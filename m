Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9E6A2695
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBYBiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBYBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B028E3BD;
        Fri, 24 Feb 2023 17:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 286E0B81D6D;
        Sat, 25 Feb 2023 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4949C4339C;
        Sat, 25 Feb 2023 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289073;
        bh=S2S65UIE5O0cFcCaHy8rRFw2NobvDz9qeee0yU+0Mkg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s/cewRwUhRQeizMMbm41tbO5TdzhoBlduphsJaZOCLTXNQRhimRcx22wxwsTw3eZW
         IYnRpzfAUKoqPN7OIchMAODKrHLkM+QjVmFOjcVEkSN3dzGk5wVz+NHpZMZ9//v7LQ
         /0x7BfhY1Y65FYMUr9h9511EBq04enikogOUrKN0PX7+4hqO+tfb50H+YpW2jQ4uu3
         zksZb+1Pxtj/+zL28XJOBRwqj1NnsBbmvoimaTj/ZJnb1mroroQBR363TwN11SwLiI
         kbEXxD34HhHrhwigCfBFiUXDWnR2OAL/KA6EFdzsLwCRykWOncYBUaRH0TpW4PI6Ck
         jvd3eswuOCqGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8285C41676;
        Sat, 25 Feb 2023 01:37:53 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222224642.u6cmwaoqtxty7sxx@mercury.elektranox.org>
References: <20230222224642.u6cmwaoqtxty7sxx@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222224642.u6cmwaoqtxty7sxx@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3
X-PR-Tracked-Commit-Id: c142872ea40a99258e2a86bf5c471bcc81752f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39f013440dbf5b1f209eadb3b4665d4f0e840b5b
Message-Id: <167728907381.28954.13929204545062522218.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 01:37:53 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 23:46:42 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39f013440dbf5b1f209eadb3b4665d4f0e840b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
