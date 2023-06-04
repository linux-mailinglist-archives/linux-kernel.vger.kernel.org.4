Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E2721722
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjFDM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjFDM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36427CA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA7360BFC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30D51C433EF;
        Sun,  4 Jun 2023 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883550;
        bh=wQLhoLK2jxIxr4KrKFijkC+AqoLLiwLctCnXIHmyEC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b3R93riDkfDx60PhSCiG7gahLZyrc863OrLNe7B7u1VzYyUsMe41gs3bj4sMG9c6Q
         BeK6VtmgzLypmHcwgeLPNySuagNvirHCpxGES/ZBspVCnuvt00MWnlVw3iMHbdJSZM
         rpURsnujy0pUduQPl53OsuNaarta8vltamrr/i7Bt9VMC9WZrQKSoj+KlnHH2h7ySU
         eZwGHaY1WMlYvqSibxg8VUYu6kV0Rk0Xsv8hBknZtAbXnFlXG/3v4YmowkY+OKi+hK
         r0SKDm8tr+EQqT4tRx2q48y/Iu2PBVL8evo7RiBf6Jm3QG6CL7Wjfay9BqR+9YDtia
         6cBBZZOxj91Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B12FE29F3F;
        Sun,  4 Jun 2023 12:59:10 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHxF1BbkBOaDv56j@kroah.com>
References: <ZHxF1BbkBOaDv56j@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHxF1BbkBOaDv56j@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc5
X-PR-Tracked-Commit-Id: 48e156023059e57a8fc68b498439832f7600ffff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 209835e8ecb01a2f60b7da153d223ba182447197
Message-Id: <168588355010.18655.5717443634481351930.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 12:59:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 10:05:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/209835e8ecb01a2f60b7da153d223ba182447197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
