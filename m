Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A164E5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLPCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:16:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAB1A23B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 846B9B81C34
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46504C433F0;
        Fri, 16 Dec 2022 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671156985;
        bh=0+XbRyWTL3TUexuhvgazvvanY0wjzm7LfY82xs/vcNA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hE6Q5lFcNrqyGabi5PoXMb/R6pcnthD3bDZscsBH162Hq5kQkUt3GY+XZT2yQv2me
         jlog8yWIxPobPak/K/CPI815EU3Pa2EqR45sWA9Jk1qdyXnjXhgATzAWZs6J0lc7Wf
         ypyFp2VMKYeEKsYhecVXjeWRKXSuOvqOkeBkJ2QtCeOTbKBsgZFaqUPocGBftP8Oe5
         0HouEk1l6Ou4X10fvoGzZA2BeTF1k8zZn7WNNvmr14eCf+yqnPXmLv4ojtKSuT0KT2
         jjxubOM25+1VvJB1aPZkIswWkILfUSvPdI6qVl23e6s3upIYtaFfOHcZykUMQC/NNG
         evp6ew49TnxKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E09AE4D00B;
        Fri, 16 Dec 2022 02:16:25 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9T3NxeotP7qmJvcF+abqu0yJGnfCySefnUPbKVCYZ_Wg@mail.gmail.com>
References: <CAKYAXd9T3NxeotP7qmJvcF+abqu0yJGnfCySefnUPbKVCYZ_Wg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9T3NxeotP7qmJvcF+abqu0yJGnfCySefnUPbKVCYZ_Wg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.2-rc1
X-PR-Tracked-Commit-Id: 36955d368dc101be885ad2c71618e3c3a93cd8ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84e57d292203a45c96dbcb2e6be9dd80961d981a
Message-Id: <167115698518.9308.4901009219418024603.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 02:16:25 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 08:50:47 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84e57d292203a45c96dbcb2e6be9dd80961d981a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
