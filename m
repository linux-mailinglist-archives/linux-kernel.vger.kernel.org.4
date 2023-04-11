Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E436DD905
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDKLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD14E5F;
        Tue, 11 Apr 2023 04:12:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2836E5C0098;
        Tue, 11 Apr 2023 07:12:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Apr 2023 07:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1681211559; x=
        1681297959; bh=PMqqr88crw3e/FBcE7+PtWmriJr6ml+310l16WR9uDE=; b=S
        Js5+f5AIDMKMpprBscSE7GMgHwHstngC7MN78l+7N7GzCEzfOTtfhTiLSCZxs3x/
        9iLaeCDCy1Dy3WCzVjY6S5Mlc3Y+Fpr0EOIjNR4I4bfX2wjXvC9FzJidaaHBIulI
        kUY4gkcvTxXerzE0nLWiRNlg6NiBl0xoCD0Cb8YjS9Ttk6THOi4Xd/8ix6Z+ETIr
        4+HwIp2IYqjcO2AZtxBXo0mDrNbw8yR2VjPh8aE5kWLPxyqZZQSZqn+5uuVBbgA9
        i78zNsOc1L6ITV0447/t6HlbP3cIaE/YeCn34NV3ns7HrCnSb2mopH0y9aAVO7hf
        34p6qpC3sBabd1Ar8K7uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1681211559; x=1681297959; bh=P
        Mqqr88crw3e/FBcE7+PtWmriJr6ml+310l16WR9uDE=; b=WSXYfmv3bD7xpK39y
        xtgqik5zXTvNddVhbO0KZRPFLFbuq7LgslTEwk1SuoUMLcJnQyEQvY7z2yl1EqDU
        3JmXtgW6DAlT5YgAnT7c5GfisTTK1PpUY2P8dwvwn9fnYufOcFTMVSPSkJ32ll6E
        2Rbs5quDsx295bvsiFqdTqQXorG0Vle7fn19PTMyWfTlqQifrXeOQ4BER0T0hNrL
        xPyfT9iQAONB6NVfpocmGNqRp14Xt4Ec7J5MYkKEffuEzW4uWBKftXpyNXVEkPwA
        20TmTwSKjZvFi5y8R8jNMfZoMqu/RB70OXjTuJ9M6hUNm4U9M+hcXm7oyOTYjV0H
        DyDNA==
X-ME-Sender: <xms:pkA1ZJpMK949mggMz6Nd8uMDj3nsYJoDMK_XHWQRoF7Q6ZX-Tsav-w>
    <xme:pkA1ZLoVMPGdv4IroZLFHeOn9ZPya7UI-I8KbCQEnOBbnsXS0pU8gZfDM5FTcRfWC
    9SAKyTM1rMeTt32iS8>
X-ME-Received: <xmr:pkA1ZGO01i-L5g1R1gZOtMirdjSHRZUrSsG4fvug0MatqKN5AAB_oWl2gXkF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejueekkedvfeekudfhhe
    eliedugefgffduveeviedvffeiueekiefhtdekueeuudenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgt
    ohhm
X-ME-Proxy: <xmx:pkA1ZE4so64hSpnTAkJkksasijDc2iyaqROC4hEni87DjzsVVPbqxA>
    <xmx:pkA1ZI61c63DFiXYqXdn08GQrRdrcQXFztZ4HZYmE627tt_L5Eh0mQ>
    <xmx:pkA1ZMh9MNO_jSqvaXrbK8lxilJ1gVkrd5Vid2xWyZDH4cAtOZdV1Q>
    <xmx:p0A1ZGnU76JpL9dC0ICqGUJ_6O5FPcPiXuuspj2M33Hn0-t1ySYDgg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:37 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/7] MIPS: LLVM build fixes
Date:   Tue, 11 Apr 2023 12:12:17 +0100
Message-Id: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes some build errors when building with LLVM.
Some of them was discorved by inspecting the tree.

Tested with LLVM + LLVM_IAS={0, 1} and GCC against:

allnoconfig, allmodconfig, 32r2_defconfig, 32r2el_defconfig, 64r2_defconfig,
64r2el_defconfig, micro32r2el_defconfig, 32r6el_defconfig, 64r6el_defconfig,
loongson3_defconfig, lemote2f_defconfig, ip22_defconfig, cavium_octeon_defconfig,
malta_defconfig

With other patchsets [1] [2] [3] I sent before, on my CI [4], with tree [5].

allmodconfig is still failing but it's not related to MIPS.

[1]: https://patchwork.kernel.org/project/linux-mips/patch/20230407102721.14814-2-jiaxun.yang@flygoat.com/
[2]: https://patchwork.kernel.org/project/linux-mips/patch/20230408115936.6631-1-jiaxun.yang@flygoat.com/
[3]: https://patchwork.kernel.org/project/linux-mips/patch/20230407102721.14814-2-jiaxun.yang@flygoat.com/
[4]: https://github.com/FlyGoat/kernel-action-ci/actions/runs/4649898964/jobs/8228560848
[5]: https://github.com/FlyGoat/kernel-action-ci/tree/71d3f53e9c44cebf62cfa4ed7ec3b0ce6452555f

Thanks
Jiaxun

Jiaxun Yang (8):
  MIPS: Replace assembly isa level directives with macros
  MIPS: Set ISA level for MSA control reg helpers
  MIPS: loongson2ef: Add missing break in cs5536_isa
  MIPS: asmmacro: Restore fp macro after undef
  MIPS: mipsregs: Parse fp and sp register by name in parse_r
  MIPS: c-r4k: Use cache_op function for rm7k_erratum31
  MIPS: octeon_switch: Remove duplicated labels
  MIPS: Implement microMIPS MT ASE helpers

 arch/mips/alchemy/common/sleeper.S            |   6 +-
 arch/mips/include/asm/asmmacro.h              |  57 ++--
 arch/mips/include/asm/futex.h                 |   8 +-
 arch/mips/include/asm/hazards.h               |   2 +-
 arch/mips/include/asm/io.h                    |   4 +-
 arch/mips/include/asm/mipsmtregs.h            | 256 +++++++++++-------
 arch/mips/include/asm/mipsregs.h              |  63 +++--
 arch/mips/include/asm/msa.h                   |   2 +
 arch/mips/include/asm/stackframe.h            |   2 +-
 arch/mips/kernel/bmips_vec.S                  |   4 +-
 arch/mips/kernel/csrc-r4k.c                   |   2 +-
 arch/mips/kernel/genex.S                      |   8 +-
 arch/mips/kernel/idle.c                       |   6 +-
 arch/mips/kernel/octeon_switch.S              |   6 -
 arch/mips/kernel/r4k_fpu.S                    |   4 +-
 arch/mips/kernel/syscall.c                    |   2 +-
 arch/mips/lantiq/clk.c                        |   2 +-
 arch/mips/lib/csum_partial.S                  |   5 +-
 .../loongson2ef/common/cs5536/cs5536_isa.c    |   2 +-
 arch/mips/mm/c-r4k.c                          |  33 +--
 arch/mips/mm/cex-oct.S                        |   2 +-
 arch/mips/mm/sc-ip22.c                        |   6 +-
 22 files changed, 277 insertions(+), 205 deletions(-)

-- 
2.39.2 (Apple Git-143)

