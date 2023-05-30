Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF071580C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE3IKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjE3IKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A31A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F25416209A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5843FC4339B;
        Tue, 30 May 2023 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685434220;
        bh=wP/OUCblEiuLbp6g1irH70e9sSm6nSIGbaKASk5qUCY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=REiUkh4fn3b38tHn3HqR3yXrY3plxwsafqP/SbClBKN71aw4AfiYts/Z0R1pZxVTq
         YJmWveqNL01TgB2hClQlKUi2UJZRL1X0AfIc7PfU+95D2K0ZyQqTyM7RD/8GBD8/nX
         M6aXoIreVmRQEkc5UW0ZKvy9GnQhGdrDYUwy7O8q8IltxswPDe4CldDrIt5Q4qU7Yx
         BynDqXmUgSCGU5D+igQu7/tevyas67TnfRO0icXoPoDUhfTf/l40OcHf8vNLUcMCIJ
         +XCW1Mi1+n5/iXliudzlx/0ZvhpqMVXOIlSzR7V+aCzXkDws6VZafwxvSLvK0QttIG
         L68CIvZOFnvCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3883FE52C02;
        Tue, 30 May 2023 08:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Truncate UTS_RELEASE for rxrpc version 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168543422022.28448.2604307451072571667.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 08:10:20 +0000
References: <654974.1685100894@warthog.procyon.org.uk>
In-Reply-To: <654974.1685100894@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Kenny.Ho@amd.com, marc.dionne@auristor.com,
        andrew@lunn.ch, David.Laight@ACULAB.COM, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 May 2023 12:34:54 +0100 you wrote:
> UTS_RELEASE has a maximum length of 64 which can cause rxrpc_version to
> exceed the 65 byte message limit.
> 
> Per the rx spec[1]: "If a server receives a packet with a type value of 13,
> and the client-initiated flag set, it should respond with a 65-byte payload
> containing a string that identifies the version of AFS software it is
> running."
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Truncate UTS_RELEASE for rxrpc version
    https://git.kernel.org/netdev/net/c/020c69c1a793

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


