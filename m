Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32746D2F50
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDAJPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDAJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:15:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BF1DFB1;
        Sat,  1 Apr 2023 02:15:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AD625C0214;
        Sat,  1 Apr 2023 05:15:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 01 Apr 2023 05:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1680340544; x=
        1680426944; bh=JpbN5IRZb6DqYHnvTvcNliYuUkNmoAjg1AAlzmLaQmQ=; b=O
        fyvzn1NLcTeL8TgMDKC9oBdYsNDJMKT8IYUADTSvqInU+x3AqmRlydpc4vpEcSon
        E2pJu6k8iERJ5BxEgFQz8OhfeWanI/7RNa7U2i/mcH9CROnjq/PI4JX8kK8SXJ90
        4YHAMc49Rzs6DZwzGnWwkYebD6VwUUiGB01N2yQ7XX5feoOncflpl7/4qHm77O/c
        8siQ2c7XNf+UtwIwRCGoifjaqamZAgUdcGEkIFRSZGISpXWwUA8Dz187RCCIhH4l
        IeLBt5CQ/0Vx9r5hBnFsbwrJw7srcx+iQGs30W5Gg7XUXuhcIqnjEHDsG7K1aAGW
        sF7mP5B5fIWjnGJj1Fcyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680340544; x=
        1680426944; bh=JpbN5IRZb6DqYHnvTvcNliYuUkNmoAjg1AAlzmLaQmQ=; b=b
        3EU5viCN9n5Q/XcEG6kEHQ6OgJHwWYiwzDMw5NOElssD3rSPHT2rgcBZmNbqmX0D
        Vpb9rWZr8Ttxk2ZJtP0sdK8TMYz975B8Mlc5jRqdPMxN6mkrVOkpE4JZaSueUbSI
        SDwj+pY+usF1YFacNUCyBWcxBPhTnpXvyX/cvCknC5O4a1/hKNh8gQkLOYOxVZ1D
        SIOccPByKwESdya6Q56UgIE94/Z2QIxvof9WPfBLFlE+H82bQmakaPMoVlRCwvBb
        bDHfWa0mYr5+/iZ3pgKVXwV7Z4fgVheoBOidUAH6oBlHzsZkGYewioXIAfk5POgJ
        uES4bxkFy623qmPzgh6BQ==
X-ME-Sender: <xms:QPYnZKEnJd1MfQGQwxB7UDIWv7U_vz-Mn7ELIub95nnsDekUs0AMkQ>
    <xme:QPYnZLWhzvgP6nt6J3LduENVzQt-joHKLg0iTNhuJsRfjrm_vK3qJLEV5ZM4yZ_O2
    M0HVfbaNwG-5vkNR94>
X-ME-Received: <xmr:QPYnZELQf5XYcSHDkPuPHw-IMEvM-J5Wne7_igyyaKOP5jSo_ICZ6RsdDYighyiUDKsQhti3-FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:QPYnZEFkQvq7CKnbnktf4XFHdIh5HN2g8MK0i8MAJYtDBdzv4k9oyw>
    <xmx:QPYnZAXahjpPUHU5VAkOB14UhFlRSgF3g5_HacdtqSVsFZi2IYwmSQ>
    <xmx:QPYnZHPuzeav2I5NuxE4ETCnldQtY68_R0QBbCpk5sTdtUb1BrD0Xg>
    <xmx:QPYnZBV9JtPz1unPsdAUVgnIbzjcbKe5BOgWAbbEVftlnSNzeWVmWw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 05:15:42 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     iommu@lists.linux.dev
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 2/3] dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
Date:   Sat,  1 Apr 2023 10:15:30 +0100
Message-Id: <20230401091531.47412-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
References: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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
v3: Add comments
---
 kernel/dma/Kconfig   | 7 +++++++
 kernel/dma/mapping.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 56866aaa2ae1..6677d0e64d27 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -76,6 +76,13 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+#
+# Select this option if the architecture assumes DMA devices are coherent
+# by default.
+#
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
2.39.2 (Apple Git-143)

