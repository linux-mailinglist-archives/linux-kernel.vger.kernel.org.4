Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D59711274
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjEYReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbjEYRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768FFE4B;
        Thu, 25 May 2023 10:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246A66481D;
        Thu, 25 May 2023 17:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEADC433D2;
        Thu, 25 May 2023 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685036014;
        bh=Qx+qUsFj4cZDhapJsSQHSYnYUJ1QlMmEhn+xr0xRgKU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CMRQ2Y1jDmyy+DCuRmUL0SoUygbsSRgu3dowEAkeA4Jo+7y928WmgUcQa3F9oUDfg
         vrrv5i1ItdD7hzxpTcoGRf1pfST59jLdIv7Otuup1Rcs8mLUcBjZbIrDdApjMX6YkO
         SOzDfVzKjKy4Va5WNR6ZUSdc5XTc9Ez1D8i6PCHok/OuYatjomamqXmd35RhBa8XmY
         MafLxlc1KcxOpZCdE6B0VYNwUd3+te47jM8Lpil9RQ8VJOVdoX17GdtPVvW3eMDGIW
         84nzMCSDTCDy7xjyF+25JXBAH32tpl//GTMZTPthtAUO11owBi2VeFQ19ndyXof4wH
         kAKVoyzJhOmkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79ABAC4166F;
        Thu, 25 May 2023 17:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.4-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <941d687d-ef8e-0823-fff0-3011be6c0e0a@redhat.com>
References: <941d687d-ef8e-0823-fff0-3011be6c0e0a@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <941d687d-ef8e-0823-fff0-3011be6c0e0a@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-3
X-PR-Tracked-Commit-Id: 3279decb2c3c8d58cb0b70ed5235c480735a36ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecea3ba2fba2124c8bdc87b27b3829a6015ff854
Message-Id: <168503601447.13926.4307342162500582812.pr-tracker-bot@kernel.org>
Date:   Thu, 25 May 2023 17:33:34 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 12:03:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecea3ba2fba2124c8bdc87b27b3829a6015ff854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
