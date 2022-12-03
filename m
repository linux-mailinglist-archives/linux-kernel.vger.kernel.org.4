Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCE6412C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiLCAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLCAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E4FCED4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 665E6B8231D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 065ADC43146;
        Sat,  3 Dec 2022 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670028016;
        bh=EgjYaw3xClikiWk08UjYSKTmVdLc42t9ZT+De5dXUd0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tIvLsGKxo3/mcTaH1mrn6z/7iPfslD/AAGdSt0X5U5rdQhcHzpEJfeex3Dm9+oLqy
         DfKmx+OFbP6gGJ2OvHp4GjxeNvEz3PbOrHM+zSNSHAiZqn0Apb2xQeIZTqbVbpFQL0
         MtbQaB7MxDu4kqfjZetikb9WrPeNrQUqZpcblHiDpE2FpNo5x7gGLM5H/GfA5BQ98Y
         CDQIiY6tDbVcMqYKPKLOUB5kx51vRP+aCY+zgXW5xWsNHJQqc/GBwtvM46vLOjl8Ta
         rBRv992BThNIDIWdZxFNVdQcIwNqzxxV6nTbPzDmNgF/9myKf4QIeRbTakcyfTgptX
         Ncjr6y84LJgKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6A23E21EEF;
        Sat,  3 Dec 2022 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v9] riscv: add riscv rethook implementation
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167002801594.8228.14116873241404694670.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Dec 2022 00:40:15 +0000
References: <20221025151831.1097417-1-conor@kernel.org>
In-Reply-To: <20221025151831.1097417-1-conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, l3b2w1@gmail.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, conor.dooley@microchip.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 25 Oct 2022 16:18:32 +0100 you wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes on riscv arch by using rethook machenism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,v9] riscv: add riscv rethook implementation
    https://git.kernel.org/riscv/c/b57c2f124098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


