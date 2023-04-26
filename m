Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE56EEC19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjDZBw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbjDZBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275EB5265;
        Tue, 25 Apr 2023 18:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6256324D;
        Wed, 26 Apr 2023 01:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EBB6C43445;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682473880;
        bh=acqbpIfAiXfnoVssaTA8z9WJiLb4LsXb4YlipTF3OTc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pZXP4oYTsO0aOcd4wZ0FqPYUIFsizaoVxvNaJHxB7hc2pwCDokc5lgqFV5HvBp/YJ
         UuLGab8QiOV2/jnqU6GIxP4qI1Ti59p0h+PjmMbue+amV1887rF1+iBPQewExF9MkA
         /dEwWovyHxTmktWKhBIeAR2oJb+Z4aAcjvSpOY06FMl+D8Fm4tgthpnNmE7k9wv/1a
         E+UzGw8PjDvQxupVOstCOEYEXLMDwx6I4lG3dibF7udu4gcgvyqdQ9ku4Zzivp7TDL
         9y3jmrU/0HSsD6flqdXPfjPSeYOYOhdwYvYaoiPxGqMQmCwq+CZld9f39RZJ5AkJNd
         F/6vvQexuODDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C49DE5FFC6;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0htGCiRkSjnOGoQbViuRz==gAN2hwuFtrFK+Y8eNGy=ZA@mail.gmail.com>
References: <CAJZ5v0htGCiRkSjnOGoQbViuRz==gAN2hwuFtrFK+Y8eNGy=ZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0htGCiRkSjnOGoQbViuRz==gAN2hwuFtrFK+Y8eNGy=ZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc1
X-PR-Tracked-Commit-Id: d3f2c402e44887e507b65d65f0d0515d46575bf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cfd8703e7da687924371e9bc77a025bdeba9637
Message-Id: <168247388050.11449.6607428091071832851.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 01:51:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 19:53:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cfd8703e7da687924371e9bc77a025bdeba9637

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
