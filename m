Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237469E0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjBUMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjBUMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:43 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91142A152;
        Tue, 21 Feb 2023 04:46:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7C94B3200932;
        Tue, 21 Feb 2023 07:46:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 21 Feb 2023 07:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983597; x=1677069997; bh=Ed
        zOAv/xcw8C660U6AYkHbaD3axiSrIufQWq0klOwqc=; b=bOjEVdwW9KvLj+SiA0
        RhT7CIkflbcfHDLoMDtvSBSeZ7O5BpriDzw0omfF5x5+F7yUndITdAuoUSuFOcuw
        B0+FQ7sruAVljv2cFT2HT8ZDrc7ShypCl0Xc8GSpjfxImp8As0GG0TwW26ZuT2l7
        lDDJ0sPCU9oAT9caTjR8XALWhi2Xy07k8pB6wA6KrX+gqy42av3oM6HmKfzK9bZ3
        ZqBwdnJbGxYLA66GT1/ry8mkXSrCweqgrmMxUJCHuCvEcg/GQPshqxXpLW+F4Pgo
        rtdPZdzQs8HTdxIOixT2j8rNhkEr0sciVtdTo4mLSASbA4r4CjCMFPVL1bvrH9H6
        COiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983597; x=1677069997; bh=EdzOAv/xcw8C6
        60U6AYkHbaD3axiSrIufQWq0klOwqc=; b=TMacjdvBZ7+GF8nhmMYIH/fVDN07x
        NmC94v8x/x3aIvJpHDAK+yc+KxhfeUH2UtLUpFiDtjMs089AiNq0u1HPcySUf/Ki
        2VpR1Eu1VpZdyFCyQoByz7rNwQ10ACxdcBqnjfDNv02dpvwsKbIlHsW1fg3tY3Vi
        3c3ILiwnD9LiL+uC3OAkME1bZJngB2PqBkVARAUITOR3ni3A9nAi1VVH1/dUT4Bn
        kw1Yn6EKPaEM0zJoMROnQfCZ7DSuMkYD86kjHCRe/CsJILRQrqlAbirKyzAyxXi4
        BE3zykbS4eImy/BEN9Pv/TKKay2XBEz5fCADVFKZKOQtl3kNy8UOkPYWg==
X-ME-Sender: <xms:LL30Y7MN1nrlvHI7IXBKEYLsNwoNdHu48hBIgM-B0oY7qPtKgVtewA>
    <xme:LL30Y1_DbMAr9xfr5eRjvUiogEIwSu6mQ4ZIdWzMTwDLUvBYixZGKZGUoUSlC40vV
    64CDOmYHNr2uzC6yFQ>
X-ME-Received: <xmr:LL30Y6ThyhqJp467PDXxse3xV2U5zoEytcsELm6o5CEwrAxdSm74597X9h8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:Lb30Y_vWLi-P5N3TZnMcC_NZYPy6mEtsKwg-r2JSdztCeIx39U881w>
    <xmx:Lb30YzfPvkHg9KApypLY4iMx473qjCSl8X6JZQ8UH4h7iIfW9D9vLA>
    <xmx:Lb30Y71ABKYzwTt6CpRJk2eS3HlGoN8sHMeRZuCR00DL5go2DPCfQw>
    <xmx:Lb30Y0WdY0Rn5Eh7qNYxsErrCejdAA11NGvc08IPi-0w7my4BNtEog>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:35 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/7] dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
Date:   Tue, 21 Feb 2023 12:46:11 +0000
Message-Id: <20230221124613.2859-6-jiaxun.yang@flygoat.com>
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
index e0b005c8ffce..3d4a2ca15b5a 100644
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

