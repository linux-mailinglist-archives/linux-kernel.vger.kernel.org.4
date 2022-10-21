Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E55607F38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJUTnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJUTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967228510E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4916661F6B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 19:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A375DC433C1;
        Fri, 21 Oct 2022 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666381420;
        bh=3nBczJAyS4azwyV3doD0jbuVheC/JebFajimYswHoiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qIg2iEnmx0r9SAj4XYLkINQglwuHK+QscAQL+XvSokkFt2CsSZ/nroMM8QFCBGhCC
         6QUoXoo2JgFY6PkpyW6eRuXkz+WJqlcY4H3fFMEyGB2j2iB03tOJJh0sQoL9DQMTFS
         4MEsB7aIy0mtGWYMkrqfUj6ZIKhDKT8y9AjTkHVdJCdnGVs/MANUN5uf3r95VpqSjL
         keLSELedSwbAiOWmxf75AWjMU6PztYGEXnfOpBvRW1llBLqqlwGFR6FrTMJ4TKkpVi
         rx+dpgYhTmw//ZA76bTBJDWvjL9j99EinzslQ1QiMO+KrCZl7inGlnXDT5tjulbgHq
         nwHctI35K03vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82707E270E1;
        Fri, 21 Oct 2022 19:43:40 +0000 (UTC)
Subject: Re: [GIT PULL] rv/dot2c: Make automaton definition static
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221020170444.2177b0b3@gandalf.local.home>
References: <20221020170444.2177b0b3@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221020170444.2177b0b3@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-6.1-rc1
X-PR-Tracked-Commit-Id: 21a1994b6492b12e55dbf39d15271430ef6839f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce3d90a87776053ec367c0eb083d389e9979c7e9
Message-Id: <166638142052.20847.10948827763161008875.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 19:43:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Oct 2022 17:04:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce3d90a87776053ec367c0eb083d389e9979c7e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
