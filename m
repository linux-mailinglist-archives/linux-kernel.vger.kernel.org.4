Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326D6F0C75
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbjD0TUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbjD0TUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C584EFE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B0A63F51
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4974C4339B;
        Thu, 27 Apr 2023 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623206;
        bh=sS4bUyfgg8PGDGHCj1u7YHlEQYWpHacmL+PeSq65mvw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=URUzk60G6uDx3evCVXLK1A8jyxpi946MWQPgYm66vwFBAyCdu0VprSeab5RgQs8yE
         ujXKIUZt6Cs9hMj83v3GrY0nYmQGyVfX9to1l2H8pGFhGV+Llpht1UuLIFAEPxWrHs
         /ayadE0NuOrj5zZ7Dk6ocJnjLp8n+neYRdc7JMekRmBg6A5GgzhhF8tdUXQI83kAkw
         yXYnIb44vq57yU6ApNYDEPUoYt0iYZZsAkXUPcwDwQmOFCEZMIvb3miUrgjl5mzGhs
         Sjd0tXXwS1p17pNswbch09JrCdwJqBXhuwZiBzH7YApoqHcm/xAE0g5VZHr1zNMUUS
         tTp4pt/bfb5IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1A55E5FFC8;
        Thu, 27 Apr 2023 19:20:06 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEqEqsEJZZEQSzLl@kroah.com>
References: <ZEqEqsEJZZEQSzLl@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZEqEqsEJZZEQSzLl@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc1
X-PR-Tracked-Commit-Id: 3fac2397f562eb669ddc2f45867a253f3fc26184
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97b2ff294381d05e59294a931c4db55276470cb5
Message-Id: <168262320665.21394.7244420994513669206.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:20:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97b2ff294381d05e59294a931c4db55276470cb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
