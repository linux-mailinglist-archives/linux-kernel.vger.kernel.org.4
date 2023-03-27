Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4E6CA9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC0QAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjC0QAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09648449A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D536136A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9F7C433AA;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=EWnaGYutZzwhc9eSNWffPnXSuPnCX8A2/5em0/333p0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cMXFdG7JF2d4yzT7u+6ESr5W/ApuoFKbWmOSkLfPTf3UIl/G/JbVtaJR7H0HeOWRq
         gVsUOLAZmhg4E9USWbQNY/jil3g9qK/1oymYpg4KmBSxk/Z+NwBzzFvtbBsCwR3SDa
         JnppFOe3BSncBylcV6zS1VZ+1bDCDHfDRlms59cozM+xiinXmC6V52wn5beJ+5FfGf
         NMNv7iGDaHNz6XEMxw1ojh5yXI4bXwccppOCESbOFtn2/NJQkKtHxgyQcl6QFdT5qc
         hfq4EodGWhqwFnYgzDgQ6zLnD5z0iRvImipuIEtp12EQGQ2qQYnV6Avhgp99HwizWO
         vTMoHupMQK0Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DC2DC41612;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add compression feature check for all
 compress mount opt
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993282005.32120.8336365155332672616.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:20 +0000
References: <20230319075130.24962-1-frank.li@vivo.com>
In-Reply-To: <20230319075130.24962-1-frank.li@vivo.com>
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

On Sun, 19 Mar 2023 15:51:30 +0800 you wrote:
> Opt_compress_chksum, Opt_compress_mode and Opt_compress_cache
> lack the necessary check to see if the image supports compression,
> let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -drop f2fs_mount_opt_need_skip()
>  fs/f2fs/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: add compression feature check for all compress mount opt
    https://git.kernel.org/jaegeuk/f2fs/c/2f3d837dbaa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


