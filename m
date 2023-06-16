Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2546A73388D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjFPS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjFPS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06E3AAB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8F362EEA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3028BC433C0;
        Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941847;
        bh=aBiANHfc7WlRsOXJs3SS4tlihuGbK31wTJiW8w+GHAI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HawpRXdpPRLre/nNAR0w12jD39h/2TyEHBPUVv4zaM6krmuPPSYc2+NKPAwLvNqKq
         vyhnKD0WORt46RxrQzpcvSE39j0K40i0PdB1SF2U+YgNhniOd4FfTYuPfLyM/p5On9
         OQrwWHOWX3F7y6OzuhdQJwcSqAPST84aVs1x3KublgMse9hf1y7uinaJZXmGEPT8xi
         VzHz6v+5/uIzQpc1TXjPjL5C7o5mTJukRZJZBQ3vA+EcWMtEU2Zfcmh/SChVx6B4En
         kerlYFqK3rR0LR4Ie1tcDPXEyZTnmK/CPOkq3wdWR8hojvpwKQskSCr5qcav7WgnRu
         NKjUld5HGTnag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19CF8E21EE4;
        Fri, 16 Jun 2023 18:57:27 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fix for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-7c3e3b18-17a7-4bf5-a977-f287ef6d18b7@palmer-ri-x1c9>
References: <mhng-7c3e3b18-17a7-4bf5-a977-f287ef6d18b7@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-7c3e3b18-17a7-4bf5-a977-f287ef6d18b7@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc7
X-PR-Tracked-Commit-Id: b104dbedbe61d89a933479f8effce6409037ef73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4fd69a32551036ac84bf4487b680167df77477d
Message-Id: <168694184709.2801.4867806136487239028.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 18:57:27 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jun 2023 08:53:34 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4fd69a32551036ac84bf4487b680167df77477d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
