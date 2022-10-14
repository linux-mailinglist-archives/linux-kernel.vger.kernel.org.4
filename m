Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F05FF3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJNTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJNTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:13:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9921911E5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0B2EB82342
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C612C433D7;
        Fri, 14 Oct 2022 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665774831;
        bh=EFSHnKiwm0zo32NbLIshfLknh2Dco1ndFuQR/dD8wGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HP2Mani4PQNQDkXXUrbs916bqp6bnNY/6uD+sNHOj+kJaI1MFAolo/4ChfBI+AqUy
         4i3pcZ1HYLZD3gIRq8HRDtANbaknGVK8BE5h+Mgfz8AEi+5uBouLytKEV6TN4L1rpw
         6JmBj3h4buG+bd1BVXPV34Hx7SfJaig67oSVLzbfLCOcxkwzR10n9+VoFuB3Zm14Tt
         TnTM4MmEZPzN8C5bZhwtdmbNy5ZPXmd64NHsmnlaWApHpAoyPn+bcgoM47i7xyYae6
         o2U+sE0s3r7RkkVC035MNKtzDioWOyAJI9db/Dc4zG+5S5XVg56NisEA/qR9QIM0xB
         O/njsMoIqq3Gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79140E270EF;
        Fri, 14 Oct 2022 19:13:51 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.1 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-569ea3ca-5e4e-4339-b3fa-84723ba9ca77@palmer-ri-x1c9a>
References: <mhng-569ea3ca-5e4e-4339-b3fa-84723ba9ca77@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-569ea3ca-5e4e-4339-b3fa-84723ba9ca77@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw2
X-PR-Tracked-Commit-Id: ab0c23b535f3f9d8345d8ad4c18c0a8594459d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 498574970fc968ee17cfea9e6959b78c094c00a5
Message-Id: <166577483147.24477.7861029463816667257.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:13:51 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 09:35:43 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/498574970fc968ee17cfea9e6959b78c094c00a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
