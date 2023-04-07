Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD446DAF0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDGO7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjDGO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:59:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508DAD3C;
        Fri,  7 Apr 2023 07:59:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337BhJTT017122;
        Fri, 7 Apr 2023 14:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=42AWNZrJGFZAap6ISs7RG705e5t13E4Fct0XAHfa+6U=;
 b=lW6LbmgotNgxfuB1HheSo8ABKKr997SqSusYhyt0hE10ZYVSzNnbjpioqzkaH3Ab3MS5
 fyL+klerdsMFCiDmCGXMmTkIwtGE/D584b8Et9KQhPe2jsQeQH6NXvlX7uNSVQHOzFWf
 8aQap9MERod8AG6v+5hR1tJdAmxGC2oIRLAYE46KMV8GFlnCEw7Ua2OGL1MoLG7Vlodv
 aQxoU5yl1jrAlUlZGlDJ4Oc2MeeHsmW+n/T5iq5rZuiNailwXhaFTRnTA6sHIgh62mRi
 Y0LYYo1gCXLXr7Dbbmv2LW374tvM2aI4wP5omFvszthIx+f0Aly4a35YPPRzzCrkpavx xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pth8brfey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:59:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337ExTgr020506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:59:29 GMT
Received: from [10.216.18.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 07:59:23 -0700
Message-ID: <4e888460-65b1-dc60-071a-4b9c88e38818@quicinc.com>
Date:   Fri, 7 Apr 2023 20:29:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 2/5] regulator: qcom_smd: Add MP5496 S1 regulator
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-3-quic_devipriy@quicinc.com>
 <714f4c97-d157-1402-1217-19e43daf645f@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <714f4c97-d157-1402-1217-19e43daf645f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CZEq8c0yj8-3IWh0SQKUVhKIQfeHDKSF
X-Proofpoint-ORIG-GUID: CZEq8c0yj8-3IWh0SQKUVhKIQfeHDKSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=913
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070136
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2023 1:07 AM, Konrad Dybcio wrote:
> 
> 
> On 6.04.2023 09:00, Devi Priya wrote:
>> Adding support for MP5496 S1 regulator on IPQ9574 SoC.
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>> 	- No change
>>
>>   drivers/regulator/qcom_smd-regulator.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>> index 6f722b2d682e..cb77b3bd1723 100644
>> --- a/drivers/regulator/qcom_smd-regulator.c
>> +++ b/drivers/regulator/qcom_smd-regulator.c
>> @@ -749,6 +749,15 @@ static const struct regulator_desc pms405_pldo600 = {
>>   	.ops = &rpm_smps_ldo_ops,
>>   };
>>   
>> +static const struct regulator_desc mp5496_smpa1 = {
>> +	.linear_ranges = (struct linear_range[]) {
>> +		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
>> +	},
>> +	.n_linear_ranges = 1,
>> +	.n_voltages = 128,
>> +	.ops = &rpm_mp5496_ops,
>> +};
>> +
> As far as I can tell, this is identical to struct mp5496_smpa2, so
> this patch could come down to:
> 
> - static const struct regulator_desc mp5496_smpa1 = {
> + static const struct regulator_desc mp5496_smps = {
> 
> 
> 
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smps, "s1" },
> -  	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
> +	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smps, "s2" },
> 
Yes, right. Will update it
> Konrad
>>   static const struct regulator_desc mp5496_smpa2 = {
>>   	.linear_ranges = (struct linear_range[]) {
>>   		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
>> @@ -794,6 +803,7 @@ struct rpm_regulator_data {
>>   };
>>   
>>   static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1" },
>>   	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
>>   	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
>>   	{}
Best Regards,
Devi Priya
