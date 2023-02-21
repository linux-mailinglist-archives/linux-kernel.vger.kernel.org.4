Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B169E90A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjBUUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBUUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:39:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1650C30B20;
        Tue, 21 Feb 2023 12:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF69611C3;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5579AC433EF;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677011940;
        bh=/HyPy+2JroSCEqh4JE8Cg8Ery5qSfYkPXLPbSmhE050=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u+T3dXSlYVNEJJTjr9I5Lz8UMUYT5TfGtxev2BdFTM4HiUNrW9J523ij5vWdHuAAb
         8Xg3BtbFdQNZXnV6UPNPkOp1i+5JF9qQkF5+PH00t8ZpLXiZ9B3oNUNas/9rPfAlG4
         zrjPOJg78WS5AW79idMec7Kkt/h+psVYJI/YiBYNRYtKsHjtz2n8U4cbf/Ta4+eB6B
         IxNYn8cvMnoQhxOwGoBhFucz55jBVocgZG/uTpnrFwwba6sLo9bp6dWVrseelO0s+B
         nyibYIU8RAPry1MWdLLjywjl6mNfhRe4ftVfasBL+1sscqneZx4bOlJ3fS2dBkovqZ
         Rs4xcZXb8z9lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8D7C43159;
        Tue, 21 Feb 2023 20:39:00 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gvSyhzfvqSZk3qFMMPJ66dJOyk_1Ti-1cMgZFKBtzVbA@mail.gmail.com>
References: <CAJZ5v0gvSyhzfvqSZk3qFMMPJ66dJOyk_1Ti-1cMgZFKBtzVbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gvSyhzfvqSZk3qFMMPJ66dJOyk_1Ti-1cMgZFKBtzVbA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc1
X-PR-Tracked-Commit-Id: f32309c4d08dbac74d3253ac8310bfcad4e21606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88af9b164c7a25a71b1a1a699872b869e2e84c77
Message-Id: <167701194023.12980.13569811268730201222.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 20:39:00 +0000
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

The pull request you sent on Thu, 16 Feb 2023 14:43:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88af9b164c7a25a71b1a1a699872b869e2e84c77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
