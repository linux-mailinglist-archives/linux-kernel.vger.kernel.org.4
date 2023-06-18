Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CAD734726
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFRRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFRRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1BF130;
        Sun, 18 Jun 2023 10:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA8960BAD;
        Sun, 18 Jun 2023 17:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FAC4C433C0;
        Sun, 18 Jun 2023 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687107690;
        bh=tobDUTohzLGZ4csPhDFXeuaV/DFtVFrB3Mb2/C7DX4g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nYr4nowOLUzvCu0kgWcgC1iVRcxW0NDBZJCgfF6y9wGAMBIG2YOuleIEUw1ZZgfqM
         t2vgeK4m98ta6CTtNnjL4AnKBclI842Sc8wUhiLf23pjcvVKmKXYJtvJ4B9mfu341P
         a0dlLi9thCOWBSPex5oOlZ/jyGpwZ5TqNtNPK3WCKQ2Ri+Zn0fgM50KEJ4nYlvwARH
         bAe4pnoAVQuVcaYGUO4l7RzJnFN0NxnhQ3JYQHwck6xyd2986OiFtJwoA4pfOHGkB4
         fw/cz9JxYrXz8Ip5m1FunqLBoUC/1JtUli0QuBkzoCyNKi42Z+vR9fqJxmXJ6nvhE4
         7nmkcgFGetO7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C042C1614E;
        Sun, 18 Jun 2023 17:01:30 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdad87164ce2f62fabccad0b4f6c11a7e8e2914e.camel@HansenPartnership.com>
References: <cdad87164ce2f62fabccad0b4f6c11a7e8e2914e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdad87164ce2f62fabccad0b4f6c11a7e8e2914e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 9cefd6e7e0a77b0fbca5c793f6fb6821b0962775
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1f0c38b31025f60437215dd27fffc293565fa4
Message-Id: <168710769030.15251.11846954188757632501.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Jun 2023 17:01:30 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Jun 2023 09:42:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1f0c38b31025f60437215dd27fffc293565fa4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
