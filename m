Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148CD5F3491
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJCRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJCRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABD3913C;
        Mon,  3 Oct 2022 10:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455F260FA8;
        Mon,  3 Oct 2022 17:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A949DC43143;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664818324;
        bh=1gYDXTKcVQuv5amPQY5/ucgOB2m3PNcHB07+rOJATts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UhVi44Nm61lJRz4VibgtDWJKRqDh0e+gO/5Cnd+CbC67CxwNWUSv5mM7wIxsqW5zD
         2z7FHUM+TPr9xrkNEhQeQdhJY8eiD/V2Udn3v6hOlvRv5khQUrhb/cjoQMrRCJMHxl
         0BSJAiU1arKLjh4mVyFWwuJdrNVniMKrcZOhOtDVUSfPo8kC2k7xWHSwQZbKcdx32P
         NGEs1VcjGYoqUeKMhd2pnQOvk/ZC9CYC3RjPkhpaDkAB8lM94TnYAgtkZ+J14Zor5D
         /qa0bc2Qtz+vSxx4yjUMmbDtjCM6HQ/dzLSuoNZXxO9brNKsDZOOL0rOwB/a5b5cFT
         1cqdJ5vmL55Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 975D0E4D03B;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003110533.GA9355@alpha.franken.de>
References: <20221003110533.GA9355@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003110533.GA9355@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.1
X-PR-Tracked-Commit-Id: 90c2d2eb7ab5848c4f853751f12b96bdc460ad1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb443f36f3b9af6a4590b6e65e2d7affdfe0da18
Message-Id: <166481832461.20277.10097702833355192196.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 17:32:04 +0000
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

The pull request you sent on Mon, 3 Oct 2022 13:05:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb443f36f3b9af6a4590b6e65e2d7affdfe0da18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
