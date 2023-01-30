Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD8681F44
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjA3XDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjA3XDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6ED3B0EE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF2261302
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27A72C433AA;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=umkF9ddrYQfLVnvHs4hapm7fWtMrN53sEfGlRBENlWs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OG8Hu/poBUEyWHtprU2VhELWPuJdYJRclmxs49CSlj/YQZvLie05PO4Y2LTSImOGo
         iAyJ/hGhrmhDusgGiP7ghXVN6g00A4/bLYJCy9tAer93TSmnmMCEDAgtz73k6vl4Mi
         bOPk/jFmiptSdfofSDWEHnrO1t4+bpuY1UZHK1oMhffaCOdIh+jIL2ORu2idZnpgEE
         k6lvi+VcXrIUJSPyI3HiiCtditcXttHV/RcYIVZ9Wf/ZVQ6nP5DtiQO3ORnfvz3lN+
         aEJryQ1CsB45vmkEmRa9BO1YfPQHhk0wPqlkDeC83DUa4MV6wX9uQUvaeXW7f5EIFu
         f/updMwlvaZcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9368E5255C;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneeded f2fs_cp_error() in
 f2fs_create_whiteout()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961795.12751.16077999668439439794.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20230109034734.491518-1-chao@kernel.org>
In-Reply-To: <20230109034734.491518-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Mon,  9 Jan 2023 11:47:34 +0800 you wrote:
> f2fs_rename() has checked CP_ERROR_FLAG, so remove redundant check
> in f2fs_create_whiteout().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unneeded f2fs_cp_error() in f2fs_create_whiteout()
    https://git.kernel.org/jaegeuk/f2fs/c/8abe4be45132

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


