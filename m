Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F4723616
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjFFEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFFEKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346E18E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EA8862CDC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDDE2C4339B;
        Tue,  6 Jun 2023 04:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686024619;
        bh=VVx+P2r9bCSbYbOc7SkWqcUm8Fu+AOSugCg45wbfwRI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ITWmvk4ZCl68Slh4bspflOosrlYORy6ybeFRVODfGZ82toBnTzxgAYYXb+4ejBjND
         gMtkNBbyhUYCU7PxERDpOuYlKNkW9VEpYQQVL9gpTc8WOdWvjAVrZyqkDd4EoeJxHI
         sI6t0qUjXwZzVhfdopjyFuZw4PT1auyNrG8UmPE9JuCPJaV1qBWv3L46DHzOxZRUM9
         hCwaAw2VPfjdCSXepCGJki9eNTxKhJ4vH13bU+rCZFL2zz5rDGBU7aPk7EpiYjrpRf
         Gz4LvZWvbZ3QV2DTxaDRFjaEUGgYSsJ3YQtCMH9gihh14qvXbgV5+XWDsCE31QrT3I
         ZWxPtFBTZVYCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A83A9E4F0A6;
        Tue,  6 Jun 2023 04:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] splice,
 net: Handle MSG_SPLICE_PAGES in AF_KCM
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168602461967.14509.12155407584086757066.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jun 2023 04:10:19 +0000
References: <20230531110423.643196-1-dhowells@redhat.com>
In-Reply-To: <20230531110423.643196-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, tom@herbertland.com, tom@quantonium.net,
        cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
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

On Wed, 31 May 2023 12:04:20 +0100 you wrote:
> Here are patches to make AF_KCM handle the MSG_SPLICE_PAGES internal
> sendmsg flag.  MSG_SPLICE_PAGES is an internal hint that tells the protocol
> that it should splice the pages supplied if it can.  Its sendpage
> implementation is then turned into a wrapper around that.
> 
> Does anyone actually use AF_KCM?  Upstream it has some issues.  It doesn't
> seem able to handle a "message" longer than 113920 bytes without jamming
> and doesn't handle the client termination once it is jammed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] kcm: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/2b03bcae66c7
  - [net-next,v2,2/2] kcm: Convert kcm_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/5bb3a5cb3e21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


