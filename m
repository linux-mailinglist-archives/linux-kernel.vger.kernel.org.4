Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1006A2B22
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBYRdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBYRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:33:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F31FCA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 153D960AC7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A1A6C433D2;
        Sat, 25 Feb 2023 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677346381;
        bh=8MFE85bxgIhqvRIBUF0M+tDcYo9Y+UJupt69jMVC4NM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F8v8Oj5jFEroqcgzPwGH5N3VJeMV2M9zJ7/K78AcL+KPE6khVqTgGpp0lt3wXwnFO
         B10FU7rD86baSjKZE4mq8Uh4Sg7AXUmbUvQnsV5VrgqNLRKfF6j5PaZEMI2beNwEI7
         NAixcyfPlsyXoeuw079sr7lYRQVUWR9jeFW/WRA63m1Gg52ZEF7QxYY8qmpIvwV6rC
         LfTmGKCR8Y0Yc19ppjoSZ9hnoRbCTjZ8yvyvdGt4nqvCoEuzGlklYP3OkDC8APooYH
         8HdgV0GU73f5ZZpUJ2qK/RelZUxrYRDliKHob087Lk3SocmuNz1DLtAlD5r4f8LCmJ
         bywQcSWiKr+BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 625BAE68D34;
        Sat, 25 Feb 2023 17:33:01 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222001636.211793-1-dave.hansen@linux.intel.com>
References: <20230222001636.211793-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222001636.211793-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.3
X-PR-Tracked-Commit-Id: 1e70c680375aa33cca97bff0bca68c0f82f5023c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8e473182ab9e85708067be81d20424045d939fa
Message-Id: <167734638139.8970.16002333322552600972.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 17:33:01 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 16:16:36 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8e473182ab9e85708067be81d20424045d939fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
