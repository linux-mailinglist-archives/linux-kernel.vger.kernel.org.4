Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD93660A84
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjAFX7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjAFX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:58:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB57D9D1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:58:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0706CE1E86
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 23:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 021DFC433F0;
        Fri,  6 Jan 2023 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673049535;
        bh=lMKFu5xWuSdRIIkmnpI9oHW1WdMDHiHMOnC+rzvj168=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=axmJJlag9IGKwD8ZShDwWKbl8y/HoKYuWoaz5UDqd+6o12m+JfTJJg5j3GTrM8mZo
         0QJmewHxraDRZ6S4RU8C/jMWbXB3IgGFJeU8I0jAGcVCYwuQYfTRa+25xX3ZShyR0R
         oMYJb2NVablQstCdT3T9EHvrGB4WNPm0yjW1mJPwcVpVRzanLAR2JyAcE6v7tWIVrO
         6sNF9td2xPsBVLrgSb4hNaxHPUkbAacKk/uEKD3NPsXTA/G7ulyVeL3dmjBaflz9Qs
         axFAGkeWp+r480FdmzYnLx0PNeWUnpZ4UMh0oZ65Lk6QWrJ4yziTO09tyqCX0P/qAM
         nS1f9yR20XuHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E37A8E57254;
        Fri,  6 Jan 2023 23:58:54 +0000 (UTC)
Subject: Re: [PULL] drm-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7ipHUfN00F3abQf@phenom.ffwll.local>
References: <Y7ipHUfN00F3abQf@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7ipHUfN00F3abQf@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-06
X-PR-Tracked-Commit-Id: 5193326c4c5a656c733b6d2c6537e3f36319bcac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a71553536d270e988580a3daa9fc87535908221
Message-Id: <167304953492.14412.12257948405064175208.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 23:58:54 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Jan 2023 00:05:01 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a71553536d270e988580a3daa9fc87535908221

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
