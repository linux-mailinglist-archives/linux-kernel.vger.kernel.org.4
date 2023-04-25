Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101AA6EE744
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjDYSBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjDYSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1015457
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4BF6308B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E8D5C4339C;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445652;
        bh=6jIoJMrSqcodu+I77p+3mEc+8Q9gzZDLdsGCWJmON4Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SA6oYgc2AWLpvZSp27SgMMbnx/I1Ncga3310+0WzBsQHOxbg/QdfT/pGo/wY4J6yt
         7vBdcqbz3DjjTE7xs1HoB20roTkbnYHaqgcVvUZGNCMF7+39XmNF6CgHbOHO6v/1tP
         FQl+eYqaHcgn67qiQ/Vd2aaNAQ0qXdCfu7iIvowbiDmaaszGYlwdTDtlBjZpRP8+ww
         AZK/YHiaUNw0URNQTk/lFlgU2xb8gBBeeZhsLPx23I9BtRlUmc0is+PB7a7Vp8Nvcl
         ETe7lE3AMj44syMUGwtdjtYDE8ZxVjWSF2gZyh7l47ZtUDK2jEQdabWksphAnuqIJb
         Ub6Gcjz5Y4SCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C921E5FFC5;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] x86/acpi update for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424134049.GCZEaG4ZVMddiZTbtL@fat_crate.local>
References: <20230424134049.GCZEaG4ZVMddiZTbtL@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424134049.GCZEaG4ZVMddiZTbtL@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_acpi_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 22767544e9763e82acb60c233051bc426381b61c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1699dbebf31f0b26a8408d24da3c7f3b113f0340
Message-Id: <168244565243.10431.15663423938684316006.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:52 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 15:40:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_acpi_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1699dbebf31f0b26a8408d24da3c7f3b113f0340

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
