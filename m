Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F669F740
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBVPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBVPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2738B7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE63F6149E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55601C43442;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=sAD41qlfpUmeVTbNrsaNBRxCTKKHTpb6EbOTUc1nL0c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V0GT9cQpOdFsMVan0RIVmmJO+AJk4l/zpz/IuknM0eLQAWsPzL5hKHWyYPotVvWC/
         iExM48uAxvBH+w+0Jq78YGe4QyD1XXSYMfoCpk5izibz/MCysGVp+193+kKHKA2rtr
         /YJeUHHnmY79nLNHzWfK3un7fSEDdaiYta01V6q1RYfD1FxgWUzyDqhSvSWHaPkzvC
         QHLNMeHCPDgpFGYkFFt5Aq/Met4mYxXT9hVHw5VquKkiontLPESjEZgJayccvGT9fW
         9uw/s10f3er9LoaawnufdN6uDtuTiVSZB4sz2uGojc6kMt1Q8mQ12fU6V8/x6mBJ/6
         OOoq+Z+g37U7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DCB4C691DE;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802217.24438.17901281821213780885.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230129094242.282620-1-liaochang1@huawei.com>
In-Reply-To: <20230129094242.282620-1-liaochang1@huawei.com>
To:     liaochang (A) <liaochang1@huawei.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        ajones@ventanamicro.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        vincent.chen@sifive.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 29 Jan 2023 17:42:42 +0800 you wrote:
> Add header include guards to insn.h to prevent repeating declaration of
> any identifiers in insn.h.
> 
> Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/include/asm/insn.h | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - riscv: Add header include guards to insn.h
    https://git.kernel.org/riscv/c/8ac6e619d9d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


