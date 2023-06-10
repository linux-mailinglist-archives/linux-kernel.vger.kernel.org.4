Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9272AEE4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjFJUzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFJUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D02D48
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 13:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E1B61146
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 20:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 885BBC433EF;
        Sat, 10 Jun 2023 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686430496;
        bh=oVz6FABB8DkUP8KXAiwsuRYuq4CNPlhVaaaBIkGvs/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A4wvQjcqy7wnUTgWTOOGTNhG/Bgy3lTLhENmtrWUQM6rweLgfDkXxEfTBUYlKZral
         jcA8BXna0o9+pZVrSlKcunAmSsdDxfkW3kwexgLos7yaeneUC8SBaHZ58ZRGjl6awI
         rgkUSV8ldEmIbDq80c0LJ/JQHV11dOCsHjUP6Dkw4yBZjUhk1m4oz+iakRi+zIV+28
         tVxmprtZAcETbeCYgxMv1Jwv3GjQ8Xzfb8swOg5bnhBVfFAztZcSTqPxwkkKTHLTJH
         zHE0NlSTVwWA2IdH4wm3bNj3vo4dr1hZRuYUJ7prJdZNfLZs9jFRfGr3EcZBY/STW1
         ptD6HyvNyeVMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72491C43143;
        Sat, 10 Jun 2023 20:54:56 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZISLJotNt4Lsk+pt@matsya>
References: <ZISLJotNt4Lsk+pt@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZISLJotNt4Lsk+pt@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.4-fixes
X-PR-Tracked-Commit-Id: 58d95889f3c2064c6139ee94bb0e4d86e1ad4eab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6be5e47b69d8bb7c3dba8d84807624954243c23a
Message-Id: <168643049646.9094.3747084578185940639.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jun 2023 20:54:56 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Jun 2023 20:09:34 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6be5e47b69d8bb7c3dba8d84807624954243c23a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
