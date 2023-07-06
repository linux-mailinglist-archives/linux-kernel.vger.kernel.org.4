Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D374A54F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGFUyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjGFUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5D1992;
        Thu,  6 Jul 2023 13:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD40161121;
        Thu,  6 Jul 2023 20:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50FB3C433C7;
        Thu,  6 Jul 2023 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688676892;
        bh=bO41QQnhs0ZSHdrMdBTrZxfoUgKmO3PX2RUaJvjiTGo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NZhaihVcj6RvVOjvmKdcog/snZ7E5rXf+c8UDGOZjBDCEMLRElNS8WgiDN3YoamqL
         xIAxjAugCKMD2zbYetvySnYPJCFsT7ODKqQB+X0iRfbAHKiQmJZ9v84whPqkFyjtGy
         isjuy6bDYY9ctdtSA+/KwnysdDMdsLdQG5MHXbPaS1ZXzwcBsSnFI2G7GWzn9tMvxg
         2Oyayg0j6mip1ZFdpaP+KhvO3W4PIntJnQDEccuiQyf9gA1ZEmJFGnuDHWB/K30+JE
         wmc6/g69xonDWWigkL06o+j4ezO5KrJxBChAp9b+1Si3OZROHr/QV3z1bB/2L290un
         WFjGMF1aYZSyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E3B6E5381B;
        Thu,  6 Jul 2023 20:54:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.5 merge window part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKazVPjc1OAM8iaL@tuxmaker.boeblingen.de.ibm.com>
References: <ZKazVPjc1OAM8iaL@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKazVPjc1OAM8iaL@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-2
X-PR-Tracked-Commit-Id: 54372cf043276735e29045abf998895b2ac277cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a452483508d7b70b0f6c69e249ec0b3ea2330b5c
Message-Id: <168867689224.8363.9839477369253580581.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 20:54:52 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jul 2023 14:28:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a452483508d7b70b0f6c69e249ec0b3ea2330b5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
