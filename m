Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990416D293A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjCaUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjCaUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CC2221E;
        Fri, 31 Mar 2023 13:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A35E62BAC;
        Fri, 31 Mar 2023 20:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C18C8C4339B;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680293696;
        bh=DlhW60BD4UZiP4phRwz6dcRyU/W7L20PAJ1YJbzEkfs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eSLzuX60AcG6MYvQA57TSSr1qC2Vmksm1NbiXd4ZXQgn5Nd7lG9BQMSofrSzIy2sj
         SDRUjnSWSUaFOqXuQWHGELeCTHTGVxavk185GHzg1eRyhOI3w/O6AP5jU/+uChqbwU
         3UJGBZaTI0A0aKQiTciDVtr9dUFtTRMGU/BSR8RANp5cVp+JoF0rt18q0y0F6hCm+Y
         H9ww9HTmHla3hKzuhEeS5n1XLbkghioOnWhlgfe/4wGSnS7DBC7IyZMtcebnEsExrQ
         hPd39R46hh0q8yIvAZz+xS5u/k3edjqhHXNJGCPUBQJ3tDU1ZaE6kNpAn3tYxI6rDb
         K3y1JEiFhylhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9103C0C40E;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.3-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <531dfb17-bdc6-00a2-cbf2-7a7c096896b0@redhat.com>
References: <531dfb17-bdc6-00a2-cbf2-7a7c096896b0@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <531dfb17-bdc6-00a2-cbf2-7a7c096896b0@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-4
X-PR-Tracked-Commit-Id: e3271a5917d1501089b1a224d702aa053e2877f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a57b48fdfcb1e196292665d87fac46180344f8a
Message-Id: <168029369668.23236.5733329661761586569.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 20:14:56 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 21:06:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a57b48fdfcb1e196292665d87fac46180344f8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
