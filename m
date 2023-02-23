Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE56A0782
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjBWLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjBWLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:37:24 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D484FA9D;
        Thu, 23 Feb 2023 03:37:16 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D315132002FB;
        Thu, 23 Feb 2023 06:37:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Feb 2023 06:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677152234; x=1677238634; bh=8m
        UR23YSfnzS5f2Sho2VGrnO7EOIakJTH1aJiVvcX4g=; b=MtlIEOyo2nFTnHdLQp
        dkn7SHXD1uEN0v6d6tQbepVtWDYYP41xWbaa7BTENRIprcmg2Y2OyC04nCuDQSAG
        dS6dpm85OOtRiQHFgTAF4AGNgct7Q+Ou71OkGeeqUoifYqITkhieKE1PMA4AX20d
        lUA2Yl7rIeHvtZGv0QSpBMXe9vuw1tMFX7BwpYrjKAzdOA2Ev7QSA+4oyGw5Zfri
        +P2wjgdMHKDGoSIZ1zhFQ1ZTwdeNuaS7SY2iaUO21vkVGae3icqRxgcERzg8Vg3v
        uIawxLTn0DY8Qv4ZVGbG/06Xt7ClH9vSyaQlDfnBQeLaJP7keJklT/BDWSegguDC
        Wh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677152234; x=1677238634; bh=8mUR23YSfnzS5
        f2Sho2VGrnO7EOIakJTH1aJiVvcX4g=; b=LQCMTotu/E41oSCGDrRDpZ3Oc5Y8s
        SF5SbZS5pGNcwFJ8h48MjZmoaJKerIvZxuqQje+r0NITpQTjfNamhBSwZteQSma2
        YEf0fz56AzyScFyPkiVcjmvtqr3oqh7yIfKKr+vnxfdDkxQbnA8bb1+QxBBL3DsN
        hOePbbLm+Qap05ACTHyO1wA3hPzNgZTQl8N9shM5zmxq858iBplLmtWaqkAYUols
        BQgiMOgdi0Twh/lTZg8e/9w5o5Lfps4rBmijMMKn3yQLX5ij70ZjWOCEsioDR6eF
        hoL39aUZdj5yEbFSRGCg0R8WAmnxoW+yt/KbXw/aTWY4chK2cmCKpw60Q==
X-ME-Sender: <xms:6k_3YwbXPI9F5cxXFzllSrLlABO3A6jAPvaigqmtakvXeXrDvAYbvQ>
    <xme:6k_3Y7YNlVs6kLD6JrFp5_88pBPtwU07OX0ywTFuxeKLsZTj38gXz7fLohWHlpWA9
    4CmfVfCjgHwgngwwFs>
X-ME-Received: <xmr:6k_3Y6-y8FdXoDHaXA9RMtN701NtuunRW1f0B1aSFw_ix-uHjoyqP8QoAGlfrzMNvUD3S1zp4NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:6k_3Y6q6PHJoAVl2HuO_-WvOAWkMYAYyfLXtsIWYnWcwJtxRWOYy7g>
    <xmx:6k_3Y7r6i_ALC33Qr8Oh_iG6MoFIlik98hpb2_rmpyt2_JMMshtSLA>
    <xmx:6k_3Y4R5Ox8LE5PHca10ysPj6iZp7VL5ZZln4Zw104c6LPi4W7am5A>
    <xmx:6k_3Y0T1cjMkEpdq6mOZLPulIMsSu6NVRR7_dq1y3o1-aeRJKkZA_g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 06:37:12 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/5] riscv: Select ARCH_DMA_DEFAULT_COHERENT
Date:   Thu, 23 Feb 2023 11:36:43 +0000
Message-Id: <20230223113644.23356-5-jiaxun.yang@flygoat.com>
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

For riscv our assumption is unless a device states it is non-coherent,
we take it to be DMA coherent.

Select ARCH_DMA_DEFAULT_COHERENT to ensure dma_default_coherent
is always initialized to true.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d46a268ce16..b71ce992c0c0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -233,6 +233,7 @@ config LOCKDEP_SUPPORT
 
 config RISCV_DMA_NONCOHERENT
 	bool
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
-- 
2.37.1 (Apple Git-137.1)

