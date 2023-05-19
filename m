Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536FE709F17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjESScp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A51A5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2C965A5E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAD8AC433EF;
        Fri, 19 May 2023 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521160;
        bh=nZnzf4o0hdcS2FWLzoxcs95T736JnHidWYLpiP5z/uE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JkiVin6xepin6cBHvm8i8ueX50r1ZDzCHu31ON0jU8ogHPoWaYSXVpKO6OiJ6wCEv
         TOCZkGZ7p4P4mbGdFrD31YrbTLvjnodKovkNnVoFw/WuXie6WA/hMhtY9AhaIYcRoH
         t+HAGrm2ICL1jlCYs65Dwj4UeZLSiWF/LV/eWp/zm8inF+S9gKuPW0ZUt5PAcGNJAw
         G96QDhy7AqoWFSq2I8LljxzxMjBYreExJ0lEMR7SphF7T854EveIJdoneOVXuN0vJm
         KYc73CF9jBhKd1rx9OLzwKNu3w61gXB/nYbKSjF0r30yH8lC/67fEEizFA7GGA7iBm
         WgoY0QDIbGn+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9FB8C73FE0;
        Fri, 19 May 2023 18:32:40 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230519114617.GA2588@willie-the-truck>
References: <20230519114617.GA2588@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230519114617.GA2588@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c4c597f1b367433c52c531dccd6859a39b4580fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ffd96c9621fcec3b84f3f997e036cc7077ec465
Message-Id: <168452116075.23824.6429941542628680187.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:32:40 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 May 2023 12:46:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ffd96c9621fcec3b84f3f997e036cc7077ec465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
