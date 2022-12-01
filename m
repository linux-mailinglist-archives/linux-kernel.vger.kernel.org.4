Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9995463F8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiLAUKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLAUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:10:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE928C692
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE00BB82025
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93BCBC433D7;
        Thu,  1 Dec 2022 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669925417;
        bh=66gIZp8QuckhxbGJe3SHqvbaAaSZGcddv1qT3Ntjfgc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RwVxCn7ViuR1CpOVf8tT3B7ZY+mBob1+3oOGzSLAB0TXI/q6XKS6iEWR/C0+5/aVM
         PCL6ViSFQ9A607B0yyxFazctlJOP+iK4VaiVP5Rv0bi7ade1Jv3ZNGWSizyIVf7BZU
         wFk9lr3sDEIZ21tqWvNmBTX9nuTijq4o+cg4ejqgywot+dsCRFHoVx/NwBV+Q5dj8n
         8UWszWLhy/vDUuwb9ulG89WpKKovAOwdfOzwaz1KD/ajwkQyMMu2HgAxRYDDunfT8t
         xQemEoI16BHu2An+y/mVxs2S8nA01Xv/xYI2zcsK+tq3Z73k/p2WuPu+Kc/E/YwZqq
         0WFfcZaWhqMrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72C2FE52537;
        Thu,  1 Dec 2022 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] riscv: fix race when vmap stack overflow
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166992541746.24789.931668146499412553.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Dec 2022 20:10:17 +0000
References: <20221130022442.18358-1-palmer@rivosinc.com>
In-Reply-To: <20221130022442.18358-1-palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, jszhang@kernel.org,
        guoren@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 29 Nov 2022 18:24:43 -0800 you wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Currently, when detecting vmap stack overflow, riscv firstly switches
> to the so called shadow stack, then use this shadow stack to call the
> get_overflow_stack() to get the overflow stack. However, there's
> a race here if two or more harts use the same shadow stack at the same
> time.
> 
> [...]

Here is the summary with links:
  - [v4] riscv: fix race when vmap stack overflow
    https://git.kernel.org/riscv/c/7e1864332fbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


