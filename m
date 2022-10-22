Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA4608325
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJVB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJVB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178A2A5682
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 18:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B8C4B82DBB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9BB3C433C1;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402117;
        bh=D9B+TkrlXqDWTEt27SqzjrXbr6e5gHtyez/u7xB3v6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CeL6SbZQaPBF18YFSmczDsGQm8bhX4Wt2dg39+O31+Z0MVAJJZYRgqLu5cmbYPfKZ
         CM/RrjBr2QQn4IVINKOhOFa7rH3tzm0A5q070AGtqSLJ0Z81D5/08yK9JsZ8Ybswhl
         511vFPDJUMng6ZzgoDMmO+3mA07b771hQGXHWl/XWwZ1sWhkGVOo//321JZzpv0LFO
         TYiC61biqsCl1/WiszwA2cAW0BOGsYvZI6B9DYg1G1J72/oz9nu/5u2pizjsT5APEx
         JlDS9Rcra05crNdeLLjCdScySozMasG+s+U5PCT1lGJMma71BvvMR/tbv+1r+bSYKE
         q9Hu7b6eyLYNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A332EE270DF;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eda45be4-c7fb-1db3-1ff6-42bc8935c9ad@redhat.com>
References: <eda45be4-c7fb-1db3-1ff6-42bc8935c9ad@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eda45be4-c7fb-1db3-1ff6-42bc8935c9ad@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022102101
X-PR-Tracked-Commit-Id: e66928af3667a9d844a674976ba7765757ab68e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 334fe5d3a99aea2e92b934b4c58fffee9b056c5d
Message-Id: <166640211766.11783.18074507608452015776.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:37 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 14:17:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022102101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/334fe5d3a99aea2e92b934b4c58fffee9b056c5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
