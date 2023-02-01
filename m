Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC49C6862B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBAJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:21:12 -0500
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 01:21:10 PST
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33783B64B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:21:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675242797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DS/uJDmsJIF4f3HNKFPKSCWe/LmhrIUEuIGlaX1YzoQ=;
        b=R2GqVBvqDPlaiv0H07DLTuRb5J4wn65xwoK7oZnlceG7INyE682cEWbLFRe9bEU+9mVox6
        3F72yy1DAVvvNikZ1ASvZj93CE39fm2lVianNwFcynQWKiYXtBLD9V/4gn/O4WUxaoghc2
        FVmPaTk4gstZriOFoaVH2XW3TgBIx5Q=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH] clk: sprd: Add dependency for SPRD_UMS512_CLK
Date:   Wed,  1 Feb 2023 17:13:00 +0800
Message-Id: <20230201091300.3201-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Add depends on and default for ums512 clk config.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/clk/sprd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
index c744bd9d2f96..2f19c8d58ff2 100644
--- a/drivers/clk/sprd/Kconfig
+++ b/drivers/clk/sprd/Kconfig
@@ -24,6 +24,8 @@ config SPRD_SC9863A_CLK
 
 config SPRD_UMS512_CLK
 	tristate "Support for the Spreadtrum UMS512 clocks"
+	depends on (ARM64 && ARCH_SPRD) || COMPILE_TEST
+	default ARM64 && ARCH_SPRD
 	help
 	  Support for the global clock controller on ums512 devices.
 	  Say Y if you want to use peripheral devices on ums512 SoC.
-- 
2.34.1

