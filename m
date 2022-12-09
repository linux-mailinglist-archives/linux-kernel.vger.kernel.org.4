Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2294648190
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLILZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLILZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:25:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79D6B9A6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:25:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so6580787lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0K7eVJj4k3cMvSUFweS+f/J9GwqB4FTC28EsgFNd3e4=;
        b=v8O3IindDPA/6bCVNb+vJbPGFFquksYTufkIL+Vc7fLkAd/9VzB6hOH2SxGv89qjVJ
         cNK9uYg8Oy/rJtYZ/8G8LMuzRhp3Gid70zHybmHW1tZxmRozMR0cJNglctyaw17vBDgZ
         +fzwQWVeI/oQsKm7SMm1faRESIHEDNiLz86aDkwC53wksXi4ccm+VpJJsbzCNj1fZ4iD
         tjwfA1zH3m3vTQH0URH6ln7ISWtYQR2uIGmDXytFFNw0KOwKuHfI45v68zdyc4VpD9jB
         2pNx580WFgQsamVQLtnQA3INsyxfKp5Es7Yezkp5xBefQc8FjwI9VJhqJWhzi5YXrMY2
         hBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K7eVJj4k3cMvSUFweS+f/J9GwqB4FTC28EsgFNd3e4=;
        b=QJt6CR2sJQzxEQZQq3FIwHVRUJm0xTYGFjwAHCSfVHykTzuzwvBbavfxQcbXzNz76D
         G8ljpVBFl4Vw+yaoIsvfIdo4pm92kzNRFB702xmKOmouPIhqNDbUT186Wj2M027mYBZ7
         uphMlJ1w1eW9F6s0otUwFMG3qUWidUVJTtSvgu7xqvZhg+5n3EgtYEOHsZSyeCFTBEmX
         via3PrA/DTxI/Jd1ncvcW5S0KOuaTqZxdXSpARPmsHoCnSOTTUnIycpns7dlqyyVOPET
         dfMmoFhqoe9y+IDU9G6M+BTBRhUzu/U8DqG7EdPlt3l6qLJrp1r+YSbwU/BtGoEcZT4U
         VUxw==
X-Gm-Message-State: ANoB5pnXywzVkR5bOogOeuzFfiwWVY6dOpBIl5Hnx3bh0Tx0yo01qxuh
        GhskloWhcn1kJ2uP85M2ls4m+A==
X-Google-Smtp-Source: AA0mqf6LfW07j/W9B4V1vwkpcNXcjozq6HyoRYstlaUqh4lqn4eUXH8+9Cn1fFTwacZZFVk5UNKMVQ==
X-Received: by 2002:a05:6512:150:b0:4b4:f212:617c with SMTP id m16-20020a056512015000b004b4f212617cmr1274955lfo.1.1670585119603;
        Fri, 09 Dec 2022 03:25:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e12-20020ac2546c000000b00497a0ea92desm218963lfn.135.2022.12.09.03.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:25:19 -0800 (PST)
Message-ID: <79d72425-2188-0a87-4ad3-a334df081005@linaro.org>
Date:   Fri, 9 Dec 2022 12:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] dt-bindings: sound: rt5640: Allow to describe how
 LOUT is wired
Content-Language: en-US
To:     Jarrah Gosbell <kernel@undef.tools>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20221209105621.39237-1-kernel@undef.tools>
 <20221209105621.39237-2-kernel@undef.tools>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209105621.39237-2-kernel@undef.tools>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 11:56, Jarrah Gosbell wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Depending on HW design, som boards may expect mono differential output
> on LOUT. Describe a property that enables it.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
> ---
>  Documentation/devicetree/bindings/sound/rt5640.txt | 3 +++
>  1 file changed, 3 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

