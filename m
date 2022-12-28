Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42231658698
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiL1UDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 15:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiL1UDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 15:03:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A4D13F15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 12:03:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so24974132lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y62W+4unrt0N1H/hbHDjd85DqMlPKfNIDH0roBe5Np8=;
        b=NVIyXU8MzWCazUdcvGbQ/5Ku9kMxsWMu7ejGi6aplzBVcX5KuR0eRkDML9JE/G6gOi
         H9n+CGBJSazsisajWbC8ADQxLeQ/L6PPEprxD1ERwc1apAZ4C1rT4TiKYVUchh2i7G4+
         HAjjgJmClFAMGghB8hw4NlsaCNDHlwe2Mko86prS67+yRg3zdCr76jGxausvorEWzaL1
         o6mJaWoD3hW0Qsd9uU6HtH8ZQu/Sc66Zo66I0s89dIOaaA8mPTMeP1QWG04rJHpf0lGb
         lqAcXk3NzKWfBH7GEy9WIU4B5FZNJwWR2g8fjnFRloDjCFCy0EZFrcQNgg5NCkOGVmZF
         tWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y62W+4unrt0N1H/hbHDjd85DqMlPKfNIDH0roBe5Np8=;
        b=uMhxppfIwFt3aE5CIibMX6VSu4ynbVXZAT8n8Tiq0YY5FbqsOxKF1biyl0X9HRJsOP
         NBztRPkQdZ498ibK0mGKDaWfynm6ivbujLkexRJpxn0bY65YTg1GSe6FgfL6t4l5FHW5
         PJi9flJIhHg4/Jc5JYlfwpYoj3ntUa+CZrDX2iHMraBqmjG4+2h/WRnZWbJ5Lj2GeIbF
         LPukdmCV/0VEkcinmQ0MdcIc9Q66lSI5/MIOOyDZ1ZN4VHy0bY2Xq67FUyLpwTqqPly6
         ti9w/Ut17nZyrwxVWNU8mS9JHUQW6F795rY4C5RknylUcAKN6aAH/vrO2YtccGiBQnlX
         8xfw==
X-Gm-Message-State: AFqh2kqrxoeNX4QXsvUJ7BLziwwHEBKo2hQXL927ufFTor3jDvb1fulj
        CEAjipdNwpxD12EmijCxWpOJMoXHEr0Xe28WZ80=
X-Google-Smtp-Source: AMrXdXvFDhQ0vprWhz+60YAD5Z4AVVtnKNcpjAKMdhCQNCbRD7s6x2CjmuLik55JG7+s8H2bESsb8g==
X-Received: by 2002:a05:6512:2385:b0:4b5:90be:33c8 with SMTP id c5-20020a056512238500b004b590be33c8mr8190561lfv.48.1672257820194;
        Wed, 28 Dec 2022 12:03:40 -0800 (PST)
Received: from michal-H370M-DS3H.office.semihalf.net ([83.142.187.84])
        by smtp.googlemail.com with ESMTPSA id j13-20020ac2454d000000b004c7d0ed9619sm2806156lfm.123.2022.12.28.12.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 12:03:39 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Grzelak?= <mig@semihalf.com>
To:     linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mw@semihalf.com, upstream@semihalf.com, mchl.grzlk@gmail.com,
        =?UTF-8?q?Micha=C5=82=20Grzelak?= <mig@semihalf.com>
Subject: [PATCH v2] ARM: dts: dove.dtsi: Move ethphy to fix schema error
Date:   Wed, 28 Dec 2022 21:02:34 +0100
Message-Id: <20221228200234.86391-1-mig@semihalf.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running 'make dtbs_check' with schema in net/marvell,orion-mdio.yaml
gives the following warnings:
mdio-bus@72004: Unevaluated properties are not allowed
('ethernet-phy' was unexpected)
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-dove-db.dtb
	arch/arm/boot/dts/dove-d3plug.dtb
	arch/arm/boot/dts/dove-sbc-a510.dtb
Fix them by removing empty ethphy subnode from dove.dtsi and describe
PHY on the relevant board .dts files level.

Signed-off-by: Michał Grzelak <mig@semihalf.com>
---
 arch/arm/boot/dts/dove-cm-a510.dtsi | 14 +++++++++++---
 arch/arm/boot/dts/dove-cubox.dts    | 15 +++++++++++----
 arch/arm/boot/dts/dove.dtsi         |  5 -----
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove-cm-a510.dtsi
index 9b9dfbe07be4..2f2f0a4bf004 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dtsi
+++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
@@ -124,9 +124,17 @@ wifi_power: regulator@1 {
 };
 
 /* Optional RTL8211D GbE PHY on SMI address 0x03 */
-&ethphy {
-	reg = <3>;
-	status = "disabled";
+&mdio {
+	ethphy: ethernet-phy@3 {
+		reg = <3>;
+		status = "disabled";
+	};
+};
+
+&eth {
+	ethernet-port@0 {
+		phy-handle = <&ethphy>;
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 2639b9fe0ab4..170c14d7f5c8 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -72,11 +72,18 @@ gpu-subsystem {
 &uart0 { status = "okay"; };
 &sata0 { status = "okay"; };
 &mdio { status = "okay"; };
-&eth { status = "okay"; };
+&eth {
+	status = "okay";
+	ethernet-port@0 {
+		phy-handle = <&ethphy>;
+	};
+};
 
-&ethphy {
-	compatible = "marvell,88e1310";
-	reg = <1>;
+&mdio {
+	ethphy: ethernet-phy@1 {
+		compatible = "marvell,88e1310";
+		reg = <1>;
+	};
 };
 
 &gpu {
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 00a36fba2fd2..c7a3fa33c56e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -382,7 +382,6 @@ ethernet-port@0 {
 					interrupts = <29>;
 					/* overwrite MAC address in bootloader */
 					local-mac-address = [00 00 00 00 00 00];
-					phy-handle = <&ethphy>;
 				};
 			};
 
@@ -394,10 +393,6 @@ mdio: mdio-bus@72004 {
 				interrupts = <30>;
 				clocks = <&gate_clk 2>;
 				status = "disabled";
-
-				ethphy: ethernet-phy {
-					/* set phy address in board file */
-				};
 			};
 
 			sdio0: sdio-host@92000 {
-- 
2.34.1

