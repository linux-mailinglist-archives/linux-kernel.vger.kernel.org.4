Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2FE69F538
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBVNYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:24:37 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD02FCE9;
        Wed, 22 Feb 2023 05:24:36 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 37F165C013B;
        Wed, 22 Feb 2023 08:24:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 Feb 2023 08:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1677072276; x=1677158676; bh=ZM1wKgNEbzttP80ykx2KdJ15q
        gC/eZYBwqpxuFevkVA=; b=SQb+gxcoYAWBv+g/yNFmfNb3vsQqN7uKqNP72D87T
        Da2fauFAxT5ULoNpAntMFqUo/VNjsVOBFVi3Uz81u8wGvNfEn414AGVDOvEFB6+m
        1VQHP/1zv+V4veI+BxBWPdmLigbwjOnug1R5+0+faZFAJMnnVxkdmWrCg9VgMtD1
        5N6mW3cvfN7rMCI5vHfBZbcCwLC3OAuDRwmKGkxdyBgvyDaqin62N5rM7x4nM+qt
        1m1LGSotptrKieAthtKz++vURTEzz+4E+NKMZ5fCthd7y6yGNuAAheqmZ8Nxwjdz
        sox1qjPUINUzkP2brUWOK7EC9oQ4s+540KYh1uFZnEVFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677072276; x=1677158676; bh=ZM1wKgNEbzttP80ykx2KdJ15qgC/eZYBwqp
        xuFevkVA=; b=IM8NjXIzTgck/ZMKbQG6QxlyiodR0CxujtYBz+OiO3IOewDcjEn
        4/Niu/ZQxVzdw6hZTG7oS6JvBihRFy1uIdpkYzl/GmgTNZVL4UUbP7gzESZEDOSM
        51pQDhn2rYjQQErqJYjEjc3PUW/RfIu4PUV+YDuwK4gKzdGySGpJfvA5l/tWxkWY
        b5XtOct702wV2KvbSoKmTh+cMC7kv/76bgKn7Fx81j5yQZs2KY242obhAHUmgxU4
        qhl4Mk8o331n9goauBeFFKcKkHunjQa73wNLLDzW3Qz9s1oDO6JuL+gkvOgTPhqf
        FurlP2pYk6D4XlT3xtVjzseZQG2s/erhqtg==
X-ME-Sender: <xms:lBf2Y7gqLQ9Gkc_b0L65mry5zpA0jPbpnfmagBAIXpSsCag5XdtPHw>
    <xme:lBf2Y4CcMkSWDupoRETL7L5d9w_91ob6_X9nCUet-cFDgTNMYBLfp1CLiYFSq6JzV
    6JtoujZ7_fksND9IvI>
X-ME-Received: <xmr:lBf2Y7H6h78BMt-2x1sYR_VPgehbCyuO54JJ4dFyQyyazGx0QWlFxofHZxUN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:lBf2Y4QvMJbllcPB28ctXEpZbMaNw1ErP8FCn8loITKMogPWJ0Kmqw>
    <xmx:lBf2Y4yXKL8MQvQ-brKKrODGaYHNRBpzm5E1f68WUIAKS5yPVNAy7g>
    <xmx:lBf2Y-7qZnp2w0i1ESo896fL-UhJi08qRym70Y-TEnAEraYjivqb3A>
    <xmx:lBf2Y0-APF_XIMTUEUH8QqZ5Y8-Wj6fsG5UjgwOYBzr8S8th4D47_g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:24:34 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        hch@lst.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/4] MIPS DMA coherence fixes
Date:   Wed, 22 Feb 2023 13:24:21 +0000
Message-Id: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

Hi all,

This series fixes MIPS per-device DMA coherence support. It's mostly adjusting
Kconfig options.

The v1 series had some extra patches that fixing default coherency settings
for OF probing but I decided to send them as a dedicated series.

Thanks.
- Jiaxun

Jiaxun Yang (4):
  MIPS: Remove DMA_PERDEV_COHERENT
  MIPS: Always select ARCH_HAS_SETUP_DMA_OPS
  MIPS: Always select ARCH_HAS_SYNC_DMA_FOR_CPU for noncoherent
    platforms
  MIPS: c-r4k: Always install dma flush functions

 arch/mips/Kconfig    | 16 ++--------------
 arch/mips/mm/c-r4k.c | 12 +++---------
 2 files changed, 5 insertions(+), 23 deletions(-)

-- 
2.37.1 (Apple Git-137.1)

