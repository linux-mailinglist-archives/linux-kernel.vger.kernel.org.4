Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58F742B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjF2RfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjF2Rep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515E35A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C876615CD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0A4CC433C8;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060080;
        bh=GQ9/neat5zxuupInFaFWDMGt9QBw67rQHs0Hhp2Xw4g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AzfQd1mNAzOAarksS4qaYq67QfGV9T7yHkaPIq+SV9M7K9ifDGl+wd7Kx7j7dxv2r
         Nn2EkBRo93C3e6y92i+5UYIl/xQ+eRaej6ZHe95GvyS8O2NrpwhWYnaJWELFhBmXD5
         ZmxdhlsMCM4Fvt/Pw2ZiEODv3evpOPF3hEE0kEmbEt+ZOqkh7JNCPGP9Lo0gRb/8Z2
         AFki7NpDhqCFuhXcDc0FG06rVlkbqjCeUSxi2OZ1axkh3LkN8eWeY1xlXr8Azj8cNh
         39k84X8gtbPo6EghnjfBFz3nfy+JPJRTBzDjAuMfAQeQnHocP1kxAtuXNjNs2nrZeA
         9Pjv9jSWeqtNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D81CC43158;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2306272250390.5716@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2306272250390.5716@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2306272250390.5716@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023062701
X-PR-Tracked-Commit-Id: b571809ec3b0af1a93d46bb09fece4ddeafe5a97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e382fa72bbf0610be40af9af9b03b0cd149df82
Message-Id: <168806008064.7356.14808968149921025933.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:40 +0000
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

The pull request you sent on Tue, 27 Jun 2023 22:54:30 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023062701

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e382fa72bbf0610be40af9af9b03b0cd149df82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
