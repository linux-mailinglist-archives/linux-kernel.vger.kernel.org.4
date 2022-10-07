Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172B5F7DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJGTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJGTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74FBC612;
        Fri,  7 Oct 2022 12:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C404C61DD4;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93608C43140;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170420;
        bh=vsNMb9cBpVhrMj7KodWqtRcc1KWG2pf9AhUA+Kdbab4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g33S9HO/v4a3rwOakIjg57v8K1dVFzBj08PS1bHEf03RuQOFUZFgWGpn21X/Le0tp
         s7vSEPnfC5Mz8kQa91uZk+MsGZzBWVFkiqS6iDdet16Cj8sCRxLHnexMbqhA9D4H6a
         q5j4MFHJSdtxaO44ju7RtE4hpj0G1SqXalc++e4tYx2I2u2oEYPnUmH+yYPEcZIbHU
         7UCk+RehS8h+ZkPztvIRTXBW5kkaPdlML5WFhJJl1ihOMOzFgOLrWDuBHPpgjV14uf
         ODb8lxJQvQq+WRzu7n28cQTxwGe9E1rF0OP8vzwd0raN7+/4lvxpGc33qOtwAEdreb
         YwJNgEKZZITyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8255CE2A05C;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221006194159.4m7ybf2lduxncc56@mercury.elektranox.org>
References: <20221006194159.4m7ybf2lduxncc56@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221006194159.4m7ybf2lduxncc56@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1
X-PR-Tracked-Commit-Id: 189a2aaef9cbee4cd7c3d1bd142f790cc14c598e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11c747e5a1f908e9e3a868461ba9992e5396402a
Message-Id: <166517042052.8063.9927245137161832978.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:20 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 21:41:59 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11c747e5a1f908e9e3a868461ba9992e5396402a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
