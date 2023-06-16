Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2034733C31
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjFPWOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjFPWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B20D1FD7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DAB62CCB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 565F4C433C9;
        Fri, 16 Jun 2023 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686953669;
        bh=hV/FvkB09pCNwQ9hBUvaaDuYdmbado/FaNsrPGvDNds=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jzR7t5SPgUL0wzWO9mA322QKIHi+9q9kpAfyvo4SVJZD0Hm2xwci9QOtPlepplugT
         pWNnz1isN4LqzOUf8lahXlkHfMxv95TICnsEaeQ5eRrlH2jVoRu2vjyv1WRvzyacrE
         xrGnWhFD/z4q2btQpdTFDewb5lgXlPVUJLOT8sYTIT/PA5OGXw8P5JiCL1MwQkR3iA
         xwZMo0N6m63QE7oDqIHYBoI/BbfALU65PbTqh9vnuu/8Hu/MvTZjZvI9/YrtQm21K8
         NfbWH5YmmxN9DCIF2vB1D1+2JnAs3VjnOhpPsmcxEkCd1lWxVLgRBhyk//lPARXZm0
         TQscyWcMuVKAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42868C395E0;
        Fri, 16 Jun 2023 22:14:29 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txbkXVgrbDbqezqBVLVXdBx4+iwfJPTVWLzWuGtDsTT_w@mail.gmail.com>
References: <CAPM=9txbkXVgrbDbqezqBVLVXdBx4+iwfJPTVWLzWuGtDsTT_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txbkXVgrbDbqezqBVLVXdBx4+iwfJPTVWLzWuGtDsTT_w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-17
X-PR-Tracked-Commit-Id: 9930f518b6a82ff10a3d13e0cbde05cce04f5930
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1639fae5132bc8a904af28d97cea0bedb3af802e
Message-Id: <168695366926.15703.2415002187192615232.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 22:14:29 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Jun 2023 06:29:31 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1639fae5132bc8a904af28d97cea0bedb3af802e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
