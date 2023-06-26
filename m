Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2173EE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjFZWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjFZWL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DC46AA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847726106F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDE90C433CA;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687817182;
        bh=Y/GeQH6b7mZyyH/ZSeQ9egmRVG3R9f4xfDnHgABLhhU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oSjVFrxEAGDSRqFHvY58yNFzHU1j599C71hZlqIfYwrsBis8vk4Zq1E6ubf59K/RG
         RiCd73aIEPZVLndUBHrkF0/lX+S9ZFFQddPAG+UpJuIOS51C41oCRuYpKniTepi7L0
         eyBDusYHzHnM7Mjy+HGRR8WodFS4zJ9Kbu+cr21A/uJ6YaLAwRrqwFpHfyaHpAarlc
         kj2p5TxxS7wry+P9yWGaEsBahK+MOjXzYRrTEHGVapAB3svHegV43g0/pgZbokEIpP
         LlTKNEioQnulFplXFSkDCxUZKXRNb1iRpZSOpiG2mJz2zoZyye/95/mRVQoJdspSPk
         BDPClXqojcjTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA84DC43170;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168778151379.3634408.18079668842542971614.tglx@vps.praguecc.cz>
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz> <168778151379.3634408.18079668842542971614.tglx@vps.praguecc.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168778151379.3634408.18079668842542971614.tglx@vps.praguecc.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-06-26
X-PR-Tracked-Commit-Id: d2b32be7debd6c0deeae95844997bd89fbe4769d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd336f6562d3d7646a9cf071b902db200a1dd77b
Message-Id: <168781718189.14634.7480825019597060975.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:06:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:13:51 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd336f6562d3d7646a9cf071b902db200a1dd77b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
