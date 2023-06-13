Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6372D8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbjFMFK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbjFMFKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14585138
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CE56316F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4E5EC433A1;
        Tue, 13 Jun 2023 05:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686633022;
        bh=NHdCIb1zv2Arlk5ZHNC+WxvFRKd8YhAHkgky6zU714g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EYYc3q/wMH0BEElR4x/aWfNiKnE71+w4S+tZLwcSdvjo1qGvXoaD/aG88sVhkjMHi
         n+gGLe9BWmjKmKaLk8YKHBwPoV9VOu96aLes+jNv6RM6W34JpNbR76odLODm8h5evn
         pAV08PHhJh3Jy0hpQRPuObLNH1miq6RhccmMFeHF/vIX4ERUOLbZxfoGKjhcO8Pyak
         rrkODPSW/ch6e+/A6GLRZ878944LH6FSSwHYPk/Qgwq9PwnMTOKeOXamk98pUJR9qs
         F5SVa8qZBGLrguJ4ekYlKP1OHRuLNY0UrbmNKq5jUCkxmnMUg+KNNkmaxx8vIJjl/z
         MVGsuoSADZW/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7DEFE21EC0;
        Tue, 13 Jun 2023 05:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] splice,
 net: Some miscellaneous MSG_SPLICE_PAGES changes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168663302181.19155.9169104916425356557.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Jun 2023 05:10:21 +0000
References: <20230609100221.2620633-1-dhowells@redhat.com>
In-Reply-To: <20230609100221.2620633-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        willy@infradead.org, axboe@kernel.dk, linux-mm@kvack.org,
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jun 2023 11:02:15 +0100 you wrote:
> Now that the splice_to_socket() has been rewritten so that nothing now uses
> the ->sendpage() file op[1], some further changes can be made, so here are
> some miscellaneous changes that can now be done.
> 
>  (1) Remove the ->sendpage() file op.
> 
>  (2) Remove hash_sendpage*() from AF_ALG.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] Remove file->f_op->sendpage
    https://git.kernel.org/netdev/net-next/c/a3bbdc52c38f
  - [net-next,2/6] algif: Remove hash_sendpage*()
    https://git.kernel.org/netdev/net-next/c/345ee3e8126a
  - [net-next,3/6] sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
    https://git.kernel.org/netdev/net-next/c/5df5dd03a8f7
  - [net-next,4/6] tcp_bpf: Make tcp_bpf_sendpage() go through tcp_bpf_sendmsg(MSG_SPLICE_PAGES)
    https://git.kernel.org/netdev/net-next/c/de17c6857301
  - [net-next,5/6] kcm: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
    https://git.kernel.org/netdev/net-next/c/264ba53fac79
  - [net-next,6/6] kcm: Send multiple frags in one sendmsg()
    https://git.kernel.org/netdev/net-next/c/c31a25e1db48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


