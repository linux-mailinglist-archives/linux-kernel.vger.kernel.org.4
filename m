Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EB6BEFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCQRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCQRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95535B9B;
        Fri, 17 Mar 2023 10:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A951760B35;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19EF8C4339C;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074734;
        bh=2QLtTVrqM4ws6RP+D7kytw1H4DA+rGrb7UdCP2TyEcQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XrMynA8GNb53l2Lr70kGFj/Re4bmw95WbvMttuWh0viQczo66h7GMXfNYttc+LAQ0
         NEtJCZ+aHC6atRHwXdZvN5ruR/0PWTmcavdk09EYt3uDEiLgcFKaOCBK5aX0YvqdWW
         +23S57ZpYDqQifqe1drIiz7BCYAhu0UwGQynP5OVqQD0D43u5tBgIj1klSVrCdIiMn
         NfxxXoFnWd1rjXxBEXS+eO7L6iRy4WxxlVDqafr0e7fXWw1B9P+r/aaTvGSvNHxoRv
         mIehXoDspjr4DM12MB5cCEdF7erEXSZRSe51OcgmfZpwdXdwprEG74bIzup2VPKY4b
         0tYuPonqNNuxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06F14C43161;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01679046223-ext-4713@work.hours>
References: <your-ad-here.call-01679046223-ext-4713@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01679046223-ext-4713@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-3
X-PR-Tracked-Commit-Id: d7a0bdbf17276b757d2b89f5351bbee9ecf58fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e50a80383e04a8e5a598a099979b52af7bfa7158
Message-Id: <167907473402.9394.6766938401061793126.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:54 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 10:43:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e50a80383e04a8e5a598a099979b52af7bfa7158

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
