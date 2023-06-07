Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC62725D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbjFGLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjFGLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F410DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C61963DE1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF299C433A1;
        Wed,  7 Jun 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686137421;
        bh=kcAHmsKKWmG2M/y7rLA6lmHAqlrpzPdULjKbfUxuns8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e+Xkbs4l/BZFprz34Dsz3i13CKIQ7QbfnJRPAODL755VFNg8Sf6xl1TRgSlig2e9G
         TY6szoVAbnFgDBv3WJ+6dGkaZDz26ygzwbdnMGOu+DIORY7XcAXA8ToLbJPBUVmDUD
         QRcfk8/zLtdRcHCYcygxV0hhKPRXc/l8yLodmogYKppYYc5cw83VE1lzct3UpTRCOn
         XdLJYPxFL6ikbUyDVwAwwsWTeEd55DJrEK1xkl9keC4Iquayc9ZkN39Hc+qMdoRuqP
         tHwcVECI0jhHtamF6VGwEIg4dSa2NJ1z3X7c2gbBoktjsHlQecLPpAzEKi0vEDbi/A
         d9/OTpt7TwtxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC904E29F39;
        Wed,  7 Jun 2023 11:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: qca8k: remove unnecessary (void*) conversions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168613742183.29815.12843311749893162234.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 11:30:21 +0000
References: <20230606122129.141815-1-hi@atinb.me>
In-Reply-To: <20230606122129.141815-1-hi@atinb.me>
To:     Atin Bainada <hi@atinb.me>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Tue, 06 Jun 2023 12:23:08 +0000 you wrote:
> Pointer variables of (void*) type do not require type cast.
> 
> Signed-off-by: Atin Bainada <hi@atinb.me>
> ---
>  drivers/net/dsa/qca/ar9331.c       | 16 ++++++++--------
>  drivers/net/dsa/qca/qca8k-8xxx.c   |  2 +-
>  drivers/net/dsa/qca/qca8k-common.c |  6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - net: dsa: qca8k: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/92db9e2e0498

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


