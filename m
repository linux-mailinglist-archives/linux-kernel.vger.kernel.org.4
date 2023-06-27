Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCC740178
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjF0Qk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjF0QkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9C97;
        Tue, 27 Jun 2023 09:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F82A611E4;
        Tue, 27 Jun 2023 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89248C433CA;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687884023;
        bh=qhrqoZJFyYeTAaz2UcFPn+tuC4Uk12bbLWZIw6uJLXs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EQvvOvi+96/TuRH9LmV8Y1eNJvyjEYMhPLpj7laewCMm6GM8uAdqfdvwoCCZrpHLk
         GYGf5ZGxhgfYW+KOEEc2/8THrJG9UMidHdommOF9qgIFHhhLhnfWZ7wh81uzu+2W0v
         Sh2VSNtQYMvlsLtNlUKXuTuUUnex+CCx8JWqX59XC1tXBmPxiF5mvA6kBr3KC6NJpf
         6U0kZjLJnMGFettylShCCnz5l0V1+dRXnVooV0V5uzQyu329seMXlDkjOH4YsNKuN6
         teWvGrbTtcJjjiLbiUvKCZ+a55BYIVBYFtHjRJ1KJYFNis6IwGRUiX0/g+vIdv9+cp
         oN6PhlkjjHbBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E6D3E53800;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to support
 MSG_SPLICE_PAGES
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168788402344.21860.17593461290392483933.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 16:40:23 +0000
References: <3199652.1687873788@warthog.procyon.org.uk>
In-Reply-To: <3199652.1687873788@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     idryomov@gmail.com, netdev@vger.kernel.org, xiubli@redhat.com,
        jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, axboe@kernel.dk,
        willy@infradead.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 14:49:48 +0100 you wrote:
> Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
> checking of the source pages (which might have come from a DIO write by
> userspace) by partially reverting the changes to support MSG_SPLICE_PAGES
> and doing things a little differently.  In messenger_v1:
> 
>  (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to use
>      that.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] libceph: Partially revert changes to support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/5da4d7b8e6df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


