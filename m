Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480868E0B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBGTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBGTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:00:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0938E8D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7CD6ECE1E7E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0A3FC4339C;
        Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675796417;
        bh=tc4dtCKdgQt+/RAfVXhthTde0FWMM+uyaqVv++pKjXI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z0tjfG+UsSF3NSOUUhryJz/D9ipM7Ey/62L3N+6SSpr7ZPHaNV14CtCpbHVaYFdOo
         EGmt+mvquUMBlN4XDDh89v/kTouCvLSPOlnzByNQZOnphkem7yTHjYAL5++/xXQ6uJ
         q8DA+RI1uNs0SFHXOAWOmnavN7HCHMg9XElZzp0NzZ0GOqHuUFP0SDp2M8HGSTfD9m
         MI/j9CTb9ASAtiDiiYMuFvYSkJ2THPw34OVglJRd3UyoPTCd9EyiiMHknLVa9VOIAZ
         ZXhJjvhheetVx6k2o+TiL7RUywXRvP+Ci5Nz3f7Jw99jd5CaijigkB1g+FdliUyzbc
         MJRaBdcI6ZArQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB499E55F09;
        Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typos in comments
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167579641776.24576.16012752036026562631.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Feb 2023 19:00:17 +0000
References: <20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7>
In-Reply-To: <20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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

On Mon, 06 Feb 2023 20:56:00 +0900 you wrote:
> This patch is to fix typos in f2fs files.
> 
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
> ---
>  fs/f2fs/checkpoint.c   | 4 ++--
>  fs/f2fs/compress.c     | 2 +-
>  fs/f2fs/data.c         | 8 ++++----
>  fs/f2fs/extent_cache.c | 4 ++--
>  fs/f2fs/file.c         | 6 +++---
>  fs/f2fs/namei.c        | 2 +-
>  fs/f2fs/segment.c      | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix typos in comments
    https://git.kernel.org/jaegeuk/f2fs/c/146949defda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


