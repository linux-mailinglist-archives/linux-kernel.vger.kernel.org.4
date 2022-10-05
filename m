Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603B5F4DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJECoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJECnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33532733EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C780B81C6B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C58C433B5;
        Wed,  5 Oct 2022 02:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664937709;
        bh=lS1b38uBGbrL++LVTDUCO0W096Jo6VzqK1n73cbmiJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g823CAAJjy/vebual3i0vT3+R/R6v5+9gZe2CyD9rnDLpeCsmXhA92DLEne+FoBWd
         UphJt94ylXEmkBCJK0R+en4eQ0s6DNC9MKrrJsnLnA8FGX070eQBPxqH599a6GLAoq
         BWDTsY/HPOrGe34JgXAK+JoJSYGZydltBDXSLYm3+3A+hv24ZKOEx2zkqTGaKMDFf0
         oEsBB/Ee3SbMYG2ZF2n2P3UHaqOgyKQVJ/iFJvzVEYRjhtI/xxacy3b6SDFHJO7qsV
         f4MsBMwD98Fhl8dwF8L5HXkDH4++OGBLaZsyBldEMbvnmt1R9VBQEFCWMr8cdLnBMe
         A24CtIvTT8SJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4735EE49F62;
        Wed,  5 Oct 2022 02:41:49 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003124657.1AC24C433C1@smtp.kernel.org>
References: <20221003124657.1AC24C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003124657.1AC24C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.1
X-PR-Tracked-Commit-Id: 392cc0a4a0c4b25534f3148b192f18be468f67bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d40c874573145b4af3b3b6205f3741b498697623
Message-Id: <166493770928.5416.10816415576768241442.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 02:41:49 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 13:46:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d40c874573145b4af3b3b6205f3741b498697623

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
