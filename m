Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473FB69E0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjBUMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjBUMqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:38 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBE29E28;
        Tue, 21 Feb 2023 04:46:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4F8D33200920;
        Tue, 21 Feb 2023 07:46:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 21 Feb 2023 07:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983593; x=1677069993; bh=cl
        U+1DjEJRpBNFORFKqHyIxdKEVEFhCaiGb/M7QBgCc=; b=qIn1qV1DkK0on6ZMeP
        KBnn0OvJCdAF06u3sTwb6TLhhvYwhobazwDY2EatXRU9Fvb3wWcrQwcUFLX7k6ga
        kbJLA67hp0QVQ+WE95nF9JhdDdHcPmpEoGB1W605thN9DLtXmRSHiuKgriPvjLpz
        bTSnFh+o803+DVbeRciysdZkn7MW9phSD8PXMLNR3V3HQXcPmlKfUFZlaFGRqQH6
        w6Exn7/aAezzhaLbUbrFiahSMH9DvK1KHYgrQ0CbNyVxdGOdHmoANV3FPaX8EVUG
        HFXDOH6p1EX0QLgoAaXEH9cbrsaFYnpl1XqE6eqOv12CC1mushGx5fqhsNZuYYLf
        c0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983593; x=1677069993; bh=clU+1DjEJRpBN
        FORFKqHyIxdKEVEFhCaiGb/M7QBgCc=; b=jjWvhaLi+nDY4ruMzqDzgliKeRkUI
        DzpKMj+qY8IeWqgJJezwBwRyp+CgWnl8cmn29ysRqJGsHwMQXx8BE7l2mTf697hK
        IxfRZIzf/F7V05uN6wZo/4ystwnI7HyCR/OOUKJoed1wAGFbksDMrBFW86p5Q1aO
        Fy3aTLeF1bSIrFb4VqYB0Uuw3kqS6ED6qMWE8i+edFWSh8NhjC0Dq3Ry41SNhKCB
        Sb1rPzThPqjT1lYzFjdv632H1K5bbaRJGPQ68uHDH0m6AO5jhRNNd5Udx2QB34SB
        L7AdHYdI2nRZgOx/EjeW6IXC58GY4LAkGpVSqI9pxHZr4Z9E1yVF5RTdA==
X-ME-Sender: <xms:Kb30YxdkRd07hHsU7Ze8w3-mzAb88q59T77I77IQ20cy03h75bGkeg>
    <xme:Kb30Y_Njog1gr2LNVCv-NVpnXFjWU7qC2cRtipkT6aCkmphwM6WObD1_vCnd7LQYB
    51nTF2RE_ItkxwbvL0>
X-ME-Received: <xmr:Kb30Y6g4VYkatzullltWucaONLGcQnyjnH3zd_GgtCskaUroU_ZBkA3oUEE7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:Kb30Y6978zk0RwMAwG13_cGLMzj8X1vuloSGIpyFciZkDgb8XnRf5g>
    <xmx:Kb30Y9unYnEavPl76RqRLqo-HHdiWS2PCt_9X2wLy6dZLAyXDGUiHg>
    <xmx:Kb30Y5HWmhJUTy7Iior3Yx1tEEOi3DKut6f67cU4E3WsK2njr_0lOg>
    <xmx:Kb30Y-nm_k6RJNCe9lBbSBD-eK02w8i4KVGrhm8mYOofiphNUd0xWA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:32 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/7] dma-mapping: Always provide dma_default_coherent
Date:   Tue, 21 Feb 2023 12:46:10 +0000
Message-Id: <20230221124613.2859-5-jiaxun.yang@flygoat.com>
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

dma_default_coherent can be useful for determine default coherency
even on arches without noncoherent support.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/linux/dma-map-ops.h | 1 +
 kernel/dma/mapping.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d678afeb8a13..3c6cd17f87c3 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -269,6 +269,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 	return dev->dma_coherent;
 }
 #else
+#define dma_default_coherent true
 static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return true;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c026a5a5e046..e0b005c8ffce 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -17,7 +17,11 @@
 #include "debug.h"
 #include "direct.h"
 
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 bool dma_default_coherent;
+#endif
 
 /*
  * Managed DMA API
-- 
2.37.1 (Apple Git-137.1)

