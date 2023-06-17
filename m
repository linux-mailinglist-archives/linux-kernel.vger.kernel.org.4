Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B4733F32
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjFQHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFQHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9732688
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 388BA61157
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC63C433C8;
        Sat, 17 Jun 2023 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686987020;
        bh=4tc8p4C5oifZtrUi/uCn7bMp/xiLkoZTzFGT+uM22KU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H806mvH/qnDDKhFKPiWpGHAXo9evX/m8y7uLvvaigbeZBu12Iw5FfxbBUaMd4kSum
         j8PbCxrhNcIqFmijXEIeqGCetcBoFWzUBkiHIm84/i1SDPN8saBOLkvhDH9u5AOMSp
         hm4kHoo2k1MWHZwMFsc+3PkYkRlVnIfJZh4VTu1Fco0NAgF0/aRlafet9JCOY36O9e
         DBHxR86txdeHl6wdGmwYPO8dRtlkrDIeL0yLFnVh8Bndx4XZB1ftE56jq1oTXY2Nsz
         rTOoyRf+dyNQl1L7XDGG9RdulyOdscMy5D4cpvorEQ+CS8eSLUMR8DdzB7AFSdHo8W
         B+GkZSSPAvP2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70673C1614E;
        Sat, 17 Jun 2023 07:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: Remove unused qdisc_l2t()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168698702045.21379.10841788568408584472.git-patchwork-notify@kernel.org>
Date:   Sat, 17 Jun 2023 07:30:20 +0000
References: <20230615124810.34020-1-yuehaibing@huawei.com>
In-Reply-To: <20230615124810.34020-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jun 2023 20:48:10 +0800 you wrote:
> This is unused since switch to psched_l2t_ns().
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/sch_generic.h | 14 --------------
>  1 file changed, 14 deletions(-)

Here is the summary with links:
  - [net-next] net: sched: Remove unused qdisc_l2t()
    https://git.kernel.org/netdev/net-next/c/e16ad981e2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


