Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B40640E21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiLBTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiLBTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94543DBF75;
        Fri,  2 Dec 2022 11:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC7F61C35;
        Fri,  2 Dec 2022 19:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67320C433B5;
        Fri,  2 Dec 2022 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670007617;
        bh=If0m8v1brmMDcVp3BHUNVEs197Sy9gAdV8ES1Njbxbs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rJh7egSiMtfUfFIs91xYk+l3hKxnd1GXELQk1R9dC1GQQphG4vVtfKCcCUQr2+kN1
         dMgZ5UmA+bZ/XyK+5Q51yIuBxfG72EcOkwyRR8aY3611VZQW9T8PAvrTGsZcDr/+Um
         E/Wc025NTyytX6J++VFok3M54wX7UE9+WYrU6K5TEPPtqWuSASJFhRvGvdYf3fEOoT
         uDWwI4SBJxOUK0tiAmJzi0MIT0egfjjAAknm84lswIhVoVJSD8/1fllCa6SXvMBp9Y
         NocHDIKg4f1kFtMU7wz9IlasEga19MqPrQK3C+dU6oYsXVbsaYegNZuoAlyMMSz4KR
         tSTGVE4GGTH4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 480C2E21EEF;
        Fri,  2 Dec 2022 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] Basic device tree support for StarFive JH7110 RISC-V
 SoC
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167000761729.13669.16471163583440376052.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 19:00:17 +0000
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
In-Reply-To: <20221118011714.70877-1-hal.feng@starfivetech.com>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        conor@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com, tglx@linutronix.de,
        maz@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, linus.walleij@linaro.org,
        emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org
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

On Fri, 18 Nov 2022 09:17:06 +0800 you wrote:
> The original patch series "Basic StarFive JH7110 RISC-V SoC support" [1]
> is split into 3 patch series. They respectively add basic clock&reset,
> pinctrl and device tree support for StarFive JH7110 SoC. These patch
> series are independent, but the Visionfive2 board can boot up successfully
> only if all these patches series applied. This one adds basic device
> tree support. This patch series is pulled out from the patch 1~6 and
> patch 27~30 of v1 [1]. You can simply get or review the patches at the
> link [2].
> 
> [...]

Here is the summary with links:
  - [v2,1/8] dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive2 board
    (no matching commit)
  - [v2,2/8] dt-bindings: timer: Add StarFive JH7110 clint
    (no matching commit)
  - [v2,3/8] dt-bindings: interrupt-controller: Add StarFive JH7110 plic
    (no matching commit)
  - [v2,4/8] dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
    (no matching commit)
  - [v2,5/8] soc: sifive: ccache: Add StarFive JH7110 support
    (no matching commit)
  - [v2,6/8] riscv: dts: starfive: Add initial StarFive JH7110 device tree
    (no matching commit)
  - [v2,7/8] riscv: dts: starfive: Add StarFive JH7110 VisionFive2 board device tree
    (no matching commit)
  - [v2,8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
    https://git.kernel.org/riscv/c/6925ba3d9b8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


