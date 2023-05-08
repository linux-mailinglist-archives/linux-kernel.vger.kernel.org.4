Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438796F9FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjEHGaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjEHGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:30:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4611B71
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:30:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9660af2499dso409085766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683527404; x=1686119404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi0i2cMZjjInkpQ+3hyZ8l8Sv2Kjn70uJtkUShV1UHc=;
        b=Kgqy//Fcdlqj1BuDNQaLj6efRELUNo/FmN1Jr7mZ2q+5eGUU4diD+v/wbw2g8RaWPr
         BssN5M5q97S8ZzcfImpknom9SjWDUx8deCZMLQeRhTx9I+3u2rub/DyzZwOUMZRHkMqn
         oEVlzO8BZ2OqEnadoBhYig5d0AE3C92fdeHP/xiVMpfXIosZItzoaHad4NfOzhVBHBy7
         dbXdT6hhfLZmW279mQNMemDoo6Nbg+nptT9xPkHJdeOn5VOXhAIxiKLpTtfqFmIgcD0i
         weugiEm0mR6mIH3xouRvDDq2imoNPkLX5RhSRWS0f5cvfx6GuhzEhax2MQ7CMdPXCdkH
         N06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527404; x=1686119404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi0i2cMZjjInkpQ+3hyZ8l8Sv2Kjn70uJtkUShV1UHc=;
        b=j3mzAHwYDw9X9eY1S9WsdZ8t+JHd7fQ0Ypldyu3WMLLG5SyCodtQBM7n+WhvHT0QUk
         O53Ikif2S5lu8FmgHe38+DSAt2ohJPqKmude4tI+Gs1nCDK30cqiap0fyLuP3l7a3S6A
         nKVmXgHE1sCscjuDwesug+r5qoKUHgSJyiVR5x5URiBq005HMU3l328mOUk0d/fBi1oW
         1a4f1IV5qF1vVgzqasDzgzkxJiCiRuhoq1HUqiztiVNuvBE8OtvzNf1YyT/TJHzWLYYe
         nAsYkjfFjs6oSsv8uRoH5pcf3vopy6F2MQ9BJ4z8Hdbbqc3KOSOBCoJ3/0WvxOcG/7dJ
         UYhg==
X-Gm-Message-State: AC+VfDwhtZG9s8FitrqIWPl4raqLrYpLxXN/WOhkja6RacJpVeL9bXpe
        qyimRf/Wy/JKxUUvwqDv75TP7g==
X-Google-Smtp-Source: ACHHUZ5YuCPskRu1pFz1aQtZmzepVWd4mFXYAtXmOsiNTP4TxuOkZffchSM69ObwVHShGO/yj+Nzsg==
X-Received: by 2002:a17:907:1b12:b0:961:b0:3dfc with SMTP id mp18-20020a1709071b1200b0096100b03dfcmr8459701ejc.8.1683527404278;
        Sun, 07 May 2023 23:30:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id hu7-20020a170907a08700b009661484e84esm3087357ejc.191.2023.05.07.23.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:30:03 -0700 (PDT)
Message-ID: <db53c250-4e6a-5dd3-6ebc-e7c4ddc70304@linaro.org>
Date:   Mon, 8 May 2023 08:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 03/10] dt-bindings: clock: nuvoton: add binding for
 ma35d1 clock controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Jacky Huang <ychuang570808@gmail.com>
Cc:     lee@kernel.org, mjchen@nuvoton.com, will@kernel.org,
        mturquette@baylibre.com, Jacky Huang <ychuang3@nuvoton.com>,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jirislaby@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        schung@nuvoton.com, linux-serial@vger.kernel.org,
        tmaimon77@gmail.com
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-4-ychuang570808@gmail.com>
 <168351638542.4154651.973240291606333991.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168351638542.4154651.973240291606333991.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 05:26, Rob Herring wrote:
> 
> On Mon, 08 May 2023 02:59:29 +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>> between the clock controller and clock references in the dts.
>> Add documentation to describe nuvoton ma35d1 clock driver.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 +++++
>>  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 ++++++++++++++++++
>>  2 files changed, 316 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>>  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 

These are unrelated, you can ignore them.

Best regards,
Krzysztof

