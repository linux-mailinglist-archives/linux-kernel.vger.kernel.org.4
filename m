Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321026F25C0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjD2SUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjD2SUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988D2691;
        Sat, 29 Apr 2023 11:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25A360C00;
        Sat, 29 Apr 2023 18:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40347C433D2;
        Sat, 29 Apr 2023 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792404;
        bh=ZUr+jqUftvnewDfw2teqU4mJ8w4u7PoGCjoWgvhhkhM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PfIs7/K9O6SjgZyJXLKhT3Ez1qUS3E1YVJICVlrct5HfYigxJGbj2u4SR9IfniOb+
         zubKtd0vsRL8Wx2S1T5CxL4h7BcdyfVe+3JrCK5ZzWh0XhMajyx0wM7Uw2Z42FNE/W
         Sl4xhn0eSLutEFnAt/+WCtVMURm9uLEPq9hgLR+Ufs4nSOh2zf2fBCJwOvB7Zh6zHt
         SLVGIRfKIfAuJcEgTyUtek+ioI2ik8P0C/qcc+muppHP0MwNP/CYHymqp89ZTtRkAc
         KOL3MAKZ7Nns++lcOeUEJ7T9oKpmzDdu5sSmaAeN7OjbtWuLBaUCdVPejQyYn+DKdQ
         AgtQ8UDtGar9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD84C43158;
        Sat, 29 Apr 2023 18:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] LSM fixes for v6.4 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSGT_kK7fB5Tea5HVTXjTWYxh+hZ+v4R1A24wdLtthPXg@mail.gmail.com>
References: <CAHC9VhSGT_kK7fB5Tea5HVTXjTWYxh+hZ+v4R1A24wdLtthPXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSGT_kK7fB5Tea5HVTXjTWYxh+hZ+v4R1A24wdLtthPXg@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230428
X-PR-Tracked-Commit-Id: 6d2ed653185baa5ba601306cbd6cd7192642045d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1318e4383e400727c700b9db5044162f5bac57
Message-Id: <168279240417.22076.4296717595055562400.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:20:04 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 13:34:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230428

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1318e4383e400727c700b9db5044162f5bac57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
