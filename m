Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9D724447
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjFFNWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjFFNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8BE78;
        Tue,  6 Jun 2023 06:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C2663321;
        Tue,  6 Jun 2023 13:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55F81C433D2;
        Tue,  6 Jun 2023 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057758;
        bh=Jm7WtQIwjExvSjh6DAfV13p9ui1JhaD+lWKh+ZYx5tg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cSuJew/9yXPl+Ck1N7igJVKzNVQdgcDFoOVwNtWU02J3n+G+65DIBtkoGTHVlbR2o
         5puLXA/FdV2lPYNoGadyXfXNUeNow7Thw1ox0kj8NAq1OHh3tia8bFHhM2S4V/rfgo
         hDkffy1ujlWjw5bcFGvA+OT9+SQRiWhuFwUU/Thr6kODcwgIWeqKrGbomyBEXBfSaK
         4DhsxzZJwmm0V7mPnHa+lSTTbawn1MwulpLTOcDhWLGJoeuRMR3qgrKYQf2J8/R6+o
         7I3C0FgMJ+aWpYrfHYDQnueg/y2d+NZQDxa3k/9SpyBP4WHHm3vdFZe7hublkBCeau
         Isw5h2+6WFZlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39FD0E8722F;
        Tue,  6 Jun 2023 13:22:38 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230606130641.AAB60C433D2@smtp.kernel.org>
References: <20230606130641.AAB60C433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230606130641.AAB60C433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc5
X-PR-Tracked-Commit-Id: 0c331fd1dccfba657129380ee084b95c1cedfbef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4d7d701121981e3c3fe69ade376fe9f26324161
Message-Id: <168605775823.13551.15450007673640362051.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jun 2023 13:22:38 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 06 Jun 2023 14:06:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4d7d701121981e3c3fe69ade376fe9f26324161

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
