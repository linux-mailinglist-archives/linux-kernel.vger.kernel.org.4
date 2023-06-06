Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA31724448
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjFFNWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbjFFNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F110E0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1A76332C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80308C4339C;
        Tue,  6 Jun 2023 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057764;
        bh=vFwmRbDA1v3L5alE0Rea1Y1hgbvKgxPnAZj3cY0xpRk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IuUS+S9rgy8rOXhqNhuD4D3Fl0v6N2kx7TRidCM6PsPBN9+GB5pVtP/dFxnl/ZY0J
         8EzeBXANkOiUz44OLRvK/corAzmJVUamvvNBTMsy/VRsoPRk/BCnGhckhYU7+osBJk
         75EAwQ7WKNVu7ySziWySGCvJtKz0cIwuPP9Y8S8oAOBuyrhOoJUcPLLCQFsjYoEHwl
         LVF8jXdV/bYMbmzL/bIZ96PnvYiKssHxrLRKh38uxV8D92kGFZzjgfIKsDBKAK0hHp
         SIpvJwxsKngygSg3LlcswFQtuJHI+70nWIEY2VqoxSqR/S2fSg9HekfY4VIBQ9+k99
         xLlQrP4GzhDtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 647A1E8722F;
        Tue,  6 Jun 2023 13:22:44 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230606124800.1151665-1-agruenba@redhat.com>
References: <20230606124800.1151665-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230606124800.1151665-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-rc4-fix
X-PR-Tracked-Commit-Id: fa58cc888d67e640e354d8b3ceef877ea167b0cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bdd0f0bf17c5aac16f348ee4b1ebf23d1ec1649
Message-Id: <168605776440.13551.2741621756274355701.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jun 2023 13:22:44 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  6 Jun 2023 14:48:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-rc4-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bdd0f0bf17c5aac16f348ee4b1ebf23d1ec1649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
