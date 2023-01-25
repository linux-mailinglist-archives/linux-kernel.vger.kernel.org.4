Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3067B92C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjAYSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjAYSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4F37F3B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9501E61502
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02891C4339C;
        Wed, 25 Jan 2023 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674670817;
        bh=O7NW1qzcvc7518X7Nz3EHWkjaBzP1VAAR59iPu7PRto=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hMDniqmzw2Vh2kAKkpHqElF/TedbZbcR90WhE2qZ5DxRhy1ZxzbjaHDd0aFI+2bFk
         Krd5roNCa2GzghZ/9SDD/MPwm/BKYxD7kbMRW/uokWVSlSp7DrbF5dOdE3X9HF5BwP
         pnuQHVoQUkllnQS9HTn/AlYNuLZKssUa1ZM4aWkSasmGTxOhTUv3JdvIHjTGpmaO2q
         PP99uTFB6lmj0NCQjklWkGJuIhTtUsjISFCCF3MmhQsiTbUzOKpofNTXFlj7Qcf1hB
         xhbTrZ51YWjadNcV5ImZyZvRUtj3XTE1+5q/qHMo4H2aNlnv4dcw946PoU+jVGd5Oq
         WBWE8h/9UEPtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFDD5F83ED0;
        Wed, 25 Jan 2023 18:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Move call to init_cpu_topology() to later
 initialization stage
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167467081691.5568.11613849837435850604.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 18:20:16 +0000
References: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
To:     Leyfoon Tan <leyfoon.tan@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 5 Jan 2023 11:37:05 +0800 you wrote:
> If "capacity-dmips-mhz" is present in a CPU DT node,
> topology_parse_cpu_capacity() will fail to allocate memory.
> ARM64, with which this code path is shared, does not call
> topology_parse_cpu_capacity() until later in boot where memory allocation
> is available.
> 
> Move init_cpu_topology(), which calls topology_parse_cpu_capacity(), to a
> later initialization stage, to match ARM64.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Move call to init_cpu_topology() to later initialization stage
    https://git.kernel.org/riscv/c/c1d610586946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


