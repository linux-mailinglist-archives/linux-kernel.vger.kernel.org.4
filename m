Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7462FEAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKRUVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiKRUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4094FF9B;
        Fri, 18 Nov 2022 12:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07C162766;
        Fri, 18 Nov 2022 20:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FBD3C43470;
        Fri, 18 Nov 2022 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802865;
        bh=DWsLD693n2wIbo21lAMAjKLSUP38xOhJOadCauauLbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XHdGlGKtGYjFolVERlzAfWHDRUpGrId8RzgnpAqIPceiWMALzf6PTt0GMYRO61ekQ
         XWuUOEfgsQPUUVXxlpis4H9gSp0RcMVDWDU10yqtUN8EjpXS7bfCpN8sY79d128UBg
         p2Yuz9LiW3ERR5i3s20J6exLjTbLVRKe4nA9T+1GnwRtMctSNFo9oazClCZzPLgL1L
         Kg2yFSSlAI79dsK2FKkMUWeJjpUgJIV4i3uyevuHTrV73NUY/RiTrOi4yLxa3jN4Q3
         EloL9JzP4j2Uq3nCGWPCOzUiiAbN27Nx3CDEVisgboNpDQ3lDnPZso1aFgNFeTdxmd
         MSON0QJip9bqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1F7AC395F3;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3fJy1m1WHFAO05t@kroah.com>
References: <Y3fJy1m1WHFAO05t@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3fJy1m1WHFAO05t@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc6
X-PR-Tracked-Commit-Id: 3ec17cb325ac731c2211e13f7eaa4b812694e218
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09389357e9667be17699b1889134fb7524dc31ba
Message-Id: <166880286498.9331.16951401045690432121.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:21:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 19:07:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09389357e9667be17699b1889134fb7524dc31ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
