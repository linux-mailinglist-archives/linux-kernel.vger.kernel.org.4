Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A66260D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiKKSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiKKSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98976FBA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:03:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5015B826C5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B4D2C43470;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189783;
        bh=cIRDXIK2WBCPZtiqE0k37LqxFETqLLE19X+Yfais0BM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VXUgxSb65XR5dbrFZOmhGnQzSOXxdutH6oN0n6KqegTokt6rJts2JrMBJPQEX0WbF
         ZRcT0q/zwKTn2+iN5tIiHFNLD43LbLpWc+IhCjwwicyJLJKmMpme/eC9uA90Rf3wce
         KQjFK9wwbh8m7rbEQr8PURmCE8KO5tkEgpF712EYPKf+IyWByh62O/OikTWcMuYQZ2
         mInCuwjiwYLlB/+pWwUnIxrxjhVec2/Q2YfMTK35h8wp6bQKz246LPOKFDWNvTtP6y
         dHnv1VLn2vGUDz7jG0IPSVhJKwuYh5jQrNGvtqdPf2xot0SU+FZpfr5sS/OmZthmhn
         YDbwoy9KIj6nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BCBCE270EF;
        Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-a9c9d14d-1da7-4c8d-b117-b207616f77a4@palmer-ri-x1c9>
References: <mhng-a9c9d14d-1da7-4c8d-b117-b207616f77a4@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-a9c9d14d-1da7-4c8d-b117-b207616f77a4@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc5
X-PR-Tracked-Commit-Id: fcae44fd36d052e956e69a64642fc03820968d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 991f173cd23cea2b4102cb78f779a7a43c29e76f
Message-Id: <166818978330.15878.2811608566324625785.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:03 +0000
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

The pull request you sent on Fri, 11 Nov 2022 08:58:46 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/991f173cd23cea2b4102cb78f779a7a43c29e76f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
