Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F326B829E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCMUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCMUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:20:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4D30184
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6D2CCE123E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C9A4C4339B;
        Mon, 13 Mar 2023 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678738818;
        bh=Y4wPcrymXNrQrkkYvhAdqewMm31tr/Sxwu2eRCOWOo8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=akkoJfuD5BzfmGhKKC0eNqDxtfRKqR/mbs3VRmPsbzG/JP4rpOiqUylUnoA0bEEBd
         H9rEj51s9oIsp2yseeAWhOvZH0hUMlQWpkHD0gGO0z05EF6x4HeYDmjIs1LZkB3c7W
         Y/cwcLiAADBF6VW2XShs76T2rzr5uS4cdEa+w4ICcEIaRWFCxURsnrn0T6NfEvTT/1
         DsMWocc+nxoMLnG0GAyN4LPxcTe84f/YxRh258aR6q2hFeXokJKm9Uva/zm5tDEKAr
         eh2tIJtgAgay79BHzIM1P6wGBT53zX/V6OrXwfhS+k9oljP7GftolThJN8tmkAxwfX
         hdn4fSZcJ6cpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 301A5E66CB9;
        Mon, 13 Mar 2023 20:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle dqget error in
 f2fs_transfer_project_quota()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167873881819.1608.4579777650655781388.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Mar 2023 20:20:18 +0000
References: <20230221144550.46557-1-frank.li@vivo.com>
In-Reply-To: <20230221144550.46557-1-frank.li@vivo.com>
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

On Tue, 21 Feb 2023 22:45:50 +0800 you wrote:
> We should set the error code when dqget() failed.
> 
> Fixes: 2c1d03056991 ("f2fs: support F2FS_IOC_FS{GET,SET}XATTR")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: handle dqget error in f2fs_transfer_project_quota()
    https://git.kernel.org/jaegeuk/f2fs/c/03ae2bf52a75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


