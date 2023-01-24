Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3280267A100
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjAXSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjAXSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:16:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FA4DCE7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7HLv6JUdWo3a6lOvE7kKnizTw2Gyv5qaUaYkOnWYnIA=; b=p8I9AiVYk8jR0wP+yThgsV9eJc
        p0qcmriRrXR8KmQKIV1lMjk1Ghn43CTVk7HT+U80VpVVZcV9NEa4kfEinjbYrPabj+0QGDmdaxCBz
        44ZUC1HRFrC10AbCN/SWHhjtEIgDizjrHQQwIcc7AM0fQ76LZDcXubs6JjS0nH9QvfS8frCKOBQ2i
        8nDuMGXgX8g+71EEp1AVpUwFIdrT7m13zIwH5OeNv4GDF9ULKtmWY2FRzrX+yrB3Sy4d0xq1mT/Fg
        SrSR11veimQrOKNiKFtJAeWb58hIEzs0yJdz0g4jfFwm4xuB3kwzLKiHu5kUaXQI2bLuwlA0X6B0w
        H6vFpltw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNqF-004vVX-Ci; Tue, 24 Jan 2023 18:16:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH] arm: Kconfigs: fix spelling & grammar
Date:   Tue, 24 Jan 2023 10:16:18 -0800
Message-Id: <20230124181618.14643-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling (reported by codespell) and grammar in Arm Kconfig files.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 6.2-rc4

 arch/arm/Kconfig.debug |    4 ++--
 arch/arm/mm/Kconfig    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1206,8 +1206,8 @@ choice
 		depends on MACH_STM32MP157
 		select DEBUG_STM32_UART
 		help
-		  Say Y here if you want kernel low-level debugging support
-		  on STM32MP1 based platforms, wich default UART is wired on
+		  Say Y here if you want kernel low-level debugging support on
+		  STM32MP1-based platforms, where the default UART is wired to
 		  UART4, but another UART instance can be selected by modifying
 		  CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT.
 
diff -- a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -743,7 +743,7 @@ config SWP_EMULATE
 	  If unsure, say Y.
 
 choice
-	prompt "CPU Endianess"
+	prompt "CPU Endianness"
 	default CPU_LITTLE_ENDIAN
 
 config CPU_LITTLE_ENDIAN
