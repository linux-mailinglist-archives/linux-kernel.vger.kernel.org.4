Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CA7298F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjFIMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbjFIMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:04:45 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A7198C;
        Fri,  9 Jun 2023 05:04:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2C7C95FD8E;
        Fri,  9 Jun 2023 15:04:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686312279;
        bh=PoZBn2oXWEbJPcRQYcnnU4ZFnn3DCCoCXhdS+GaFOf8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=k17c/BFkgY9tJE2KtwrS4UwCNcPzeZI9BKnEQ3pzsCPOdispWOcN1X1O0qXdudHnJ
         moxswhJLs/2bWHN91Pd6buGUWEobQhL8Uug/z4y9Ai7/5rBm2xYmVumjEEe8LwsEk+
         qSHumeNbMOPyQD/N/BP5EWMGP9DneZVHyPyxo5tjMAPCHCCcHwtvOAwN6YudLz9MKh
         Yj6X0IBIjo11eY/KtzX7A0NkcO1FR8YcNb8xh7YZbe2IEvPiv2UlqZ1v0cHZgl573o
         4oAZLAhl9C+3jLLM1A0qiT/MODPVCR2lW19XRisejD3k3CJny7pgHYnb3/b67lYaS3
         TaBPfRCV3cBDQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  9 Jun 2023 15:04:38 +0300 (MSK)
Date:   Fri, 9 Jun 2023 15:04:38 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 11/18] dt-bindings: clk: amlogic,a1-peripherals-clkc:
 expose all clock ids
Message-ID: <20230609120438.n7wnrpiqusasbly4@CAB-WSD-L081021>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-11-9676afa6b22c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-11-9676afa6b22c@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/09 07:08:00 #21465535
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

On Wed, Jun 07, 2023 at 12:56:22PM +0200, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every A1 peripherals ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 
> [1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> [2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/a1-peripherals.h                 | 63 ----------------------
>  .../clock/amlogic,a1-peripherals-clkc.h            | 53 ++++++++++++++++++
>  2 files changed, 53 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
> index 4d60456a95a9..842b52634ed0 100644
> --- a/drivers/clk/meson/a1-peripherals.h
> +++ b/drivers/clk/meson/a1-peripherals.h
> @@ -46,67 +46,4 @@
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>  
> -/*
> - * CLKID index values for internal clocks
> - *
> - * These indices are entirely contrived and do not map onto the hardware.
> - * It has now been decided to expose everything by default in the DT header:
> - * include/dt-bindings/clock/a1-peripherals-clkc.h.
> - * Only the clocks ids we don't want to expose, such as the internal muxes and
> - * dividers of composite clocks, will remain defined here.
> - */
> -#define CLKID_XTAL_IN		0
> -#define CLKID_DSPA_SEL		61
> -#define CLKID_DSPB_SEL		62
> -#define CLKID_SARADC_SEL	74
> -#define CLKID_SYS_A_SEL		89
> -#define CLKID_SYS_A_DIV		90
> -#define CLKID_SYS_A		91
> -#define CLKID_SYS_B_SEL		92
> -#define CLKID_SYS_B_DIV		93
> -#define CLKID_SYS_B		94
> -#define CLKID_DSPA_A_DIV	96
> -#define CLKID_DSPA_A		97
> -#define CLKID_DSPA_B_DIV	99
> -#define CLKID_DSPA_B		100
> -#define CLKID_DSPB_A_DIV	102
> -#define CLKID_DSPB_A		103
> -#define CLKID_DSPB_B_DIV	105
> -#define CLKID_DSPB_B		106
> -#define CLKID_RTC_32K_IN	107
> -#define CLKID_RTC_32K_DIV	108
> -#define CLKID_RTC_32K_XTAL	109
> -#define CLKID_RTC_32K_SEL	110
> -#define CLKID_CECB_32K_IN	111
> -#define CLKID_CECB_32K_DIV	112
> -#define CLKID_CECA_32K_IN	115
> -#define CLKID_CECA_32K_DIV	116
> -#define CLKID_DIV2_PRE		119
> -#define CLKID_24M_DIV2		120
> -#define CLKID_GEN_DIV		122
> -#define CLKID_SARADC_DIV	123
> -#define CLKID_PWM_A_DIV		125
> -#define CLKID_PWM_B_DIV		127
> -#define CLKID_PWM_C_DIV		129
> -#define CLKID_PWM_D_DIV		131
> -#define CLKID_PWM_E_DIV		133
> -#define CLKID_PWM_F_DIV		135
> -#define CLKID_SPICC_SEL		136
> -#define CLKID_SPICC_DIV		137
> -#define CLKID_SPICC_SEL2	138
> -#define CLKID_TS_DIV		139
> -#define CLKID_SPIFC_SEL		140
> -#define CLKID_SPIFC_DIV		141
> -#define CLKID_SPIFC_SEL2	142
> -#define CLKID_USB_BUS_SEL	143
> -#define CLKID_USB_BUS_DIV	144
> -#define CLKID_SD_EMMC_SEL	145
> -#define CLKID_SD_EMMC_DIV	146
> -#define CLKID_PSRAM_SEL		148
> -#define CLKID_PSRAM_DIV		149
> -#define CLKID_PSRAM_SEL2	150
> -#define CLKID_DMC_SEL		151
> -#define CLKID_DMC_DIV		152
> -#define CLKID_DMC_SEL2		153
> -
>  #endif /* __A1_PERIPHERALS_H */
> diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> index ff2730f398a6..06f198ee7623 100644
> --- a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> +++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> @@ -10,6 +10,7 @@
>  #ifndef __A1_PERIPHERALS_CLKC_H
>  #define __A1_PERIPHERALS_CLKC_H
>  
> +#define CLKID_XTAL_IN		0
>  #define CLKID_FIXPLL_IN		1
>  #define CLKID_USB_PHY_IN	2
>  #define CLKID_USB_CTRL_IN	3
> @@ -70,6 +71,8 @@
>  #define CLKID_CPU_CTRL		58
>  #define CLKID_ROM		59
>  #define CLKID_PROC_I2C		60
> +#define CLKID_DSPA_SEL		61
> +#define CLKID_DSPB_SEL		62
>  #define CLKID_DSPA_EN		63
>  #define CLKID_DSPA_EN_NIC	64
>  #define CLKID_DSPB_EN		65
> @@ -81,6 +84,7 @@
>  #define CLKID_12M		71
>  #define CLKID_FCLK_DIV2_DIVN	72
>  #define CLKID_GEN		73
> +#define CLKID_SARADC_SEL	74
>  #define CLKID_SARADC		75
>  #define CLKID_PWM_A		76
>  #define CLKID_PWM_B		77
> @@ -95,21 +99,70 @@
>  #define CLKID_SD_EMMC		86
>  #define CLKID_PSRAM		87
>  #define CLKID_DMC		88
> +#define CLKID_SYS_A_SEL		89
> +#define CLKID_SYS_A_DIV		90
> +#define CLKID_SYS_A		91
> +#define CLKID_SYS_B_SEL		92
> +#define CLKID_SYS_B_DIV		93
> +#define CLKID_SYS_B		94
>  #define CLKID_DSPA_A_SEL	95
> +#define CLKID_DSPA_A_DIV	96
> +#define CLKID_DSPA_A		97
>  #define CLKID_DSPA_B_SEL	98
> +#define CLKID_DSPA_B_DIV	99
> +#define CLKID_DSPA_B		100
>  #define CLKID_DSPB_A_SEL	101
> +#define CLKID_DSPB_A_DIV	102
> +#define CLKID_DSPB_A		103
>  #define CLKID_DSPB_B_SEL	104
> +#define CLKID_DSPB_B_DIV	105
> +#define CLKID_DSPB_B		106
> +#define CLKID_RTC_32K_IN	107
> +#define CLKID_RTC_32K_DIV	108
> +#define CLKID_RTC_32K_XTAL	109
> +#define CLKID_RTC_32K_SEL	110
> +#define CLKID_CECB_32K_IN	111
> +#define CLKID_CECB_32K_DIV	112
>  #define CLKID_CECB_32K_SEL_PRE	113
>  #define CLKID_CECB_32K_SEL	114
> +#define CLKID_CECA_32K_IN	115
> +#define CLKID_CECA_32K_DIV	116
>  #define CLKID_CECA_32K_SEL_PRE	117
>  #define CLKID_CECA_32K_SEL	118
> +#define CLKID_DIV2_PRE		119
> +#define CLKID_24M_DIV2		120
>  #define CLKID_GEN_SEL		121
> +#define CLKID_GEN_DIV		122
> +#define CLKID_SARADC_DIV	123
>  #define CLKID_PWM_A_SEL		124
> +#define CLKID_PWM_A_DIV		125
>  #define CLKID_PWM_B_SEL		126
> +#define CLKID_PWM_B_DIV		127
>  #define CLKID_PWM_C_SEL		128
> +#define CLKID_PWM_C_DIV		129
>  #define CLKID_PWM_D_SEL		130
> +#define CLKID_PWM_D_DIV		131
>  #define CLKID_PWM_E_SEL		132
> +#define CLKID_PWM_E_DIV		133
>  #define CLKID_PWM_F_SEL		134
> +#define CLKID_PWM_F_DIV		135
> +#define CLKID_SPICC_SEL		136
> +#define CLKID_SPICC_DIV		137
> +#define CLKID_SPICC_SEL2	138
> +#define CLKID_TS_DIV		139
> +#define CLKID_SPIFC_SEL		140
> +#define CLKID_SPIFC_DIV		141
> +#define CLKID_SPIFC_SEL2	142
> +#define CLKID_USB_BUS_SEL	143
> +#define CLKID_USB_BUS_DIV	144
> +#define CLKID_SD_EMMC_SEL	145
> +#define CLKID_SD_EMMC_DIV	146
>  #define CLKID_SD_EMMC_SEL2	147
> +#define CLKID_PSRAM_SEL		148
> +#define CLKID_PSRAM_DIV		149
> +#define CLKID_PSRAM_SEL2	150
> +#define CLKID_DMC_SEL		151
> +#define CLKID_DMC_DIV		152
> +#define CLKID_DMC_SEL2		153
>  
>  #endif /* __A1_PERIPHERALS_CLKC_H */
> 
> -- 
> 2.34.1
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

By the way, I can share another approach for 'private' clock bindings.
Instead of registering 'private' clock objects on the hw_provider side,
they can be completely omitted and registered only as clock objects.
The such approach restricts internal clock usage by public device tree
at all.
I've already introduced this approach in one of the versions for a1
series (the approach was suggested by Krzysztof).

https://lore.kernel.org/all/20230321193014.26349-6-ddrokosov@sberdevices.ru/

---
+/* Array of all clocks provided by this provider */
+static struct clk_hw_onecell_data a1_periphs_public_clks = {
+	.hws = {
+		[CLKID_FIXPLL_IN]		= &fixpll_in.hw,
+		[CLKID_USB_PHY_IN]		= &usb_phy_in.hw,
+		[CLKID_USB_CTRL_IN]		= &usb_ctrl_in.hw,
+		[CLKID_HIFIPLL_IN]		= &hifipll_in.hw,
+		[CLKID_SYSPLL_IN]		= &syspll_in.hw,
+		[CLKID_DDS_IN]			= &dds_in.hw,
+		[CLKID_SYS]			= &sys.hw,
+		[CLKID_CLKTREE]			= &clktree.hw,
+		[CLKID_RESET_CTRL]		= &reset_ctrl.hw,
+		[CLKID_ANALOG_CTRL]		= &analog_ctrl.hw,
+		[CLKID_PWR_CTRL]		= &pwr_ctrl.hw,

[...]

+/*
+ * These clocks are entirely contrived and do not map onto the hardware.
+ * It has now been decided to expose public clocks in the DT bindings.
+ * Only below clocks we don't want to expose, such as the internal muxes
+ * and dividers of composite clocks, will remain defined here.
+ */
+static struct clk_hw_onecell_data a1_periphs_private_clks = {
+	.hws = {
+		&xtal_in.hw,
+		&dspa_sel.hw,
+		&dspb_sel.hw,
+		&saradc_sel.hw,
+		&sys_a_sel.hw,
+		&sys_a_div.hw,
+		&sys_a.hw,
+		&sys_b_sel.hw,
+		&sys_b_div.hw,
[...]
---

-- 
Thank you,
Dmitry
