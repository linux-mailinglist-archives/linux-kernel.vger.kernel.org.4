Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B36F5DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjECSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248997DA4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA7A62F60
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF43C433D2;
        Wed,  3 May 2023 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138736;
        bh=0wIttIPof6+XCGZuRAIFD1NPVVm2uFFs1iAfaR6EXRw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DFDPL2jz/y2BPyqzrDxGzixTrmCYORISdzEQyawaV5k1XdY9qJ3TkA8eMQ92VsnAW
         yWHRM51Y4tr5k8r9Ofs1XSyE6XTFAD9/nM+3pmhYGG8IBEZZd8o72I0Ho/JXQT5DWQ
         RSp1/+AQINhehZgBE3m0V74pLPiuLmxQR6skltrkK5UIOrdjLMUPQjqJnkhTl/NluZ
         o0+G0aMr+dYG7qKXGZfZM2umMVw/PM+YxXDW25zdugICZJFu7l/MJJ2fADisq4U/p7
         uXE4CsnZ2K0NrJOQaXudc2+jQOnD2vPtzxvf4KjH7UZv74iVxE0eesmMSVI844f4Gu
         ydpSPRj5GBgsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12552C395C8;
        Wed,  3 May 2023 18:32:16 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFI74eeUzVPKhi4f@matsya>
References: <ZFI74eeUzVPKhi4f@matsya>
X-PR-Tracked-List-Id: Linux Phy Mailing list <linux-phy.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZFI74eeUzVPKhi4f@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.4
X-PR-Tracked-Commit-Id: a0106132372120dd0abf5ad7636614e5aeb5da08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54bdf8a39931cf8fe2c74432e715353d9a1c1107
Message-Id: <168313873606.23026.140779276363218902.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 18:32:16 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:18:01 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54bdf8a39931cf8fe2c74432e715353d9a1c1107

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
