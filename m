Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511F744280
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjF3Sqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjF3Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E044B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1820617E9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22665C433C8;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688150788;
        bh=DBrkaZpP9Z4M9gmzS3H5eRSfwaftbN4LVboqVydaPDQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BQv06YfzI98Lv0kpWGMQYbNxiimaBAV98vTsm5q/F3CekSpru6kiIF8qVaLWDxu2h
         77QJxysa7kZy07Ep8o5xzGwhKzzMbD4dmERnPDt+jLt5Xyj+VGmodPPmIlsGmMuLHM
         eeewRpWWrOuaaejtfMv4VgXf9uHv79kLeXjGwxauOlPEP4hjdAF841PeTcGZXEQWg/
         9zfBwAn8guuiuB1vlQ5nPuBc52MMKPdpuyCIk/T6AseCDFQNkJcOSm3eGmnfmQPzJ0
         OWEEPla3PBLLOKiGLq5s30Y3wbeK3cYlFA5JMh3e6fhEuFZtIQ3nIvVXssXLMdnHJM
         nT/WteUkoW6Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08370C40C5E;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] Probes update for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628005818.c8df3a79955c7585d979419b@kernel.org>
References: <20230628005818.c8df3a79955c7585d979419b@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628005818.c8df3a79955c7585d979419b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.5
X-PR-Tracked-Commit-Id: 53431798f4bb60d214ae1ec4a79eefdd414f577b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2a6fd45c5c4a5c5fdfe6c57f74f630e61d8d9a0
Message-Id: <168815078801.30480.2331921972632900120.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 18:46:28 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Akanksha J N <akanksha@linux.ibm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 00:58:18 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2a6fd45c5c4a5c5fdfe6c57f74f630e61d8d9a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
