Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FA5E7FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiIWQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiIWQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F25121658;
        Fri, 23 Sep 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D5562866;
        Fri, 23 Sep 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 896B0C43140;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950358;
        bh=SaVBN2wPZZvxs/uSX2EkysKMNjApJKgynrOmee8hp3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tLfJEyCdpN9KRSLWfLzgHvcB3bA2wO7y1sUyts0kaCeIQhNnX+dCVisce81lF+UaS
         5JJ6cUxz5BdmKOVM3KK0M+l/2+40XnBMQ3UDTux2GJhRKoZqkQYl8025sPO0tT1M99
         Nt9z2qzCDEIY5TUgCzEp+tO9M96lA/aEmmzp6oASrgAoavtu0jgGw0jJFTo8TfAJgh
         Wf326TqEdv75FmyyjXVLtCmg392hvcGyk6YDvRSKVJ0TqtrJSyoqplcADFqsJgyNaz
         2UMGaWaLZNt/pYfFLmcGm1eyIKFXjJY9+vR0IHGI9wGAIfahsAM2o6Y8LebtVESn3m
         V9Nz4D5Zxm83A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76F15E4D03A;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy3Msbnbxhs1OZLD@kroah.com>
References: <Yy3Msbnbxhs1OZLD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy3Msbnbxhs1OZLD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc7
X-PR-Tracked-Commit-Id: 47af6c640ed82f111dbce0b3bf4083a91d61e324
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33a4e37ebc8ccdfe2c51306b1a40d9e7d17b4691
Message-Id: <166395035848.8411.1198487184286067191.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:58 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 17:11:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33a4e37ebc8ccdfe2c51306b1a40d9e7d17b4691

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
