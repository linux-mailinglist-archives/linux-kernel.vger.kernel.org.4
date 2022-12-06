Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36A644C33
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLFTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLFTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:07:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E23FBBA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 173E1B81B24
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DC7C433C1;
        Tue,  6 Dec 2022 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670353622;
        bh=OMPXil2J/N8Qt2tnrj7UzGzwYvRcs8wTfw50Gaw9rGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s9Knvj38DMPdEz+bk4qsU+6UGtSdd+O3Ug1OXmIJBjgTkwC/pUHiImPC859IwaZjg
         ESysTejMpPJ/CgoY9Rn5ffk1h/sIy/64ESkZS+JC9Cmi/XMZfDkCgUYED13lN5lOJT
         axvIZo9wDb+AX8Wa1MeMucOjvcOwkage6nkH9BbMuCWjQpfztihz7YvKCVcAAohDdJ
         6Mk7ZNOgeH1BoIhcUpWEDqOw8lmAz1TIN6W/piurPc+7OGBYvUC5v0qbzpfZzoTLmb
         qyv+NRFYTvQRaxSaUXFPfhuP2IQRoR4QYJRIUzbinWnFfYFbs5bdOgOHSCQOx7mHZ1
         MTeRE5sc1ZXkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABFCDE270CF;
        Tue,  6 Dec 2022 19:07:02 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix/revert for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4+CgaxbC0BVlE6h@arm.com>
References: <Y4+CgaxbC0BVlE6h@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y4+CgaxbC0BVlE6h@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b7d9aae404841d9999b7476170867ae441e948d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ed710da2873c2aeb3bb805864a699affaf1d03b
Message-Id: <167035362269.3568.9528218823466957656.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Dec 2022 19:07:02 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, regressions@leemhuis.info,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Dec 2022 17:57:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ed710da2873c2aeb3bb805864a699affaf1d03b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
