Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFB67F06E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjA0V2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjA0V1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:27:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF41205D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEB92B821EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A47C1C433EF;
        Fri, 27 Jan 2023 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854853;
        bh=0XGYMJnULZ4O9WgCJj1Dd0Kf1MOKMqUWf1OrafF40HE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ktoQsgzsJ9ztczCMSkHFtWUtlooAcCAXkQuhk6cby8A/fvGhUGbW/PdUMHcX4fbiy
         wwTnF12QAgOTHOxdJgunMgaBfVaU3STnpcE82JMIcW9gSUx3wTsMvGrYwyaehFkxFS
         T0N0BRlgBuZRwxupDdotGTCfFa3ynJga7fCkeL6k8j3nnMoo+RN/De5Li8gj0VswZV
         25NxoJ+FKfUER1rBAiDJQAJQOhB+dwQMvHXrl51txu4EzQEsuLUoXWsdzVsMzOGoaE
         g5Vl0TGAMkXX/rI8Fo1uW2oqzpPu/6YicXRLAyblPH84n/E6KFtSu0WWZ0SaU3BZHv
         IYlj3Bda8KZxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90E4CC39564;
        Fri, 27 Jan 2023 21:27:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzuu4xnx6T5v7sKsK+A5HEaPOc1ieMyzNSYQZGztJ=6Qw@mail.gmail.com>
References: <CAPM=9tzuu4xnx6T5v7sKsK+A5HEaPOc1ieMyzNSYQZGztJ=6Qw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzuu4xnx6T5v7sKsK+A5HEaPOc1ieMyzNSYQZGztJ=6Qw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-27
X-PR-Tracked-Commit-Id: d23db89883962d9b4cb3ad03dfd02e525ed2cc03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76e26e3c6a49b368a6fd38e2da2b1b164470cc52
Message-Id: <167485485358.19779.8573236755688332118.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:27:33 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 15:22:36 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76e26e3c6a49b368a6fd38e2da2b1b164470cc52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
