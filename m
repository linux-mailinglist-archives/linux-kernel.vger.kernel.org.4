Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96046EF8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjDZRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjDZRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3367EC5;
        Wed, 26 Apr 2023 10:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3CA6226F;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE050C433EF;
        Wed, 26 Apr 2023 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528792;
        bh=ofV3NUbR0fLH/FdltYXRmA7aAUbxkLpJbK95mAO8GZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DYujjBDAluk165oFg4/hPTdSswXhC5/qtlJ8nJMO2gLgajNbxCS9/VmisNAhcXINO
         wZUtaIZE7ezYfkT+d+dIAGT+hySbF0Mp2OWfo4pJUnvIFP+zKDeMwbXhKkcukx7Coo
         9p4LodPe06a2aDnmkdhPIzEOASNxYytzNMcHxVbRUrCO6e1RFEG15H89dOeJLWuU1w
         11Vx/yThrb8GxILIDPjoewDvohWxdnKvQZkuAGUJ7a5TH2JOnCbFnyxqbC90ocNwe5
         fY4X/bScd7DI3ynu6aBtP8eE5u0SRN+mNn26TmO85sx+Qi+xfjLEMXk7XVtUaR1sI3
         T+mc75ca2QuwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADCD0E5FFC8;
        Wed, 26 Apr 2023 17:06:32 +0000 (UTC)
Subject: Re: [GIT PULL] flexible-array transformations for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEaNFzLag13mLxOL@work>
References: <ZEaNFzLag13mLxOL@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEaNFzLag13mLxOL@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.4-rc1
X-PR-Tracked-Commit-Id: 00168b415a60cec7558608efb4fc50f2a73daae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f99e67a1dc456e9a542584819b2aa265ffc737
Message-Id: <168252879270.19907.8746142034603815070.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:32 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 08:07:19 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f99e67a1dc456e9a542584819b2aa265ffc737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
