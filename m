Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186369E0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjBUMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjBUMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DC28D0E;
        Tue, 21 Feb 2023 04:46:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AD2123200392;
        Tue, 21 Feb 2023 07:46:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 07:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983600; x=1677070000; bh=hV
        blcbnQNQnrUYmR42maX841iYbSBNUD5mWumav+q1s=; b=j8/j9yp/wQMNo7LXlC
        8GDFZxMTHD0uB/Sy7andq8NyyTpgXSQoN/e2cjH0Nsk22VVREnsFDoTqbvQQXOGe
        U4StaiPSs1d/6l6Lwh/UsiqwtmbhweOPIhTl49bGdYDne6I+VDRbHigxAxEzhm3E
        Xh97ymVPgKnYDhLivkRDbKxug4hubPXp/XR1x1Ea5Lj2LGVHgPXhjlY8NG8xzrlj
        Z2PXzpbJV6beOoZSmcZf5hdsEIc8210yJjRLWf53rdglL+GjRPO2V5NBp4vnpWIE
        ZIfd7VaY5aGNbW1PssK1ZhA9yWAq5jBEMb4heitVMv/w+dwcyac50C7MWYCkK8M7
        DMtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983600; x=1677070000; bh=hVblcbnQNQnrU
        YmR42maX841iYbSBNUD5mWumav+q1s=; b=DJNjAvwyDKZHlxBA/gAxauFhEP52V
        DDUmJgzGwKHB/gJz2K9Znpstt0ap92MxGDV0jM3R9/sXEs5nbgVHigHu6j0EJ1nQ
        ziLcOgHcsI9YKxbbmibzF+lOjLGsrppJ9p8ls0bRLdjOMDcmMiVJX6O5oXq/9d0+
        r66grgdF6zwYw99glYagz5HUOAyfVNY2AS5qTtd/AtqTXiTRvh0ZM1ZHBiI9ik5f
        0i8OsAde28fjYD7n7lKmgx2CITbfjNxmwXXuKPVxOPcRiqXSVPGnOgAAnh7pDGQs
        l/Ko4XguNZj3CnkzH+jH4YqKSgOOf8uIcHtytI5vZO6DBmvSsJ++2cbAQ==
X-ME-Sender: <xms:ML30Y7os6kpvz8_zFyH7sJ7n9eUw_rrB7BuhVEFBi2jJYPfvak22UQ>
    <xme:ML30Y1pDUhmNEVGK4wVrQkHBmZiQxrU8YO1ERVfJXp3uIA9fgaiBSQbAoGvRru3gG
    Evu32pRNSQPi9ufVQ0>
X-ME-Received: <xmr:ML30Y4Ph4cpyc4pnGiHvqdmi7a8TlfLWRzp421bvphdxMN_hIOLN895s3y2H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:ML30Y-4icBZ7bolZH0vXrV0jXkzGzFJ8I2xQWJWanNKFIh6T49PORg>
    <xmx:ML30Y653zCBJC1pe7Mc1h9EaACoA8ZD22sfqZ4jfa61BqqT7hByWUA>
    <xmx:ML30Y2jl42NjIyotQkRdi6NrzmNYZvYeac0P1nY-pPIE93TLTcCRwg>
    <xmx:ML30Y3xRGPjMuKTTKbePBZ93G-i-aUg2CBAoAwUHNLKszhNIL9C4qw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:38 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/7] riscv: Select ARCH_DMA_DEFAULT_COHERENT
Date:   Tue, 21 Feb 2023 12:46:12 +0000
Message-Id: <20230221124613.2859-7-jiaxun.yang@flygoat.com>
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

For RISCV we always assume devices are DMA coherent.
Select ARCH_DMA_DEFAULT_COHERENT to ensure dev->dma_conherent
is always initialized to true.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8b1dbd23dbd6..c1327309e0f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_BINFMT_FLAT
-- 
2.37.1 (Apple Git-137.1)

