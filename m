Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7606719B67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjFAMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFAMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D691E4C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF4C6115A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75A6BC4339B;
        Thu,  1 Jun 2023 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685620820;
        bh=D5LVIK3I++w9C6mFrD26n1XnwE05g6mZbXYRzyUPNrs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OQeBOR2o6wAw/vcZj0s/hpA1ucoDAkOaCX7RIMgGh1mycAoQ1zAU6tH4xxEyjr9Cz
         U74ISrcNvXDsigo84dLtdsbBXIlRbQRYNHZuIA7jY54Vz+g/T1FBMUWmZYEtVmotFI
         omNt7NQLMnIk2F+pWdQxFqwMR5wkC5BbWRMCj9zg2AnnQm3n8PcIE6gdFZfmB7dyuV
         T5mI89xR7a0qY8D8jKtmVg4NUVFdhY+xgo8chTVmFyfFFtUrPGiDj5ba1Sf9nWV6wa
         yR3siiOet7s8EXot3XSKvb81kYhZ3UMNQ0Z/fSc+r4YqtrWVZ3lEZmbMQwukHzmYyF
         4FWFTEYHF7TEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B04EC395E5;
        Thu,  1 Jun 2023 12:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] splice,
 net: Handle MSG_SPLICE_PAGES in Chelsio-TLS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168562082029.29159.8707546224300597535.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 12:00:20 +0000
References: <20230531110008.642903-1-dhowells@redhat.com>
In-Reply-To: <20230531110008.642903-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, ayush.sawal@chelsio.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, willy@infradead.org, axboe@kernel.dk,
        simon.horman@corigine.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 31 May 2023 12:00:06 +0100 you wrote:
> Here are patches to make Chelsio-TLS handle the MSG_SPLICE_PAGES internal
> sendmsg flag.  MSG_SPLICE_PAGES is an internal hint that tells the protocol
> that it should splice the pages supplied if it can.  Its sendpage
> implementation is then turned into a wrapper around that.
> 
> I've pushed the patches here also:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] chelsio: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/116f7b361ebb
  - [net-next,v2,2/2] chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/26acc982c1c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


