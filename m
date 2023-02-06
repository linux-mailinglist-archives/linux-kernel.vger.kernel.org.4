Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7920868BEB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBFNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjBFNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:49:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC762D52B;
        Mon,  6 Feb 2023 05:49:02 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316BNBnm029786;
        Mon, 6 Feb 2023 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nrt5KNpJAtsfMMxpc3BHojYVpg+wThGUJFzebOpAX14=;
 b=FXaPLwWNnsu9z6JbCgu6f6G3H5xwMhrd02mmj0hLFcxW+J7cZ7i2Bo+B5JVJac9VSA3m
 49P1Lwhn/rW32Fy02QhVc8LplV2nHejQGma41ACH70m9UE8+OETJMHdflW3szIMyUpTo
 fC3m7W0LwEZLNRAMJuQSvwqqgrVBzswiSi/0AsT0yO+FbKQDDA1/054vw2BSewIVy47S
 tt7qlvc9eQzzLIlvxRuBA6esojmZG9r3OnnuLFlTHtAxTF/2aeg2mK1vHku6KqA0jScT
 tfZObqLKZ9EKfu6O1rIEFOtKmOmJZEr7eXWhQ16hGvB1ksYvoPW4RhM10nLlEqX/hdBr kw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhgng3mqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:48:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316Dmb7i027899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 13:48:37 GMT
Received: from [10.50.61.251] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 05:48:32 -0800
Message-ID: <9c3801a3-9180-d955-d5b4-9a6ec39866eb@quicinc.com>
Date:   Mon, 6 Feb 2023 19:18:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] regulator: qcom_smd: Add support to define the bootup
 voltage
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-7-quic_devipriy@quicinc.com>
 <77d84408-166e-8a02-227a-67654a4d31f2@linaro.org>
 <df6c1cd6-ea70-e65c-b4e8-3da80697242f@quicinc.com>
 <cc037133-7c45-325f-4a1d-9855d033ae5c@linaro.org>
 <6bb22160-5966-43d3-ffba-489b77b3a095@quicinc.com>
 <de6e69d6-18cd-2732-9a18-f4dfd29be6dd@linaro.org>
 <05c01db8-1ca1-475f-8cb4-41fddff8b85a@quicinc.com>
 <bab449de-73c9-f65e-24fa-84749fbc51bb@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <bab449de-73c9-f65e-24fa-84749fbc51bb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9dW6M3FO0NUVDJzJmCa9LUDqHFV0_9vJ
X-Proofpoint-ORIG-GUID: 9dW6M3FO0NUVDJzJmCa9LUDqHFV0_9vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060118
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 5:13 PM, Konrad Dybcio wrote:
> 
> 
> On 2.02.2023 12:09, Devi Priya wrote:
>>
>>
>> On 1/31/2023 6:14 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 31.01.2023 10:28, Devi Priya wrote:
>>>>
>>>>
>>>> On 1/27/2023 9:40 PM, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 27.01.2023 17:07, Devi Priya wrote:
>>>>>>
>>>>>>
>>>>>> On 1/13/2023 9:07 PM, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 13.01.2023 16:03, devi priya wrote:
>>>>>>>> Kernel does not know the initial voltage set by the bootloaders.
>>>>>>>> During regulator registration, the voltage variable is just declared
>>>>>>>> and it is zero. Based on that, the regulator framework considers current
>>>>>>>> the voltage as zero and tries to bring up each regulator to minimum
>>>>>>>> the supported voltage.
>>>>>>>>
>>>>>>>> This introduces a dip in the voltage during kernel boot and gets
>>>>>>>> stabilized once the voltage scaling comes into picture.
>>>>>>>>
>>>>>>>> To avoid the voltage dip, adding support to define the
>>>>>>>> bootup voltage set by the boodloaders and based on it, regulator
>>>>>>>> framework understands that proper voltage is already set
>>>>>>>>
>>>>>>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>>>>>> ---
>>>>>>> Or maybe hook it up to the spmi_regulator_common_get_voltage()
>>>>>>> from the SPMI regulator driver and read the real voltage instead
>>>>>>> of relying on hardcoded values thay may differ between boards?
>>>>>>>
>>>>>>> Konrad
>>>>>> In IPQ9574, SPMI regulator is not used. We are using RPM-Glink communication and the regulators are controlled by RPM.
>>>>>> In this case, we don't have an option to readback the bootup voltage and so, we have hardcoded the values
>>>>> Unless something changed, RPM regulator framework is simply a
>>>>> fancy front-end for communicating with the PMIC over SPMI, AFAIK..
>>>>>
>>>>> Konrad
>>>> Currently in our driver, the voltage write request will be sent to RPM via GLINK which then writes it to the PMIC over I2C using the below APIs
>>>> qcom_rpm_smd_write -> rpmsg_send
>>>> In IPQ9574, we do not have SPMI support or the support to readback voltage.
>>> Okay, I didn't quite catch that there's *only* an i2c PMIC on this
>>> platform.. Looking at the MP5496 datasheet though, reading back
>>> the voltage should be possible via simply reading the fields that
>>> are used to set it.
>>>
>>> Konrad
>> The CPR regulator operates in closed loop mode and the RPM can independently update the PMIC voltage.
>> So, Performing an i2c read to the PMIC would introduce conflicts when RPM uses the i2c for any of the voltage write or read operations.
> So.. are we even going to set voltage from Linux at all, for example
> for DCVS? If not, maybe we can simply not register the regulator and
> let the non-APSS parts handle it themselves?
> 
In IPQ9574, PMIC basically controls three rails. In that, RPM has 
control over two rails (MX and CX) & APSS has control over the APC rail. 
RPM controls the MX and CX rails independently. For APC rail, APSS sends 
the voltage request to RPM via GLINK and RPM takes care of accessing the 
PMIC via I2C for APSS voltage requests & its own requests. This approach 
helps us to avoid arbitration. In this case, if we directly use the I2C 
to read the PMIC we would end up having issues, if RPM is accessing the 
PMIC.
> Konrad
>>>>
>>>>>>
>>>>>>>>      drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>>>>>>>>      1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>>>>>>>> index 1eb17d378897..49a36b07397c 100644
>>>>>>>> --- a/drivers/regulator/qcom_smd-regulator.c
>>>>>>>> +++ b/drivers/regulator/qcom_smd-regulator.c
>>>>>>>> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>>>>>>>>          u32 id;
>>>>>>>>          const struct regulator_desc *desc;
>>>>>>>>          const char *supply;
>>>>>>>> +    int boot_uV; /* To store the bootup voltage set by bootloaders */
>>>>>>>>      };
>>>>>>>>        static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>>>>>> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>>>>>>>      };
>>>>>>>>        static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>>>>>>>> -    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>>>>>>>> +    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
>>>>>>>>          {}
>>>>>>>>      };
>>>>>>>>      @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>>>>>>>>          vreg->type    = rpm_data->type;
>>>>>>>>          vreg->id    = rpm_data->id;
>>>>>>>>      +    if (rpm_data->boot_uV)
>>>>>>>> +        vreg->uV = rpm_data->boot_uV;
>>>>>>>> +
>>>>>>>>          memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>>>>>>>>          vreg->desc.name = rpm_data->name;
>>>>>>>>          vreg->desc.supply_name = rpm_data->supply;
>>>>>> Best Regards,
>>>>>> Devi Priya
>>>> Best Regards,
>>>> Devi Priya
