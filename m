Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F856E1869
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDMXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDMXkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB410C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA19564293
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E75B2C4339C;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429218;
        bh=FCdRLP1bIR+b34FlLmWhChicvm3dOWNEYQM95/2rJzI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UgoR/eWJp0y4mA7FQrMKBtN466m9+67oim9i99p58jj1ykz6+P2p0KBASkr8QKhjp
         RWhHbBl4pHY0/B4QgYdIXrzioRPffnVBLBEQKBNBilqEOSr2lV1p/cSsiKaR5Ts9RH
         1xVlBHHrWZzJQ+sCNznIJ46vHW9narnU0oLw2Rd69qqbwr9lINqKpjzxIs6jiZMeGV
         Fd2QkAb4Ob1TCzyTKeUCtMTl6hdiETxgCXQdbPbkTe7BL26HvGMO++madyBXsAzROm
         4NBWanZrOmK5EkionVi86Gfofn8n3hPPVlJcbkqL761slnrQFlJQYjjH1wn5w0LSJd
         E+m+Y/yrU/ouw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEF9BE4F0B3;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove batched_trim_sections node
 description
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168142921877.31957.15174753111449147359.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 23:40:18 +0000
References: <20230404143832.18234-1-frank.li@vivo.com>
In-Reply-To: <20230404143832.18234-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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

On Tue,  4 Apr 2023 22:38:31 +0800 you wrote:
> It's deprecated since commit 377224c47118 ("f2fs: don't split checkpoint
> in fstrim").
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove batched_trim_sections node description
    https://git.kernel.org/jaegeuk/f2fs/c/abae448626a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


