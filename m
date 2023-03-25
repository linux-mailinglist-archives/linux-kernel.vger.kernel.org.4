Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7A6C89E1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjCYBRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCYBRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:17:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101DC66C;
        Fri, 24 Mar 2023 18:17:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P19H3f015520;
        Sat, 25 Mar 2023 01:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bhYjiuvUfwpUCea0950cvK2HHYTarKFcAn58TsVx+2E=;
 b=TmGDT2KvUAujQf21HnAjsCtf65vznBdpzxn+q4Syf/fE12FrUmPGXccgLwBBLBQ+YB7q
 y2+r5IM0cxIPG93qqucTe/PP6dEwGNtrV7IRE4ZtA7SlrPPuJv9/lWtP1cwvYFM2u0az
 OINZPMkKYI3neNygHLvPr/yOsde85I6RMaNrNNNdkQ1VIVzwtlBT5i+H2rD7OYMK7UH8
 OlDbPgct3kpiPE2nLe4j50UhuNmMoK5UmD+hlViikRDJJpsMJveBtt1a5KA4YvIrJ3l3
 aF62+ZuWOf5QKXXlMBPDzLMiS06WgP85X2MnhkPcUr8/Kp1104/Xr13oEIIdv9Ux9Nk4 yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phgtu8sas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 01:16:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32P1G5S8018750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 01:16:05 GMT
Received: from [10.110.22.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Mar
 2023 18:16:03 -0700
Message-ID: <318549cb-dd83-55f2-fa05-57fce041ed40@quicinc.com>
Date:   Fri, 24 Mar 2023 18:15:58 -0700
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
 <64fc529a-3250-e655-e06e-952f25b1ac2b@quicinc.com>
 <3795f87d-ae1b-bc58-79b7-56c67329de02@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <3795f87d-ae1b-bc58-79b7-56c67329de02@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oUTp3vkfgygB_tfMuxg05aK4khzpnl5J
X-Proofpoint-GUID: oUTp3vkfgygB_tfMuxg05aK4khzpnl5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=788 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250007
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 3/9/2023 11:21 PM, Srinivas Kandagatla wrote:
> 
> 
> On 09/03/2023 19:38, Wesley Cheng wrote:
>> Hi Srinivas,
>>
>> On 3/9/2023 1:01 AM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 08/03/2023 23:57, Wesley Cheng wrote:
>>>> Create a USB BE component that will register a new USB port to the 
>>>> ASoC USB
>>>> framework.  This will handle determination on if the requested audio
>>>> profile is supported by the USB device currently selected.
>>>>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>
>>> Thanks Wesley for the patch, I have few minor comments.
>>>
>>
>> Thanks for the review!
>>
>>>> ---
>>>>   include/sound/q6usboffload.h  |  20 ++++
>>>>   sound/soc/qcom/Kconfig        |   4 +
>>>>   sound/soc/qcom/qdsp6/Makefile |   1 +
>>>>   sound/soc/qcom/qdsp6/q6usb.c  | 208 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 233 insertions(+)
>>>>   create mode 100644 include/sound/q6usboffload.h
>>>>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
>>>>
>>>> diff --git a/include/sound/q6usboffload.h 
>>>> b/include/sound/q6usboffload.h
>>>> new file mode 100644
>>>> index 000000000000..4fb1912d9f55
>>>> --- /dev/null
>>>> +++ b/include/sound/q6usboffload.h
>>>> @@ -0,0 +1,20 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0
>>>> + *
>>>> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
>>>> + *
>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>> rights reserved.
>>>> + */
>>>> +
>>>> +/**
>>>> + * struct q6usb_offload
>>>> + * @dev - dev handle to usb be
>>>> + * @sid - streamID for iommu
>>>> + * @intr_num - usb interrupter number
>>>> + * @domain - allocated iommu domain
>>>> + **/
>>>> +struct q6usb_offload {
>>>> +    struct device *dev;
>>>> +    long long sid;
>>>> +    u32 intr_num;
>>>> +    struct iommu_domain *domain;
>>> Why do we need to store this domain, You can remove this along with 
>>> the one line that gets domain in probe function.
>>>
>>
>> We'll need a reference to the iommu domain, because the QC USB offload 
>> driver will be the one that is going to map the XHCI interrupter and 
>> transfer ring regions for the audio DSP.  This happens when a USB QMI 
> 
> this is okay, AFAIU, as long as uaudio_qdev->dev pointer is used in dma 
> alloc apis like dma_map*, dma_alloc_* you would not need to handle 
> iommu_domain directly like this in drivers.
> 

Was looking into this a bit more, but couldn't figure out the proper DMA 
API that would achieve what we're attempting to do.  So we are trying to 
map the PA of the memory allocated by the XHCI driver, for say...the 
xfer buffers being used for the ISOC ep.

If I call the DMA MAP variants, ie dma_map_single_attrs, we pass in a 
virtual address only, and the DMA map api will map to a PA that it 
derives from that.  However, we're trying to map to memory accessible by 
the audio DSP, which is the virtual address we're passing into 
iommu_map(), and the PA mapping to is the XHCI xfer buffer.  There 
wasn't a similar API that achieved this.  Please clarify if there might 
be something I'm missing.

Thanks
Wesley Cheng
