Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323446F0888
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbjD0Pkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbjD0Pkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8EA270F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BFA61997
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69EC6C433D2;
        Thu, 27 Apr 2023 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682610031;
        bh=AGcuhYtNzFrux5McXEODTSUU7MEG3cba++PzlNvwJHY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gkkj4uS6Xr5q6sCOPxmK7/6j6Z3UY9DMRscXSv0jEBE5CuYHN1GyUyU6PUm2dTNrp
         bDHspHF2HJWVZatZZULJJk08sm+z7D70EBSmQNzwQAA3l0h7bS6pL9jmfjDuHeblJ+
         TSM/a6XpF1019Kra6vVO+362GmKVgFFBPBSXtd6gWZwS9Z7zcIBdXNnJxXcjI27vOK
         cKlDKqYgHE9IMNL1cPpPvx0kctp2UJ5q981H6I5ssBDph/l3XBM/L/KcvV7G33QsjF
         aQXO3PTowFzM0pvQ59G1gPMvLKlPl3f5bNyWAD5hkbgPSajO5Ms6k8lIieMCaunBf3
         fGxTVddwAhMxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 567E6C41677;
        Thu, 27 Apr 2023 15:40:31 +0000 (UTC)
Subject: Re: [git pull] drm next fixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw2xUZQJkzmt5aj=F8erC3cv9aAB+KqTQgn7=B7D8haFA@mail.gmail.com>
References: <CAPM=9tw2xUZQJkzmt5aj=F8erC3cv9aAB+KqTQgn7=B7D8haFA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw2xUZQJkzmt5aj=F8erC3cv9aAB+KqTQgn7=B7D8haFA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
X-PR-Tracked-Commit-Id: cf03e2956af307dc25e8c41fd4cffe44482a6ec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32f7ad0fbe7521de2a5e8f79c33d46110247fd7c
Message-Id: <168261003134.27650.4473474129707548062.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 15:40:31 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 11:43:17 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32f7ad0fbe7521de2a5e8f79c33d46110247fd7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
