Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF569F53E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBVNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBVNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:24:49 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA5F3B3CB;
        Wed, 22 Feb 2023 05:24:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C6DEB5C016D;
        Wed, 22 Feb 2023 08:24:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 08:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677072282; x=1677158682; bh=6T
        1o68vOusF0U/JsH2f0H8DjY8CJLE2Yaxz8jLQ29x0=; b=ixIYenL6yUTrdKDf/y
        yGIMj2+CSE4XTpBVAo7gCAd6shbojXwqI3NUDE39LbMxm++eR0YWt1gTl0i9l5IA
        Fm0+kXA6ietLck3SBwQybWWhAkxkbpSfi+3qr8HliYb7qKgDGwbXYFCwd6Pr8s/S
        Niw9CedJjVYG+kN05usHi5zNCLSnJFYiMQR4QuzIsjjLAk9L2hr04JsFqcXoZxng
        MyOY5dY51iukVAInSIqcLGFCdBX9CuCYIbVp3VZul40fOfAzd0cZ7wgrcwgX2WC8
        dqipPh/sBhj+y8nfWd6Ffeh08TDdXnhxiiG673ourd/lszWo2HYu2WAmw4D8d3wa
        liFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677072282; x=1677158682; bh=6T1o68vOusF0U
        /JsH2f0H8DjY8CJLE2Yaxz8jLQ29x0=; b=pNBkQpTD4j3sLCiTNDX2ffGfvR6r7
        54tMAQhX6XvhaNkeB3gAXYgggEq7wjC0amoqS+d6x2anSKX6x7ud+PgzAd5giu1E
        LuDCHCAXRpcPyodL87kAsINNGwLAJrM8XyZrbd6W7biR40o8MiuSsQ5kFK4Z6vfv
        nkXQcunmuBHQoPlTTz6CkTDKMjk9ub2/KrK71q7MKgdWOQFwWqfu93FtU82tJ8fI
        Bz1giQiKdcTir3WqXX3KhjpfBFCVDe0u7COTOp7KtB5yOznBTUnLMFz6gxw9W914
        nhutfvI7FL9c+bw1wpYo8Z8tuoYdnqv7GCse1/qjXL3blxKadGlQS7yDg==
X-ME-Sender: <xms:mhf2Y5zjUoseZfQ0DHTG3l60xCUTVQSGudPqOi9DrEjp5XtpFkmGPw>
    <xme:mhf2Y5Qtjy6CirzVExS3k-wU7I0FjUk5STaHgR9n0EG0UbjHfYP0pKY0H15-AvTob
    eoW4s4BJqcz22XSsqM>
X-ME-Received: <xmr:mhf2YzW4ucnVZmdAzXB2te8fvQzmoh4F3MchX4GW-eb4XclXQmr21YUp0EYl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:mhf2Y7h4Ust7zeHzVGMRZr2t9Rek-tYyM7hL0arr5eWiw5168HEeUw>
    <xmx:mhf2Y7B6dsDwo3_oAQtEn0GKH6StYR_zS_ivcv8eJcGAedP_-WGulA>
    <xmx:mhf2Y0L50p-7g6cPXB3hVBMfN556DScJnOMvAPcAuWXp77J5WUlelg>
    <xmx:mhf2YyOFNI2mYaksDm3R2WX-7l7QIdzazAD1DOQhxSeWoCz4R5WKew>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:24:41 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        hch@lst.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/4] MIPS: c-r4k: Always install dma flush functions
Date:   Wed, 22 Feb 2023 13:24:25 +0000
Message-Id: <20230222132425.7442-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
References: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
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

As nowadays DMA coherence is managed per device, it is possible
to have a system that is defaulted to coherent dma but still
have noncoherent device that needs to use those flush functions.

Just install them unconditionally.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mm/c-r4k.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a549fa98c2f4..7d447050a20b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1867,15 +1867,9 @@ void r4k_cache_init(void)
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
 #ifdef CONFIG_DMA_NONCOHERENT
-	if (dma_default_coherent) {
-		_dma_cache_wback_inv	= (void *)cache_noop;
-		_dma_cache_wback	= (void *)cache_noop;
-		_dma_cache_inv		= (void *)cache_noop;
-	} else {
-		_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
-		_dma_cache_wback	= r4k_dma_cache_wback_inv;
-		_dma_cache_inv		= r4k_dma_cache_inv;
-	}
+	_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
+	_dma_cache_wback	= r4k_dma_cache_wback_inv;
+	_dma_cache_inv		= r4k_dma_cache_inv;
 #endif /* CONFIG_DMA_NONCOHERENT */
 
 	build_clear_page();
-- 
2.37.1 (Apple Git-137.1)

