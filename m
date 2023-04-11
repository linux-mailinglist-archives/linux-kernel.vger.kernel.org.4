Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876386DE1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjDKRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDKRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716E5BAF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EDC1629A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0163BC433D2;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232420;
        bh=AgbUHXxAqtch2A8ZK9s2UlYpUA1Fw453yyGXCQGJqk8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MwmG6PpNvMwo/cgJhd7Pkd0lP4bYljwNmD5rtAWWCQGYHctG4JZMBBHTy9Kruy/jY
         WlhkP5OzLkdc0IIl3JdUWYKfCZJ2loIiovV6N1c7Kz9JVyW7D1cUr6CTcNVGhd+ZyR
         N2qc/UQtVtxH3NDlENIdS6tklvy3pksMXtxRai0mCjd/rAW7VXYEaxuAvn3SSTvGro
         rUFuf8AgZuYrC2DbKvi84A56ImqQGcTNbLnFKhD8iQpd3hZmcXF1I2YDFOoL0HunX2
         0jp9YYlTw6uLl/m2MLxp9fQHvuo18xU1YX1D4MWOl2Ews91OQy9mcQS/CuWu1Ft73c
         HvHRUezrENgJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D71E3E52446;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use common implementation of file type
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241987.4928.2853902355953919510.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230404032844.3596879-1-o451686892@gmail.com>
In-Reply-To: <20230404032844.3596879-1-o451686892@gmail.com>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

On Tue,  4 Apr 2023 11:28:44 +0800 you wrote:
> Use common implementation of file type conversion helpers.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  fs/f2fs/dir.c           | 39 +++------------------------------------
>  fs/f2fs/f2fs.h          |  1 -
>  fs/f2fs/inline.c        |  2 +-
>  include/linux/f2fs_fs.h | 15 ---------------
>  4 files changed, 4 insertions(+), 53 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use common implementation of file type
    https://git.kernel.org/jaegeuk/f2fs/c/0c9f4521958f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


