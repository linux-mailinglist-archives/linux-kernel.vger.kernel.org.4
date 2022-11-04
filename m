Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC861A4DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKDWwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiKDWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20622554E2;
        Fri,  4 Nov 2022 15:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B6962378;
        Fri,  4 Nov 2022 22:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 549DEC433C1;
        Fri,  4 Nov 2022 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667601997;
        bh=Y0WP8JgTAS/F0y/ZkKGWdKIlTWOq7gBKnMnzDzuDO40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TfEsUo5Zh6T0GNm2EuCGzUi1NGQd3anhZDNCh1pgHXSfd6NdnLr5738/nmsVFesJq
         RLekrQ0nZHdbIYh0KAkhXPGl/S6HjFwwgqEfnWsOfUwkIrQcnFFQ8M/sI/TtSfR/qV
         vybJkxaMcnexZsAd4tXBRKAn44EFb9zvbp+6gMU5Pv13gsPiyidejFKL4ompdF3OOC
         XVAtSj8gBq1UewfVn5PmVVjPXpozcnPdhmApCNd6y57boYRjxF1ldDmy3L34TxLleR
         xPxXi8d3zFfEUXqxzYOHvPOB5/O6nOZc4oQQaA3Ki0k/0kqRUhY0QsCbdrS20dXY5j
         /K9QuSiXVKh+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42F8EE270FB;
        Fri,  4 Nov 2022 22:46:37 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fix for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202211040926.0E7BBDB1@keescook>
References: <202211040926.0E7BBDB1@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202211040926.0E7BBDB1@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc4
X-PR-Tracked-Commit-Id: 6f7630b1b5bc672b54c1285ee6aba752b446672c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd745027438a854e2d7c124032e9ad4aa389e153
Message-Id: <166760199727.25569.10949830136990958125.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Nov 2022 22:46:37 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Nov 2022 09:26:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd745027438a854e2d7c124032e9ad4aa389e153

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
