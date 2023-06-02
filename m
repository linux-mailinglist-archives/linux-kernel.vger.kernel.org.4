Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35B7201F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjFBMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjFBMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D42E71;
        Fri,  2 Jun 2023 05:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6789464FE3;
        Fri,  2 Jun 2023 12:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC3F5C433D2;
        Fri,  2 Jun 2023 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708378;
        bh=ZjmVsfJZPDIRqu+hGMgWbdozX9icQaUCr51LGriC2Aw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j3KG239aufywXMxz1ZrJ2Xs0YKBNnQBHS3sqtG7upxG0lrQreZgIoTP5VyStylyWc
         llXQazboBppPWf0v6upOuyLvC/ik2Mn0T0/ml78IbhMMiGBqSjL+6XbODz+SmmatgW
         28Nj5OKbaBoGd/XeqzZBY1fqvKKSaryH7xl01UJBA7px1e6H2woWSO//ROm8Oxrrb2
         XCiy+ZxRzvZ1jyHd9b1H2+p5/qfe2jzPhu9UFZ13Dk9sEs63/GDe0Hkqs5vkexqx3w
         mFCu8HMBL923MUiNQJ3BBeVGAzaSFX+9+IDwpJxrGLAVd5g6taG9nsjfnl5D3Z69/+
         MIWobKJCySs9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB218E52BF5;
        Fri,  2 Jun 2023 12:19:38 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v6.4 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
References: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230601
X-PR-Tracked-Commit-Id: 42c4e97e06a839b07d834f640a10911ad84ec8b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1419c3ba31446feecb728f49820ff2730d6deaed
Message-Id: <168570837876.24915.8384597581978470137.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 12:19:38 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jun 2023 21:13:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1419c3ba31446feecb728f49820ff2730d6deaed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
