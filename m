Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A7681F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjA3XG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjA3XGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:06:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3212878
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A268B8172B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21869C433A7;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=oFJJ4H2f4g+K6au8aw2K+jW0tLl9r0XaxoY4/Pwg1og=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A+LIGrp2YMdNDCBkgNcA8ltxp12rIFUSTeS1aUB7+h7fIrejEXoKmhfrQweqTyR4A
         XintNA+Nh5fXrbZa7NkPlNPcCitHTIAJYqroe/Auin2tvikpeJ4WrAHESVZaIMYNCd
         BLk0x7s7i9h4yNofYiP9ntqQqCeVRjlAv+Rnbv6lJhYmnidQSABfbcM5mN/SFYPG2B
         3sfqnQInFc5z5xRIrNBvlBDkrm12buTHua+vopsbG/DD4RXBbylDLfGPgu4E0CcIJt
         AgDZhF/jiA3tN356yOjBRXY9PyxInG79ULpTZVvAKqC+Y1JBihk6Ab+RACJTvr0CU8
         cM808e685itzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2A46E5255D;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to check warm_data_age_threshold
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961792.12751.12417544655020627742.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20230117132442.77645-1-frank.li@vivo.com>
In-Reply-To: <20230117132442.77645-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 17 Jan 2023 21:24:42 +0800 you wrote:
> hot_data_age_threshold is a non-zero positive number, and
> condition 2 includes condition 1, so there is no need to
> additionally judge whether t is 0. And let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to check warm_data_age_threshold
    https://git.kernel.org/jaegeuk/f2fs/c/3d41b70411d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


