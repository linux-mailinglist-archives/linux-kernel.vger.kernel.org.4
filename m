Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C026C03A1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCSRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCSRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD41CAE1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 182A161147
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B857C433D2;
        Sun, 19 Mar 2023 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679248417;
        bh=oSLizypeMbRWqOeSSDeOOuLYBsqucTEDj5JtsO4EDIU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UoncVh3vz4sNNBbNvCoEWHGQSbXPk4C3itgETJWDr9RFSi07M6IsmNseNsEltsKIY
         daMKc4Ckn3HvrvOTqngjCGk1qJMvqCG7VcLcLcD5sLQUCz/J76J2ypLpfW/SWUfC3t
         6m4GgBC/4CsLxjzKHIunUBORYnZdtYjuD4CHAxzqcZxzJHIuDBARXpORnj7k00k0f3
         k8Lfd9SfkFAXuMlSg0nPRSnSRRdctXaRvwfksJJyLm5JocmUKjbBxBtmIbNdoBZILg
         NBM3I67LN5R9A4fIY8QE1nTmY/ldT46bC2yvGZ5Z3SWJqTNYE0BMK3EZSsHTYyBPdt
         B8iMvpHzeFrHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A271E21EE6;
        Sun, 19 Mar 2023 17:53:37 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230319134216.26d9dcf2@rorschach.local.home>
References: <20230319134216.26d9dcf2@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230319134216.26d9dcf2@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc2
X-PR-Tracked-Commit-Id: 71c7a30442b724717a30d5e7d1662ba4904eb3d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaba52d63bfcf0047ce3a1bb011b35d4f066df8e
Message-Id: <167924841736.5395.7901517426371557452.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:53:37 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Gusev <aagusev@ispras.ru>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Sung-hun Kim <sfoon.kim@samsung.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Tom Rix <trix@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 13:42:16 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaba52d63bfcf0047ce3a1bb011b35d4f066df8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
