Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6068F75F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBHSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:47:05 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DA34015;
        Wed,  8 Feb 2023 10:47:03 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id r28so16331922oiw.3;
        Wed, 08 Feb 2023 10:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQR2OeB8GdBCvZmYBsmELI/in0H1BRjqllMiTjr8o4E=;
        b=mWtDEood+9nld7c1om7liZEr4tVYVevRPK2/KtSjmpi44u4vSJxdH2Bi3tDMImNiBf
         POQofK6cTtWoh3005bPszWjaRA61XR9iNk3VN163oQYH8g0L5la4mgL7jHCHv76IkFO2
         y4iyqezQdaGrZs+3kgLe6WWM6v4UDNWe0hdcinRgaN/cEd0H8c79LiX51kLLnNz0x1qC
         DTN9wrPZbQSY1Gf8MJRNFtj/G3SGrL4HPzM3cF0NJa2B2RceC1nWap0zbr6Us5Ti0kXy
         8atDDq9zWPHf1gt8O2Vy+n9QkkyuHD3cwjkjENCUdXHa4Sxhyo3mxlqXQ8N46IthZhc6
         i+TQ==
X-Gm-Message-State: AO0yUKUPT10yq2UPXZYJKHBQJLxhJ8MSml3HrXnjMGugqBECWlxLayWA
        YvUkpzecPUUtncjsJg8+lndHumcFzw==
X-Google-Smtp-Source: AK7set/Wmm4AaqO3KoD2uZ7O0ObyLfRs5KnmQKQ6NcHQ157U89avSKm6u1QJkXXi9mhxHe/O3HQtOQ==
X-Received: by 2002:a05:6808:92:b0:364:98ca:efb0 with SMTP id s18-20020a056808009200b0036498caefb0mr3423802oic.6.1675882022184;
        Wed, 08 Feb 2023 10:47:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s191-20020acaa9c8000000b003631fe1810dsm7371066oie.47.2023.02.08.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:47:01 -0800 (PST)
Received: (nullmailer pid 2296664 invoked by uid 1000);
        Wed, 08 Feb 2023 18:46:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        - <patches@opensource.cirrus.com>, devicetree@vger.kernel.org
In-Reply-To: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
Message-Id: <167588125123.2283195.8694738903913228349.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Date:   Wed, 08 Feb 2023 12:46:59 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 18:25:52 +0100, Krzysztof Kozlowski wrote:
> Convert the Wolfson WM1811/WM8994/WM8958 audio codecs bindings to DT
> schema.
> 
> Changes against original binding:
> 1. Add missing LDO1VDD-supply for WM1811.
> 2. Use "gpios" suffix for wlf,ldo1ena and wlf,ldo2ena (Linux kernel's
>    gpiolib already looks for both variants).
> 3. Do not require AVDD1-supply and DCVDD-supply, because at least on
>    Arndale board with Exynos5250 these are grounded.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/wlf,wm8994.yaml | 203 ++++++++++++++++++
>  .../devicetree/bindings/sound/wm8994.txt      | 112 ----------
>  2 files changed, 203 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8994.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230208172552.404324-1-krzysztof.kozlowski@linaro.org


audio-codec@1a: 'AVDD1-supply' is a required property
	arch/arm/boot/dts/exynos5250-smdk5250.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb

audio-codec@1a: 'DCVDD-supply' is a required property
	arch/arm/boot/dts/exynos5250-smdk5250.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb

audio-codec@1a: Unevaluated properties are not allowed ('wlf,ldo1ena', 'wlf,ldo2ena' were unexpected)
	arch/arm/boot/dts/exynos4412-i9300.dtb
	arch/arm/boot/dts/exynos4412-i9305.dtb
	arch/arm/boot/dts/exynos4412-n710x.dtb
	arch/arm/boot/dts/exynos4412-trats2.dtb
	arch/arm/boot/dts/exynos5250-arndale.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb

