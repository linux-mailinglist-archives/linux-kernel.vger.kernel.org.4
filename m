Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF926986B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBOU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjBOU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:57:39 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CF460AC;
        Wed, 15 Feb 2023 12:54:39 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id g15-20020a9d6b0f000000b0068db1940216so38068otp.5;
        Wed, 15 Feb 2023 12:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjzOyjobJagfirhvlCXNjjk5lMxOm3c7K/SKq6NqqPI=;
        b=EnsZ1ndN/HXOGXpCe1ntumJb08LRGNPQpLqnePul0IAXkxKeWgMme9znCPqCSuCp/U
         TVoUnyjPpjX+1Pemp6m0pZxRrBg/0e6WHMi8tzXpY/cqDCTzCrr/GVMk1jX1gQPafo+d
         8C2LOVCwa+WOb8vVlGo103YMGvlmZsfPVt4ZmPZAsrnoEolgLj4UycdpY+UB57F88wcI
         WFRR2oqC/8DIdw8wSKaUy8+1FZgBRQ4CsuGEqRn+knlK+QvubC6b35wmYzVteNLFs5eN
         eHZTvRkLVuO/WSzEeLTRHn7MfwppjnTeCjfxRB1hujUPLvODgMheEjv2UErA4UrtJZNw
         UhDg==
X-Gm-Message-State: AO0yUKUPn1G/OATaJptGvaMJ67ByeIoy5GHkBzA0rnuMMBo6EvtSMeKS
        95BeP2YKH/qcyX/io8rzSA==
X-Google-Smtp-Source: AK7set85Fr/64N9KeajUXci8m4jgyhP+/i2Yinfwq8mFdO068byhumKoIjoQQ4OEwMVGLZpL31ak1w==
X-Received: by 2002:a05:6830:3a10:b0:68b:d2c2:4430 with SMTP id di16-20020a0568303a1000b0068bd2c24430mr1533886otb.38.1676494398146;
        Wed, 15 Feb 2023 12:53:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u4-20020a9d4d84000000b0068d752f1870sm7896769otk.5.2023.02.15.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:53:17 -0800 (PST)
Received: (nullmailer pid 533048 invoked by uid 1000);
        Wed, 15 Feb 2023 20:53:17 -0000
Date:   Wed, 15 Feb 2023 14:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] media: dt-bindings: samsung,exynos4212-is:
 convert to dtschema
Message-ID: <20230215205317.GA529822-robh@kernel.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
 <20230214104508.51955-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214104508.51955-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:45:06AM +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
> bindings to DT schema.  Changes during conversion - adjust to existing
> DTS and Linux driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/exynos4-fimc-is.txt        |  50 ----
>  .../media/samsung,exynos4212-fimc-is.yaml     | 221 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 222 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt b/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
> deleted file mode 100644
> index 32ced99d4244..000000000000
> --- a/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -Exynos4x12 SoC series Imaging Subsystem (FIMC-IS)
> -
> -The FIMC-IS is a subsystem for processing image signal from an image sensor.
> -The Exynos4x12 SoC series FIMC-IS V1.5 comprises of a dedicated ARM Cortex-A5
> -processor, ISP, DRC and FD IP blocks and peripheral devices such as UART, I2C
> -and SPI bus controllers, PWM and ADC.
> -
> -fimc-is node
> -------------
> -
> -Required properties:
> -- compatible	: should be "samsung,exynos4212-fimc-is" for Exynos4212 and
> -		  Exynos4412 SoCs;
> -- reg		: physical base address and length of the registers set;
> -- interrupts	: must contain two FIMC-IS interrupts, in order: ISP0, ISP1;
> -- clocks	: list of clock specifiers, corresponding to entries in
> -		  clock-names property;
> -- clock-names	: must contain "ppmuispx", "ppmuispx", "lite0", "lite1"
> -		  "mpll", "sysreg", "isp", "drc", "fd", "mcuisp", "gicisp",
> -		  "pwm_isp", "mcuctl_isp", "uart", "ispdiv0", "ispdiv1",
> -		  "mcuispdiv0", "mcuispdiv1", "aclk200", "div_aclk200",
> -		  "aclk400mcuisp", "div_aclk400mcuisp" entries,
> -		  matching entries in the clocks property.
> -pmu subnode
> ------------
> -
> -Required properties:
> - - reg : must contain PMU physical base address and size of the register set.
> -
> -The following are the FIMC-IS peripheral device nodes and can be specified
> -either standalone or as the fimc-is node child nodes.
> -
> -i2c-isp (ISP I2C bus controller) nodes
> -------------------------------------------
> -
> -Required properties:
> -
> -- compatible	: should be "samsung,exynos4212-i2c-isp" for Exynos4212 and
> -		  Exynos4412 SoCs;
> -- reg		: physical base address and length of the registers set;
> -- clocks	: must contain gate clock specifier for this controller;
> -- clock-names	: must contain "i2c_isp" entry.
> -
> -For the above nodes it is required to specify a pinctrl state named "default",
> -according to the pinctrl bindings defined in ../pinctrl/pinctrl-bindings.txt.
> -
> -Device tree nodes of the image sensors' controlled directly by the FIMC-IS
> -firmware must be child nodes of their corresponding ISP I2C bus controller node.
> -The data link of these image sensors must be specified using the common video
> -interfaces bindings, defined in video-interfaces.txt.
> diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
> new file mode 100644
> index 000000000000..288f4bf3d44d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/samsung,exynos4212-fimc-is.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +description:
> +  The FIMC-IS is a subsystem for processing image signal from an image sensor.
> +  The Exynos4x12 SoC series FIMC-IS V1.5 comprises of a dedicated ARM Cortex-A5
> +  processor, ISP, DRC and FD IP blocks and peripheral devices such as UART, I2C
> +  and SPI bus controllers, PWM and ADC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos4212-fimc-is
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  clocks:
> +    maxItems: 21
> +
> +  clock-names:
> +    items:
> +      - const: lite0
> +      - const: lite1
> +      - const: ppmuispx
> +      - const: ppmuispmx
> +      - const: isp
> +      - const: drc
> +      - const: fd
> +      - const: mcuisp
> +      - const: gicisp
> +      - const: mcuctl_isp
> +      - const: pwm_isp
> +      - const: ispdiv0
> +      - const: ispdiv1
> +      - const: mcuispdiv0
> +      - const: mcuispdiv1
> +      - const: mpll
> +      - const: aclk200
> +      - const: aclk400mcuisp
> +      - const: div_aclk200
> +      - const: div_aclk400mcuisp
> +      - const: uart
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  iommus:
> +    maxItems: 4
> +
> +  iommu-names:
> +    items:
> +      - const: isp
> +      - const: drc
> +      - const: fd
> +      - const: mcuctl
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#size-cells':
> +    const: 1

Normally this is next to #address-cells.

> +
> +patternProperties:
> +  "^pmu@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Node representing the SoC's Power Management Unit (duplicated with the
> +      correct PMU node in the SoC).
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +  "^i2c-isp@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/i2c/i2c-controller.yaml#
> +    unevaluatedProperties: false
> +      #additionalProperties: false

??

> +    description:
> +      ISP I2C bus controller


