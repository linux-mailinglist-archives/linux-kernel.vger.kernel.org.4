Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156F74BF16
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGHUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGHUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 16:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A801BF;
        Sat,  8 Jul 2023 13:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36B060B08;
        Sat,  8 Jul 2023 20:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32BB6C433C8;
        Sat,  8 Jul 2023 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688846904;
        bh=ergHiaMJ2IwXgJksW+WhJIPSCC8ngoi1+dYut0nYAlQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jXB4SMFJrv/DS7ZexHSAHp8ranoNPvGh/x90UZqcUnS17ZUpcD7VgmusG/tSOQOhd
         xRPwlbhBIARuG6u0CLKjrskDvRmJnGUGdbLHucJKsly0I9mWN+g8fZGysoRyWfqXzS
         fyO1pli3VSZ3ccVlBv/9ldH5JDQLIjOETdGV1yWiIwPt0mMATXLIiaDyU0U2jefYvk
         e4RiBcxdpC6F1ULopRs+SUlNaukGEOUtBSPcNzMLRHD2FNFSBBlwYGm5hQBBGw1B3T
         6J0OA9OqDvNdnZjrf3M+vX/zYgmwftFi+JY021gghS2NR83Ps0TGlkRvM82pbG4Sl2
         BY5huTJZjhoAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FCB3E53808;
        Sat,  8 Jul 2023 20:08:24 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.4+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5d8a017f39f95d4214ba638ecb8e41d2994cda0.camel@HansenPartnership.com>
References: <c5d8a017f39f95d4214ba638ecb8e41d2994cda0.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5d8a017f39f95d4214ba638ecb8e41d2994cda0.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 24033d71cc36ae8af02b56ec22c7490779a9e39f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fcd473a6455450428795d20db7afd2691c92336
Message-Id: <168884690412.10103.6327003456697541408.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 20:08:24 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 08 Jul 2023 14:50:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fcd473a6455450428795d20db7afd2691c92336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
