Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296166F36C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjEAT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjEAT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E8271E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E627261EE8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D0AC4339C;
        Mon,  1 May 2023 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969166;
        bh=JG4ccKb79I620GdDA/8RZxzeYAe5IGlRqROONyxWxLw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a2a7RqkEZRSYTJMv9WXTu86VBJiC68CRw+y3NWbAoV0TwKgzoFSfzRN/06C/cu4Tg
         +Rezwd0eYHA/3KJakLZCyCgN8MgAGvPgNQfxy+8YZdh3RGnX3+YXHXmu7mQe+WAuWY
         x4psZe9z7Wx6eODkClfn5vb57ob46SxBbvLCJTpxupcxqcte4eNmUcs7D2R+Zd4Hyg
         vJAUfwiG9TPgFFk5+k5qLmooyqYlKt0N9qMVS9NOvEuyHH67sB0XgZ+yS20uvWK84V
         cEAqoHx2FwaVkPaqxpDg2kqvdiJ2exbBuYXiE5bQ9OFXMjwdcwzQunUEYUUdTeFMci
         rA8QCioGU/IPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 409DEC40C5E;
        Mon,  1 May 2023 19:26:06 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230430221151c27da7d9@mail.local>
References: <20230430221151c27da7d9@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230430221151c27da7d9@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.4
X-PR-Tracked-Commit-Id: 6b496a94c5905fca7879bc0dc438a47de40b7d4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0906f1feb7caf5098e7f831f4889feecfb0c68b
Message-Id: <168296916626.17937.10288951538423900232.pr-tracker-bot@kernel.org>
Date:   Mon, 01 May 2023 19:26:06 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 May 2023 00:11:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0906f1feb7caf5098e7f831f4889feecfb0c68b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
