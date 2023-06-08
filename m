Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684C72761C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjFHEa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHEaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94215213F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBC864751
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 772B8C4339B;
        Thu,  8 Jun 2023 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686198620;
        bh=+DMYfaZqNxNT6uJpx1QlJAqBKJO+dRWsxXEUzGF1Hck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o7g6+/HOCWZEI6pS1m5DplWLh7eFqMl7gecnpsf5lQbgHr+Ue4sr/Js6DdeuAdnO9
         1wJ01aaSw8Sr7O3Ut/vMtD95ZY9QDf/lwTy8B45mGsFex1MSvdkQHJA1gTor3YjxLQ
         d4nUxYFJ+i+RkvignVwLBdNoMs3nCnBFbTi1/XtU9rk6Tduyn/9TvVKJGSjx4VHl+t
         20NNzXWvFhwOFBGAUVskjC8UWZJu3z3UoAD7ewMIj6PzWbrNgFDrLGy1zIt5+Rhg+N
         QY3deRa5yhMgC5loOZwhBEDkZyoUeyiBboQlSl6wya4OvL1Cws3BqnQFmVlQAYK6Zy
         nuMUGqw8yTZCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D4BE87232;
        Thu,  8 Jun 2023 04:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] lib: cpu_rmap: Fix potential use-after-free in
 irq_cpu_rmap_release()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168619862035.10114.4240315179189704298.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 04:30:20 +0000
References: <ZHo0vwquhOy3FaXc@decadent.org.uk>
In-Reply-To: <ZHo0vwquhOy3FaXc@decadent.org.uk>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     netdev@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, elic@nvidia.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 2 Jun 2023 20:28:15 +0200 you wrote:
> irq_cpu_rmap_release() calls cpu_rmap_put(), which may free the rmap.
> So we need to clear the pointer to our glue structure in rmap before
> doing that, not after.
> 
> Fixes: 4e0473f1060a ("lib: cpu_rmap: Avoid use after free on rmap->obj ...")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> 
> [...]

Here is the summary with links:
  - [net] lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()
    https://git.kernel.org/netdev/net/c/7c5d4801ecf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


