Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20935723356
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjFEWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFEWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E880D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285FD62B85
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 733F3C433EF;
        Mon,  5 Jun 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686005422;
        bh=qMzJbsUxyn7F5AoJSAoGEdgw+NaC+Ioc/FGR+NVtrkY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EUZmJUxX8Su5vqVMf93IK/I1gLIEumS2K8nZeqRcOgSm6w/lBq6+cqJC6J2bV5yTR
         vkJ6BoAsAqw5ZlGSDBtRLbSGjUGTrDFgshcZWMwHCfOvIvA3UaBG7cmiFj8ZFsuWbF
         f3ebtmaHLEiPV6TS7nK5X2ml2OlujWW9fmRL2LFH3ZNqQS1wm1mYW3MWfkf46IUdRk
         lTIiaFlJHwYc4g1A6GtKFZZ7PE/vKhUK+fbZPH4QP3QaW8Sgyfpz36/N8XBaHRLG9H
         3GV0ioD9V/ZXlEZ3Nr97BnTA8QH7k3mWLDWBxnwQjTMpu9kluX0OF2aj1XrXiSxsys
         je5bl+HNWErWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58FC0E8723C;
        Mon,  5 Jun 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/4] drm/i915: use ref_tracker library for tracking
 wakerefs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168600542236.23821.5722558079876009232.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 22:50:22 +0000
References: <20230224-track_gt-v9-0-5b47a33f55d1@intel.com>
In-Reply-To: <20230224-track_gt-v9-0-5b47a33f55d1@intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
        netdev@vger.kernel.org, dvyukov@google.com,
        andi.shyti@linux.intel.com
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Jun 2023 12:21:32 +0200 you wrote:
> Hi Jakub,
> 
> This is reviewed series of ref_tracker patches, ready to merge
> via network tree, rebased on net-next/main.
> i915 patches will be merged later via intel-gfx tree.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> 
> [...]

Here is the summary with links:
  - [v9,1/4] lib/ref_tracker: add unlocked leak print helper
    https://git.kernel.org/netdev/net-next/c/7a113ff63559
  - [v9,2/4] lib/ref_tracker: improve printing stats
    https://git.kernel.org/netdev/net-next/c/b6d7c0eb2dcb
  - [v9,3/4] lib/ref_tracker: add printing to memory buffer
    https://git.kernel.org/netdev/net-next/c/227c6c832303
  - [v9,4/4] lib/ref_tracker: remove warnings in case of allocation failure
    https://git.kernel.org/netdev/net-next/c/acd8f0e5d727

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


