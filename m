Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF1693567
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 01:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBLAlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 19:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 19:41:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E985113EE;
        Sat, 11 Feb 2023 16:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31A1FB80B0A;
        Sun, 12 Feb 2023 00:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDD5DC433EF;
        Sun, 12 Feb 2023 00:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676162497;
        bh=UkhJF+Gp9x1SE3kG9//McMbKVqc5kA6L/N20z20g9Kw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QOuQQ5EYmi+IcX2CMF0XeXJ2RJDI0/KIuD7MSqaXTZ8Aw5PZJU6P2V9GlWuM/idgz
         /hmoVEIIL00k06AKdCiwAM6KEbWJL430ylv1idU/VqoqFWX/T8s7QX43ZRp+pqnHVb
         4zvyhwV1SXxSJxYN99s0Q5YHZvbqfBUb5p8LaxwfWoT1vYrStTfEFb5TOkj6wXt33o
         ScU4YRbYMWGqIADMWQrQ9hoj04ERj/jNr8SLKkVaKIDTTfFsuNHQ3c6kmwokz5/hfK
         TM40iS4OOc9gnyeoaNCqHodym+5tgL8TVm6acobymoUT+plCYxbW2yIk5wIjRe1BBz
         /FRZ0uJ1O7XPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC906E55EFD;
        Sun, 12 Feb 2023 00:41:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230211232523.6A8DEC433D2@smtp.kernel.org>
References: <20230211232523.6A8DEC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230211232523.6A8DEC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc7
X-PR-Tracked-Commit-Id: eede42c9459b58b71edc99303dad65216a655810
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f339c2597ebb00e738f2b6328c14804ed19f5d57
Message-Id: <167616249682.23504.4148695583825153218.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 00:41:36 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Feb 2023 23:25:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f339c2597ebb00e738f2b6328c14804ed19f5d57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
