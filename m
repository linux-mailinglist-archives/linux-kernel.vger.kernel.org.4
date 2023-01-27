Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830CF67EA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjA0QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjA0QID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:08:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198C402E1;
        Fri, 27 Jan 2023 08:07:55 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RElCvm006204;
        Fri, 27 Jan 2023 16:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AAZlzl6JlRBW0e+fgaddlEBozVUWOh5t4FNV9kZruAw=;
 b=hY7Tnel6oaCQ2qBNQwYlqCHoF6ii86qzY+FMBmtAwQh1PRzQ3lgJ9+ondQ9sWpOLAlZD
 FXKvI14EpFX4txNedkOv/HM0OVxDUVHeTj1XHx6DBqCrZM/c1/D8m+nm2nlCYGn/tNCC
 EdOxib9oqCdj+I182FQI+YzppYVP8iAoSkec9+RZWSd9OCM5hVcnsXXgAKWLORQyY8WQ
 iIxyRiH9K1mjFnpjHhU3XNpZYG98zvS+oX6LxkD4FW93mdjq/pfM0af7sHlLShxqgX3v
 5sHBZsRZy1UrCfWj5zexVZ/7aKtgfVxP7L8qNVsTh5Mo5ohzst4qs9dNBvJCiWTIZVDu mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb0qrw58v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:07:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RG7o9U023561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:07:50 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 08:07:45 -0800
Message-ID: <df6c1cd6-ea70-e65c-b4e8-3da80697242f@quicinc.com>
Date:   Fri, 27 Jan 2023 21:37:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <77d84408-166e-8a02-227a-67654a4d31f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pu4c0VkZZ1Bof0k-yODjrLRY45XvxKZ0
X-Proofpoint-ORIG-GUID: Pu4c0VkZZ1Bof0k-yODjrLRY45XvxKZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=935 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270148
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 9:07 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 16:03, devi priya wrote:
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
> Or maybe hook it up to the spmi_regulator_common_get_voltage()
> from the SPMI regulator driver and read the real voltage instead
> of relying on hardcoded values thay may differ between boards?
> 
> Konrad
In IPQ9574, SPMI regulator is not used. We are using RPM-Glink 
communication and the regulators are controlled by RPM.
In this case, we don't have an option to readback the bootup voltage and 
so, we have hardcoded the values

>>   drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>> index 1eb17d378897..49a36b07397c 100644
>> --- a/drivers/regulator/qcom_smd-regulator.c
>> +++ b/drivers/regulator/qcom_smd-regulator.c
>> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>>   	u32 id;
>>   	const struct regulator_desc *desc;
>>   	const char *supply;
>> +	int boot_uV; /* To store the bootup voltage set by bootloaders */
>>   };
>>   
>>   static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>>   };
>>   
>>   static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
>> -	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
>> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
>>   	{}
>>   };
>>   
>> @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>>   	vreg->type	= rpm_data->type;
>>   	vreg->id	= rpm_data->id;
>>   
>> +	if (rpm_data->boot_uV)
>> +		vreg->uV = rpm_data->boot_uV;
>> +
>>   	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>>   	vreg->desc.name = rpm_data->name;
>>   	vreg->desc.supply_name = rpm_data->supply;
Best Regards,
Devi Priya
