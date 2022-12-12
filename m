Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940B64A958
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiLLVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiLLVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7F1A220
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7190DB80E66
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3733EC43396;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879509;
        bh=7IXJVvlGJCb3tHznQmvdKbssM9cbrzZbcKbLT4bKJf4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BIhJqG9X8EB61Zg3yeP5CITBDy6GcbYPBHuVy+h3FdnrU3CcZGkZQuIV9/fSPgUdp
         jrEoxwlfNhS/cTWyJEtyGkkm/lntwqQH6gMqKT2kKuzUOootxMMjgwxW8RAqZVJDS2
         2CKOUJ/TFuwRkoD+pVM3SxfjL+ApX1ulYs+n/Iv1bQ9oT7BnWRUfedLkZNg8tZx1iE
         /vtvwH6TDvxMqiQS+RBUlSTllO+/0NTQieOyQcoiDdNrSnEjlcAqy6MO0vLZR609VI
         jm6DnFO0P/YLOMo11h3JY5BBc2CyePdyipWWgBHBlun6MCdfudsD+6fvfkvOa+DpBr
         /kAJefcICHLYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24FB8C00445;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908161.564878.1790621826078402593.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908161.564878.1790621826078402593.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908161.564878.1790621826078402593.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-12-10
X-PR-Tracked-Commit-Id: 6f855b39e4602b6b42a8e5cbcfefb8a1b8b5f0be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08d72bd299d08ae019a8a999b95f3e72643a11a4
Message-Id: <167087950914.1809.3744178417526037.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:49 +0000
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

The pull request you sent on Mon, 12 Dec 2022 11:09:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08d72bd299d08ae019a8a999b95f3e72643a11a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
