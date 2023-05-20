Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45F70AA7F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjETSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjETSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875F1713;
        Sat, 20 May 2023 11:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BAE261638;
        Sat, 20 May 2023 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90E6BC433D2;
        Sat, 20 May 2023 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607496;
        bh=aHTfWISuwsLVyApBx6HCOtqOSXqaq6e2Wa9Cs+n1ip0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qq1bYvVZoP8YBGA23dCBH/MdQ8x4BryM5WgvK1PEnakmfSqrWoUgb385Tq3vK0fOi
         sIeqffNuKjUEgrtafmckeFtMOGRseiAAHYhHj/2GiXH3vHui/ye13QQMBxAd/3tGQ7
         BeHLO8BXk3vZIdjxYt5rXXJGraOaBQ8deBfGy2u8H4iiO6EzxoHjwjqM7agDBBzM2D
         Dvrc0vHNA4yQrVkLmIkXsyX7IzmQgSciqv+w7SDrFjW66b0bRMuia46IFKuZcmqaNA
         whlFM1r/+q1G3r9CxDMkfGYwMXXFTQtTCDnbSS5SdZdSiayYOIiIGGYcWCGRPmHtdF
         qmgz6GRwSSnog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81716E5421C;
        Sat, 20 May 2023 18:31:36 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGj-OwflJxwZafmq@kroah.com>
References: <ZGj-OwflJxwZafmq@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGj-OwflJxwZafmq@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc3
X-PR-Tracked-Commit-Id: ddaf098ea779b3c1302c7843f6ff01e89b1fd380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dd0d98d62103c993f74193a7abe97eaef4bc120
Message-Id: <168460749652.29791.8274589072073256958.pr-tracker-bot@kernel.org>
Date:   Sat, 20 May 2023 18:31:36 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 May 2023 18:07:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dd0d98d62103c993f74193a7abe97eaef4bc120

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
