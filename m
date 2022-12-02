Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3088F6411A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiLBXpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiLBXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:45:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06937FA44F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:45:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DB362444
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 23:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C9BC433D7;
        Fri,  2 Dec 2022 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670024735;
        bh=pNkJa/Qao5I+mbIzTeSKiP+j4La3PtgbIQs+Wmk91DA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mLtRedAue8IK9CQrY1TXCqnoG6xn198Wwff8Lh3LBSQ/G2TushWTec4Vb851xGdea
         Y+eDC+T35qQPxTF2xF/Ut8VrVLn+Qp55prRW035qBbQZX3m50d7Z/+a4rufAZrPwju
         aNRGvTGobQ3QWgLJm0YKb/9uHhaPAzS2e8uWlJae+qTV3lWLRdgvIwKu1aNBcHfCSd
         JGWZBhPSIn7JAD5mMLD1sZxLBymcruXngIwZw4KF3gEpbWxf6VO1EzgAaVtWjLx+ls
         8cm/PmkiW9iLyWGVHI6ij8UftIAm196YJwnREbJZMgtD8r8ZX2N02CChDE35rS8mCt
         RGZSrvIMLFfBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E969EC395F5;
        Fri,  2 Dec 2022 23:45:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzKpUGHMEw3aN43b+P3+WwAtZGia190JktnB163TvVjCw@mail.gmail.com>
References: <CAPM=9tzKpUGHMEw3aN43b+P3+WwAtZGia190JktnB163TvVjCw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzKpUGHMEw3aN43b+P3+WwAtZGia190JktnB163TvVjCw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-02
X-PR-Tracked-Commit-Id: c082fbd687ad70a92e0a8be486a7555a66f03079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c290db013742e98fe5b64073bc2dd8c8a2ac9e4c
Message-Id: <167002473494.10636.17514527635123501904.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Dec 2022 23:45:34 +0000
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

The pull request you sent on Fri, 2 Dec 2022 11:44:43 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c290db013742e98fe5b64073bc2dd8c8a2ac9e4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
