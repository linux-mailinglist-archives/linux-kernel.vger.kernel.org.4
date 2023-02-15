Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF336982CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBOSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBOSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:00:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BCF13DF2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F2A9B82333
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12C0BC4339B;
        Wed, 15 Feb 2023 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676484020;
        bh=j2eRplYbp9PP1g5JU1C4Wj/IK2TR7ql64N9/+y8UEhQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KKhVeoVQF9m3Mre4FKRPIIyXrIqW7pMewu7e0nZTXY8+lkPcgzEl9s81Avmi+1ZP6
         LFF9kFIOV+j+taxrx1ofxINDSNxpCOv/bjBSr4haSy7kLTmyFd7JWtLBJsElHFfpOJ
         l//dLqRWDihCuREco995b5CQwLzR0NfR0bFne0SW1LK0h9rmcrQ3zKTTIzbAFUMj9s
         DQMWBF2ItVqPcMUujvV44H7KonyF43AFlrppQImZWILiLDbJa1jd8Yq2fvY1hDBzP3
         tin79c0TBQpcALJ0gm/9vI0QW+mfXH1tKxHNrL0UsgmB6HhvdkfDZ5ePu4YZWY3lgm
         BGflPMhcV/WBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6C83C41676;
        Wed, 15 Feb 2023 18:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop unnecessary arg for f2fs_ioc_*()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167648401986.12560.9834857293407249431.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 18:00:19 +0000
References: <20230215061701.1433-1-frank.li@vivo.com>
In-Reply-To: <20230215061701.1433-1-frank.li@vivo.com>
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

On Wed, 15 Feb 2023 14:17:01 +0800 you wrote:
> They are not used, let's remove them.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: drop unnecessary arg for f2fs_ioc_*()
    https://git.kernel.org/jaegeuk/f2fs/c/ddf1eca4fc5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


