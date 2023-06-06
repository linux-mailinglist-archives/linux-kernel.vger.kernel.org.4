Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C197B724449
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbjFFNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbjFFNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A810DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF26F63329
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 603EBC433D2;
        Tue,  6 Jun 2023 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057764;
        bh=b3vcqjhWJsnWK5ynop/JTgaDSRXJDPqHxVQq6iJwPLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iB5kijd0OmXa/SiZWXG+LuP9r+lGeLLrjfuDO5tnoGxxMSqpT0klusgAxtKN7L+y7
         sJHUGxkUIvkJMJHBPOy4A6rhOE9MXy3Ex2BjoeYStLkue+A/leTpvKAZBm0HGRyTGC
         ewjH1hnZO16WFLYDeeFYeak/lv8hX4xuQiDDdFScpmc+f2WI+odK5B3wgddfhN+zxa
         3B6ws9OMDWW6ppyzkx7jgxZ6xfu4KHVXkGDn8rUbqxmVEoK7z+BqFzfmVcPdi1Tn6C
         Qy6hZBtZRnCfd1FNJUmwI/9NxV7Dz5oZOEgwyr1vGsIZhdTxqyxzajPVQwzG5xbPwp
         t0D3AFZ3TXcbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C6F1C4166F;
        Tue,  6 Jun 2023 13:22:44 +0000 (UTC)
Subject: Re: [GIT PULL] HID regression fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060501
X-PR-Tracked-Commit-Id: 7c28afd5512e371773dbb2bf95a31ed5625651d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa56e0e44f658085262f536bbfdfff3374b8828d
Message-Id: <168605776430.13551.2135209983187880737.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jun 2023 13:22:44 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jun 2023 23:39:17 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa56e0e44f658085262f536bbfdfff3374b8828d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
