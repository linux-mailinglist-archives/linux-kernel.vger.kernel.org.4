Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8F6C036B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCSRQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCSRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:15:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D51B31F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95FFACE0F83
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7BE7C433A1;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679246146;
        bh=X9ef+yx0atCpgmkLsueBFOxeLJcSMCzUYYlXYvA8REE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QKu4tWU+kad3Tg+xQKnk1KgxDpFvJ+R0E3ARM57FVX3MQ+4ZKG7lJl6283k9u0Dh/
         2Ie2Sa2XZ7/gAUzFx8mNqxEEcAcrnBnT66OY+wBKeQsbgtMi69K9uf+1rsaC6A4rMs
         AFa/tMtBfWuEKqWM3r7p+swk+AFjhMCBvhL5sx2TrwyBgHuI1QBqTgFwa75DeSiuOl
         wB4ds5ekmXZ7SCVzeZYDo5O77HhwfGhqD+2Gfs15BNdlJtk73MGiPNYZCXQtxmCetO
         DEARvXLbwiwhJkT4EaDFH3s2fVLWV1tY2sfoI3sgdXtAoA1C2TUDH3aGggjXkwVXea
         BfkNFchnUyfEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4D2AE21EE6;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZBciwlyC4qJ63339@kroah.com>
References: <ZBciwlyC4qJ63339@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZBciwlyC4qJ63339@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc3
X-PR-Tracked-Commit-Id: f551592f72563e119bdec5b9d5242f584111b2aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce86beb43eb5f801cb053abf763579f25d5276ab
Message-Id: <167924614673.22094.16482276550405894476.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:15:46 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 15:57:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce86beb43eb5f801cb053abf763579f25d5276ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
