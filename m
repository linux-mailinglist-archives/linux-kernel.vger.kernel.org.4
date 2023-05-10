Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C26FE0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjEJOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbjEJOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A01A7;
        Wed, 10 May 2023 07:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11B56147E;
        Wed, 10 May 2023 14:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 310C6C433D2;
        Wed, 10 May 2023 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683729949;
        bh=1c9fRTUO6iiKYYfXAGntBqMBRbbiwEYSgLK3BzCmTas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PF9RSu488LeTb1YvU5jjwdHg4UB2uoEAyyEZWb+RdMb87CMhJ7vycFPYQVICQafhE
         SD8fAR8cYv6jsJWWpQX3CeYbNq0xSJGwWiNNtKc/Iqumpq1JSJVGx58dN8MjlOq0cA
         CO7ZAdnKxRqZ2lQCWkf8wyklvq3Y/ttwdZDQfqlbzmVcnTpNY4MD5e9doV9iAiwnLR
         qmqt57MidN36wyiUflQdGN8wldkdS+AYPoZwzyI5ivGxq3dgYWdiTgYqbXxXYEpX6a
         NXqnZm7MSyqF7vRuBNs5I9UaOmS92O6HgUOyU98WVabzaLw0Kp4h03B8gW5BnJuU0b
         lbdeP/jiPcClQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20A84E26D2A;
        Wed, 10 May 2023 14:45:49 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.4-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fcddbd63-758f-4e05-c9c5-39a904eebf9d@redhat.com>
References: <fcddbd63-758f-4e05-c9c5-39a904eebf9d@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fcddbd63-758f-4e05-c9c5-39a904eebf9d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-2
X-PR-Tracked-Commit-Id: 3d43f9f639542fadfb28f40b509bf147a6624d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad2fd53a7870a395b8564697bef6c329d017c6c9
Message-Id: <168372994912.27527.744454295935471200.pr-tracker-bot@kernel.org>
Date:   Wed, 10 May 2023 14:45:49 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 May 2023 12:29:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad2fd53a7870a395b8564697bef6c329d017c6c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
