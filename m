Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505445BCE53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiISOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiISOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:15:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F332AB7;
        Mon, 19 Sep 2022 07:15:54 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDJuhI000922;
        Mon, 19 Sep 2022 14:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mh4LIgXD3tBMsOyRRz6BbYcbwpt0cZ4i7TH7i2evpOI=;
 b=AKC8HUDnIH7Rz4+cKdgus3lMnDjeF8EyDNmhLVlMs7iIW4jHwCg5sP8te78xrw3dR2cX
 EpFfJepzRY8ao4Z4Q7Tqtaqjyn3gEptYYFM2UqvPwCi9/nsWe5aOH/dB9KbJ3Yqk1ii1
 TK0T9Z9ArcsZz0AMR4z0kItzILOcR4tohxezJF9O65q1vqAnfSDZW8liYlUYWGxhJ3CL
 qoFPfWEJ+IFs0os6UOWocAywCInEpTVA30DeyyTzE2KRu68GwdeHI6NtCKHsLUNGrMzn
 oJPRH/Yhlhp75EQT21muGXsEbUQzkb9FGTqfZiu78ActixF79xe9pswygPLWBgTLCRcs /g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jprv7r6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:15:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JEFheg006692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:15:43 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:15:38 -0700
Message-ID: <a298b048-1435-fc75-7855-bf93016eb280@quicinc.com>
Date:   Mon, 19 Sep 2022 19:45:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/8] remoteproc: qcom: Update rproc parse firmware
 callback
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-5-git-send-email-quic_srivasam@quicinc.com>
 <babd014c-bf8a-bbff-7bc7-fabeeb250d0d@quicinc.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <babd014c-bf8a-bbff-7bc7-fabeeb250d0d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wDpUoNSyaDVafj6sl2xL3bfqja1W7aps
X-Proofpoint-ORIG-GUID: wDpUoNSyaDVafj6sl2xL3bfqja1W7aps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190095
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 3:05 PM, Sibi Sankar wrote:
Thanks for Your time and valuable inputs Sibi Sankar!!!
>
> On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
>> Change parse_fw callback in rproc ops from qcom_register_dump_segments
>> to rproc_elf_load_rsc_table, as section header to be parsed for memory
>> sandboxing required platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 02d17b4..207270d4 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -447,7 +447,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
>>       return qcom_q6v5_panic(&adsp->q6v5);
>>   }
>>   -static const struct rproc_ops adsp_ops = {
>> +static struct rproc_ops adsp_ops = {
>>       .start = adsp_start,
>>       .stop = adsp_stop,
>>       .da_to_va = adsp_da_to_va,
>> @@ -590,6 +590,9 @@ static int adsp_probe(struct platform_device *pdev)
>>           return ret;
>>       }
>>   +    if (desc->has_iommu)
>> +        adsp_ops.parse_fw = rproc_elf_load_rsc_table;
>> +
>
> The parse_fw would still need to perform the register_dump_segments
> in addition to elf_load_rsc_table, otherwise you'll lose coredump
> functionality for ADSP on SC7280. You could perhaps just follow
> qcom_q6v5_mss parse_fw i.e. have a static func internal to adsp
> doing both and have it assigned to both wpss/adsp with the
> pre-existing has_iommu flag to differentiate between the two. With
> this you wouldn't need to remove the const in adsp_ops as well.
Okay. Will update accordingly and re spin the patches.
>
>>       rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
>>                   firmware_name, sizeof(*adsp));
>>       if (!rproc) {
>>
