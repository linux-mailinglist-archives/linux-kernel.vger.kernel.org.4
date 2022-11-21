Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7E631BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKUIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKUIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:47:44 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F522790A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:47:43 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t10so13782957ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O63hibjYAlrDnPNGTBFzJzkRraoluFL/kguca7bLrYo=;
        b=EltU4fn2WwltWnxGtHI95UcKp8i7eq+YAlW2jT4kEfKWGeet48gr7Oebr6G+/JeJSN
         k4nMJuCyQYSLAT3mCXCYXA0vJsbMZ0chZryjsRemEqhgCF5D/hp45PV24S9hXquP2v2i
         7rroPLe7bCePychqzc4/nlgOSvGkHpxK6H6Zl/n/9H993Eg1Jvn1/CNXT7kq2og5Nx2C
         /qENFve7xFzUK2ed0IXworEBRL/XR3xLN7GDis8GrvEyXRcEOeen5BaRKHVyix0FJR4a
         /yoU/5sWtY42qhHP+t1+gnxEtXkA2T98wQCfFW91rGLMwhH571k3q1MI7/wZOQSBiBnF
         P5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O63hibjYAlrDnPNGTBFzJzkRraoluFL/kguca7bLrYo=;
        b=rS0rljUd+nvzfqFjTZMfwPq5lkdzz+3X3LcnpcSp0p8Orv93qkunrazXTa0MmIvM4d
         UUqyzKjIKqDPdmCqMNOvWU3UEHYoTZ8pzosNZ0ai6SazM09Su7qA5kZFr0L/890AKWaY
         8RR/AqhtDZMVGydeNgeYS5iJmDRUwUt8xb9urdYrsaviksIUyEO0jQ0Ox2brFXfu/+SB
         L65WJb4dooqU/obGb1oYAghqhtWg/GgbL7qzKs2YTSrOpBfpkt18f8Q8OHvTurhlOf7s
         DOYT+2cUl+HTv616siBUEF1ARVfJJXuJv2sBePE980XufwTWzBoxER1dJNKLCzNLT0Fp
         5DMw==
X-Gm-Message-State: ANoB5plxwejjswqN5Lan4a8fxcQQLrorMzDn35cEW8OFdCcX9Prqxo84
        HPhSf0Ut2Ur6fDkPTkTbAsnm0g==
X-Google-Smtp-Source: AA0mqf6CP55rs1V20Qglel+czmAfoGR50CNjnpZfVEcHfcsCVlMnJzzXwnIjMoW1Yz0V7922SH02+Q==
X-Received: by 2002:a05:651c:158a:b0:26f:c160:6dde with SMTP id h10-20020a05651c158a00b0026fc1606ddemr5035948ljq.20.1669020462193;
        Mon, 21 Nov 2022 00:47:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t9-20020a056512030900b004a05837103csm1923980lfp.196.2022.11.21.00.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:47:41 -0800 (PST)
Message-ID: <c75d1799-d7f7-d461-b412-27c084357c99@linaro.org>
Date:   Mon, 21 Nov 2022 09:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/14] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-10-hal.feng@starfivetech.com>
 <CAJM55Z_Gq22NiVYHawvjsehL8j3agvp_b2RCgabdTki+ovWa8Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJM55Z_Gq22NiVYHawvjsehL8j3agvp_b2RCgabdTki+ovWa8Q@mail.gmail.com>
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

On 18/11/2022 17:50, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add bindings for the system clock and reset generator (SYSCRG) on the
>> JH7110 RISC-V SoC by StarFive Ltd.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-syscrg.yaml         | 80 +++++++++++++++++++
>>  MAINTAINERS                                   |  2 +-
>>  2 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> new file mode 100644
>> index 000000000000..a8cafbc0afe2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-syscrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 System Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Emil Renner Berthing <kernel@esmil.dk>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-syscrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Main Oscillator (24 MHz)
>> +      - description: RMII reference clock
>> +      - description: RGMII RX clock
>> +      - description: I2S TX bit clock
>> +      - description: I2S TX left/right clock
>> +      - description: I2S RX bit clock
>> +      - description: I2S RX left/right clock
>> +      - description: TDM
>> +      - description: mclk
> 
> Maybe you could ask your colleagues for a better description of these clocks.

And drop "clock" from previous descriptions. All these are clocks, so no
need to repeat it.

Best regards,
Krzysztof

