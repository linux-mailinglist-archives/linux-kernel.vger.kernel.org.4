Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4715610397
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiJ0U7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiJ0U7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6AC06B7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FCC462551
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8211CC4347C;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666903832;
        bh=1A/G3hoV72wGzLvnhEDx66Z918kN0QqQiFrdEeZzkBU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=urA81TrqYowTIwSednPLSNnO7AliZ8Q6+nvxy37hMYlV2457B+bJn5ZnzfjSIq3hS
         CMotCJ8mx5emV3/xV//5TzcJf1mkTMYg9HZxwYaf2THdA55FCJrhaG6ZGv544kLARe
         eDCIAPMriQ+XU7U6ASCOxNDy0yD60RpT21zH6/6EWUzdCulhDyrSCTzRghXpFh8uzt
         BRy8gB67pNPuqya3M81T2Jo0epra+V/GZlEgELv3R3XCFvLBMbyvNWcNDFOCUgJ7Ut
         eNaGk5Z1bmp+ZntuzXvtZR1fXVpJfMfIZkDGypG7vAZNDSRwaxaEp1+Z+TvLTJiyrW
         XJNA6yYpBSXwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EFC2C4166D;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
Subject: Re: [GIT PULL] execve fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202210271208.CBD42E5E9@keescook>
References: <202210271208.CBD42E5E9@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202210271208.CBD42E5E9@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc3
X-PR-Tracked-Commit-Id: 594d2a14f2168c09b13b114c3d457aa939403e52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dd257d02eb31391c3cf06874412322c0943b67d
Message-Id: <166690383245.21870.17977568980012651370.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 20:50:32 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Li Zetao <lizetao1@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Oct 2022 12:08:41 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dd257d02eb31391c3cf06874412322c0943b67d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
