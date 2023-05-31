Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847F717DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjEaLKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjEaLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F265107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF9F639BB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68FCFC433AC;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531421;
        bh=FPFcVsxFDHWUA/K7a3KuzDqudNUNFy//Xing6rKzvoQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m+DqHJ0zQj8KriiyBfn1TRBjWr08KcVIH4vf2cmjjXqSR0fn/PiWQSHx/9zJ3jfsw
         6RmrMLArE7YG+3SNjhHGt2AR9f4caAFND+reU1bugY0KR9PfuBFWSsIfbZmMqGgpeI
         1myxhAaorRGbkpQvZKNdtPAQjX00nc0cVUdor8M1NjRKYTE66VLy++5YAiozrT0V4Z
         7vwKUT6USkUWoXbAU9FB7B9eXKvrYx9+FgUcwtbVHQwYxrM+Hxcd649GhyGe4cSKHu
         STAau6N7M/jGQRijQluWopO5UV56Gqo9uGPdYnfXn93eFKovOIpL380v8Ib9Kt4Glg
         Q6hWT4bwdGeGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42D93E21EC7;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: use umd_cleanup_helper()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168553142127.8778.2442831312976659281.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 11:10:21 +0000
References: <20230526112104.1044686-1-jarkko@kernel.org>
In-Reply-To: <20230526112104.1044686-1-jarkko@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     davem@davemloft.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 26 May 2023 14:21:02 +0300 you wrote:
> bpfilter_umh_cleanup() is the same function as umd_cleanup_helper().
> Drop the redundant function.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  include/linux/bpfilter.h     |  1 -
>  net/bpfilter/bpfilter_kern.c |  2 +-
>  net/ipv4/bpfilter/sockopt.c  | 11 +----------
>  3 files changed, 2 insertions(+), 12 deletions(-)

Here is the summary with links:
  - net: use umd_cleanup_helper()
    https://git.kernel.org/bpf/bpf-next/c/9b68f30b6870

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


