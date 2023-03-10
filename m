Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267D6B373E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJHVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCJHV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:21:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB336FD280
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:21:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c18so2739374wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678432883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1POc04jfkfBTQgAJUSsVDqeK4gvy0mo0kDtY0v/iXs=;
        b=T96ciuns1KQu/i4XNFef7v7GJvP+4ZOLuUwXzmcmX0KBSmBN/48Xe7PkxiifoYGP7b
         Nt02kp3/0wwwa2mcZtUov/HZtDx4MForsw4ZxmT68rEXaPGp7ZpNEvP4xesBGO0r0cgr
         BpTzP2RpOgEvjw8+9H6DJ8CesjclbX9PRy2h6hE+lqI9tzTolMEbyqNpebeqlPTJcMDy
         Tyau6aVD16MF0bhnbGDDc9Ep93XG1exFkG4QGVwQdhTX94wwfIgkuGQDgGlYpqmXsOdc
         b1G9HSzsfjxIW1MqljKwaQvLPkrlscFyNSOA/OcwN1FR7B3y59W/zaZ8mwSOsW0Q2jZL
         9K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678432883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1POc04jfkfBTQgAJUSsVDqeK4gvy0mo0kDtY0v/iXs=;
        b=p/0OqjMqV7xBkfAa8Xv48STdtTuOXVp8oBMjQcQ1IPUJnO9E4TaGAD3CZfqGXg3eYT
         iFH/SFu4X/OTyC0lHn/Ki+mX6ZX7yQzXHBxfo9mOmiWfJhq873dnwBnzbN/zgGcN5M03
         tCaO09uCFnfhifF89mAv5Y86iOCG7rmjpwxMysGKz2KdIF2CzL14UdmlCPxnlDFeDlY0
         VJJdjN45ITM1wq3GwdUvMjnJ2vl0lxxmj8tGK14LS2UERnq/yL7aKsl6xB6xsl98Pn3Z
         f6RtoozrpwGOkIv3QmSzWopzRzqgbYj1Gzl2hg6bAEYzHY95Yp9N9xcjEJeUj4o9Vban
         rtjw==
X-Gm-Message-State: AO0yUKXD6ZcqiNVc8unX4PoGeWUuuF8JVQpUx/sYYEZ/ha0YGlOdJQoA
        s9X/qSmrM7Pky269lKxUU7P4kg==
X-Google-Smtp-Source: AK7set+Ox/4RE8/rAwJ252AX6d2ueTWn8ZTqfXuo6QHL832bzNmFSHqpYa/y56B04XnoYl6AHLk9ug==
X-Received: by 2002:a05:600c:198f:b0:3ea:f6c4:5f26 with SMTP id t15-20020a05600c198f00b003eaf6c45f26mr1691912wmq.17.1678432883201;
        Thu, 09 Mar 2023 23:21:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c2caf00b003e8f0334db8sm2401999wmc.5.2023.03.09.23.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 23:21:22 -0800 (PST)
Message-ID: <3795f87d-ae1b-bc58-79b7-56c67329de02@linaro.org>
Date:   Fri, 10 Mar 2023 07:21:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 08/28] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-9-quic_wcheng@quicinc.com>
 <ad7dd26d-0ee6-675f-72a5-a93bb0240121@linaro.org>
 <64fc529a-3250-e655-e06e-952f25b1ac2b@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <64fc529a-3250-e655-e06e-952f25b1ac2b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 19:38, Wesley Cheng wrote:
> Hi Srinivas,
> 
> On 3/9/2023 1:01 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 08/03/2023 23:57, Wesley Cheng wrote:
>>> Create a USB BE component that will register a new USB port to the 
>>> ASoC USB
>>> framework.  This will handle determination on if the requested audio
>>> profile is supported by the USB device currently selected.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>
>> Thanks Wesley for the patch, I have few minor comments.
>>
> 
> Thanks for the review!
> 
>>> ---
>>>   include/sound/q6usboffload.h  |  20 ++++
>>>   sound/soc/qcom/Kconfig        |   4 +
>>>   sound/soc/qcom/qdsp6/Makefile |   1 +
>>>   sound/soc/qcom/qdsp6/q6usb.c  | 208 ++++++++++++++++++++++++++++++++++
>>>   4 files changed, 233 insertions(+)
>>>   create mode 100644 include/sound/q6usboffload.h
>>>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
>>>
>>> diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
>>> new file mode 100644
>>> index 000000000000..4fb1912d9f55
>>> --- /dev/null
>>> +++ b/include/sound/q6usboffload.h
>>> @@ -0,0 +1,20 @@
>>> +/* SPDX-License-Identifier: GPL-2.0
>>> + *
>>> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
>>> + *
>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + */
>>> +
>>> +/**
>>> + * struct q6usb_offload
>>> + * @dev - dev handle to usb be
>>> + * @sid - streamID for iommu
>>> + * @intr_num - usb interrupter number
>>> + * @domain - allocated iommu domain
>>> + **/
>>> +struct q6usb_offload {
>>> +    struct device *dev;
>>> +    long long sid;
>>> +    u32 intr_num;
>>> +    struct iommu_domain *domain;
>> Why do we need to store this domain, You can remove this along with 
>> the one line that gets domain in probe function.
>>
> 
> We'll need a reference to the iommu domain, because the QC USB offload 
> driver will be the one that is going to map the XHCI interrupter and 
> transfer ring regions for the audio DSP.  This happens when a USB QMI 

this is okay, AFAIU, as long as uaudio_qdev->dev pointer is used in dma 
alloc apis like dma_map*, dma_alloc_* you would not need to handle 
iommu_domain directly like this in drivers.


--srini

> enable stream request is received in the USB offload driver.  Please 
> refer to:
> 
> static int prepare_qmi_response(struct snd_usb_substream *subs,
>          struct qmi_uaudio_stream_req_msg_v01 *req_msg,
>          struct qmi_uaudio_stream_resp_msg_v01 *resp, int info_idx)
> {
> ...
>      xhci_pa = xhci_get_ir_resource(subs->dev, ir);
>      if (!xhci_pa) {
>          dev_err(uaudio_qdev->dev,
>              "failed to get sec event ring address\n");
>          ret = -ENODEV;
>          goto free_sec_ring;
>      }
> ...
>      va = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, xhci_pa, 
> PAGE_SIZE,
>              NULL);
>      if (!va) {
>          ret = -ENOMEM;
>          goto free_sec_ring;
>      }
> 
> This is just an example for mapping the XHCI secondary interrupter.  We 
> will also do the same for the transfer ring.
> 
> Thanks
> Wesley Cheng
