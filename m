Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3137693592
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBLCPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBLCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:15:37 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957F1422A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 18:15:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B88F5C00B2;
        Sat, 11 Feb 2023 21:15:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 11 Feb 2023 21:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676168132; x=1676254532; bh=XF
        d2itQ9Q8tRMCuANmPpVcUQz7tHsp9UVd1TrH5jLFM=; b=bDR6b4n0NG+2t72sIG
        VAH6ziPmwqPxQxLfm1jzqnPrshKt7OXIccm/Gr8vEnAX+VnkyNyrA2s8PZCabm4z
        4M4FEHh5osWWgS1UrmO5YK4HpFRGWG15l5ZgclBxrkALRG6tG8sqZWtEWLkB0pkz
        LHGMJsdKmISsZOZllphS/lJZbadEp/hymDNckm/2gTRKyeygpDoqUJPFqnQEZ6V1
        Ib6mvL1GjdhoVPF1gaDSskqx7tfp10dz0shDtHX5zPE6Ui5qt1hCHwMT+gCFlF44
        NhLEBHRLml30VP1TUvrVErscqm3ZiUtiwe1iLP7v4NPHOkDStH0wFFe4+OUeEub6
        MvJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676168132; x=1676254532; bh=XFd2itQ9Q8tRM
        CuANmPpVcUQz7tHsp9UVd1TrH5jLFM=; b=KLEtnz0+tCfMFjMxGOhUF5UGpmLT9
        E2k+2D7fWrC3t31yEROpLLQOiyem0XfuNqRlgKtuGX0Uq0zdKgvCdUkOvl3K21Qn
        p2+cSuMAhjljl6r7nJEISPFAmW2YTQdIXqGx6GBFxoLoUot90pOxQMvCgrH5WJPk
        WzEyK/jETrR6HMD4JzR6yxNuH3OOkkcPmHS4PQPnd4KH32IAUy14FFQ61Mh3Ucr4
        A7dpgCsWsouPzfenRBYOu0g/OjRbZL4sp+JbTYfEFikpC57gNNLEOYCnIR5UKpnw
        knAFgTlygdyEmIT2AIwa8++VVJEzmqlU8mRw5zagsvvflrPlU0dxXJlLg==
X-ME-Sender: <xms:xEvoY-7GNFfLILLAYsTchd2SabJ-mixxPCLfxVEB1IxVrbQGa1u7Sg>
    <xme:xEvoY36jkJtG2bRIoVLs64MzLxS0WOxxG2AVKrR1-Wm6iLkXJA7y1hLjaa7IxGtMl
    WXzwcvTwNl3zA6CgA>
X-ME-Received: <xmr:xEvoY9coASMaC5e-N4jrkSRhgOlig9H7oVqaTQcbKJkCzkggLYH0_W-x0l79-MzcOIJl3CVFzPrOX3mYfnujlGk97cWTBml4hu2wnNLjakPQuCMVjG6JOhKqqcS5TYIjPTS2nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xEvoY7L5Rk_PbKMLjP50gI7JXNTc1KqD68ej3adBLfYQmL_Ndq2NPQ>
    <xmx:xEvoYyIB6k0tujYNeVzxtO1HGLY2SfrKAFmFgYq6d0g1gQ8UdNCURQ>
    <xmx:xEvoY8yj5XEbubFJ2Xcd0PiQmBSPpAZvJlP9ke5IdEpe3AJ9bpIUwQ>
    <xmx:xEvoY_AfO3C20HwqnZlD0SPKYSm3coD9eY7_69meVmjkTMrHEHi7Ag>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Feb 2023 21:15:31 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Fix early alternative patching
Date:   Sat, 11 Feb 2023 20:15:32 -0600
Message-Id: <20230212021534.59121-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
References: <20230212021534.59121-1-samuel@sholland.org>
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

Now that the text to patch is located using a relative offset from the
alternative entry, the text address should be computed without applying
the kernel mapping offset, both before and after VM setup.

Fixes: 8d23e94a4433 ("riscv: switch to relative alternative entries")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/errata/thead/errata.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index c0bea5c94128..1dd90a5f86f0 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -102,9 +102,7 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 
 			/* On vm-alternatives, the mmu isn't running yet */
 			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
-				memcpy((void *)__pa_symbol(oldptr),
-				       (void *)__pa_symbol(altptr),
-				       alt->alt_len);
+				memcpy(oldptr, altptr, alt->alt_len);
 			else
 				patch_text_nosync(oldptr, altptr, alt->alt_len);
 		}
-- 
2.37.4

