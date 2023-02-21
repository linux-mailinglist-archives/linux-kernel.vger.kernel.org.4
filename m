Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A309B69E5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjBURY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjBURYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9921C72BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3235261163
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 919D6C4339B;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000283;
        bh=CU7dxhe9I3xLwqc4lkqS2LkKUTyegSxV6nwe8TIaT54=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rRtruVquygAs8IUgU/esT9EGu40xXO58pp07H+H5AON6zPnAP49Fki+DFM9XEnttj
         PfJKdh/rGAs+sKMFZ2NDl1kQJdHvQUwzcr1Jyy8irXfU2DCTy50VTxZcn+lSu8pdhJ
         rhzINsdtnRfM3ICyE+lf4YuawgCWLQ+V+amJBaEI/6zh1mofaJes8sK3VM2ERZmhgn
         rTHpnBB8t7BgRYasKK20aZE6gg1eOg8N5trSMtIGilP8dtSqumWBCGEWXIU8vWWqnZ
         AZbOFqcLCXi31PITCNKq3DGDtbYSOqXiSo5RV7nYvAjuGOj6nfRTaXQabFExjVYiN3
         JkKi2BW3a6IRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E1B9C43151;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NQfnRa82W0vCoy@zn.tnic>
References: <Y/NQfnRa82W0vCoy@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NQfnRa82W0vCoy@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.3_rc1
X-PR-Tracked-Commit-Id: 8a01ec97dc066009dd89e43bfcf55644f2dd6d19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0246725d7399d7d6acc8fd5a1a0a1ffce9a1eaa3
Message-Id: <167700028350.32027.9725718413401467419.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:43 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 11:50:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0246725d7399d7d6acc8fd5a1a0a1ffce9a1eaa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
