Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5BA74B3C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGGPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGGPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5F102
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5E4619EF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF51C433C9;
        Fri,  7 Jul 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742623;
        bh=0zVXLprUpQU+oJMwLsb3lwhShv/mpv3ilpjhA5PWGGg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ubXCBmIX/zxWd+xAxTItNg8C/lpNTMnHDkxZ8jv85smVGtsy6TXYKwKYoCIJog2xb
         wMg1czLeDcNHofMPP+0sKukLLTiWH51ZjpNfeGCih6jvp5bqe40a/UEvXubTggyz7c
         Vhvri0hkV0FG2wfd2Jq9O29hKVl8loXlbdIp2yEk+mgP7VYW7yAl8Fzl7UFbEfH+xB
         b+rOcUPr8oXn9H6F/P2LraUeNG2y8HQh+JeBz2cGvdVWzemUCqOiKRpCqbdJUqakrS
         OH7mNhY3H8Q3gBDmbwNcDqUO6GO4TGHgXoGh8SfnUnI7n2DzyRuVK4ag4OpNwzSNBM
         qgWJcTEGAg+YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CF07C0C40E;
        Fri,  7 Jul 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Select HAVE_ARCH_USERFAULTFD_MINOR
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168874262337.15275.12046013710547039140.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 15:10:23 +0000
References: <20230624060321.3401504-1-samuel.holland@sifive.com>
In-Reply-To: <20230624060321.3401504-1-samuel.holland@sifive.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org
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

On Fri, 23 Jun 2023 23:03:20 -0700 you wrote:
> This allocates the VM flag needed to support the userfaultfd minor fault
> functionality. Because the flag bit is >= bit 32, it can only be enabled
> for 64-bit kernels. See commit 7677f7fd8be7 ("userfaultfd: add minor
> fault registration mode") for more information.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: Select HAVE_ARCH_USERFAULTFD_MINOR
    https://git.kernel.org/riscv/c/a2492ca86c98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


