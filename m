Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86664A7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLLTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiLLS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:59:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076D193E4;
        Mon, 12 Dec 2022 10:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEC4611E0;
        Mon, 12 Dec 2022 18:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 251DCC433F0;
        Mon, 12 Dec 2022 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670871381;
        bh=AZVOrRSPBZR8eLUwgMVhjtX3aUGhlIJxlQH/IUWUOM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NbFVnaTr8ioQ2fYh4krT7iZ5XKr3AR4ylOa6nHQ1XExtBLsdJqio07QuDJxjmWPSI
         hiAhh0OMgPisGTsJOUlNmzwSmK/qT/ZoHG6dFT7LF6vdYrmd+jGUJ0Ih47caY7BsyC
         Ibfz+0j/ZBJF+YtOsElu7ZbeArtrw2ilB80+yUDYh3mbvMKZqYNAJW8Lx0atL8/Vz5
         RucqazLyMRPm4+ldRX5SLnYKsmyfIJVdQqHFVSeEQTwXbojoaP62sTslazooYIrefn
         mFds20jyCm1DjcMgNlJG6mp5Iz8t/DmWxLvCZK4Uh0Z8jXWAK5rubenmHEohQjSLFM
         vSr1VcCkSQPSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11AA8C00448;
        Mon, 12 Dec 2022 18:56:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.2-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4bbe54cb-744a-eb84-df67-024e01b9501e@redhat.com>
References: <4bbe54cb-744a-eb84-df67-024e01b9501e@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4bbe54cb-744a-eb84-df67-024e01b9501e@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-1
X-PR-Tracked-Commit-Id: b0b698b80c56b0712f0d4346d51bf0363ba03068
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a76117f9fa52afcf244d4f1b8d4ce92f3e5ef99
Message-Id: <167087138106.22870.16742936948537326245.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 18:56:21 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:00:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a76117f9fa52afcf244d4f1b8d4ce92f3e5ef99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
