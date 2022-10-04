Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761A5F3BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJDDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJDDpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60A559B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 20:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0BC7B81658
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C62EC433D6;
        Tue,  4 Oct 2022 03:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855092;
        bh=NoqojNcFXzfUqgBFfqu+BYWlUYNJaSSg4ZYHNlhpHEw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FYD8xpXzShMy/4cBu+x5kC/55BpajXb0/Z31I/dj5gHQiJe7ZQlYmvkhgAQZDh0Uz
         ydJLfUCc/pf1OqoIhIobL7SXjrcg/YJveNALPQ+9DxKN1wMEo9r7m+cdWrv16f/ECG
         VM98JuWZ+wW2GaXz/YfTjMxnWBi3A8GbvMlyeHn+Xh/S/cyMDB8yRuN6Rh0XuSDQ/y
         lOFeS1zZfnL6P9VmK5DFD6gAvqu5MHi8FwFzqjMd/p+RUFBcDE7WPK1nS5rezYPIQy
         ss11mdYhoaxUPjZqxISv4bCjCx8o2aGIKs6NYxPiUVnBvzEzVFcf3fii23TNZ3Ca8p
         +eyrXr7eVVzKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82974E49FA3;
        Tue,  4 Oct 2022 03:44:52 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzrD50lgln3c9zEf@debian>
References: <YzrD50lgln3c9zEf@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YzrD50lgln3c9zEf@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc1
X-PR-Tracked-Commit-Id: 312fe643ad1153fe0337c46f4573030d0c2bac73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3497640a80d77cd098d45c9f3ab235b1aa472dbc
Message-Id: <166485509252.18435.13778164711420552778.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:44:52 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 19:13:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3497640a80d77cd098d45c9f3ab235b1aa472dbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
