Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43474A8FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGGC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGGC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F01BE9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FC961637
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 028BCC433CA;
        Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696868;
        bh=mcZtBTeQkYnDFMADt3lJgU/hohpSZOxYL3gq0/8S8ZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uBctPLW5MBcxUZxERpOGm0kEd2Sq6YUi9afa/EmIu4KHcAcY4Xj4YlnK6Cdf5EUWQ
         5YW1ckg/vAP86R8MIIiTWn+1B8cIv4+0YIUL0UsNF/LuaN92OvS3eQuGhqyXrhO7bx
         RBXOb8laeT1/gY2UrchDIex3IlFkrOBeDZGggG54gWk0KVkNah+batKQOY/zY5uezv
         pgPD9wuc944azafGHm68TpyaKIdCdzd6vsz8agGGhxqs29aTCMFiEatB/gFGKG8j7f
         a/S8K8Shx5Qm3exv0CI/tGsrnNVNg40rMAEjB5trdb5NhTQXM3yPL4F1vmZsZ8AnZZ
         uKbh8lSAqv0dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEC3FC73FEA;
        Fri,  7 Jul 2023 02:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230706103410.6499a3cc@gandalf.local.home>
References: <20230706103410.6499a3cc@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230706103410.6499a3cc@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-2
X-PR-Tracked-Commit-Id: fddca7db4a4c17f7333793dfb5308d80c76d2896
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8066178f530898e4be07406a4c359a2cd14754e8
Message-Id: <168869686790.32373.5879641060365467651.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 02:27:47 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mateusz Stachyra <m.stachyra@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jul 2023 10:34:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8066178f530898e4be07406a4c359a2cd14754e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
