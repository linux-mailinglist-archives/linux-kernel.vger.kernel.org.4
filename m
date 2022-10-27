Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6F60ED34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiJ0Ayt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiJ0Ayq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:54:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988731CB28;
        Wed, 26 Oct 2022 17:54:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i21so158076edj.10;
        Wed, 26 Oct 2022 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=agUfJhSL/7u/2Vjm1nnugKSFMcqrJl4gZcmjxoIEl1g=;
        b=c1yDcrGA3P2wThetdZ/lu4NMgMjfBlMmWFOYec18OiEEEQCYvaOX2qKRMIgbYJK0Nc
         /uvA3XBy6kFS5rdNPZduV6FnIdNqcMpxTHwXyZ8+1byL10cm1co2Khhh9qJkOZqDU6iL
         hgO29pBqwHO/Dfb0vlueW8pBcIU5yFSce9CJpLBD4yF3/O7qOfyozUK5Asw6wF+DTlPk
         SROTe2tzLGfR5WRYaK5ywCxje21+Z20zhtXDBrMBCtnRlayfpbr8XGIFIGeOo5DxziAQ
         9Ig51gp59OfNdabyzvXMvNNCcK/9fXtJNWX/Q9Y/RGlotg4hJeeS0kV2b+ZfN5NJ7+sK
         UVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agUfJhSL/7u/2Vjm1nnugKSFMcqrJl4gZcmjxoIEl1g=;
        b=Y4vLhw5LmXdl51DVoQHDg5RnACVFOxMJhfkPUlDSUybyM03r3/uuuhgFSmLnVZtLP1
         faKb/trp/qmgMvlJx53pZ2au0hgWvAC64tH+C9zMElFlYYrskqeplhlRHz9McHt5o43G
         aiXLyisfix2PUCfQnfjgYiOfPm8vcfvMqGKqflkPDDYjyefDPvJOnNPo63mtSYb8O61q
         Ksx1Y2yaHoqnpkfD7femQa81hATtInA6yKPu/U0LVP4nyiZNZMkTngzKXMWiECWkOQoC
         3i8s5sKx677lKSX0tUjx3zRZISc0kX1IJYQpYU5P52DnZBoPsWUiV90G2GDIeI8klNfz
         UYcg==
X-Gm-Message-State: ACrzQf1Pngs8LuYgWYMVG5y3CcyyrUrNg+iyIpTMdp9+q1QZ91vuPBBb
        5v7uYgKvNUkrTpYbHVrLf+U=
X-Google-Smtp-Source: AMsMyM6aIB8iArlp/yXdLbkVlfyR5S2chCIX7ypP3AB53UZCrMN6kr/dhBXe3qlkTlhGWpT++ItiBA==
X-Received: by 2002:a05:6402:2546:b0:45d:8bff:7afc with SMTP id l6-20020a056402254600b0045d8bff7afcmr42631340edb.302.1666832082497;
        Wed, 26 Oct 2022 17:54:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b007ad2da5668csm2286040ejc.112.2022.10.26.17.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:54:42 -0700 (PDT)
Message-ID: <e0679728-7a15-50e1-8a5e-847db1528726@gmail.com>
Date:   Thu, 27 Oct 2022 02:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/4] ARM: dts: rockchip: add rk3128-evb.dts
To:     kever.yang@rock-chips.com, heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
Content-Language: en-US
In-Reply-To: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rk3128-evb.dts

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/rk3128-evb.dts | 105 +++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3128-evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 68ac9b360..0f26539d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1127,6 +1127,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-marsboard.dtb \
 	rk3066a-mk808.dtb \
 	rk3066a-rayeager.dtb \
+	rk3128-evb.dtb \
 	rk3188-bqedison2qc.dtb \
 	rk3188-px3-evb.dtb \
 	rk3188-radxarock.dtb \
diff --git a/arch/arm/boot/dts/rk3128-evb.dts b/arch/arm/boot/dts/rk3128-evb.dts
new file mode 100644
index 000000000..6ad4549d5
--- /dev/null
+++ b/arch/arm/boot/dts/rk3128-evb.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2017 Rockchip Electronics Co., Ltd
+ */
+
+/dts-v1/;
+
+#include "rk3128.dtsi"
+
+/ {
+	model = "Rockchip RK3128 Evaluation board";
+	compatible = "rockchip,rk3128-evb", "rockchip,rk3128";
+
+	aliases {
+		mmc0 = &emmc;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	vcc5v0_otg: vcc5v0-otg-drv {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_otg";
+		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_host: vcc5v0-host-drv {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		gpio = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+	};
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb_otg {
+	vbus-supply = <&vcc5v0_otg>;
+	status = "okay";
+};
+
+&pinctrl {
+	usb_otg {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb_host {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
--
2.20.1

