Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84FB64A7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiLLS7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiLLS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A719033
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95899B80DFD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58FC8C433D2;
        Mon, 12 Dec 2022 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670871372;
        bh=NsvJFvQmJVs3BKfjinqjpAX1Q6kIm+eM5VPOFJwMjuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MUGcPu7ZMgWDMTbCVdRiH7iS6pJSJR0lM2QIws5s4KJ5MMaSLrd7IyN4n8+tIOb2u
         QpVas1RpisFDYgd8hN2dDJQ+IN4tctRbQLrhJeN1fiyu/TOCAKe9QX9FD2/jz1l0Vj
         Gl6bGkOjKY+OtU4RqCEqxN/3Y2eFwrVqoR3CaLyNsCPUyvUMKyUKd6cl/y6XneFlzI
         u9sF4DdICLTGrQttK/CAlrAZ2k4n86JC0VcyTlPt7+89m+IEMS58/kpGQU/fQt+XYy
         XPjsQLY2kkVWDWQ4001koMMdFxk9ZDAurGS+N0SZkTDTKuSdg6WrxgM0RmnGcTvw7B
         d5sxFYa3QUcgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46F5AC00448;
        Mon, 12 Dec 2022 18:56:12 +0000 (UTC)
Subject: Re: [GIT,PULL] chrome-platform changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5aSPxsxWqmkstFb@google.com>
References: <Y5aSPxsxWqmkstFb@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y5aSPxsxWqmkstFb@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.2
X-PR-Tracked-Commit-Id: 9a8aadcf0b459c1257b9477fd6402e1d5952ae07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
Message-Id: <167087137228.22870.1814595782332042358.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 18:56:12 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 10:30:23 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ec5a38bf8499f403f81cb81a0e3a60887d1993c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
