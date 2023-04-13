Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DD6E186A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDMXk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMXkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBEDF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C8A64282
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3324C433A0;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429219;
        bh=y1tsCDiR9PB0QaZqwPHvaqN4LWmaz9Wyb/y9A7Tkf5Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZE0jiYJYP3cQM56F74mfHvqsS8Bkl2etzHgJ+mhyvwgEFuNYXzWCXxabfjm8Up+tu
         amXve31PQc2ZY+SKmEDoaDyRkR+MkD8lqU4+WTNTC6GXiOhUNTn+VPmtpNr+Y1UEaW
         2yeipsDYoiTcpA10S2vkDWsubTSGQK3euLBKDn+6CVG4//QNhRCApbsLmaf/Dy7k2i
         swIRPhPMKGAJ2VXrcu6FdFwJEPP+Hf/WOjFyWXXDN1zBBhp2+ztgODOWDUPzICGTYl
         4OPGgAMJSyqsejovCPxp5PrYhddY16ob788ybkaUKzBNEiAQH7RPcIOYxyaATYqqES
         y9QuQUC7AlEmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0646E52505;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 inc_valid_block_count()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168142921884.31957.17494916129948763212.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 23:40:18 +0000
References: <20230405144536.930370-1-chao@kernel.org>
In-Reply-To: <20230405144536.930370-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, daehojeong@google.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

On Wed,  5 Apr 2023 22:45:36 +0800 you wrote:
> In __replace_atomic_write_block(), we missed to check return value
> of inc_valid_block_count(), for extreme testcase that f2fs image is
> run out of space, it may cause inconsistent status in between SIT
> table and total valid block count.
> 
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check return value of inc_valid_block_count()
    https://git.kernel.org/jaegeuk/f2fs/c/935fc6fa6466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


