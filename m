Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DC709F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjESSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjESSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524D1A7;
        Fri, 19 May 2023 11:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEED56185C;
        Fri, 19 May 2023 18:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61DD9C4339B;
        Fri, 19 May 2023 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521167;
        bh=CoISHt31iYAlqISghLuNoM0/CkoTCdegKa7NTEObgvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LlLKbGzZEvPE2taIBm6D9xvMcHNaLRBKPWJN4t2MWcjAg/3H4DwmHrBSrcST80aqo
         +8u9VH3Id4sMyJWV5PlLYFD71RLtcVv1qlB7eE8urejmXCoduaiw8pe3yBifJyRyOA
         ayrPuwPAE4js7vPwMJl8kYUApYncc5D47MTthAA0z46EDBz+R2gJwBJt5EvizPbub4
         dT8hs2qRpegWuXPukq/64H0t77FsEMVwnBiYtju/iMS8OGcHSjqLenO0oJtKhPYK6n
         adaeGKC6IxBvkIi6THgITP2CVRn/MwLOrg0EO7q7ge2XJROTtERBg3t8xUlFOueJKS
         dDsXwbsG3IuoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CC6EC3959E;
        Fri, 19 May 2023 18:32:47 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGd9KHlUSFgg+NHq@tuxmaker.boeblingen.de.ibm.com>
References: <ZGd9KHlUSFgg+NHq@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGd9KHlUSFgg+NHq@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-2
X-PR-Tracked-Commit-Id: 0f1cbf941d5949110adf70725a9614e622de8d99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac92c27935c759ff8b3cc9f761b086b15145c901
Message-Id: <168452116731.23824.34372407816903188.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:32:47 +0000
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

The pull request you sent on Fri, 19 May 2023 15:44:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac92c27935c759ff8b3cc9f761b086b15145c901

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
