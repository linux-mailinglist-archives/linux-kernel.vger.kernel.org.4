Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655536DC8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDJPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDJPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:43:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF049EC;
        Mon, 10 Apr 2023 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681141379; x=1712677379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ym2cho9LOcQwyXbTc9OkJFyWAtaHr3Us3FO9g6jBII=;
  b=PaHoH9EDdCTl3J1sAeODk+KuVDVk0DKSsjijcR97ArbYc08OINR9E/U6
   DMIW9nY7NaUaMglnbJPZI+Zl0fZjgPBt0CJ7geI4sEi+Rd8MJvYfCmb1G
   /s4xJSlZ3hqxcmpqbCuiCGPvoCzKDh65tQ9tSd654ibDr+sPpnnIrbskc
   DYKznVb7UN942w3Eh9AMG35UbsRHLCh94MkFooJZTSReds4wRxngxc4HK
   Gpj+yMYiVyKe/uy7pvX7B8zlnRaoEWxxWm4KhwPNuZrsJ40Iq2e4d+53a
   joXV9hR1CjKWqNScmm0MkcgmffV3zSNZrBSUPNzMeRFzsVRwVmvMcjvOZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340868175"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="340868175"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757482052"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="757482052"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:57 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCH 5/5] arm64: dts: socfpga: add hwmon properties
Date:   Mon, 10 Apr 2023 10:33:14 -0500
Message-Id: <20230410153314.27127-5-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Add the hardware monitoring properties for Stratix10 and Agilex.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 .../boot/dts/altera/socfpga_stratix10.dtsi    |  4 ++
 .../dts/altera/socfpga_stratix10_socdk.dts    | 31 +++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  4 ++
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex_socdk.dts   | 66 +++++++++++++++++++
 .../dts/intel/socfpga_agilex_socdk_nand.dts   | 66 +++++++++++++++++++
 .../boot/dts/intel/socfpga_n5x_socdk.dts      | 46 +++++++++++++
 7 files changed, 283 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 41c9eb51d0ee..0efb570d27e5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -633,6 +633,10 @@ svc {
 				fpga_mgr: fpga-mgr {
 					compatible = "intel,stratix10-soc-fpga-mgr";
 				};
+
+				temp_volt: hwmon {
+					compatible = "intel,socfpga-hwmon";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 38ae674f2f02..eb0880a49f77 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -212,3 +212,34 @@ qspi_rootfs: partition@3FE0000 {
 		};
 	};
 };
+
+&temp_volt {
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
index f9674cc46764..d6cc52a48599 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -666,6 +666,10 @@ svc {
 				fpga_mgr: fpga-mgr {
 					compatible = "intel,agilex-soc-fpga-mgr";
 				};
+
+				temp_volt: hwmon {
+					compatible = "intel,socfpga-hwmon";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index 6231a69204b1..09ce00fe42d1 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -64,3 +64,69 @@ &watchdog0 {
 &fpga_mgr {
 	status = "disabled";
 };
+
+&temp_volt {
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
index 07c3f8876613..9af029e5633e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -138,3 +138,69 @@ qspi_rootfs: partition@3FE0000 {
 		};
 	};
 };
+
+&temp_volt {
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
index 51f83f96ec65..d3576bb8b04d 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -114,3 +114,69 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&temp_volt {
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
index 08c088571270..70b9f0e56cc5 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -129,3 +129,49 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&temp_volt {
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

