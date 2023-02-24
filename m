Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F26A149C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBXBdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBXBdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:33:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BD119;
        Thu, 23 Feb 2023 17:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0832B81694;
        Fri, 24 Feb 2023 01:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5487C433D2;
        Fri, 24 Feb 2023 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677202389;
        bh=7X5l6I9zG42jWzxopGBrYi9wGItoPMKJqS+p1gAesKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IFaUUIaJRbC4Zpsdln1ABXoYUrGr3DLA91JkXMLS5lGSIGGqXB65DgF/RPjMZvZ8t
         i6xSnojhug3Hc6j/+Jhab2OI/pSt8kumzKvvEak1rDUKh7fea1qM5nh/4Jnu2XFFKJ
         +OQnIuQIcckOQ2w09tl+KgpSFLt1U7vgx7ZZB7BBJuSy002fU0+IAvWv9y1nSsqfnx
         YnlxVVIOfMs/OfTw7JwE1D0mRRMFrtZBF5Ao/73shcssFAAWrD2a8fncSnQtfTw8px
         IbvRCryF2afa/4Hpek4ixr9oHN2BubT4ZoPtOS38KqempKLCqo2A3lea+CqkJyvpJ4
         gVzQbHSQ+T5Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 940DEC43157;
        Fri, 24 Feb 2023 01:33:09 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20230106125915.60c8b547@canb.auug.org.au drivers/infiniband/hw/hfi1/file_ops.c
X-PR-Tracked-Commit-Id: f9366f4c2a29d14f5992b195e268240c2deb116e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3822a7c40997dc86b1458766a3f146d62393f084
Message-Id: <167720238959.3984.15645064723633869987.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 01:33:09 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:52:25 -0800:

> https://lkml.kernel.org/r/20230106125915.60c8b547@canb.auug.org.au drivers/infiniband/hw/hfi1/file_ops.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3822a7c40997dc86b1458766a3f146d62393f084

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
