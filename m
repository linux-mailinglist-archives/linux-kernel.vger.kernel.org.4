Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD66F632C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEDDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEDDNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABDE79;
        Wed,  3 May 2023 20:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68D763130;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F59C4339C;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683170009;
        bh=DD5qlPaRjDWWFSDae+T2U4FEP3fQqqRPWCD+8BgKbE8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OwrXDe9Q7Iso6sqqA5xvkGo3XFnMrvx2ibiDJMfW+xLPoxhM1redjJWAn+p92j2bO
         fynzulw00YCuG7GlaJwXg/Wa+s3S9NHPzVeQ/cK6oZiRE5b0WvaKVqJjwwE2eMbIfo
         9Gmb2v9/8mW4v64at6hVVN65645wMidGbhjBt0n6w2U0b4R5ZWaUdkMGFx9o7gpfhG
         bWWZcsOfSjJY3uUeV4YlOFSgKmOo9voLJuLgxYphmnq7oXedaGG+OpdRc97d/IsqG2
         cdRnCS5Cme5zY4Sh524JlLYpvd2fDbThSYDhnfTqDnhyuo9ZA5jPulB3c2+a76bnyp
         C4OvP+DOzl+kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24592E5FFC9;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.4-rc4 second request
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFK2xmSgFCxtlMm+@bombadil.infradead.org>
References: <ZFK2xmSgFCxtlMm+@bombadil.infradead.org>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZFK2xmSgFCxtlMm+@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1-v2
X-PR-Tracked-Commit-Id: 0b891c83d8c54cb70e186456c2191adb5fd98c56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4082428727b58f223661278974527ef9a9661e0
Message-Id: <168317000914.23861.9133557214005780345.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 03:13:29 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     torvalds@linux-foundation.org, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>, mcgrof@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 12:32:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4082428727b58f223661278974527ef9a9661e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
