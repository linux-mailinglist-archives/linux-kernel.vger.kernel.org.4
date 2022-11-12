Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C66269E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiKLOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiKLOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:19:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E11836A;
        Sat, 12 Nov 2022 06:19:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a13so11342504edj.0;
        Sat, 12 Nov 2022 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+7dkLsIQWkssfwSwIW2QDjIIkEwPc25TwB+Qcm5uo=;
        b=UKsD0x/5BTuv9I4BmyFff3ZscFituJT8FVzMy4P+x8g7Wf2MoY84kUTPR8DxMkOuL1
         H559lXZ7bzcyr8wmsTE3pMtmipu5Yfk/QjpFTk3QH97fzoy63E3zJoVwM0f8TpxVnTPm
         Lpi63S8/Sz0jTdVKe0WrNrJWPZvq8IDjRI033hdCCTizDmJv08AFv9gvk9AcdkObd+3u
         cHNLeRzoW2CFo8Y11wEeY5KzeknnkpeOHTgMUL3YRR7skwQIL5ac/zBMR6/eQ1iGhgGM
         AP431ZJAhlQeMETgUt95VLv99uuTOtfVllNTBl+HMuk6MEWro6Edy+vJx31PpwjRXq4Z
         JVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+7dkLsIQWkssfwSwIW2QDjIIkEwPc25TwB+Qcm5uo=;
        b=rIs8ju0j4wKUl7vt/bUVlX4hTRx9z1XpPm2cpai/3Nae9FUca9/YpEF/L2dGqnLfT7
         KvQkLNcK6/eiZ/p0luo6OcR5AzCNEgpJs58j/eJ0tbujGb1OjTRjSewsfL1dt5YCVnda
         wHdAj7pbidY7YHr7B5gCi0aEVl9QSGS8wOCV6F9wijv6hgW0h2RJFPngTl+Hg1io8BBU
         whr2NvxQWA3CfaQE3xSyNpUCldrBmdOVp40jAszV7CeShUyXiWTmClAwBzkYdh/+Mpgj
         gY5eJuvWGd6yAY4mg2CASicAQaA8NjMzoPhZ9zZO9NJZUB2xwZcAYvJaBvd572lGcWZN
         CGLQ==
X-Gm-Message-State: ANoB5plyPFKmx+ypNJG0PTNZRetkMo6v27UHjzF1uNvA/rReyJINrFZt
        gmI471eKFhSjnnCvlV71Nxc=
X-Google-Smtp-Source: AA0mqf4AoYvIvRXjdP+4QwIcYyifLsaVVmZlBcKGdBmBxZa/s6+zu4hpBWycYBZO2fiqpwcFBdHIcQ==
X-Received: by 2002:aa7:d793:0:b0:460:d1f6:2917 with SMTP id s19-20020aa7d793000000b00460d1f62917mr5591021edq.207.1668262745128;
        Sat, 12 Nov 2022 06:19:05 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id g21-20020a50ee15000000b004677b1b1a70sm1050148eds.61.2022.11.12.06.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:19:04 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: rockchip: Add Anbernic RG351M
Date:   Sat, 12 Nov 2022 15:18:41 +0100
Message-Id: <20221112141840.516224-6-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112141840.516224-1-maccraft123mc@gmail.com>
References: <20221112141840.516224-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is a clone of Odroid Go Advance, with added PWM motor, internal
gamepad connected on USB instead of just having it be on GPIO + ADC, and
missing battery shunt resistor.

There's also an LED on GPIO 77(I *guess* PB5 on &gpio2), that is controlled in a weird way:

- It is set to red by setting output value to 1
- Set to green by setting output value to 0
- Set to yellow by setting gpio direction to input

I have no idea how to describe that in DTS, without adding a custom
driver, for now it's just left out.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3326-anbernic-rg351m.dts   | 54 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 142c83d2e5aa..b379516c15eb 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-anbernic-rg351m.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
new file mode 100644
index 000000000000..7f4726d4130e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Hardkernel Co., Ltd
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3326-odroid-go.dtsi"
+
+/ {
+	model = "Anbernic RG351M";
+	compatible = "anbernic,rg351m", "rockchip,rk3326";
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3450000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <100000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+		pwms = <&pwm0 0 1000000 0>;
+		pwm-names = "enable";
+	};
+};
+
+/delete-node/ &builtin_gamepad;
+/delete-node/ &vcc_host; /* conflicts with pwm vibration motor */
+
+&internal_display {
+	compatible = "elida,kd35t133";
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&rk817_charger {
+	monitored-battery = <&battery>;
+};
-- 
2.38.1

