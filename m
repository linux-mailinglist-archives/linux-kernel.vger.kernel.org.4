Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E35F224B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJBJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJBJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F32A964
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d42so12840515lfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4AayInl3S9+zHPYK8km1P6govnSXrSAE9fzk5vXFB0s=;
        b=sfRfFA4j4SX/kKbyIfdUp4GKo9SxSl5dkkC76Jj6jdUqkYiLQdmuxY7G/xu7EbpBIE
         yFOdWL5+nNcxD/FugzS+CIKJza3epciksC+AgVF6lSwPxpT/gj0MRCZa16VO71q2O4Cg
         UpjE23JW1kzfpPShmm/ocmUrMSDylaCYKDFaaPyrHtB2q5+rkp9MdPnY1j6rKf2s/do2
         4Fr9GUGms2OuQtowcncqcwrzd34HcHqzYF+QFkGYgRdRbvzL5SPYAcH8p+ldY21j/gXA
         AhvHDyK7BJj38o5SstqqnLLmRscghs+2TxrKWf14NOyQVaw1E8QXMygJBhpcvudapGHd
         s2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4AayInl3S9+zHPYK8km1P6govnSXrSAE9fzk5vXFB0s=;
        b=f6wheY8wZ6B9NZIwOrdNC/sQ41kBIyrBdGsDCkLBgtfT7TseGTv0zcFbYpc00QFEDE
         +f5y7ifk8Pt/kkyc31nOQLNa3CXfuLbfN2Y7RTqWh4o4ZMm+kql83oJIXf00kpc3v8nA
         vXotMABuMqQ4uNz98jkIS3gIa7DcoGyO/EVA8M8CA/SSqvHPgzCVwFjPxu2AMwWcAezQ
         Q/N0vdWuheRrZPMZG43THqFx+QoRNK+DEBAjP2xJ9AvBx/U/ZvlUy/oLhyg5zVM+cdgI
         EtB50XYejmO+UgkBYlZfYYykZtIn2w9QmKCGVkgcuUYNzxhnJ6FfYC6pBM8si6hk4X9M
         bS+Q==
X-Gm-Message-State: ACrzQf3vK+BK6rDn2M0sTbNfnrs6rlqNJJca0qu77Ao5oJ/pG8cemoor
        7QSyC8GybndYeOW5JENzhXq6nQ==
X-Google-Smtp-Source: AMsMyM5bEy1bIiI4DNTciYLNO2B3kGHnx6DBr0kEsEPXAIKZQbJnXPw/vr0KYUg5cdPozZxvs3kWlw==
X-Received: by 2002:ac2:4e90:0:b0:4a2:2a79:392d with SMTP id o16-20020ac24e90000000b004a22a79392dmr1551321lfr.578.1664702408242;
        Sun, 02 Oct 2022 02:20:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b004994117b0fdsm1018255lfb.281.2022.10.02.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: kirkwood: correct indentation
Date:   Sun,  2 Oct 2022 11:20:05 +0200
Message-Id: <20221002092007.68955-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/kirkwood-b3.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts     |  2 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts     |  2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts         | 14 ++---
 arch/arm/boot/dts/kirkwood-ds112.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-ds411.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts       |  2 +-
 arch/arm/boot/dts/kirkwood-km_common.dtsi     |  2 +-
 arch/arm/boot/dts/kirkwood-l-50.dts           | 24 ++++----
 arch/arm/boot/dts/kirkwood-laplug.dts         |  2 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi   |  2 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts        | 16 ++---
 .../arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts |  2 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts        |  2 +-
 arch/arm/boot/dts/kirkwood-net2big.dts        | 10 ++--
 arch/arm/boot/dts/kirkwood-net5big.dts        | 10 ++--
 .../dts/kirkwood-netgear_readynas_nv+_v2.dts  | 12 ++--
 arch/arm/boot/dts/kirkwood-nsa310.dts         |  2 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts         |  2 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts         |  2 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi |  2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts      | 60 +++++++++----------
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts   |  2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi     |  4 +-
 arch/arm/boot/dts/kirkwood-rs212.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi      |  2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts          |  2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi         |  4 +-
 arch/arm/boot/dts/kirkwood.dtsi               | 34 +++++------
 29 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
index a7636fe28501..681343c1357a 100644
--- a/arch/arm/boot/dts/kirkwood-b3.dts
+++ b/arch/arm/boot/dts/kirkwood-b3.dts
@@ -187,7 +187,7 @@ ethernet1-port@0 {
 
 /* Wifi model has Atheros chipset on pcie port */
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
index 2adb17c955aa..a9a8e6b744c7 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -18,7 +18,7 @@ / {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
index f84a48539917..6dc6579d4524 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -18,7 +18,7 @@ / {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index c32300611d2c..f9f4b0143ba8 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -211,18 +211,18 @@ port@0 {
 			};
 
 			port@1 {
-			       reg = <1>;
-			       label = "lan3";
+				reg = <1>;
+				label = "lan3";
 			};
 
 			port@2 {
-			       reg = <2>;
-			       label = "lan2";
+				reg = <2>;
+				label = "lan2";
 			};
 
 			port@3 {
-			       reg = <3>;
-			       label = "lan1";
+				reg = <3>;
+				label = "lan1";
 			};
 
 			port@4 {
@@ -268,7 +268,7 @@ &rtc {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
index f48609e95afe..3912f1b525b6 100644
--- a/arch/arm/boot/dts/kirkwood-ds112.dts
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -43,7 +43,7 @@ &s35390a {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie1 {
diff --git a/arch/arm/boot/dts/kirkwood-ds411.dts b/arch/arm/boot/dts/kirkwood-ds411.dts
index 86907be70cf9..1d4256ef325d 100644
--- a/arch/arm/boot/dts/kirkwood-ds411.dts
+++ b/arch/arm/boot/dts/kirkwood-ds411.dts
@@ -47,7 +47,7 @@ &s35390a {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie1 {
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 95af7aa1fdcb..aed20185fd7a 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -187,7 +187,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-km_common.dtsi b/arch/arm/boot/dts/kirkwood-km_common.dtsi
index 75dc83914f56..52baffe45f12 100644
--- a/arch/arm/boot/dts/kirkwood-km_common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-km_common.dtsi
@@ -39,7 +39,7 @@ &nand {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-l-50.dts b/arch/arm/boot/dts/kirkwood-l-50.dts
index 0d81c43a6a73..60c1e94f5dd3 100644
--- a/arch/arm/boot/dts/kirkwood-l-50.dts
+++ b/arch/arm/boot/dts/kirkwood-l-50.dts
@@ -223,18 +223,18 @@ port@0 {
 			};
 
 			port@1 {
-			       reg = <1>;
-			       label = "lan1";
+				reg = <1>;
+				label = "lan1";
 			};
 
 			port@2 {
-			       reg = <2>;
-			       label = "lan6";
+				reg = <2>;
+				label = "lan6";
 			};
 
 			port@3 {
-			       reg = <3>;
-			       label = "lan2";
+				reg = <3>;
+				label = "lan2";
 			};
 
 			port@4 {
@@ -282,18 +282,18 @@ port@0 {
 			};
 
 			port@1 {
-			       reg = <1>;
-			       label = "lan8";
+				reg = <1>;
+				label = "lan8";
 			};
 
 			port@2 {
-			       reg = <2>;
-			       label = "lan4";
+				reg = <2>;
+				label = "lan4";
 			};
 
 			port@3 {
-			       reg = <3>;
-			       label = "dmz";
+				reg = <3>;
+				label = "dmz";
 			};
 
 			switch1port5: port@5 {
diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/kirkwood-laplug.dts
index 6158214a939a..8c2b540eaf4f 100644
--- a/arch/arm/boot/dts/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/kirkwood-laplug.dts
@@ -160,7 +160,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-linkstation.dtsi b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
index 407d6d8b3a7f..b54c9980f636 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation.dtsi
+++ b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
@@ -156,7 +156,7 @@ hdd_power0: regulator@2 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index b80d12f6aa49..e87ea7146546 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -8,10 +8,10 @@ / {
 	model = "MPL CEC4";
 	compatible = "mpl,cec4-10", "mpl,cec4", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-        memory {
-                device_type = "memory";
-                reg = <0x00000000 0x20000000>;
-        };
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
 
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
@@ -66,8 +66,8 @@ pmx_sdio_cd: pmx-sdio-cd {
 			};
 		};
 
-                i2c@11000 {
-                        status = "okay";
+		i2c@11000 {
+			status = "okay";
 
 			rtc@51 {
 				compatible = "nxp,pcf8563";
@@ -79,7 +79,7 @@ eeprom@57 {
 				reg = <0x57>;
 			};
 
-                };
+		};
 
 		serial@12000 {
 			status = "okay";
@@ -208,7 +208,7 @@ ethernet1-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 2e1a75348908..ced576acfb95 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -170,7 +170,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/kirkwood-nas2big.dts
index 6a2934b7d0ce..0b0a15093146 100644
--- a/arch/arm/boot/dts/kirkwood-nas2big.dts
+++ b/arch/arm/boot/dts/kirkwood-nas2big.dts
@@ -131,7 +131,7 @@ partition@9100000 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
index 3e3ac289e5b0..d5f6bb50ba11 100644
--- a/arch/arm/boot/dts/kirkwood-net2big.dts
+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
@@ -46,11 +46,11 @@ regulator@2 {
 	};
 
 	clocks {
-	       g762_clk: g762-oscillator {
-			 compatible = "fixed-clock";
-			 #clock-cells = <0>;
-			 clock-frequency = <32768>;
-	       };
+		g762_clk: g762-oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
index cba8a2b6f6d9..2497ad26b5b6 100644
--- a/arch/arm/boot/dts/kirkwood-net5big.dts
+++ b/arch/arm/boot/dts/kirkwood-net5big.dts
@@ -78,11 +78,11 @@ regulator@5 {
 	};
 
 	clocks {
-	       g762_clk: g762-oscillator {
-			 compatible = "fixed-clock";
-			 #clock-cells = <0>;
-			 clock-frequency = <32768>;
-	       };
+		g762_clk: g762-oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
 	};
 
 	netxbig-leds {
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
index b13aee570804..6cf76430cfab 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
@@ -78,11 +78,11 @@ pmx_poweroff: pmx-poweroff {
 		};
 
 		clocks {
-		       g762_clk: g762-oscillator {
-				 compatible = "fixed-clock";
-				 #clock-cells = <0>;
-				 clock-frequency = <8192>;
-		       };
+			g762_clk: g762-oscillator {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <8192>;
+			};
 		};
 
 		i2c@11000 {
@@ -266,7 +266,7 @@ ethernet0-port@0 {
 
 /* Connected to NEC uPD720200 USB 3.0 controller */
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 9b861c2e76c5..c1799a07816e 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -131,7 +131,7 @@ red-copy {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index b69b096f267b..652405e65006 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -211,7 +211,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-nsa325.dts b/arch/arm/boot/dts/kirkwood-nsa325.dts
index 6f8085dbb1f4..371456de34b2 100644
--- a/arch/arm/boot/dts/kirkwood-nsa325.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa325.dts
@@ -224,7 +224,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
index 8f73197f251a..ea3d36512e9f 100644
--- a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
@@ -150,7 +150,7 @@ partition@5040000 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
index 712d6042b132..f00325ffde07 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6192.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -31,10 +31,10 @@ pinctrl: pin-controller@10000 {
 			pinctrl-0 = <&pmx_usb_power>;
 			pinctrl-names = "default";
 
-                        pmx_usb_power: pmx-usb-power {
-                                marvell,pins = "mpp10";
-                                marvell,function = "gpo";
-                        };
+			pmx_usb_power: pmx-usb-power {
+				marvell,pins = "mpp10";
+				marvell,function = "gpo";
+			};
 		};
 
 		serial@12000 {
@@ -62,43 +62,43 @@ sata@80000 {
 	};
 
 	regulators {
-                compatible = "simple-bus";
-                #address-cells = <1>;
-                #size-cells = <0>;
-                pinctrl-0 = <&pmx_usb_power>;
-                pinctrl-names = "default";
-
-                usb_power: regulator@0 {
-                        compatible = "regulator-fixed";
-                        reg = <0>;
-                        regulator-name = "USB VBUS";
-                        regulator-min-microvolt = <5000000>;
-                        regulator-max-microvolt = <5000000>;
-                        enable-active-high;
-                        regulator-always-on;
-                        regulator-boot-on;
-                        gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
-                };
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power>;
+		pinctrl-names = "default";
+
+		usb_power: regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "USB VBUS";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
 	};
 };
 
 &mdio {
-        status = "okay";
+	status = "okay";
 
-        ethphy0: ethernet-phy@8 {
-                reg = <8>;
-        };
+	ethphy0: ethernet-phy@8 {
+		reg = <8>;
+	};
 };
 
 &eth0 {
-        status = "okay";
-        ethernet0-port@0 {
-                phy-handle = <&ethphy0>;
-        };
+	status = "okay";
+	ethernet0-port@0 {
+		phy-handle = <&ethphy0>;
+	};
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
index 9d88301daf0e..72edd47e19ff 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
@@ -19,7 +19,7 @@ / {
 };
 
 &eth1 {
-      status = "disabled";
+	status = "disabled";
 };
 
 &switch {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index f1f8eee132e8..e21aa674945d 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -48,7 +48,7 @@ mvsdio@90000 {
 			cd-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 			/* No WP GPIO */
 		};
-       };
+	};
 };
 
 &nand {
@@ -126,7 +126,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-rs212.dts b/arch/arm/boot/dts/kirkwood-rs212.dts
index c51cea883215..4ad412115a24 100644
--- a/arch/arm/boot/dts/kirkwood-rs212.dts
+++ b/arch/arm/boot/dts/kirkwood-rs212.dts
@@ -43,7 +43,7 @@ &s35390a {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie1 {
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 8f6c387d3a8b..9b6666020cdd 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -847,7 +847,7 @@ ethernet1-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index fe63b3a03a72..ad093324e075 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -219,7 +219,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 994cabcf4b51..1939462a5f48 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -86,7 +86,7 @@ &mdio {
 	status = "okay";
 
 	ethphy0: ethernet-phy@X {
-                /* overwrite reg property in board file */
+		/* overwrite reg property in board file */
 	};
 };
 
@@ -98,7 +98,7 @@ ethernet0-port@0 {
 };
 
 &pciec {
-        status = "okay";
+	status = "okay";
 };
 
 &pcie0 {
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index fca31a5d5ac7..815ef7719d13 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -24,9 +24,9 @@ cpu@0 {
 	};
 
 	aliases {
-	       gpio0 = &gpio0;
-	       gpio1 = &gpio1;
-	       i2c0 = &i2c0;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		i2c0 = &i2c0;
 	};
 
 	mbus@f1000000 {
@@ -279,15 +279,15 @@ dma0: xor@60800 {
 			clocks = <&gate_clk 8>;
 
 			xor00 {
-			      interrupts = <5>;
-			      dmacap,memcpy;
-			      dmacap,xor;
+				interrupts = <5>;
+				dmacap,memcpy;
+				dmacap,xor;
 			};
 			xor01 {
-			      interrupts = <6>;
-			      dmacap,memcpy;
-			      dmacap,xor;
-			      dmacap,memset;
+				interrupts = <6>;
+				dmacap,memcpy;
+				dmacap,xor;
+				dmacap,memset;
 			};
 		};
 
@@ -299,15 +299,15 @@ dma1: xor@60900 {
 			clocks = <&gate_clk 16>;
 
 			xor00 {
-			      interrupts = <7>;
-			      dmacap,memcpy;
-			      dmacap,xor;
+				interrupts = <7>;
+				dmacap,memcpy;
+				dmacap,xor;
 			};
 			xor01 {
-			      interrupts = <8>;
-			      dmacap,memcpy;
-			      dmacap,xor;
-			      dmacap,memset;
+				interrupts = <8>;
+				dmacap,memcpy;
+				dmacap,xor;
+				dmacap,memset;
 			};
 		};
 
-- 
2.34.1

