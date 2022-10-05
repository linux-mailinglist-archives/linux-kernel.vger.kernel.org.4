Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A45F5A01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiJESmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiJESlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1880EAC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3223C617AB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEAE3C433D7;
        Wed,  5 Oct 2022 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664995220;
        bh=0nazo7Kim6HmQ49lpJiGVWwOmpCdMNDhJEkRF2Umcpg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bzyLswfspTVsGby+cnhKtFjv8bNlpBrH4MaypB8F+PyrVAAYeqWUq3NjtY0p6aARd
         kQDDwl4li6SnSCLDMFJRR8DFh70Qk4OLlmN/27+OMM2xRId0ZfxCqfxvcdKn/0NPtv
         0X3pjjTHNLWQ56X9fhs2uA6PDV0rHr9WRrnaxbRu/nOk6oXUjycAIdWH/gglZ2cdGU
         /CfeI+VzphQ/tFGyDK1T7M+ORy87+IYfGhQE2cCObDSOtLvS8Ri6qy/Qhy7AizwC4N
         Vh8/DP3YJiivxvzXysCs7lbHElMJctPIoH1nGR8ibh4wkcW/CyZO6M+GJ520ic/DAp
         AtWPMOqcveUTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF4C9E21ED4;
        Wed,  5 Oct 2022 18:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz18QA27+gN0oaM3@google.com>
References: <Yz18QA27+gN0oaM3@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz18QA27+gN0oaM3@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.1
X-PR-Tracked-Commit-Id: e7647de058cba3c05b0d4753d84cbc042d02956a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a47e60729d9624e931f988709ab76e043e2ee8b9
Message-Id: <166499522071.1673.8788051024157593334.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 18:40:20 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 13:44:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a47e60729d9624e931f988709ab76e043e2ee8b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
