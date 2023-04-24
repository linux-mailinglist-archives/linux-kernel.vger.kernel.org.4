Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8616ED588
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDXTtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjDXTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101245FE1;
        Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AA9628AB;
        Mon, 24 Apr 2023 19:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94B7CC433D2;
        Mon, 24 Apr 2023 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365734;
        bh=5pRAvC7HdXEVTLkCRfUYjYWh1KEwyDVlN7WGBeOenJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A3pWt1IfwEUgoLCzdFV3PDPMyJhG5sTsZIH8Gz669dEzUT/E5Wewxd5MFrrzRsW/G
         pe1NXKbiGy44iRkyYhjzIJSoCh5AnobyOYBJotDQ/YwK93+oF4dmxjGsY+RC6nsTuO
         uwYvDNQGCmADub+cAXS92sOcQCM85vd61qXVq1t+zcBSk5seKfX2E+dobI/X1dfGYq
         XrY0CWb9792ykORB4W2gn4kHNX2hP8cqNmAHJSdcRdHdQ131nDqEYp5KvHX76FH2Ab
         cDA7Hk5G4fZupw7tg4Tc9j5yeHst1Su00fTu5wndIzSYiE+v38udKILaDaUqQd3xF6
         r/sB5ruc+bIXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83435E5FFC7;
        Mon, 24 Apr 2023 19:48:54 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230412143512.GA1697547@google.com>
References: <20230412143512.GA1697547@google.com>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230412143512.GA1697547@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git tags/rcu.6.4.april5.2023.3
X-PR-Tracked-Commit-Id: 8ae99857748bece993962dd8d04e096f9e76731f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfb75e842e0ef59fc7bf307e5c52eab215bdb4c
Message-Id: <168236573453.6990.4431806365226838623.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:48:54 +0000
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        frederic@kernel.org, quic_neeraju@quicinc.com, urezki@gmail.com,
        qiang1.zhang@intel.com, rostedt@goodmis.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Apr 2023 14:35:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git tags/rcu.6.4.april5.2023.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfb75e842e0ef59fc7bf307e5c52eab215bdb4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
