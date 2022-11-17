Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC9C62D7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiKQKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:25:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F53E55;
        Thu, 17 Nov 2022 02:25:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19C213D5;
        Thu, 17 Nov 2022 02:25:53 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E35B3F73B;
        Thu, 17 Nov 2022 02:25:46 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: fvp: Add SPE to Foundation FVP
Date:   Thu, 17 Nov 2022 10:25:36 +0000
Message-Id: <20221117102536.237515-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPE DT node to FVP model. If the model doesn't support SPE (e.g.,
turned off via parameter), the driver will skip the initialisation
accordingly and thus is safe.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 83e3e7e3984f..b8c1a674fb43 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -84,6 +84,11 @@ pmu {
 			     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	spe-pmu {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	watchdog@2a440000 {
 		compatible = "arm,sbsa-gwdt";
 		reg = <0x0 0x2a440000 0 0x1000>,
-- 
2.25.1

