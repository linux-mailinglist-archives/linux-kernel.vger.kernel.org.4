Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03D365AB2F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAATan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjAATa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:30:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B82AE8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 11:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F400DB80B89
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2A53C433D2;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672601425;
        bh=ohMCezbtIQBRAV5WuTKDDWJnAhLotvcWzSMbDWmFQR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HNwF/uF5Z/XtHV0AMuONZ3Qx3U1+MW7OMJnZJbBWfQzVTlIxJJZDgw9WCqRQFBNI5
         /uE6h968qfGjuZGvsUMBLP4N+gHLln+QPVKkcG0+hXB8KfQxWfRqCylQmL3GWZWcRi
         SVENnT826r9iujWWfkWH4QywqNonbMzUfWiQNnGsWJvQNvKGqZ95kKFj1PEtvr5WXP
         DQ6kxnb7xyOeEqp/D7qBidu4raBeziO6Jq2mdtc9vNFQTbSFNUTHlPZhbL2tQx/64S
         9sIlVT6qpy3j4beQJVYECQmh9ZYeMPP6OBUExDYLuV9ujUpl76vYBQrHV0ahRTGBen
         tbmyxTxVaFNVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3131C197B4;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for -rc2 if I'm not too late :-)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7GDIi18rJ/YgbYn@phenom.ffwll.local>
References: <Y7GDIi18rJ/YgbYn@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7GDIi18rJ/YgbYn@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-01
X-PR-Tracked-Commit-Id: a9f5a752e86f1897c3b377b6b861576a4c1a2ff0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b41948296b76588f5ebaf7cbc5be5c803ece70a
Message-Id: <167260142566.13445.16240168930511041613.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Jan 2023 19:30:25 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Jan 2023 13:57:06 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b41948296b76588f5ebaf7cbc5be5c803ece70a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
