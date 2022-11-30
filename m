Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4856763D4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiK3Lsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiK3Lsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:48:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9D3723C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:48:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u27so15514655lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6nM01jdZbRN1c8R/kAUrMPOWppbWgjC7UXAd4yftaU=;
        b=ag858vg44uCxNf2eO/iLKmnpTupGAfp1XUmIeaw9JsO+AnI3ZHBhboqqA+gOeqd2F/
         ddE27oic+H1jHtAQU5hayzbWX/HFs9l37uF+zNenAy3n5wohoh4wXp17/v9A4XxVVvYY
         DkGxJnZbC73e7Q0k305SQspvKXbX5CcLlG7Hn6tP0qvf0HkoCQUNAFv4Pd3FJe85LXMu
         e36dSvagsDk4Am8ZNXxQjya8gd6+InZIQi/qpLvtzZz2OQMvunGaGgRqRcWrTpdIlKCs
         d9mxRDe1OSZXj2c7M6OEyb7+h87wsbEhKXRR7SQhazsOXpWHTQnLobYAo2HYxNmxmE7N
         Jz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6nM01jdZbRN1c8R/kAUrMPOWppbWgjC7UXAd4yftaU=;
        b=zeRSOGT+/PmV7esHpfUeGJM37luIwqWSPNqbHs0WKvKpGl4Wt3jgp5V7iwZZmIxRss
         CV8JeTu+otHkISz6ZVL+oXCO83zh800ooYnA1VBcKMxtTzsg1G1btemM7lX5jFn1YDVn
         UlF3HZ6cvIgziBH+OavTtITopjL+IPQxy2tLZiE/WuMUiw31/k1hDMjEOq2u4Okrmp2c
         4wYrfcj6PZ6C8161HAfbPPf1SR6ILEwQJnHQz7oDPQ8leLWiGWccrfonRs2EZlabCsFb
         92d6mvwQyML/SbjTvJnKITpqrTrrBrtKQDgWQHqJUH9Wtd+3BWCzxqxl0LoDLu/u14vY
         pNBg==
X-Gm-Message-State: ANoB5pniIfarI0z0+ZLNX88eH7UJq36gDtJe4ZWih0uhmC/oP7LdX8Tb
        e87Mio5oleYAwZrL1LntAvFLng==
X-Google-Smtp-Source: AA0mqf46Dgx9g65+aoK9r/yyHdIsLmyD6n/zh75G53yu0mO042j1P3ccGQ9+yCF7Qp0fCdrLdlfl3w==
X-Received: by 2002:ac2:5e63:0:b0:4b4:f08a:45fb with SMTP id a3-20020ac25e63000000b004b4f08a45fbmr11464657lfr.74.1669808912471;
        Wed, 30 Nov 2022 03:48:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9796000000b0026c2baa72d4sm111907lji.27.2022.11.30.03.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:48:32 -0800 (PST)
Message-ID: <1fb1474b-ec13-e83a-973e-bd9e9a86cb44@linaro.org>
Date:   Wed, 30 Nov 2022 12:48:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 09/14] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-10-hal.feng@starfivetech.com>
 <1d62f95f-0edc-afd4-abb4-37fadc0b6a47@linaro.org>
 <72b3d10e-5a8e-ed42-6808-f53773913422@starfivetech.com>
 <768c2add-4c1f-0b36-5709-dbcdd560f504@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <768c2add-4c1f-0b36-5709-dbcdd560f504@starfivetech.com>
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

On 30/11/2022 10:47, Hal Feng wrote:
> On Fri, 25 Nov 2022 14:41:12 +0800, Hal Feng wrote:
>> On Mon, 21 Nov 2022 09:47:08 +0100, Krzysztof Kozlowski wrote:
>>> On 18/11/2022 02:06, Hal Feng wrote:
>>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>>
>>>> Add bindings for the system clock and reset generator (SYSCRG) on the
>>>> JH7110 RISC-V SoC by StarFive Ltd.
>>>>
>>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>
>>> Binding headers are coming with the file bringing bindings for the
>>> device, so you need to squash patches.
>>
>> As we discussed in patch 7, could I merge patch 7, 8, 9, 10 and add the
>> following files in one commit?
>>
>> include/dt-bindings/clock/starfive,jh7110-crg.h
>> include/dt-bindings/reset/starfive,jh7110-crg.h
>> Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> 
> Hi, Krzysztof,
> 
> Could you please give me some suggestions?

You can keep aon and sys split. First add one of them with their own
headers. Then add second with their own defines.

Best regards,
Krzysztof

