Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41116EE873
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjDYTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjDYTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692359010
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0493862A60
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BD23C4339C;
        Tue, 25 Apr 2023 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682451903;
        bh=nHm924/A1tD0lQvfc+IAOcSLLRpDpZBvFCtEqDeWkHo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mq4cl4yVG/pZEC69R3U8l8Vwk2dzpWwaQZABQKFbCN2pJ8GPTt4BeXwObECA6hAk4
         vL3W1EEBBXllDPON5BDlRylgEwK52gawx+d7PY8V3tUca9LcaHbdvxquSTIuC+MTny
         SgrQjknpNfMslHDP5Uam5v7AQGNHPtEN/o7celI93ZpeUQXtfvJq9M6S/ZHLjTlEVP
         ZgIHqb69Qnd/c6dcIIiYQvK3YnN3ng3IBv4usI2RjWdNvCh4s7oSokZp2cJ8ujTLte
         rHZ6fMPDmO/gGzwiNZAKyRbBM6OAYd9JSUs+EEgGkSUMkN5C1glUOW4vJx26Yjm0kc
         ajhha54a2uquQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A121E5FFC5;
        Tue, 25 Apr 2023 19:45:03 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425093218.GA7967@willie-the-truck>
References: <20230425093218.GA7967@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425093218.GA7967@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: eeb3557cc188e42ae7f7bef2d6dc5bf0e078412e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df45da57cbd35715d590a36a12968a94508ccd1f
Message-Id: <168245190329.15168.12636876601228709401.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 19:45:03 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, maz@kernel.org, rostedt@goodmis.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 10:32:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df45da57cbd35715d590a36a12968a94508ccd1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
