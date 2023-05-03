Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292166F5F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjECT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjECT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457D768A;
        Wed,  3 May 2023 12:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F5E62EE1;
        Wed,  3 May 2023 19:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22F57C4339B;
        Wed,  3 May 2023 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683142111;
        bh=Zduz0pCn3VSQvd8O48qUit79BRza4G66rgHX/CYCqJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k9ksRZG+3BPLHqMSp7hTIXw788fMGX1i0Y+JpiOTDVnM+8fFjfmDiwEkfqUm+77hw
         r5OvrwglmxboMLkOeEd+fpkUvIKqLFL2VVVCcLH0DqQ3K0cNH3TyqcilSmVY41AZVv
         Rz2BMvnoOJOoYkkqxjtxV2aiWa3GBMbd0IP4M31+jK/xqNrt30RlvIgGn9wCZoqcU5
         TbZ7c79/NrS+PZrUzJFM5XUGeFDhi92EXlESYWVwenJqfw0qJfgAH5MV6fJtMltY4d
         d0dFHMsMK0HC1guo2x//zNzvgF4003HbDyoAinbSavavJbXXWiU+EZXfkflbOa9RHd
         Zh26u2N7t7awA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0413BC395C8;
        Wed,  3 May 2023 19:28:31 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h5B_eC5_2RwWTeD4_y29GDh-aoJmwk7oWQxNJA7GzGBg@mail.gmail.com>
References: <CAJZ5v0h5B_eC5_2RwWTeD4_y29GDh-aoJmwk7oWQxNJA7GzGBg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h5B_eC5_2RwWTeD4_y29GDh-aoJmwk7oWQxNJA7GzGBg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1-2
X-PR-Tracked-Commit-Id: 2e70a47ceafe4d71a4a402b2f7c5123cb4bf33f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0153d8e695255cdf3faa5cfa9f18b57158dc2764
Message-Id: <168314211101.24310.17964985935864125356.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 19:28:31 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:26:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0153d8e695255cdf3faa5cfa9f18b57158dc2764

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
