Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD064A957
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiLLVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiLLVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384931A21E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C88E161244
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A267C433F1;
        Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879510;
        bh=w9YUeUFsye9unQWwyGu6GGmklCTGglajEG4Aub+vRR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WsXT6M0zEQNFw3sBBJNRbW/F4pqhiX3WkT5Gh21B338VEAfzeeswzI1vvYcHiEi1q
         BKVJeo/cb0iaLNWv0w5+PdKNvuIvn3vzdGpApj7h6UjfuXxJje7JJL73AW8SW8shqc
         HmOW+owXkjyCrfSYqsdx9yuVdHafJZiWU2DmtXhYRmo+W+Ybf89+dt/DYN3yO9Mbju
         KsNkneq3+c4Yz1sB4592k5QaYxk5Rm6xxwZH9wqQU0M2fTo5DUubs4InmiyUYrm3aS
         a61+CTHI1624Zl9ApFR9mPNJeaqQILqcEZ6noGURmw5Vik4WjmF/9kpXmUerWua/bu
         dFWiUI7EiVZrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89988C00445;
        Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Subject: Re: [GIT pull] x86/misc for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908656.564878.7729109468817582873.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908656.564878.7729109468817582873.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908656.564878.7729109468817582873.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2022-12-10
X-PR-Tracked-Commit-Id: 00ed1eabcc3b785aecf6f6cbb41d7b436bb54d28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 631aa744423173bf921191ba695bbc7c1aabd9e0
Message-Id: <167087951055.1809.13273454526212393227.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 12 Dec 2022 11:09:07 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/631aa744423173bf921191ba695bbc7c1aabd9e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
