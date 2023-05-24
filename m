Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0870EC77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjEXEU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXEUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACE119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38E98638A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DA7AC433EF;
        Wed, 24 May 2023 04:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684902019;
        bh=Kfj7uQjDJMXFM0cm9fLG2FGT/MmRT8alZ3jos2HL3GM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HQs/iIvQ7Nkck3O4YJvE072GCSUylXaKcu1ve9sXuGhukKB48U4YpwDvvA5ZaLg/9
         yItTfz3q3T6qcD9aWIa9AgDtlQfGN5ZD+vkC4H7q3KzLWrPdP87YA9nfmjN1TVAhmy
         HjXUth4v5/UO/Id87OfNugJrrRTDrvWXJac/EotU3ve+eW7TDIMKSLyvROasLPYHnw
         EkNLAd8XEaTGlUgx/WMJmDYMFWcPuuE1YJlb2C8pIbsDCwwPCy/kdoFUICwxVx93mn
         NkUaRcb/NY4FNzx7gazxV6fMxhBrdXnXEWlFBcVkuJFP3E47igVmVeg8N1jjVXusXg
         k2U9qw3mpFQwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CD9DE21ECF;
        Wed, 24 May 2023 04:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168490201944.21222.1273870966646702952.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 04:20:19 +0000
References: <20230522153020.32422-1-ptyadav@amazon.de>
In-Reply-To: <20230522153020.32422-1-ptyadav@amazon.de>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kuniyu@amazon.com, willemb@google.com,
        nmanthey@amazon.de, netdev@vger.kernel.org,
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 May 2023 17:30:20 +0200 you wrote:
> Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with
> TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
> zerocopy skbs. But it ended up adding a leak of its own. When
> skb_orphan_frags_rx() fails, the function just returns, leaking the skb
> it just cloned. Free it before returning.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> [...]

Here is the summary with links:
  - [net] net: fix skb leak in __skb_tstamp_tx()
    https://git.kernel.org/netdev/net/c/8a02fb71d719

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


