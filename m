Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC26AAC92
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCDU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCDU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:58:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A8F944
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 12:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0482A60A48
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 20:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69EF5C433EF;
        Sat,  4 Mar 2023 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677963503;
        bh=7aG//NL/0EV3TyUHShGdvjmKEswjWOeBJYkOyTNBuC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NUptYqtztI6HqJnx8bAwJFnL+EB3Axb8KTjnH+y5y7ttd4DKYkjdyREiJ46/+3Jjy
         pEiN58Z4njd818Grha9kWcNpJZqVTKNnYQ5G0sdUVoHADlSXwOG1uEl4pa9KyBtzxa
         A0eSh8Ye92BwXqAmeD6HJOIkRlcBYl/8me97ig0uYlQhUCpMwB1lb0wHriSBboM707
         gDQjbNcZrAeu1IAEOcCVAbH/N5p9Gh2WfhcYASNWliZVH7eqWb/imaCUk9PoF5BYDn
         Mmsk3pPBkgNeMWxLG7Ol7I0HRL/p7TOlJUP4sEU2ph02vawrBmSBEwlmDF/pUwnyzA
         awJQ5ZX+6UZgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 582A6E68D21;
        Sat,  4 Mar 2023 20:58:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8jg1zta.fsf@mpe.ellerman.id.au>
References: <87v8jg1zta.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87v8jg1zta.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-2
X-PR-Tracked-Commit-Id: f8b2336f15f3bc30e37ce5c052cde5b6319bb6df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c29214bc89169f735657f614bde7c0fad74bd1b5
Message-Id: <167796350335.24622.5745677179033135252.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Mar 2023 20:58:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Mar 2023 23:11:29 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c29214bc89169f735657f614bde7c0fad74bd1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
