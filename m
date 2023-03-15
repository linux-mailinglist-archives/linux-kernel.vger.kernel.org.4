Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2955F6BA551
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCOClb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCOCl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3683347B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286BE61AAF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89F3FC433D2;
        Wed, 15 Mar 2023 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678848084;
        bh=jbpPKQOny73LpJKPd8a+GD6GNnWExnyQJnjDVa1fY8Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QD59VmN94x7x6W4ONdyyLpgvZOOA135AiZGTQ1+uItd4+fLTPHUr6hAOSWC+MqRbK
         5CU3MCAzW6v1V7dtXgIwlHbqz+J9LkE1j9H1sn1wpJlJLDi1/S8AlZIV4wCV4c159w
         iI7qjoamOgnYNufAROozPbNqbu3PswD68T5JZ3s8PJxVKTAnuup295oiW9j+zMvrWL
         qXzBlNHeElDxm86LzWsY1Iub18WipGsb1w0Uk4f9M9ZY1CPqEUzxsfy+msC2PG9dHf
         3xuCJSDF/GxYiTJjxlGqKCjibHJ7PboISaW4cH9fJlsSscSaLd3UktmyPqzhkDTsFS
         RrK5KLcpugKxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7687BE66CBA;
        Wed, 15 Mar 2023 02:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] zstd changes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0BCE9AFC-7E97-45F1-9EF2-D565C597C53C@meta.com>
References: <0BCE9AFC-7E97-45F1-9EF2-D565C597C53C@meta.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0BCE9AFC-7E97-45F1-9EF2-D565C597C53C@meta.com>
X-PR-Tracked-Remote: https://github.com/terrelln/linux.git tags/zstd-linus-v6.3-rc3
X-PR-Tracked-Commit-Id: 6906598f1ce93761716d780b6e3f171e13f0f4ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed38ff164fba98a21993c95d240013f32309ccab
Message-Id: <167884808448.332.8093260157527978222.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Mar 2023 02:41:24 +0000
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Mar 2023 00:56:11 +0000:

> https://github.com/terrelln/linux.git tags/zstd-linus-v6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed38ff164fba98a21993c95d240013f32309ccab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
