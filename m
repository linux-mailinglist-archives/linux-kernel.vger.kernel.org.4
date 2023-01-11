Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603BD6663A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjAKTUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjAKTUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524D17E39
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA49261DD9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06539C433D2;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464818;
        bh=i7Qp59A3TmyXYbXmFvhfzEdfZw5mam2mOwVXokz7Dvw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z88Vj4W1wyLVNVP41scf48p4yDzWqGirMHVH1sXYKIAdIXNnhH9AeSne6plfL6V9E
         2F6YtZgBWCKk2X+29vWarhk8Ek3g+bENea7qK+2nSxIyrrpFDexiXU9Lx2jcU5bG0G
         dsocGlujRfs/0qZBxT9SoxfrJaZRJ0sp5md8GZ821Cgiqx0lfrP4VQtSN7YkgVplcZ
         pdfvLaT2OcGKG/ehJ1moimPmyxwf7SihQ4n/igiNbE+QL6EiH2vSKOSsQIfncFfR44
         8NlOmzlkxHaG3MpJhFVBHvzagsldPZy8y0ciO+GWLqdt6GMfTKLFZNzfq1qAN0WTGS
         FmnjqcOFoJP3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3F6FE4D025;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a f2fs_ prefix to punch_hole() and
 expand_inode_data()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167346481779.5008.8969169400238709620.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 19:20:17 +0000
References: <20221220191212.58042-1-frank.li@vivo.com>
In-Reply-To: <20221220191212.58042-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 21 Dec 2022 03:12:12 +0800 you wrote:
> For example, f2fs_collapse_range(), f2fs_collapse_range(),
> f2fs_insert_range(), the functions used in f2fs_fallocate()
> are all prefixed with f2fs_, so let's keep the name consistent.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: add a f2fs_ prefix to punch_hole() and expand_inode_data()
    https://git.kernel.org/jaegeuk/f2fs/c/1cd7565449de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


