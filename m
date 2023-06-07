Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC872675E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFGRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFGRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2E2111
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F04C2641FB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A97C4339B;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159025;
        bh=Iu0WdkrFGv1GjZ2atrz9cBImnG3oKrStjhc+uU+EgpI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oq0QouLgg4ddzK8u3+yf703bLYcZNkZbV9Tb9+uzbMtT+yBG2FeVSw/Rzb89/yMaK
         G9IfYZOwaa8n2qAlZQOtVwh+kUo6wnY2zCtO3pk1pDwvtvgvDBChhrzqMM9yBR0HgS
         XNjr1VVwWCV1k77BPu10o/7L3KbXhg4cr22or+10RhpR3zisdhgiHtsuAbim/1rrxI
         sqeIuVjqCDsgjW85CjY4t4R6xnS9UT63ec1Mw0sO6V3Fb1ZtKUUg8VS44GkDpXTp3W
         YsN/SDUK/i9BmdVG8bRDeAzIKdWTONpVBT/R+IiBF9YclmtyP36MI+fNx7gVjCmyYL
         9FYrMnrTkeNeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FA3DE4F13A;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: flag as supporting buffered async reads
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168615902518.7521.17734763826963254315.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:25 +0000
References: <20230531125918.55609-1-frank.li@vivo.com>
In-Reply-To: <20230531125918.55609-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, luhongfei@vivo.com
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 31 May 2023 20:59:18 +0800 you wrote:
> After enabling this feature, the read performance has been greatly
> improved:
> 
>     167M/s -> 234M/s, Increase ratio by 40%
> 
> Test w/:
>     ./fio --name=onessd --filename=/data/test/local/io_uring_test
>     --size=256M --rw=randread --bs=4k --direct=0 --overwrite=0
>     --numjobs=1 --iodepth=1 --time_based=0 --runtime=10
>     --ioengine=io_uring --registerfiles --fixedbufs
>     --gtod_reduce=1 --group_reporting --sqthread_poll=1
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: flag as supporting buffered async reads
    https://git.kernel.org/jaegeuk/f2fs/c/fdb43e12e0c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


