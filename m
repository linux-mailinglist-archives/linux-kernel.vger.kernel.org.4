Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF0681F47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjA3XDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjA3XDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4D303ED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:02:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41333B81731
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590B1C43445;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=VQfPTgOSrENSs6GXZMHzN6Pub/gJTtD/bPFw5A74qKg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ccp/gDfbo3m+Z0A2407sCUnbNnoziYMPlai7HPaO4tnbborNjbknIIeNDScwbsLHK
         KvmNn/n7ehALHEBacUy/+fFKugprp9wzbDU4f7AM7VgIp8Hnn5PZAVmizCh8xzirrR
         Mj7JP2X+Qsw9hWzpdjz6DkxvCKEp1zO2X9ioHuRnqk1ce9wC6E0dDflHdocph2RyzZ
         AFNWkMZ06r2wmQrJb8ubgoJDOs8Dp9etwJ0cr/yhQLlhLE0/2rmPXv6ERi5p1t3l8m
         Hu/PYIMGpYBT1CgrP+aAYqw+C5lI3SlYnqGKzxUToWX9uoxk+Hacmn8sn/UkprsgxO
         DXFIfnCONji+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 111D0E52560;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to show discard_unit mount opt
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961806.12751.12383846430084360473.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:18 +0000
References: <20230116141228.43239-1-frank.li@vivo.com>
In-Reply-To: <20230116141228.43239-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 16 Jan 2023 22:12:28 +0800 you wrote:
> Convert to show discard_unit only when has DISCARD opt.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to show discard_unit mount opt
    https://git.kernel.org/jaegeuk/f2fs/c/d6a19f963267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


