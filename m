Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8A5E6503
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIVOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiIVOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:20:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91C85895F5;
        Thu, 22 Sep 2022 07:20:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72BD22BE;
        Thu, 22 Sep 2022 07:20:49 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3B53F73B;
        Thu, 22 Sep 2022 07:20:41 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: arm: add copyright messages (Linaro)
Date:   Thu, 22 Sep 2022 15:20:10 +0100
Message-Id: <20220922142010.1412640-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922142010.1412640-1-andre.przywara@arm.com>
References: <20220922142010.1412640-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPL license seems to require an explicit copyright statement.

Add the appropriate line into files which were lacking this. This
assigns the copyright to Linaro, for files which were originally
contributed by Linaro employees or assignees.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts            | 2 ++
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi            | 5 +++++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 45cef48378d07..9d0d1a39b9c31 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -2,6 +2,8 @@
 /*
  * ARM Ltd. Fast Models
  *
+ * Copyright (c) 2017-2022 Linaro Ltd.
+ *
  * Architecture Envelope Model (AEM) ARMv8-A
  * ARMAEMv8AMPCT
  *
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 4299287e1e284..e9f2eb53712d8 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/*
+ * Arm Juno board common Coresight definitions
+ *
+ * Copyright (c) 2017-2022 Linaro Ltd.
+ */
 / {
 	funnel@20130000 { /* cssys1 */
 		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
index 9dd155ef09ab3..44a6e7ad287c3 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
@@ -2,6 +2,8 @@
 /*
  * ARM Ltd. Fast Models
  *
+ * Copyright (c) 2017-2022 Linaro Ltd.
+ *
  * "rs2" extension for the v2m motherboard
  */
 / {
-- 
2.25.1

