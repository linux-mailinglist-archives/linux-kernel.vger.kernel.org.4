Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237667B0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjAYLKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:10:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E64C1E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:10:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so16655385wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJtTZhrwaqH3s3nH8A+0YXY5lPVl4tJDj1mXgSnDowA=;
        b=zbL5Bo69yM/6w4xhXqFMJxIAOw5UQ2yCYIiDsIeWN/3gNv75Jg/yCr4CRpp1Sd2I04
         fBaFHe6vVl4gQ6Ckg/IvwWyI6ydZ4qoFacpmRsSNzfGBnG0dwjsggENeR33EMM2zkIeW
         0q/5r7I/Ud2lPjFrJAzeXuJCSfgvgviZQSur1oSIJFAK+5DcO5FTF8fkHTz15ujOeJ0J
         P7yTUoZeTcjdTSyXpMcVod77Xw1kl2/FqISs4d620/jYZ/7qkaxN23CPY2/sQOEH3Ow1
         cVZMldgnUYxW2UJxSQC4PL2kygFLma+OcTySfRN2Rh0uHKR4gfJMcROwrn1tEP31C0EJ
         7NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJtTZhrwaqH3s3nH8A+0YXY5lPVl4tJDj1mXgSnDowA=;
        b=XggPZOQj9o1RXOmHGINVXG9xYy/hUra7h0r043ACfRvekyDQ8FDnNGsYBrwQZlMpKF
         7F/YY8go9IpmTcQwEpLuY+1UsegTTzvcxdRBS5BdElJLhme/J8ew0ozI5ORV626bSLTL
         Rru+zCnh9mfwqU2WoGhoQ2SWG/FN5oE57DzzknNjGODKF4AItTYymPw8wf8FsZmciaWZ
         POOo61zBXDzNlVntIT7AIpHGS4KY/04jvWVNrNJYBWnK420b/s5RWlLsoaMazre4UIUj
         W6sx0e11etKqDArB/iJgFRIYurbcSVtYhSAJbhpgETV8oLQyqUREMHAKEmYIIm4FHSqH
         /lLA==
X-Gm-Message-State: AFqh2ko8FtjQF20ZukRIpqsHk7E8XCuBX/dyvHYRWoSoTKRe7j35DSrr
        bOdyrO0C6N97/U7zE0fYe0msgw==
X-Google-Smtp-Source: AMrXdXtSIH3syXyxnqXwjnP6DbOMmtoF5w7xPN0YIgvt87MuZJe5f5fhpWIcO4suVj/J5Yr/QKdELA==
X-Received: by 2002:adf:b181:0:b0:2be:59aa:fce5 with SMTP id q1-20020adfb181000000b002be59aafce5mr16633860wra.69.1674645021880;
        Wed, 25 Jan 2023 03:10:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u2-20020adfae42000000b002bfb8f829eesm1524135wrd.71.2023.01.25.03.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:10:21 -0800 (PST)
Message-ID: <50ec54ba-3468-3448-3fab-f28e97549ad2@linaro.org>
Date:   Wed, 25 Jan 2023 12:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125104520.89684-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Add device tree bindings for IPQ5332 TLMM block.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  .../pinctrl/qcom,ipq5332-pinctrl.yaml         | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
> new file mode 100644
> index 000000000000..d101ee04b8b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml

Name matching compatible, please.

> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5332-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ5332 TLMM pin controller
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description: |
> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq5332-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true

missing maxItems

Rebase your patches on latest next and use the latest bindings and
drivers as starting point.

> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 27
> +
> +  gpio-line-names:
> +    maxItems: 53

You have 54 GPIOs.

> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-ipq5332-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-ipq5332-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-ipq5332-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          pattern: "^gpio([0-9]|[1-4][0-9]|5[0-3])$"
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ PTA_0, PTA_2, PTA_1, atest_char, atest_char0, atest_char1,

1. lowercase only

2. order all these by name


> +                atest_char2, atest_char3, atest_tic, audio_pri, audio_pri0,
> +                audio_pri1, audio_sec, audio_sec0, audio_sec1, blsp0_i2c,
> +                blsp0_spi, blsp0_uart0, blsp0_uart1, blsp1_i2c0, blsp1_i2c1,
> +                blsp1_spi0, blsp1_spi1, blsp1_uart0, blsp1_uart1, blsp1_uart2,
> +                blsp2_i2c0, blsp2_i2c1, blsp2_spi, blsp2_spi0, blsp2_spi1,
> +                core_voltage, cri_trng0, cri_trng1, cri_trng2, cri_trng3,
> +                cxc_clk, cxc_data, dbg_out, gcc_plltest, gcc_tlmm, gpio,
> +                lock_det, mac0, mac1, mdc0, mdc1, mdio0, mdio1, pc, pcie0_clk,

Best regards,
Krzysztof

