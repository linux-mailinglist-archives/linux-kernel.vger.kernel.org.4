Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E1068012F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjA2Tez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjA2Tew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:34:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DC13DCE;
        Sun, 29 Jan 2023 11:34:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7E22B80C94;
        Sun, 29 Jan 2023 19:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 761E4C433EF;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675020890;
        bh=1pgc2YcieceAZEUNE+ZwUtk1C1vBvvqOpgAi73FoknI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LwxZeeI6g6VQj5VF6g4JBLRfp+g3AHP0sB56q+pH/yPnnfqio6pc1BffhH83KdrhP
         fSCdt0WkBpxW0sxBLogLVadNOHJkFlg6ozh2i2YifL/zH593w9+ISnsX337PtuoqNy
         mmGPjNAcVQr4O44CVcKtm3iJysemGy8usCQcOgovBYQrkykGHpcGmtkBBIQ7unp9mK
         RHCMa8tRAjdDTi8S+YQox020BXjdSLaHEuKb/tl7UlRCoD6nX6ysLbfxhMCTxoJrmy
         ApWwbSq7X78Q9o3J2OuBbdZGewBwl5s6E1kMJFqwtF/AG6P/CHxCO9MfU0rP0wQJJS
         S4W3H8y0bypMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62548E451B6;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9XAv4p0H9aU4+yz@google.com>
References: <Y9XAv4p0H9aU4+yz@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9XAv4p0H9aU4+yz@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc5
X-PR-Tracked-Commit-Id: 9c445d2637c938a800fcc8b5f0b10e60c94460c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80826e9020afc7b8243df302a13521e0020fa9d8
Message-Id: <167502089039.8980.1857518134361632101.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Jan 2023 19:34:50 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Jan 2023 16:41:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80826e9020afc7b8243df302a13521e0020fa9d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
