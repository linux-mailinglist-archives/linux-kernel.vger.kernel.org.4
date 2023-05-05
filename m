Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295DB6F8A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjEEUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjEEUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBA4C26
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFB464094
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E3E6C433D2;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318797;
        bh=3qIuYlnw4zf+GFw/wLLlvIu76TpG3JUDMbPz4LCaoCY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AoledPz2PdtcEndtzLbaD9fPWcogFVmhfSrFJN7yeydHNWTO8IGHBB9Gnw1PosIGw
         F8R7f6/o6MM2tLNtNh14BXh2SG+Sjj9dgpgEA7guqX9sOGP93cMsZHxXx6gET55nAN
         zfjgnnVGOLdn/N7MggZYjeVLg9tWLJsM3ZCoz+hv5KogGE6GMpCNnfUpwXJjHRB+dr
         gT+pDWPv0MIAlQqZ1unVpiYb6aUFIUFraXIAbTwuZVJNZ8ZyX4iO2S9reKkoByoxAq
         Bn3mIPf8xiy0M3/DpfHOlh5mVlIcSxGsBONYY3Lkq/nsHMUc0BUQZqRXoWwR9eX5Rz
         jk6IySLoYognw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A281C395C8;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230505111540.0b2af312@gandalf.local.home>
References: <20230505111540.0b2af312@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230505111540.0b2af312@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4-rc1
X-PR-Tracked-Commit-Id: 6ce2c04fcbcaa5eb086e5142ab359be306cbc3e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e919a3f7057b5ca918dea98826b39a38eff9bebb
Message-Id: <168331879756.21250.14825233444392295398.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 20:33:17 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 11:15:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e919a3f7057b5ca918dea98826b39a38eff9bebb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
