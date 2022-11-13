Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF144627059
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiKMQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiKMQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:01:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D680E0D4;
        Sun, 13 Nov 2022 08:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88DDB60B1B;
        Sun, 13 Nov 2022 16:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F074CC433D6;
        Sun, 13 Nov 2022 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668355303;
        bh=AfZEyNM91CdN04YWnK+tyJ60VlxFpCApaQWpbBkPBBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RkKsNZNUefC3jh1HmYD0vQ0dQUwFR420Y3789yV1kyW3vmESnh3iwBAjiOINkqZa2
         QhN3PQG1PgsrriZ5YoqUleLN0Gln7ksqPvUbAV2Dh7tz4NI2LJZa3tiIq2JncLvstn
         omkR8IEn6uxgHd/tzf5LnEkeiYfxdBlYYwbzMCQ6eW18VhgqMGf/1v9UDcvLz0N/FR
         423Hmh6EHVAjv19U/OVQQInSkyTObSIfv7y2a1smwE95Ak1CjuKkw4A0jOk1nmPRgj
         4pEKJapGgIm7paGXda0hC4fjG6zCJfJ7t9aPAEsjsnfiiQM6v1G21NYDcT02Jojp/O
         C690d+PRHQPkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE31DC395F8;
        Sun, 13 Nov 2022 16:01:42 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221113133527.GA3935@alpha.franken.de>
References: <20221113133527.GA3935@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221113133527.GA3935@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.1_1
X-PR-Tracked-Commit-Id: 648060902aa302331b5d6e4f26d8ee0761d239ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af7a056891899fd3942afec79fb219f58271e319
Message-Id: <166835530290.20823.2552251515021890256.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Nov 2022 16:01:42 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Nov 2022 14:35:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.1_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af7a056891899fd3942afec79fb219f58271e319

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
