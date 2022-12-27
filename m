Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D9656FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiL0VdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiL0VdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:33:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3B263D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:33:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so21200652lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blLdzUMAkH6NNOpHUUK0r2VWc/AFPUHqvr7AifIWIZI=;
        b=TwQ0/7811fSSzMqrJssEzw6BoEyyvfG48ujo0eQ+zgnPM/yKo+OCopgEGg+EKtRWMY
         Qjz1Qd+h/pa7QIfjiFjtXEuuzalGr2V0xAUOmPIIrIpnacNZDIceeuFTlQ4tSbvmSEsv
         Rpsbm/XfJ+wTPN5x5I4uoJF5xuYOJgInoSgEOKn8owlQAsn3CaVmMkZaMayM19wLxfr7
         MiEReiWiQ/jT3i/siSclbwlZ99e+tyrR1hXoHr05Xur+WotgBs5evT2iu/fUdGLBxinv
         xTk8zpsTHIFDLNj2Tj2qaasRYvWJHLmLPEy0T96EoTjlvvQi2XSk6uegPdpiJ0dmRrD2
         7wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blLdzUMAkH6NNOpHUUK0r2VWc/AFPUHqvr7AifIWIZI=;
        b=AdQPfj47Z7gG6AnMYYjwiI25eQXsxQYHRvPnhE9fFMTLNniXQA8JkioPpvq6x1hSD+
         DXnp/eLoSzrl2TDJO0o2ojkwty0P425kTcfvX99A9wM0Gx/YDmVY5JLi85MdnakVe1bG
         gbIkwJ39zyykLaPzSaoL0zynz7+pi/e4f5rV4REcZvznfvcpqmOyz7sfgy3ZGL5kXWNf
         fOxb+4A1hGUSNJQx9BID/RYuCxV5YCxP4ii9Umw7ZMxCFRLAO4r+rq0PO6zvdU3wy2aX
         9LdGj8sEpt6orl4kqRoqMxuEoLu0Deqv1yaRQGmi2mXwqjpkGm5wE3t7agMgtqnrCPIB
         SOJQ==
X-Gm-Message-State: AFqh2koPv3CQUFBqvA5AGmeMfRi4DBkZOj3IVBFJrC9wuAMXzApE4j10
        ECI9MhfxD/3KVkMgYPJauxAPvA==
X-Google-Smtp-Source: AMrXdXuaAAOW9AP+69/mg0K8pYcjI6noxqGBDzQUMRrrItvqeB0VXR5G4dXsaLjX2lWQlF+DRJmCSg==
X-Received: by 2002:a19:7b18:0:b0:4b5:9cce:73a0 with SMTP id w24-20020a197b18000000b004b59cce73a0mr6987359lfc.39.1672176792470;
        Tue, 27 Dec 2022 13:33:12 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q25-20020a194319000000b004c57abccb8bsm2388708lfa.102.2022.12.27.13.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 13:33:11 -0800 (PST)
Message-ID: <f6e4e538-b4dd-a45a-0078-ea7ebb960672@linaro.org>
Date:   Tue, 27 Dec 2022 23:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op
 callbacks
Content-Language: en-GB
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-5-quic_wcheng@quicinc.com>
 <CAA8EJprFD53zmECHJ44FpjztRjwsMym2QP_Gk-JWya-SL_ryHA@mail.gmail.com>
 <730d8cbc-c391-6d77-2374-713f539d38b6@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <730d8cbc-c391-6d77-2374-713f539d38b6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 23:07, Wesley Cheng wrote:
> Hi Dmitry,
> 
> On 12/24/2022 3:03 AM, Dmitry Baryshkov wrote:
>> Hi,
>>
>> On Sat, 24 Dec 2022 at 01:33, Wesley Cheng <quic_wcheng@quicinc.com> 
>> wrote:
>>>
>>> Allow for different vendors to be notified on USB SND connect/disconnect
>>> seqeunces.  This allows for vendor USB SND modules to properly 
>>> initialize
>>> and populate internal structures with references to the USB SND chip
>>> device.
>>
>> The commit message definitely needs some improvement. We do not notify
>> vendors on SND connect/disconnect events.
>>
>>
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   sound/usb/card.c | 22 ++++++++++++++++++++++
>>>   sound/usb/card.h |  7 +++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 26268ffb8274..212f55a7683c 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -117,6 +117,21 @@ MODULE_PARM_DESC(skip_validation, "Skip unit 
>>> descriptor validation (default: no)
>>>   static DEFINE_MUTEX(register_mutex);
>>>   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>>>   static struct usb_driver usb_audio_driver;
>>> +static struct snd_usb_vendor_ops *vendor_ops;
>>> +
>>> +int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops)
>>
>> platform ops?
>>
> 
> Will change it.
> 
>>> +{
>>> +       vendor_ops = ops;
>>> +       return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(snd_usb_register_vendor_ops);
>>
>> What happens if several platforms try to register different ops? I saw
>> from the patch 09/14 that you register these ops unconditionally. If
>> other devices follow your approach there is an obvious conflict.
>>
> 
> Thank you for the review.
> 
> That is true.  I don't think there is a proper need to have multiple 
> vendor ops being registered, so maybe just returning an error for if ops 
> are already registered is sufficient.

This would be a required step. And also you have to check the running 
platform before registering your ops unconditionally. Ideally this 
should be done as a part of the device's driver, so that we can control 
registration of the platform ops using the usual interface.

> 
> Thanks
> Wesley Cheng

-- 
With best wishes
Dmitry

