Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6736F2180
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbjD2AKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbjD2AKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2DD421F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F29D964266
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 00:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C5CBC433D2;
        Sat, 29 Apr 2023 00:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682727004;
        bh=XsoaQj93I5H97j77YSJFrGFLBXFXTiy6B3pMwBky3fI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VVHfVvy5/8eagge8hVaN2D+tJvdluuGCZcVim4Gwfwal5jODmVGhd9fOyeZRuxO0h
         y1aKZvc8sCC6w2ssGvqz6PYOSo5iLD+8BCB/oA6tyRf8x5ClKAyd1/kT8/V7JiTVGM
         gGMx/Z36XBRs4EGKJaorOwEzMvl/s65goBEZPv95hycvhIuAz76yXRiZv1f+If3n8X
         BpLbOt1ASsopNBlzF6724SX6m2xZYq8aBoq2NqSKs77QyMahBZWhcr4CfwXoYvn4DZ
         TL1tUsSYY3y0yQEKFBICdcpjok3q/e6YkBaxAsCRDMaMaMVqWl5s9L9Z3KUm8PQEQd
         pGg0NY4ttMKdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44762C3959E;
        Sat, 29 Apr 2023 00:10:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
References: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw1
X-PR-Tracked-Commit-Id: b09313dd2e726fe5e1fa574cd73f5e326c6030a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89d77f71f493a3663b10fa812d17f472935d24be
Message-Id: <168272700426.9526.5480201367174697156.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 00:10:04 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 09:09:21 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89d77f71f493a3663b10fa812d17f472935d24be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
