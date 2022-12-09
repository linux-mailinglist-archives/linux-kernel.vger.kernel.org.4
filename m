Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B816488BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLITAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLITAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF851572F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C63DB828E7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F573C433D2;
        Fri,  9 Dec 2022 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670612416;
        bh=HhzObmealiumgLE/hiuztZWY02q27ALbHNUmhYu2rz4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IQWboPdjYV6eaUeyNme4FGwk/Agx0y+09lvz1u2bxhEZGhmJRMM/GTiUvmsGsf4sC
         HXuxRXdwY4vXdWjyUDkxVyPNQJ+deqkqUWRvjPnv4/JPlCZg5aadvzuzGaa/cttvQx
         0PmKJ540LHLLYiksmrpCfc0FDkvsdzHmHMYweUdiRQlX5yuyB7HQk9dmuaT7jaw06L
         Ge43ziueva9jR4jIbpUtNIMwAvs2lcQVn1RRznGH3EQHx1WJWGSpjIHG/8310mFpJO
         OftjQotEFD5TtlT2WiSn27LiAWPKjs/dCgesrIHXLVpvkqRItQWdG0sevKPRmWUndc
         Ao/XT3y4zn8Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F30E1B4D8;
        Fri,  9 Dec 2022 19:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] riscv: Fix crash during early errata patching
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167061241627.2369.16766839910285576298.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 19:00:16 +0000
References: <20221126060920.65009-1-samuel@sholland.org>
In-Reply-To: <20221126060920.65009-1-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        heiko@sntech.de, aou@eecs.berkeley.edu,
        alexandre.ghiti@canonical.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 26 Nov 2022 00:09:19 -0600 you wrote:
> The patch function for the T-Head PBMT errata calls __pa_symbol() before
> relocation. This crashes when CONFIG_DEBUG_VIRTUAL is enabled, because
> __pa_symbol() forwards to __phys_addr_symbol(), and __phys_addr_symbol()
> checks against the absolute kernel start/end address.
> 
> Fix this by checking against the kernel map instead of a symbol address.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: Fix crash during early errata patching
    https://git.kernel.org/riscv/c/61b2f0bdaa3c
  - [v2,2/2] riscv: Move cast inside kernel_mapping_[pv]a_to_[vp]a
    https://git.kernel.org/riscv/c/583286e2072e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


