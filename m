Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD9611E68
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ1X5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJ1X50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518B59251;
        Fri, 28 Oct 2022 16:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B34A3B82DDD;
        Fri, 28 Oct 2022 23:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5910FC433C1;
        Fri, 28 Oct 2022 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667001443;
        bh=stwXUVWiYszaeox1+Fx1wt+zzqcan7l4R1cBxTzila0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mwi6njBQcLWSw+KaRdjMSrYsEkYsfGGnq6YumFl4prvoA73IRNsRDT3IKCaOBf9pS
         IDypU7rN0jZVTmlCCFMO7Y0QMcIg931OJNBa+dMss3RtwYE6zdBvXMOwh5mm2fjEhE
         DX3a7aIQwyougV83GmZcNOZz8V7cpYYG9hiRGxtfj2cVF2A784Qiow2mPw1vBE2j1+
         B8u3poAPzr4z7Lx198SinK2NLI0NbNeQpwRF2OcyByW3vLAIgLeA1MXFnJtj0H+1cd
         m9ww8WxCPvp3/J+g5QwGoRbkTFvYkV3AP4q6W/Meg1w20tTtRamauxcwzhlNCqfFh3
         WTbyUGet1wHeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A96CC41671;
        Fri, 28 Oct 2022 23:57:23 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI and device properties fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hUPC_+d71tWx5S-sQQS3oc59mqmNFxhpiqozfMn44i4A@mail.gmail.com>
References: <CAJZ5v0hUPC_+d71tWx5S-sQQS3oc59mqmNFxhpiqozfMn44i4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hUPC_+d71tWx5S-sQQS3oc59mqmNFxhpiqozfMn44i4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc3
X-PR-Tracked-Commit-Id: dd183e320524f076a765ec441193deb90bd53836
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13f05fb219d528d0352340106967b126c99209f5
Message-Id: <166700144323.1674.15828836014188135986.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 23:57:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 17:20:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13f05fb219d528d0352340106967b126c99209f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
