Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9C6924DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjBJRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBJRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:52:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963673967
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D444B82599
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6107C433D2;
        Fri, 10 Feb 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676051575;
        bh=MYPJJIAYtY3MLXCZqs7b4RiPIoahFIRQrSxDm/HhHZ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KvQrNd1kupvv6MEHKWB64YlnKEknso3nCbUlbWtfZ37fNPx1tEcBX3EA9tEZqOEWf
         Rn38zoEB0bbTBOgI8RKjn2XAhDMYq2Hgfr/FHLXKItvyfdF6HsvmdIeBTbVtWwMsls
         nEcTxf5oSTS/yB+eCLunJoecdiMOPDPjoIKAJyiejn++0hgA7lWlcSnECZa0oey9+h
         aWwsNDythqLr6bvAKOGsJpJwVuNMioeBhRwZos8hB82lrHXH6DTYr4I63Af7VUi+eG
         S7e0X/XRjIALzVgFBUHzp9RR9CAehVYNStdzqwbhlcutOg0IoMyL+Wp5L7u2RS2kVR
         cIgQtQFKKxSbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0B67E21EC7;
        Fri, 10 Feb 2023 17:52:55 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-6912c0cd-33ec-4209-8a38-3da4be55fd88@palmer-ri-x1c9a>
References: <mhng-6912c0cd-33ec-4209-8a38-3da4be55fd88@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-6912c0cd-33ec-4209-8a38-3da4be55fd88@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc8
X-PR-Tracked-Commit-Id: 950b879b7f0251317d26bae0687e72592d607532
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e9a8427a1f1f39632e2b2ccd651e499c64f59b2
Message-Id: <167605157584.13061.3796042137852696913.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 17:52:55 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 08:02:47 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e9a8427a1f1f39632e2b2ccd651e499c64f59b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
