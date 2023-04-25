Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67176EE73E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjDYSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjDYSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CECC2C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF89863086
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CA25C433D2;
        Tue, 25 Apr 2023 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445650;
        bh=yoIMSX1bFo4pd+DAjC6STjJ/pBDD+d/FkHyoWytAqNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f4+y5Ms/IDTmrnlqT8PKjS67Ot//rv6CA9bh3sqk21k4vb4TLbT/MMNBHfSFuoNPR
         7bYWn33A+Tua+GYXg5v84kk3klGHReyQV2YZfbLD6dXLxOq9VJAcOca6U56Adm9KtO
         fcDB+7rZNR2zjDcohad/N7IpGyrhXPylxDCNxqzCMp2xcT60DuLPI22bLNhN6BFkDB
         +2yu3CpT+c/PRFZb1uqSTocJiUZzk/4foypSblfgryvBw3JZSbE2e8HkbGK8y+73Sf
         WInjkRCqtPSw9neliklFvB2UqMYzVWmEjwUV6iNGmlp20y0RRYEytK7kFLjj4wRe5h
         HC+tVrBg/zv0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AD67E5FFC6;
        Tue, 25 Apr 2023 18:00:50 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424094816.2034583-1-geert@linux-m68k.org>
References: <20230424094816.2034583-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424094816.2034583-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v6.4-tag1
X-PR-Tracked-Commit-Id: aaee8c7f2a17d2dd015dc97c113c9ea0cc97272a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7301270a29fb3b5b2f3ab73ef63a208e21f783a
Message-Id: <168244565016.10431.15587054641692673832.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:50 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 11:48:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v6.4-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7301270a29fb3b5b2f3ab73ef63a208e21f783a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
