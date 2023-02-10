Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9185692969
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjBJVkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBJVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB560D4D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706A961E97
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3EA8C433D2;
        Fri, 10 Feb 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676065217;
        bh=NObY+KuoP7Q6hH83bq+sCb02XrbExn08QoALMeMctbY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RV0I4RGZk3IyH03FS/mAq9oujHCIoG98Anxz8lZEglH2zWbo4Bt9HA97C2i7AI8zh
         0xLEepV2SrrCcG1rc+Ef3XqwJOoEsKJFlp0MVW5q05fd4zM2zIOinu1Co6ljj7CfaV
         M3PVytEQC9sbU1PI92wbQX8HpOLho1JGE2DxGflSFfrOiGS33+6CWuUJC5pGKVlCs3
         xzzAsXZ8W61g6PEtAJX1R6qCVVBvhKJe34ixhvUqkBzrMD/dRnzAf1WDz4VB4KyHMY
         8BwqZfSgVEHPVf7+ANxIJP7v2KSi3KA0x8+HVF0SN0snEVApqtuijY68TzbdJem66B
         0WpCsLtAmnJ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB25E55F00;
        Fri, 10 Feb 2023 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: make kobj_type structures constant
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167606521769.8706.16031363509228076615.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Feb 2023 21:40:17 +0000
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
In-Reply-To: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@ci.codeaurora.org
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

On Thu, 09 Feb 2023 03:20:10 +0000 you wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: make kobj_type structures constant
    https://git.kernel.org/jaegeuk/f2fs/c/663bb23cc1ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


