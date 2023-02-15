Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728DB698823
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBOW51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBOW5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:57:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C6442C9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D04E061DE4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F60C433D2;
        Wed, 15 Feb 2023 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676501842;
        bh=CdpscQtcxVz80seNt/V0xr9r735Cpr0XFqb15Yagb/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qcsi0B2AruRzZfbki7PvrdyDBOtdz9Y8Dwy5XHMMg6vCc8FA3+nqstQqK7GhGvKY2
         TJaEjej8DjZHf4c0y96e3IXmUsS91epK983aLL/bQcqyMnd6NT2RV5PM2gbLpNAx2Z
         KmoRy+ayVZ3Y88WtCtE2E3RJv3Du6PPCpV/MpAvifZaPAQPN2pMY+12GsWnaPiLdu8
         NvJVLuIYKg/NFUoG/O+VmVfvtxE5Loddkw2bYTGIEMYQVEGK3DE9EAaChHTTgSr8m/
         Lobe4DLSxqkdY/k5ajBtAA8iSrRGn+9BaUreu+nZcF4d6+JW9B58c/nG+MQ2EPSqcv
         nGJg6FtmIvzjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F841C41676;
        Wed, 15 Feb 2023 22:57:22 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Make trace_define_field_ext() static
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230213100836.33d2b0b0@rorschach.local.home>
References: <20230213100836.33d2b0b0@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230213100836.33d2b0b0@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc7-2
X-PR-Tracked-Commit-Id: 70b5339caf847b8b6097b6dfab0c5a99b40713c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca5ca227757d7da7f19092bce662b80c74dea507
Message-Id: <167650184212.1740.792489162368856690.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Feb 2023 22:57:22 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Feb 2023 10:08:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca5ca227757d7da7f19092bce662b80c74dea507

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
