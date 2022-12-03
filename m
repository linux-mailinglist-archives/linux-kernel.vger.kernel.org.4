Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C796412E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiLCBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiLCBAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28648567A;
        Fri,  2 Dec 2022 17:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45AB862477;
        Sat,  3 Dec 2022 01:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91984C433B5;
        Sat,  3 Dec 2022 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670029216;
        bh=MGsPTcfIDMe8NsW+WgRecjSM7wji1B+lYnN8B7L988E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DnOIfI/oz3QrsMN5TuUpL4+k48Cgf1oo2sPSBBvl6Mo2HqJPMaI4tz0CSTIIMRaIS
         SRZTLFxi/xfJ97DlMF+60OXNAFRBpTu16M8+4yWIsMp2wnMsFUhHyGQTVDuhRpOfzE
         aUSYPDS3QoRdCA/VDPMI1Q+qjhIi8g4eU32SuTTunZnYJI54tig6yhCL3uTtsnPWSv
         wXKqPBGKxfustW6KDKNC461eKxZ/w+M8KuoeYuT3g0KVrPZcvtEG8p2A4AjKoB+AEI
         h8MyMtL+i41gbjgKPFmN0FJVqltNSLhB0aKd0g8xHKHlUREnuYDKx8nlGNgSd3saoC
         CvQZOE7R7ptAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75819C395EC;
        Sat,  3 Dec 2022 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167002921647.19521.1698989789137180552.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Dec 2022 01:00:16 +0000
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 26 Oct 2022 22:42:06 +0800 you wrote:
> As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> need to update according to Bagas's comments.
> https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> 
> As others patches in above patch set already applied, so this patch set only contains below two
> patches.
> 
> [...]

Here is the summary with links:
  - [V5,1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
    https://git.kernel.org/riscv/c/649d6b1019a2
  - [V5,2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
    https://git.kernel.org/riscv/c/c5b4216929eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


