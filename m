Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762AE64D259
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiLNWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLNWZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:25:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D6E27FCE;
        Wed, 14 Dec 2022 14:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6230761BB3;
        Wed, 14 Dec 2022 22:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C3FC433F0;
        Wed, 14 Dec 2022 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671056719;
        bh=otwWOlEzZxyN99rUEf7ZVvKy/Z75+TX93SgbAyeRPio=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WKJKOmVJEyUVPiJM7mAolCKwiVz58ZU9zwousAxA8FGIFw88SN7hO90UzZa/ZrxYb
         eqLk/I3b3Zu/ZxTOdjRczdA/Aydodc8YvcKg2l2kkBMUR3qk0ZhgBB/uHGc0SoivaC
         FkL2cCCeCdDoIQqbK14gTXfsAqIy3osM4uREzB3ISPNbOJoQWoQrm8FAzTuhVZpz0L
         YNtl1/IbFQSh5oN6zvwrS++WaHfGI6YfQT6TbdtYAvrFInIJ13MmcMXhaMaVLpPDRK
         6GW81q+wdhDWLiDodNiLb3ak1zq0azEEewzk9qNr9dwzd2snVOK74BBgzlDEDwCujU
         2/W10sMQYWhDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B750EC395EA;
        Wed, 14 Dec 2022 22:25:19 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
References: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-12-14-merge-breakout
X-PR-Tracked-Commit-Id: 4295c60bbe9e63e35d330546eeaa1d2b62dae303
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93761c93e9da28d8a020777cee2a84133082b477
Message-Id: <167105671974.22509.5991919513100894698.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 22:25:19 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 10:35:57 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-12-14-merge-breakout

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93761c93e9da28d8a020777cee2a84133082b477

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
