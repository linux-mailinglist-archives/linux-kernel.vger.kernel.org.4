Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F05F860A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJHQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJHQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C363C167
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B857E60A49
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 16:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89915C43140;
        Sat,  8 Oct 2022 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665246609;
        bh=DtWmD11NXBVddZY5n7EffCClnSFVrNuM1IpvTVtlI/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d6RJKg4716mGBoP+bYOR8lRzmaVg3pfFI1qVhJFa4ZpKxVp/Vb0L0P2IUBM5tlFIt
         GYlqM4YbMpCLOefUczTS6ORSUFeoAtmkSorkImUi7SC/Hd7bYjrCLYqxGUgGw8WEQW
         NyW/HhFnrY7us1z6Ng5ozSvSRtM5fmRiv1f/KGSwWS26kt2EG+Gr26yI55pPrAtU66
         lfzlVyodyEzMGliJHjcRQaCH6pWpUubQHWj4MpYgtWyJnNrs73g6V0+k4SDOFRzC6d
         jls8XHxPiRDK9d0smc3RXgChDbRokIIFMD0WHFT2nCcCG49HF8MQT7uFrb9IXAr/M3
         oZhnrtqIszpZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F3A5E43EFB;
        Sat,  8 Oct 2022 16:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0GQ+GimB8eTuRDL@kroah.com>
References: <Y0GQ+GimB8eTuRDL@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y0GQ+GimB8eTuRDL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc1
X-PR-Tracked-Commit-Id: 4256e500f61922a3e59c7ecb6a11aab972d41b18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3002b7a31894cfa0e57080f7e0961b5fee788aa3
Message-Id: <166524660942.14582.11161381391303967190.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 16:30:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Oct 2022 17:02:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3002b7a31894cfa0e57080f7e0961b5fee788aa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
