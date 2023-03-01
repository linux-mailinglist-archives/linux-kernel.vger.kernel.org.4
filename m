Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F56A727F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCASCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCASCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BD4A1C5;
        Wed,  1 Mar 2023 10:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF22461453;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 400C0C433A0;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693731;
        bh=bWW/5ozZCHu4rInwKLRJHNLJwrQTWnrL8a4oZTu9av8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ufz0l0E0NO3PNE9EV6PPxgVlygEg6N3thoZH2m37tl04Pe5p6jdg2XyZdI5+mDAoF
         0QSmhYGkC1xNyqksaZFw/TBCU3YyvqSpn+/cElZRU5CBV+XeSC56WHdaF/nO/8wrYl
         EGBjrBvf/Oxk7hbTb+Pr07irbRJrn4tyuIoxY3LzBSLT1mZXUu2wYSp0uGW2HA7IMT
         xQwcGY+vfrtFMJ8nHmFqsN7I8v4l7gQpgABnEsIc/R0sd4h+LIek3j5UzAu4t4DOAX
         croxq9RHDd53MJcKIJWM6NHwVUuQ5KYvdDVYjgjb/JCc5JdeijKXqYA+eMKTP6O3NR
         TCiQFxFGiOnZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E2EBC395EC;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <43b34b98415a56fa5808837ae0d16003c80910b9.camel@physik.fu-berlin.de>
References: <43b34b98415a56fa5808837ae0d16003c80910b9.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <43b34b98415a56fa5808837ae0d16003c80910b9.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.3-tag1
X-PR-Tracked-Commit-Id: ff30bd6a6618e979b16977617371c0f28a95036e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d2aea1bcf68992c90218f47405bee29efd722cd
Message-Id: <167769373118.10213.13124914948263089775.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:11 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Mar 2023 10:02:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.3-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d2aea1bcf68992c90218f47405bee29efd722cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
