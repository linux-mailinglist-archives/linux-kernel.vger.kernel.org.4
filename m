Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464DD5FBA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJKSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJKSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82767B786;
        Tue, 11 Oct 2022 11:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6D761165;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1517C433D6;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512529;
        bh=O51qB0xMoygeA5NsyroR3G8rUzJYKfJBTzDJQROMGd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n+cs1JsKvxM8BXT+w7auguJiIlchq8l1dZ5ykoFr6lFV78xxWTmbIK07i8pPLrdpO
         il3CDRHeVCmD8WUZa1iDRRkJgwBfFhnW4PhnTztQsVvflNLbI3In82pwPbp65hxBF0
         1tofqijzLqdJ4ySz+WBJED6FVNabP29bDz6ZaA2ShU1qFhIRfspl4et/J/fOYerFtD
         Cyixj1n6yPgvV1ZOieJ4is4Dg/qUXg5vEnv51cZDPqcdQ3rWID9yrksa9UCit2lIdE
         Pap1FWTfJld7bmST38S57yaGR/VjlWLaH6XorQo91S/ZOeHGUhwqMllrKyJ8YssaYx
         MzbGkI/fNgRog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F887E29F34;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0KnIfLe8WxtXc5c@ls3530>
References: <Y0KnIfLe8WxtXc5c@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0KnIfLe8WxtXc5c@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc1
X-PR-Tracked-Commit-Id: 29926f1cd3535f565f200430d5b6a794543fe130
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eec4ed317dccdef610b54224f45e0e1f4fdb75fb
Message-Id: <166551252964.20259.1882299445546237306.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:09 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Oct 2022 12:49:05 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eec4ed317dccdef610b54224f45e0e1f4fdb75fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
