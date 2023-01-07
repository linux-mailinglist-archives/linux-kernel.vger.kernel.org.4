Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29B566111D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjAGSn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjAGSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:43:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C1482B1;
        Sat,  7 Jan 2023 10:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE8A4B8047E;
        Sat,  7 Jan 2023 18:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BD03C433EF;
        Sat,  7 Jan 2023 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673116994;
        bh=lO+8nKwwpkplhTTxETgrByL5PkQP6+5zIFvNzeZ+2B8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iHiKYp+0zgxLbTS1DYDpR5Bs9W4hh6m8aZCZbUwy8OmQCNDYrq+D5IVQ4nCtyVpHR
         YcwPNd66u3KaQr6iRV5dVzZTMyAVnpPeCQjlSaoKTbtW3asKN6a19TYToZY1Fhl1+y
         KQUqFdjq02zZc1IdaIQrXRhG9Y2PUF85qbYkDv7TcsUa3x9L5kuNLEve6okW13TFmh
         t0PAGkSYznHH2b3vl/5eIRIfn+4JCf2365htOXgP7bqPBliBvOi6VhZxuacD/DFuIR
         kdbD26Clx+4nhUv9koACm56YD1cR948HrTWcCQwZsBbkdbWl6rKUxxsmTLmsf1iyQM
         joTFUX0+HR34A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7973EE5724A;
        Sat,  7 Jan 2023 18:43:14 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7mSX5PfJ/2wEere@kroah.com>
References: <Y7mSX5PfJ/2wEere@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7mSX5PfJ/2wEere@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc3
X-PR-Tracked-Commit-Id: c4e3ef5685393c5051b52cf1e94b8891d49793ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c28bdeaf5d723b40c8e2901662f4e8acd574e839
Message-Id: <167311699449.9095.15081130767725849026.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Jan 2023 18:43:14 +0000
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

The pull request you sent on Sat, 7 Jan 2023 16:40:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c28bdeaf5d723b40c8e2901662f4e8acd574e839

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
