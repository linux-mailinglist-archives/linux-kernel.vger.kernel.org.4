Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136B6F8A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjEEUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjEEUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087C4EC6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7CE64090
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C21F9C4339E;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318797;
        bh=qvOgJN+oCNS5g1ytNum7KttdtPMJbOoHq9j31ClFAwA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nuVkRigt9PCDIBUX2IZHLJhUilIv6QWEeXvf+nQhtk6+COCXB+X6rxvhq4MTc+ssI
         K9/fXI1fn+xdRXtXOhNwXi20dahBw+ztVFgUXe1HxyxZdtV9gDoVRbLmsNnYIv5xDD
         t6W27b7vCaPQ5rkagwGh2kbZdvLPku4lLB1M7hgFacIaOAAbhjyDgwl9yMdVZDzziZ
         KP7sE4/d5eBMjMpNEGxckFjnWAwQDmx0qGZiDJbOp16zUKaF2BdLvm0Dx95T63ZQ36
         6OZfR2xci+oQkNtVc7PCosBcZW6z+KJpD3qFfOSsQWK4w0Qh83sTQVSc/dLV1vBsDb
         b3xFB+HMaii3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD1C9E5FFFA;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b783c0bb-3d23-4767-9c69-a39f805a8544@palmer-ri-x1c9>
References: <mhng-b783c0bb-3d23-4767-9c69-a39f805a8544@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-b783c0bb-3d23-4767-9c69-a39f805a8544@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw2
X-PR-Tracked-Commit-Id: c2d3c8441e3ddbfe41fea9282ddc6ee372e154cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 982365a8f5c453b3ecff131d60f254a7e67c9a2b
Message-Id: <168331879770.21250.12119912930299851226.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 20:33:17 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 May 2023 08:16:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/982365a8f5c453b3ecff131d60f254a7e67c9a2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
