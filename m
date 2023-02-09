Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC156910DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBIS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBIS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:59:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBF5EA0A;
        Thu,  9 Feb 2023 10:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D55D61BA9;
        Thu,  9 Feb 2023 18:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DC15C433EF;
        Thu,  9 Feb 2023 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675969177;
        bh=C421LtBeIdvEx/77405PE58z3WphO4n+gOkSOQRUnok=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mDlnG3j0aYE+vxEL0Lawh1OKyYct2AzMO9wnp/Bo6nT62XPWpbm547kU5x93bd6HC
         wcbY9x+bpRbldxLLIAWZJKG1hT1oGlDYou6rC1QAL+PWb+OXQOjmtEZZDzyaPjp717
         JjcB9h+4gKFw70m2/UtnRrV+hs/5dN/afYG2KNulFDuL4Xr5CWTxaWRHmsvKs9stuj
         k9vECF6XMW2WpDoyBSFPFiVyq1b2dbm9Y3hbL7vOPAWiSk0MBKsRSFiU4ND1XSfjio
         8oPd3WQiK4QXqzGrdr9k4vX5x4wAMWpSXATRjvbZ4WhVgpt6p5Qb5TwhlpYNFwBevg
         iuwvTLCgtnmUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E85D5E21EC9;
        Thu,  9 Feb 2023 18:59:36 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iTBJNNxKs86LjTVfer6aqqPYhOuZP04FC-zcq3CWfv8Q@mail.gmail.com>
References: <CAJZ5v0iTBJNNxKs86LjTVfer6aqqPYhOuZP04FC-zcq3CWfv8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iTBJNNxKs86LjTVfer6aqqPYhOuZP04FC-zcq3CWfv8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc8
X-PR-Tracked-Commit-Id: 918c5765a15420ad60730fbe5b5b67beb74ca7b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e544a07438522ab3688416e6e2e34bf0ee6d8755
Message-Id: <167596917694.5202.6396809056121171365.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Feb 2023 18:59:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Feb 2023 19:49:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e544a07438522ab3688416e6e2e34bf0ee6d8755

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
