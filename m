Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4773D2AF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFYRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFYRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093018B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F3A460BFB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC71EC433C0;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687713809;
        bh=PUARuTIaBfPdzuGx3zlZBdQitfMOyqyJT12MG4qLo5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dZeYORFEwTD2MSDvOUgqf5C0P5vBiQLVaM6GKx2xi6p/NEUYZZNuv9Jwb5WSPf1vv
         6T1m/CLKPAG7xm8qSph1XXmFQ+PDpxgqcWmBzr/z0j67Xy4DdbhxaVAxgMMxv0xHbz
         NVIKrQbUD+M++lMmVYarHYqO18y1Ps047Kf8NM2rsgFsMVBPSSqXQrsBuMQ0QMXqrA
         Sx8x3zJscnK6/Iq96VifdcfCe1BGX1HDWeaKTGrQSXC2U/7kZeL1SJDCPSN1RocEK7
         CdN6R2brmeb9IR+8G8MhmxTojNm6NBRDdxnKau1UhNuWw0jPGQcu0Ef+4/3lSYf/7z
         abayZB1vZ6AGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C19EAE21ECD;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
References: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.4
X-PR-Tracked-Commit-Id: b9f174c811e3ae4ae8959dc57e6adb9990e913f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 300edd751b102715dda0fe44b4bf8442f6ccf9db
Message-Id: <168771380978.13789.15886727880164352370.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jun 2023 17:23:29 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 11:28:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/300edd751b102715dda0fe44b4bf8442f6ccf9db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
