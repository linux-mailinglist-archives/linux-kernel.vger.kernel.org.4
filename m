Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D106D2F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDAJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDAJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:15:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6865B9;
        Sat,  1 Apr 2023 02:15:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 158355C0158;
        Sat,  1 Apr 2023 05:15:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 01 Apr 2023 05:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1680340540; x=1680426940; bh=Sm/eQGuZcU
        AzNY/GFXXITkKckQxGS+A5PlDB5scZWkU=; b=fjcFYggGb4OVf1pzdEYo17YkMx
        2Efmp1shhPRn6Bt9P8kKC2CuKhlv4uih3fPMtxttH+MggUdjwdpBzaYEHhScEq2f
        HOAaygQJuli8lqLNHXnsYT6gVGMMPKou5k8UTMgDzKBdrjf30lRvHRarJdB7gVp0
        pGQofPzD8bXpPLDbjVwEzbVwINYUfQMlPMAOHViBYaMwliqM91HQyYqNL8Q1rTNT
        c3jbM1CpsAsdOqB5yvUVo848LLS5r7heOYlDCV2+BVHUq6aZUdRIpwptqTG89qYI
        mlGaG8aGzM6ZYfzQgFafLSQpmy/UbcU02j7Y7lozF5ONQCeMkT/KIkw1lP1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680340540; x=1680426940; bh=Sm/eQGuZcUAzN
        Y/GFXXITkKckQxGS+A5PlDB5scZWkU=; b=aFtafIFXo2CkpTEHZ1q/tiUh0cQVK
        36gIQpmYlyRdjeDWOUhoCssahVisfR62yOm4pIxdUxZxQ8q5tEr6u1LvBaHdcGi1
        P6P28PklrflNdwBYQei19f+8bSofs3YFQUdQT7P9lJvzAbYNfzpDyrJj7qm7kAjQ
        PQvNyjH3yyxtifhIFL22DXoZW6/CJbul3v26LukN0LvaTws/eK1IZcoHF6mx3Pg8
        ZGWt/1/zLvvf6b2DJ7A0kDTxe/CaMvncAS3+Z8VNY5uRkTd916HPzoNY8qhLkqum
        FDDoUUVr4EW2A1xsvxK+0qWKRalQur2MBDcD/8w5uW+3pCkt63JVWaBgg==
X-ME-Sender: <xms:OvYnZBNwy_6UQiCElzlgZCSKZiCLsHvIILbCqF-lrYNPWlYdNwPBXA>
    <xme:OvYnZD_myVa0dcrmmb-VxOfQUL33J0WBtozhe2kScwqFTJ5PSN-vAc84x0LEW9wSC
    ntYxaReOq3ENuh0qlQ>
X-ME-Received: <xmr:OvYnZAT7RzRC69BiUKWC0L5CfJoNOYjra6UGCzZkhXzyi_kKm1ijAdz7dSXUtYF2Aq9GboSYzc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:OvYnZNvkvhKqh_H0ey5fxKOABQ4ybIUvYmTmpKZrsNzUm3W4sL76dw>
    <xmx:OvYnZJf3C50KQFxJWZmxs8RqguDuXTr3JntFpJGIgkiAwC3iwOocmg>
    <xmx:OvYnZJ2xpFDMQ4WbMCXeIkeXEkc99Pi6e5iGO6_PqoRw7gQ1yEv2Tw>
    <xmx:PPYnZM-vsPoKAC8U2W8-BPSGWKf0f0IIZAEjaTg-1TD_k0QK8RERCQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 05:15:36 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     iommu@lists.linux.dev
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 0/3] Use dma_default_coherent for devicetree default coherency
Date:   Sat,  1 Apr 2023 10:15:28 +0100
Message-Id: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series split out second half of my previous series
"[PATCH 0/4] MIPS DMA coherence fixes".

It intends to use dma_default_coherent to determine the default coherency of
devicetree probed devices instead of hardcoding it with Kconfig options.

For some MIPS systems, dma_default_coherent is determined with either
bootloader or hardware registers in platform initilization code, and devicetree
does not explicility specify the coherency of the device, so we need the ability
to change the default coherency of devicetree probed devices.

For other platforms that supports noncoherent, dma_default_coherent is a fixed
value set by arch code. It's defaulted to false for most archs except RISC-V
and powerpc in some cases.

Thanks
- Jiaxun
---
v2:
  - Add PATCH 1 to help with backporting
  - Use Kconfig option to set dma_default_coherent 

v3:
  - Style fixes
  - Squash setting ARCH_DMA_DEFAULT_COHERENT into PATCH 4
  - Setting ARCH_DMA_DEFAULT_COHERENT for PowerPC

v4:
  - Drop first patch

Jiaxun Yang (3):
  dma-mapping: Provide a fallback dma_default_coherent
  dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
  of: address: Always use dma_default_coherent for default coherency

 arch/powerpc/Kconfig        | 2 +-
 arch/riscv/Kconfig          | 2 +-
 drivers/of/Kconfig          | 4 ----
 drivers/of/address.c        | 2 +-
 include/linux/dma-map-ops.h | 2 ++
 kernel/dma/Kconfig          | 7 +++++++
 kernel/dma/mapping.c        | 6 +++++-
 7 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.39.2 (Apple Git-143)

