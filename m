Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDE7377A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjFTWyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFTWxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376310FB;
        Tue, 20 Jun 2023 15:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0729C61236;
        Tue, 20 Jun 2023 22:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 677ECC433C8;
        Tue, 20 Jun 2023 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687301633;
        bh=DYOYjPlSbQzXxNe29cAO4SrS8OWRou7BUvM3i0H7qDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A+yr30052SoI3c5NQogTvRHULd31WhPXSapzN7LXeuPhQZEECkcD/7IOjNbQ4yyZl
         sNWZRwfsF5MrU+Brnw5i4zB9Js4JtejAErifnLL+MasXCgpFmNjjIvctiqWXdWgwjv
         Zq31zWTspozn7XoKutD0o2SJsBFBZTfBBaoEehIlZYJFmzR0M1GERCV6KnSAkJOi+b
         K4QgMoVNss7yQ46I6gY/EQlyY4LTzU5ixkz99G1G9FSFopRLunnodfqnSwS+JYX+hx
         +jTUnhppg+ceiXqy5DMRk8Nwnl1SKL2vYck+RzmNUGPfIH191+S7bAspt5MUHWaou+
         xYLticSvtWL+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E2F4E301FA;
        Tue, 20 Jun 2023 22:53:53 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0irirNR8h5JNkdsKTZACpBYXa7mLv55F-i6cYa03jZD1g@mail.gmail.com>
References: <CAJZ5v0irirNR8h5JNkdsKTZACpBYXa7mLv55F-i6cYa03jZD1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0irirNR8h5JNkdsKTZACpBYXa7mLv55F-i6cYa03jZD1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc8
X-PR-Tracked-Commit-Id: 0bb619f9227aa370330d2b309733d74750705053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c74e2ac2383fd687bf2f8dd3f29f674cbd0cdaea
Message-Id: <168730163331.29619.2128765180034365688.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Jun 2023 22:53:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Jun 2023 18:11:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c74e2ac2383fd687bf2f8dd3f29f674cbd0cdaea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
