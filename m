Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2211E6ADCA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCGK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCGK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:57:20 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB6F5BCA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=dJBOGd647MQDIh
        GLO7K2LOAhZbvKu6Gsk4myiM4hGrY=; b=Yb0g7pvOoWHRIkg88gumubrnprHbga
        1rD1WCxbwzN7j+QwS9/AdqYV+aqCUMITyQ8wLvXtC0QLbIW9uxeFx72xAMAqBXCr
        sSwP/Plf/qcgqH3SPUPZhppYnuowYw4nmb7s18FetYYVAPEc5gFRSkglkWE67XUj
        B2tGXzbzKdWaw=
Received: (qmail 650912 invoked from network); 7 Mar 2023 11:57:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 11:57:06 +0100
X-UD-Smtp-Session: l3s3148p1@z9u/RU32JoggAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: renesas: remove R-Car H3 ES1.* devicetrees
Date:   Tue,  7 Mar 2023 11:56:38 +0100
Message-Id: <20230307105645.5285-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |   4 -
 .../boot/dts/renesas/r8a77950-salvator-x.dts  |  49 ---
 .../boot/dts/renesas/r8a77950-ulcb-kf.dts     |  16 -
 arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts |  37 --
 arch/arm64/boot/dts/renesas/r8a77950.dtsi     | 330 ------------------
 5 files changed, 436 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950.dtsi

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 0699b51c1247..366fddbd3c91 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -28,10 +28,6 @@ dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
 
-dtb-$(CONFIG_ARCH_R8A77950) += r8a77950-salvator-x.dtb
-dtb-$(CONFIG_ARCH_R8A77950) += r8a77950-ulcb.dtb
-dtb-$(CONFIG_ARCH_R8A77950) += r8a77950-ulcb-kf.dtb
-
 dtb-$(CONFIG_ARCH_R8A77951) += r8a77951-salvator-x.dtb
 dtb-$(CONFIG_ARCH_R8A77951) += r8a77951-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77951) += r8a77951-ulcb.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
deleted file mode 100644
index c6ca61a8ed40..000000000000
--- a/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for the Salvator-X board with R-Car H3 ES1.x
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-/dts-v1/;
-#include "r8a77950.dtsi"
-#include "salvator-x.dtsi"
-
-/ {
-	model = "Renesas Salvator-X board based on r8a77950";
-	compatible = "renesas,salvator-x", "renesas,r8a7795";
-
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x38000000>;
-	};
-
-	memory@500000000 {
-		device_type = "memory";
-		reg = <0x5 0x00000000 0x0 0x40000000>;
-	};
-
-	memory@600000000 {
-		device_type = "memory";
-		reg = <0x6 0x00000000 0x0 0x40000000>;
-	};
-
-	memory@700000000 {
-		device_type = "memory";
-		reg = <0x7 0x00000000 0x0 0x40000000>;
-	};
-};
-
-&du {
-	clocks = <&cpg CPG_MOD 724>,
-		 <&cpg CPG_MOD 723>,
-		 <&cpg CPG_MOD 722>,
-		 <&cpg CPG_MOD 721>,
-		 <&versaclock5 1>,
-		 <&x21_clk>,
-		 <&x22_clk>,
-		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "du.3",
-		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dts b/arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dts
deleted file mode 100644
index 85f008ef63de..000000000000
--- a/arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dts
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for the H3ULCB Kingfisher board with R-Car H3 ES1.x
- *
- * Copyright (C) 2017 Renesas Electronics Corp.
- * Copyright (C) 2017 Cogent Embedded, Inc.
- */
-
-#include "r8a77950-ulcb.dts"
-#include "ulcb-kf.dtsi"
-
-/ {
-	model = "Renesas H3ULCB Kingfisher board based on r8a77950";
-	compatible = "shimafuji,kingfisher", "renesas,h3ulcb",
-		     "renesas,r8a7795";
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts b/arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts
deleted file mode 100644
index 5340579931e3..000000000000
--- a/arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for the H3ULCB (R-Car Starter Kit Premier) board with R-Car H3 ES1.x
- *
- * Copyright (C) 2016 Renesas Electronics Corp.
- * Copyright (C) 2016 Cogent Embedded, Inc.
- */
-
-/dts-v1/;
-#include "r8a77950.dtsi"
-#include "ulcb.dtsi"
-
-/ {
-	model = "Renesas H3ULCB board based on r8a77950";
-	compatible = "renesas,h3ulcb", "renesas,r8a7795";
-
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x38000000>;
-	};
-
-	memory@500000000 {
-		device_type = "memory";
-		reg = <0x5 0x00000000 0x0 0x40000000>;
-	};
-
-	memory@600000000 {
-		device_type = "memory";
-		reg = <0x6 0x00000000 0x0 0x40000000>;
-	};
-
-	memory@700000000 {
-		device_type = "memory";
-		reg = <0x7 0x00000000 0x0 0x40000000>;
-	};
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a77950.dtsi b/arch/arm64/boot/dts/renesas/r8a77950.dtsi
deleted file mode 100644
index 57eb88177e92..000000000000
--- a/arch/arm64/boot/dts/renesas/r8a77950.dtsi
+++ /dev/null
@@ -1,330 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for the R-Car H3 (R8A77950) SoC
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#include "r8a77951.dtsi"
-
-#undef SOC_HAS_USB2_CH3
-
-&audma0 {
-	iommus = <&ipmmu_mp1 0>, <&ipmmu_mp1 1>,
-	       <&ipmmu_mp1 2>, <&ipmmu_mp1 3>,
-	       <&ipmmu_mp1 4>, <&ipmmu_mp1 5>,
-	       <&ipmmu_mp1 6>, <&ipmmu_mp1 7>,
-	       <&ipmmu_mp1 8>, <&ipmmu_mp1 9>,
-	       <&ipmmu_mp1 10>, <&ipmmu_mp1 11>,
-	       <&ipmmu_mp1 12>, <&ipmmu_mp1 13>,
-	       <&ipmmu_mp1 14>, <&ipmmu_mp1 15>;
-};
-
-&audma1 {
-	iommus = <&ipmmu_mp1 16>, <&ipmmu_mp1 17>,
-	       <&ipmmu_mp1 18>, <&ipmmu_mp1 19>,
-	       <&ipmmu_mp1 20>, <&ipmmu_mp1 21>,
-	       <&ipmmu_mp1 22>, <&ipmmu_mp1 23>,
-	       <&ipmmu_mp1 24>, <&ipmmu_mp1 25>,
-	       <&ipmmu_mp1 26>, <&ipmmu_mp1 27>,
-	       <&ipmmu_mp1 28>, <&ipmmu_mp1 29>,
-	       <&ipmmu_mp1 30>, <&ipmmu_mp1 31>;
-};
-
-&cluster0_opp {
-	/delete-node/ opp-1600000000;
-	/delete-node/ opp-1700000000;
-};
-
-&du {
-	renesas,vsps = <&vspd0 0>, <&vspd1 0>, <&vspd2 0>, <&vspd3 0>;
-};
-
-&fcpvb1 {
-	iommus = <&ipmmu_vp0 7>;
-};
-
-&fcpf1 {
-	iommus = <&ipmmu_vp0 1>;
-};
-
-&fcpvi1 {
-	iommus = <&ipmmu_vp0 9>;
-};
-
-&fcpvd2 {
-	iommus = <&ipmmu_vi0 10>;
-};
-
-&gpio1 {
-	gpio-ranges = <&pfc 0 32 28>;
-};
-
-&ipmmu_vi0 {
-	renesas,ipmmu-main = <&ipmmu_mm 11>;
-};
-
-&ipmmu_vp0 {
-	renesas,ipmmu-main = <&ipmmu_mm 12>;
-};
-
-&ipmmu_vc0 {
-	renesas,ipmmu-main = <&ipmmu_mm 9>;
-};
-
-&ipmmu_vc1 {
-	renesas,ipmmu-main = <&ipmmu_mm 10>;
-};
-
-&ipmmu_rt {
-	renesas,ipmmu-main = <&ipmmu_mm 7>;
-};
-
-&soc {
-	/delete-node/ dma-controller@e6460000;
-	/delete-node/ dma-controller@e6470000;
-
-	ipmmu_mp1: iommu@ec680000 {
-		compatible = "renesas,ipmmu-r8a7795";
-		reg = <0 0xec680000 0 0x1000>;
-		renesas,ipmmu-main = <&ipmmu_mm 5>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		#iommu-cells = <1>;
-	};
-
-	ipmmu_sy: iommu@e7730000 {
-		compatible = "renesas,ipmmu-r8a7795";
-		reg = <0 0xe7730000 0 0x1000>;
-		renesas,ipmmu-main = <&ipmmu_mm 8>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		#iommu-cells = <1>;
-	};
-
-	/delete-node/ iommu@fd950000;
-	/delete-node/ iommu@fd960000;
-	/delete-node/ iommu@fd970000;
-	/delete-node/ iommu@febe0000;
-	/delete-node/ iommu@fe980000;
-
-	xhci1: usb@ee040000 {
-		compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
-		reg = <0 0xee040000 0 0xc00>;
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 327>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		resets = <&cpg 327>;
-		status = "disabled";
-	};
-
-	/delete-node/ usb@e659c000;
-	/delete-node/ usb@ee0e0000;
-	/delete-node/ usb@ee0e0100;
-
-	/delete-node/ usb-phy@ee0e0200;
-
-	fdp1@fe948000 {
-		compatible = "renesas,fdp1";
-		reg = <0 0xfe948000 0 0x2400>;
-		interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 117>;
-		power-domains = <&sysc R8A7795_PD_A3VP>;
-		resets = <&cpg 117>;
-		renesas,fcp = <&fcpf2>;
-	};
-
-	fcpf2: fcp@fe952000 {
-		compatible = "renesas,fcpf";
-		reg = <0 0xfe952000 0 0x200>;
-		clocks = <&cpg CPG_MOD 613>;
-		power-domains = <&sysc R8A7795_PD_A3VP>;
-		resets = <&cpg 613>;
-		iommus = <&ipmmu_vp0 2>;
-	};
-
-	fcpvd3: fcp@fea3f000 {
-		compatible = "renesas,fcpv";
-		reg = <0 0xfea3f000 0 0x200>;
-		clocks = <&cpg CPG_MOD 600>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		resets = <&cpg 600>;
-		iommus = <&ipmmu_vi0 11>;
-	};
-
-	fcpvi2: fcp@fe9cf000 {
-		compatible = "renesas,fcpv";
-		reg = <0 0xfe9cf000 0 0x200>;
-		clocks = <&cpg CPG_MOD 609>;
-		power-domains = <&sysc R8A7795_PD_A3VP>;
-		resets = <&cpg 609>;
-		iommus = <&ipmmu_vp0 10>;
-	};
-
-	vspd3: vsp@fea38000 {
-		compatible = "renesas,vsp2";
-		reg = <0 0xfea38000 0 0x5000>;
-		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 620>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		resets = <&cpg 620>;
-
-		renesas,fcp = <&fcpvd3>;
-	};
-
-	vspi2: vsp@fe9c0000 {
-		compatible = "renesas,vsp2";
-		reg = <0 0xfe9c0000 0 0x8000>;
-		interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 629>;
-		power-domains = <&sysc R8A7795_PD_A3VP>;
-		resets = <&cpg 629>;
-
-		renesas,fcp = <&fcpvi2>;
-	};
-
-	csi21: csi2@fea90000 {
-		compatible = "renesas,r8a7795-csi2";
-		reg = <0 0xfea90000 0 0x10000>;
-		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 713>;
-		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		resets = <&cpg 713>;
-		status = "disabled";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-			};
-
-			port@1 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				reg = <1>;
-
-				csi21vin0: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&vin0csi21>;
-				};
-				csi21vin1: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&vin1csi21>;
-				};
-				csi21vin2: endpoint@2 {
-					reg = <2>;
-					remote-endpoint = <&vin2csi21>;
-				};
-				csi21vin3: endpoint@3 {
-					reg = <3>;
-					remote-endpoint = <&vin3csi21>;
-				};
-				csi21vin4: endpoint@4 {
-					reg = <4>;
-					remote-endpoint = <&vin4csi21>;
-				};
-				csi21vin5: endpoint@5 {
-					reg = <5>;
-					remote-endpoint = <&vin5csi21>;
-				};
-				csi21vin6: endpoint@6 {
-					reg = <6>;
-					remote-endpoint = <&vin6csi21>;
-				};
-				csi21vin7: endpoint@7 {
-					reg = <7>;
-					remote-endpoint = <&vin7csi21>;
-				};
-			};
-		};
-	};
-};
-
-&vin0 {
-	ports {
-		port@1 {
-			vin0csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin0>;
-			};
-		};
-	};
-};
-
-&vin1 {
-	ports {
-		port@1 {
-			vin1csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin1>;
-			};
-		};
-	};
-};
-
-&vin2 {
-	ports {
-		port@1 {
-			vin2csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin2>;
-			};
-		};
-	};
-};
-
-&vin3 {
-	ports {
-		port@1 {
-			vin3csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin3>;
-			};
-		};
-	};
-};
-
-&vin4 {
-	ports {
-		port@1 {
-			vin4csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin4>;
-			};
-		};
-	};
-};
-
-&vin5 {
-	ports {
-		port@1 {
-			vin5csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin5>;
-			};
-		};
-	};
-};
-
-&vin6 {
-	ports {
-		port@1 {
-			vin6csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin6>;
-			};
-		};
-	};
-};
-
-&vin7 {
-	ports {
-		port@1 {
-			vin7csi21: endpoint@1 {
-				reg = <1>;
-				remote-endpoint = <&csi21vin7>;
-			};
-		};
-	};
-};
-- 
2.35.1

