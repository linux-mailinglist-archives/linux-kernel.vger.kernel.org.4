Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00C65C6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbjACSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjACSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247BDF32
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFEACB8107E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CA5BC433F0;
        Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672771816;
        bh=oxUs1mk9fjhojX+d/cpiJWecqbmfx6WhG1uIbFJCakc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pAd/sfDIPfSoIX/zNIdDAxnetiqMTfvN7bLxf/AP0kJSc29XdkVx3VGmC1FFOo12s
         NcUdJ3LG5ruKo5es3Rz4GgDzKUqqlfufinKDRO5BFCjcq2jag0nhNwAFpnmVkKrA5/
         DkJLSyDMfxA1fF8GLy+Oruv3HLvwq+DZyFe/DGbD6ppKaN0xNPK5SO0Fn5rXsmsV0U
         617zHeNgdkvBhfk1D96D/Hab1LkgZu0Xp6FnYtvrBiosY4W1m+USzUzusI2n//gupa
         STbb/6T/8FZpZFFOvT9zJvqzrvbPH4TTBiat4UnJhKGeotgA/MKAFd/DTmF3IlPuF8
         Dj4UderVEztHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EE83C395DF;
        Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/3] fix per-block age-based extent_cache
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167277181645.18849.7061029698605018840.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 18:50:16 +0000
References: <20221217004659.2092427-1-jaegeuk@kernel.org>
In-Reply-To: <20221217004659.2092427-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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

On Fri, 16 Dec 2022 16:46:56 -0800 you wrote:
> Clean up and one bug fix.
> 
> Jaegeuk Kim (3):
>   f2fs: initialize extent_cache parameter
>   f2fs: don't mix to use union values in extent_info
>   f2fs: should use a temp extent_info for lookup
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: initialize extent_cache parameter
    https://git.kernel.org/jaegeux/f2fs/c/fe59109ae5c0
  - [f2fs-dev,2/3] f2fs: don't mix to use union values in extent_info
    https://git.kernel.org/jaegeux/f2fs/c/ed2724765e58
  - [f2fs-dev,3/3] f2fs: should use a temp extent_info for lookup
    https://git.kernel.org/jaegeux/f2fs/c/22a341b43036

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


