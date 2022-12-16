Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB464F1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiLPTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBB36D4A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D920162202
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 429ECC433EF;
        Fri, 16 Dec 2022 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671220216;
        bh=4lC6hyy9W3zd6RmTX4nvnw17q+Uv/WgG8SmO2EN7qUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z/fzGFp8cGqfso4d5/ghYwwT8AbLvAABhWve4g876wUtkHI9J3mPqbn4NLVioyH/i
         iWx3PhLAVjDQFmoeWADcPHNdn7VNYM+MFe6hTpVMlfF734mnqwuDXmsGG/TWKmUNiN
         vDb6lSPmcRAtugpDuYSxCaBR/a394HVjwDoiHMyKE1wIcNzkQgRh7fAb+AHqkw0xnR
         8o7IO2l6DNXRCkp/BrTG1Y5FhMQcbf93GTPZKbHze7sQTsB/3GgfjiHEwZUU4jz7mv
         pOzpFd/HI+j4dLgryClCCX4KVUOjSOHt2r4rohfpHDYjLfnXktbq1Yz80vSkhxhl/Y
         QL0LFxdgUzZAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C886E21EF8;
        Fri, 16 Dec 2022 19:50:16 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216155111.GA8949@willie-the-truck>
References: <20221216155111.GA8949@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20221216155111.GA8949@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c0cd1d541704c45030cbb2031612fdd68e8e15d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77856d911a8c8724ee8e2b09d55979fc1de8f1c0
Message-Id: <167122021617.13335.8884134192467234426.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 19:50:16 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 15:51:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77856d911a8c8724ee8e2b09d55979fc1de8f1c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
