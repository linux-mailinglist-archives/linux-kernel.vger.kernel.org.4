Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03263B610
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiK1XkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiK1XkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566261DF08
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F02B81025
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9514C433D7;
        Mon, 28 Nov 2022 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669678815;
        bh=6mPlbaUReAz5hkyqzULKNUBalSvtA+axzTczmuk1Snk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WMALrFjvnJ425z8bodXqzHP5ZOCjr9cmW3ca3LKTaCRqXvYMAMBUC4QODhGKGY77C
         HPAwyXlqZj0izpNUjh7wKI4BnKuk74KcWjWGXNR3IiBkpUi/8eMZD80awcjH56XvGi
         EdM9WmRCWKHzcLcyBo3Yd5btygOgfPS2nuz02iA57xCzR8sOjA0NT/VwXovOTK6NbA
         mpdVeiQ629ubF0oos7LD07R7v47Bg41UT6ZqJazt7TSkcQBCrD9T9/CKKDbII+mxxB
         Eumpm+knDh7q0BCFGqEB/ynyVNKW3L970EOcfd19ZOqSbuAVr9+flH2rBwefZ3Y1s0
         H4E1XUAeUEwpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81601E21EF7;
        Mon, 28 Nov 2022 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix NR_CPUS range conditions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166967881552.1570.15037145347501399600.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Nov 2022 23:40:15 +0000
References: <20221126061557.3541-1-samuel@sholland.org>
In-Reply-To: <20221126061557.3541-1-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        heinrich.schuchardt@canonical.com, paul.walmsley@sifive.com,
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 26 Nov 2022 00:15:56 -0600 you wrote:
> The conditions reference the symbol SBI_V01, which does not exist. The
> correct symbol is RISCV_SBI_V01.
> 
> Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> [...]

Here is the summary with links:
  - riscv: Fix NR_CPUS range conditions
    https://git.kernel.org/riscv/c/1d6b5ed41f8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


