Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE469F73F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBVPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjBVPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2938B55;
        Wed, 22 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02BD61497;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F054C4339B;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=kydm5AUKJGxRvRaP4t7C0EB2bX0fweLM9h2sQNC5Byk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QF3n4CqTvoxq/NH0jcIs+uxO22bVplSaoDzshEHaQOMhvaTBW/4E6zp5cZ/VZXp/g
         bfU3plMH8gGfZMD60MfsbT2/w+HfXObEFE4SyPNv8dyrCCWVMxjK9SvGrl9Jrdma2I
         +6G6XkqdZYk4h7cdDVOalAo138K8MtM6m8AqViv0lQs+L3mMGXPESWi0CLM4Srb/p1
         2eaYzlNWP1/APrj6yxG9gLyPCEblere/O8Gpa4CM5mVo5CEzDx6oI+YNOamYXANL0k
         Fw+84oT7ckBU5zcOGQSg4ZTV3ben/mIIPV4PO1ClYnTBmWrY2IyIRAqizCx1S75+DI
         RKnc6BmjWNYRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E663EC395DF;
        Wed, 22 Feb 2023 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/19] Basic clock,
 reset & device tree support for StarFive JH7110 RISC-V SoC
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802193.24438.5407460288169239541.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:21 +0000
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
In-Reply-To: <20230221024645.127922-1-hal.feng@starfivetech.com>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, maz@kernel.org,
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

On Tue, 21 Feb 2023 10:46:26 +0800 you wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC. Patch 17 depends on series [1] which provides pinctrl
> dt-bindings. Patch 19 depends on series [2] which provides dt-bindings
> of VisionFive 2 board and JH7110 SoC.
> 
> You can simply review or test the patches at the link [3].
> 
> [...]

Here is the summary with links:
  - [v4,01/19] clk: starfive: Factor out common JH7100 and JH7110 code
    (no matching commit)
  - [v4,02/19] clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
    https://git.kernel.org/riscv/c/f3af3b0039fe
  - [v4,03/19] clk: starfive: Rename "jh7100" to "jh71x0" for the common code
    (no matching commit)
  - [v4,04/19] reset: Create subdirectory for StarFive drivers
    (no matching commit)
  - [v4,05/19] reset: starfive: Factor out common JH71X0 reset code
    (no matching commit)
  - [v4,06/19] reset: starfive: Extract the common JH71X0 reset code
    (no matching commit)
  - [v4,07/19] reset: starfive: Rename "jh7100" to "jh71x0" for the common code
    (no matching commit)
  - [v4,08/19] reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
    (no matching commit)
  - [v4,09/19] dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
    (no matching commit)
  - [v4,10/19] dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
    (no matching commit)
  - [v4,11/19] clk: starfive: Add StarFive JH7110 system clock driver
    (no matching commit)
  - [v4,12/19] clk: starfive: Add StarFive JH7110 always-on clock driver
    (no matching commit)
  - [v4,13/19] reset: starfive: Add StarFive JH7110 reset driver
    (no matching commit)
  - [v4,14/19] dt-bindings: timer: Add StarFive JH7110 clint
    (no matching commit)
  - [v4,15/19] dt-bindings: interrupt-controller: Add StarFive JH7110 plic
    (no matching commit)
  - [v4,16/19] dt-bindings: riscv: Add SiFive S7 compatible
    (no matching commit)
  - [v4,17/19] riscv: dts: starfive: Add initial StarFive JH7110 device tree
    (no matching commit)
  - [v4,18/19] riscv: dts: starfive: Add StarFive JH7110 pin function definitions
    (no matching commit)
  - [v4,19/19] riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device tree
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


