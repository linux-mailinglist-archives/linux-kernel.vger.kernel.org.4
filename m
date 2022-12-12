Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DCD64A955
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiLLVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiLLVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C41A21B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E8C6123B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4575CC4339C;
        Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879510;
        bh=M8DdZtei9X03yX1XkxPEbL0qosm4G2bPkSZwxrukoLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kX48+RvS4WzHM5avbT0Xq09G/8cFBFUmb6sxrKXqgpAvmTYeaLbET9oGzkvps6Ncv
         lUsIsZ5I6BKb7owDBlIEIxclyDMK3s8+Jz373NGFbY1VsNLXefxhiM5dJhfSGR+pLm
         PKgny1r0KQjxq9068nRirrv90rHMScU1/Cvlbp8gwOYHfqNRVoUCfF/pYiw8kmUzw8
         sC3Ba51rOeDHe/iVMj6SJY93/eozyPGDA7BRabBsEVSxStc8EI/eeCsKMoJzK39BzR
         iAdpMlzOyvQ4af7LIytIYW2iZFoJBnVm0mt/j0b/x1uVks9vpuY8W6sb12c4oJs8AS
         kI+npE3AMaCAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3498AC00445;
        Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Subject: Re: [GIT pull] x86/cleanups for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908533.564878.10400182618682606020.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908533.564878.10400182618682606020.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908533.564878.10400182618682606020.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2022-12-10
X-PR-Tracked-Commit-Id: ff4c85c05333c6f24d3fe0a344c6dacd18a7ee49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79ad89123c2523a7982d457641dd64f339307e6c
Message-Id: <167087951021.1809.17779861595429953015.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:09:06 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79ad89123c2523a7982d457641dd64f339307e6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
