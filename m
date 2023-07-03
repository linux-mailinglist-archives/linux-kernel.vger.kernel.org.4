Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7874629D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjGCSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjGCSjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20540137
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B926100E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 592B7C433C7;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688409552;
        bh=chBca2TVZLaQjsrWAR1UrcyJVanW8KIEZrfIlmJiLj4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aASpM8sCWogWLpSCLOoDzT+/hqL847pvjzTEKjbJ7vR2bGzlk5MApoVHEOo/PQ3Fx
         ymXLZdJFa3292wa4aS761mI3XdwlvkNUIril7itnap02ewz5pjYxSrGxYk5pQWEZTD
         c4PAFqNdfAOCkkZNpWkL43Hhfby4gjOAg/Gd/BaPemdnlLOcs5IlYK9hlyon6q/7o7
         yfAsqucDfh1taULgkduvW88LDAQt2+24UvTE5TFVOCs1ln3zG7V3GmDvYqr9HR5Xjw
         V5X1D7GMZ0Y9Dp7qc+juvJXH1X3W5s9QNDtrF1y86nkfQLXtCPn0TrnmqWz4jqDjGL
         wgqb6wnGWuLUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AF80C04E32;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703100501.GA10359@google.com>
References: <20230703100501.GA10359@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703100501.GA10359@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.5
X-PR-Tracked-Commit-Id: b05740d71bd2f8b2261930944bfe95f529190b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8ec70ab66b09ee9e081a38b8625b5accb388176
Message-Id: <168840955222.6002.4172163124625149666.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 18:39:12 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 11:05:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8ec70ab66b09ee9e081a38b8625b5accb388176

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
