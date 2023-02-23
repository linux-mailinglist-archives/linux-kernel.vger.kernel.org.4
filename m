Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FF6A077C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjBWLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjBWLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:37:08 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C44FA9D;
        Thu, 23 Feb 2023 03:37:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 995ED3200344;
        Thu, 23 Feb 2023 06:37:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Feb 2023 06:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677152225; x=1677238625; bh=w9
        MPuL3xvzlmyepaLfzNP3Yd6NyYPIjuZVV4oO83i4c=; b=IFZl2ORBAKjtu4cjv9
        Vfl/K5vu4Oek2GhcVjflrWw0JVZ06TwgSSBi83cgXB8SlyR3RMgyYN+cFj6Xndgd
        3OTC0HUgMgF1DpcQOS+1FGgqUxBNUv8yM1nkC2f5WkVqPBqKkN9bVznVQy5O0hw3
        i5vvK2vl+IKBEnx8Wug4WWSKSscPE9tx7pMqi4nTr5gpwBbpGVEIiZ4tmqNF7F7l
        CfgxTZUPRp3/SQd6fmGa9ldl8+NNMM9GQXBnhjHTRxfQfARlMqdgHaaQ2t/7nS5/
        0cESPCq53PW1rNWy6ZDUMlklofp2FbOLo4Gz1zNehZK99ZlxYOHzxSKkc1TQw7sE
        mEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677152225; x=1677238625; bh=w9MPuL3xvzlmy
        epaLfzNP3Yd6NyYPIjuZVV4oO83i4c=; b=apbZeE9vqPT4maFETj+CqsSLwDNY7
        lxWddqhvvVPs2dGKhJOrtwldSE/Oi4LwVBGgh4XLb57V7GEtlY77C6hw/yWkJoNS
        iST3BQcSQ8VLRaPCu5uzT00p+HSxG/7n5s0uTDSI0WzQ2HfqARRjBdqe6kx8L4j9
        wdj2d2CPQ3FgbkOLXIt5OjTuFHwkGX8xiEF0njyMOWqhBqejGAkWZvmFuBvceJTS
        vR2XjGPzK3r6oyjiLZvHCf/Rq5qxUiFBw7HGZo2Iu0HA5mwWChdqWFj+n/JHY7Nl
        6ah7WJGCGFFo8NGbEbYS/XQk4iJGNyi5PpPBcBWcKSe6rkRDMKdnSI5Ug==
X-ME-Sender: <xms:4U_3Y-v9mCNvggSK3q_UWgxIlqsYkPS8-IwZ1eGRDIjg1VCFleO8YA>
    <xme:4U_3Yzdb38KK2Qn-pIo1hA_rSP0p71AouUI2cyJHLJp0Utu50TFsqLhMQRMNXaqTj
    FadLxquMU7x2Jh4GJA>
X-ME-Received: <xmr:4U_3Y5yYIWXZGp4woK6kEOrOr8iLq8taSiRMEmvGafRD6bVJnKYt8-npMOLOZN63R9LNvtvFrz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:4U_3Y5OOHXsMLFJx0VxB5MdWP3KoSMTrN4vunhaxFU3eSGO8jBXfEw>
    <xmx:4U_3Y--KdR_D9r63gvtkIPUmv28NYqM-JyrWV_q0V5a96hFSSttTjw>
    <xmx:4U_3YxV-GddjATpvv74n5HT9Qif0yrfPViVZa8hwoDq6xmMHPchuOQ>
    <xmx:4U_3YxVAjxDcbaygjSIEqU5Zz6amewiDTR_WdRfzLYoOWXCgi5VEQg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 06:37:01 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/5] dma-mapping: Provide a fallback dma_default_coherent
Date:   Thu, 23 Feb 2023 11:36:41 +0000
Message-Id: <20230223113644.23356-3-jiaxun.yang@flygoat.com>
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

dma_default_coherent was decleared unconditionally at kernel/dma/mapping.c
but only decleared when any of non-coherent options is enabled in dma-map-ops.h.

Guard the declaration in mapping.c with non-coherent options and provide
a fallback definition.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/linux/dma-map-ops.h | 1 +
 kernel/dma/mapping.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 41bf4bdb117a..0a1aaf7163b3 100644
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
index 68106e3791f6..80f9663ffe26 100644
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

