Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E570779D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjERBua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjERBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5B2D76
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429F964C3A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E403C433A0;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=WWMJVyyhTnwh2cfx/KpW0I+0aNVVIvg8+5ecK0txWCI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bFsZvK8I24yGU9vojBHCYURsGtkipDQWFDkBht4dgCIdnwcsFMmuooMlR0Ahd4yLw
         tqQI4reXI1igz8Ya9+PqfjPX6PIwg19KUlgZ/RzoxnJa1HLd1jYGccOcVNijugQ77u
         t5D6bkfjtBew6LY3Tx/2gpUL+nHj/s5tdl1NSP7Bl0pCMH8G1/3EVG/l6YXfcWOSWf
         cUAYAdPYaTv0lCRaoq84msZo82Gr4y9wZjT3JFdSSGQ/9xfBOa4Edav7WW5ciUTjjb
         ZoVpHc3hx+y4UU1TxQ1zl0K/oDRECfwLyTMnXqVDi8EjeYTUafSDmPuVgNSy0WS01c
         BM/8JOAv3Jj/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63AB3E21EEC;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set noatime and immutable flag for
 quota file
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462140.19511.17183994837001574389.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230516152346.190199-1-chao@kernel.org>
In-Reply-To: <20230516152346.190199-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 May 2023 23:23:46 +0800 you wrote:
> We should set noatime bit for quota files, since no one cares about
> atime of quota file, and we should set immutalbe bit as well, due to
> nobody should write to the file through exported interfaces.
> 
> Meanwhile this patch use inode_lock to avoid race condition during
> inode->i_flags, f2fs_inode->i_flags update.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to set noatime and immutable flag for quota file
    https://git.kernel.org/jaegeuk/f2fs/c/3c125710454d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


