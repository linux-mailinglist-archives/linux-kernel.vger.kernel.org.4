Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEA74785E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGDSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGDSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08910F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A43261355
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D088FC433C9;
        Tue,  4 Jul 2023 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688495927;
        bh=QMdEXaX3S/uGrqB5eSW3OPeWgZpi8UQoyoMpqzlodBY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bIMifGM8YuafBwts+2+sSHOTyZqzCnfYT3KirMeaYuedYbf890+HuwMikCdPSTCbJ
         1jqt2UfMdrGA0GRbkqdG4vjL0GQ15MBfSxWSnDOdnUg5Cm1gD44Nyi5A/ifjIlenU+
         Wkgb6s/B7JorqqXxC06hlNniJ9dI/Hv/yUQ6dRNAd8RKJReLLG90XcQ499o8JFli5F
         1ZIIDfzR0hhDBYYST81lO2iDGLDNfP9dyUeCmgF8gzDLxqUytM4+jZligJiejAXIvd
         it4sn9Xfe4XvzmNi6w28BX32xD8yVuPBQqVQJEKGHiptYoTELhQnE3TbR8hK3WHkKC
         kRqcjtppeEm2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCAFBC395C8;
        Tue,  4 Jul 2023 18:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230704121847.GA26576@workstation.local>
References: <20230704121847.GA26576@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230704121847.GA26576@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.5-rc1
X-PR-Tracked-Commit-Id: 3ff256751a2853e1ffaa36958ff933ccc98c6cb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 406fb9eb198a05fa61c31ec8a6e667c8440749c8
Message-Id: <168849592776.22559.990107628241028606.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 18:38:47 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Jul 2023 21:18:47 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/406fb9eb198a05fa61c31ec8a6e667c8440749c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
