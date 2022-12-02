Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C79640AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiLBQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiLBQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:41:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09271C726E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:41:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f21so7344243lfm.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAq+fVHmIhCdKS7zABOm6n+xbqhaX7I/kqj6V6QJRdA=;
        b=cEvbPinNNHFoSzYYRCjmu+dZle00/Om99aGXDsuGwJtsjH0kcHXB3AbG7Fln+3Xe7f
         9Ed2Du4oJ5VfR09EEqhaFLIbzhnk5sWAK2MB+M56NYEEraFEowoahozwZZ+OWMDVj1va
         L3Fg4QmE2KsZEk3e5XZTI18U4ZDwDAMHxKNUEHD60Tr1hOTIjff3AcLWl8/9JxEzCjsJ
         hshnf+ycPMcOSSBoCJEZB4FCrFbyo2cmXpZ01qt7NDSqa2HT1ZL+dnv0wVUdbSFfwf7K
         PssCqh2six1PYS51W4kh3lg7t4NDp5FR8oEOeim1Ak1FoxS0jWbXqIjzYU8OsSt7oW3Z
         3QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAq+fVHmIhCdKS7zABOm6n+xbqhaX7I/kqj6V6QJRdA=;
        b=Pq/KIXzESr6snZgcQtUn30zoQDMn9xtMQrjat7d3KGKsR4mmr7tnwLhsUL2N1f09KJ
         WGgYS8pLnebnGmxJ7QxqeqvaXkPzCYBKIREZkRkMpq25nwHJMGpO/7vV6wenv8V4tjNC
         KNGSZnWM2gdzSiHqZ2Wbxhm2ckZqQAH25x5xI1q0iw+P8kUIAvPVidKtF+oUGT68ECHE
         k7BCmcq/Wy2E5Ur2/Uiy7HbuYGuvvE2lJxHD7sk8MW3l4ZaOUIhTn+l+kplOVbLpuRby
         abKtXTbNl/+MIbQO6RlsIqScJFyUClJn20U7Os5JWCvb4SzKc/W0jKYOpxXdfbVlw5xY
         HG9A==
X-Gm-Message-State: ANoB5pkLDcVeIiO4YGcdwQB5BwFTuCTmJYKUDY3WyBSNZSFYRBWD6qAh
        0bPkEGoq3or/y0Veo8CZ9u4hWg==
X-Google-Smtp-Source: AA0mqf6oea5Kvs0FUDDil6DVjGdcz2bh7/d3UarMFl9jl+UoVskWak6MPuASvv0rchDNa4BGdJu6aA==
X-Received: by 2002:a05:6512:484:b0:4a2:33f8:2d0f with SMTP id v4-20020a056512048400b004a233f82d0fmr23443294lfq.140.1669999301382;
        Fri, 02 Dec 2022 08:41:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a25468d86asm1075351lfa.68.2022.12.02.08.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:41:39 -0800 (PST)
Message-ID: <620b19f5-2202-21a5-7e3b-816dcd42d1b4@linaro.org>
Date:   Fri, 2 Dec 2022 17:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Content-Language: en-US
To:     Martin Kurbanov <MMKurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
 <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
 <0a9e7d65-4ad7-b753-ec9b-8e58a549b5db@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0a9e7d65-4ad7-b753-ec9b-8e58a549b5db@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 18:43, Martin Kurbanov wrote:
> Hi. Thank you for quick reply. 
> 
> On 25.11.2022 11:29, Krzysztof Kozlowski wrote:
>>> +
>>> +  imax:
>>> +    maxItems: 1
>>> +    description:
>>> +      Maximum supply current, see dt-bindings/leds/leds-aw200xx.h
>>
>> No. Use existing properties from common.yaml. This looks like
>> led-max-microamp and it is per LED, not per entire device.
> 
> The AW200XX LED chip does not support imax setup per led.
> Imax is the global parameter over the all leds. I suppose, it's better
> to add vendor prefix or take minimum from all subnodes?
> How do you think?

Have in mind that led-max-microamp is a required property in some cases,
so skipping it and using per-device properties does not solve the
problem of adjusting proper currents. What if each LED you set for
something which in total gives more than your imax?

> 
> 
>>> +/* Global max current (IMAX) */
>>> +#define AW200XX_IMAX_3_3MA  8
>>> +#define AW200XX_IMAX_6_7MA  9
>>
>> No. Bindings are not for storing register constants. Feel free to store
>> here IDs (ID start from 0 or 1 and is incremented by 1)... but how the
>> IMAX even matches any need for "ID"?
> 
> IMAX can be chosen from the predefined values in the
> datasheet (10mA, 20mA, etc). Do you mean the IMAX should be round down
> to nearest supported value in the driver?

What Linux driver support does not matter here. Bindings should reflect
hardware and the same time not store register constants but logical
values (for current this is in uA).

Best regards,
Krzysztof

