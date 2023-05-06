Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C86F92DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEFPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjEFPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39724191D3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D0060EFE
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 15:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36AF1C433D2;
        Sat,  6 May 2023 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683387976;
        bh=pwOrJk2+0tkcWbUlsZVZ+M2wKy6zImeYw1LZseO1W7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mDBR+4xiNXdhb9/sEDJnO0irWLfkocz0UVW+1SqeS5d5mljAyTiv+57LF3hNQ4wh2
         OMCmbuqR2Xg8Gx2U+V/3zl88pNXY+uQYRTwkzM6uoBD3t08VmCPcvHh+p86qq/ahLj
         eB0H3f+RF2dPL8LwdYzuKR7HxGz2aeGjni+BNoofHmDml1CbJ+9QmdJmRWf/InbOyp
         siGMTUVUPjaG3+JU2OvhcemTHi19/bs35dvoncwb1SHeslzTExjYBkLNcbfORnZi+C
         e4DwpmHsJRjrF7opWjF90z72IiJlD7aUZQC85jd8HUoYJZWbJjmnxJOurk+DBQvdC8
         KMOftR5QTe/gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25168C41677;
        Sat,  6 May 2023 15:46:16 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7c6f8881772b1689ba8bc0f9e28ff319.broonie@kernel.org>
References: <7c6f8881772b1689ba8bc0f9e28ff319.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7c6f8881772b1689ba8bc0f9e28ff319.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4
X-PR-Tracked-Commit-Id: 3302212f0384ab286b65683bc340f3953f88f70a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27e0c8461c0aa2454d236924421e1c078cb77f21
Message-Id: <168338797614.28822.15764572642220946858.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 15:46:16 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 May 2023 09:25:38 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27e0c8461c0aa2454d236924421e1c078cb77f21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
