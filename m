Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44969F5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjBVNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjBVNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:37:22 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0418A83;
        Wed, 22 Feb 2023 05:37:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EDC35C0121;
        Wed, 22 Feb 2023 08:37:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 Feb 2023 08:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677073040; x=1677159440; bh=w9
        MPuL3xvzlmyepaLfzNP3Yd6NyYPIjuZVV4oO83i4c=; b=Z9k/56ZNql9SmQjH8z
        KTyQCSI1IZ1NM2Yj9JWpAzAz3hnbjCpGdshk3Ra8L0dbAefCWwUgoJrZlvDfu5T1
        K/L+D9sZ59n7AAk/yBR0zWYCFsxF+2h6jUuu798ERAg4iafehLBk1vvv5BkKxSZR
        T0WfKFm788ARSFTH+p39Ly6DMFpnvTP0M6waFf5vedhgMtuvRQ+L/PwnSP03bX5H
        8tkfMxiTlHLBHSe3bfLkOIIYFCEsz9uCx9wkgOEnPd39wOYMRpFeqXPnfuR5S+AJ
        bU7mWQssr0Pvse4r6RXHikUPkwQzEeO3X/UYeCCYPM53JxkqwgUmtyo9lP1Dmgd+
        ZC8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677073040; x=1677159440; bh=w9MPuL3xvzlmy
        epaLfzNP3Yd6NyYPIjuZVV4oO83i4c=; b=t0+fpHEADym4UyAXwv8RABDiQxR2Q
        4gr8wHJZ/37eH4oUG/xTdRNgRlf1o62QDvSv/LE8AUm4DxFsmz28+PSxKycYCmt3
        BgYtnw9uQFmqOLw9Mrz1XGlXRWR8T9OCRktL4UUFb07DJOe1giUUnt740OEhNoEn
        1UrMK+67Ean0yYV0Nz80kffJMD7kPvijn5HeBxEdFN1nmA6tfQP8mw5PpMbgWabU
        xaqwtrhLyYKPB7p/Lpdb+i7FQ06zm9ihVR/oN5F1KHXWIgVwUjTpENj+jEBUwfa0
        4l10PZDnOlS1lDOR3ssdXABDUnXL1sxi8eFIZUlEdwv5VKIKABV7BR82w==
X-ME-Sender: <xms:kBr2Y9vF38sk8KSl4mjKN2CSZdP9mX6NDkYIg3RHIWUfqoNj4eXXoQ>
    <xme:kBr2Y2cc5HFbjGy5ApPxiYayvruX5OJ3dnEpYORb_8SSmfGWOeoty1G4bzJ-lGtx2
    RbI8DTpHKRt-4XYf9Y>
X-ME-Received: <xmr:kBr2Ywz6-Oc_V1KF6Ja29VhdN9MgjUlTtz85DSyHQGBi4qJcPe3qATqQCqtG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:kBr2Y0OrnKXttDtdULg443FsoVFkMfvrthWFRORpU1rGbvl_XJbJsA>
    <xmx:kBr2Y9_hmn1P_0q-gWu6tjR5daETPTWMnamL6yces1lputUFA-WEiQ>
    <xmx:kBr2Y0UiW75n_mq7fWZ7wCdbjgVkgj8XbCn8GUeNAj-LXeHqA8mSbQ>
    <xmx:kBr2Y0VQQrGqFrijDkbKuBdoHlqNKzufSvpCs8jmv-uQitso-V00HA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:37:18 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] dma-mapping: Provide a fallback dma_default_coherent
Date:   Wed, 22 Feb 2023 13:37:10 +0000
Message-Id: <20230222133712.8079-2-jiaxun.yang@flygoat.com>
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

