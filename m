Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5F662140
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjAIJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjAIJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:17:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AC14D1B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:14:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so7449638wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlixzkzqValLsSGt/YddnrJastCEZJ5Ucobceh+rKl4=;
        b=MG1vI+rwgFcGbrK7mXwF62ZyHrexAKwldb9ir0SczjotVq/ePou+OuJNODzoCUHlda
         2HYJaAwKYPj3CTcX7U6QCe+eGAfmy5l4SmaDwXYbp2yGU+OgauTfV1T52jCjCwNxqdm1
         27HwuDnbsNTCP7QZdn1OxKrhsJ+yTu8H0jHSUQCQgL03vf7G5u2b3Tt45jglpMe4tCS5
         85/2Me+TLmnluhZ3SWDaLNuFdTLiZAfEVMCaBIaHQz2jvhFcLeJHjT/oL3cNhBuQBPSs
         3I4381X+2lFsQUgLFjtczMc1GMXzDYfsW2otcFaDJAjNYPfsivJuESWJtGkUBGwqBaF1
         JbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlixzkzqValLsSGt/YddnrJastCEZJ5Ucobceh+rKl4=;
        b=vxafX113SJMNevALzlcmMtxGYjJoENikUL/lS16x8JAafS73j2Ovm0qLeArRZcjTUI
         rDTQRyIqbuvYVGmiJPrqxZXa3Xoanbmhh8YRbhOZQUPh4JZ4Hx8YTUMQ4K4nHDWo3Lko
         BbBp6SkUb5IvExH3tbJ3BdPoU3SLjuN6vNNX2qfXklYV/kv/59bo5zvFa0sjNMdeoBdi
         8+ebxgpIMRzr9XTuKQrHYdFXOFCWMXx7GzRi5kvmsaAsWqjSAUlJ/Jw0s9HrxZrN6oFS
         pSzgPbQGC+uMRRm/ToeiY8N0sW1xgs4eX7qiC3Oa2KnFB8B3RBkSR/GXow2hb5wQZI3D
         LJfg==
X-Gm-Message-State: AFqh2krSkonBnpFpBVLRE8mk3wIrn9MDzsj7rNQ9eRJtzX/+5mtpS51A
        mlQ/zCXWpuZX0qjCVlh3hjwuqQ==
X-Google-Smtp-Source: AMrXdXskykw7MrPU0fzOfCuWIR+MxaI3X/Nt7l+Cf8qE1kFjUipKm+VPSXLtzR3XByRKyNXHg/aSbw==
X-Received: by 2002:adf:f482:0:b0:2bb:f4bf:e758 with SMTP id l2-20020adff482000000b002bbf4bfe758mr1853263wro.48.1673255647637;
        Mon, 09 Jan 2023 01:14:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j17-20020adff011000000b002a64e575b4esm8116461wro.47.2023.01.09.01.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:14:07 -0800 (PST)
Message-ID: <8d22cd2c-a0d1-757d-0723-cd96f582f408@linaro.org>
Date:   Mon, 9 Jan 2023 10:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
 <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
 <20230107150740.0ba34aa1@aktux>
 <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
 <20230107160105.66df4136@aktux>
 <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
 <20230107165457.30f4dddf@aktux>
 <70474070-404b-2fbe-2575-4810f6fbda91@linaro.org>
 <20230108182049.679de9f9@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230108182049.679de9f9@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2023 18:20, Andreas Kemnade wrote:
>>>>
>>>> No, half compatible is the A in such case.
>>>>  
>>> I think that there is some misunderstanding in here. I try once again.
>>>
>>> Define compatible with "X" here:
>>> To me it means:
>>>
>>> device fully works with flags defined in:
>>>
>>> static const struct esdhc_soc_data usdhc_X_data = { ... };
>>>
>>> with usdhc_X_data referenced in
>>>         { .compatible = "X", .data = &usdhc_X_data, },
>>>
>>>
>>> So if there is only "A" matching with above definition of compatibility
>>>   compatible = "A" would sound sane to me.
>>>
>>> And scrutinizing the flags more and not just wanting to achieve error-free
>>> dtbs_check, I think is this in most cases where there is only "A". 
>>>
>>> If there is "A" and "B" which match that compatibility definition, you
>>> say that only compatible = "A", "B" is allowed, but not compatible = "A".
>>> In that case I would have no problem with that.
>>>
>>> But if there is only "A" but no "B" matching the above definition, I would expect
>>> that only compatible = "A" is allowed but *not* compatible = "A", "B".  
>>
>> Sorry, I don't follow. I also do not understand what "matching" means in
>> these terms (binding driver? of_match?) and also I do not know what is
>> the "above definition".
>>
>> Devicetree spec defines the compatibility - so this is the definition.
>> There will be differences when applying it to different cases.
>>
> Ok, lets stop talking about A and B, lets be more specific.
> Hmm, I try to insert the missing bits here:
> 
> I am not convinced anymore that my patch is correct
> - for dtb compatible formality
> - for pure technical reasons
> 
> I am not convinced that your proposal is correct either.
> - for pure technical reasons (for same resan as you state)
> 
> Especially this part I consider faulty:
> +      - items:
> +          - const: fsl,imx6sx-usdhc
> +          - const: fsl,imx6sl-usdhc
> 
> Keyword: ESDHC_FLAG_STATE_LOST_IN_LPMODE (detailed that in
> an earlier mail).

I am not discussing here real compatibility for your hardware, as I
don't know whether 6SX is or is not compatible with 6SL. I am saying
that it either is or is not. Cannot be both at the same time.

Now for the question about 6SX+6SL. Rob responded here detailing when
compatibility of SX and SL is valid. If your hardware fits this case,
then remove the alone SX from enum and add SX+SL list like in this patch.

If your hardware does not fit, so there is no single 6SX client which
can use 6SL compatible and work somehow (e.g. half-speed, reduced
capabilities but still work correctly), then please bring back the DTS
patches. I am not sure if other people who commented on DTS, are
following our discussion here...

Best regards,
Krzysztof

