Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B715B745016
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGBS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGBS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C124171D;
        Sun,  2 Jul 2023 11:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89DBB60DDB;
        Sun,  2 Jul 2023 18:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF49DC433C8;
        Sun,  2 Jul 2023 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688323980;
        bh=oLOrAjaFmnoNaDsCAUaBwFcwNuxFar/iOGYWCHAB/KU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OOz4fodrrB7Pt7x51N+HrShn/D4cwjqbZjVdExxwbnD9ZQ39uFO4jBar93QZZ4fJk
         Qezg0ls70gnoWons47HvA7bhsqd2gg8ufkqr24MTQB/SqeCEylsKGKmZ7QlRvXt8ci
         i0Ay4orXf5uCIpN6YZX1Y3AxDzkGz1IkI00S+/pA3kyCOi4WvBBe9dQalDZfJE2p4F
         N6pNte2uzYZdzkJN1ES8YMFHkYHNDwA6mT+bxFdCBi/3MXmSYJ0FV/UmTmMvaGXXbG
         zJYPZWZCToZgz6IGHwPDbwm3CI4xG64z0M43qRHNwimId25pZwFUVQQUjfXjbaezgu
         Yyl4otz3uf2cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC663C395F1;
        Sun,  2 Jul 2023 18:52:59 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes & updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKGOzzDGM1925iYg@p100>
References: <ZKGOzzDGM1925iYg@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKGOzzDGM1925iYg@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1
X-PR-Tracked-Commit-Id: 4ad1218bed3d1ea4c5fd28588f8628b92df30ad7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed77ac92a17c5138c5b5d792ab226c3188217053
Message-Id: <168832397989.18363.5170179806380861488.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jul 2023 18:52:59 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jul 2023 16:50:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed77ac92a17c5138c5b5d792ab226c3188217053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
