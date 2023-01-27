Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44367F0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjA0V6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjA0V6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E75A7E69D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E748C61DAD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51360C4339C;
        Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674856713;
        bh=I8FrMcL01dMLStUIHTVhShExZfdUUxmy7m22x/AEZJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EdvyK6Sb/FGPpLMHG0nhazOGU2ZOWjaqg/yMPUJrZmhWy7+Io51afKZ/f1+hMvVfq
         Sr3JVLCJf3GDoGgdyvQo6HTwxU8BMaYqG5FX0vbg33I0hivLAoMz+M17tOiDRkFbA2
         DsGD6MVbTImxc7mWMV/M3QNbCMJ7vcEaUGtvervIF5uIxA01JvMLzI2atxQfevTwos
         fLvpoPBJ7B6scXoQr62TjSceY+VbChNrnPmVTn40R4RmZVR+CjlOdAkhzXCiM5IApt
         QAq6LOZp/U5t1BbYzk2Ys4KzMTSLCC5babJvVh/RtPGxpC/3rhmenpclFc0G93La7i
         tmZYRpAlqB1tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A062F83ECD;
        Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230127190024.4066EC433D2@smtp.kernel.org>
References: <20230127190024.4066EC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230127190024.4066EC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc5
X-PR-Tracked-Commit-Id: 4bb3d82a1820c1b609ede8eb2332f3cb038c5840
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d1483a99e9cdf2775ae93c49982042a0a103c29
Message-Id: <167485671323.1722.6168514253955420388.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:58:33 +0000
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

The pull request you sent on Fri, 27 Jan 2023 19:00:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d1483a99e9cdf2775ae93c49982042a0a103c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
