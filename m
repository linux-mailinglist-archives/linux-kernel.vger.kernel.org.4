Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13975740548
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjF0Uwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjF0Uwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB9D10D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC22E6121B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3033DC433C8;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899150;
        bh=Kv0wAMJxNcltf8+ap6yg+0e2O/5dRLHqIrCtmbfT+9c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jh0AD2oC0ip/poOQfvylMvFOdOY5AxWaHi7Uv3DX2seRXIThgqyIZXAjhifoH4JUn
         v1RlAVN8OPBhNBK941Y/bJ2huYA9oDpjEnUTLAUIoO9L9zdphUz+rIdgjEGPeHVQA0
         61LZZsWQj53iL+wwr/HY7YUMsED/O9yGciYvTem8lnW+wxehezNoDzE9x4LwGIfSt6
         G732NOjQdXGcePJgwHLpjR25bZmNa3re5l3dCtXOXtnAOizzntLAxlIdMz9gmIUzcW
         xsznKnuU9LWRkp/NP9TBDO7yLxQKfua6ad83sT25EFJzHm7/BkQBS3QpXoxKMdUX1U
         au4NTKIQny4FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C70CE5380A;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627093452.GBZJqtPAaq9JI9AFZR@fat_crate.local>
References: <20230627093452.GBZJqtPAaq9JI9AFZR@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627093452.GBZJqtPAaq9JI9AFZR@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.5
X-PR-Tracked-Commit-Id: a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aacacee8617424e1dacead8d830e5b768eb3e53
Message-Id: <168789915010.12194.298757959923350640.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 20:52:30 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 11:34:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aacacee8617424e1dacead8d830e5b768eb3e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
