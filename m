Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB43737530
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFTTk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjFTTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973441710
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EA56119E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C8B0C433CA;
        Tue, 20 Jun 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687290023;
        bh=NMfOxx6q+hxrTh7EK1c+LpZj/IcR3oyMUkdkNjdu1QY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ScMlDdRKJITYQwHZ5thwj3BRhtBNXKiebqKZKjd47Uov7xTtdrWYyEHVlCUwveOBA
         DmkZSpIsidKffAtrCMj8s705uiWbUlD6x/g5QvpVMqQCpEl0VECCqyLPHgPSj8WEqC
         Nt9f3QHqOe80kAxH62CBfbpYGVdz66bXpkukX3VRd6aejt5UHvI7F6lZnDXLVadhVE
         IyGtW/j5KdnxArst2iUZ4FGGVWep+nZugoK2IZlypfA1DSnZ2culXqt9LZb7TtxME9
         evE6jR/7w+kTQriogJuMBluOLTw0Ev7skL+x4FvVpTKNdoPfXFwqjNm2q1mvIcLGYF
         yhFWA4jVVg1sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5089FE2A035;
        Tue, 20 Jun 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: uprobes: Restore thread.bad_cause
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168729002332.20607.6961437038563461199.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 19:40:23 +0000
References: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 23 Apr 2023 09:42:26 +0800 you wrote:
> thread.bad_cause is saved in arch_uprobe_pre_xol(), it should be restored
> in arch_uprobe_{post,abort}_xol() accordingly, otherwise the save operation
> is meaningless, this change is similar with x86 and powerpc.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - riscv: uprobes: Restore thread.bad_cause
    https://git.kernel.org/riscv/c/58b1294dd1d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


