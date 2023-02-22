Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F969F53B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjBVNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBVNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:24:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25543431E;
        Wed, 22 Feb 2023 05:24:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 394115C0132;
        Wed, 22 Feb 2023 08:24:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 08:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677072279; x=1677158679; bh=p1
        V6c2YQKPdBi091Tqa4iPFzeD9QI7L6DP4eQYxxvFM=; b=wI4nXPl2zfm3ZUxD1K
        H9K0JWhjrFZJNb393iyBS0bApQ4Rs0/iqOh0kxXo4NXH3ludGeV03Ran/+wFdYQH
        TU3ojIs/rxtBHUSHBCyjTKEkjF72W+Dmo0pczskCbNg3//T8jFyT6mAEwWFhCGa6
        Cz7PdIWyJMwFP61oIURw+45OAaFxFJcfrLGZjmV4vKiwcHh4phC0jxdZ9l2GuHEB
        F9d4JMrEnJllna5HAGOypUuQGdGCx6CbU8VdOeGAAguBTTZOkDLevicD8bCS1Hk5
        P6gLA3imLk6WJAAZ29rbkoPGdMIasqaR4z3VU3WlZ8MppWQDYT8rC07LnBmY1zeE
        USlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677072279; x=1677158679; bh=p1V6c2YQKPdBi
        091Tqa4iPFzeD9QI7L6DP4eQYxxvFM=; b=Y5ehZbXZlmfaJ6YtJUwqm0nl69Q9y
        TpPisx3hhMiNXqoZjp28cMEBraOz1SJPKdxjUKYQxSpfL3sG9q98PSsF2sZbqOAm
        wHFU6ZsISGm2o1UTxGnSMZWkGOt09EJhJ6r12iDXF9pUj3sEpoNnt3oBrSqIoZ51
        U1Zkbc8wgN8PfnemAEikR8xwnME1IUhq5G41fjJ8G+mrJ6kE/EPDSsEJWQxs1r3B
        2oN4WwLf88mp8HBj/e9rCkdgVS19/CIbX8j9vA8Qf50tpwTLFLQUmDfeknWciYkd
        zYLoZ27h3eEWzJfPeXY/ZgDeo1Wjugzw0pwB7+xKPArD3pVDmdC9sFO9g==
X-ME-Sender: <xms:lxf2Y8vhaRnh9eMDLG0Gt6mwyRNqXzuo4P7bRJMOOS-wEgyIA7FgdQ>
    <xme:lxf2Y5ehC2xeQ1Xnvx_GXXqc_lhX1CUjEFQCM-W0QulcSeU0uGoDDya0E_z5WA9Uu
    tZ47FhAOlz-8KObEbY>
X-ME-Received: <xmr:lxf2Y3zPtVSCUofUngq1W-svpUvx-JHM-9OQGpOlIwI2MbH6zlE3GrSOPOz9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:lxf2Y_MrBn3vbunqIvrUSlLdbkDWN2QdAWsQf6HmUg0f_kezdemL4Q>
    <xmx:lxf2Y8_MZEHdXUBoKITZrftVLr3mFOnfOruoCanL3bkwrMLQdG-qVA>
    <xmx:lxf2Y3XKpzkKXuCjM0dKmRlKpUV4RR9zRqjZa0B00ZRav86gcMnbCA>
    <xmx:lxf2Y7Yp8XjlzYTDiiyg9j1M4tc31ugkl0Cd8eRvjVEAeeNTfLyJlA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:24:37 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        hch@lst.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/4] MIPS: Always select ARCH_HAS_SETUP_DMA_OPS
Date:   Wed, 22 Feb 2023 13:24:23 +0000
Message-Id: <20230222132425.7442-3-jiaxun.yang@flygoat.com>
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

arch_setup_dma_ops on MIPS sets coherency information in struct device.
It's essential for per-device coherency to work.

Select it for all non-coherent platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a1170f0a0c04..dae894b7d857 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -134,7 +134,6 @@ choice
 
 config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
-	select ARCH_HAS_SETUP_DMA_OPS
 	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB
@@ -1089,6 +1088,7 @@ config DMA_NONCOHERENT
 	# by pgprot_writcombine can be mixed, and the latter sometimes provides
 	# significant advantages.
 	#
+	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-- 
2.37.1 (Apple Git-137.1)

