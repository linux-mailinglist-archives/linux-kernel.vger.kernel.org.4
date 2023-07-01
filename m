Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F892744AE0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGASns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGASnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF465171B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5559360C02
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 18:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C24C433C8;
        Sat,  1 Jul 2023 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688237025;
        bh=HBuOxlOAIgLipmhu+VFqP4QnRqzhGcyPzr86fs9Liz0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Abyiamk2Ack5OwnorMjXFIk2ykEiGXRjP/9Jxg/USSOY9M4/v5wD6/gNtd4tHjOIU
         NseekKeQOzsoQ5YNcIMQEnVKDA87/Lqkbzi0fCTGxea4qq/84Q5AUTeRHJkaL+a0Iu
         qZeWt/oTQx4KLUAq91jzwigBr0C4LkEMI40cYhKSDSVIw7VbkU+CCZFqRs4JzTFWPi
         wOlLV6xmCsYFM5JtdyZy7rxhZ6D5l5VfifzOgRHPAWjzMQBNDRS4ewFX+elImPXztH
         8KOgtyibVZ1zwOvas9eFmnAGzvJyFixDg+BriCT9+HZ32eg09mEihjw2sw4Dz6v/eS
         D3hPtGSMxFJIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98AFDE5381B;
        Sat,  1 Jul 2023 18:43:45 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168823486244.3978156.6059859588267964136.tglx@xen13>
References: <168823486244.3978156.6059859588267964136.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168823486244.3978156.6059859588267964136.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-07-01
X-PR-Tracked-Commit-Id: 0303c9729afc4094ef53e552b7b8cff7436028d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8566aa4f1766bb0267b7a0ed89c1d2c4a82ee1a
Message-Id: <168823702561.9455.10890226197552462078.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 18:43:45 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  1 Jul 2023 20:08:20 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8566aa4f1766bb0267b7a0ed89c1d2c4a82ee1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
