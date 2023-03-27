Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339A6CA9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjC0QAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjC0QAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64454489
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B50F561368
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FE77C433A0;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=oUUSCDiH2WMg9UB86ydnRFcrguAfJOQY+1/VoFRAloU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NeMVYXZ/FxoXhFDtqN+LHHb7lbyL+S2Veih4DCOl5zTZst3rKH76kafeSe279jp7z
         ulD6Brrphq7Ir6CetYD/B7vdsWwyXS49jeOfPr5BmJ3kKezjM2CbVcJY7driafB/VW
         2sSCpwiwLnAwy4qRfLh4KD5Ug4zMZtb4jIVNmEmluoupr5P5eaXuVkFYab4uV8ufzG
         XL4Lv4yAI4aCCXgttOrR6f1q9ehGXpObwXYQDiGgx9XKieViNxeMQPFO/KdDhl/Qjm
         6TmTfX7M71v13RsFh0df1w1ZBbjKVVrQm5DM3uKTT3MoY9ayDPblf2tCk5xUXJcqnX
         oH3r/UGoPGa+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC7CCE4D02F;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RESEND] f2fs: convert is_extension_exist() to return
 bool type
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993281996.32120.327857245576913303.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:19 +0000
References: <20230319075822.79337-1-frank.li@vivo.com>
In-Reply-To: <20230319075822.79337-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 19 Mar 2023 15:58:22 +0800 you wrote:
> is_extension_exist() only return two values, 0 or 1.
> So there is no need to use int type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> Resend this patch because there is no similar patch to merge in this time.
>  fs/f2fs/namei.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,RESEND] f2fs: convert is_extension_exist() to return bool type
    https://git.kernel.org/jaegeuk/f2fs/c/08d04e0156f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


