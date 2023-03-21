Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE46C3719
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCUQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCUQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FE4EED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7691B61D34
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE07C433D2;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679416818;
        bh=3rDLFVHcU6ma5+cN0vAvs0YCv2Sk5f2f3Irv+23Nd+0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PTyJ+slN6Kya1SR2N5ikXvIMXDRToqPgCBWLSYxyhbj2vGjsoY/Gt2zX+OoIEHnOf
         q1B8o7eyDU3Qawoow+mw0W+j524OCMrvKShRh9hP0BZY9kDOkNVDJdy7iZ0914dl/S
         bIW6AM9fUfd3hTEGVKV7sXfUowwCUqiSE2BUG50HJ78nU+lfMQ7flUsS2ubzMPjr21
         LMaWJ5WeTtI6Z394qoSqOC9Pcwr8dHWN6L2W+6JApm0on7bJBcBtELFAsPIj16jLWd
         vRthd7JAXRgrIb0UVIu5XiDp6KKsgGoPk5kl9Ph/EPZflGsWwFvDoBKtfZOC7piY97
         f9QN5BWSuA5RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B83A5E66C97;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Fix discard bug on zoned block devices
 with 2MiB zone size
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167941681874.25004.16164429117786681993.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:40:18 +0000
References: <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
In-Reply-To: <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
To:     Yonggil Song <yonggil.song@samsung.com>
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

On Mon, 13 Mar 2023 18:48:25 +0900 you wrote:
> When using f2fs on a zoned block device with 2MiB zone size, IO errors
> occurs because f2fs tries to write data to a zone that has not been reset.
> 
> The cause is that f2fs tries to discard multiple zones at once. This is
> caused by a condition in f2fs_clear_prefree_segments that does not check
> for zoned block devices when setting the discard range. This leads to
> invalid reset commands and write pointer mismatches.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: Fix discard bug on zoned block devices with 2MiB zone size
    https://git.kernel.org/jaegeuk/f2fs/c/5108a09b11d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


