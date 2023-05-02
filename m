Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543DB6F3B69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjEBA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjEBA3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3440DF;
        Mon,  1 May 2023 17:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EAD6172C;
        Tue,  2 May 2023 00:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6D3C433A1;
        Tue,  2 May 2023 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682987362;
        bh=R54DymXyUQV3ZZIkDnA4Ry8nOyW2wqPr1hP2+hsX0Ho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MpJEO+PRkk2MB3bA3f8H5pgxtUJ/usMC6TZsTiGnZfnDyC59bf2iBYfXiHJ+ARyAz
         FWi8c6ryfcESvMf13rcWtP6ihBbCVXlJa6m0+x8YkU0K079UN/wg3Tl2Jx39ZG7Q/K
         frq91EGSO/NzJ9B/FIevMOEfAY8hb0SWE14BKqFfLFs9sY+itCtgJAp5Yv21UmYqLe
         SI/64mmXeAU6wAbTAwyVSmhUpV0/+uCwEZjp337eAGxhzgwIF7QRNOw8MC1b6j0A1p
         byS/xoeXeOZ0GffOISFH0JpBwHj8H67XS0+ZnRdspLKATS8PDqYSUGbE1eJclwzDj3
         xO+3aFU3S8A7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A557C41677;
        Tue,  2 May 2023 00:29:22 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.4-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFBKHyTky9YhQv+s@google.com>
References: <ZFBKHyTky9YhQv+s@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFBKHyTky9YhQv+s@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc0
X-PR-Tracked-Commit-Id: 9a87ffc99ec8eb8d35eed7c4f816d75f5cc9662e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 865fdb08197e657c59e74a35fa32362b12397f58
Message-Id: <168298736261.8426.10755077915881781590.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 00:29:22 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 May 2023 16:24:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/865fdb08197e657c59e74a35fa32362b12397f58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
