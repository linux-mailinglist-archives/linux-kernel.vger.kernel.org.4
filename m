Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C446888BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjBBVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjBBVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF7244AD;
        Thu,  2 Feb 2023 13:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B35B8286C;
        Thu,  2 Feb 2023 21:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF3B6C433EF;
        Thu,  2 Feb 2023 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675371884;
        bh=K8NJXYsXmDS9UF7umUuvakMU0wKJR7Sm6YQ69fr9zAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R6hUtyihRl97B1Y2dGIjnWtTTlp3v9Ug7y3agb30efzz+qPb7aCUzmPKJBd+OT0g6
         vnNBCiFazbQ0uJ1SLtCIBwT/bN6Pt4KZj6tPdKYBbNy4UHsoE7pjtsB4MrU7H01LKb
         PkpI86WpA7g2Y2bJHz2/ltSBHCC4YrJ5znBNYw6M+RU72nE+0vGynw80k1uCpMoqTC
         wK/IPu8UNlDvjERXoH1PK2jEp9nxz3c5pCb1wqhUzqM0eq5TNijwvyUBxYl94vNDA5
         wVcd8umKXPfXsGlbt+d6fDJbUUdJWk1vQqatixKsI5yV87j4Pya+Z0EVmqjQABuVyN
         tmqz6BCyVVuCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA564E21EEC;
        Thu,  2 Feb 2023 21:04:44 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9wYTnwXVwg/3Dv3@osiris>
References: <Y9wYTnwXVwg/3Dv3@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9wYTnwXVwg/3Dv3@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-4
X-PR-Tracked-Commit-Id: 7ab41c2c08a32132ba8c14624910e2fe8ce4ba4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: addfba11b314824e3b4fb70448b339dcb21be5bf
Message-Id: <167537188481.3773.587859670524329178.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Feb 2023 21:04:44 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Feb 2023 21:08:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/addfba11b314824e3b4fb70448b339dcb21be5bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
