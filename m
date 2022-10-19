Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673D604B08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiJSPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiJSPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB787192988
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EAD661908
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1C6C433D6;
        Wed, 19 Oct 2022 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192147;
        bh=zUtsmVJ8rL6oHo3JZVWiCC7ZDlsk1P/m+Y1Ap7DEApY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzLJa/CUu5Mi0FdieqPlUEzMbFAQxp2ZABzGUDmbvMh5z6+G73KNBB4VUIbkHQuz6
         MiiQ4rFsc38AvFb9ut3/URT/bL+1yI5jQf0o19A1KyfCgx2DV4HHHDcZGPWp+GTBd0
         HOMfz+P9LK568wYAA/g5r/OSX1P3OP/e5JvJ0iddOsdCLtiwi8bN/WZTt6KPuszeSw
         HQuPwRLumAY0V/Eo6AjSBVia5hjeVX0Bb5cQ1zzrxbYoZDtcOwz0vjcrhbflv1VzfQ
         m/5Swk+7F6fyGgumh3zo9PIzeItRIFxfx53ysoZwpHxaIr2vSITGh//PY4gyBN7qxp
         aV7m/rAjtzFBg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 06/17] ARM: mv78xx0: un-deprecate Terastation WXL
Date:   Wed, 19 Oct 2022 17:03:28 +0200
Message-Id: <20221019150410.3851944-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This board is still being worked on by the Debian-on-Buffalo
project, so let's leave it in the tree for now.

Link: https://github.com/1000001101000/Debian_on_Buffalo
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/mv78xx0_defconfig | 1 -
 arch/arm/mach-mv78xx0/Kconfig      | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 877c5150a987..f02f29d3fecb 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -17,7 +17,6 @@ CONFIG_MACH_TERASTATION_WXL=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_FPE_NWFPE=y
-CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index da92f94494cc..0464b732ead4 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -3,7 +3,7 @@ menuconfig ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	depends on ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
-	depends on ATAGS && UNUSED_BOARD_FILES
+	depends on ATAGS
 	select CPU_FEROCEON
 	select GPIOLIB
 	select MVEBU_MBUS
@@ -17,12 +17,14 @@ if ARCH_MV78XX0
 
 config MACH_DB78X00_BP
 	bool "Marvell DB-78x00-BP Development Board"
+	depends on UNUSED_BOARD_FILES
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-78x00-BP Development Board.
 
 config MACH_RD78X00_MASA
 	bool "Marvell RD-78x00-mASA Reference Design"
+	depends on UNUSED_BOARD_FILES
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell RD-78x00-mASA Reference Design.
-- 
2.29.2

