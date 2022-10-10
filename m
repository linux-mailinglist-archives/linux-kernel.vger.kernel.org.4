Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B575FA6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiJJU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJJU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C65727E;
        Mon, 10 Oct 2022 13:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976EB61032;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 056F0C433C1;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435398;
        bh=s2Ej6XrZFJWQNYQBhzbEoFqG9B/P5d4rZiiqHjCXV7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j/NvsrFHmSZJOTXpXNygoFttOoc1xbntKTOTNTuT91F4baLDgvIS9KDco4ruclNZ/
         668j4b07RGehm6Muwys7THEl2ba7de/Or//0lk2la6Ld9/X2oLgtSclxz5TpQt2eoZ
         s8WawM5TPOUYTtrLIWpiMxpLk+cbtorXhNatyfmAuVfD93YOoT6xpsZo4AHhfk6Ii1
         cWcrbw8lyWfXvPy+VwxpyuS4RyOFlo1ztWb79Igr12rVdw9aUFgLcRxIGPCikBHmZ+
         75UVpayLSLY6+avvn+ZmNGlhwSq21oSVwYQkVj/JH4WOcS+9xvVdtsu3X1jBocVSc4
         9V4PtEYaCwrzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8F61E43EFE;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jxEKB0521TSXqrJj4D0=2Dm+tXe-RxMff-2exxGLcA6A@mail.gmail.com>
References: <CAJZ5v0jxEKB0521TSXqrJj4D0=2Dm+tXe-RxMff-2exxGLcA6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jxEKB0521TSXqrJj4D0=2Dm+tXe-RxMff-2exxGLcA6A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc1-2
X-PR-Tracked-Commit-Id: 056a81549c2722f0e7a9cceb7a98728eb1d67434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a1e24fa70a06ab6b087361ffe90d4cb5e1d059d
Message-Id: <166543539795.11766.9462886223358557510.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:37 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 19:44:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a1e24fa70a06ab6b087361ffe90d4cb5e1d059d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
