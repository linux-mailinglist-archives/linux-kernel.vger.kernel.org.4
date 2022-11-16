Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB962C845
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiKPSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiKPSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:53:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94E654C1;
        Wed, 16 Nov 2022 10:51:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA75B81E51;
        Wed, 16 Nov 2022 18:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21FE9C433D6;
        Wed, 16 Nov 2022 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668624687;
        bh=UhNCDZTfECOu2XHFbojTpPYpkhdXTT/+wgxn1c2zwUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pb8KxTM71uHeyFwJNvSEkWKPnZ+PWSgciVP2HIa9424UF3GQBNCgPawQKMyrpkwM2
         mZzXD1Ix8w4zqXCs8OuZAWlx5OoBCu1gPexBhHgvs2mVrIva18rhr7Y2M+a1RK4FMQ
         nAhhQ0qTsVdFwXANW0EbSD7XZSsyZnjUBax5sobMDP/4akJr7sYPhY55kK5lQ9j8AS
         o5edZl7QIegHloDgtTDOkF4jJuPPagj0yXE6F24TjpMgHngzzbCaYOR+7b4mvOx2MG
         g+l3BSB5GdDvqk/YQdlUgdgoVnVH4aYpClxtv3pWmPwSHy0BcjjOmaJuIvu9QrumwJ
         h/Xq2gTHDbp5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02F7AE21EFD;
        Wed, 16 Nov 2022 18:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5e425476-5f04-23e2-03e0-1f8ea57c1a55@redhat.com>
References: <5e425476-5f04-23e2-03e0-1f8ea57c1a55@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e425476-5f04-23e2-03e0-1f8ea57c1a55@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-4
X-PR-Tracked-Commit-Id: b44fd994e45112b58b6c1dec4451d9a925784589
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 941209ef89e3f5e5fd75bffdafe8e74d5c2d4d92
Message-Id: <166862468700.19828.18143695869834816826.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Nov 2022 18:51:27 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Nov 2022 11:48:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/941209ef89e3f5e5fd75bffdafe8e74d5c2d4d92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
