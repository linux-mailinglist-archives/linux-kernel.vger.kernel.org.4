Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FEA6D5062
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjDCSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjDCSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247F2703
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71861625B5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF2A0C4339B;
        Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546618;
        bh=3DvCucPxUeD1Jihv3ZNtq1tc5RsK0vh2rCux0YE1IFY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rteC1mXhVvEryy5rV5kcMzThKMLxZ5HH33G3TO5GYA/vnq+cqHfaEQahRF63Ga1vo
         7z8mMH+xBbBZokNVoRvJx2E4fB0JEsOHBCQWKFIs+6idpOgu/yyi2idfEhhOlsle77
         1dpUPqBM21vlHR2Qlknn0CC4EvpI1D40cAF9PC47EinYUhYqX7kiv3GmMUAd3IvU5o
         3EZS3rLvQsk2x84iUNS7N7gdQ1ir6MR38ozzWbr7Gfkdqj0+UxtFLQDKftxwv0YkoM
         MvXhz8CxD5EOV6cNnSsOixUxem6GubLytlnrvNvH4Icb4QcRNfbcTIG9GKMZ3sA+7i
         muLy/GvOqUFJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D3BEE5EA88;
        Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix align check for npo2
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168054661863.14597.5981880840616760856.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Apr 2023 18:30:18 +0000
References: <20230402031259.286-1-yohan.joung@sk.com>
In-Reply-To: <20230402031259.286-1-yohan.joung@sk.com>
To:     Yohan Joung <jyh429@gmail.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  2 Apr 2023 12:12:59 +0900 you wrote:
> From: Yohan Joung <jyh429@gmail.com>
> 
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/segment.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix align check for npo2
    https://git.kernel.org/jaegeuk/f2fs/c/2aeb9c3b9a3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


