Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC76B2DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCITiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCITiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:38:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D3E41C5;
        Thu,  9 Mar 2023 11:38:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IXaK7024558;
        Thu, 9 Mar 2023 19:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xZAR6XDVFBaevTms7M/7sO5L2ikvAoL5CGDXYC2WcS4=;
 b=h424Jg6Vd1QQDwTbCWXPZSonHJQ9KtCq60HUUheoTSJkqpt2n4U65gVi+n2VAsIPR5tX
 Ug3gfX2i+qCZN18uQaDUgkb4zYciAXI2t57id7XK2C2kPkn7XEKvHf6SJi9C6TCS1iRp
 sgL0dVkEbYsmA0pA8tMwDKUkEvqhc/Q+PHdd8G8WwSBOjwsOxv2SKW776UaLN+jtwIkY
 /R9KJm6AQoIrbm7pK080Vm5cuZo6mLTyxRDnUwyDMM/HrYxRYcULekXgOXLMwZhNZTRw
 QjxiZxH+JJmLI3un9SgpIxG1uvZzKjJ0FgOgS2y1g1D6TfQOlCNbub9vs/1JoHFBYCz8 VQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7egyhddm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 19:38:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329JcPOc022664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 19:38:25 GMT
Received: from [10.110.90.116] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 11:38:24 -0800
Message-ID: <64fc529a-3250-e655-e06e-952f25b1ac2b@quicinc.com>
Date:   Thu, 9 Mar 2023 11:38:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 08/28] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <mathias.nyman@intel.com>, <perex@perex.cz>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-9-quic_wcheng@quicinc.com>
 <ad7dd26d-0ee6-675f-72a5-a93bb0240121@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ad7dd26d-0ee6-675f-72a5-a93bb0240121@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HQ89nE5xkL_DFxNKHIhV1GYEh3P3ZEpI
X-Proofpoint-ORIG-GUID: HQ89nE5xkL_DFxNKHIhV1GYEh3P3ZEpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_10,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=589
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 3/9/2023 1:01 AM, Srinivas Kandagatla wrote:
> 
> 
> On 08/03/2023 23:57, Wesley Cheng wrote:
>> Create a USB BE component that will register a new USB port to the 
>> ASoC USB
>> framework.  This will handle determination on if the requested audio
>> profile is supported by the USB device currently selected.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Thanks Wesley for the patch, I have few minor comments.
> 

Thanks for the review!

>> ---
>>   include/sound/q6usboffload.h  |  20 ++++
>>   sound/soc/qcom/Kconfig        |   4 +
>>   sound/soc/qcom/qdsp6/Makefile |   1 +
>>   sound/soc/qcom/qdsp6/q6usb.c  | 208 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 233 insertions(+)
>>   create mode 100644 include/sound/q6usboffload.h
>>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
>>
>> diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
>> new file mode 100644
>> index 000000000000..4fb1912d9f55
>> --- /dev/null
>> +++ b/include/sound/q6usboffload.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
>> + *
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +/**
>> + * struct q6usb_offload
>> + * @dev - dev handle to usb be
>> + * @sid - streamID for iommu
>> + * @intr_num - usb interrupter number
>> + * @domain - allocated iommu domain
>> + **/
>> +struct q6usb_offload {
>> +    struct device *dev;
>> +    long long sid;
>> +    u32 intr_num;
>> +    struct iommu_domain *domain;
> Why do we need to store this domain, You can remove this along with the 
> one line that gets domain in probe function.
> 

We'll need a reference to the iommu domain, because the QC USB offload 
driver will be the one that is going to map the XHCI interrupter and 
transfer ring regions for the audio DSP.  This happens when a USB QMI 
enable stream request is received in the USB offload driver.  Please 
refer to:

static int prepare_qmi_response(struct snd_usb_substream *subs,
		struct qmi_uaudio_stream_req_msg_v01 *req_msg,
		struct qmi_uaudio_stream_resp_msg_v01 *resp, int info_idx)
{
...
	xhci_pa = xhci_get_ir_resource(subs->dev, ir);
	if (!xhci_pa) {
		dev_err(uaudio_qdev->dev,
			"failed to get sec event ring address\n");
		ret = -ENODEV;
		goto free_sec_ring;
	}
...
	va = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, xhci_pa, PAGE_SIZE,
			NULL);
	if (!va) {
		ret = -ENOMEM;
		goto free_sec_ring;
	}

This is just an example for mapping the XHCI secondary interrupter.  We 
will also do the same for the transfer ring.

Thanks
Wesley Cheng
