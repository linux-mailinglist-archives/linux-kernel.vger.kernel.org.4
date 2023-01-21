Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60C67685E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjAUTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjAUTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848C1026F;
        Sat, 21 Jan 2023 11:23:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 764C3B80781;
        Sat, 21 Jan 2023 19:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33316C433D2;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=S3D3ekhnnV77utYj5bIqYYwlcb1ovh5YEclWHfiZfFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pSy7OLM+Tn7hpvfQPvCv6GG+lV+zzB5or8aPQSZCQL+OGWESLgeHdjvyi1RZlXwRf
         g+nWsgeRnR2Kxyh8TeiwyVidsqxy1QM0phNSBNyU8tMpqpfPTAvA48IHFBbBXWhZIV
         jBteMBxyuOs7Kems7biprWAud9dL/G1UWytIuCTlqsokvDzzqPpJzyqtTubFS0704Z
         D7GOaSKM09WpUYtPf55lXv/oRm7t5gs+uDnAWtc2JPWF0cbGpU+h+he4BlK4LXV9qS
         kNzQrq3cDWmjfuf+4LY+aBkbRnU0lkNvBaxy8NDNosCvQ0O92eKhquAVuOy5GilnTK
         KaihzDHXe/S6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B88FC04E31;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARFTDWJtxb=1gu6f4_=jRWevb4Hd71ipfpMFpf8GU4SCw@mail.gmail.com>
References: <CAK7LNARFTDWJtxb=1gu6f4_=jRWevb4Hd71ipfpMFpf8GU4SCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARFTDWJtxb=1gu6f4_=jRWevb4Hd71ipfpMFpf8GU4SCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2-3
X-PR-Tracked-Commit-Id: 13e1df09284da53ae5abdd3364c36caf8f0f8916
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83cd5fd014c0abfd3cf6d8e4189333d099630845
Message-Id: <167432901810.17568.5288416598602230734.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 17:31:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83cd5fd014c0abfd3cf6d8e4189333d099630845

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
