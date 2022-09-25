Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525E45E9093
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 02:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiIYAwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 20:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiIYAwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 20:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAD40E3C;
        Sat, 24 Sep 2022 17:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDEF60AEB;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D463C433D6;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664067170;
        bh=Hvs1QUukH+qLqqh/cHfKigmnb3q5kQy/7O3VICf76x4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BAwhnaihhoZbcpAY68wnIqtfw9ye+cRAK5at8Hf5QC39FyoxxuWK/qpSw/dOzwh4l
         2jd44+Vsen4unH4njmd2F/RZRkYkYU8u093uj9N403Y0vdBAVA8bwn0kwv5T9EOzbQ
         217gkOxvITZmC04ouLS72J941TIHjLPYvBUbVe0p4z51mPbLgm9PPYSvq7v0Y6dFMy
         xJosSrve4FZo/i8rE3oC0dQIpF6tfghYPPOTQ5Ab1hFxO+b+iW0f29YjkxCFIlUMu2
         e2i199S1EKvxblSoEPMcqXEdB1MLb9pKWUFGW2INlKOkkDkdPiEiHaZ5LxUvxfrwPi
         PjRBRkqKFF2eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43419C73FEC;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01664035808-ext-9945@work.hours>
References: <your-ad-here.call-01664035808-ext-9945@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01664035808-ext-9945@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-5
X-PR-Tracked-Commit-Id: 1918f2b20c3de73ef6f644979896e20a2e7dbb2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23b99237f86df34cbcefa81d1fa45bc316b4a124
Message-Id: <166406717027.14733.4589444944005345403.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Sep 2022 00:52:50 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 18:10:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23b99237f86df34cbcefa81d1fa45bc316b4a124

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
