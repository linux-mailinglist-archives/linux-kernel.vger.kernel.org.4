Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BC61FD8C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiKGS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiKGS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:28:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E021181C;
        Mon,  7 Nov 2022 10:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96DE3B81618;
        Mon,  7 Nov 2022 18:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 486D9C433D6;
        Mon,  7 Nov 2022 18:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667845727;
        bh=IvxViwUlIhKa6gb9BUMOrTSyMdG1bgRL0cXTw7n1Yrw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bh9VlMwXYLGzWUK6cHHn/si8sVXBzNyfxyq2K6858WOfTq6/9VeDMyGpUn5TPbHV+
         Z50YALNL/neeB0bUlg5w4Ls998E9Ncz+1VWwVcETmoVWDmW79zsMx0N0DTos/jDV0o
         Dn8woRQSxfAWQDn3rk2PJxlcomUPNcF/MvSCh4zctgP37C+CRbRZsswjjnIpEsjt+B
         fJFdaYvAsU8Lo0fwluQd/6MeG9upITGg+OBZr4p1uHDj3B2TKm5GyMXc+swvF+vw9a
         dTVtuSmWJmPA844aG5Lj2oGfptWT1wmbbTsR7vpF0+9CnTFCstWK2+g7vD+0m2qGrh
         XkEbThDsY5/tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D109C41671;
        Mon,  7 Nov 2022 18:28:47 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bab3412a-6328-953e-81c2-cea423908c21@redhat.com>
References: <bab3412a-6328-953e-81c2-cea423908c21@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <bab3412a-6328-953e-81c2-cea423908c21@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-3
X-PR-Tracked-Commit-Id: 53eb64c88f17b14b324fbdfd417f56c5d3fa6fee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1de832bd3243577de365222d8bc92708005ebf3
Message-Id: <166784572717.16899.16268147170381402440.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Nov 2022 18:28:47 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Nov 2022 13:17:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1de832bd3243577de365222d8bc92708005ebf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
