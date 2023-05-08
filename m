Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6B6FB326
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjEHOmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjEHOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C16E81;
        Mon,  8 May 2023 07:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C63264074;
        Mon,  8 May 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79973C4331E;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556916;
        bh=iiK+/z6CHwJS0C1NeEmEWs+kZ4yRiOpMM4oq3dhmQMA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oD2N2ApPYCUX15+T/aoqbi8hBBsCsi/nM1W74A0Au9Rv2QM/7nVsd0b+Rjqql5+CZ
         XC9x8YusKHhbFzMYd8/rKiAZKo+VWLpxqqHxoyW1E+YUg4z/pPZudQNiPuEDcpWye6
         5sUQf3/ms5YdMxxBBinVDnlBgGmPHePwTlzzrv6+7EPRw+ShPRSbuxPkXSpy+63jYa
         /icexnPsOMnz/kyZxVQTnEWAOrE2FS0/e+Bc0q6+yakVuZXnUm+zUPkCM17k5Yb6FM
         +9Lya6QE4dUVSb9+Thi28513dGrAb08lMW53IPCJp8Z2ZCqDuOOzn1GVUj2sURDibd
         q+DMDWehcEYkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AA9AE26D2A;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] dt-bindings: perf: riscv,pmu: fix property dependencies
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168355691636.25692.16621694024321930278.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 14:41:56 +0000
References: <20230404-tractor-confusing-8852e552539a@spud>
In-Reply-To: <20230404-tractor-confusing-8852e552539a@spud>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, atishp@rivosinc.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, ajones@ventanamicro.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rob Herring <robh@kernel.org>:

On Tue,  4 Apr 2023 19:03:22 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Seemingly I mis-implemented the dependencies here. The OpenSBI docs only
> point out that the "riscv,event-to-mhpmcounters property is mandatory if
> riscv,event-to-mhpmevent is present". It never claims that
> riscv,event-to-mhpmcounters requires riscv,event-to-mhpmevent.
> 
> [...]

Here is the summary with links:
  - [v1] dt-bindings: perf: riscv,pmu: fix property dependencies
    https://git.kernel.org/riscv/c/4d276e4d3bb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


