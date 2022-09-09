Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313E5B3F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiIITOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIITNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358099E0D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8448620C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 19:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3446CC433D7;
        Fri,  9 Sep 2022 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662750831;
        bh=+v5ng4wmNW3c0sSfOKJuxKTz3QSRCG60yJSnGDdtZIw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=distVyKpEBgIFfla7alfKaHxXiwpZJUGyg7pmHcPWX2DEU8sxYhuZRJqJr1Zj+Brx
         kNILBdtztR0O4M4DXcbuh6p4AKuGNCAZKW9iYzhVIzVi1bjr4j5jHeSkAaJequpSet
         J08MTpsRTYk2J/dHH1bvQy44tGAd1s1Uk3DJET022ywutC+HZZs4YVTJ9m6nLla/By
         5BdCcY/x8576MUdlo9CGZRtamyTzOBbFXbFFAjltfqpPlHT1cYim5RTk6xzIZZ2Fi+
         y489LUksXhIGyPaozU04aTkOQ6umh/FJCV5+RhMJdRhHqvZC4hxl/WHKCVgPWqPFne
         PSVf5ty5Nt9OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CC06C73FE7;
        Fri,  9 Sep 2022 19:13:51 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxuEnRoUlZPzjfL6@kroah.com>
References: <YxuEnRoUlZPzjfL6@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxuEnRoUlZPzjfL6@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc5
X-PR-Tracked-Commit-Id: 5ac251c8a05ce074e5efac779debf82a15d870a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35be05d748a1b82c0bd3f62dafbad859a3bd027
Message-Id: <166275083111.6812.2421240276825496673.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 19:13:51 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Sep 2022 20:23:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35be05d748a1b82c0bd3f62dafbad859a3bd027

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
