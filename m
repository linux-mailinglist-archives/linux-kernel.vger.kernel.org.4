Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17964ACA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiLMAwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9BF167DC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE8BB810AB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 280D5C433F2;
        Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670892741;
        bh=EmFhfmuRNhHkhAPXSbQUF1K/bZlxB8YAWyqrYIH9Sz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+Ri2SRpt/1uDhSetLk4E6d/v6a1WCqjBH25tHqNrt2xZKYA0koGKtsD3KwFK5Tam
         juuirCM2WtlSNtX7V/WapImNPnBiIje92oQcAXt/9h1QofE4YisVzUZMyitk64wIaB
         LjwRGX221XZzahyKRCrxD0fcZTf6csF+hNX1ZdJkvt3O5QxcliSqJ3A3WA3B2d2TJM
         P4WFrz4i35ZB8QWSMPK7BjQDAKu0SiFzGS4nlOwCOCFrxziEQmAxQ1IltmGleUD1NA
         FaXCkKHIWfGyJPaFE3MeUxTzDlh4FlycXufQTMofBtQpOqSs2uhvcdC7m2E/f32+vB
         VTyKOpTyqKfrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 128DCC00445;
        Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212184627.3ce2d748@gandalf.local.home>
References: <20221212184627.3ce2d748@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212184627.3ce2d748@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-6.2
X-PR-Tracked-Commit-Id: afc70ccb962861e068e04c6089827493f5160a0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb4511538191ac758faa0735fe06c5ce8202ae04
Message-Id: <167089274107.13252.1720816652782174885.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:52:21 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 18:46:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb4511538191ac758faa0735fe06c5ce8202ae04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
