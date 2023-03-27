Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271466CA9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjC0QAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjC0QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77734698
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44F8BB81608
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0719BC4339B;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=mQ6KWLsxV9NormSx/+1aGLy0yqMY0E4Re/2j1dGBNnc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mqwVoAo7jLqQX5r8RxYTCgUELJXI9Uni/abxE6og5FLdlLH8DesMAKHPxrhxjbNWt
         pVxM0Q6MNebwaNxZMX7Jr6XSTBJXy8QiG9imW1HaxMOeRjNEFNWkcSjdZrkoMcOLHz
         Lhr9DF8W3QZYecndjbX4/ew20qw/yTB9klYeo5JJpMeeEgYtRoOqwE32YLDwE9Ob2y
         CGpfcxhnprHdpWgOZXWn9hnX6/JQv+ptmHC4pWrARcpEhMHhfuxw+roYc06wgkfLni
         wjd2O1Ss8fOAZZsrNvOuK32TAdzEbdf8UjdkPlSna4dP4iLkB8Pa/bvSg2qbg0DVGQ
         g0XaqGxRyzxKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB154E2A038;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove else in f2fs_write_cache_pages()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993281989.32120.7782788067831740553.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:19 +0000
References: <20230320173137.64413-1-frank.li@vivo.com>
In-Reply-To: <20230320173137.64413-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 01:31:36 +0800 you wrote:
> As Christoph Hellwig point out:
> 
> 	Please avoid the else by doing the goto in the branch.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/data.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove else in f2fs_write_cache_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/d2afb3f006dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


