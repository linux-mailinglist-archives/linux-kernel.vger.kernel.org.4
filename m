Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F6744281
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjF3Sqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjF3Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A333C00
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37FAA617FE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FAE1C43391;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688150788;
        bh=6tYM+D7+nlJa7mc4hFZ6un8MDHhawcy56w9+QPGfdEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iFsj0TsGHE/LNkb6FFORw3Vc1apH5rY7vzB45X+hAfjBPzslWMcWJvuTIXIxtStsi
         a0I0+ygDzNqcNzQLzorp96T20dFxNLiVs9RYB6l7dT/kn5euRgmld5PIO8aPqCLw06
         Yo2ckVBRxHWDaEe2CWawLnPSsXrmu/vPXhemga8TAcpACPpHuossBCJyicSwS1syoT
         tSIDFUhfXM8uFSQmDgqXVkaXDC5K9yhaLtPQWJrZP1RXECzi6FjTSvD16IXV0mtaNs
         Uo0R/EPDgXZ3IVflxfZSKTXfDgPmUMcaXG3a4wzhHdVKXkyOhg18eLLSjcupseFeJp
         hqkBd5LeGBFoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AC50C39563;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628190032.12421bf8@rorschach.local.home>
References: <20230628190032.12421bf8@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628190032.12421bf8@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5
X-PR-Tracked-Commit-Id: fc30ace06f250f79381a8e3f6ed92dd68e25a9f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cccf0c2ee52d3bd710be3a3f865df1b869a68f11
Message-Id: <168815078856.30480.14427877441057805751.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 18:46:28 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Jiri Olsa <jolsa@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 19:00:32 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cccf0c2ee52d3bd710be3a3f865df1b869a68f11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
