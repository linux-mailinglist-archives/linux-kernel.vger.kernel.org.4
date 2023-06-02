Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001C720237
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjFBMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjFBMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F61AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6230F64FED
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C26AAC4339C;
        Fri,  2 Jun 2023 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709452;
        bh=HY91tQBTBM0+UjI85NT0LNfJo8kJQ1k7j32gkJ6NI/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u9I6lkHji4QuYD/HV/D0oRcKpqcmtswDlmpy6vP3hxPT8IxNKNT8rNBNgArNDdBdg
         KdbXU/nTeb6YHPYqe2K3c053y9keEUDegnhsaqd2YRQfFFVencQRfYRwOYYrF5tVMi
         ztHaLG7SyuP80qorjOtRz6YAWOjCd8p2Ba7O47YKmjmPz2WpirZPIi+yY1G3tVjpbj
         l1IbQ1NlKZK6RxphSy9MiBY37MVxtpeZYUAQ76PVu0pF6puWGLcjKIyQMUSSVfxNRZ
         deNmwHjH+ZjWwTjdLqhIiEAwWAwt5eDtYn2QCkya9xV+c5RypCPLY/LyStAStY+ldk
         B5vZvCBgE3XxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADE26C395E5;
        Fri,  2 Jun 2023 12:37:32 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHmoJ_TIIzruBSIY@8bytes.org>
References: <ZHmoJ_TIIzruBSIY@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZHmoJ_TIIzruBSIY@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.4-rc4
X-PR-Tracked-Commit-Id: b3fc95709c54ffbe80f16801e0a792a4d2b3d55e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bdecc26722710bad806bc583a92881a2fa51c73
Message-Id: <168570945270.3943.7507177544187327717.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 12:37:32 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jun 2023 10:28:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bdecc26722710bad806bc583a92881a2fa51c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
