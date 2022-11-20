Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772BC6315BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiKTSxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKTSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D61A824
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108F560CE8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B652C43146;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668970374;
        bh=DL0HzGxNpQo37oGbrR0s3l4XBRoeWTon1FpU1FKywUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m7JRvQku4Ow1wvVCVSxCL3/9mHcbrbUnpYt/tmrFIEqMDYWBKAgb2bb+gVNRXcr2s
         qWrrvHBF5ZdnTgm6HdxxH5Gw+7duoTan6HLyvUDKptEsQc1vGr7dQ5TbfCaBK/chG/
         ug4iZ3/pWSyUyrBnOYkFqwQ1/cbSoWFaKOTj/rK9fBJAuRJtrTLgAFtbuKjNDpepDe
         X/CsXX1mTssd7fyq+vvgNl2hhN6rBU2O2mkxXUKVdpi/vt6jkM1HgnK2iX8WI8x9JG
         5BKksb2qsvrDymgCrWXO3DXAZgGnud+88Jm3moRmN9oF9bkmUHCOfjOOJzONvGT00h
         0xgp4oUbqAcKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 551A6E270E5;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3oao37SUu9tluFY@zn.tnic>
References: <Y3oao37SUu9tluFY@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3oao37SUu9tluFY@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc6
X-PR-Tracked-Commit-Id: 36b038791e1e2baea892e9276588815fd14894b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 894909f95aa1473f49f767dcd5750ba152b85e13
Message-Id: <166897037434.26274.532306354836599134.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 18:52:54 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 13:16:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/894909f95aa1473f49f767dcd5750ba152b85e13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
