Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2A67EA48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjA0QCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjA0QCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708EF87152;
        Fri, 27 Jan 2023 08:02:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFIqXe002245;
        Fri, 27 Jan 2023 16:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=evSNeZpBQoz7jrhq7Q5gRuxG9xnYwF0GsgutK5iPCaM=;
 b=NlTKMeOkv8Wx5GM5ujbUwvqOqbf6YZqUBGvE11Zq3kNwlpCiiPMAAxzOBvh5MQNore31
 bBswpEJ2C8KwwrpxQ6quoYCzJAAFre9J/fgjlNtcDNrYOBLYpZ3roI8Sec/2eJvx/Y6k
 kOm+yek4ryZJhacdF9QftaBBsu6WppyExvbWOBDfEdm1BU0rWrVS4sVFU8UcDg/lBb9r
 6/WGXijZyhbJyW8Sm2RQhoML+Ykgo1y0E1wkraj/V3QYhFb2076ihuC00b2eD7ry7nvo
 qZu+RYIhZpIsqunRQr4Y2dv+aKqLHSSKH6IAnsezbibxe8NgeBMoYNTJsMIXKyh529ft Eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbyma1qmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RG1l0g016242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:47 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 08:01:39 -0800
Message-ID: <2cc385d9-4f51-945d-cc59-2738011bd295@quicinc.com>
Date:   Fri, 27 Jan 2023 21:31:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/6] regulator: qcom_smd: Add MP5496 regulators
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
 <20230113150310.29709-4-quic_devipriy@quicinc.com>
 <552e75a9-179a-7720-3d37-59f1846266b1@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <552e75a9-179a-7720-3d37-59f1846266b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VY-np1TOUQIodBzB8kMA3fWiPGU4e9sC
X-Proofpoint-GUID: VY-np1TOUQIodBzB8kMA3fWiPGU4e9sC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301270148
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 8:54 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 16:03, devi priya wrote:
>> Adding support for PMIC MP5496 on IPQ9574 SoC
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
> Please simply extend the existing MP5496 support with this
> S1 regulator. If you don't explicitly define and set voltages
> for the other vregs, they will not be probed.
> 
> Konrad
IPQ6018 and IPQ9574 platforms use the same PMIC MP5496 but they have a 
different power layout. IPQ9574 has S2 regulator which will be used for 
NSS scaling but S2 in IPQ6018 serves a different purpose. Hence it would 
not be possible to extend the existing MP5496 support for IPQ9574
>>   drivers/regulator/qcom_smd-regulator.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>> index 9f2b58458841..1eb17d378897 100644
>> --- a/drivers/regulator/qcom_smd-regulator.c
>> +++ b/drivers/regulator/qcom_smd-regulator.c
>> @@ -767,6 +767,15 @@ static const struct regulator_desc mp5496_ldoa2 = {
>>   	.ops = &rpm_mp5496_ops,
>>   };
>>   
>> +static const struct regulator_desc ipq9574_mp5496_smpa1 = {
>> +	.linear_ranges = (struct linear_range[]) {
>> +		REGULATOR_LINEAR_RANGE(600000, 0, 37, 12500),
>> +	},
>> +	.n_linear_ranges = 1,
>> +	.n_voltages = 38,
>> +	.ops = &rpm_mp5496_ops,
>> +};
>> +
>>   static const struct regulator_desc pm2250_lvftsmps = {
>>   	.linear_ranges = (struct linear_range[]) {
>>   		REGULATOR_LINEAR_RANGE(320000, 0, 269, 4000),
>> @@ -799,6 +808,11 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>   	{}
>>   };
>>   
>> +static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>> +	{}
>> +};
>> +
>>   static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
>>   	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
>>   	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
>> @@ -1320,6 +1334,8 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
>>   };
>>   
>>   static const struct of_device_id rpm_of_match[] = {
>> +	{ .compatible = "qcom,rpm-ipq9574-mp5496-regulators",
>> +		.data = &rpm_ipq9574_mp5496_regulators },
>>   	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
>>   	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
>>   	{ .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
Best Regards,
Devi Priya
