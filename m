Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857B6A5E17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjB1RRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1RRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:17:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D71557C;
        Tue, 28 Feb 2023 09:17:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97F86117E;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ADB3C433EF;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677604661;
        bh=n0+jQ+Ids2MN33qI0Dcw0DrgCHjaGWzzK4Yj1C+pyCc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YybGAIqsMaHcmeLlnZ7ufQnZkM6jw2i2Jqa7ZbwWzuLz7oY9cbK3+4kpJccwE7j13
         JnaiR2RdWwp8Y4PStAIxllxavI/R/pohbwwPv5z1J8fqpi1iIl8N3cZlY6lFps/jWr
         7DKoj2aKP75XvChRXDp/EbZ50irUSi9ikX8BBBA+BcrhQu2eHQK21So6XpbB86tYJ9
         lK8GwvVZdGO3WmPSsb6MepN2mkWWVxs3b8SQ8wCHqtADQifQ2W6tU6NQWn8NhfM3pn
         5RLGC707NMQ5imbVy/TMTAAht0TaTZpeOG/16IMJcOF3NXv5rTCEwbvYR/MhcWVPmF
         j1ghUiBdWQeMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48DFBE68D34;
        Tue, 28 Feb 2023 17:17:41 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230228142651.3839023-1-thierry.reding@gmail.com>
References: <20230228142651.3839023-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230228142651.3839023-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc1
X-PR-Tracked-Commit-Id: cf70d01a62c712ee715df1f7892b58c77474bcfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e492250d5252635b6c97d52eddf2792ec26f1ec1
Message-Id: <167760466129.26717.16184498370267179060.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Feb 2023 17:17:41 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Feb 2023 15:26:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e492250d5252635b6c97d52eddf2792ec26f1ec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
