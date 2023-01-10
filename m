Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E968663A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAJIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjAJIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:01:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98795F7A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6955AB81128
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A0C433D2;
        Tue, 10 Jan 2023 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673337706;
        bh=4DbMRmg8+IursOw5O7v8oTrvD4RrdJthfiKf942CnmE=;
        h=From:To:Cc:Subject:Date:From;
        b=Xc55i1JAozZNfvVNzALMMJWHv1Uxl0JM9oHzKcvUnJoHYJXjhbwSsL+QJOl3Pd3DG
         sxbYRPnq0bO3jbW3q9rTNra3WgUCxsBvCryKKaUi82kx/bz6ShAoiXyHaQXQE9AGtA
         KbMNoDfeQxEQMxerls1piKtp9PY/WUKP3TY0HoPl9zk8dJuCIntoClOdFTBX0/1TF9
         YT9t2xgY9MeJoxssRT+Gg4Z9C37iqh31avxQF0G2pOGPJtp3kxuVG8WVFXgmxCvqLp
         iOGwv3VKRQGxJKhkqYUl6VYI95gG75TDp66Uk3kmsXqacyw2Hsf7C5lbprw0JgU5Nq
         9CskxBwxHqJjA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: remove meaningless arch/arm/mach-rda/Makefile
Date:   Tue, 10 Jan 2023 17:01:29 +0900
Message-Id: <20230110080130.160528-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to put Makefile if there is nothing to compile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.2-rc1

 arch/arm/Makefile          | 1 -
 arch/arm/mach-rda/Makefile | 2 --
 2 files changed, 3 deletions(-)
 delete mode 100644 arch/arm/mach-rda/Makefile

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4067f5169144..233496bfbe19 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -213,7 +213,6 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
-machine-$(CONFIG_ARCH_RDA)		+= rda
 machine-$(CONFIG_ARCH_REALTEK)		+= realtek
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-rda/Makefile b/arch/arm/mach-rda/Makefile
deleted file mode 100644
index f126d00ecd53..000000000000
--- a/arch/arm/mach-rda/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj- += dummy.o
-- 
2.34.1

