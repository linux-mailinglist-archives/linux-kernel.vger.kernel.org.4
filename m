Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC468B48C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBFDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFDkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FFF166E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:40:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08AD7B80D26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C2C6C433A0;
        Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675654819;
        bh=KwKRt75uEK2f/FDXaE2lng5C8xdbuN8ECgK7NOXQUOc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qSMztfuAeI+B2rqa7hb0TGmrhdcNL3wcvfsVpy3RaeSX/zI4toNNttBRM5PitOo5N
         vmldF1Vll56wtoik6SFtJpcki3PUdlWjOH5aZ1GbEny2Vjiuf/KxeVJ3iFggMiVSwy
         kfv497XvhWcyRQXgDFePo11rnpWlhIbJD2VhqBtOgQ/69zeEbxVx7c0r7dIBQhH/Kp
         KpktHHcpUG/y8Dkbv7Sz+K93h0s14+q/Qtcf2jpiWXsfyvOrDYIv5hsozAhVKlWErT
         dnN23gQL09rPxLKC8jFj2khaYtZke9GUJ8x1hQhokma+40Mu+jPU6gGIfnmwttHljc
         wAR2ZtHqBn8Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7246EE55F02;
        Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2 v3] f2fs: fix wrong calculation of block age
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167565481946.5323.16929437612897381301.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Feb 2023 03:40:19 +0000
References: <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
In-Reply-To: <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
To:     qixiaoyu1 <qxy65535@gmail.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, xiongping1@xiaomi.com,
        qixiaoyu1@xiaomi.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Feb 2023 16:20:27 +0800 you wrote:
> Currently we wrongly calculate the new block age to
> old * LAST_AGE_WEIGHT / 100.
> 
> Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
>                 + old * LAST_AGE_WEIGHT / 100.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2,v3] f2fs: fix wrong calculation of block age
    https://git.kernel.org/jaegeuk/f2fs/c/b03a41a495df
  - [f2fs-dev,2/2,v3] f2fs: add sysfs nodes to set last_age_weight
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


