Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E75E7FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiIWQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiIWQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34B12112D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB575B82444
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E125C43470;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950358;
        bh=dxmbGIxIdFaOcSR4ghPkDz9/NSfj7opcrB5OCi+xoaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tufWcqWayxeATJI/K7yIV1yafrN9pkyD52pjqxlc0JlNQzLGmIZv4vkQ3aLg9sgHp
         eWqyYVvVYA3YG5/RiEN6l7od+Sj+2byp+CqX2U2E/wWJCfChElaqW7EZwrXKpFsa+m
         9vFSBR9l9R1O/fniA3bWc7nBQPFwS4/EOnyeCQS7tnkLnsYunG3nQDwFO3J3y/K8VM
         QyC/7IbjePMKnEWwOvuY18ONA5d7O/HTLf1Z530Mw//4nLt3/bHVqgfBx0dVQf+v5W
         7kDHnPZOIqrx3MNQLdzG2oEX32Q/gwG2X57gojUrbGvbZCB7P0gEDKNSEOrZzIzpwf
         BMUcLeG11ugmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58480E4D03B;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d96d9461-4a76-47d6-8a6c-fe0890247b0b@palmer-ri-x1c9>
References: <mhng-d96d9461-4a76-47d6-8a6c-fe0890247b0b@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d96d9461-4a76-47d6-8a6c-fe0890247b0b@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc7
X-PR-Tracked-Commit-Id: c589e3ca27c9f608004b155d3acb2fab6f7a9f26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7b7751aeb1348a4358724719aac5310597144fc
Message-Id: <166395035835.8411.1458593398657878309.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:58 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 04:23:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7b7751aeb1348a4358724719aac5310597144fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
