Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50747018F0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbjEMSGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjEMSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:06:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A235B83
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:05:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9659443fb56so1749654266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684001137; x=1686593137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VORmC64siVlBa/0lsts3YfZ0fyyp1pGdpaqv6LESwso=;
        b=wEKkAyeWa52ws3iAGnzglLlKlS3zlbpBZ4QgIsfT3pJDn0B03VxbK080SEDVumngKN
         Xdr9wix17dCRN5YoJMGYMo9kqgtQ2fzH6cI3wGX8OqNuDjaNMfijfLhE/b6Dn4BlVtAd
         KBHNxbh78/fNEK4gw7Wme7nVqhR7+9muiraIOzH9ojNzoL6HSTuIpRbK9C+H6ivxaeou
         J2tAWi2B644hS5Pr8BPft2de8uC2ffIWcP7T9KmksbbXtaQ8Q07Ud6vjttKqWNL8V2x1
         8fhBBGRKKjTaegm/1Ns61Ea/dl93XMKRuTunMW/0vUBHFb5DFhnYIWQVu3Nk2Kt0fns+
         4m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001137; x=1686593137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VORmC64siVlBa/0lsts3YfZ0fyyp1pGdpaqv6LESwso=;
        b=YOjUpy8nxI60YFqY2BrRWiPpMoAUP73zA42IVYsrYZXk3CvsLILTntABPDqQnHF92h
         yAm9tpXkO2I9PBBCSrp3FDEaZpJUGB0CTvXCV0htR8/5fCLHkWf+9cNZ0XioBqx+CfWp
         THmjJfhhuO9B6vwZZ7+Mxt8Irw0wRPa5/RSu2lMfEeVyv9ABQDaCwDP7nwqHn80JmtSy
         luHx3/TnJivXj7mHB0NwHxqHh99upbaaku8OeNUEAs3XWpJXKidANFw2qzZvqpetv0u0
         g0m62IOKY0/MeIo9T4NqKE6evcB+/4mnqjBZFnd4dC2KcPcSxXjdtHyhbkLSnrrmwkUX
         Udsw==
X-Gm-Message-State: AC+VfDy7JZdq89vd/hzZASERR2aQorIKX+5LCXPovuKLZx0DDH3eX0vL
        YKQnJZxXalrSeC4INO0qYap/Cw==
X-Google-Smtp-Source: ACHHUZ456NqFDsI+SzfZLKpEWQ+eDqx16S3lEUJwP8MVzdzMH2X2yE1vj8bXjIo/Mqxrqh0ozu1OcA==
X-Received: by 2002:a17:907:6295:b0:94e:cbfb:5fab with SMTP id nd21-20020a170907629500b0094ecbfb5fabmr27362822ejc.75.1684001137121;
        Sat, 13 May 2023 11:05:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id hx7-20020a170906846700b00965a4350411sm6962208ejc.9.2023.05.13.11.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:05:36 -0700 (PDT)
Message-ID: <015c5208-ac85-8a14-3455-c70781fd92f8@linaro.org>
Date:   Sat, 13 May 2023 20:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
 <25c92476-7bca-90c4-9130-cb765495a783@linaro.org>
 <20230512161545.GL68926@ediswmail.ad.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512161545.GL68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 18:15, Charles Keepax wrote:
> On Fri, May 12, 2023 at 05:23:22PM +0200, Krzysztof Kozlowski wrote:
>> On 12/05/2023 14:28, Charles Keepax wrote:
>>> +$id: http://devicetree.org/schemas/mfd/cirrus,cs42l43.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Cirrus Logic CS42L43 Audio CODEC
>>
>> That's audio codec, so it should be in sound, not MFD.
>>
> 
> Is this true even despite the device being implemented as an MFD?

Implementation in Linux almost does not matter here. Bindings location
match the device main purpose. We indeed stuff into MFD bindings things
like PMIC, because PMIC is a bit more than just regulators, and we do
not have here subsystem for PMICs. If you call it Audio Codec, then I
vote for sound directory for bindings.

> I am happy to move it, and will do so unless I hear otherwise.
> 
>>> +  - VDD_P-supply
>>> +  - VDD_A-supply
>>> +  - VDD_D-supply
>>> +  - VDD_IO-supply
>>> +  - VDD_CP-supply
>>
>> lowercase, no underscores in all property names.
> 
> I guess we can rename all the regulators to lower case.
> 
>>> +additionalProperties: false
>>
>> This order is quite unexpected... please do not invent your own layout.
>> Use example-schema as your starting point. I suspect there will be many
>> things to fix, so limited review follows (not complete).
>>
>>
>> Missing ref to dai-common
> 
> Apologies for that I was a little hesitant about this but this
> order did make the binding document much more readable, the
> intentation got really hard to follow in the traditional order. I
> guess since I have things working now I can put it back, again I
> will do so unless I hear otherwise.

The additional/unevaluatedProperties from child nodes are indeed moved
then up - following the property:
   pinctrl:
     type: object
     additionalProperties: false

but that's exception and for the rest I don't see any troubles with
indentation. That would be the only binding... so what's here so special?

> 
>>> +  pinctrl:
>>> +    type: object
>>
>> additionalProperties: false
>>
> 
> Can do.
> 
>>> +
>>> +    allOf:
>>> +      - $ref: "../pinctrl/pinctrl.yaml#"
>>
>> No quotes, absolute path, so /schemas/pinctrl/....
>>
> 
> Can do.
> 
>>> +
>>> +    properties:
>>> +      pin-settings:
>>
>> What's this node about? pinctrl/pinctrl/pins? One level too much.
>>
> 
> codec/pinctrl/pins
> 
> The device is a codec, so the main node should be called codec,
> then it has a subnode called pinctrl to satisfy the pinctrl DT
> binding.

Sure, but then you do not need pin-settings. Look at Qualcomm bindings
for example:

Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml

Best regards,
Krzysztof

