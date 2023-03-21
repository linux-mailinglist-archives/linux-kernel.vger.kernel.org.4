Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB56C2FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCULJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCULId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:08:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E094E1A1;
        Tue, 21 Mar 2023 04:08:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DBDC25C01B6;
        Tue, 21 Mar 2023 07:08:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 Mar 2023 07:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679396907; x=
        1679483307; bh=34g1rJ4eKpg7Mv3jK1Pi5YCKoRtvBAJ5vAexAPGkFH0=; b=Y
        K+9dSwiWN5z6O7qjaYxoOOE1GCx05bPaiar5IBe0GjOE2Gg72p2f1IvsY/C//OWx
        p7gSbGBNOoVVoloLCrHjB4SPaKQarMqBkqpg1FkmXpAYD0a9QUllqA+t/Zo5vaI/
        laKToT9DVbZp+Aq6xcH5Dn2+4uzMuFhnBzMzTRW/uvE7iuDXF228IBsD5u9Iz+e3
        bS96ZBzP00NWoXYZYiFBMW4xzi1+TMNAxsn81ZvIpwBF73jmbDczEyDK1jCTteAm
        KMqVvasp6Ub2ZXkViwPfjvitj4I2bu6zgxR7/5uZngv9z+Yg2ynUTvo7zOglVgc6
        v4fvrc5XV5TUVhAUuYVig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679396907; x=
        1679483307; bh=34g1rJ4eKpg7Mv3jK1Pi5YCKoRtvBAJ5vAexAPGkFH0=; b=W
        OwhmSW5w8OdUB4dg8PnaHDyMCfwhHm5a8sgXyqO0PVSFhO1MDiYQADBuCXpN7zk5
        pIYVpmA+kPdwRYhzhrn8dVTWB8GyioN19BZ5CxJu67Gs+EE0H0KFo7qWXHCmQ/vr
        vGGMnfuYBiOQKw2h5lSL8yQmvxH+IgJRd2JBa8bPLNI/6ucTd2xKPdK6vPai++Ex
        s7soBPUCCq5+8cZGQcgskcxjWoFOcykPujeauciWTd/oIA+gpah/wLNbT3e/BUBI
        zzhjGOmJ97oV+jghV+2ihL/1QGxZt3gex5MxlL5qMK0QXYhcmg3n+Jc82s2Dp2VR
        tK+HB0so+lUgPj9tsFPzA==
X-ME-Sender: <xms:K5AZZCCeDevojgzHlmqOuVkf0WVt3kA2sIdIMRFuR3L-rQB4PkHqZg>
    <xme:K5AZZMgvUx5G849LWNfilyZB8sYDAP2vMelYCjuzvxvrVrMQhjLzbCM8epM2kPjpK
    Cd0uiK-BnSzINKYBaY>
X-ME-Received: <xmr:K5AZZFlgGRribAerj9e29wl1EP7-_rCyXAz8VYm36-8_coo_poDgESEpHOb-1A9yu7wlIloJE48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:K5AZZAxoTS4-Enr_LRenIV52tFK6fIf_OlFHQKHSpzkW1nSPiWJZjA>
    <xmx:K5AZZHTZw9GZ5wTscsriCuRaKtYrgA4YYHdEZ21X3aLPYcZOP8gksw>
    <xmx:K5AZZLZqmNXh8ihQi4efRYoI2-OCE32nFzBH6-eU5rYU-dDQGRvD8A>
    <xmx:K5AZZPaWlkVxBcFthA1CvCe63W6mpgde3lTCQwQhvk2iCfxxleGwFg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 07:08:26 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 2/4] dma-mapping: Provide a fallback dma_default_coherent
Date:   Tue, 21 Mar 2023 11:08:11 +0000
Message-Id: <20230321110813.26808-3-jiaxun.yang@flygoat.com>
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

dma_default_coherent was decleared unconditionally at kernel/dma/mapping.c
but only decleared when any of non-coherent options is enabled in
dma-map-ops.h.

Guard the declaration in mapping.c with non-coherent options and provide
a fallback definition.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Style fix
---
 include/linux/dma-map-ops.h | 2 ++
 kernel/dma/mapping.c        | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 41bf4bdb117a..31f114f486c4 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -269,6 +269,8 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 	return dev->dma_coherent;
 }
 #else
+#define dma_default_coherent true
+
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

