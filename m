Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBCC6E3AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDPRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDPRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A91BE4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A7860F18
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E494C433EF;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681667011;
        bh=/3XLWyy9XtHKGWrV1lStuYlL6XW94nFnXAxbwLUzwQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s5ors/q5o2LSQZT9jxiOu8qpJCjX89qC4RKjeYP+kvjYLj5owGw0u1fxp6PlbZski
         wdkajtXYc70S2D4bb+AiaESvxW3LwZ9XZk3Jtku7RIeS9nkVhDyFGnsTVgx1nY/Ca5
         mZQ0O05jYjXgykLOtoLH2vJT8LEtQtb1THq3S3Y/w3HDoso5oj1FuUC09pY9IYmdHO
         RgQOHLD65I6sYyND5ZBJv9BOeit7dhIKuQv21eMuDcdIW90iaCLk+Emym22a6rISYh
         dWQB0KAx4Qmm5dldN3EfJJ21lDUYstSzPrO0azT0tRS4Yxr5iglD0hDlikG5oMtn9W
         wBT/4kSANWfNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7FA9E29F3B;
        Sun, 16 Apr 2023 17:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r0ski27c.fsf@mpe.ellerman.id.au>
References: <87r0ski27c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r0ski27c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-5
X-PR-Tracked-Commit-Id: b277fc793daf258877b4c0744b52f69d6e6ba22e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a1c388ce0521163f1556f7edbacb50ec2df15cf
Message-Id: <168166701094.4218.17580746926855703988.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 17:43:30 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Apr 2023 19:52:23 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a1c388ce0521163f1556f7edbacb50ec2df15cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
