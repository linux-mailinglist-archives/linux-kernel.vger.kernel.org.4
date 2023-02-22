Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0C69F5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjBVNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBVNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:37:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC162193CD;
        Wed, 22 Feb 2023 05:37:18 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 406245C012E;
        Wed, 22 Feb 2023 08:37:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Feb 2023 08:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1677073038; x=1677159438; bh=q47+CVQ8qOOPo855ergJq8EIk
        +6dfpBuSgP6iPw22CI=; b=opYVZpd/XF5J/eKbesKxrOtpEWftP+G4hLgGtKgtj
        HcHnwYNu3YC+k5hIC72K73quoO2l+1p2KNmN59U9pvIKFkSTlnTWBag/LesrY5vz
        7t7ryjM71pbSRV/Gwu/ziBpPeDKyHBYiQk0cO/TTfVS8YZmUjdJoBsRk7Cet/mFm
        /A6n/f1UZMcCjk3gs4Ogc8HQ5FPHQRSqjNiuS1O6narB35j+xKdJaZx56JMO/Wag
        3x8fSeNTYJBvMLRv61fl6S9CBTYBxW/+bupn8V1o6C444CQ65lVkK7ecZ0qJoqV2
        lYvSLd/knUOqT+PVxmBaMBNQgAWencw2CuNka3r6K5auQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677073038; x=1677159438; bh=q47+CVQ8qOOPo855ergJq8EIk+6dfpBuSgP
        6iPw22CI=; b=t8Al4EAn4K1+5pIsWvTQP1KCpr07Sn43gwo4L43VhWY97zwuk/Y
        O3rUzQTuOC+s5SMyzu67kTYKJvlgB+6MMUe3G5yf4KNwoY1LyLwRXBOWDdjkJKRm
        1GpY728Zav4aHK1cZ1xIwYgfNidOeapqPW5MYCI3y83MnmS+P1hbQmomDD7M/xQg
        6I/7vDIiNJAUsxyGEsZZwHoE0+91xVM+N1RFKPh/oBV+p3iZr+Jczd2g4Kr56whN
        LGuVfh84frqQLfIhvUWfgh9IAYfBUXWiIsYS5bKH2hGMZAPPcIhJLkmg/PmNI9Dp
        nsUQohL2uuN51ZGPDldHETle9i/6XD6JQGA==
X-ME-Sender: <xms:jRr2Y4gEYHl6JEtJG7gMX2DKvChE_vQTHW6C0yq62jrSOn94aSPfig>
    <xme:jRr2YxA6SlfPH4XT4o_Ql2G3JPJyzq36Jf-bXiiHGQZ99fVhnX-JCVZuqPcwduTGo
    Pdfn9xeHJ-Y8sod_Pw>
X-ME-Received: <xmr:jRr2YwFx5TgFJYPPMo9ZG1Z_o7OPKHCfhBWUVJ39YBPdeVA_l6SStMimWG9J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:jRr2Y5RvB610Is-2kxRvdGjpcxp0QlhByDehDQrwerFEtQBIyshGZw>
    <xmx:jRr2Y1w-Hct9lqqbRUyed-Zshsfgt96p1vlT5K3dD_ARspZ1h9uz5w>
    <xmx:jRr2Y37RMIcOFVluOV1zM6OmfPjsxzwhxGt50H225TPnN3JCi4U3KQ>
    <xmx:jhr2Y74_tiDsOk4So97qWM7it4ZmSEOZlJNx8Y8r9EiByIh_2IbJ0A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:37:15 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] Use dma_default_coherent for devicetree default coherency
Date:   Wed, 22 Feb 2023 13:37:09 +0000
Message-Id: <20230222133712.8079-1-jiaxun.yang@flygoat.com>
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

This series split out second half of my previous series
"[PATCH 0/4] MIPS DMA coherence fixes".

It intends to use dma_default_coherent to determine the default coherency of
devicetree probed devices instead of hardcoding it with Kconfig options.

For some MIPS systems, dma_default_coherent is determined with either
bootloader or hardware registers in platform initilization code, and devicetree
does not explicility specify the coherency of the device, so we need the ability
to change the default coherency of devicetree probed devices.

For other platforms that supports noncoherent, dma_default_coherent is a fixed
value set by arch code. It's defaulted to false for most archs except RISC-V.

Thanks
- Jiaxun


Jiaxun Yang (3):
  dma-mapping: Provide a fallback dma_default_coherent
  riscv: Set dma_default_coherent to true
  of: address: Use dma_default_coherent to determine default coherency

 arch/powerpc/Kconfig        | 1 -
 arch/riscv/Kconfig          | 1 -
 arch/riscv/kernel/setup.c   | 3 +++
 drivers/of/Kconfig          | 4 ----
 drivers/of/address.c        | 2 +-
 include/linux/dma-map-ops.h | 1 +
 kernel/dma/mapping.c        | 4 ++++
 7 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.37.1 (Apple Git-137.1)

