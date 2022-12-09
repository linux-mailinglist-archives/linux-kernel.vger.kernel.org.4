Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253C7647B74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLIBa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB86801ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AB42B826F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E419CC43392;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670549418;
        bh=XjQfoNgG2GiBY7jADESEO1zAcbSoAJAF8r+mKWMXI44=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VCFTcA500RiRVb3k1OLCZE9KysbeMc0XG4FVUlDrdJdioIbiXxTFaQbtfTYj6hgcU
         ls5dRn9ZCg3U4wkr1i4Hi87ueFnHVZcnd3WwnJtJXbyXlPknJQ3u6uvwLs62FS5isX
         TxXxu+GBgtP6ZkDoS37IE44ANlI/f/jNgdAHO1Ti0HnnFcqbcK5N7vav+8+by3uPZG
         X44OfIwmUgMwLsmDp772AHksWOI27iFed8b8oXCoVc1fmlIG7UzhDD1U3romgceMg+
         0vIgf6SlgxqsC6GOV1t7s7Ak1KjKkWs9U2DkXlwlQ2e23EPcEmSG8GFLbIuQFfzqM0
         gxSw4AF2aN7uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC219C41606;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/3] Add PMEM support for RISC-V
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167054941883.3046.11002142340745112697.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 01:30:18 +0000
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, atishp@atishpatra.org, heiko@sntech.de,
        arnd@arndb.de, anup@brainfault.org, linux-kernel@vger.kernel.org
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

On Mon, 14 Nov 2022 14:35:33 +0530 you wrote:
> The Linux NVDIMM PEM drivers require arch support to map and access the
> persistent memory device. This series adds RISC-V PMEM support using
> recently added Svpbmt and Zicbom support.
> 
> First two patches are fixes and remaining two patches add the required
> PMEM support for Linux RISC-V.
> 
> [...]

Here is the summary with links:
  - [v6,1/3] RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
    https://git.kernel.org/riscv/c/b91676fc16cd
  - [v6,2/3] RISC-V: Implement arch specific PMEM APIs
    https://git.kernel.org/riscv/c/a49ab905a1fc
  - [v6,3/3] RISC-V: Enable PMEM drivers
    https://git.kernel.org/riscv/c/497bcbe3ce04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


