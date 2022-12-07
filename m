Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585AB64627E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLGUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DA4B999;
        Wed,  7 Dec 2022 12:41:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D7861B8D;
        Wed,  7 Dec 2022 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CB10C433D6;
        Wed,  7 Dec 2022 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670445674;
        bh=NC2UMqpJAXmq+uK8tpc2NDg3yDZSH2dJNlYquAJS8/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rMwHZHC82eBay7EC+MLxohK5i1A7+Td/DBGTdOP5ZOX75Vd5PwnYTzici4rdxnung
         xbCOni6aFzkOVr74rY6LwGV71wHUsnucjRkjim3GTNeXT/4ALwA3asBM/7taqnVP3Q
         xUWhd20HLjWcekhrJ4ItPe0cmZojykPoQyWoQ4TtzhN7T1ZgWV5OWa9buKpgVsxrbS
         zICwFrPaKGismvraXDmUOygFcz8xynNOZb1H15X7xUuRCqjihBvZgHf9Ds28uiUpMV
         1+lRLwpgKWx6Q48UyE8DriTX+hkqwDD+5NiMR4QqYF4Ov2+ooAETJ06dndOhDtD9cS
         B06Ml59OPr57Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59F43E29F38;
        Wed,  7 Dec 2022 20:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <de32d340-7723-f980-4519-d8204a14d504@redhat.com>
References: <de32d340-7723-f980-4519-d8204a14d504@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <de32d340-7723-f980-4519-d8204a14d504@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-5
X-PR-Tracked-Commit-Id: e4678483f9bc400642bbc05c6b75a1b44bcb6c25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 479174d402bcf60789106eedc4def3957c060bad
Message-Id: <167044567435.9392.14917065638443786997.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Dec 2022 20:41:14 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Dec 2022 18:23:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/479174d402bcf60789106eedc4def3957c060bad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
