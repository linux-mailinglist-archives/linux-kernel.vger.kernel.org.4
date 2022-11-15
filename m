Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67A6299AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiKONII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiKONIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:08:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5526AFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:07:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so24316411lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBJBQbBMlMmd7V0JpeZBtsA3DhYWso8sxLsDK2tqGUs=;
        b=ZJq/7J3mBFpZpKRcyciB8c3k9If8s4TJ9Fs/6Gdk/OSb6dj9ULeJBxvRGZxYZAL3SS
         btx+DG0MOtdXsRe3PXjzE6HcsK5pW+yEOprjXjTV2r8jMf4Ueiqh8gIz0FatRiE9ZNO1
         VsKaV8wQLgRt8Z14GBjhG9aUsZW7bqi3WJsND8dlpH9BlzfWIelDkLo74WE3Nr1kyPGB
         8ZRAF/FCAWqt15DJAzJpF/KaPSbAUybsLNW1vbJ1PKRlzLO6k5eX3zz2HCprQpLnMefV
         9HvmntHWFXavknrll/SHKAk17FQSrH/m2wWyybn8HgAxF7X9y+eeh45AvY2XxbGUZxb4
         4K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBJBQbBMlMmd7V0JpeZBtsA3DhYWso8sxLsDK2tqGUs=;
        b=I0VClsvteElGcJaUTTq4qpqPc/+4nuwHeAfIxWvBdwWlNMJcl1lNTaMF8t0ykIfGpw
         Ss7XfPEMCAQPHIAeYiWyVIBd/JkBMi50a5L2CZUXnrDOAOJOweFfm2nerwhtlBUU+vyn
         ftsQ1CFQqX7tRdI8SFqqyjG3P4p5eXuwXJ2VIASBGDuotEc+gQzWfg4pw0yl0HjpiFIP
         ZPMXwEqQWHKDF1CLkp6G2/6DkQiad7o5zBd4GIVWNLIUPG5eD2de7N00K6uh8/TY/Mfj
         yLXTgq+vsHfqLqwzXRNXLDLQcboGppn5IESYr3zouUKITLBEyCh48LBocEufbNaQVW7t
         SJ9Q==
X-Gm-Message-State: ANoB5pkMYRdBqG69x0yFWiXxai+mGYjWA8mYGgK+xslDYHRVahVbadea
        ol6rcydFjZHNO4+auKrH4uIyAA==
X-Google-Smtp-Source: AA0mqf4gbD4DD6OxXBHy5q68FOYR9L+0Cf+XWUOqhm+ul9x3BuzZfPL1VH2lsviiirfkCFxML6tXtA==
X-Received: by 2002:a05:6512:3f2:b0:4a2:3e6c:a32b with SMTP id n18-20020a05651203f200b004a23e6ca32bmr5413822lfq.54.1668517674600;
        Tue, 15 Nov 2022 05:07:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e8e77000000b0026c2d2a9b92sm2426054ljk.101.2022.11.15.05.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:07:53 -0800 (PST)
Message-ID: <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
Date:   Tue, 15 Nov 2022 14:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
In-Reply-To: <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 14:05, Krzysztof Kozlowski wrote:
> On 14/11/2022 12:15, Herve Codina wrote:
>> Add the h2mode property to force the USBs mode ie:
>>  - 2 hosts
>> or
>>  - 1 host and 1 device
>>
>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>> ---
>>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>> index 95bf485c6cec..f9e0a58aa4fb 100644
>> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>> @@ -39,6 +39,16 @@ properties:
>>    '#power-domain-cells':
>>      const: 0
>>  
>> +  renesas,h2mode:
>> +    description: |
>> +      Configure the USBs mode.
>> +        - <0> : the USBs are in 1 host and 1 device mode.
>> +        - <1> : the USBs are in 2 host mode.
>> +      If the property is not present, the value used is the one already present
>> +      in the CFG_USB register (from reset or set by the bootloader).
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
> 
> 0/1 are quite cryptic. Why not making it a string which is easy to read
> and understand? Can be something like "two-hosts" and "one-host". Or
> anything you find more readable...

...but actually you should rather make it a property of your USB
controller, not clock controller. You have two controllers and we have a
generic property for them - dr_mode.

Best regards,
Krzysztof

