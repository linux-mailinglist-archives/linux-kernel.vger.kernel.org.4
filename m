Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213662C2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiKPPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiKPPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:44:11 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA1915FD5;
        Wed, 16 Nov 2022 07:44:07 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-141ca09c2fbso10905273fac.6;
        Wed, 16 Nov 2022 07:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMo6J/xzRkf1qXE2NKBwI6pYJF06fUQVfFkcN76kkF8=;
        b=O0elWtFf+jqfYVUr+llAdKZs1NG6xr9bZG+uO5RTaHPeYAU6We9tOiKrOqzuhRHOFH
         gksLtoxHXnRl3jWCDAE8w3RdQfM9DSQ6Disx/9EC6UAIp9lHH0oNNv9wU1HOIQujv/ez
         2UmigPR3r7J0h0FiZm81XyjHctWUvbqXqHuTQIgXrVYh6l14dLkUmdVixZok/WsVdyij
         N/5IKjmo5BSoIAvec/QT0iw+u3DPg7zrfnztVgU/qWqIjPzDaWfFu8037E1PBVUjJGfu
         CVJmkiBwMfxd05GwNpIpakdTyu8noqdg85hXl92UTsFzos3v/ow92jLRxTOzBbCLvrcn
         Kcbw==
X-Gm-Message-State: ANoB5pnMQ3wMdCueK0uTYiCLmDBCvrVqoozieUTHIrS1cepMsPLZeHEu
        tUOmlXs1eAM0oiFXhfuErf8zgxoEVQ==
X-Google-Smtp-Source: AA0mqf54pkgBbUpdwKOrjUT6QhVYiAi0ssoyyBFQndLmit2Qvve+VkWtQ12mUZTMUwvVfGPtCp7sdw==
X-Received: by 2002:a05:6870:be97:b0:132:712d:75cb with SMTP id nx23-20020a056870be9700b00132712d75cbmr1977748oab.145.1668613447117;
        Wed, 16 Nov 2022 07:44:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j59-20020a9d17c1000000b0066da36d2c45sm2641748otj.22.2022.11.16.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:44:06 -0800 (PST)
Received: (nullmailer pid 48656 invoked by uid 1000);
        Wed, 16 Nov 2022 15:44:08 -0000
Date:   Wed, 16 Nov 2022 09:44:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 08/10] dt-bindings: phy: Add qcom,snps-eusb2-phy schema
 file
Message-ID: <20221116154408.GA4193429-robh@kernel.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-9-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-9-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:01:55PM +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> new file mode 100644
> index 000000000000..d6a4bdd0cd42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,snps-eusb2-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm SNPS eUSB2 phy controller
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@linaro.org>
> +
> +description:
> +  eUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-snps-eusb2-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: ref src

parent to 'ref'? If so, parent clocks don't go in 'clocks'.

> +      - description: ref
> +
> +  clock-names:
> +    items:
> +      - const: ref_src
> +      - const: ref
> +
> +  usb-repeater:
> +    description:
> +      Phandle to eUSB2 to USB 2.0 repeater
> +
> +  vdd-supply:
> +    description:
> +      Phandle to 0.88V regulator supply to PHY digital circuit.
> +
> +  vdda12-supply:
> +    description:
> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
> +
> +  resets:
> +    maxItems: 1
> +    description:
> +      Phandle to reset to phy block.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - vdd-supply
> +  - vdda12-supply
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sm8550.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/clock/qcom,tcsrcc-sm8550.h>
> +
> +    usb_1_hsphy: phy@88e3000 {
> +        compatible = "qcom,sm8550-snps-eusb2-phy";
> +        reg = <0x88e3000 0x154>;
> +        #phy-cells = <0>;
> +
> +        clocks = <&rpmhcc RPMH_CXO_PAD_CLK>,
> +                 <&tcsrcc TCSR_USB2_CLKREF_EN>;
> +        clock-names = "ref_src", "ref";
> +
> +        vdd-supply = <&vreg_l1e_0p88>;
> +        vdda12-supply = <&vreg_l3e_1p2>;
> +
> +        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +    };
> -- 
> 2.34.1
> 
> 
