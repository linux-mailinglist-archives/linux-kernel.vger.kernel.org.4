Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0266A0FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjBWSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjBWSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA81158AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26028B81AD0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8CB3C433D2;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178032;
        bh=oCXQhGhSENSn01bOtNfJL4N3xMVyEF9AfrM1uwx/hFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rhkWUwEUiUIvE7FHH6ob5EUX/waV9Wtu//PGDvwehTBI2k+FISGfwv/LKDxFfxXTl
         B1CShSFQXL+706eitk87VXxXA1JphjnNO5HIfd8i63NP5z3Ft0vnb626jZTTQVnpFi
         NpKD9neMZMw/+ey72W0Uva0YoYNsL2PaCSuG/OVL3Wdee/zJ3RDnDI9HUcyEw4QZGB
         dwpuTPE08b6V1xSVMkVGqE9p5YcJqAKJLZwTYgfQfgU6kIVTpZxIbGLY/p1xhrMC3y
         gYiu7VY9Cv51wzyfCd4Tj7quuVTvLMSVB98LXcFtMU5/BySH5UCa66VlZHGVYeJZR3
         wABQFtMpG1VMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7F8BE68D31;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222020708.GA1345661@paulmck-ThinkPad-P17-Gen-1>
References: <20230222020708.GA1345661@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222020708.GA1345661@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.02.06a
X-PR-Tracked-Commit-Id: c54ba4178159e440bea3826d22d43a9d0d94b071
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f01d4c8a22908956f4018ed334bb6713e41b37c1
Message-Id: <167717803274.14005.17460044613769697368.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:12 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, w@1wt.eu, svens@linux.ibm.com,
        imp@bsdimp.com, ammarfaizi2@gnuweeb.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 18:07:08 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.02.06a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f01d4c8a22908956f4018ed334bb6713e41b37c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
