Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490A6E198C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNBUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DC2D5F;
        Thu, 13 Apr 2023 18:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 452606097C;
        Fri, 14 Apr 2023 01:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B2C3C4339B;
        Fri, 14 Apr 2023 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681435218;
        bh=+mGU8LvAZW8m7fj90vpPY/gIjF8LyNG9Tk6TfIjRLj8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DLSA+HM43trQJjMeZ+5Kar1a7wrKhAsShy2AiA04YR1mhKNqwOGLO8lBuvRa/zY+Q
         a2PS6nXlPC6LcS4Wrbko/i64qRWpOi6OZf7pHfiL0I0YlJzheyxaHT4woO0QotdJbo
         32mhm9J+vWxjGNUQoCjOne8qhenMUeBcuMEtCJRaXypTu4VK6CpQnD/igTq4mZrxmQ
         oWVBc2sVgfpZEJY/adMA28tRUzqyTpq0JtIzbeljD9/PD7ldfEAfZvPJtDCrvEII13
         sLFPDpI3yReuSLfA0KYDizVbLTtMb4balB82cOGkgW4Y7CWFM/zfvkcdU3WU5lxyRL
         tabL96NKH4eaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C328E5244F;
        Fri, 14 Apr 2023 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2 0/3] Fixes for dtb mapping
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168143521837.16022.279979629741476730.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 01:20:18 +0000
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
In-Reply-To: <20230329081932.79831-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 29 Mar 2023 10:19:29 +0200 you wrote:
> We used to map the dtb differently between early_pg_dir and
> swapper_pg_dir which caused issues when we referenced addresses from
> the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapping
> to the fixmap region in patch 1, which allows to simplify dtb handling in
> patch 2.
> 
> base-commit-tag: v6.3-rc3
> 
> [...]

Here is the summary with links:
  - [-fixes,v2,1/3] riscv: Move early dtb mapping into the fixmap region
    https://git.kernel.org/riscv/c/ef69d2559fe9
  - [-fixes,v2,2/3] riscv: Do not set initial_boot_params to the linear address of the dtb
    https://git.kernel.org/riscv/c/f1581626071c
  - [-fixes,v2,3/3] riscv: No need to relocate the dtb as it lies in the fixmap region
    https://git.kernel.org/riscv/c/1b50f956c8fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


