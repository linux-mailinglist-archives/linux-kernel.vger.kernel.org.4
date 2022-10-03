Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EB5F348B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJCRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJCRcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE093473E;
        Mon,  3 Oct 2022 10:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14D06118B;
        Mon,  3 Oct 2022 17:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DFA4C433C1;
        Mon,  3 Oct 2022 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664818323;
        bh=oLioZC5I3aGM/pQZHcXFE92TQuGyYzqkbp8zoSYAMpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SRjKbKLDRkg1zSWUoIVutAlUIfFaW/zTpKmAIVTdg2UyzzDYYUgmQP6d9x/lHiFNF
         Ou2rTnXltHGSdvRbTf9rtNPpFzKjrKPBghuqexl0TbHb0XU2MtdDjIDdIT3PesBZ1i
         EMlSrjWrS5ZxD0OLC5UrMMzIm0tgmLcuQRmbCS2ERTrwZShovM2eYQDBsHWvnZcxhP
         p/Kp/Os6la2u8ULocCp/o4jlfPAo82M8WSUVdo9o8GL87rHr4cFCy5M6RpiUmgRMtR
         0zQDGvNJ4QG+TVxltY4NNr8B2w36wIixVRW4FVl/8jqGIDYOLGKvSZC6or7+jhX5Ws
         CwU01mqotRwWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CF73E49FA7;
        Mon,  3 Oct 2022 17:32:03 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221002031046.GA3511311@paulmck-ThinkPad-P17-Gen-1>
References: <20221002031046.GA3511311@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221002031046.GA3511311@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu.2022.09.30a
X-PR-Tracked-Commit-Id: 5c0ec4900497f7c9cc12f393c329a52e67bc6b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 890f242084c9eac18ef87031d95e0bdbaac01ed4
Message-Id: <166481832317.20277.4586977687545362756.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 17:32:03 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 20:10:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu.2022.09.30a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/890f242084c9eac18ef87031d95e0bdbaac01ed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
