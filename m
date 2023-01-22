Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81AC676D55
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAVOAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAVOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:00:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED91E29A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:00:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so7207246wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdiNtdUzDSNjkfrLI1XyxfUQrXm9A0/KpGIdOvbJRBs=;
        b=eMt5C6g6bjdP2zwpVZADjhiFtBJMN/WOpc2ug3gd+b9qLR1Cq6j30I+FsBvx/zLsSj
         HkltIXBr3q/pKksh3TAVvrmS78uUKP5mFjwvKGxOSVDoU/jfpmS2gSKlQgi1uzH/3aaY
         eKuUbqa39ldeEf6uHqdtixfXV0iDYY8+6leKV1BAvtXP6soJTy8a6eLSC3k3chqB0LIh
         VTs1cCi3n8n1aO46uXEL1F10yb2OFViMwunpeYAWrbvWuvq/xDE/W1VHuflQ7+1iq6KH
         r+RDaXsklUZo0RaVrOyDxQyKPi4o9WS/r6PTE7a0tRfj2vh3iX80rNj3mbNc/lpQ0Hc1
         0w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdiNtdUzDSNjkfrLI1XyxfUQrXm9A0/KpGIdOvbJRBs=;
        b=VmSOvpl4jdVoMeG9ydD/3HgatfzAFmfLGdr6e+7+KilP7H5+puZzptgkks0UZY/r9h
         imAwnSUwxwic3jjzX4y6Xfn9G82QIwcCLYxa7A0iFhwMt+ntmtiEWyYlsu4lG413WD6/
         wrn6ryKzom0i4e7m/tREAK5DSFxLE09jBAz4Ly0vf0gARXOAFMbEeAQEGKuv8uczHhZs
         4uvYWHt94oYYgqETKuJe3FqCp275xXdlfO5yVLXSGK7UlDTT9eqGhwOEQec+bvsJgFHY
         z/ICs1dEQp5bPj2YYEX4Y+UJOYBMSiFh3X3mASQiEXGBlmz8aev2UXCkWD1IWv6WU0+5
         ud7g==
X-Gm-Message-State: AFqh2kosQVeIdYcx4UFE1wxToTL1ig6crFR3pP/gV6InWHHZOYJBLbkL
        nhGspVOMijRjIKGDafXE+7D48g==
X-Google-Smtp-Source: AMrXdXs0JQRtQnYauZIlR3A+e26rCG+DYCwtpwZVGqYvz7atFYKwwQCVmfh9CjkA+F02koPFUAdgdw==
X-Received: by 2002:a05:600c:4e05:b0:3c6:e61e:ae71 with SMTP id b5-20020a05600c4e0500b003c6e61eae71mr21667261wmq.1.1674396025224;
        Sun, 22 Jan 2023 06:00:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003d237d60318sm8781576wmq.2.2023.01.22.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:00:24 -0800 (PST)
Message-ID: <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
Date:   Sun, 22 Jan 2023 15:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt
 nvmem based
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121000146.7809-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 01:01, Christian Marangi wrote:
> The operating-points-v2-kryo-cpu driver supports defining multiple
> opp-microvolt based on the blown efuses in the soc. It consist of 3
> values that are parsed: speedbin, psv and version. They are all
> appended to the opp-microvolt name and selected by the nvmem driver and
> loaded dynamically at runtime.
> 
> Example:
> 
> opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> 
> Add support for this and reject these special binding if we don't have a
> nvmem-cell to read data from.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index b4947b326773..cea932339faf 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -61,6 +61,17 @@ patternProperties:
>  
>        required-opps: true
>  
> +    patternProperties:
> +      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':

This does not end with correct unit suffix. Should be
opp-speed-.....-microvolt

> +        description: |
> +          Assign a microvolt value to the opp hz based on the efuses value from
> +          speedbin, pvs and vers

Where is the DTS change?

Best regards,
Krzysztof

