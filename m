Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00E672D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjASAYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASAYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:24:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30D5FD48;
        Wed, 18 Jan 2023 16:24:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B76CB81FB5;
        Thu, 19 Jan 2023 00:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C560C433EF;
        Thu, 19 Jan 2023 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674087851;
        bh=cPBBDTVYOeHVuunHHatoNAwf1qLf1n97Ngqnf5A4Nzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJLOYaTyKihG3Ec0hW7apYEAw7/K/gSnnY1P2ss42LjXQtE+Rfn2MyL0McCpXukGe
         /pfDL92ScqNmPqCC063w+SqiwYnkBVE84+O35cfku6CG8Ymj06tdjftJs1Pl7bkBsv
         DTLAMw3PfDzaGbU24+VuN255KY/2RjXGa2kqf2b5oXwBeNdqAZGsL5kdamXd+mDvuU
         fXq7bu/EKfL1CQmKLWRVMPmjvfEFwwWauh5779FtsWJWqKfKPyPWO4I3x1Y/RXcOKb
         Norp+e+f8wx2VdCbmdkvP/WRaiD7b0WB1ydH6Jfgqd17JA0l83XF9O0gTWnRAicS3R
         NwGOt4ReXld2A==
Date:   Wed, 18 Jan 2023 18:24:09 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Yang Xiwen <forbidden405@foxmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device
 tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Message-ID: <20230119002409.2neba7eczftdxkc4@builder.lan>
References: <20230110155014.31664-1-forbidden405@foxmail.com>
 <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:50:14PM +0800, Yang Xiwen wrote:
> This commit adds support for the ufi-001C and uf896 WiFi/LTE dongle made by
> unknown manufactures based on MSM8916.
> uf896 is another variant for the zhihe usb stick. The board design
> difers by using different gpios for the keys and leds.
> 
> Note: The original firmware does not support 64-bit OS. It is necessary
> to flash 64-bit TZ firmware to boot arm64.
> 
> Currently supported:
> - All CPU cores
> - Buttons
> - LEDs
> - Modem
> - SDHC
> - USB Device Mode
> - UART
> 
> Co-developed-by: Jaime Breva <jbreva@nayarsystems.com>
> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
> Co-developed-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../boot/dts/qcom/msm8916-zhihe-uf896.dts     |  41 +++
>  .../boot/dts/qcom/msm8916-zhihe-ufi001c.dts   |  39 +++
>  arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi   | 246 ++++++++++++++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b42362c7be1bf..7abc7bb19c9fc 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-zhihe-uf896.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-zhihe-ufi001c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
> new file mode 100644
> index 0000000000000..2ddceb1d8b210
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-zhihe.dtsi"
> +
> +/ {
> +	model = "uf896 4G Modem Stick";
> +	compatible = "zhihe,uf896", "qcom,msm8916";
> +};
> +
> +&button_restart {

Please sort nodes alphabetically.

> +	gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> +};
> +
> +&led_r {
> +	gpios = <&msmgpio 82 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_g {
> +	gpios = <&msmgpio 83 GPIO_ACTIVE_HIGH>;
> +	function = LED_FUNCTION_WLAN;
> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
> +	function = LED_FUNCTION_WAN;
> +};
> +
> +&button_default {
> +	pins = "gpio35";
> +	bias-pull-up;
> +};
> +
> +&gpio_leds_default {
> +	pins = "gpio81", "gpio82", "gpio83";
> +};
> +
> +&sim_ctrl_default {
> +	pins = "gpio1", "gpio2";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
> new file mode 100644
> index 0000000000000..715874a2b8650
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-zhihe.dtsi"
> +
> +/ {
> +	model = "ufi-001c/ufi-001b 4G Modem Stick";
> +	compatible = "zhihe,ufi001c", "qcom,msm8916";
> +};
> +
> +&button_restart {
> +	gpios = <&msmgpio 37 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_r {
> +	gpios = <&msmgpio 22 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_g {
> +	gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&button_default {

Same here, please sort alphabetically.

Regards,
Bjorn
