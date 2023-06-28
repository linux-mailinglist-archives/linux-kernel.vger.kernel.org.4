Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8354741CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjF1X60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjF1X6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C95ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DC0D61452
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FDBCC433C0;
        Wed, 28 Jun 2023 23:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687996689;
        bh=N8+ozCHnJlm7x262G/IWW5P1T59+/h3535cMtXvyhpQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cgRff7dFf07j+tMUD6o1QH2Mj7Y3C6vKUtmURBqNEYjBdN2LjF+H/oDvnsd2dhqzR
         VNS+bDtfEn94gQ3UROZ8zdp3pD04rE4rikS7l3wB+lrjPu16Mb6VWFiYLVM5Qv6tm+
         JEMg+Ii4ED2788zdHIi5MfQT/X//bLK2aMJa7T2R6HhSDg5sRUSM9xncOyPyQRpWvm
         zIeGFMvrdu/ZOnVgJX6YBUciroacdFzUYuC0NyFikmvOASBYCS+cShGUxcmM36bA3x
         TKztOUYJg/axWmZKYtBU730BMiU3TUHaZnLscpqjvlIfBzLJyIdA2PUSyr4X/3ouXE
         LdZI9dRqicC3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A944C0C40E;
        Wed, 28 Jun 2023 23:58:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627184830.1205815-1-kuba@kernel.org>
References: <20230627184830.1205815-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627184830.1205815-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.5
X-PR-Tracked-Commit-Id: ae230642190a51b85656d6da2df744d534d59544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a8a670eeeaa40d87bd38a587438952741980c18
Message-Id: <168799668955.4861.7004023441610460029.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 23:58:09 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 11:48:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a8a670eeeaa40d87bd38a587438952741980c18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
