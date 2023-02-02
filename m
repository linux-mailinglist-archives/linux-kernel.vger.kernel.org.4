Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598DE687BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjBBLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBBLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:10:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106EEB5F;
        Thu,  2 Feb 2023 03:10:18 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3127rsqG026411;
        Thu, 2 Feb 2023 11:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3WhFaPOhscTrfIH3ywSSfnIMEnBXCiKTfxwcK+0XWk8=;
 b=nEr7EEgCu4X1lctEFeRF2MNc78b55psxxN08y16c7yl+dMKP1OnbIEBk2F9EB0XbrgxJ
 vPymFP9GzYN+q8MHpOKAaMLMHDRKdBepnWz3RYEGq+c8Z3Ku6wWD2J9augrmrwo6zxgB
 twVnyeEXRyGAojAV66emeyjSFnl7jCCbcFkLGk//zsBaEzKj+JIGHSbEEH4QiDoC21lS
 IWh7Qed43+4pF79H72YM9dDJMhk24Amw++aI2qizzR4Bc15X1/dzccfBejZOP0ht6Gyh
 3VUlTpUp+VSKLI3NjG5LRinV5FI6/ruEljCWDJRmO1HEgoujsMnl5vi6OuS+lOOQlgKd 1g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ng969rd4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 11:10:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312BA686005011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 11:10:06 GMT
Received: from [10.50.17.72] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 03:10:00 -0800
Message-ID: <afe30fbd-08e8-287d-3a7e-f5f5be0ce3b6@quicinc.com>
Date:   Thu, 2 Feb 2023 16:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] regulator: qcom_smd: Add support to define the bootup
 voltage
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-7-quic_devipriy@quicinc.com>
 <3813f262-8d36-2b1c-2230-cbb5a161d4c1@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <3813f262-8d36-2b1c-2230-cbb5a161d4c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 68wcw6h2oEYBrAmJ0KpMukq0J8yrlx9v
X-Proofpoint-GUID: 68wcw6h2oEYBrAmJ0KpMukq0J8yrlx9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020102
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 3:07 PM, Dmitry Baryshkov wrote:
> On 13/01/2023 17:03, devi priya wrote:
>> Kernel does not know the initial voltage set by the bootloaders.
>> During regulator registration, the voltage variable is just declared
>> and it is zero. Based on that, the regulator framework considers current
>> the voltage as zero and tries to bring up each regulator to minimum
>> the supported voltage.
>>
>> This introduces a dip in the voltage during kernel boot and gets
>> stabilized once the voltage scaling comes into picture.
>>
>> To avoid the voltage dip, adding support to define the
>> bootup voltage set by the boodloaders and based on it, regulator
>> framework understands that proper voltage is already set
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/qcom_smd-regulator.c 
>> b/drivers/regulator/qcom_smd-regulator.c
>> index 1eb17d378897..49a36b07397c 100644
>> --- a/drivers/regulator/qcom_smd-regulator.c
>> +++ b/drivers/regulator/qcom_smd-regulator.c
>> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>>       u32 id;
>>       const struct regulator_desc *desc;
>>       const char *supply;
>> +    int boot_uV; /* To store the bootup voltage set by bootloaders */
>>   };
>>   static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data 
>> rpm_mp5496_regulators[] = {
>>   };
>>   static const struct rpm_regulator_data 
>> rpm_ipq9574_mp5496_regulators[] = {
>> -    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>> +    { "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
> 
> I think this is a peculiarity of the particular board that than a 
> property of the PMIC. Please describe this in the board or SoC DTS if 
> the value can not be read using the software .
> 
The bootup voltage is actually blown into the OTP register of the PMIC 
and so, it remains the same across boards for IPQ9574 SoC
>>       {}
>>   };
>> @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct 
>> qcom_rpm_reg *vreg, struct device *dev
>>       vreg->type    = rpm_data->type;
>>       vreg->id    = rpm_data->id;
>> +    if (rpm_data->boot_uV)
>> +        vreg->uV = rpm_data->boot_uV;
>> +
>>       memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>>       vreg->desc.name = rpm_data->name;
>>       vreg->desc.supply_name = rpm_data->supply;
> 
Best Regards,
Devi Priya
