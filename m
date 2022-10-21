Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068D3607B80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJUPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJUPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA41CFF32
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E8A61EFE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287FAC433C1;
        Fri, 21 Oct 2022 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367474;
        bh=02xgHKl4J6URwRa+LsuMzm/BT2QzQWcjATRH+/1NXmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5MxsZijGVQcLEfZ/4jOYJqbyLeaXVg4fZQNSs6wIwcaCtndHDyn/peNwSBm+qjr5
         UWSYVEHNTK4WOzNCIaUoyHs6UAPDYhXQF9uk3YjEbSqCdn20hL/MRf3P/mw9cX5r9D
         uX7mHiq938HYSBwC9n2Ha8qCPlX+CxiSb9v8vWS4sgMcVETToEz6qPJBdOecmgkLFA
         vSFN4CnF2zlJLMkB4G/9pNumDFa5M6qKjfysjNgsRq755Wz1gZrnZJ02H9U0yHcj6l
         A21Cfl96Kwx5YWMcA6wfO9A+GewWs7pX4OxWp5nrJ80ac68VFC3OsOdSMhsWNCjEPv
         75hCseYpWWflw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stefan Lehner <stefan-lehner@aon.at>
Subject: [PATCH 01/11] ARM: sa1100: un-deprecate jornada720
Date:   Fri, 21 Oct 2022 17:49:31 +0200
Message-Id: <20221021155000.4108406-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Stefan is still trying to get this machine working again, so it won't
be removed in this round.

Cc: Stefan Lehner <stefan-lehner@aon.at>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/jornada720_defconfig | 1 -
 arch/arm/mach-sa1100/Kconfig          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index ae1d68da4f2a..91bdcc095884 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -6,7 +6,6 @@ CONFIG_ARCH_MULTI_V4=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
-CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index fb9cd10705de..8b6360e363d1 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -109,7 +109,6 @@ config SA1100_BADGE4
 
 config SA1100_JORNADA720
 	bool "HP Jornada 720"
-	depends on UNUSED_BOARD_FILES
 	# FIXME: select ARM_SA11x0_CPUFREQ
 	select SA1111
 	help
-- 
2.29.2

