Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCB5F4893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJDRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1667174
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E51ED614E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 550B6C43147;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=3YQMP8sZOKfXnVIqH1D+GHrk9dxMgy0/ydzdxnZrrxk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A6jvJH1aEmbwWElwwVdJPseh/JICV9+fXiCm9s9p+sx4rh5Wq5/9lBao6yjDb0cF8
         f0Uw/o/sZ0es34aazC/fJnriGaDvS5bvmajvViEXXqDnOIlDL7kgpaWvzLwTf3vNW2
         vqMnPmGC2WFxFEKeOFn6E134e1LZ6LBq8MMbOAd55+nRZIhhzp3UdfWAImoLeRJd/L
         hrMnpzc8HsPTXu6UrG/zcD1OBHOEjoktmyItNgWXV7GIgJm11GeAw/kehFPAqzwVxB
         2TQGGPN6aRkAlnxRJsdBVIol1QhHWVe1VgI/6lolvrJ5DVStX/NwFuLkqe/E8QFu2M
         F7piwrynIIndA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F75EE21ED6;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzv8yRMxwmNDbqWy@zn.tnic>
References: <Yzv8yRMxwmNDbqWy@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzv8yRMxwmNDbqWy@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_v6.1_rc1
X-PR-Tracked-Commit-Id: b8d1d163604bd1e600b062fb00de5dc42baa355f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb3a16dbea8ac40a36056e8ca79d37d47198a67
Message-Id: <166490484525.22164.14463225532138991444.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Tue, 4 Oct 2022 11:28:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb3a16dbea8ac40a36056e8ca79d37d47198a67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
