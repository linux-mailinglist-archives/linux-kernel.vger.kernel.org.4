Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880A06F0FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344482AbjD1Abo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbjD1Abd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB893A92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55F864096
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12543C433A4;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641891;
        bh=5djsHgQTS8K6L3HQA0GAAJF4lUWWM1JJdBVuZrvhry4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l85RevMGRV2kCCrmtu1QgPhXYFS9OUOwRX/NKzv1/JXwlu5fnYLQb5b5hzcwnh/LB
         4PTvfpdIKxQO3eDP0hVzsjV/NvXQaT+B0XBLgoUPAvJu2FQFeZJISp5UNfhR5MrjDm
         FFgv+BBauGeQcs/cx7vhDwO7VRRDRnKIljbdP9VDQLScHgdZbdLpeQnoBNb2D7Oazp
         THQQ0NKn2YklKE6g4qVwhIEtxJnoe086s43TNF80TcwePIa9qGnwXJ+EJaQtdGLS5G
         Y6kBvcPHPjWylNHqjlcnAgGzTe23V/Oa2fuQqMU/mWLSI37/aV/BEMJm7ZMNb19n4B
         GRvS1+Cv5iZRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01AC9C39562;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Subject: Re: [GIT PULL] hardening update for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <644968c3.050a0220.78a9e.7d6f@mx.google.com>
References: <644968c3.050a0220.78a9e.7d6f@mx.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <644968c3.050a0220.78a9e.7d6f@mx.google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.4-rc1
X-PR-Tracked-Commit-Id: b69edab47f1da8edd8e7bfdf8c70f51a2a5d89fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 900941bea3f69859c8e4cb17e4fd89c3ff6ade99
Message-Id: <168264189100.7031.3683038339060991660.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:31 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 11:09:06 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/900941bea3f69859c8e4cb17e4fd89c3ff6ade99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
