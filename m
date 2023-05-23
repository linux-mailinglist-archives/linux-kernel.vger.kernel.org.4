Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18970CFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjEWAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjEWAqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE084234
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0B8611DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3459EC433AF;
        Tue, 23 May 2023 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684801804;
        bh=8SLIjka9j0UfSy9jb2OdugDq1Rhkh0/hM6dT/+2Q5B8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kyVYo03sYavGuR5wPQJjMGAcyGbsCoTvn2QE/kHLf+ZTWuD5YLJ2OMEtFpO6kJBrR
         qu4vtl14bU1zL67vEoAjhHlSF8ogPpeaMt2emB86/aoePO8tJO99s2kCyCbmBp4fe1
         WVpTwpbbfhVTeUpRFzc0toO6mM6dHBeLrVBNQWXMl/B/xK0+QnEzNpkv0GLm3aO/aN
         CLclp8Ea8i1uJMbEzoPx+daVO6tAGGtl/LsnM9Uq93ZzXYRuhkbBwAtedbNJiTCktY
         HQoiMachEC4qgUa9BDELsXBlKUWJ8ucnG1nxFoRelXJFlGv1QweySkc3MNDPaovFtA
         3xv8qtCe3IllQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1BDBE22AEB;
        Tue, 23 May 2023 00:30:03 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230522231548.1511061-1-dave.hansen@linux.intel.com>
References: <20230522231548.1511061-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230522231548.1511061-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.4-rc4
X-PR-Tracked-Commit-Id: ce0b15d11ad837fbacc5356941712218e38a0a83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae8373a5add4ea39f032563cf12a02946d1e3546
Message-Id: <168480180392.28619.7366740216303666306.pr-tracker-bot@kernel.org>
Date:   Tue, 23 May 2023 00:30:03 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 May 2023 16:15:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae8373a5add4ea39f032563cf12a02946d1e3546

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
