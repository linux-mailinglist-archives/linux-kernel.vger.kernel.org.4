Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4804569E0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjBUMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjBUMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:24 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240B12F0C;
        Tue, 21 Feb 2023 04:46:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 45DF23200929;
        Tue, 21 Feb 2023 07:46:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Feb 2023 07:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1676983580; x=1677069980; bh=o1ZGzAY+2IAq6iM9F+Xf8a1cE
        huTp9TD8y5vFZAwf2Y=; b=EMJBt3zyvDdk72wNVD6Rp0MSRXuNpRO1l4RTro2Bm
        Q68vwd6ylAHTjrNFljCyq/JBIn3lPPXfgc4/6kk8pQgPkHmUfQCfVhmtTjfoAUiq
        E/1Z2y3iMjQZb/AYwTUje2WUwJPnsW8dGeROQUPzZMMapCpNieebulQ6b1s5lOgS
        LsUuGRK/I5d2SJ4y4WrcSJPckasYkpldbLC2L/xjAJasWeEQOnOy2/fv6z6QdazG
        0CV9dHfdja/HMB+EHvRjIXBskQYkKM8Cr3uY3SLxOq0hcNokeOxDrhxM0XZPuvTO
        HuWtbpT/vjLX4Qq5womPSW0644hrxyBElJ44X/bD6TpwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676983580; x=1677069980; bh=o1ZGzAY+2IAq6iM9F+Xf8a1cEhuTp9TD8y5
        vFZAwf2Y=; b=th8zsIYP60+WQlHRLMTjitDNcmVVDGTJ4WbmTbjgZDhRpdcEwlE
        aCund/RrXSmSkquNlWkBr2iMp0JV5Mm+P3VNM29fo27vJM/A4nzKB4CevyDHad2J
        djFJxRQhZHNRUSRui7eG0RgbSYGhXbPbvdKUr0VjPNaZggFS+fMolbh72aV8uyI0
        hHatvxsKUdaK10Q7JbiQHjloeYstWVihqVySVTiuHHwHxi5ZbeiX8esoglNsHTSp
        A+K0VLkheajhYIwiap8e8HA+U850GivU0NLEI6wpmTCGdBRiQFVW87ycfljjvf9i
        hofR4SCjfv1ATpwx0NjJq6viCycYj/SCpsA==
X-ME-Sender: <xms:G730YyDtoU_NWr-nX8omgYp9iWEj_Cpb88tfMFG7GUF6i_qqaeMpsg>
    <xme:G730Y8jScgS-F_7op8B22ovm68GLn8BL6vO8AryrQRCvto2J2QuiFdFn-oTd1ADFM
    -RIkx4qSaRWuSc4ifk>
X-ME-Received: <xmr:G730Y1nHA8Z1dGd7OMFxUBeSeLbmsED_OBnzecdttXlDAJIOTc0UGAsii8Lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:G730YwxDpe2tLRi9YpZeLRv_SsYUczt_Urwj0V4BSAXYzA3yHIJG_w>
    <xmx:G730Y3QY7hzjzjJ6ucBUr7Fv_xJmTC1vaxZ7xNPsrtwTXLSaCN9l0A>
    <xmx:G730Y7Y9L98rNX2KaPH3_pmFqXa3yTp3iFs8SR4cGFrKqw-5p3Xx1Q>
    <xmx:HL30Y8Kvm1mRR7-cnzS-00Ff_ZzvPWOsyBWtSIbb2hjIGU1m7Ec61A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:17 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/7] MIPS DMA coherence fixes
Date:   Tue, 21 Feb 2023 12:46:06 +0000
Message-Id: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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


Jiaxun Yang (7):
  MIPS: Remove DMA_PERDEV_COHERENT
  MIPS: Always select ARCH_HAS_SYNC_DMA_FOR_CPU for noncoherent
    platforms
  MIPS: c-r4k: Always install dma flush functions
  dma-mapping: Always provide dma_default_coherent
  dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
  riscv: Select ARCH_DMA_DEFAULT_COHERENT
  of: address: Use dma_default_coherent to determine default coherency

 arch/mips/Kconfig           | 16 ++--------------
 arch/mips/mm/c-r4k.c        | 12 +++---------
 arch/powerpc/Kconfig        |  1 -
 arch/riscv/Kconfig          |  2 +-
 drivers/of/Kconfig          |  4 ----
 drivers/of/address.c        |  2 +-
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/Kconfig          |  3 +++
 kernel/dma/mapping.c        |  6 +++++-
 9 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.37.1 (Apple Git-137.1)

