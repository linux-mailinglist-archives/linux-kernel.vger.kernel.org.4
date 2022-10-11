Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C45FA9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJKBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJKBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:24:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070D85586
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31754B811C1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD814C43142;
        Tue, 11 Oct 2022 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665451423;
        bh=RI0MtfEk99t7Z1AgVom4PUWvOGqJYU1wJppAPzT45pU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fekLFow9YQ24SsnxL5YNIm6ZwOKWfOcuWjdHrj44b0wZ8H4nUYtvfGPbQFUKcILn7
         WiZHOT187OnUPuFZ6+2MAPsH9zzKpmpwJVyTWUhcNjgU0hHcmMVVOo8gN/DRTyhDvy
         EkqWwf53khnu3Qu6zRD+9w5lORyYKoD3+xYv6Jixi4XTZg/j43EpXDtwXaVhfjXGGI
         0TLTSp7+Sd/qFMs8EuPnqfXfaJ8EiKeEqQtGRrU01jaUXciddGLTkcbsIwt6K6Xafw
         D5fl0ZueMLigOUwSLC7QzW0HkT47e5hdb9qliygLRX7D33gHPtkCCR+RYq6siFDnF4
         dgDOnkaAMIzDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDF21E2A05F;
        Tue, 11 Oct 2022 01:23:43 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f42d43fd-30b0-e661-4b47-61ab15ef76ab@intel.com>
References: <f42d43fd-30b0-e661-4b47-61ab15ef76ab@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f42d43fd-30b0-e661-4b47-61ab15ef76ab@intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.1_rc1
X-PR-Tracked-Commit-Id: c5129ecc12a3101555d8922b1e0aa90f91247ab6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70442fc54e6889a2a77f0e9554e8188a1557f00e
Message-Id: <166545142377.30881.3582945378018188052.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 01:23:43 +0000
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 09:23:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70442fc54e6889a2a77f0e9554e8188a1557f00e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
