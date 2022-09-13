Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB715B6E67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiIMNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiIMNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:32:10 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5227CD0;
        Tue, 13 Sep 2022 06:32:09 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2714399otu.7;
        Tue, 13 Sep 2022 06:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I+ucQEKSvX9YOsHVXukRimqDti9pARbM+2lMpF+5sVw=;
        b=VYvXQv7GHFDxM44chGXnVCB86sQ49t4fmag4Fv+ZFWyb/2vd5JG+Y+7i/ONqR5k1r+
         UrNODBoSSsM7aum5DKeUt3RH5E3nWRH7DwgqUVCPMgCBD3Qp+k7DvP20my5yMEr7HaKn
         T25tqL6bBmt3kJ/ylEEdwjJK2Fz2k+wLaG5fbf7J7OFqvN18n2S+6c3kO0vxl8eq+N1+
         UIevMhPbCyUxX57wOv/cs0TACfOCgKBglmxlMz0fUDxEPk/Ivki6BKJVVdWPMkzZDMML
         ZA57bZ/7O6bwmCkWbeDa6lhdCO06Z59hSCD6vcDYoGTnY+cbrS6Br1CyNI7KMfxMZpHS
         /Q1A==
X-Gm-Message-State: ACgBeo2t/zulNJ5gQ0xu58ybsgUBULF0UDm4EUzFvi2MzZe/DVeSqq0v
        1wea3as5BRluB9x716KSxw==
X-Google-Smtp-Source: AA6agR5Sdatjw3/2OGeg7hmdKmuqP2x9bjcJr/HcdynCSVCCYMv6HOx4eLTpdeARTxIvD3Z5O/0EGQ==
X-Received: by 2002:a05:6830:608b:b0:638:d739:a18d with SMTP id by11-20020a056830608b00b00638d739a18dmr13301349otb.144.1663075928326;
        Tue, 13 Sep 2022 06:32:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a4aa544000000b0044b22632d51sm5313038oom.2.2022.09.13.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 06:32:08 -0700 (PDT)
Received: (nullmailer pid 3537975 invoked by uid 1000);
        Tue, 13 Sep 2022 13:32:07 -0000
Date:   Tue, 13 Sep 2022 08:32:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/10] arm64: dts: apple: Add initial
 t6000/t6001/t6002 DTs
Message-ID: <20220913133207.GA3500192-robh@kernel.org>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-7-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909135103.98179-7-j@jannau.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 03:50:59PM +0200, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> These SoCs are found in Apple devices with M1 Pro (t6000), M1 Max
> (t6001) and M1 Ultra (t6002).
> 
> t6000 is a cut-down version of t6001, so the former just includes the
> latter and disables the missing bits (This is currently just one PMGR
> node and all of its domains.
> 
> t6002 is two connected t6001 dies. The implementation seems to use
> t6001 with blocks disabled (mostly on the second die). MMIO addresses on
> the second die have a constant offset. The interrupt controller is
> multi-die aware. This setup can be represented in the device tree with
> two top level "soc" nodes. The MMIO offset is applied via "ranges" and
> devices are included with preproceesor macros to make the node labels
> unique and to specify the die number for the interrupt definition.
> 
> Device nodes are distributed over dtsi files based on whether they are
> present on both dies or just on the first die. The only execption is the
> NVMe controller which resides on the second die. Its nodes are in a
> separate file.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> 
> 
> ---
>  arch/arm64/boot/dts/apple/multi-die-cpp.h     |   23 +
>  arch/arm64/boot/dts/apple/t6000.dtsi          |   18 +
>  arch/arm64/boot/dts/apple/t6001.dtsi          |   63 +
>  arch/arm64/boot/dts/apple/t6002.dtsi          |  173 ++
>  arch/arm64/boot/dts/apple/t600x-common.dtsi   |  128 ++
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi     |  298 +++
>  arch/arm64/boot/dts/apple/t600x-dieX.dtsi     |  103 +
>  .../arm64/boot/dts/apple/t600x-gpio-pins.dtsi |   45 +
>  arch/arm64/boot/dts/apple/t600x-nvme.dtsi     |   42 +
>  arch/arm64/boot/dts/apple/t600x-pmgr.dtsi     | 2012 +++++++++++++++++
>  10 files changed, 2905 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
>  create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> 
> diff --git a/arch/arm64/boot/dts/apple/multi-die-cpp.h b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> new file mode 100644
> index 000000000000..153d89dd0ae1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT
> + *
> + * C preprocessor macros for t600x multi die support.
> + */
> +
> +#ifndef __DTS_APPLE_MULTI_DIE_CPP_H
> +#define __DTS_APPLE_MULTI_DIE_CPP_H
> +
> +#ifndef __stringify
> +/* copied from include/linux/stringify.h */

Which is dual licensed? Arguably, not big enough to matter.

> +#define __stringify_1(x...)     #x
> +#define __stringify(x...)       __stringify_1(x)
> +#endif
> +
> +#ifndef __concat
> +#define __concat_1(x, y...)     x ## y
> +#define __concat(x, y...)       __concat_1(x, y)
> +#endif
> +
> +#define DIE_NODE(a) __concat(a, DIE)
> +#define DIE_LABEL(a) __stringify(__concat(a, DIE))

Not a pattern we encourage in DT, but seems necessary here.

> +
> +#endif /* !__LINUX_STRINGIFY_H */
> diff --git a/arch/arm64/boot/dts/apple/t6000.dtsi b/arch/arm64/boot/dts/apple/t6000.dtsi
> new file mode 100644
> index 000000000000..89c3b211b116
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6000.dtsi
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple T6000 "M1 Pro" SoC
> + *
> + * Other names: H13J, "Jade Chop"
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/* This chip is just a cut down version of t6001, so include it and disable the missing parts */
> +
> +#include "t6001.dtsi"
> +
> +/ {
> +	compatible = "apple,t6000", "apple,arm-platform";
> +};
> +
> +/delete-node/ &pmgr_south;
> diff --git a/arch/arm64/boot/dts/apple/t6001.dtsi b/arch/arm64/boot/dts/apple/t6001.dtsi
> new file mode 100644
> index 000000000000..620b17e4031f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6001.dtsi
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple T6001 "M1 Max" SoC
> + *
> + * Other names: H13J, "Jade"
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/apple-aic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/apple.h>
> +
> +#include "multi-die-cpp.h"
> +
> +#include "t600x-common.dtsi"
> +
> +/ {
> +	compatible = "apple,t6001", "apple,arm-platform";
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges;
> +		nonposted-mmio;
> +
> +		// filled via templated includes at the end of the file
> +	};
> +};
> +
> +#define DIE
> +#define DIE_NO 0
> +
> +&{/soc} {
> +	#include "t600x-die0.dtsi"
> +	#include "t600x-dieX.dtsi"
> +	#include "t600x-nvme.dtsi"
> +};
> +
> +#include "t600x-gpio-pins.dtsi"
> +#include "t600x-pmgr.dtsi"
> +
> +#undef DIE
> +#undef DIE_NO
> +
> +
> +&aic {
> +	affinities {
> +		e-core-pmu-affinity {
> +			apple,fiq-index = <AIC_CPU_PMU_E>;
> +			cpus = <&cpu_e00 &cpu_e01>;
> +		};
> +
> +		p-core-pmu-affinity {
> +			apple,fiq-index = <AIC_CPU_PMU_P>;
> +			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
> +				&cpu_p10 &cpu_p11 &cpu_p12 &cpu_p13>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
> new file mode 100644
> index 000000000000..32c971c0e191
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6002.dtsi
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple T6002 "M1 Ultra" SoC
> + *
> + * Other names: H13J, "Jade 2C"
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/apple-aic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/apple.h>
> +
> +#include "multi-die-cpp.h"
> +
> +#include "t600x-common.dtsi"
> +
> +/ {
> +	compatible = "apple,t6002", "apple,arm-platform";
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		cpu_e10: cpu@800 {
> +			compatible = "apple,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x800>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_e11: cpu@801 {
> +			compatible = "apple,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x801>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p20: cpu@10900 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10900>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p21: cpu@10901 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10901>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p22: cpu@10902 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10902>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p23: cpu@10903 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10903>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p30: cpu@10a00 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10a00>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p31: cpu@10a01 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10a01>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p32: cpu@10a02 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10a02>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +
> +		cpu_p33: cpu@10a03 {
> +			compatible = "apple,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10a03>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};
> +	};
> +
> +	die0: soc@0 {

Where does 0 come from? 

Unit address comes from 'reg' or 'ranges'. Empty ranges here means all 
of the address space is part of this node which obviously is not true 
given the next node. You need a 1:1 non-empty ranges entry.

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		nonposted-mmio;
> +
> +		// filled via templated includes at the end of the file
> +	};
> +
> +	die1: soc@1 {

soc@2200000000

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x2 0x0 0x22 0x0 0x4 0x0>,
> +				<0x7 0x0 0x27 0x0 0xf 0x80000000>;
> +		nonposted-mmio;
> +
> +		// filled via templated includes at the end of the file
> +	};
> +};
> +
> +#define DIE
> +#define DIE_NO 0
> +
> +&die0 {
> +	#include "t600x-die0.dtsi"

Looks like this one is not templated, so it doesn't really need to be 
here. But it's fine.

> +	#include "t600x-dieX.dtsi"
> +};
> +
> +#include "t600x-pmgr.dtsi"
> +#include "t600x-gpio-pins.dtsi"
> +
> +#undef DIE
> +#undef DIE_NO
> +
> +#define DIE _die1
> +#define DIE_NO 1
> +
> +&die1 {
> +	#include "t600x-dieX.dtsi"
> +	#include "t600x-nvme.dtsi"
> +};
> +
> +#include "t600x-pmgr.dtsi"
> +
> +#undef DIE
> +#undef DIE_NO
> +
> +
> +&aic {
> +	affinities {
> +		e-core-pmu-affinity {
> +			apple,fiq-index = <AIC_CPU_PMU_E>;
> +			cpus = <&cpu_e00 &cpu_e01
> +				&cpu_e10 &cpu_e11>;
> +		};
> +
> +		p-core-pmu-affinity {
> +			apple,fiq-index = <AIC_CPU_PMU_P>;
> +			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
> +				&cpu_p10 &cpu_p11 &cpu_p12 &cpu_p13
> +				&cpu_p20 &cpu_p21 &cpu_p22 &cpu_p23
> +				&cpu_p30 &cpu_p31 &cpu_p32 &cpu_p33>;
> +		};
> +	};
> +};
