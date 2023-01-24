Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7C67A0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjAXSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjAXSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:16:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670954AA63
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fY3WclIGTvkM31tI4bLOjCsMCGC/hbazodU9XQ98Dh0=; b=U6NSpKFt6oQhoked6gxqCbONGH
        TtZYDEUv7ampOPer7qR1Xef23S6gEJg8JZKySWT6RWQ/XUUZJ1+O9jYwMhU7Hg1NSl1GLAEGOpquL
        +QzhiFafc+RCkuYDS1Tb9dvoZNR+C1kbpC8IyZFBvZpRAeBBDiQZc2JXIGiVgX3xD/+GSoEmcHjHG
        DcX/84v87CYCkEvQycZ7SXhDS314ZQ9XRWp1OFI9R9KCTgnrvIWYkb6tPT7iwNcmWMbgaa5XcgEJs
        BBGyUunnFawM1SumBeqKMGSycbsEhlpirMvMHltyAJGtAkKVuKUI3zYgzSOIE86wCOYFBpcymFTpU
        8081ghFQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNq2-004vTi-I4; Tue, 24 Jan 2023 18:16:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Kconfig: fix spelling
Date:   Tue, 24 Jan 2023 10:16:05 -0800
Message-Id: <20230124181605.14144-1-rdunlap@infradead.org>
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

Fix spelling typos in arm64: (reported by codespell)
s/upto/up to/
s/familly/family/

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig           |    2 +-
 arch/arm64/Kconfig.platforms |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/Kconfig b/arch/arm64/Kconfig
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1499,7 +1499,7 @@ config ARCH_FORCE_MAX_ORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 11 means that the largest free memory block is 2^10 pages.
 
-	  We make sure that we can allocate upto a HugePage size for each configuration.
+	  We make sure that we can allocate up to a HugePage size for each configuration.
 	  Hence we have :
 		MAX_ORDER = (PMD_SHIFT - PAGE_SHIFT) + 1 => PAGE_SHIFT - 2
 
diff -- a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -187,7 +187,7 @@ config ARCH_MVEBU
 	select PINCTRL_ARMADA_CP110
 	select PINCTRL_AC5
 	help
-	  This enables support for Marvell EBU familly, including:
+	  This enables support for Marvell EBU family, including:
 	   - Armada 3700 SoC Family
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
