Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02469E847
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjBUTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBUT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:29:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E6AD18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45504611B3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC768C4339B;
        Tue, 21 Feb 2023 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007795;
        bh=QrSkTtH+pv+/NrdONqghuJbeZyNqUZHbg1Ub6kHYl1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HVX6Y97zuCSYX3VHiVldzob49ncO89bu+aTb4JNQDVCXL7yNBdXQ8Rh91pthgjPeV
         4riMbMbgsfc5RIsNassdKio86jOoMwkLX4JsD9FPrW3oV+5y6VWVdcmP9E3b9+xxcI
         tKkW1ExLtPlz0fJPhe5wMZhOBNYtnTVCgSIxtqsEi3aOLfklxODNEgZ7ZMCJMJ/EyH
         LkTIH4zY9d7yQ2nYAXfxNZP+pYYHDKkTHkNGffxZkoVqTogls1paKLqgK7s4Ii1pHJ
         v4nFFuGP4K4cKmnESlTwkwTk8o3f0w1M6PHAClMK20+iuDZ/O0pd+CtP5HWN42/jr+
         JicCeL2qw532w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A519C43158;
        Tue, 21 Feb 2023 19:29:55 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp update for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63efd2d6.170a0220.c7721.6d38@mx.google.com>
References: <63efd2d6.170a0220.c7721.6d38@mx.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <63efd2d6.170a0220.c7721.6d38@mx.google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.3-rc1
X-PR-Tracked-Commit-Id: 0fb0624b15d21622c214617fda5c05a203b04564
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 902d9fcd8dccf6a5ccd009f2ae8fec5b3db7f41b
Message-Id: <167700779562.6594.6236594646475971453.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 19:29:55 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Drewry <wad@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 11:17:42 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/902d9fcd8dccf6a5ccd009f2ae8fec5b3db7f41b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
