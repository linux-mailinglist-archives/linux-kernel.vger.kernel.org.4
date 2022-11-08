Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33080621E02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKHUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKHUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:49:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4015731
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B184BCE1C6D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 20:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9ABDC433D7;
        Tue,  8 Nov 2022 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667940536;
        bh=b8DQd6tMe75PmT4tSlxaBUxbHuS0WPDL+b4jwYA0eSA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EyBc4V5bS/xUato1x3FnerGAZphIsCBKFb4cjpbpQ0fg5xgg7ZaTAQsnwskeRc2BQ
         F1R4wwsC15D+Nr2gonNX2JJhLN9JWNQdLSc3tXvXaXQO5Yb2NjdfPzgawOmOs7EJWS
         JnGQxnM1PG8Dn+D23pfF/iQMOOHHnpWpIxwpIzsq/HKB1VJcdE+VNnc4JJkzd3e5tI
         3c3BThhO9xbmn49e47spttsW4EGbV9QGmvzqCJaj6L/Adf9PnSz0JcvHuXchOdPmXc
         uQPUkQXBk9k/jAyZehgf3yaVgU7t3kwI2QLWYnYzDO6ce1keMyXnix80BGZmEbK6tU
         IrwhjFsoOTdKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E64E270CD;
        Tue,  8 Nov 2022 20:48:55 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v6.1 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTv96BsOTQyyBTWSJ80fDuiniacDUhfz1GJrP-huWxJzg@mail.gmail.com>
References: <CAHC9VhTv96BsOTQyyBTWSJ80fDuiniacDUhfz1GJrP-huWxJzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTv96BsOTQyyBTWSJ80fDuiniacDUhfz1GJrP-huWxJzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221107
X-PR-Tracked-Commit-Id: 986d93f55bdeab1cac858d1e47b41fac10b2d7f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f141df371335645ce29a87d9683a3f79fba7fd67
Message-Id: <166794053585.22160.9230442831910400778.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Nov 2022 20:48:55 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Nov 2022 18:10:15 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20221107

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f141df371335645ce29a87d9683a3f79fba7fd67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
