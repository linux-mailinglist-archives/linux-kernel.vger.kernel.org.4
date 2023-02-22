Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA069F5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBVNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjBVNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:37:23 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342F193CD;
        Wed, 22 Feb 2023 05:37:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E9195C0114;
        Wed, 22 Feb 2023 08:37:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Feb 2023 08:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677073042; x=1677159442; bh=+/
        4foVkx/AAkjDoTO2qfVYMQOOmzfm5uV10l4tbGnOM=; b=bEC+HUAWsEqXDeJF4X
        MA1wqXCKJ3T2WcwxsnS4elTB0VjWbYBje7oacXsnUgnACmBeeGTB67w8FzAYkqV+
        aXedw+fQrbk6Ch9T0UKEN/g9k8wqPAwrVmUGF6RBg0n1ZCzXlTU322qudJoDORSP
        gQ4KCCvuPkpvkGjZcVxXEQZKXoPedwlWjlt+3P0OBw30xeOQ8NtrDPb27k4vMhbB
        AnKak+Ybarxu4f5rTHMwmzj8cbrKbCd+y3tu2Su51ZDh4AaRLO1XLDK//BcIZmod
        P8vSn6rQzRWQFrph3P0YiywCRCfaLgV4RpxIQXvdpe/oiDwkAaoQdHl/s8uKAUdu
        BL9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677073042; x=1677159442; bh=+/4foVkx/AAkj
        DoTO2qfVYMQOOmzfm5uV10l4tbGnOM=; b=lDTx8Fqm9+4FFLw32LKkKiTLwmjsn
        l0mUUxPCKnaLpsBBiYnHOJHUH0TF7ZblTTeqK6mJ0R2v3St5xbF2tbhe6vXGPjkr
        K3Q0GCn2kau2vIzfTDF/MA8F2CleyTwjfKDBICORHF+kr+373Y0Un07s5/EXt2iP
        sSLw1qR8QIO8ERnP2ikmBv+6d4jBge/anOebCHV+i0oLFB/ftSXv0nS5HftxAtbX
        ni4HtVZDoxtf6OPwBt/wvJF/DW4zkh20/yAbILyE+3KFe4hUMrwA7ZrgjQQ76jH1
        S/sIFdtmfMVTWJGVMWoqV+lwwHsuNMrb68d1F3826n6W1sczGsZW4OnOg==
X-ME-Sender: <xms:kRr2Y9rLXqnHgjN9OiU3Ioj4Iv9MH_FQTuX3iskwPFYgXN6RnrxuNg>
    <xme:kRr2Y_rDcIlUUroaiNON3InQinQ5cZER9GPwubvkOXyqhARRY5o0zYR3M7r-iboZV
    5mESgeohyKZCjsIDnY>
X-ME-Received: <xmr:kRr2Y6Nl7kK3L-9EJbzaWulMM751DAyK-x3EUTMo_TFLgLxQOnUBS4pIiTCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:khr2Y44k-f8lGvXVpfkiyhTu-K5nUpUo_usZN-Owu2afTvXZjm5Maw>
    <xmx:khr2Y87oF-dy0Qq1uqr0amcdajC_jRA3PhOwbOcVyP4V45QkI55gYw>
    <xmx:khr2YwjQJaOcURNBXeonaXJ3885rq_0kR6lixtyi68AWcZsM707kDQ>
    <xmx:khr2Y8j0bzq9U0BMjug_XQefxGrIxZw6wz1xnuCljQSdSBkOkuUKsQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:37:20 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] riscv: Set dma_default_coherent to true
Date:   Wed, 22 Feb 2023 13:37:11 +0000
Message-Id: <20230222133712.8079-3-jiaxun.yang@flygoat.com>
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

For riscv our assumption is unless a device states it is non-coherent,
we take it to be DMA coherent.

For devicetree probed devices that have been true since very begining
with OF_DMA_DEFAULT_COHERENT selected.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/riscv/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 376d2827e736..34b371180976 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -300,6 +300,9 @@ void __init setup_arch(char **cmdline_p)
 	riscv_init_cbom_blocksize();
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+	dma_default_coherent = true;
+#endif
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
 		riscv_noncoherent_supported();
-- 
2.37.1 (Apple Git-137.1)

