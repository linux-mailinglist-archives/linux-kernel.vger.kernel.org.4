Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1247D635292
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiKWI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiKWI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:27:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDDFC736
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:27:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g12so27116484lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcQzfS4Peg1BcWVPqA3r5THwZqoD6UuyTScyPfW0+gk=;
        b=wwsMJSLDaFLkDmDTXJtxCSc0Yi9K/FrzEMP5aqu+f3DlffmLcAneNewS0AeVoruiVA
         P/UeSJbrk0e1LjmHE43sKXJW9qWXGXevFE80Yxar8Exmw3uJKnxVTottlDgGYvfxX1/s
         kk/OnKpMdejE9stbilHmFZz4R3CIxE1s4wpsH9FS4U5W8TyTm0TL7e6WX0mvjJwrnPmC
         comRH/5ZY+VXajexEne/REUOPAHJTj5ssKXbUQNCdIH6VEVSqy2k9eXfiU/TeNpHNTlK
         viWQ8x4OUOwoHLQCwSs8gLKi2Ggzr70p/tUZPb0B/V1fqvIzQrXjxXdhq9uro2PbBj3C
         Ra2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcQzfS4Peg1BcWVPqA3r5THwZqoD6UuyTScyPfW0+gk=;
        b=DNOa83BaYOgWgwt15Evb+eGZD+/AU/xT0HfHZvgJueIi00k4pVRbzhyy4VmF8FH8RK
         gTYQIDfodmLGJkIr5BJH/ONTGtKmWiQ1jSElwoZ7Mc2CTr5Kb+JVTq6c9AZoKfzQKKdY
         miPXDbhM+4LYcHduJ/CY6OItlqZoPiUT6Vhdf1yC17XiI/+kaPeyJ15G5QNeWc+r9olC
         i7IYqQGV5x7srghiHMFFkk2CM1cwoHLP9wN15vro0DzlYwZ6FChrXB9LuSOmbSNy2ZUh
         SDo0BDz0d1BFNEYbG4bMLnlewSBlZya9h1VWFPesQ0HAW8/8XNjMuf7WoEP56RmIdaqA
         txeQ==
X-Gm-Message-State: ANoB5pndE+1uW9Pz433GheYJwWLLpSY5rJ2TbUVdLprm2csAK8zH7s1P
        KDzc9GZz+oWxGQiLzANVZ4S/4A==
X-Google-Smtp-Source: AA0mqf43Wrz+lScpnmQazgR9edsrHf8CWzNzDGSguKpLX4o0m+7qhfGZ6s4+ZcKOiUFO9TVR0WiMOw==
X-Received: by 2002:a05:6512:2a89:b0:4b4:dffc:62a8 with SMTP id dt9-20020a0565122a8900b004b4dffc62a8mr2147155lfb.585.1669192039230;
        Wed, 23 Nov 2022 00:27:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c03d000b0026dffd032b8sm2110336ljp.2.2022.11.23.00.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:27:18 -0800 (PST)
Message-ID: <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
Date:   Wed, 23 Nov 2022 09:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
In-Reply-To: <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
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

On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
> On 23/11/2022 07:16, Billy Tsai wrote:
>> Add device binding for aspeed pwm-tach device which is a multi-function
>> device include pwm and tach function.
> 
> Subject: drop second, redundant "bindings".
> Also use proper PATCH prefix.
> 
>>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> ---
>>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>> new file mode 100644
>> index 000000000000..e2a7be2e0a18
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2021 Aspeed, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PWM Tach controller
>> +
>> +description: |
>> +  The PWM Tach controller is represented as a multi-function device which
>> +  includes:
>> +    PWM
>> +    Tach
>> +
>> +maintainers:
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - aspeed,ast2600-pwm-tach
>> +      - const: syscon
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
> 
> If this is simple-mfd then it cannot take clocks or resets.  Usually the
> recommendation for such case is: This is not simple-mfd, drop it. Drop
> also syscon and make a proper device.
> 
> However I am surprised to see such change, so I have no clue why this
> was done.

Actually now I see it was like that in previous patch, I just missed it
during previous review. Anyway this must be fixed.

Best regards,
Krzysztof

