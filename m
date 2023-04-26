Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F76EF900
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjDZRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjDZRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068376A54
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44D4631A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45AF1C433A0;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528793;
        bh=CVRcs5GJh90mlatF3oSnG8vY/xCW6GBNDPe4lqI2JkA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nyq0vqFKp4ffexiDJeMwWJRhGJWbisEBCRSSNuQAfQSDhbjSDr6/VN9MM/2qC4rZP
         AmjZ0k/3pmFx+dRn2Xb0n0ev5KTm/DTgTFTiq7tN+ZyjPoLfKTWmc86wwpfLpYhllc
         zZCXrrfRJeA3/66UvFdU3PJj0LiuyJzNkOoRcUPw5FPHRU9QAV1CCfz5L/aK8gCo58
         jS60AW5yooi2ph4ztjganKaAQpf00Mco8Q8WMhMNGJHakm1T8apw5Z1wtLwDBeO5cH
         DCBQ3NmCYOm2YIuuIlm+Oq1Kf13zt+zTVfxetrqx6Lc4GN8sUHFe0M1y/ty2YxQpmI
         nODRRDBmZejaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3560FE5FFC8;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425135044.1100895-1-agruenba@redhat.com>
References: <20230425135044.1100895-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425135044.1100895-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-rc3-fixes
X-PR-Tracked-Commit-Id: 644f6bf762fa903f64c59c2ec0f4d0d753527053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0fcc9c68d1147ca33159d57332b02ca8bac6ab9
Message-Id: <168252879321.19907.8499411321786175819.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:33 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 15:50:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0fcc9c68d1147ca33159d57332b02ca8bac6ab9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
