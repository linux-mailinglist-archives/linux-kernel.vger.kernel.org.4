Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1965FF7D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJOB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJOB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:26:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F110071
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99D12CE27D0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7CF2C433C1;
        Sat, 15 Oct 2022 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665797202;
        bh=GVMP4r2Hfa9BV2HDkorX+mxl6yljcepM4oHHjUdD28c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DucsxmIhZg9fiS7EdA7CqieRsUfncznrtMaNJmYCGLun58+0O5vqTu3A3hut7d6j+
         OaAqrX+lq5PjGyNlIiq+2Aty3PzENdKFTGDu59uZtS6mYAQ6agj8QiQadiGtpf2R0B
         Ud+nkP0125uyZyVPjM8fwIsEhzW29yqZ/FM7Vl87MVS/kr/GLF5tE+UsO95M9Wi65t
         bck4gvH9vWAJ/DP/b4akYMfmiV3IA4Zznz18WRBGib+nsHqZgrTdFgutqyaDHONnKL
         IAf4H6BbkqSCdj5AOwRQDj3s/5mkFKKncGSyFf3QDxvvSydBHu/S5+BqsUxxii0NNU
         UeATtdOJ7YApw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D477EE4D00A;
        Sat, 15 Oct 2022 01:26:42 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1135185122.30714.1665782233107.JavaMail.zimbra@nod.at>
References: <1135185122.30714.1665782233107.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1135185122.30714.1665782233107.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-6.1-rc1
X-PR-Tracked-Commit-Id: 669d204469c46e91d99da24914130f78277a71d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7cef0d21c379669c9f620c9692b5c7c885a6311
Message-Id: <166579720286.30479.2326196270255262901.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Oct 2022 01:26:42 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 23:17:13 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7cef0d21c379669c9f620c9692b5c7c885a6311

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
