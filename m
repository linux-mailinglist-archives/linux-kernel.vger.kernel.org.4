Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC0647B73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLIBa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CD801EC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52686B826FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D24EAC433EF;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670549418;
        bh=f1cL7pV8I99q0tSRDPv/Gl5RgKQSNbhxEEWS18lyhVY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kfBXi1pJukSy8tQaBAY+s6ev7y5+IRn5fPXjWXqxsnd/xjBPkj66KoR2NVB+QmzHz
         MOGUZcwNrAFZV/yQM/C3eW8bc/MjBnCp09nwTm9YJeLrcmaPjF8YaM49VhjR+HS9ST
         rHgx76rAATe+P9k9HekmTQixHYAwmfApFE2oHYIoECLPv/x8RvM5x6a2ttN+vBtEG3
         TqRdHGdCIM/QQm5oU3H+B4wBBjQzUDF2goezQjD7J0aKmxXHB57cVCGKVek+4Ck/jX
         6ByODRz+S4jElg46O3fFkUUhMJxx3lGxO4FBv22sttz5s2j8xQXL8PWuoBwQZXAdep
         QEZ57uaQ7vtAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B81B4E1B4D9;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] RISC-V interrupt controller select cleanup
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167054941875.3046.10675797620524560319.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 01:30:18 +0000
References: <20221118104300.85016-1-conor@kernel.org>
In-Reply-To: <20221118104300.85016-1-conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, maz@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com
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

On Fri, 18 Nov 2022 10:42:58 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey Marc, Anup, Palmer,
> 
> Submitted a patch yesterday defaulting the SiFive PLIC driver to
> enabled [0], and in the ensuing conversation Marc suggested just doing a
> select at the arch level and dropping the user selectability completely.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] irqchip/sifive-plic: remove user selectability of SIFIVE_PLIC
    https://git.kernel.org/riscv/c/fdb1742aff43
  - [v2,2/3] irqchip/riscv-intc: remove user selectability of RISCV_INTC
    https://git.kernel.org/riscv/c/d8fb13070c3c
  - [v2,3/3] RISC-V: stop selecting SIFIVE_PLIC at the SoC level
    https://git.kernel.org/riscv/c/bf3d7b1d8499

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


