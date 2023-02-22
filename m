Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1962969F744
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBVPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBVPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E92CFC1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A2C6148E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7649AC43326;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=gFfjgz0Q8tMCqC/g+ibd4XRnh3poCdRXJ7SYTaiiMGk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iUc07ou9jr7xs7FuduwDLvvw0KikIv8SlZP1q1piXXUzcMoPtu3WuD3PH48O5QbYm
         L0as6vtkohdapB/UNVtj0ISsMuXtiXh1COxdB8Gu+LtEzGtPvTzQw5nouXApk1k8jA
         HoOMjuPQTtVlNFKNMyQmnc97UntHwZ/8foqGvWikA0hIiLNMv3c+dt7uUToS8WwtAu
         8/ZfdprXYt/wKJ7J0Mv//j2S3YBZ7uVfQ2ytGs0869oCXLNEeX5N1IHpSAHaDaH2Vg
         gUqkuu4urOWFr2Ay0iQLMCo6NZaQQDaz9zx6gMQgNqD+ZmmChUeZh2Lh1TyN12bS3+
         1l6WXTUhCXroQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DE11C395DF;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv: Dump faulting instructions in oops handler
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802237.24438.17153104207129769364.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230119074738.708301-1-bjorn@kernel.org>
In-Reply-To: <20230119074738.708301-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        schwab@linux-m68k.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 19 Jan 2023 08:47:36 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> RISC-V does not dump faulting instructions in the oops handler. This
> series adds "Code:" dumps to the oops output together with
> scripts/decodecode support.
> 
> Thanks,
> Björn
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: Add instruction dump to RISC-V splats
    https://git.kernel.org/riscv/c/eb165bfa8eaf
  - [v3,2/2] scripts/decodecode: Add support for RISC-V
    https://git.kernel.org/riscv/c/00b242509c8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


