Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64901650D47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiLSOaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiLSOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:30:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA19EE23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E40F60FBF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AF3BC433F2;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460209;
        bh=z/jcoxjea/Y9MNo9lMokc6Ln6nqiejVKUnSpylmGYC0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qj7nAFkWL/kUVlGjTFNNNcKsfNW8fFFY3gYiPQLzDgmGCD2pZytFhd6aHXxRPuarh
         mARFRgL4VnnEwif78jspsR+UzTQFEUPP1czZL2rZLCL3aWiBWpz5bXb1kAAWYyOFD2
         /6Ykv3jrHppAgV3oihC5HDOOSZzgz6Fj3Gahsxn2xcnTfCXlrFWD3cN12IvfbmylU1
         taiTOoFmoSIUUPFeIcYB1W6XpjHwAkk9KkH/BNdbrZ9WIHNot7Z+tfnmaaDNlgyAWh
         d3OpwSRRUqzpoL5tOrVH2Am3Tav8hk+GFaZSH8/YjCGms0+dxduiQEwPJe21ZCIQ+x
         3GJLmFNATgDhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E93E5E21EF8;
        Mon, 19 Dec 2022 14:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] MSI fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221217113214.1836857-1-maz@kernel.org>
References: <20221217113214.1836857-1-maz@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221217113214.1836857-1-maz@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/msi-fixes-6.2-1
X-PR-Tracked-Commit-Id: 4545c6a3d6ba71747eaa984c338ddd745e56e23f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03d84bd6d43269df2dc63b2945dfed6610fac526
Message-Id: <167146020894.28969.14157151886280456187.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:08 +0000
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Dec 2022 11:32:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/msi-fixes-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03d84bd6d43269df2dc63b2945dfed6610fac526

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
