Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51CE6DA03A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbjDFSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbjDFSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F67AAC;
        Thu,  6 Apr 2023 11:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2862364B1B;
        Thu,  6 Apr 2023 18:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91FAFC433EF;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806770;
        bh=bW2XJCyfWW2jLuw4+HiXx3ax6IlNZMoMGgWp9IfrkQ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bt9FaqNXxJvqIYR77/o3PqL5ixAs24xMB3HFTL0+JuNvT8NKsQwdLxfFjwHncGn03
         L/x0Lyv0+PgAvG2bqqwyl1gZ+6h3yG8zf1CxLBB2qKiMZh3hgQle6eq1G/B3d0uHWK
         aG9WeECf2BFwO0etCcm8kR2SIsy/2op7DIHkk/knDFfT7kl7n9yr0k41x2xSxckr0T
         fe48kFRdwT9cPlGBQdQ+saDDDWuTe10Pte/dv+hOgjrTQqX4yJxqp1xVXi+Cd/OoB4
         MDez20kQaUBAW/RIU6Czm7BvT0gdUD+fJqHjet18nGh8jdzzAqoLz2Iu3u+wl6OnQS
         T9eh2UdH/230A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C635C4167B;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.3-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <93693a29-ea2a-3e6a-6581-f336abcffc80@redhat.com>
References: <93693a29-ea2a-3e6a-6581-f336abcffc80@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <93693a29-ea2a-3e6a-6581-f336abcffc80@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-5
X-PR-Tracked-Commit-Id: 9a469c6dfab38326f99f105386db84230be09ee3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dfab5237d9f728fab8528a5673d8348996a898f
Message-Id: <168080677050.24406.12240342793320581892.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Apr 2023 18:46:10 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Apr 2023 11:48:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dfab5237d9f728fab8528a5673d8348996a898f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
