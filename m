Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67390651EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiLTKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiLTKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:17:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A6B8D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:17:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b13so17893882lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrTekWHNOgv+F0e5TC1Fas9u4YJ2h20SGUV3dr9RK5s=;
        b=k5lmZq21aFLkFdWYS+czsbL4XWEbN/x6AcmMwL0fZ2R2CIrgxj2v7PKCPFRWu8TP8S
         yKxWhCOcpht8XlLEJYZt0Gz8g10xzmvXP8hIyD4JNs2BtIuESQSJLPRs9cIzYrlA3oe3
         m3KEEgM40QFNCc/6OjIXWf1yESG0iwPUTcIY4KOR6EYeSBNYSIilnks0woVfKXCI0tHb
         XTGLsblfV+LvuPZmYvspWVxDq13pSym36OwPFXOWUkqPQTirqGDleMWEDN6rd/u8x9wi
         sY6gkknnp39imVRDw8njLINuBc0XivtZ6jY92hlzbGOkOPUtr8p8Uuuv1Ll2LG2uDG1w
         pN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrTekWHNOgv+F0e5TC1Fas9u4YJ2h20SGUV3dr9RK5s=;
        b=e6wAAW7n2WijkdEC1DZISxndnBoCzTse99NCA2sKEPvop3fqMxG8B2KHIZuuEdu3Gv
         irur1XDolPFa9mtQ+C7O2Wi86dSfnKYdHRlA5CAl/1CYKYKovVnJUrsGTqZXL638/c/q
         efS3E65bOx6BcaAAh5dcJDGj3tJPxAUq4n9atHqgsybeMDea0MMkYWarFhWom5K6Aocn
         3wxMvrwm3+XhjLnvGd8O5qKPD2V/Ha4cPL8lgZF+KhCvxbkAwHZt5M60hTyVduJbrYLE
         UW5FRV3YfSPd2va+FPbJMwkO6blWvx9g5PJKpfJyt7Y5GKPDPVGo/GbWEdxUs841pFK+
         /pXA==
X-Gm-Message-State: ANoB5plDyK+mStVLpsxAXQoMsZzHonSnuq0+koM/4xSCnumde0mopn8Y
        J5DR2soL8QriP+XN71lcDi1SoHS8g2Kpl68N
X-Google-Smtp-Source: AA0mqf5r7YbEHI6ETMCzYbU4qf7I5s7yu4+AVB4r6z2S3I8dCXcRbmpb04iUEHmo6KtOKcRln81PBQ==
X-Received: by 2002:a05:6512:468:b0:4b5:5efe:966e with SMTP id x8-20020a056512046800b004b55efe966emr12963990lfd.15.1671531458683;
        Tue, 20 Dec 2022 02:17:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z11-20020a056512370b00b004b4f1ea713csm1398723lfr.73.2022.12.20.02.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:17:38 -0800 (PST)
Message-ID: <8a0a38e2-9907-fa2e-a8a6-4cbc4dceb0a2@linaro.org>
Date:   Tue, 20 Dec 2022 11:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: add missing pcf/pca2129
 entries
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219194241.3817250-1-hugo@hugovil.com>
 <20221219220335.GA2400372-robh@kernel.org>
 <20221219175205.2989b6bf86941ec4774dab37@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219175205.2989b6bf86941ec4774dab37@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 23:52, Hugo Villeneuve wrote:
> On Mon, 19 Dec 2022 16:03:35 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Mon, Dec 19, 2022 at 02:42:40PM -0500, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> The pcf2127_of_match structure in drivers/rtc/rtc-pcf2127.c also
>>> contains:
>>>     nxp,pcf2129
>>>     ncp,pca2129
>>>
>>> Add these missing entries.
>>>
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
>>> index cde7b1675ead..00dbae7e23c2 100644
>>> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
>>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
>>> @@ -14,7 +14,10 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: nxp,pcf2127
>>> +    enum:
>>> +      - nxp,pcf2127
>>> +      - nxp,pcf2129
>>> +      - ncp,pca2129
>>
>> Check Documentation/devicetree/bindings/rtc/trivial-rtc.yaml.
>>
>> Maybe they aren't trivial after all and should be removed? Or 
>> nxp,pcf2127 is also trivial?
> 
> Hi Rob,
> the pcf2127, and also the pca/pcf2129, can use the "reset-source" property. Are they still considered "trivial" devices then?

Then they do not look trivial, so please remove them from trivial-rtc.yaml.



Best regards,
Krzysztof

