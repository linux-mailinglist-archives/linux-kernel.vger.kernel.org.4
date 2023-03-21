Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1CB6C2FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCULJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCULIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:08:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4E3E1E3;
        Tue, 21 Mar 2023 04:08:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CFE785C00CD;
        Tue, 21 Mar 2023 07:08:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Mar 2023 07:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679396911; x=
        1679483311; bh=RMUyY24KVPUr2kuw3Jz6nElWvCSULjyC1kNh/s6lQlQ=; b=E
        KCJqVU37dGL/jAYaoCalJYg8HEzX4Tk+7YXps1J67iMBQ14ON5M7rcgrCRRjJBJA
        1KR6BQ1HP8YgrUhpw6sXR4Mzlbxskn9LcK6TUdBWOJso9DFDNM2CwsRjoWSzzVdB
        kjdvIdDLBtuucjMqJzu7+sgu5GIfxj6/61EYO67ezJWw8B/2FLV9IjsE5M/uIhYt
        lI3jnHoaE1Nfypb9WGW+uie9F46BR2SD+iGW6nBVu6HjrpGmunga9YDH6Mum5UI+
        5QVtsSKEHAjAMhObwnxJqoI01qhNHh/3ZBErOb9MJwfoEQC6ioNwMh9qXJxwJHIH
        UbruH/r2VBGMxIyo9MVzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679396911; x=
        1679483311; bh=RMUyY24KVPUr2kuw3Jz6nElWvCSULjyC1kNh/s6lQlQ=; b=I
        8ij9zH8Vk9qa8A82aaFfxbWTmSjPHJsOeKLV3ABKaJokfgY65T/iOLHYC3VxhQmG
        KDFZh/LTNctR4BcO+ynAE4X47qXPidwM24+H/zbgcGNIF63KfLKBpzWKakoPIuQB
        65OdYabaVJagU6aM2QdCLj3MJb4d91mpfkY/xP59piH+HsrM1ZhB1A/IW3YhoC1t
        PvS3MoEflpvKe5l/dO45oHfJRFjMFzrT/qlWC/R3ilSo3vWnh8WYBgDOD3r1vPFX
        xzfkMVp5py5SGqBlP5FKELGBXJkWTr5IiAP0t4FEGOBgXSnT+9teYZloCrKXWKfM
        St8RmvzYjmvxchtbiCQow==
X-ME-Sender: <xms:L5AZZF0JTSX9CWLeGzNm34wTaNOyXmD9M64feYRDaKJwPqW9jdZ_Hw>
    <xme:L5AZZMGm6KeLLQ3CXwfdr0PIEbP0lrSWkr_YdvmozEGu5LiAXL--3le2LIQOPbc1F
    BPipS6eCWw1f0SHpPY>
X-ME-Received: <xmr:L5AZZF6-LJMfB8gaKJhhOCv4F0Kdcwbt0bWYpOIifuNsGglEAEgffOYEP-Gp__18B0a_5jgq5xU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:L5AZZC3uoCSqnFZgv1Y5WP87fRYtYCBEqRUjJ157T9Z_my_i7FKsbw>
    <xmx:L5AZZIGbQQLR_pvbKLnfln6ElnLSreM9hATAEPhe4UAkCPp7LQ-JTw>
    <xmx:L5AZZD-4d6FLIpmVdEg-y2na_DYd-ZooTmvUh_JbiXYVDBHzoYfZRQ>
    <xmx:L5AZZL9Y-EmhICS9i61ujCnyDI53kMfBXlvPb94IyO964ep1xUmkSQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 07:08:29 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 4/4] of: address: Always use dma_default_coherent for default coherency
Date:   Tue, 21 Mar 2023 11:08:13 +0000
Message-Id: <20230321110813.26808-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for now all arches have dma_default_coherent reflecting default
DMA coherency for of devices, so there is no need to have a standalone
config option.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Squash setting ARCH_DMA_DEFAULT_COHERENT into this patch.
---
 arch/powerpc/Kconfig |  2 +-
 arch/riscv/Kconfig   |  2 +-
 drivers/of/Kconfig   |  4 ----
 drivers/of/address.c | 10 +---------
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 57f5d2f53d06..824e00a1277b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -113,6 +113,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
+	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
@@ -273,7 +274,6 @@ config PPC
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
 	select NEED_SG_DMA_LENGTH
 	select OF
-	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
 	select OF_EARLY_FLATTREE
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36a5b6fed0d3..6425b5c5d6d4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
@@ -121,7 +122,6 @@ config RISCV
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
index c105d66a1fa4..23ade4919853 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1103,15 +1103,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node;
-	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
-
-	/*
-	 * DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
-	 * might override the system-wide default at runtime.
-	 */
-#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
-	is_coherent = dma_default_coherent;
-#endif
+	bool is_coherent = dma_default_coherent;
 
 	node = of_node_get(np);
 
-- 
2.37.1 (Apple Git-137.1)

