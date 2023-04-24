Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754526ED4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjDXSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjDXSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F6B441;
        Mon, 24 Apr 2023 11:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D8C6285D;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C98DC433D2;
        Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362056;
        bh=4dleVc+1+mPVAEbksahSJTbCr20nxi2oHPGWFUhVnrw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TzHtLPnfMqoL4gWwcTtIhZ8OQEn8wtJ9q9LadHRfhT0Khpk3kXOyiApvqjrgkPZfP
         sr4QcutFkxG/jNVZc5unHpLXrgRY957uq5cxIaI7EmJqWRoEnIRZpz0XdhsaYlECyF
         iDJxmyHOcqn5j+UWaF8lTXtItSlDhgHQwDAVcVRSHFx1/4euaUbWJMfn1Y5JIeVtvY
         IxCXMZhWRB/vwAKJMqW+Ifu72S5PFBtzHNfbv2TcU95v56Ojt5Xg/oqFAvMAeV5bgH
         xj039QteRbi6Z7j4E3oG2KNd05w7gQ+x0nMb1bS1xXn8K9b35Tc3M3ZybFpIUCfJzF
         d13iAzu4ZTyGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF6CFC395D8;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424144943.135041-1-mic@digikod.net>
References: <20230424144943.135041-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424144943.135041-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.4-rc1
X-PR-Tracked-Commit-Id: ed35e2f2f0ded15df313ae6f8da21e85c8e1e493
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62443646a5fddd2c15dacd670fda84044ee7f748
Message-Id: <168236205597.5635.11532543581313030663.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:35 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 16:49:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62443646a5fddd2c15dacd670fda84044ee7f748

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
