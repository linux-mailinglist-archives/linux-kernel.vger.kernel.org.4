Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357F964BEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiLMV5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiLMVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D625EA0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C72B815D1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EAF1C433D2;
        Tue, 13 Dec 2022 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968441;
        bh=TA5kF2//6ZMLeSO9E7VZW9kha3rhtvRCGGlrXnDmu3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wj5xUYxapKXbO5KzkF0EoAtVXkx+xx/P5QcASt4CPxuN4GbGRrxeFcE0E5pCyPkDu
         r14iJUGabeA5CXkOUcS4VzvxaJgbUCiqcthqizpsKQQbe74GcX42bDMVOZBh7tPiJJ
         0myP+oVAW8gzunPvt6T17yRPkx+Nac6BuJmYGZBvzuSClKN4D/Y8vA4Q+z6PI9dpad
         rnsDWOJaVpfIMQhHOeNd3F2ENGo4G2QxbgxfRUZyi+3GCm5tnEl+d9dSHplL3jeGr6
         bkXev0/N3cYlrh5dpakTVid9kuosgxNZGTulM1YRRpCd4NJRdG0bqcaod62NGJGLO7
         XP8s8gi7cAhYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DED3C00445;
        Tue, 13 Dec 2022 21:54:01 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212131547.9FBBAC433EF@smtp.kernel.org>
References: <20221212131547.9FBBAC433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212131547.9FBBAC433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.2
X-PR-Tracked-Commit-Id: 22250dbaba99f87574095af894610e9801d74419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8cc9174ff9e7b739c6fa61037759f885748fbf5
Message-Id: <167096844131.13204.8176176446881522671.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:54:01 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 13:15:38 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8cc9174ff9e7b739c6fa61037759f885748fbf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
