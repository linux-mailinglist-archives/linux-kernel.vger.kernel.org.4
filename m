Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11B6888B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjBBVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBBVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:04:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808F244AD;
        Thu,  2 Feb 2023 13:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B644761CB0;
        Thu,  2 Feb 2023 21:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 270F9C433EF;
        Thu,  2 Feb 2023 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675371890;
        bh=kSwZ2DyV687SPcNZ46S0CjZ3eD9kTFUvo4ylxlnr5NM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E/Kn2qOs6Ww6HK12BRyQ4GIxYDxGhW92c9yBlh5d0dMhgP0xOviY7oWtXfCQ5A2YL
         L1y5cAWjEyy6ioTPI9EjGrIskA3LeSdweO+Tw4C8YFnj+SLNuh6iLVEOy818bvkj05
         XdsjtigGdbHMR3U3rHZS6LxYSgEizSAx02YIHrkvqqInGmRL0vf/Prmy0inrC7iJhU
         3hIyP9Vy9D8T+EgbvTepDMe6QQgu3dNOiZAEmPP16o6i8l2uhs+uYodeYNl0r7HQPE
         yMdO/vGUoi2p84eZI7UCandoveVN428ZK2ONm9c1JrIeSKNyvAfsnrXbexIWGsz9iG
         0Jev6xWYowoaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157D7C0C40E;
        Thu,  2 Feb 2023 21:04:50 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.2-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <21c96b2f-92bb-5ba8-c08f-e6df1db4a4df@redhat.com>
References: <21c96b2f-92bb-5ba8-c08f-e6df1db4a4df@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <21c96b2f-92bb-5ba8-c08f-e6df1db4a4df@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-4
X-PR-Tracked-Commit-Id: eecf2acd4a580e9364e5087daf0effca60a240b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 870bb7656ab247c000e9627e0da0db7ef8e9cf0c
Message-Id: <167537189008.3773.1462899791079245373.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Feb 2023 21:04:50 +0000
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

The pull request you sent on Thu, 2 Feb 2023 11:41:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/870bb7656ab247c000e9627e0da0db7ef8e9cf0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
