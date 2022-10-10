Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F55FA2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJJRWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJJRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A74D83E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE500B81058
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87467C4314A;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422527;
        bh=6ndwP/2kjk/bcUCBZJqwPMucDbNfevWevgoNzLuJ+wM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=heBhYcokgXy6sqpJz+kXCfqROG9xCBNcQrUyxoAXsrNDwgmHxK3PwgjxpAHMivDVR
         OnyEiO+CzUgZuwb06ZLNu1v1lA1M9ydjSzdOctee3nd6Wws/VbH1PSGQ031U60kHXt
         DwlCbd/+MOsIUYdbUoHtfXb3yXtn4ErFM5TtsjB8BiXccYwAzXzVsu5GmxbGglaUCO
         jrPh6Weh2+dVFeb9gki/ZDmFZQ99G9r/ReBDJR7NS3Bv4nlbbLJflltjdYhOVfHY2F
         l/fVCtwCGdr2vPwyraqW1tA/8KNgVr6sdiZLtJbcg2ksWBGfJFaGjQaope8jUV0Mmi
         vH3DylgIvh/0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76B4DE4D023;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Subject: Re: [GIT PULL] Objtool updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz/g+0Ar/1z1d7Uh@gmail.com>
References: <Yz/g+0Ar/1z1d7Uh@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz/g+0Ar/1z1d7Uh@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-10-07
X-PR-Tracked-Commit-Id: 7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65f109e19976a833c18820e3950c8f2bb8bd19b4
Message-Id: <166542252748.13651.10927522801827202800.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 10:19:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65f109e19976a833c18820e3950c8f2bb8bd19b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
