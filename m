Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637EC70A2FF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjESW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DCB2;
        Fri, 19 May 2023 15:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277AA65B4D;
        Fri, 19 May 2023 22:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8845EC433EF;
        Fri, 19 May 2023 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684537048;
        bh=h8socTlt1GEsOUSmVGIVVptBI3/m5KKwApvE3v5t0Yc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TEpK3ZJk4vW0HizoaM2YD835Qi7CodgP8r0J1mMiEuciEGPnsmdzR88lmoL/Y8BM+
         /2inBFJLmhuqeWV0uxX2WQpe/hgF1BOMVOPJ/qtJsTw3vRVUmUz3HiiXEX1XVn3bG6
         1teSKTwLhLWEFf6KqoKGqUXZ4gWkLSf/wgWKWa1zQZa5x26PXsHti3NoVOdTKXeHkr
         +sHDXCgkBCzbV0PJBc9JEamteVT8R8pSvQ1vjSGKxMQP5kLsiD2XfXTIPbq3wzHrid
         9XqJNF1hkk1/Wldb054pthBhRW+39DQDOOlXNdV8b96b/X5KVVBS/ZnSygwZ63Re2s
         G2AZK1qbgujQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75ACFC3959E;
        Fri, 19 May 2023 22:57:28 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230519161655.667685-1-idryomov@gmail.com>
References: <20230519161655.667685-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230519161655.667685-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc3
X-PR-Tracked-Commit-Id: 4cafd0400bcb6187c0d4ab4d4b0229a89ac4f8c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a59487458824184abf568721fe7d1beb1e0d099e
Message-Id: <168453704847.17720.5667186822006919784.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 22:57:28 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 May 2023 18:16:55 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a59487458824184abf568721fe7d1beb1e0d099e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
