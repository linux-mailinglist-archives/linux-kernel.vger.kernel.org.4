Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B57377A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFTWyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFTWxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF21703;
        Tue, 20 Jun 2023 15:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAC8611C3;
        Tue, 20 Jun 2023 22:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DFAFC433C0;
        Tue, 20 Jun 2023 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687301633;
        bh=18D5H1CVm5fG49x3b5x0COSDfPeJXztZr/SJmmS1t8U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NPeRBXgKLn7zz3VMdMWxTC/pO9pYLtOrxTfwSPMUf9qQgaAwV1ZHCJr+3TDK4sod/
         McgH7cMWE5tI/eDrV03/IxWPTtfz4gHNkkhKEGW4JpT2lvqk4wviklkbU6b4LRVgnp
         ICnjEZok4rp8+o1djS458KKPs4RQOU4jStAeSw+djo8IvN5tf6b9i8jRQFJ0/d9kXb
         /liA6ReAmNbX6mpXdeayQEObL2i+DrRSup6mW1OpB4Q3KwlyaRPIwUQjSrncr8bRVA
         ffIO8pS9Z5I5V0ZSl4yiPK0zLqjJUvhJelcf3r1ieFd1+WoY59H81YTpQ8m28AGmqG
         DwhYX53TnOfJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60590C395D9;
        Tue, 20 Jun 2023 22:53:53 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7dfsyHq14pYkgWAq=chG6WWWEjU1fwe_7OCbyjKKVqA@mail.gmail.com>
References: <CAJZ5v0h7dfsyHq14pYkgWAq=chG6WWWEjU1fwe_7OCbyjKKVqA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7dfsyHq14pYkgWAq=chG6WWWEjU1fwe_7OCbyjKKVqA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc8
X-PR-Tracked-Commit-Id: 22db06337f590d01d79f60f181d8dfe5a9ef9085
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e660abd551f1172e428b4e4003de887176a8a1fd
Message-Id: <168730163338.29619.18364694365099157329.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Jun 2023 22:53:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Jun 2023 18:12:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e660abd551f1172e428b4e4003de887176a8a1fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
