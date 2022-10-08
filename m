Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957565F863D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJHRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJHRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:36:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A03F1D2
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 10:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C63F3B80B9C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 17:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F119C43142;
        Sat,  8 Oct 2022 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665250557;
        bh=458TLm6EF8J4szePmIBjleXnlZSyzqXJIYWjZ0AGRp0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GtNF7MW3r+m6fKX9tBSSF8JNXP/fiF4bK1bEY0M7atsC4n6/TKvG+KWNyKc/GpW0+
         1RJEllKfmm1nBLrgNOH5TmzyCicuKEsFmOjodAlyE9PsJ827RQFIaiwBqIa5pvtAsK
         nVhN6U3hhczz2LehApPJDZXWGCMVRJAeDKMrjRR4yLOPSLIn99utLIOtblVXiFk1ry
         BqtiIWnOVSzN+m/L7dXnGyXc1RzYwvuBX6TPdn62NGcge1ANdmygos61CkMZt8PJ7J
         lUl2xWiRhHhfncLSIiDLmVgN0NzNFKIiJswGb7jAtdG4mhco3uuwlZpT94zAUVxKpd
         yoFOeF5R+dAWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A24FE2A05C;
        Sat,  8 Oct 2022 17:35:57 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3b28dTgLNEtUN4OQc6ixmMXrN=9trgRQ9r6NvPXobXfg@mail.gmail.com>
References: <CABb+yY3b28dTgLNEtUN4OQc6ixmMXrN=9trgRQ9r6NvPXobXfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY3b28dTgLNEtUN4OQc6ixmMXrN=9trgRQ9r6NvPXobXfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.1
X-PR-Tracked-Commit-Id: b8ae88e1e75e5cb7a6df5298ab75334362ed631c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6afa4199d3d038fbfdff5511f7523b0e30cb774
Message-Id: <166525055749.22843.6436659831682152.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 17:35:57 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 20:54:02 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6afa4199d3d038fbfdff5511f7523b0e30cb774

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
