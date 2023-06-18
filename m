Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A7734728
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFRRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08507E4C;
        Sun, 18 Jun 2023 10:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E4FE6123C;
        Sun, 18 Jun 2023 17:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D25CBC433C9;
        Sun, 18 Jun 2023 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687107690;
        bh=8hBpRKdPYCGQr3y42zDgjG+5Vvi42Uqy7z3v8HnznDg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FW890xa0LrqY73HVGpPPjQ21DXZ8xunzbR706YSMTtZGsoGZYQXoO8gAQ3jHCxkWH
         IlgIurbOyM1Kk7mC2wWcRDklDusQKJv2ZP7FO+yphjJvFG+pu8vzcpWikgXGHvuFzU
         RkjPw0TREq1q3gb3LCX7jiRx4O3ppbT697NW0BsnqfbK1nmN/2iNd8ZYtz5NZ6Zggw
         tQwJTzzSWcZDS7yEUVuMj6xYioxqNfnPk33ZCMqjE8I9KBTa5QHmOCC1/7TVlNeZbz
         VC+pkidIutag2IFt0kMs113ZGQZMtpg8+u44Cy6v9eENb1p73qBXoXEfEPIDLBGTef
         eOjN2sChvmWkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0DC4C1614E;
        Sun, 18 Jun 2023 17:01:30 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZI6TEDXhJKW3l3XF@p100>
References: <ZI6TEDXhJKW3l3XF@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZI6TEDXhJKW3l3XF@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-4
X-PR-Tracked-Commit-Id: b5b2a02bcaac7c287694aa0db4837a07bf178626
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dbbfe254d2360993e79a10ca42aeec407e13b34
Message-Id: <168710769077.15251.15059496966085119746.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Jun 2023 17:01:30 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Ben Hutchings <benh@debian.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Jun 2023 07:16:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dbbfe254d2360993e79a10ca42aeec407e13b34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
