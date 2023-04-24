Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A36ED418
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjDXSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDXSKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C16EAC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F4E627F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88887C433D2;
        Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682359819;
        bh=5xGyBUYnUwW4OTflQUHEhzZkbxr+LFXlTmTBB1kJWp0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W+r2rsXI0iVlyqHVSGwwl7cwnjlrBMF8NJD+9g4bQcaG2n1wn0IAsvbP+21VbFXhr
         t900yl06XBJrSk7TMjm99lq6/lQxJBDicvuF0e4rRgCTj/rYBntRglDBZA7dHb6tIg
         CkhYCb+ntEMCD4oJ4TMzPgRDWaV/9L3/wxC2Sby0HSjrjg40GjORCUdtTGURBRtle6
         nWRRi2YXVr+/+JKf5+1PNkGJkZeUXFyRqpWzQ20o8ADitoVLa6xkOnc+EGCXWDBtMF
         R0l4KQY6BkoK0xINUU3b/htOs/3EM/pw/05P5mwgdbWSoCeD0nn3yeIkw8Q+7NjWrc
         OTsV4FGN4nIyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61926E21ED9;
        Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnessary comment in
 __may_age_extent_tree
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168235981938.17900.13599013308884334410.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Apr 2023 18:10:19 +0000
References: <20230418060954.67585-1-hanqi@vivo.com>
In-Reply-To: <20230418060954.67585-1-hanqi@vivo.com>
To:     Qi Han <hanqi@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Tue, 18 Apr 2023 14:09:54 +0800 you wrote:
> This comment make no sense and is in the wrong place, so let's
> remove it.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>  fs/f2fs/extent_cache.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnessary comment in __may_age_extent_tree
    https://git.kernel.org/jaegeuk/f2fs/c/8375be2b6414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


