Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38A639142
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKYWAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKYWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:00:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223DD1D644
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5ADBB82C78
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 22:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59438C433C1;
        Fri, 25 Nov 2022 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669413642;
        bh=fEeNPFUDGm2z5+KWIW/L1vpvLkUpsjrhvOazV6cXKC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qpqY/W4LV+Pukc2WRxMGcVa8rHnd1Bz1L4LvRHuhItVWhRn8EEQC94MNxb6TnaY9l
         OfNiw7QJdhoGUBZg6AUbYfxmPh6TkHufwH2FNavWpfkjKLBSUJanSLwhCdZ94kS0wJ
         rjv+HbOUZjDiyDtRmWROQ0leZ4yijS4oCPFRpl8FmynToBEk3OFI++4b8PPaAVkhwd
         /sSNcnankL+PUT+ZJLSA+fbhTbI+W8fX2kuM/ZN4T1sLeU3XW02+Ofrvly3VX8LeEd
         tnedA1cmpDpNnU2JSax+gBNb/ztQfwIRyeGBxBYjqAu88nSBDmewp/OmLjTLLnEvdV
         HdD+R4KM5fS0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4729EC395EC;
        Fri, 25 Nov 2022 22:00:42 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221125215409.D942CC433C1@smtp.kernel.org>
References: <20221125215409.D942CC433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221125215409.D942CC433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.1-rc6
X-PR-Tracked-Commit-Id: 31a6297b89aabc81b274c093a308a7f5b55081a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f10b439638e2482a89a1a402941207f6d8791ff8
Message-Id: <166941364228.29754.16470503583715631448.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 22:00:42 +0000
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

The pull request you sent on Fri, 25 Nov 2022 21:54:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f10b439638e2482a89a1a402941207f6d8791ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
