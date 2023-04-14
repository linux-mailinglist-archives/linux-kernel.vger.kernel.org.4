Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B66E2995
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDNRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjDNRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50676B8;
        Fri, 14 Apr 2023 10:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5612661861;
        Fri, 14 Apr 2023 17:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE1F9C433EF;
        Fri, 14 Apr 2023 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494027;
        bh=xZEo2wsl+kZE8aeUuUpM7pC43UV2fFAHulQXDgQvjl0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TbhRBRNmUYrdVT8jjf2iBdov6gPTrgD/YITwVM70hZQGqjradXmPjy5Gfkjo3mw28
         Aw73z9hiGTuJMuGAmYCZMJI9tmeT09879gcFrB4JPsqLB2Is+GmIR1znyHUIoF3l2v
         udAkF3v853QUN3NUaSZyF1TWXX11Gv0du9MClV4LRdefoK966+UiWf3+1IX6nlnP1/
         c6i5gMfU4PpMgImWFHHTSBycR6k97RagUNA+3EIHyhciMCs7lUXpPeDwT0AiItdW1O
         CjdcZt5Ez/+C1/elvZnJsTfsmTsgrKAXL1rseRCgzjovgDv+AWJ9ALpG+hZYIGk9/x
         GOKgZtMZRE/Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3F05E29F3B;
        Fri, 14 Apr 2023 17:40:27 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jVJ+7XLZtv6YE0O0PUB9OSzf7c2qN=eESVHUCni8xjrQ@mail.gmail.com>
References: <CAJZ5v0jVJ+7XLZtv6YE0O0PUB9OSzf7c2qN=eESVHUCni8xjrQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jVJ+7XLZtv6YE0O0PUB9OSzf7c2qN=eESVHUCni8xjrQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc7
X-PR-Tracked-Commit-Id: 4654e9f9f43993eb9ce383fa7c88d14b052b8cc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b992ead33cdd47723f606350efcf8a8cae4fe36
Message-Id: <168149402766.11053.15235477289381160115.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:40:27 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 15:57:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b992ead33cdd47723f606350efcf8a8cae4fe36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
