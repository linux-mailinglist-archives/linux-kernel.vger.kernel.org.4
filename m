Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D216A077E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjBWLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjBWLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:37:16 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48C4D61B;
        Thu, 23 Feb 2023 03:37:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 003183200344;
        Thu, 23 Feb 2023 06:37:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 06:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677152230; x=1677238630; bh=JC
        tc1LAvAhfDA4RG+C6XypPUVxwDMaGgizoOrWjZThg=; b=GaGS+u0+rSSVKUsd0i
        sqoeElcfMYYLQ6byq2QORQKnsEyh4C9ROAnOx5KCKLg+OK8S/bh5E6b2vISXmNHk
        GVyzyZ5ZcblpzFCCI+JrWZdEgID5xaAtzVeRyHqR2RhxwQ8/nsxMOhYkXTYHWv9X
        gu5/M31EZV00ws+MBFy7qOkrGQxKM/ZiaEONGv73b3j7ER339LSqQPtJDKdIaRlL
        HadjA9m4YYtPknnPRO3LIigtxwdJroHbAsYGfXGO3FWuZTO76BuDwmnsyaShBY43
        6edfXfb02cc4LKRKPTYuv7ROH01hV3qzMKSEng35z/DF4sXK24OGiABAvRnUCZU9
        H3Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677152230; x=1677238630; bh=JCtc1LAvAhfDA
        4RG+C6XypPUVxwDMaGgizoOrWjZThg=; b=XEXwTCTny+b8L3t8CwaoU6u0aDE61
        F4+JgeR6y6jkE3FZRhOZ6h9fBdNHQxArpyLqc6RH5mYylc9qBgtbRWMBuUdlt3zd
        nfMvWfZaTK9nGXEIN8tYbeK7Cxlq0lubZsrTS6dGLmvy9SCWiTqkukwv45wQq3/z
        KwiXX6jzGAT0huYCYPBU4R/6ldTwBT8kjoLZLab5Nt4g/dHfWbz/+OmVWiMCynNZ
        TkMHjwJCQe78ux6lkTDVMa8h1d+N3vhePV0YNE7jI+ZHm3rVjVyrXyEczaoNBzXg
        Zsg4m6S8x19lG4Zw2p1hSRdyTQpSxDZcjmKOhy260HWtIHadWdou5iOMw==
X-ME-Sender: <xms:5k_3Y6VfTDyIbHXW-IkEobTC3947Y3bdCvGsX8EoXuQDaEk14Lqfgg>
    <xme:5k_3Y2kThdS_OiHuEXX-dS1lAxh5SxFkP41bOub0FkFDyYGJkXQkugxFvX-018VOJ
    3FvAAYbxxR8mpoCdSY>
X-ME-Received: <xmr:5k_3Y-bxRfaSIW4pBiV_5krQMGEPwMEabpcwbRYFQ0y5vdLTAUO3rY9ap4oCMNkLTaG4JRt0lqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:5k_3YxUPCGxhOjthwIDhT6mVOBkqXSX2GmIx8buR1W8Iss_zKg5PPA>
    <xmx:5k_3Y0kOm5aDTj3uWXYvwlf1C15owKbDTPp1KIwsh6-T8_T28rKFNQ>
    <xmx:5k_3Y2dHDWlFegs8mF3O8NLG8f3c4l7z8wyTFSQq0MSOvAQCGrcu_g>
    <xmx:5k_3Y-cBMACkQ2aoU5UYsAa4dDKAbeuwvZIsw5gCakdORlZa3ZSwfw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 06:37:07 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/5] dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
Date:   Thu, 23 Feb 2023 11:36:42 +0000
Message-Id: <20230223113644.23356-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a kconfig option to allow arches to manipulate default
value of dma_default_coherent in Kconfig.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 kernel/dma/Kconfig   | 3 +++
 kernel/dma/mapping.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 56866aaa2ae1..968108fdf9bf 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -76,6 +76,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_DMA_DEFAULT_COHERENT
+	bool
+
 config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 80f9663ffe26..9a4db5cce600 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -20,7 +20,7 @@
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-bool dma_default_coherent;
+bool dma_default_coherent = IS_ENABLED(CONFIG_ARCH_DMA_DEFAULT_COHERENT);
 #endif
 
 /*
-- 
2.37.1 (Apple Git-137.1)

