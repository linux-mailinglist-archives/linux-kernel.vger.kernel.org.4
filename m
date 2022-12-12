Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC89B64A954
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiLLVNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiLLVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764561A211
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135C061237
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74E3CC43398;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879509;
        bh=CeSmuNmvGm7OU8L342NelfbsCDWDhKqZRcjMxL5xyuY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y5z0AGsmU6OM/Xig4Uj7CKpBOI7a0BFuoyQEGc/cmNdLWwnVDp1Eo6nhVNWjcik+e
         V8EIcwoGU7T3nF0NFxfohqQ8/pc66se+SzG5b1/WxEtpgFytJv8MpaOLKgid/z0lLg
         WHP9Op1b3Szx97XT/GkWgroU86M6pbRhQ/flRlPyj2EKXmwoPmPuvyf7iIQh6AWUXz
         XaCJ96lMJUSnzoXbzzSz5F7l6zAUI7NiS5LjIs1nJW40+uWgLV9yc2C6fHjL3JutYa
         BIV55qOy0jPxcXmKvAwO4h5nSC8TJlxdkMx0YSaxA0bcN85IZSA+MtE0T4KTkSRehf
         cLJ2DXkGtZcEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B55C00448;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908411.564878.10748979729911169682.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908411.564878.10748979729911169682.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908411.564878.10748979729911169682.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2022-12-10
X-PR-Tracked-Commit-Id: 2833275568755eb937a52c358bf8bfa7125a463e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 369013162f7a7aed9e685e4763c3395700e909ad
Message-Id: <167087950940.1809.14805199616943078206.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 12 Dec 2022 11:09:05 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/369013162f7a7aed9e685e4763c3395700e909ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
