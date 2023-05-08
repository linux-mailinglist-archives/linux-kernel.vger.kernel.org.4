Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA086FBA17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjEHVlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjEHVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EE93CB;
        Mon,  8 May 2023 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683582021; x=1715118021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKHsoNGSMMtx6Q9tcu30hatw3LMK0bAjnC3I6pBAw90=;
  b=kh1TJajYrqqOrsY/bqIBp3yTXEf0fsUSIt2lfh+DsIX5x3IUurUCE0kp
   OAVgiq7YbAG0+CnNHLSoZSFgswLBlFEdFiEZ+A3Zcqx8VD9FAKDxUgdaY
   TI6ijfhDu9f/Gnaatzhl/IWfZW2nPYJP/tcJlY8ujAtXvj5FyHGjCHS2Y
   +jPZAHaOcNKLlrZax/3Cydrrdjse21jhT7Ey8w4QLKsoXLwD+IgmW9js5
   i3Sg68mkvlKhY3Zxg9s+aBwN9lpMxXGatVP7O0/qy4b93uq2vrq/cMcgZ
   GSL8indkKrfNy8Eo6nzTl49r6dj2EzjuPkqTOQJ7/xvaAjnKk0ztxtDmW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796708"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796708"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018727"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018727"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:39:00 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCHv2 6/6] arm64: dts: socfpga: add hwmon properties
Date:   Mon,  8 May 2023 16:28:52 -0500
Message-Id: <20230508212852.8413-6-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Add the hardware monitoring properties for Stratix10 and Agilex.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
v2: add platform specific platforms to DTS files
---
 .../boot/dts/altera/socfpga_stratix10.dtsi    |  4 ++
 .../dts/altera/socfpga_stratix10_socdk.dts    | 31 +++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  4 ++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex_socdk.dts   | 66 +++++++++++++++++++
 .../dts/intel/socfpga_agilex_socdk_nand.dts   | 66 +++++++++++++++++++
 .../boot/dts/intel/socfpga_n5x_socdk.dts      | 47 +++++++++++++
 7 files changed, 284 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 41c9eb51d0ee..2526afa687d6 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -633,6 +633,10 @@ svc {
 				fpga_mgr: fpga-mgr {
 					compatible = "intel,stratix10-soc-fpga-mgr";
 				};
+
+				hwmon: temp-volt {
+					compatible = "intel,socfpga-stratix10-hwmon", "intel,socfpga-hwmon";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 38ae674f2f02..d506dcf8dc7c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -212,3 +212,34 @@ qspi_rootfs: partition@3FE0000 {
 		};
 	};
 };
+
+&hwmon {
+	voltage {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		input@2 {
+			label = "0.8V VCC";
+			reg = <2>;
+		};
+
+		input@3 {
+			label = "1.0V VCCIO";
+			reg = <3>;
+		};
+
+		input@6 {
+			label = "0.9V VCCERAM";
+			reg = <6>;
+		};
+	};
+
+	temperature {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		input@0 {
+			label = "Main Die SDM";
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index f9674cc46764..552f9a05d039 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -666,6 +666,10 @@ svc {
 				fpga_mgr: fpga-mgr {
 					compatible = "intel,agilex-soc-fpga-mgr";
 				};
+
+				hwmon: temp-volt {
+					compatible = "intel,socfpga-agilex-hwmon", "intel,socfpga-hwmon";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index 6231a69204b1..c0642353b506 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -64,3 +64,69 @@ &watchdog0 {
 &fpga_mgr {
 	status = "disabled";
 };
+
+&hwmon {
+	voltage {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		input@2 {
+			label = "0.8V VCC";
+			reg = <2>;
+		};
+
+		input@3 {
+			label = "1.8V VCCIO_SDM";
+			reg = <3>;
+		};
+
+		input@4 {
+			label = "1.8V VCCPT";
+			reg = <4>;
+		};
+
+		input@5 {
+			label = "1.2V VCCCRCORE";
+			reg = <5>;
+		};
+
+		input@6 {
+			label = "0.9V VCCH";
+			reg = <6>;
+		};
+
+		input@7 {
+			label = "0.8V VCCL";
+			reg = <7>;
+		};
+	};
+
+	temperature {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		input@0 {
+			label = "Main Die SDM";
+			reg = <0x0>;
+		};
+
+		input@10000 {
+			label = "Main Die corner bottom left max";
+			reg = <0x10000>;
+		};
+
+		input@20000 {
+			label = "Main Die corner top left max";
+			reg = <0x20000>;
+		};
+
+		input@30000 {
+			label = "Main Die corner bottom right max";
+			reg = <0x30000>;
+		};
+
+		input@40000 {
+			label = "Main Die corner top right max";
+			reg = <0x40000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 07c3f8876613..4bd8cdd8a7ca 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -138,3 +138,69 @@ qspi_rootfs: partition@3FE0000 {
 		};
 	};
 };
+
+&hwmon {
+	voltage {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		input@2 {
+			label = "0.8V VCC";
+			reg = <2>;
+		};
+
+		input@3 {
+			label = "1.8V VCCIO_SDM";
+			reg = <3>;
+		};
+
+		input@4 {
+			label = "1.8V VCCPT";
+			reg = <4>;
+		};
+
+		input@5 {
+			label = "1.2V VCCCRCORE";
+			reg = <5>;
+		};
+
+		input@6 {
+			label = "0.9V VCCH";
+			reg = <6>;
+		};
+
+		input@7 {
+			label = "0.8V VCCL";
+			reg = <7>;
+		};
+	};
+
+	temperature {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		input@0 {
+			label = "Main Die SDM";
+			reg = <0x0>;
+		};
+
+		input@10000 {
+			label = "Main Die corner bottom left max";
+			reg = <0x10000>;
+		};
+
+		input@20000 {
+			label = "Main Die corner top left max";
+			reg = <0x20000>;
+		};
+
+		input@30000 {
+			label = "Main Die corner bottom right max";
+			reg = <0x30000>;
+		};
+
+		input@40000 {
+			label = "Main Die corner top right max";
+			reg = <0x40000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 51f83f96ec65..bfee1ca0bd6e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -114,3 +114,69 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&hwmon {
+	voltage {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		input@2 {
+			label = "0.8V VCC";
+			reg = <2>;
+		};
+
+		input@3 {
+			label = "1.8V VCCIO_SDM";
+			reg = <3>;
+		};
+
+		input@4 {
+			label = "1.8V VCCPT";
+			reg = <4>;
+		};
+
+		input@5 {
+			label = "1.2V VCCCRCORE";
+			reg = <5>;
+		};
+
+		input@6 {
+			label = "0.9V VCCH";
+			reg = <6>;
+		};
+
+		input@7 {
+			label = "0.8V VCCL";
+			reg = <7>;
+		};
+	};
+
+	temperature {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		input@0 {
+			label = "Main Die SDM";
+			reg = <0x0>;
+		};
+
+		input@10000 {
+			label = "Main Die corner bottom left max";
+			reg = <0x10000>;
+		};
+
+		input@20000 {
+			label = "Main Die corner top left max";
+			reg = <0x20000>;
+		};
+
+		input@30000 {
+			label = "Main Die corner bottom right max";
+			reg = <0x30000>;
+		};
+
+		input@40000 {
+			label = "Main Die corner top right max";
+			reg = <0x40000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 08c088571270..090b0382db98 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -129,3 +129,50 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&hwmon {
+	compatible = "intel,socfpga-n5x-hwmon", "intel,socfpga-hwmon";
+	voltage {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		input@2 {
+			label = "0.8V VDD";
+			reg = <2>;
+		};
+
+		input@3 {
+			label = "0.8V VDD_SDM";
+			reg = <3>;
+		};
+
+		input@4 {
+			label = "1.8V VCCADC";
+			reg = <4>;
+		};
+
+		input@5 {
+			label = "1.8V VCCPD";
+			reg = <5>;
+		};
+
+		input@6 {
+			label = "1.8V VCCIO_SDM";
+			reg = <6>;
+		};
+
+		input@7 {
+			label = "0.8V VDD_HPS";
+			reg = <7>;
+		};
+	};
+
+	temperature {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		input@0 {
+			label = "Main Die SDM";
+			reg = <0x0>;
+		};
+	};
+};
-- 
2.40.0

