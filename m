Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808415F3944
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJCWod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJCWoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:44:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2473220D5;
        Mon,  3 Oct 2022 15:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02432CE0DF9;
        Mon,  3 Oct 2022 22:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD3FDC433C1;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837045;
        bh=z9Uw8PWJspUBdCZc8g8K1qJdpCD9fLjoD/ik1SObB0U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G3rY5tY5nAV1wBk+U9DA+tzkPbAsmhezhkXZa6404i9rZRtGBETXyhKOYBlCuJcxP
         I+8HwJY9BWhyTgDHHeAiHtMSDgJn0qyVAzr6yzqEyJEX2MCtucXDADlHMdP552EGZm
         YncgHprCGhszlIJNJTmLUGn+kj0b/Nd1FPzqkULyn743rtqRxHQ9G0PIud4mv7owr1
         EOhJfvavq+o+JUQEms0CXxEPXJwu0N0m2j5GmCfpXnbQeGrB8+opqZxR/HT1Aa0gHN
         fYnTTsLExD1Qi8k/KfSk5f45ZIBSDqjCJfrrpjIBp3N6NgooevSEPqSLWRxN8L0I6/
         gXHYl+w6vq4UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9501BE49FA7;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iNVCB3PKrquK2RycuZvzQgYz2dODB7hF1jvHm9o3fE3Q@mail.gmail.com>
References: <CAJZ5v0iNVCB3PKrquK2RycuZvzQgYz2dODB7hF1jvHm9o3fE3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iNVCB3PKrquK2RycuZvzQgYz2dODB7hF1jvHm9o3fE3Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc1
X-PR-Tracked-Commit-Id: c8efe77f23d508d62e232de612e739dbf4da4659
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9388076b4cedf199624173b4fcd3f208c02632d6
Message-Id: <166483704560.27150.12969802784565511792.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 22:44:05 +0000
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

The pull request you sent on Mon, 3 Oct 2022 21:54:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9388076b4cedf199624173b4fcd3f208c02632d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
