Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA32A6336B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiKVIKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKVIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:10:44 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF83F050;
        Tue, 22 Nov 2022 00:10:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so22454313lfv.5;
        Tue, 22 Nov 2022 00:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbPKzkChynx+GYmDdXgP3pWFfT9r2oPlv769MzOZF9M=;
        b=OFfuNJXHKvoj8yvrcfaEJoVsq5m/cqizCbAPVyf+twUKZ/+PoaX4OTYEbOYabStW7o
         51nJj8J0yN+fjHTxLipIuL2X1YvBKz+1iUC1e1GUjAupB08RzAyb+WtTjjzOIQqO/o+I
         EGnpvcn8V10GR3VqRIADAITru3BWrcLw0h2VlQQYO7OgaEUjZ2+7afAtdgUQz3XIUtVX
         vGVdHs36GHFaZKfg7YFbZUcQW6wFMnRCcppFlQJxIvANvy9pc3w/Y/zc5CcKx58vJjzy
         tb0bvPH4E97LwstNjXCVtoPRe3Zeqd2s0lTC/nTXFijxiIoq6TAPOaCqqrDPYzwLvFOx
         MlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbPKzkChynx+GYmDdXgP3pWFfT9r2oPlv769MzOZF9M=;
        b=OCDShg65NMhCvefJcTTlB8e3PeUkQcWI8zF2K99JaJ/8Gf1q6SCw80J8fgORUtSlnU
         Z+a6noeOAnqRm6YzjYrf2PHEYAHhhxyqIJrj7qZQClsLag6lyVTpGC8e+ztujues4etw
         wB7+aV41omMncVecinC+IPa3vtbaQxAZBvMUyCWJomeVIcwwv39qy0cEqFzPhJwMA/y/
         Gv0I/t6ioTmZ97SXkcxgQP0LzsA2mHSPZUJhRJhmuFKpTYIYSAT+9Gh1LtRSW0L5hzqy
         sr4IunK9iLtjTluoE3gk644/vmkq7pXbEkzDxRVoMUEAM663WdyK5lNA+z42lHBSOTFi
         neyg==
X-Gm-Message-State: ANoB5plKeeLZjfy+jdv4zdAj6fqRy0WuYaeVL/Uvqqq8EEbLUWdD53dZ
        0W90X3owyx79vxP1rYpLb4YIUaewjXs=
X-Google-Smtp-Source: AA0mqf5n2ArCtX2nxBRlLeYUjETg/GqYWo2qGHvn3l6oGI8VXl2wN4XgvhzZr5YRDxtkPm5cv/U8dA==
X-Received: by 2002:a05:6512:4029:b0:4b4:e26b:2c28 with SMTP id br41-20020a056512402900b004b4e26b2c28mr375487lfb.356.1669104640538;
        Tue, 22 Nov 2022 00:10:40 -0800 (PST)
Received: from [172.16.196.95] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651239d500b00494618889c0sm2378290lfu.42.2022.11.22.00.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:10:40 -0800 (PST)
Message-ID: <5498cfea-8aed-aa8e-dec7-6102814b572e@gmail.com>
Date:   Tue, 22 Nov 2022 10:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-7-krzysztof.kozlowski@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: drop redundant part of title (end,
 part three)
In-Reply-To: <20221121110615.97962-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and thanks.

Please note - I dropped plenty of recipients to avoid spamming so many 
inboxes.

On 11/21/22 13:06, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "binding", but instead just describe the hardware.
> 
> Drop trailing "bindings" in various forms (also with trailling full

'nit': trailling => trailing

> stop):
> 
>    find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
>      -not -name 'trivial-devices.yaml' \
>      -exec sed -i -e 's/^title: \(.*\) [bB]indings\?\.\?$/title: \1/' {} \;
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

>   Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml    | 2 +-
>   Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml    | 2 +-
>   Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml    | 2 +-
>   Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml    | 2 +-
>   Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml     | 2 +-

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

