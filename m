Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550BC6DDCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjDKNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDKNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:55:21 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15210FE;
        Tue, 11 Apr 2023 06:55:20 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id bx42so21879299oib.6;
        Tue, 11 Apr 2023 06:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221320; x=1683813320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZO7ezzSE2J/Q6kfu0V6nhJj8JV4tY/GZHsr0viCIQg=;
        b=c++ag5pBCNz4L1Tgzj30Xtv9a9hOOu+kxW4Dnazck9f0YT2ZqmmKIf/RwWiGJRz+0Y
         jUh8BSZ4tPm4nmUUhBbi9kllgKjGND48nYlpcjsVj/yhdFndwmqIr6QjmQTnCjwlMvG+
         YyKL7WT+ArZAOjaBULRs1zVPn5e4u6Wvak/UVr6Y6OAaIgvrIg5mvLIGAD6jKzJ0vIfW
         wWS3b2cL5mBX6IN/yqCL94Lr7OfLPzx3nL49v3z4qjS4ejIoWdB9avfrOQssV0nMi2QS
         1xqItxnnJ4pOVw2CsIeaIh5V6QtQ0xPrMe1YnxWCI/1DFv8TKP8ikLzyeuShmnjqXYpg
         yr7Q==
X-Gm-Message-State: AAQBX9cCzeKHwyuZAoxX5JFgzvT+Qwvg5wO/GbIgvd3vTp+lBvqIIEuE
        5wcYsfW9EkJV/bieZr32eQ==
X-Google-Smtp-Source: AKy350Zknu9XdcP66k0cfxAwCQD/B6DUAgh2awz+0hWaJCNQBE/oSeXwvEvVidCKbiEVzCNEA+x/Kg==
X-Received: by 2002:a05:6808:8e:b0:387:2075:59c with SMTP id s14-20020a056808008e00b003872075059cmr5793228oic.37.1681221320010;
        Tue, 11 Apr 2023 06:55:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i128-20020acaea86000000b00386eff32f58sm5587706oih.13.2023.04.11.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:55:19 -0700 (PDT)
Received: (nullmailer pid 2960222 invoked by uid 1000);
        Tue, 11 Apr 2023 13:55:18 -0000
Date:   Tue, 11 Apr 2023 08:55:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v13 08/15] arm64: dts: Add AMD Pensando Elba SoC support
Message-ID: <20230411135518.GA2952600-robh@kernel.org>
References: <20230410184526.15990-1-blarson@amd.com>
 <20230410184526.15990-9-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410184526.15990-9-blarson@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:45:19AM -0700, Brad Larson wrote:
> Add AMD Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v11 changes:
> - Delete reset-names
> - Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'
> 
> v9 changes:
> - Single node for spi0 system-controller and squash
>   the reset-controller child into parent

Have you run this thru 'make dtbs_check'? I see at least one issue that 
should report.

> ---
>  arch/arm64/boot/dts/amd/Makefile              |   1 +
>  arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 +++++++++++++++++
>  arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  80 ++++++++
>  arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
>  arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
>  arch/arm64/boot/dts/amd/elba.dtsi             | 191 ++++++++++++++++++
>  6 files changed, 595 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
> index 68103a8b0ef5..8502cc2afbc5 100644
> --- a/arch/arm64/boot/dts/amd/Makefile
> +++ b/arch/arm64/boot/dts/amd/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
>  dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
> diff --git a/arch/arm64/boot/dts/amd/elba-16core.dtsi b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> new file mode 100644
> index 000000000000..37aadd442db8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 { cpu = <&cpu0>; };
> +				core1 { cpu = <&cpu1>; };
> +				core2 { cpu = <&cpu2>; };
> +				core3 { cpu = <&cpu3>; };
> +			};
> +
> +			cluster1 {
> +				core0 { cpu = <&cpu4>; };
> +				core1 { cpu = <&cpu5>; };
> +				core2 { cpu = <&cpu6>; };
> +				core3 { cpu = <&cpu7>; };
> +			};
> +
> +			cluster2 {
> +				core0 { cpu = <&cpu8>; };
> +				core1 { cpu = <&cpu9>; };
> +				core2 { cpu = <&cpu10>; };
> +				core3 { cpu = <&cpu11>; };
> +			};
> +
> +			cluster3 {
> +				core0 { cpu = <&cpu12>; };
> +				core1 { cpu = <&cpu13>; };
> +				core2 { cpu = <&cpu14>; };
> +				core3 { cpu = <&cpu15>; };
> +			};
> +		};
> +
> +		/* CLUSTER 0 */
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x0>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x1>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x2>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x3>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		/* CLUSTER 1 */
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x100>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x101>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x102>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0 0x103>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";

This is missing properties. If you don't see warnings, update dtschema.

Rob
