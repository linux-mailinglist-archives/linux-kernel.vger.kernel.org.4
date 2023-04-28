Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526086F0FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjD1Abv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344669AbjD1Abe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97193AB6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE687640A7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E4EC433EF;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641891;
        bh=pA0KPwZUm4/Ss5MtraanmLUm2n7G7D9wxKpT5aoZK1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fn9m88dPzmRVnHQhXuLexIUF/C5DHDNoZh0MyUekZssyay/LQ+NyDKc4ebjbALnS/
         oSK7r/W26wfnhM4chG2sGOMRVENZqy8JHk/80Ufc2CfCMgmoS4HuFgpc89URvAIn4x
         zxK1hrdPng0+jbVWqFU9ince0NYkrbHrIlf9BZfRCEVDM8X/rhmwaDr+JBWcRx3ZBc
         zMvSj6YWzvSF/rJBQubA+22iqE9kcDlJmW7HA2iT8OB3kdVjFatIBjMIL4hKSwYvAO
         gt5uJZKCdK7AVmVSY+g2SKoglLTQO4CpSQ7MNRgqHm4b1MbNrKTPH1QgfQJmpo/wIk
         l+J+AKCxSdZKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 381F7E5FFC8;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <64496919.170a0220.2c3ce.53bb@mx.google.com>
References: <64496919.170a0220.2c3ce.53bb@mx.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <64496919.170a0220.2c3ce.53bb@mx.google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.4-rc1
X-PR-Tracked-Commit-Id: 5239a89b06d6b199f133bf0ffea421683187f257
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0835b5ee8704aef4e19b369237a762c52c7b6fb1
Message-Id: <168264189122.7031.2239672307893180689.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:31 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chunhui Li =?utf-8?B?KOadjuaYpei+iSk=?= 
        <chunhui.li@mediatek.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        John Stultz <jstultz@google.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Midas Chien <midaschieh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>, Wei Wang <wvw@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 11:10:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0835b5ee8704aef4e19b369237a762c52c7b6fb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
