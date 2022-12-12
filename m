Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D364A952
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiLLVNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiLLVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ABD1A219
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9212261233
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 031D4C433F1;
        Mon, 12 Dec 2022 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879509;
        bh=Mfg63kZGFMpEqA5SPdwnszenh4/0dziTZDZ7GFXzcxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nlw+mxcEdHiMnfSOSk3N6k5px6fDL53M7wbXLxGNyidKNUVBMpAP7AWJNBcdwNWCm
         eFbtW5380gdcn04pr0mBaLWfVPwCRepjdG/ZfDVOxbCTk6sSmpmPooeRk8huadomdJ
         9xtbJTi61T7TZOtGxhnhIZAvsmnQSEo9idWjLuYRV9XuXYsHFjJp+blPx0pybgt5A7
         MZOLUHZ8GxI3JZIQzyCqetszwxhiSC+cZ6TW8JThzsN4fEaBOnLNldCTISNWVS3M9i
         QTOAwLoNiA+A/n/vzp2YhrovIdskZuL377bEKu0VC5ZXXRo5LaElkCTw6kzTnJbqgk
         rXRXbJHf55PXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA099C00448;
        Mon, 12 Dec 2022 21:11:48 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-12-12
X-PR-Tracked-Commit-Id: 45be2ad007a9c6bea70249c4cf3e4905afe4caeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c2b840a3b446ec2a7fc1cfb68af481905ec6f5f
Message-Id: <167087950888.1809.4051792294426731623.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:48 +0000
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

The pull request you sent on Mon, 12 Dec 2022 11:08:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c2b840a3b446ec2a7fc1cfb68af481905ec6f5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
