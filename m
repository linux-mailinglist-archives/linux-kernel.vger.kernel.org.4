Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE4721718
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjFDM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF2A3;
        Sun,  4 Jun 2023 05:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D2261028;
        Sun,  4 Jun 2023 12:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 825AEC433EF;
        Sun,  4 Jun 2023 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883434;
        bh=3u/XGGpkZ5Ml1h4vMs/z8UQJO7IpHWLNU6pa6n/LujQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qz4ykwcnHBpnNfQ/R72NG7u3PCZHeUAuI6hGlL60lHNGC2kfrEZXsWzOpd5DkENSa
         FuyTgzsg0WRi98U8Gea005HaCSAlR/crjbTJa9NUcPskIcuu1UKqwdMjf8L1C15DOl
         7kcHOfNaPqn9a8FABEHduVcW4dIh17fdP/MuzpXJGPMDdYZyWoX4IOFYdXJOmXrj71
         /FieDAwSGQf1icHB8Iapbt1D+O8IFpX7OgS0IxHgk5vEfEMDHogDnz512PUY5sK+fv
         Rg7XMfz0eEeSJVG+RFdktv3Lxh9eIuZIrCTI3Q4yQBVvPT1247NlS+m4azg7T308qe
         tdTjxcO1lTlqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69311E52C02;
        Sun,  4 Jun 2023 12:57:14 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHxFU2gVcgqYpx6m@kroah.com>
References: <ZHxFU2gVcgqYpx6m@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHxFU2gVcgqYpx6m@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc5
X-PR-Tracked-Commit-Id: fcfe84236ec0974fe92f0578d1d58ed805c4b70f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b435e40256f51f4576c8ab22b88398d21acb149
Message-Id: <168588343438.22483.4117386803497987415.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 12:57:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 10:03:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b435e40256f51f4576c8ab22b88398d21acb149

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
