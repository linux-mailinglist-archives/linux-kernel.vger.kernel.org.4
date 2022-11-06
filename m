Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6961E5FF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKFUsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKFUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:48:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC4DFA1;
        Sun,  6 Nov 2022 12:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E77DFB80D21;
        Sun,  6 Nov 2022 20:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A6B0C433C1;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667767718;
        bh=zDOrIz0yTGUBMYKtK8wTHi5NfEehJHKzL+wsABSgL50=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P0WvtGoq93BFLCRuBfcVX58Ufa8UkxcWxsrrFbAwVh0z6NvN2GcO2lJqB8dT72KHT
         ZT4qaVx7D/drinjJ3XecByYyCPbYzMi+b1tp268LYoDRBRCc3+SVC0CVH9+9kJuJtm
         oEP+uw4OsGZsKDZW3eUoyZDOkU2ImpMHZnnI+YWrZ3VCQD5JkkYOrnqEAO8r9chA2C
         z6tv6lLU91FWMQnVUHigSQlUuVVgRIggKGhFR44lH+x2jrJCqTEGnl2QB0eIjlRlss
         STEqiaIuYYfit6aikZUNzYJaIljNJgWB9VrlnVc4fapnaGL0mFUZFusUG1WoTfeirl
         /1n6ChElnk6eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D5C1E270DD;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARS3S3vfT0eu94FnK9kkHHTSeKs8KZNLcu8-oVzFtyuvw@mail.gmail.com>
References: <CAK7LNARS3S3vfT0eu94FnK9kkHHTSeKs8KZNLcu8-oVzFtyuvw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARS3S3vfT0eu94FnK9kkHHTSeKs8KZNLcu8-oVzFtyuvw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1-2
X-PR-Tracked-Commit-Id: 7a263a0402561035199cd9049baadb908a92b6b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35697d81a778223727c2a01a3480735cf51edd93
Message-Id: <166776771850.27719.8399963188481628153.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 20:48:38 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Nov 2022 19:12:02 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35697d81a778223727c2a01a3480735cf51edd93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
