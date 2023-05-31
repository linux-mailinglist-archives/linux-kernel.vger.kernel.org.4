Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84717185C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjEaPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjEaPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC27107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B2863D23
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF5E3C4339E;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685545822;
        bh=5lizdQwgDjzOGRTGSgGaTLL6eAMn99hHqlDNrARDpUk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E41USqB9H6f/NtMA+9VU3/1/VbnKpMqBKUz3W5QQZ+/M5i0WlFNEC3xQ2KDAU6PEU
         cXr7n0Xy3Gbciq65TDQxyRhnh5V0bmRMCHf5HdW6FDjo3huHXGOvY2UQBi2PK7m/gg
         +NQHOQfe8HfjwVQqT4TvuFruAlM4Qg7mgMquQZS6MXsUieaHC2En8T4I3Iysxvbb+e
         4E7Iz4EKXMcjcIrXwlRqc/WgD+NPnDob3XzDAxRbgMrNlsIM6dlHgeYgW/DTaoFW10
         4TLIsvhFC7ZT2vfvtQ3pTUCo7x3ZU9CcT6NQJ9puqviZ/H8OhksUFkG6PGHRA5SGBn
         cWxnlDni2icsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6AFDE21EC4;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix unused variable warning when BUILTIN_DTB is
 set
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168554582187.8247.15042711269697974982.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 15:10:21 +0000
References: <20230519131311.391960-1-alexghiti@rivosinc.com>
In-Reply-To: <20230519131311.391960-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 19 May 2023 15:13:11 +0200 you wrote:
> commit ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap
> region") wrongly moved the #ifndef CONFIG_BUILTIN_DTB surrounding the pa
> variable definition in create_fdt_early_page_table(), so move it back to
> its right place to quiet the following warning:
> 
> ../arch/riscv/mm/init.c: In function ‘create_fdt_early_page_table’:
> ../arch/riscv/mm/init.c:925:12: warning: unused variable ‘pa’ [-Wunused-variable]
>   925 |  uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix unused variable warning when BUILTIN_DTB is set
    https://git.kernel.org/riscv/c/33d418da6f47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


