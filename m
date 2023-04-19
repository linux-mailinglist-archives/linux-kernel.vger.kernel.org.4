Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDD6E7CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjDSOax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjDSOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F80AF3A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A99615D4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 618E5C433EF;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914622;
        bh=3GJL08UQ5T50uXQNNpKgWldke5xsbQdeX8PVBzZ1dls=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mngx4+wXO49ZYROCoPjuV0ixDSGI0mgFVagpIIbixh/mGPE4+nNOjxGBll4elwaMs
         GXF2hoYusxo4WnRVB7JVtE3MYcEkbBxc5WDf1sWlbnoS/t1Zcu1FFD2ctttvo3DP9e
         B3kyObgtLVO+kE05X7BYkg3FhvWUYE5Pna95TYaj+NG9sgXFI4VBVJYs81h6gSo1Am
         ZKYmXcxa97p5f7e8/dA+drjzkDO0TOhhYt/FI9HzJuX2DtRNc1Nw5xgdqRgbYJP2Pq
         drxKYFNu88yAvLWzXkoilZ7VEwV4wG8nRxQJ43ID6sglTZX3hWEnIQDWc0oNJ2xMLH
         pYmIXLJF4NLgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B12EE270E7;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168191462230.22791.11892683089171760503.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 14:30:22 +0000
References: <20230323123924.3032174-1-suagrfillet@gmail.com>
In-Reply-To: <20230323123924.3032174-1-suagrfillet@gmail.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Mar 2023 20:39:24 +0800 you wrote:
> RISC-V now manages CPU topology using arch_topology which provides
> CPU capacity and frequency related interfaces to access the cpu/freq
> invariant in possible heterogeneous or DVFS-enabled platforms.
> 
> Here adds topology.h file to export the arch_topology interfaces for
> replacing the scheduler's constant-based cpu/freq invariant accounting.
> 
> [...]

Here is the summary with links:
  - [V2] riscv: export cpu/freq invariant to scheduler
    https://git.kernel.org/riscv/c/c4b52d8b6c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


