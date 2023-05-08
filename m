Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735F6F9E71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEHD4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEHD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CC5FC6;
        Sun,  7 May 2023 20:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC59161E4E;
        Mon,  8 May 2023 03:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4EF0C4339C;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683518162;
        bh=/oCN6Snro+5jKdEaSS2H/1Stk2he2z97oOjDuxIMUgc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GhJrpVYlr7iUIGEy5SEwSY1iBsiX51a36ZQfT7K2T98jvLtFSggiz9cNjj9fgqXzD
         2sWCfb5rr6ofL4Jg3VD+mxKR4P4FEf+Nm3I1QzRbDyckaq0Vf1IMOz/s0vDvrNRER3
         kSEXDH9zfbJ34VtBPYeo2bwv3ONT6fej6Lmr2IilL2mPO9b+ed9RjH0j7szSVaW/zT
         dFqChcEQsw+2KCEmZHwu7HGYAxVSMjdcNnSNwRObSucIoZiUEup1G8HjW+WjiL41Rw
         KExaBxII4/unfGroboQMg1RoN9xGa2thAwldXeASRIwIO/lsm5Atd41SChbXIErT6e
         esCKThzm1AL7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8542E26D26;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] media: platform: cros-ec: Add aurash to the match table
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168351816181.5651.18369881388504503057.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 03:56:01 +0000
References: <20230223054138.267849-1-zoey_wu@wistron.corp-partner.google.com>
In-Reply-To: <20230223054138.267849-1-zoey_wu@wistron.corp-partner.google.com>
To:     Zoey Wu <zoey_wu@wistron.corp-partner.google.com>
Cc:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, scott_chao@wistron.corp-partner.google.com,
        ajye_huang@compal.corp-partner.google.com,
        hellojacky0226@hotmail.com, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-next)
by Mauro Carvalho Chehab <mchehab@kernel.org>:

On Thu, 23 Feb 2023 13:41:38 +0800 you wrote:
> The Google aurash device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
> 
> Signed-off-by: Zoey Wu <zoey_wu@wistron.corp-partner.google.com>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - media: platform: cros-ec: Add aurash to the match table
    https://git.kernel.org/chrome-platform/c/46ff24efe04a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


