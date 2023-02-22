Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAC69F5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBVNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjBVNh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:37:26 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9535FA;
        Wed, 22 Feb 2023 05:37:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EC025C005D;
        Wed, 22 Feb 2023 08:37:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Feb 2023 08:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677073044; x=1677159444; bh=5z
        jeAJ2ng0uc67KhUvTeOlPjTfztQbBqYYqvTXy2dRg=; b=CnrFptuFsGKJRUfj22
        eCJvIHR1rJ4rKKwuCSdvEU+t9keMUDYPlDxrKcdqiW0vC5egsutD5g7hoY5HP4i7
        HMkxMbTWzCvonUHl+cEPckRAYx9ZmgvBYs2nTFAyLcI3uiAuukwtflA0h+n2BMtX
        D4c4H29o/Biee/U8QEwpNnT81CSqOzpHNXdTD4PuyxAFkqEbEnSY7rkqI4Zv/IBO
        lZQhHbZED7ZdPdCJW2zwOxN+gyQ0kfwifvdgTVupijeB/M1YFFTKGMxH8T7/XBY8
        s0ryQ9kNXOEtaL17+KH3VNxIVNIK3CaT5rB/phV5snAiLpuwPiJ7jysU0003Jk0t
        hpFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677073044; x=1677159444; bh=5zjeAJ2ng0uc6
        7KhUvTeOlPjTfztQbBqYYqvTXy2dRg=; b=VzXR1xbEz1IC9r9+uv9wPm7aP/JYm
        taOclHyTm8DhAhbYsRGnFHa5ifieabUyklQVcAaMOmmh1jOttMTuNN64yGb1pkJo
        ZN9lsKeIetM7xEYG3zU2Ko30dMLs29mKeKRZdqM1lTWf/1XFEHmBtRTEwPh1yNwO
        IFHfS6W/kMf3DxmGvR562tP06uxyuItekl0iqQQfMxtQNa+vRe+uhaE8Xv3mvxVV
        SDLkEfgUkGrH+CXQwWdFMh2tLYm3h/pl3/VehpFL/z8ibRv1fFD+mKzD+MxQZgeD
        mgHThGHB/4Z7OYCzCdRgQojveVgnaSKqfFMvRK5cQm1DKvyqOIPdeJ8xQ==
X-ME-Sender: <xms:lBr2Y_fd_y7-lyDagHUQauYYUsjMuYvbJVMQx4dyJAOktY-ztVfrAg>
    <xme:lBr2Y1OIB_44Crz0vWfrdn4wFfJxATCwx12gxJ38K-VJxVEpu6PWFu3fi5KwG6hoJ
    EbduqNJ0aX06s8cfgc>
X-ME-Received: <xmr:lBr2Y4j1k4trw4eeC3YlaU0_CUT_vM7uf538cvdTul_wh9JeDYyviQ-BoSFb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:lBr2Yw8n2-qOCR3hBXdqQb9KZcMcGNydr7HI24bFMZk4nsLW5F6ZOQ>
    <xmx:lBr2Y7vffiT2Pmx4n1TJUvyiwviZFB1feIvDEg8oDdA8u04ZKZ5ivA>
    <xmx:lBr2Y_HgUXKLtz07fcBscvXWh8na5wCKIbEa_84pnwjT-N0TsmB1hw>
    <xmx:lBr2Y_ERVjZ8C1xQR81Q6cevq2oOO_I25aenHUeMo4usyzbGh_azpA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:37:22 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] of: address: Use dma_default_coherent to determine default coherency
Date:   Wed, 22 Feb 2023 13:37:12 +0000
Message-Id: <20230222133712.8079-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230222133712.8079-1-jiaxun.yang@flygoat.com>
References: <20230222133712.8079-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for now all arches have dma_default_coherent matched with default
DMA coherency for of devices, so there is no need to have a standalone
config option.

This also fixes a case that for some MIPS platforms, coherency information
is not carried in devicetree and kernel will override dma_default_coherent
at early boot.

Note for PowerPC: CONFIG_OF_DMA_DEFUALT_COHERENT was only selected when
CONFIG_NOT_COHERENT_CACHE is false, in this case dma_default_coherent will
be true, so it still matches present behavior.

Note for RISC-V: dma_default_coherent is set to true at init code in this
series.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/powerpc/Kconfig | 1 -
 arch/riscv/Kconfig   | 1 -
 drivers/of/Kconfig   | 4 ----
 drivers/of/address.c | 2 +-
 4 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2c9cdf1d8761..c67e5da714f7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -272,7 +272,6 @@ config PPC
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
 	select NEED_SG_DMA_LENGTH
 	select OF
-	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
 	select OF_EARLY_FLATTREE
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d46a268ce16..406c6816d289 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -119,7 +119,6 @@ config RISCV
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-	select OF_DMA_DEFAULT_COHERENT
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 644386833a7b..e40f10bf2ba4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -102,8 +102,4 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
-config OF_DMA_DEFAULT_COHERENT
-	# arches should select this if DMA is coherent by default for OF devices
-	bool
-
 endif # OF
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c0b169ef9bf..23ade4919853 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1103,7 +1103,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node;
-	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
+	bool is_coherent = dma_default_coherent;
 
 	node = of_node_get(np);
 
-- 
2.37.1 (Apple Git-137.1)

