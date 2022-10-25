Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3060D42F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJYSwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiJYSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01A411D992;
        Tue, 25 Oct 2022 11:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A5B961B01;
        Tue, 25 Oct 2022 18:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A1C433C1;
        Tue, 25 Oct 2022 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666723921;
        bh=24HtZK+64pLjoLqyjcZ8BB1o6F2FHMPWQnmPxc1FREE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXu0HXtunY8YsogpiEksmr93n4mws9Q2kUIDlnfxJn0KFEMaWDlWMo4Dxa+IB6mHP
         ZnHHrLX9qrFSoVXQZumVgtIlcToiLp32NVkbYBEZREYLQm2X32mHrgdZjtZOkDcwsE
         +0+MksywdKu70mT7YCdNXMoW0ggPwIOH4KL1zdt1pmG9hN8lbBHRFP2rpoTtlca0Si
         +SkpVvu17UJekXd/a8EnVbkMjodJUwQP28GWj+WbPqqb0Jl+j12br5KoiVjKpG0Bpm
         YXbf2FOgVM7zyBp9XS2l257UtHmrhdb+uJH/M/f+mJwt/kAqJ7fmE/1/YIiavJJsE3
         H+tMjBA2IC+Yw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] PCI: Remove unnecessary <linux/of_irq.h> includes
Date:   Tue, 25 Oct 2022 13:51:47 -0500
Message-Id: <20221025185147.665365-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025185147.665365-1-helgaas@kernel.org>
References: <20221025185147.665365-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Many host controller drivers #include <linux/of_irq.h> even though they
don't need it.  Remove the unnecessary #includes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/cadence/pci-j721e.c   | 1 -
 drivers/pci/controller/dwc/pci-layerscape.c  | 1 -
 drivers/pci/controller/dwc/pcie-armada8k.c   | 1 -
 drivers/pci/controller/dwc/pcie-tegra194.c   | 1 -
 drivers/pci/controller/pci-v3-semi.c         | 1 -
 drivers/pci/controller/pci-xgene-msi.c       | 1 -
 drivers/pci/controller/pci-xgene.c           | 1 -
 drivers/pci/controller/pcie-altera-msi.c     | 1 -
 drivers/pci/controller/pcie-iproc-platform.c | 1 -
 drivers/pci/controller/pcie-iproc.c          | 1 -
 drivers/pci/controller/pcie-microchip-host.c | 1 -
 drivers/pci/controller/pcie-rockchip-host.c  | 1 -
 drivers/pci/controller/pcie-xilinx-cpm.c     | 1 -
 drivers/pci/controller/pcie-xilinx-nwl.c     | 1 -
 14 files changed, 14 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a82f845cc4b5..cc83a8925ce0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 879b8692f96a..ed5fb492fe08 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index dc469ef8e99b..5c999e15c357 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/of_pci.h>
-#include <linux/of_irq.h>
 
 #include "pcie-designware.h"
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b6b437823d2..02d78a12b6e7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -21,7 +21,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a5398633c..784fcf35599c 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index bfa259781b69..5efc6e56559f 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -10,7 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/msi.h>
-#include <linux/of_irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 549d3bd6d1c2..887b4941ff32 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 4366e042e98b..65e8a20cc442 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 538115246c79..4142a73e611d 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 2519201b0e51..83029bdfd884 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 57b2a62f52c8..0ebf7015e9af 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 7352b5ff8d35..c96c0f454570 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -28,7 +28,6 @@
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index e4ab48041eb6..4a787a941674 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pci-ecam.h>
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 40d070e54ad2..f0271b6c6f8d 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -17,7 +17,6 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
-- 
2.25.1

