Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9E6CFF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjC3JR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC3JRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:17:06 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9777DA5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=PfPZKp62ZUfMvI3fqeh72mzhaSf7vvFEI18bulM/FrI=;
        b=gTE0TsMBwKVLxEbNOrzWrtH71pn1o+UlfqzsRG8/3UmX0iJ2rWvmntfY4g8DsNe7LPrmtWZCcxq2O
         zIS7wl5qQ852E6qOJRU+hcwEd//h4U6pjI7bLhG9Rj32t08tD1R0/AmRTA7wwKnQKCoz3UvPRTAoGb
         jj6f82uZnheU/dwxN4DGcqqghUd2M4haooD0aZYGv6yPx09z43PFAV4+kiOeNs/sHd8FHuk4auFjBc
         xcI7l29bBIq1Tml+ALIp2IxGDVGDX/59XLVquMFgrWvniwOmnXwQHeCQmtuczfWENIACeTeh/lxuGZ
         zIn9QB9TbMvPlxwRuFf6S08xUnNVOZw==
X-MSG-ID: 85abb958-cedb-11ed-a150-0050569d11ae
From:   Roan van Dijk <roan@protonic.nl>
To:     corbet@lwn.net
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-doc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v2] ARM: stm32: add initial documentation for STM32MP151
Date:   Thu, 30 Mar 2023 11:16:13 +0200
Message-Id: <20230330091613.1445734-1-roan@protonic.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds initial documentation of STM32MP151 microprocessor (MPU)
based on Arm Cortex-A7.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---

v2: 
 - Adds stm32mp151 to index.rst

 Documentation/arm/index.rst                   |  1 +
 .../arm/stm32/stm32mp151-overview.rst         | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32mp151-overview.rst

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index ae42fe886f0d..056ac11372af 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -58,6 +58,7 @@ SoC-specific documents
    stm32/stm32f769-overview
    stm32/stm32f429-overview
    stm32/stm32mp13-overview
+   stm32/stm32mp151-overview
    stm32/stm32mp157-overview
    stm32/stm32-dma-mdma-chaining
 
diff --git a/Documentation/arm/stm32/stm32mp151-overview.rst b/Documentation/arm/stm32/stm32mp151-overview.rst
new file mode 100644
index 000000000000..f42a2ac309c0
--- /dev/null
+++ b/Documentation/arm/stm32/stm32mp151-overview.rst
@@ -0,0 +1,36 @@
+===================
+STM32MP151 Overview
+===================
+
+Introduction
+------------
+
+The STM32MP151 is a Cortex-A MPU aimed at various applications.
+It features:
+
+- Single Cortex-A7 application core
+- Standard memories interface support
+- Standard connectivity, widely inherited from the STM32 MCU family
+- Comprehensive security support
+
+More details:
+
+- Cortex-A7 core running up to @800MHz
+- FMC controller to connect SDRAM, NOR and NAND memories
+- QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- ADC/DAC
+- USB EHCI/OHCI controllers
+- USB OTG
+- I2C, SPI busses support
+- Several general purpose timers
+- Serial Audio interface
+- LCD-TFT controller
+- DCMIPP
+- SPDIFRX
+- DFSDM
+
+:Authors:
+
+- Roan van Dijk <roan@protonic.nl>
-- 
2.37.2

