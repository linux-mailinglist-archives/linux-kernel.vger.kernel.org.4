Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D374B58E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjGGRLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjGGRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0500196
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F7A061A05
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E94F3C433C8;
        Fri,  7 Jul 2023 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688749864;
        bh=6SimfNFVEnrDAlXNCEMGXkyHfjgELeF7SVKI+9QYsoo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iCiyTmPEbU7R/WtKgJac7f1n/lVVkxdsL88Ona12kJToEqwILq1OK0APeZApF/bNr
         9coo7XdPDXxlupeXFsfYMgKNTvfCRALn2peWAH1hjL2PANR4X831nEodGxnfgvCeXG
         P5rCupNmZkTlZhxAztSDn8tjPSbc6dcBMly6POaHGeV2FNjaahugdIJUjjr6TAmzJ+
         C93Jv7WnAbyN6MGenBaYvEyghbg8sxua2AgRLABbxXqcVWGcZ9Mkl1O1ktAnlhfv3c
         Wc2ZGEYWq/+BzKwGAqZ6Dk198vXMNOr6+ozQ8mAYiVVVyzBfimKwKjalyg0llvB4VP
         JZmbVzbuPXyGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D88E6C4167B;
        Fri,  7 Jul 2023 17:11:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-4bd23a4e-dd7c-4f62-90c8-804c137c2621@palmer-ri-x1c9>
References: <mhng-4bd23a4e-dd7c-4f62-90c8-804c137c2621@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-4bd23a4e-dd7c-4f62-90c8-804c137c2621@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw2
X-PR-Tracked-Commit-Id: e8605e8fdf42642048b7e59141deaf8e4cf06d71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f6b6c2b2f86b7878a770736bf478d8a263ff0bc
Message-Id: <168874986488.21562.10846905883615220864.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 17:11:04 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Jul 2023 08:51:13 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f6b6c2b2f86b7878a770736bf478d8a263ff0bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
