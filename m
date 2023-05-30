Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF17171DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjE3Xkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjE3Xke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE412B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C286354A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60E50C433B4;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=JUb5V6kUM0gHtoz2x7OrWhtRLti1YDyfG3Z2xfxVIT8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XUhL7fxY7nS/+bDHkU9GjXgiFAamwjgoOKf1Ztm8Miis7BJ/Zk0rQbIbrkjPXkTi+
         imSx0NIp2uF+Y0vrir4JYiW0eZmipNzRMm9EgaAQSUgecwqnC1i2UpkiE61Jt0WRac
         Q4QBWfV9bUmbHlGISZL9+kNj7hwbefXMsYl0pOrFuWg0UulpsN1ETzaDqIdlaVAVhY
         pBtIWJc0kjkd834wgRZQ96H2l7h2J8L4tnli1dX6ybAGR7b2fPwQMsdaLJY/X0A74e
         ULC7B9gstPjhihIcAaVC+l+lMcoOyETKJyyQaRdw9CGpAnK4oFMlLYxno5F1XBb6/O
         PP4pzmBuGVkag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 407E7E4D022;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to set noatime and immutable flag
 for quota file
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002425.8773.15836981117739675166.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230527001539.3608665-1-chao@kernel.org>
In-Reply-To: <20230527001539.3608665-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sat, 27 May 2023 08:15:39 +0800 you wrote:
> We should set noatime bit for quota files, since no one cares about
> atime of quota file, and we should set immutalbe bit as well, due to
> nobody should write to the file through exported interfaces.
> 
> Meanwhile this patch use inode_lock to avoid race condition during
> inode->i_flags, f2fs_inode->i_flags update.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix to set noatime and immutable flag for quota file
    https://git.kernel.org/jaegeuk/f2fs/c/cd2a3af38096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


