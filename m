Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69B6DBCC9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDHTb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDHTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B61AC;
        Sat,  8 Apr 2023 12:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D896168D;
        Sat,  8 Apr 2023 19:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E70EEC433EF;
        Sat,  8 Apr 2023 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680982270;
        bh=oTRmkIxyvn6JhP8d9cW5n0UDLfpH3CvnTjn/H+Kwtag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EOmGKLfmTrunHOAmy3b4nJ7HvjCtPG5pSuiRPsbspL+YnACjIkKZrANVjAFewgg8d
         fe2F4ZER0yA06r1rQh/zwefRYEgBPRCDlFMsmBerIf/F1PNeZJPOQ0rnHOtWjfTNXZ
         oH0vd9D4pOs3fVjygZq2w9WvBYfq0BI2dsGXgeWuwwgBJ0VMOFTCJo3aJtStbU8IKz
         FSot9G/Fofw156cKxZMoTAB2mhPDykdaneyJGfKj1Dc0Qy05/kXUMdab8J0wYWwoo9
         1h+1eTbU29NatlqUQtmfb65V8H1SzDF3tY7OEQdbBxxxqgvXJs+oovY+eETac0pnsL
         bD+wALtJJv0SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3F73C4167B;
        Sat,  8 Apr 2023 19:31:10 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDFU1R-GyuE-Gb4e@kroah.com>
References: <ZDFU1R-GyuE-Gb4e@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDFU1R-GyuE-Gb4e@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc6
X-PR-Tracked-Commit-Id: f92ed0cd9328aed918ebb0ebb64d259eccbcc6e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa46fe36bbac623d58817eb12ed0222d88fe6b16
Message-Id: <168098227086.15421.2948025480670677821.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:31:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Apr 2023 13:49:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa46fe36bbac623d58817eb12ed0222d88fe6b16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
