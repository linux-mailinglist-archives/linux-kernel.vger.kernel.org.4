Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD466EE746
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjDYSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjDYSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F9B1720
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DE963096
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32D78C433A7;
        Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445653;
        bh=+oS5EE2tJ9Y8Z53WOBeFyvqJMOXQqrpXhyEb0cq6hBM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qS8x3fGAErXMAJ45kqRGXimncY5brt/Pm9VqrxZTkO51P2O2tbiUwmlWMXFSyNc+l
         hTrGKe94FXcHbDxOJ5F7OIsVTXyWx+c76GGmJkK2Roa9hiqfeQtgdfhEKDOE/sHife
         wQLwQ/A22zbwMpxOOtV0VIMvbuFj3m2flrd2/aY+bmdDehIuhA3p8TT0/960IM0tK8
         d42HtO2Kj7efZv0x9LNjIWtrRQSuyfilN6O0NiaAPSjiw6f5gU6UFDrrAr7zIEBxzP
         v5k0nESXPtF+ro2mwJQrmaRnrpRBkfeOe6bKHFz+KqLg21CH9eoQ8Dz6lN5Sc3oNcy
         Ad+Ay5nTmtqUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FE47C395D8;
        Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424145507.GGZEaYS0KOeYeXHYns@fat_crate.local>
References: <20230424145507.GGZEaYS0KOeYeXHYns@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424145507.GGZEaYS0KOeYeXHYns@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 812b0597fb4043240724e4c7bed7ba1fe15c0e3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc1bb2a49bae915107fd58705edb1e32db92c635
Message-Id: <168244565312.10431.8114735148852466747.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:53 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 16:55:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc1bb2a49bae915107fd58705edb1e32db92c635

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
