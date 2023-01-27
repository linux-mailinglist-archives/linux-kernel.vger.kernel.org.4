Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51CA67F035
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjA0VOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjA0VOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA348A546
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C5AC61DA0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D528DC433D2;
        Fri, 27 Jan 2023 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854082;
        bh=777o8q30/9HQNkSmQaK6BcTRR8GGs/P5WNImavVy2rY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b8Krx6lmVPp6gfPvxfQ7vw4yMaMuBtALB57f0Tr3ADt5/I7huaQyZ2IYJ/UbuOmR4
         yAWNwe2HVyvdSiTTiirLM0tfC2snKUFRk08HhUmqumt+Qm02mrcqzCxTOkkCnpyunR
         KvXTfDhNYvbZczP9BFLTVVzJ6wj9MKugYdHSIqD8insafpa/ByXRX8N5w1WcSNeT8+
         Fh8ewdXnj3CwlZylB4R5fceBvXuRBayKCd51HljpP5uw13TGhIFo/ldZEkkXPc5pO0
         jEPK4RTvkvUgxFnrDmWViEkRsCflt08SzywKFWX1RQ/u3050xtbjKcdDtAI2cHOb0A
         vZKkp6I+G1c4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2C64E52504;
        Fri, 27 Jan 2023 21:14:42 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e9212465-c032-4266-b8ea-a40f2bdcc767@palmer-ri-x1c9>
References: <mhng-e9212465-c032-4266-b8ea-a40f2bdcc767@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-e9212465-c032-4266-b8ea-a40f2bdcc767@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc6
X-PR-Tracked-Commit-Id: c1d6105869464635d8a2bcf87a43c05f4c0cfca4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db7c4673bbd30e54e28a3274dd50fe6a5e28a8b8
Message-Id: <167485408279.14056.11354819331577715108.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:14:42 +0000
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

The pull request you sent on Fri, 27 Jan 2023 09:38:54 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db7c4673bbd30e54e28a3274dd50fe6a5e28a8b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
