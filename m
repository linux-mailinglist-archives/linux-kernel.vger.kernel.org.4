Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342F721976
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjFDTPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:15:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31852A4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:15:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso6060440a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685906137; x=1688498137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oH9Cr0aed9+SlGFSxcuX+CM/ZuPzolXMmmuHZioD1Hw=;
        b=M3lclyEwwgmcfweqqFKYlO/pXrx5sqR43R8US5cgUcuQhYgXTxTBH8bnmoz+xOxQ2x
         Qww5rcE2NpTNCTpfUf5lWWC+vIqXTCNNcE/fUOjDtZhvG5ZIzvrMpuMi/f6M+y2dVp9i
         s0poQ0QHk+JdzLZeEy4BiP0LPnClqeazR+Pi7c89GerlRJu8hA9D/NV6Yo2jURUrtXe7
         6frzkKUcbwyBWYBLiv4QSu0/sJ2P2ZUqmdD0NtwOD8CN3Lnos87LuMEExUGb4lI6KGId
         53mruOVpbKZmf4ArPdMAeACMFiGST6DhgYMSa5Ku0aktXjiL8VWIQKTNY2F1oiPrM07L
         XyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685906137; x=1688498137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH9Cr0aed9+SlGFSxcuX+CM/ZuPzolXMmmuHZioD1Hw=;
        b=d+LXCLwWw2rfcqVcLfFkvQy+F1RxdjvGJm19hyW78Xs8E9YwlfKxiUUvjNzzIAHkuP
         oJcl+IOOGedd1JwFfAxAGzxZ88Xa/CrSxYxiYbtzx9s1L6DWYBXiM7m7jjbCwgOQzHOA
         Ho2ZlYzLndwZaDbGMY0zhSmtFvoCKfTpuaV8zuau5ST0wSP4i+c8Ulj1LV38d66wVrui
         fQVxGz0t97zN+x+dsiaa9mYECebZfH2UVfRFkTkfPtsxyIMccY+0/UF+lTneGz+dzNRV
         zVTXKPQfRyczgwShZoEdSWp5UiPFY1V3TSA8b5UFUVjLbQjXmGK+FVuBPWepXnPLRE/O
         p91g==
X-Gm-Message-State: AC+VfDyqQYYwPIf5wjytVU+ltANDszBCetyhRBnPrweVn5yXTfmHzGNg
        QKoqF0RFQUCp8vN4+A8ewyFVK4PFMUujQwBIfiI=
X-Google-Smtp-Source: ACHHUZ7Ksh/PEECYfIW7+cnMnPoU2N/J0/a3hIXQ3RDFnmAk+dCPnK6b0/p2X6w6QuFk8miSunoa5A==
X-Received: by 2002:a17:907:1607:b0:96a:6c64:8066 with SMTP id hb7-20020a170907160700b0096a6c648066mr5595587ejc.4.1685906137605;
        Sun, 04 Jun 2023 12:15:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b0097461fecc91sm3335292ejt.81.2023.06.04.12.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 12:15:37 -0700 (PDT)
Message-ID: <aae10e8f-b4f2-7417-ab08-41d6ec9ab8fc@linaro.org>
Date:   Sun, 4 Jun 2023 21:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230604165627.16963-1-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230604165627.16963-1-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 18:56, Artur Weber wrote:
> Introduce support for the Galaxy Tab 3 8.0 series of boards:
> 
>  - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>  - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>  - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
> 
> What works:
> 
>  - Display and backlight
>  - Touchscreen
>  - GPIO buttons, hall sensor
>  - WiFi and Bluetooth
>  - USB, fuel gauge, charging
>  - Accelerometer and magnetometer
>  - Audio: speaker, microphone, headset
>  - WiFi model only: light sensor
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> This is an updated version of "[PATCH v3 13/13] ARM: dts: exynos: Add Samsung
> Galaxy Tab 3 8.0 boards"[1].
> 
> Changed in v4:
> - Added touchkey keycodes
> - Added audio nodes
> - Added MMC aliases
> - Fixed dtbs_check warnings
> - Fixed indentation in pinctrl sleep state overrides
> 
> Changed in v3:
>  - Addressed review comments
>  - Removed rtc node (RTC is provided by PMIC)
>  - Added CPU thermal node
>  - Fixed dtbs_check warnings
>  - Added common changes from next/dt
> 
> Should pass dtbs_check with no errors, provided that the following patches
> are present:
> 
> Backlight node is adapted to changes from "[PATCH v2 1/4] dt-bindings:
> backlight: lp855x: convert to YAML and modernize"[2]. The whole patchset
> has been reviewed, waiting for any further reviews or a merge.
> 
> Touchkey keycode property is added by "[PATCH 1/2] dt-bindings: mms114: Add
> linux,keycodes property for touch keys"[3]. So far only the bindings part
> of the patch has been acked, otherwise everything is awaiting review.
> 
> Display bindings have been added by "[PATCH v5 1/3] dt-bindings: display:
> panel: Add Samsung S6D7AA0 LCD panel controller"[4]. These are already
> reviewed and merged into the DRM tree.
> 
> [1] https://lore.kernel.org/linux-devicetree/20230501195525.6268-14-aweber.kernel@gmail.com/
> [2] https://lore.kernel.org/linux-devicetree/20230519180728.2281-2-aweber.kernel@gmail.com/
> [3] https://lore.kernel.org/linux-devicetree/20230521145843.19489-2-aweber.kernel@gmail.com/
> [4] https://lore.kernel.org/linux-devicetree/20230519170354.29610-2-aweber.kernel@gmail.com/
> ---
>  arch/arm/boot/dts/Makefile                  |    3 +
>  arch/arm/boot/dts/exynos4212-tab3-3g8.dts   |   29 +
>  arch/arm/boot/dts/exynos4212-tab3-lte8.dts  |   44 +
>  arch/arm/boot/dts/exynos4212-tab3-wifi8.dts |   26 +
>  arch/arm/boot/dts/exynos4212-tab3.dtsi      | 1303 +++++++++++++++++++
>  5 files changed, 1405 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..6a4ca481171e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -217,6 +217,9 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
>  	exynos4210-universal_c210.dtb \
> +	exynos4212-tab3-3g8.dtb \
> +	exynos4212-tab3-lte8.dtb \
> +	exynos4212-tab3-wifi8.dtb \
>  	exynos4412-i9300.dtb \
>  	exynos4412-i9305.dtb \
>  	exynos4412-itop-elite.dtb \
> diff --git a/arch/arm/boot/dts/exynos4212-tab3-3g8.dts b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
> new file mode 100644
> index 000000000000..d96b2dd44608
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 3G board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 3G (SM-T311) based on Exynos4212";
> +	compatible = "samsung,t311", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +/* Pin control sleep state overrides */
> +&sleep0 {
> +	PIN_SLP(gpb-5, INPUT, UP);
> +};
> +
> +&sleep1 {
> +	PIN_SLP(gpl0-0, OUT0, NONE);
> +	PIN_SLP(gpl1-0, OUT0, NONE);
> +	PIN_SLP(gpl2-4, OUT0, NONE);
> +	PIN_SLP(gpm3-3, OUT1, NONE);
> +};
> diff --git a/arch/arm/boot/dts/exynos4212-tab3-lte8.dts b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
> new file mode 100644
> index 000000000000..bbb398eca7b0
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 LTE board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 LTE (SM-T315) based on Exynos4212";
> +	compatible = "samsung,t315", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +/* Pin control sleep state overrides */
> +&sleep0 {
> +	PIN_SLP(gpa0-4, INPUT, UP);
> +	PIN_SLP(gpa0-5, INPUT, UP);
> +
> +	PIN_SLP(gpb-5, INPUT, UP);
> +
> +	PIN_SLP(gpc0-0, PREV, NONE);
> +	PIN_SLP(gpc1-3, INPUT, NONE);
> +
> +	PIN_SLP(gpf1-6, INPUT, NONE);
> +	PIN_SLP(gpf2-2, PREV, NONE);
> +};
> +
> +&sleep1 {
> +	PIN_SLP(gpl0-0, PREV, NONE);
> +
> +	PIN_SLP(gpl1-0, PREV, NONE);
> +
> +	PIN_SLP(gpl2-1, INPUT, DOWN);
> +	PIN_SLP(gpl2-2, INPUT, DOWN);
> +	PIN_SLP(gpl2-4, OUT0, NONE);
> +	PIN_SLP(gpl2-5, PREV, NONE);
> +
> +	PIN_SLP(gpm3-3, OUT1, NONE);
> +};
> diff --git a/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts b/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
> new file mode 100644
> index 000000000000..54cb01703b60
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 WiFi board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 WiFi (SM-T310) based on Exynos4212";
> +	compatible = "samsung,t310", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +&i2c_lightsensor {
> +	status = "okay";
> +
> +	lightsensor@10 {
> +		compatible = "capella,cm3323";
> +		reg = <0x10>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos4212-tab3.dtsi b/arch/arm/boot/dts/exynos4212-tab3.dtsi
> new file mode 100644
> index 000000000000..e014100e11f8
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3.dtsi
> @@ -0,0 +1,1303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 board common source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212.dtsi"
> +#include "exynos4412-ppmu-common.dtsi"
> +#include "exynos-mfc-reserved-memory.dtsi"
> +#include <dt-bindings/clock/samsung,s2mps11.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "exynos-pinctrl.h"
> +
> +/*
> + * This device does not use the built-in RTC; instead, the RTC in the
> + * S5M8786 PMIC is used instead. Remove the unused node to avoid DTB check
> + * warnings.
> + */
> +/delete-node/ &rtc;

This is not the solution. The S3C RTC is there. Just like all other
boards we have two RTCs and DTS should be complete. Definitely you
should not remove something just because there were warnings. Instead
warnings should be fixed.

Best regards,
Krzysztof

