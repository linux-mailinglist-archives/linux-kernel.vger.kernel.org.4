Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D67491FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjGEXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjGEXmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C31997
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370AA6177F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0043C433C8;
        Wed,  5 Jul 2023 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688600562;
        bh=mQwSV/WhgBqTT+Gf/XxCaf8OIlzlS1QxSGJvq3DCLeg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HoXJEmtowHepiCJAIZUCc/fVmW4qQKtxgJvEmxxfqEoCDF3kvgwzB+3Q3Bqtaigcj
         dUJTloB57lezuKo4Za2aTQd21bv7Mn/WqEPQjABz8lVkxlxJJpg+YC2tI05u7PcVWx
         9c6Wq0mXFwi+X8I0UPbzok0yFhr+vKB/MSZUysk/G0W0hjp+awDVsH2w9tUcyqL3ei
         nBRNbAPvyZZmMLWefzXG7LbYdL8+0bSmxunscgnf0uEXeha7YshFWMDrD1EUQtdg7U
         iCW4Cpd3Abmv0Z3JyVyIUS8it7qBz+dVuJcDUyW0QncYZFXdEmHO866BkHbdhvTWEL
         +N2iBEukI9XgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D574C0C40E;
        Wed,  5 Jul 2023 23:42:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230705190945.602792-1-kuba@kernel.org>
References: <20230705190945.602792-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705190945.602792-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc1
X-PR-Tracked-Commit-Id: cc7eab25b1cf3f9594fe61142d3523ce4d14a788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6843306689aff3aea608e4d2630b2a5a0137f827
Message-Id: <168860056257.20183.11442487377795774975.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 23:42:42 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Jul 2023 12:09:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6843306689aff3aea608e4d2630b2a5a0137f827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
