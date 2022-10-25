Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7C60D49F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiJYTWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYTWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:22:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD2B0B16;
        Tue, 25 Oct 2022 12:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAEE3B81DA0;
        Tue, 25 Oct 2022 19:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EF67C433D6;
        Tue, 25 Oct 2022 19:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666725719;
        bh=hWmgKuYiXRBbz8jLtG/QsBFDSU/1fVxWBZZlSiPmT1Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rGX9cXJP7cMnZIR+9OLGOBp/xrchZVSZbQkAoaPcPZZo12hm1mV+3zKxgEIfklXL4
         OGvEXighLNdfZbUUgeKpit/kDof3VZzLin9Gpz9SZWC0WJxJZWvpsLmkwK+s4tYXNQ
         u9gQ4rnryBpcbvZ8hBMbtD7Eo/ghZZvVhet599OTFtJy9eD66tUpBvdZ6HoBsPh9XR
         vRG5cecNAhFF+qCf54Jmc/ZDJmg8mDgGHlbAix+yr636Ty+s2s/6G1jfWYpV3s64SM
         o32vyYEBX9uc4g27kvHHB00k5VpWaNf/pHFJ9ge2NNqUHuS8y91QmH3BQZd0F34/us
         qLT42dDr5+wNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D561E45192;
        Tue, 25 Oct 2022 19:21:59 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9256cedf-151d-724b-1e39-fe016fce8a44@redhat.com>
References: <9256cedf-151d-724b-1e39-fe016fce8a44@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <9256cedf-151d-724b-1e39-fe016fce8a44@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-2
X-PR-Tracked-Commit-Id: e9cf4d9b9a6fdb1df6401a59f5ac5d24006bfeae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dc12f37a8e98e1dca5521c14625c869537b50b6
Message-Id: <166672571943.8691.2995875890569106220.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Oct 2022 19:21:59 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Oct 2022 11:52:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dc12f37a8e98e1dca5521c14625c869537b50b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
