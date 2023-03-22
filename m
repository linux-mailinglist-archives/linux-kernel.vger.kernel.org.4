Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C76C441D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCVHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:32:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5676567A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:32:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so69095823edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679470345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbE8oOZ1qZy7ZlmJACzOLsropg794kzA9oxRKKssPU4=;
        b=rosb2UzCDE310cFsKZvvlZEuOZU4dbBgS5Eo/Aj78i3YYF4d6XpfBhr7Ou7vQh/9z+
         RLts7gLtWNeK/icyP6htyqPMcCs0DLcWjPT9ZpuLqNRbonOSDRYa4kW/Ks4tMTxdllxp
         UIPF1R2Los/rPHB4/VkTLabY310QxilopTF6Tu4TqXci+Yt4UKc2caCvI2LN2H070Xmy
         GQE4J1zNVSei0eUNdcCGw/9sxltTDYzkuWP3kBYFCD1buvmLI1Zmnb2hTMhILpWm+gDg
         PJuBZHgChz9yECK+CbpJBYqscYCLbgk5WyKeL3KI4PodCdAVYF5RE/I8DQklVC1bs3TT
         dBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbE8oOZ1qZy7ZlmJACzOLsropg794kzA9oxRKKssPU4=;
        b=VtnNsJhg6XKpH8h+FEgxGsLcA+/m7UDx8Y/oFPaxpWvsaM8g6lMgk2kY1a8w6Lk6RC
         WP3T7wxrph7QqEvbbfySOw71/4+nd4dLw7VrDLmpF/rnFEoBzxQrMqpkD5GE61vUXyNA
         SWf1yxDhSMAtgpliDFfn2WE9IzV/Q3p7arJCaARDAlqQnfSG5hORE5UBUSFQ5ukjJdTx
         eEXxSdMJnlEAKpfEw1Tkw53Z4bK8uqxkwunh4cqYNMrITjoea6q+B7mNKuCY+IweELmA
         hiTFWhTAX2nlXNhmqwJG2ADqVWtHiORIDrcA+mM1NLhwIgr7QSdu2RD/YaYJPl32rXmS
         4U3w==
X-Gm-Message-State: AO0yUKWTqvaOV9nLvdZiesDqoRjVjswqjRdMPM/JgIiozXdoUtsyv0jn
        +vTj/V8x50NDg10F4B+BtUPDag==
X-Google-Smtp-Source: AK7set/wSSXlrbJsDDQXgAr2v2nJuUw7h9vQAscX1NrYfvyCXh6GOm7tutLrYb2SBwqnqt9K7pASpw==
X-Received: by 2002:a17:906:7016:b0:930:45ea:4a28 with SMTP id n22-20020a170906701600b0093045ea4a28mr6718363ejj.35.1679470345270;
        Wed, 22 Mar 2023 00:32:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906110d00b009333aa81446sm5117276eja.115.2023.03.22.00.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:32:24 -0700 (PDT)
Message-ID: <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
Date:   Wed, 22 Mar 2023 08:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3
 glue bindings
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321151951.2784286-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 16:19, Frank Li wrote:
> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>


Subject is still not fixed.

> ---
> Change from v2 to v3
> - Drop two fixed frequency clocks, it is system reset value, no need set now.
> If need, futher work/discuss on driver or dts change. It will not block this
> basic enablement work.
> - Drop lable
> - Drop some descriptions
> - Reg as second property.
> 
> Change from v1 to v2.
> - new add binding doc
> 
>  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> new file mode 100644
> index 000000000000..d876e3dab608
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP iMX8QM Soc USB Controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qm-usb3
> +
> +  reg:
> +    items:
> +      - description: Register set for iMX USB3 Platform Control
> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +  clocks:
> +    items:
> +      - description: Standby clock. Used during ultra low power states.
> +      - description: USB bus clock for usb3 controller.
> +      - description: AXI clock for AXI interface.
> +      - description: ipg clock for register access.
> +      - description: Core clock for usb3 controller.
> +
> +  clock-names:
> +    items:
> +      - const: usb3_lpm_clk
> +      - const: usb3_bus_clk
> +      - const: usb3_aclk
> +      - const: usb3_ipg_clk
> +      - const: usb3_core_pclk
> +
> +  assigned-clocks:
> +    items:
> +      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MST_BUS.

Drop useless pieces so "Phandle and clock specifoer of " and name the
hardware, not the syntax.

> +
> +  assigned-clock-rates:
> +    items:
> +      - description: Should be in Range 100 - 600 Mhz.

That's better but I still do not understand why do you need it in the
bindings. You never actually answered this question.

Best regards,
Krzysztof

