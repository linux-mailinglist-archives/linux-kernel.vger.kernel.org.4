Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5D60BD16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiJXWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiJXWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE729C491;
        Mon, 24 Oct 2022 13:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CFE2B81212;
        Mon, 24 Oct 2022 20:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 210ABC433D7;
        Mon, 24 Oct 2022 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642018;
        bh=Qsye84xGRaBi9tSqB7PN+0CTel2A+AamhqEIPkbkMio=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pUVPc/u2OHDU/o9BK3GwuQTkIOJZ3Ts2hoi9XLZTIi4f5IsMXjELXwwOjGs0DEbDy
         H/RZxgPfISOvOKsQMHfScVOaAA9ImswMl5W1gO2M4DmfsViHVIfSlqSXE1s/qjrLZq
         GUYdI/oXi4Gx6P+E997btDSKiKTQoVfbh0QQb7BlA8ad0vgSF5NbTOdT2J0rBf1DVI
         yyMFqkhAORGNt1XO6wI6/X7ul7QwicOhnO/zp8JUZ+TxczmQSpH6AticvUG71VywIx
         7NAKUj6UWUc2CzZmZ0cYh3dmuYIV+j37DsYqZY7rhZerNCMzqtdrdbcsCCC3cAEJRn
         kXIPbB9pkE3Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DB1CE4D005;
        Mon, 24 Oct 2022 20:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early boot
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.10.20a
X-PR-Tracked-Commit-Id: 31d8aaa87fcef1be5932f3813ea369e21bd3b11d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6602a97a11a3ddc077889fec2c026113c33c670
Message-Id: <166664201805.4311.12142131558870472599.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Oct 2022 20:06:58 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Oct 2022 09:54:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.10.20a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6602a97a11a3ddc077889fec2c026113c33c670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
