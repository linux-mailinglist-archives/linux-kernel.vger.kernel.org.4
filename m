Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411A5F8EEA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiJIVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiJIVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D8200;
        Sun,  9 Oct 2022 14:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AA760C93;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A6D9C433B5;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350237;
        bh=L6uejkkTX8dEsd4WE0nNYlh2Qkh164jJBtYdqjGdxGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mhgY/MxhEhNzGNCoBd/SMpEiXe3Ehxfvw98lWZGT6WNpTd1kmGK4rhVKePWaxj4Qs
         Eib3KuGk1Yo1s/pW6r6KXHpk3O/YKZZsr4UpgnFhA4yb4R15bLIg3d/7L/B6yPbnLc
         crq8oq3I+NAOoysbMqjbisDM/PFuipgE1DBcTrBycME7bKj22fgrmhNe341gvI3Hzb
         6Q52vVuqPJkEdX0ym7YTeYXruBo461qKOtYd9AZIehU2gXpsgMPadEAOP/oTIQZuOj
         57BGOGPHVW70lwO9UZvAALta9aE2DvIrIkDnBezv/YLN3DakjbkCuZU/EJcFwBPJUN
         V0gJUezRyJ8SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BC9BC73FE7;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.1 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01665259895-ext-4990@work.hours>
References: <your-ad-here.call-01665259895-ext-4990@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01665259895-ext-4990@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-1
X-PR-Tracked-Commit-Id: 8fb65e05bd60058e15842e511b3ee5299ac51829
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03785a69ae47a17fe57fee31058fef7cd3042977
Message-Id: <166535023730.11566.12447474641592050744.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 21:17:17 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Oct 2022 22:11:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03785a69ae47a17fe57fee31058fef7cd3042977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
