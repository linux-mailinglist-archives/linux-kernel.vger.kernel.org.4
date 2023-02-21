Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC169E0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjBUMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjBUMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:52 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D06D2A98E;
        Tue, 21 Feb 2023 04:46:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D85E8320093F;
        Tue, 21 Feb 2023 07:46:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 07:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983603; x=1677070003; bh=4P
        PQjSJNVgwU03Pj5b/L4ZJLYgKGF2yahc105X2h56E=; b=gBZQ/xBKen2MpRDqHP
        kJP4HpYQo9Y6HqiqgXj9Mkqt/E/w3PwhRLBkE2o+OsS3n2SP9Ng/mPu35D3sV0XG
        44kexJZOGcBldDe5iwaHzLuU50gl+ow/vbdFun9T8eu262Wt582T3SGMrheJZZFZ
        3jBvE2XmHjtOp42z/17cv1Rfl7ZsStyBqxCG4finf9YocP1WcjhW8Eb6pPNCvZNI
        GylOw4CO39XLkDwWQI6+alB5FVa5KxxixzE6Uiqk9noV/xrLRZVBRHCHcu5LFdYM
        UOmUoQYDMw5zb3Xh4tRcy1rKVWGuFIckozYMFJalQV2aNBBknfS4tEdcmRBiXsvl
        FxKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983603; x=1677070003; bh=4PPQjSJNVgwU0
        3Pj5b/L4ZJLYgKGF2yahc105X2h56E=; b=MZMgKI/gl8T1hTzUgKkJMR3mNindB
        KgWZVIUrLChZ30l55JhNCgYdW3MMIsdwb8GiRKv+NqTDp0pMCAC97JvgBi0NVo1a
        59N/OyP1GexGFx0AURQkG//75AKXweo6fJVG5qBuIej14MxNspp7fNzlW0i5f/S7
        PzcLbTb2XAl8KHgEFu4A6Obsup/5dipb6urtUkNscFOm2gK85vpRHAMfdwKyzZPC
        7iiurARaXXFvV2tzemiTAOgjW4URHiTGQ96+dDpTsoLR5tXecM11Hyd1OvRn/OPo
        7XRYI2Pb6tNtv7Q/DbqQttHVn08MlN0NuJVvQ+r4BSARy5JfmtLi5rAVQ==
X-ME-Sender: <xms:M730Yxt1TniEuAk-73JMgS0iGFIqvjkE9Uxy4xWkpnIlhTL5MvU_uQ>
    <xme:M730Y6c6eF3p3Y5zFYcM0LX2_rxqAJ87QX3aV5by0f-pYzwO-EcRY86QhPcdUtA0Q
    Li8rQpRSIn1YSBBSBo>
X-ME-Received: <xmr:M730Y0xbN6yBdz9NM4GLNuezTMlQJTv40ncFaqE5ubv2J03eLTpYBBJM4UgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:M730Y4OTi2bXoEKFq2FkGt83FufSs4MPUEDr-VEmt7Ky3bECOZ3laQ>
    <xmx:M730Yx9F_eJz7u8kYWrwbw1YZnSqGhR9EWNTXy9jfjTTt6DKvGsDyg>
    <xmx:M730Y4Xkak2MgdU6fBhUD0eDO-TRqxVduoarf2fFIChw6jXVD0dgvQ>
    <xmx:M730Yy1dSx_tc7huMS06v9vjala-OT_7jJ1zaaBM9ajmNjWM3T0nMg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:41 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 7/7] of: address: Use dma_default_coherent to determine default coherency
Date:   Tue, 21 Feb 2023 12:46:13 +0000
Message-Id: <20230221124613.2859-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
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

As for now all arches have dma_default_coherent matched with default
DMA coherency for of devices, so there is no need to have a standalone
config option.

This also fixes a case that for some MIPS platforms, coherency information
is not carried in devicetree and kernel will override dma_default_coherent
at early boot.

Note for PowerPC: CONFIG_OF_DMA_DEFUALT_COHERENT was only selected when
CONFIG_NOT_COHERENT_CACHE is false, in this case dma_default_coherent will
be ture, so we don't need to select CONFIG_ARCH_DMA_DEFAULT_COHERENT for
PowerPC.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/powerpc/Kconfig | 1 -
 arch/riscv/Kconfig   | 1 -
 drivers/of/Kconfig   | 4 ----
 drivers/of/address.c | 2 +-
 4 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a27fea39413e..2cfee7ba2e6a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -271,7 +271,6 @@ config PPC
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
 	select NEED_SG_DMA_LENGTH
 	select OF
-	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
 	select OF_EARLY_FLATTREE
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1327309e0f6..e69e69b9cfd4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -120,7 +120,6 @@ config RISCV
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-	select OF_DMA_DEFAULT_COHERENT
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..e040837e5537 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -90,8 +90,4 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
-config OF_DMA_DEFAULT_COHERENT
-	# arches should select this if DMA is coherent by default for OF devices
-	bool
-
 endif # OF
diff --git a/drivers/of/address.c b/drivers/of/address.c
index c34ac33b7338..8e17adb10f20 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1053,7 +1053,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node;
-	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
+	bool is_coherent = dma_default_coherent;
 
 	node = of_node_get(np);
 
-- 
2.37.1 (Apple Git-137.1)

