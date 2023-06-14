Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEA72F4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbjFNGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjFNGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:31:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80361FF5;
        Tue, 13 Jun 2023 23:31:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E3JV7b012659;
        Wed, 14 Jun 2023 06:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JTFgRNonA1gZ9eWnyVGkswayYwhAY4igilQc1WnzJ9U=;
 b=Q8AmxSco9C63mEyC6y7SWxmkkPSQjl3iduD2/9hUFyO3VXIYhphD7OurrzIe8pg0esJR
 W4gYy5vBQ3OmDxNVi3abfZ32fgtk3MGl6QBNdBOT3GFUsAV/f9hYndLLWq16cBpAptRP
 NiAly5TMB6pO5q8IQo0jirSWnOZqSrFXwcUIg0lAdz+7W4ED/Map/ufboTFOEz8E+iea
 lv0xJMNNy75+paNib1dGItsakdUzo3bj0A+Nks+05O7RiLmtwsby1kl207i9ozajKr2M
 3Q9eF/3k1C7TBjQWmeEVs3pFzcpfGPCgutQ1mW6aUU43Qc2NP7mzsHG+f2rBe4FfsTu3 YQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6f7a33ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:31:05 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E6V4T9001304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:31:04 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 23:31:01 -0700
Message-ID: <aa12e201-f930-00ec-5a20-406a8ca52505@quicinc.com>
Date:   Wed, 14 Jun 2023 12:00:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 06/10] soc: qcom: Add LLCC support for multi channel
 DDR
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-7-quic_kbajaj@quicinc.com>
 <20230613171110.ud2ybjpoxnwwflce@ripper>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230613171110.ud2ybjpoxnwwflce@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BTiZlKanvDCJZqsE3mc-dh2cBx9wSOg6
X-Proofpoint-ORIG-GUID: BTiZlKanvDCJZqsE3mc-dh2cBx9wSOg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2023 10:41 PM, Bjorn Andersson wrote:
> On Fri, May 12, 2023 at 05:51:30PM +0530, Komal Bajaj wrote:
>> Add LLCC support for multi channel DDR configuration
>> based on a feature register.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 6cf373da5df9..1da337e7a378 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/regmap.h>
>> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>>   	return ret;
>>   }
>>
>> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
>> +{
>> +	int ret = 0;
> First use is an assignment, no need to initialize here.

Noted.

>
>> +
>> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi_chan_ddr", cfg_index);
>> +	if (ret == -ENOENT) {
>> +		*cfg_index = 0;
> Does nvmem_cell_read_u8() cahnge cfg_index when it fails with -ENOENT?

No, if nvmem_cell_read_u8() fails with any error, cfg_index will not be 
changed.

Thanks
Komal
>> +		return 0;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>   {
>>   	/* Set the global pointer to a error code to avoid referencing it */
>> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>   	struct device *dev = &pdev->dev;
>>   	int ret, i;
>>   	struct platform_device *llcc_edac;
>> -	const struct qcom_llcc_config *cfg;
>> +	const struct qcom_llcc_config *cfg, *entry;
>>   	const struct llcc_slice_config *llcc_cfg;
>>   	u32 sz;
>> +	u8 cfg_index;
>>   	u32 version;
>>   	struct regmap *regmap;
>> +	u32 num_entries = 0;
>>
>>   	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>   	if (!drv_data) {
>> @@ -1040,8 +1056,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>
>>   	drv_data->version = version;
>>
>> -	llcc_cfg = cfg[0]->sct_data;
>> -	sz = cfg[0]->size;
>> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>> +	if (ret)
>> +		goto err;
>> +
>> +	for (entry = cfg; entry->sct_data; entry++, num_entries++);
> This is not readable, move the increment of num_entries out of there.
>
>> +	if (cfg_index >= num_entries || cfg_index < 0) {
> How can cfg_index be negative?
>
> Regards,
> Bjorn
>
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	llcc_cfg = cfg[cfg_index].sct_data;
>> +	sz = cfg[cfg_index].size;
>>
>>   	for (i = 0; i < sz; i++)
>>   		if (llcc_cfg[i].slice_id > drv_data->max_slices)
>> --
>> 2.17.1
>>

