Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56A6775BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAWHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAWHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:38:32 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC093ED
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674459454; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dbYpjYSJH3h0lRF/4B7JiQ4/eC8ll/qGf2ftlPnQvSVZ+VqF4+wjlkd3StLpEmVs67QGYRwevZWpowZ832rsbQgw4L1onRANkABRe2lIqh6Erh7nF7OeuJfn326+eTCctTZnk+YtDcriBuYHmel98anxuc1XOlix/uOUcKsXz9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674459454; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=cSIIxAdcbotYly86BelrBgIcY293NSaG3FrGFXhFFJw=; 
        b=ZCRju3zEmh+VcinNzxoBNHF2XiogmvppzsHEkDQ0nwIa+IhOD21q78hln23nrLx8MwUoqBKXk5OyE/D15XfD7abE9I+l4SSVaGYg3NoCntJ8grG1avxVw8aoa31V9d8Wl1hgWOK4FiAmP6S/pTzICD4ohduhwjOPuZSDMZyBtVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<lchen@ambarella.com>
Received: from shbuild9.ambarella.net (116.246.37.178 [116.246.37.178]) by mx.zohomail.com
        with SMTPS id 167445945243625.57623052088718; Sun, 22 Jan 2023 23:37:32 -0800 (PST)
From:   Li Chen <lchen@ambarella.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/15] arm64: Kconfig: Introduce CONFIG_ARCH_AMBARELLA
Date:   Mon, 23 Jan 2023 15:32:20 +0800
Message-Id: <20230123073305.149940-6-lchen@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123073305.149940-1-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a Kconfig option to toggle support
for Ambarella ARM SoCs.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: I41345f5052b08023d399cb9db3faa228ca54d265
---
 arch/arm64/Kconfig.platforms | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab..8def8aaca0c4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -8,6 +8,15 @@ config ARCH_ACTIONS
 	help
 	  This enables support for the Actions Semiconductor S900 SoC family.
 
+config ARCH_AMBARELLA
+	bool "Ambarella ARMv8 SoC Family"
+	select PINCTRL
+	select PINCTRL_AMB
+	select RATIONAL
+	help
+	  This enables support for Ambarella ARMv8 SoC Family starting
+          from s6lm.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.34.1

