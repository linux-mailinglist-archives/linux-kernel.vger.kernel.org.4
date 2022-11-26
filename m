Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3663960B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKZNIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKZNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:08:48 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A861CFDA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:08:47 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id bn5so8029883ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBp9JJJ8y9iJjxZRAAxiuLXJ4T2FaosTbSPRiHvomTk=;
        b=bST3FkgoBljZ5d3OnIxGZe694KSTcTtbU7/LamQOhEBhuRF5W2cZybdVk7PBbPhf/z
         V/WUfp695FFhu2WImtkfdYtIcPHpVs0TJM44SSFvtsfclcHIJ9E5VUsuUbnK2ofTsSVE
         O/qvyOru7KZQo3SFpW8EZllT9HfPeKdDLQlfnl7gSrsoHbfw3mXlfTWnURQ/vMW3ddi5
         PHqvUweV7ZEzGe1kW8DddH1qITGrPRp0/dGOsF6Z6pU8e+NGS1FCuNvohtVxjJbALS2r
         HHxc9Gm/fs6bcUEvWWfAr2elbZNzYuNsa39Ul8RdXsiY3/ES91l/Hp4SjnJGWLDAqgUz
         rHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBp9JJJ8y9iJjxZRAAxiuLXJ4T2FaosTbSPRiHvomTk=;
        b=uHAUd7VuPLnnFdqL+5fD2Ed6nWtrNRuNalYZXTldkZsMa5zSB4OXk3F2tyJ/SzUiNo
         glQleiDjW1mcHd7HoQ50xXYgCPqn1GE5jnFCl8l0tHT0TllkYFCVDOlaoWKQ+JHGWBuB
         BCCXRU1LZbHZ+QHVc0zUoSbEeYU72zqmGSdt4NishcpoIvfo6EBcQLgCnw051zG4Maxo
         SoAGVTJQIjq+1vcVKVGca5pLU9qiqedSW70g6feKu+8PiMhacCpKNgIs4mwC2UaPNKyh
         eW7nOP17G/zOVbgDdUR7KpVxWYx9yS4iyO9ut1uN0aWjJYKqh37h1ujIcCceINd8Jw99
         7imQ==
X-Gm-Message-State: ANoB5plecfnjkGzaYFLW7gd/BTo6uQUh/BMXHRlvVouV34dxiPBWZFwg
        gOEOSogYhjkXBsA39HhpvoKKcA==
X-Google-Smtp-Source: AA0mqf7wRdpO5GEpd9igTtQ2FsMD4Iu4RPsZKe+3QvKfPtldGePuaubW6od0RFNNbWpvHhgAS/id+Q==
X-Received: by 2002:a2e:6a17:0:b0:277:fae:902e with SMTP id f23-20020a2e6a17000000b002770fae902emr9927508ljc.267.1669468125710;
        Sat, 26 Nov 2022 05:08:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2410b000000b004b40c2fccfdsm933446lfi.59.2022.11.26.05.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 05:08:45 -0800 (PST)
Message-ID: <8cc27053-0635-b34f-cef8-8ac307060f1d@linaro.org>
Date:   Sat, 26 Nov 2022 14:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Lee Jones' <lee@kernel.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     'Sriranjani P' <sriranjani.p@samsung.com>,
        'Chanho Park' <chanho61.park@samsung.com>,
        'Sam Protsenko' <semen.protsenko@linaro.org>
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <CGME20221125112241epcas5p1d9558a8de5bfa807ed6dc5c55635c900@epcas5p1.samsung.com>
 <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
 <01a901d900f0$3b025560$b1070020$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <01a901d900f0$3b025560$b1070020$@samsung.com>
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

On 25/11/2022 18:06, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: Friday, November 25, 2022 4:52 PM
>> To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
>> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> samsung-soc@vger.kernel.org
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
>> <sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
>> Sam Protsenko <semen.protsenko@linaro.org>
>> Subject: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
> dedicated
>> SYSREG compatibles to Exynos5433
>>
>> Exynos5433 has several different SYSREGs, so use dedicated compatibles for
>> them.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Sriranjani P <sriranjani.p@samsung.com>
>> Cc: Chanho Park <chanho61.park@samsung.com>
>> Cc: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>> .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.yaml
>> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.yaml
>> index 68064a5e339c..42357466005e 100644
>> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.yaml
>> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysre
>> +++ g.yaml
>> @@ -17,10 +17,21 @@ properties:
>>               - samsung,exynos3-sysreg
>>               - samsung,exynos4-sysreg
>>               - samsung,exynos5-sysreg
>> -              - samsung,exynos5433-sysreg
>>               - samsung,exynos850-sysreg
>>               - samsung,exynosautov9-sysreg
>>           - const: syscon
>> +      - items:
>> +          - enum:
>> +              - samsung,exynos5433-cam0-sysreg
>> +              - samsung,exynos5433-cam1-sysreg
>> +              - samsung,exynos5433-disp-sysreg
>> +              - samsung,exynos5433-fsys-sysreg
>> +          - const: samsung,exynos5433-sysreg
>> +          - const: syscon
>> +      - items:
>> +          - const: samsung,exynos5433-sysreg
>> +          - const: syscon
>> +        deprecated: true
> Any reason to add "deprecated: true" here for above compatible?

Because it should be used alone as unspecific.

Best regards,
Krzysztof

