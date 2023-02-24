Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD16A2392
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBXVQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBXVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E16F009
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 148C8B81D43
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD912C433D2;
        Fri, 24 Feb 2023 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677273361;
        bh=UCQ5+yrUKQiX0Wgpv8hPDgfqITKwjMENPSTKvcAPR+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LNo0It+7Qdz3fqZ6gYdSUzXnFFT/B+8Zmz6JBN5FlBCYr2pBuHe8UUMTYzdwcHQ38
         89WDW+nNmlH11nv+XFjaVOEDl3W1JlCgUk/S7Nv/2L6ePqVK2QsRL8dngTh07wknN5
         36eaCLAWh4VXr0WoRf+erbhdcBaSsB3AvWmMmdvG+E1XaVZfF6ioINRMWemc7j3ZzM
         M/IJzbQk35w908p1GCE22PIaHr3YV4O+tVhupjDBr7i1TFsZbX6ml4NIN4sIy2iLiR
         rJOOAupfPg9ZHgK9LExwxCUAvHK2x0LOIGqoZP3Tf6pht/oUPGc1COxRO77Ua94Oa8
         k62GN0POGjVuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBF84E68D2D;
        Fri, 24 Feb 2023 21:16:01 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/iy1MgXVLkmtOQP@kroah.com>
References: <Y/iy1MgXVLkmtOQP@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/iy1MgXVLkmtOQP@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc1
X-PR-Tracked-Commit-Id: b5929325f06300d28696b9a030539a4009154788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0601f25d1c4937c678db786961705ce56fbd6bb6
Message-Id: <167727336176.26367.10402166456450454236.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 21:16:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:51:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0601f25d1c4937c678db786961705ce56fbd6bb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
