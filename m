Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B945E78AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiIWKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiIWKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:50:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0389091D17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:50:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372BC176A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:50:17 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FBCB3F73D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:50:10 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:49:55 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: arm: unify DT license statements
Message-ID: <Yy2PUx+mfi2/iVDl@e110455-lin.cambridge.arm.com>
References: <20220922142010.1412640-1-andre.przywara@arm.com>
 <20220922142010.1412640-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922142010.1412640-2-andre.przywara@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:20:08PM +0100, Andre Przywara wrote:
> Many devicetree files for Arm Ltd. arm64 boards did not contain a
> license statement. Some just got a blanket GPL-2.0 tag by a script,
> confirming the default license for files in the kernel tree.
> 
> Add an explicit SPDX license tag for every file, at the beginning.
> Also extend the license to include a BSD compatible license, as it's
> customary and recommended for DT files.
> For files without an explicit history license-wise, this is MIT,
> otherwise we keep the BSD (2-clause) license that some files already
> carried.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi      | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts  | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts       | 2 +-
>  arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi      | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8-psci.dts        | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi       | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi | 1 +
>  arch/arm64/boot/dts/arm/foundation-v8.dts             | 2 +-
>  arch/arm64/boot/dts/arm/foundation-v8.dtsi            | 2 +-
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts             | 2 +-
>  arch/arm64/boot/dts/arm/juno-base.dtsi                | 2 +-
>  arch/arm64/boot/dts/arm/juno-clocks.dtsi              | 3 +--
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi             | 2 +-
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi         | 3 +--
>  arch/arm64/boot/dts/arm/juno-r1-scmi.dts              | 1 +
>  arch/arm64/boot/dts/arm/juno-r1.dts                   | 3 +--
>  arch/arm64/boot/dts/arm/juno-r2-scmi.dts              | 1 +
>  arch/arm64/boot/dts/arm/juno-r2.dts                   | 3 +--
>  arch/arm64/boot/dts/arm/juno-scmi.dts                 | 1 +
>  arch/arm64/boot/dts/arm/juno-scmi.dtsi                | 1 +
>  arch/arm64/boot/dts/arm/juno.dts                      | 3 +--
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts            | 2 +-
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi  | 2 +-
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi      | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts  | 2 +-
>  25 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
> index 655fdcce15614..53fa6b9fd86fb 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
> index e096e670bec3c..32c16d7f216ab 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
> index c87380e87f595..e1426de132560 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
> index e4a3c7dbcc20c..dd2d305b53393 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
> index 723f23c7cd31a..1d6c6bcb08cdd 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
> index 16cdf395728bc..f9589905dc024 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
> index 4d4186ba0e8c1..6796bbb5eef05 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
> index b17347d75ec60..a73bf774c7603 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> index 83e3e7e3984fc..152bc7f0f37cb 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd.
>   *
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index 5f6f30c801a7f..45cef48378d07 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd. Fast Models
>   *
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 2f27619d8abd5..5f89d984b031e 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  #include "juno-clocks.dtsi"
>  #include "juno-motherboard.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> index 2870b5eeb1984..27aec6425512b 100644
> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  /*
>   * ARM Juno Platform clocks
>   *
>   * Copyright (c) 2013-2014 ARM Ltd
>   *
> - * This file is licensed under a dual GPLv2 or BSD license.
> - *
>   */
>  / {
>  	/* SoC fixed clocks */
> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> index 09d2b692e9e1f..4299287e1e284 100644
> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  / {
>  	funnel@20130000 { /* cssys1 */
>  		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index be42932f7e21e..21f84a34f6ff0 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  /*
>   * ARM Juno Platform motherboard peripherals
>   *
>   * Copyright (c) 2013-2014 ARM Ltd
>   *
> - * This file is licensed under a dual GPLv2 or BSD license.
> - *
>   */
>  
>  / {
> diff --git a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
> index dd9ea69f086f8..e63543c624f4a 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  #include "juno-r1.dts"
>  #include "juno-scmi.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index 6451c62146fda..9253ca28e8fa5 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  /*
>   * ARM Ltd. Juno Platform
>   *
>   * Copyright (c) 2015 ARM Ltd.
> - *
> - * This file is licensed under a dual GPLv2 or BSD license.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
> index de2cbac1d1c3e..6c80f08b3ec2e 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  #include "juno-r2.dts"
>  #include "juno-scmi.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
> index 438cd1ff4bd08..2545bc79158f1 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2.dts
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  /*
>   * ARM Ltd. Juno Platform
>   *
>   * Copyright (c) 2015 ARM Ltd.
> - *
> - * This file is licensed under a dual GPLv2 or BSD license.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dts b/arch/arm64/boot/dts/arm/juno-scmi.dts
> index 41588fa46d317..51844a407a7dd 100644
> --- a/arch/arm64/boot/dts/arm/juno-scmi.dts
> +++ b/arch/arm64/boot/dts/arm/juno-scmi.dts
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  #include "juno.dts"
>  #include "juno-scmi.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> index ec85cd2c733ce..c6f4b80d3dff0 100644
> --- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  / {
>  	etf@20010000 {
>  		power-domains = <&scmi_devpd 8>;
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index cf4a582113999..270505339eecd 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  /*
>   * ARM Ltd. Juno Platform
>   *
>   * Copyright (c) 2013-2014 ARM Ltd.
> - *
> - * This file is licensed under a dual GPLv2 or BSD license.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> index 258991ad7cc0a..5b514c865845d 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd. Fast Models
>   *
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> index ec2d5280a30b1..9dd155ef09ab3 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd. Fast Models
>   *
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index ba8beef3fe99e..5f8f17d6c8e59 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd. Fast Models
>   *
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index 5b6d9d8e934db..8cb44b0577ca5 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * ARM Ltd. Versatile Express
>   *
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
