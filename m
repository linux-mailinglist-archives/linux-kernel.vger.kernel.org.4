Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7C6E365E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDPJCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjDPJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:02:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E631FD9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:02:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c9so17722244ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635721; x=1684227721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBUHTWlHcrro+mx7/9lOvPlUuF3ExDqDmTNUFbhNBPY=;
        b=YUvb7THHiqURbCOmoNw/dZBLEj2xPq54a3eWupj7vxzIVUhLlCpA+ST8u+1uzK5Rl9
         tkGBo9xl85Nozhw80ElwQpe3CsQc0wdf+lVxd0Mkcw8lcfEC5Tp3xrl2Ur2iVgHFmULw
         1oLC07TDOaTUx86bTpgAlVEWgNl7EklCo3Jdr00YHLe0OwOsuDriON4/LXS0LhxJrO4b
         5TtBDbeNkvgr0nGB763WOPqXE3ORTRMD1BgQXY7LlRSvs5bSIGfFNbjVNQcqsXN0pP29
         kEhdoeToT77U9g+62VJIHQKV4EuwA7XZRkPYrexxoMDWl4qeErvybkzRZS2EEwXtg1iR
         DOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635721; x=1684227721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBUHTWlHcrro+mx7/9lOvPlUuF3ExDqDmTNUFbhNBPY=;
        b=WxjZHa+bjK5hhw+jPYbVVCLjnEdKJrVlONkSpXFKwseJ8dcOJe/PMdNpv1ye/+wgxy
         qwnC5XQziQJeqYR5K374A5989F4xP0Pbc/znzzwCZKSFvNIcU4ZMV9BRe+LBqqaSXySO
         MvYaPAFc1Y/3XrTH9trYNqKs7fd4x8y65OaHdynDyVuxXL6MqzJf28r4wN0nuI+VYMu/
         SQOq//y+qcJbMjXvvogTI7Ch5fxY7S3chDhV3VhO3wXHfyiRL80SQDwPdXE1acDwZgL8
         cP/onO2HeiMznPmcxIyWmdE4lyxH9o/CLBc2Yr5gqDX1ZlHKCDc4OD2kO24kf+yk+IEw
         O6QA==
X-Gm-Message-State: AAQBX9eSHV6XXb8Rt33WRIXbjjHugM4/lpMZHIQVB+kn3DXcaIMRhBJW
        A5Bg4pr+ql+1nLDk52bzm9LXDg==
X-Google-Smtp-Source: AKy350aCD3Nl1B/AkFfCuM+/+M8YwGdIR+7xVCq69z7r0rmzBt4t2g8IpQdlLgZTDLt3vijT1P2g0g==
X-Received: by 2002:a17:907:838d:b0:947:4828:4399 with SMTP id mv13-20020a170907838d00b0094748284399mr3225966ejc.12.1681635721315;
        Sun, 16 Apr 2023 02:02:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id nd39-20020a17090762a700b0094e477eb441sm4776829ejc.110.2023.04.16.02.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:02:00 -0700 (PDT)
Message-ID: <5f33cdc9-cc14-e122-0590-ad59a0f44b2b@linaro.org>
Date:   Sun, 16 Apr 2023 11:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 1/9] dt-bindings: arm64: Add IPQ5018 clock and reset
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-2-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-2-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> This patch adds support for the global clock controller found on
> the IPQ5018 based devices.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed review comments and dts schema warnings
> 
>  .../bindings/clock/qcom,ipq5018-gcc.yaml           |  63 +++++++
>  include/dt-bindings/clock/qcom,gcc-ipq5018.h       | 183 +++++++++++++++++++++
>  include/dt-bindings/reset/qcom,gcc-ipq5018.h       | 122 ++++++++++++++
>  3 files changed, 368 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
>  create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
> new file mode 100644
> index 0000000..f94a699
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq5018-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on IPQ5018
> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on IPQ5018
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,ipq5018-gcc.h
> +    include/dt-bindings/reset/qcom,ipq5018-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq5018-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE20 PHY0 pipe clock source
> +      - description: PCIE20 PHY1 pipe clock source
> +      - description: USB3 PHY pipe clock source
> +      - description: GEPHY RX clock source
> +      - description: GEPHY TX clock source
> +      - description: UNIPHY RX clock source
> +      - description: UNIPHY TX clk source
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@1800000 {
> +      compatible = "qcom,ipq5018-gcc";
> +      reg = <0x01800000 0x80000>;
> +      clocks = <&xo_board_clk>,
> +               <&sleep_clk>,
> +               <&pcie20_phy0_pipe_clk>,
> +               <&pcie20_phy1_pipe_clk>,
> +               <&usb3_phy0_pipe_clk>,
> +               <&gephy_rx_clk>,
> +               <&gephy_tx_clk>,
> +               <&uniphy_rx_clk>,
> +               <&uniphy_tx_clk>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq5018.h b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
> new file mode 100644
> index 0000000..f3de2fd
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
> @@ -0,0 +1,183 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.

Are you sure about the copyrights that they are attributed to Linux
Foundation? CodeAurora is long gone, so this is a bit surprising.

Anyway, fine with me:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

