Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAE6A9F75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCCSpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCCSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:45:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5259419;
        Fri,  3 Mar 2023 10:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84918B819B9;
        Fri,  3 Mar 2023 18:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D9CC433A0;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869071;
        bh=3+blzz/o/7Z3s6nIgKqJFPIN1F2p/Qpg7jNgY10jf8M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sys8nl3OGFP5UaIn7XbPVmJuhvXBvNbsmnCxuD3n0oo6M+NSDa0jOpWMqKsCQ6mmr
         oo2XXhhiN5steJKZKQEOVhX5TxVoI7ZE7ZX/i7sUOMDQ07HPSYYMwJAyFXMrOFlrrx
         qRWqVVD4AgcxPcQfGsE7xt/oInx6D5fET/R6ed/5IESQNTu0kP4O2UIcTcgsZYSXvg
         t4e4fZVOGDc51mKJ7KAAvX8yr2BNKKlRMuG6g/3zgP2gCK57GwSrT/+aPLKFm/sP0m
         frrsZ9s5f7D2T1ObaD+hx85oiwRuyX1omcH+lOyiEz7h3UqeG3nUgE+NJPOIsS29Mx
         P4ewyyhsRatAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23CBCE68D5C;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jwa5wpitjs+wf--ndk4k5zpM4iuXV6gzxAoB4UmnKUfQ@mail.gmail.com>
References: <CAJZ5v0jwa5wpitjs+wf--ndk4k5zpM4iuXV6gzxAoB4UmnKUfQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jwa5wpitjs+wf--ndk4k5zpM4iuXV6gzxAoB4UmnKUfQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc1-2
X-PR-Tracked-Commit-Id: 57b76324c2a03b7b75d2d93f5c83f4340fd9b621
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b6f565e79188760851d58fa59628b4c2a1b334
Message-Id: <167786907114.30023.17088830195921845954.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:31 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Mar 2023 19:16:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b6f565e79188760851d58fa59628b4c2a1b334

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
