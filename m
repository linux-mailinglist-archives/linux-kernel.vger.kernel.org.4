Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB867A967
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjAYDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAYDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:50:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399754900B;
        Tue, 24 Jan 2023 19:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B343B6144D;
        Wed, 25 Jan 2023 03:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B82DC4339C;
        Wed, 25 Jan 2023 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674618619;
        bh=5zYmil3GpjhlKKEO9HlMg1matkV2+zsa3NF9i+Idsaw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QYYA1Z0/PbzFDo8jvAvczuNLHcVO9ml0x5u3HcjnIfdZLSX41QzZnBxyor1elhfLm
         Gc1MUf7+c0N8W9HnXviYlwtBw65xD/GaEEwXGNTBWs1S8RRfR1NxzgQOyX1gyLuxnf
         IQGnNQD3wyG40/hbQ+m82/67Hd+5KILCbHbLQPOTfmvLwP1KTY2rhQPhlR1B0qhb+B
         Gg7PiA7PT8jHr92jX9h1R5vauTzL0nXVWnh0u5YaBJRG+8upI/TwrFePJW+wH65+Mo
         NZLPvY/cds/pnpXkDEoc/WF0xrcazmiJYoOoK+Yzd4HvSB+lG/F1rH5vK5Qsedz0Kl
         0sUmfwSDD3NKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC620F83ECD;
        Wed, 25 Jan 2023 03:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Putting some basic order on isa extension lists
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167461861889.411.5843489021071731633.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 03:50:18 +0000
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
In-Reply-To: <20221205144525.2148448-1-conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu, conor@kernel.org,
        corbet@lwn.net, guoren@kernel.org, heiko@sntech.de,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
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

On Mon, 5 Dec 2022 14:45:23 +0000 you wrote:
> For v2+, I added another path with some uapi docs & switched to Drew's
> suggested ordering of alphabetically, except in the /proc/cpuinfo array,
> as per the discussion today in the pw-sync call. I also added a
> sprinkling of comments around which things should be sorted in which
> way.
> 
> Pasting from the chat on v2, since it's relevant to whether re-ordering
> what appears in /proc/cpuinfo is even permitted..
> 
> [...]

Here is the summary with links:
  - [v2,1/3] RISC-V: clarify ISA string ordering rules in cpu.c
    https://git.kernel.org/riscv/c/99e2266f2460
  - [v2,2/3] RISC-V: resort all extensions in consistent orders
    https://git.kernel.org/riscv/c/80c200b34ee8
  - [v2,3/3] Documentation: riscv: add a section about ISA string ordering in /proc/cpuinfo
    https://git.kernel.org/riscv/c/f07b2b3f9d47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


