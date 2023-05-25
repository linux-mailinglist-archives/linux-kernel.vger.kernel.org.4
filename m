Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64F711272
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbjEYReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbjEYRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D22E4A;
        Thu, 25 May 2023 10:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4216481C;
        Thu, 25 May 2023 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E247BC433EF;
        Thu, 25 May 2023 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685036013;
        bh=SoKLXM6IzEoyTNsGLUdI8RjaZ/6QCBAd3yr0YTYEZZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TRPe1nUSr4NF7IuXfFYBWM8fsZUPlsGdQpyhb9L1svi8QycleChHzaQD8ug/3bFEO
         2jkXA7oIH+6I88silCD6b+6GGq2LuhIEWdjkUlKHgBfyrO6RhKl82kUPapQ0KT5mqW
         nsHKg+hgS5PFFixhrDu6Ia6t3zNNsQs4WyNmkKg961fN961ql4Kw8lbibM46Krc6JL
         BJXSomKusSZ9m0hIHL964n7tc04z0wWYaE5/i7x1cnpvcWPiUK1wZdmId9a/fXYJFV
         P5hIzBuTWExm2jYX/XC/VF/u+3ZM4wM+cX7yCZjiHkqCH1xPum9Q/gLu8cH+Zx8t4r
         4PhJ2mA1uTuaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F55C4166F;
        Thu, 25 May 2023 17:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.4-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230525165442.lnltc55c6ivirtub@mercury.elektranox.org>
References: <20230525165442.lnltc55c6ivirtub@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230525165442.lnltc55c6ivirtub@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4-rc
X-PR-Tracked-Commit-Id: 95339f40a8b652b5b1773def31e63fc53c26378a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb03e318135419b8b781f83cdfa7dbb9252afad6
Message-Id: <168503601380.13926.13559855222764719084.pr-tracker-bot@kernel.org>
Date:   Thu, 25 May 2023 17:33:33 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 18:54:42 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb03e318135419b8b781f83cdfa7dbb9252afad6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
