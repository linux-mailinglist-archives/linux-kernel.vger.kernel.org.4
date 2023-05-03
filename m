Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E36F5DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjECSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjECSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A137DA8;
        Wed,  3 May 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490136303E;
        Wed,  3 May 2023 18:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC639C433A1;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138742;
        bh=s2MHNIyesFtV4x+Mvm/bu4ZRbQQKxxRSdymaqkMJ4j4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m+85Ln6NA5VetI3dGWY9XFLR/9EG7o0kWBuP+gxaLU4xcnmIVQ+DpnikRz9jlbDwA
         2DHyJJxjGanuazWmHYO/k+9GOLhdGnNMbeh/42vuJglZkGXJMc6Mzl44vAUW9Jqh7U
         TZAvHTZ5Glju/2W7jwdQs832dXkqhpizx7RXwjN60JixZag6I8lKnBJr7XIvsVKFau
         mRf7i1LnKSV84zJnrsQQ3uh4pU4bKXUEcFAk3v4y/1cjCpAOW391RYBwE4rV2gUFAc
         UWH8xqNbWI0RqtlY5a+HhpzQfCoQNzJl74SgQzPbRAQu7KY9dle2j9eA7REdPM2yFq
         dDt1jUwTA5VqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98A9FE5FFC9;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503154936.1824529-1-thierry.reding@gmail.com>
References: <20230503154936.1824529-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230503154936.1824529-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.4-rc1
X-PR-Tracked-Commit-Id: 247ee6c780406513c6031a7f4ea41f1648b03295
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89b7fd5d7f3ceda236cc1d0026986a5f57ecaf4a
Message-Id: <168313874262.23026.9747540711137922366.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 18:32:22 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 May 2023 17:49:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89b7fd5d7f3ceda236cc1d0026986a5f57ecaf4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
