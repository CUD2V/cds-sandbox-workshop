library "Statin-Use-Example" version '0.0.1'
using FHIR version '4.0.0'
include "FHIRHelpers" version '4.0.0' called FHIRHelpers
include "CDS_Connect_Conversions" version '1.0.1'
include "CDS_Connect_Commons_for_FHIRv400" version '1.0.1' called C3F
include "Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv400" version '1.0.0'
codesystem "Condition Verification Status": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'
codesystem "Condition Clinical Status": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "LOINC": 'http://loinc.org'
valueset "LDL-c VS": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.215'
valueset "Diabetes VS": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "Statins VS": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.3616.200.110.102.2050'
valueset "Hypertension VS": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.9'
code "Confirmed code": 'confirmed' from "Condition Verification Status" display 'Confirmed'
code "Active code": 'active' from "Condition Clinical Status" display 'Active'
context Patient

define "Has Hypertension":
  exists(
    C3F.ActiveOrRecurring(
      C3F.Confirmed([Condition: "Hypertension VS"]
      )
    )
  )

define "Age 40 to 75":
  AgeInYears() >= 40 and AgeInYears() <= 75

define "LDL > 130 mg/dL":
  QuantityValue(MostRecent(Verified(ObservationLookBack([Observation: "LDL-c VS"], 6 years)))) > 130 'mg/dL'

define "Has Diabetes":
  exists([Condition: "Diabetes VS"] Co where (Co.verificationStatus ~ "Confirmed code" and Co.clinicalStatus ~ "Active code"))

define "10-year ASCVD Risk >= 10%":
  "Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv400"."PatientBaselineRisk" >= 0.1

define "On Statin Therapy":
  exists([MedicationRequest: "Statins VS"] MR where (MR.status in {'active', 'completed'} and MR.authoredOn in Interval[Now() - 2 years, Now()]))

define "MeetsInclusionCriteria":
  "Age 40 to 75"
  and "One or More Risk Factors"
  and "10-year ASCVD Risk >= 10%"

define "One or More Risk Factors":
  "LDL > 130 mg/dL"
  or "Has Diabetes"
  or "Has Hypertension"

define "MeetsExclusionCriteria":
  "On Statin Therapy"

define "InPopulation":
  "MeetsInclusionCriteria" and not "MeetsExclusionCriteria"

define "Recommendation":
  if "InPopulation" then 'Start low to moderate intensity lipid lowering therapy based on outcome of shared decision making between patient and provider'
  else null

define "Rationale":
  if "InPopulation" then 'The USPSTF found adequate evidence that use of low- to moderate-dose statins reduces the probability of CVD events (MI or ischemic stroke) and mortality by at least a moderate amount in adults aged 40 to 75 years who have 1 or more CVD risk factors (dyslipidemia, diabetes, hypertension, or smoking) and a calculated 10-year CVD event risk of 10% or greater.'
  else null

define "Links":
  if "InPopulation" then null
  else null

define "Errors":
  null

define function Verified(ObsList List<Observation>):
  ObsList O where O.status.value in {'final', 'corrected', 'amended'}

define function ObservationLookBack(ObsList List<Observation>, LookBack System.Quantity):
  ObsList O
    let LookBackInterval: Interval[Now() - LookBack, Now()]
    where (O.effective as FHIR.dateTime).value in LookBackInterval
      or (O.effective as FHIR.instant).value in LookBackInterval
      or PeriodToInterval(O.effective as FHIR.Period) overlaps LookBackInterval
      or O.issued.value in LookBackInterval

define function MostRecent(ObsList List<Observation>):
  Last(ObsList O sort by Coalesce(
    (effective as FHIR.dateTime).value,
    (effective as FHIR.instant).value,
    (effective as FHIR.Period)."end".value,
    (effective as FHIR.Period)."start".value,
    issued.value)
  )

define function QuantityValue(Obs Observation):
  FHIRHelpers.ToQuantity(Obs.value as FHIR.Quantity)

define function PeriodToInterval(period FHIR.Period):
  if period is null then
    null
  else
    Interval[period."start".value, period."end".value]
