Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7774BF54
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjGHVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGHVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 17:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03901E46;
        Sat,  8 Jul 2023 14:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9637A60B23;
        Sat,  8 Jul 2023 21:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A25C433C8;
        Sat,  8 Jul 2023 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688852485;
        bh=z9vSwHm1UKD/XNpiZwd5OFvWDknZkcQKanhK5VxPztA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VoSm4aQ0EACHrWcZS59AiERsrd3Aisf9RMuAdJv8+kdb7I+qRnJO3QWTLZ0PucjbO
         oo03xSPbhBKp+p+64qR4rjbTGq01ApNC/D5g6L5roalAT86cYYuoRpRk6E5JLXl+A2
         2RTLTZts04TmFV7xji1y6lJ/9RhxOwljQHEOZItDYCL/Bqsr+m0qL4y1V2IGiGlMCN
         l2pajhMwto8TzlozO7aAA7zZXEOf4wgM+P2zmAba3ZJesN7HdeaXRSRTwz5Ow+aEBK
         sLeHkOrch6L9ulc6+aVZf2hteEe6AeZGKHOZ+4Sumb6l4EMt5YRHIb3HQZpDiZoHG5
         UVvTDNz7BPv0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4563E53808;
        Sat,  8 Jul 2023 21:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230708104658.927e647f75d55c4a5d99cbf5@linux-foundation.org>
References: <20230708104658.927e647f75d55c4a5d99cbf5@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230708104658.927e647f75d55c4a5d99cbf5@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-07-08-10-43
X-PR-Tracked-Commit-Id: 8ba388c06bc8056935ec1814b2689bfb42f3b89a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 946c6b59c56dc6e7d8364a8959cb36bf6d10bc37
Message-Id: <168885248492.22313.17203626653790450275.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 21:41:24 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jul 2023 10:46:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-07-08-10-43

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/946c6b59c56dc6e7d8364a8959cb36bf6d10bc37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
