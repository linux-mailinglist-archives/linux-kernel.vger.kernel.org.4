Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6418B73F100
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjF0C4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjF0C4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8311119AC;
        Mon, 26 Jun 2023 19:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63BA260FE7;
        Tue, 27 Jun 2023 02:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4EF1C433C8;
        Tue, 27 Jun 2023 02:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687834576;
        bh=QzGAndb5ala/OezbZU5QtRA6XqWtb+YoTMGRoQ9TcWw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GQyeWbGcS5vbQvJzXl6jOAqUBxAiwngpJTHfMdiyfzcRqy6KXnA+bWBjRwcDg/kRO
         sE6558yC0HQT8ure8vz6uRywNiLVV0Q4OhwcWz/yO+9xs0QnOjvCHmMja4aJNpQD4H
         1qa884Vjg/SY4ccjE4ePwgaxEzJo/2n54cIqzBNBQArvEPHyTfjaBe074UI7q65ZUf
         uMJZDyQHkuGkzEQM9CGVhN1Qiu/acwQOcElLQyZrWQ8eLYwPejflOGB6sKvBTNzX2L
         ueE/UslrcHdAgKFap/sEZ1vkCn84bRwjnkQFubsddKCUuUSOYGnH+4WzvYGypJzsz0
         dyZwLxHdvPmpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9EF7C43170;
        Tue, 27 Jun 2023 02:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h88c==8MP7H98oJo1tzY-i1isuru-axwLpSQ0ouG_COA@mail.gmail.com>
References: <CAJZ5v0h88c==8MP7H98oJo1tzY-i1isuru-axwLpSQ0ouG_COA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h88c==8MP7H98oJo1tzY-i1isuru-axwLpSQ0ouG_COA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1
X-PR-Tracked-Commit-Id: 01fee479846bb13139d339b11e04bf327200cac9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb6950556d4b1dd1226c1f09e84b53cb37e5340f
Message-Id: <168783457668.6991.18423126585588916709.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 02:56:16 +0000
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

The pull request you sent on Mon, 26 Jun 2023 19:18:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb6950556d4b1dd1226c1f09e84b53cb37e5340f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
