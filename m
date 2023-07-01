Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA093744A56
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGAPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGAPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A892707;
        Sat,  1 Jul 2023 08:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DC060B06;
        Sat,  1 Jul 2023 15:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DCC5C433C9;
        Sat,  1 Jul 2023 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688226304;
        bh=ra42rcphL7tKW7I45Ex8nV8bC3r82UuPkw0dfoyiW7w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mmGzBb8jTH4fWOy+MNZiXnhPYutdgMzfYBZLCgmZ/ahpceab/0Cqy3s+SSNxK5QVE
         U4tAJr2SSY0YOAocXGfYFWzSKL8xOCHEyEv+8sIIWM8j5zNAm9bQd8Q9JjvzXUKWFW
         vFQF6ixBc15d41oYC12IADIsWOFfZVKUp+MFdCSiYP0fkZ3UNedNctHuEjVsjO5cp7
         oygFROQHAp1ArGWdQYnV/5rQ/CVmBE/tuW8Eny1KTa/b5C1/+SDBPghstrwU2hYk/j
         RrHrXE6tg7B504hYC5s4HPy5hb7cUcdWkr4tJAoVPmcxXdEDpYmbNGnkCWF5gyXkxI
         C2t0aIRX2B43g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EEDEC6445B;
        Sat,  1 Jul 2023 15:45:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 00/11] Add STG/ISP/VOUT clock and reset drivers for
 StarFive JH7110
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168822630425.22742.10407688185048619244.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Jul 2023 15:45:04 +0000
References: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
In-Reply-To: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        conor@kernel.org, kernel@esmil.dk, robh+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hal.feng@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

This series was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Thu, 18 May 2023 18:12:23 +0800 you wrote:
> This patch serises are base on the basic JH7110 SYSCRG/AONCRG
> drivers and add new partial clock drivers and reset supports
> about System-Top-Group(STG), Image-Signal-Process(ISP)
> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
> clocks and resets could be used by DMA, VIN and Display modules.
> 
> Patches 1 and 2 are about the System-Top-Group clock and reset
> generator(STGCRG) part. The first patch adds docunmentation to
> describe STG bindings, and the second patch adds clock driver to
> support STG clocks and resets as auxiliary device for JH7110.
> 
> [...]

Here is the summary with links:
  - [v6,01/11] dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and reset generator
    (no matching commit)
  - [v6,02/11] clk: starfive: Add StarFive JH7110 System-Top-Group clock driver
    (no matching commit)
  - [v6,03/11] dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock and reset generator
    (no matching commit)
  - [v6,04/11] clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
    (no matching commit)
  - [v6,05/11] dt-bindings: clock: Add StarFive JH7110 Video-Output clock and reset generator
    (no matching commit)
  - [v6,06/11] clk: starfive: Add StarFive JH7110 Video-Output clock driver
    (no matching commit)
  - [v6,07/11] MAINTAINERS: Update maintainer of JH71x0 clock drivers
    (no matching commit)
  - [v6,08/11] reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
    (no matching commit)
  - [v6,09/11] riscv: dts: starfive: jh7110: add pmu controller node
    https://git.kernel.org/riscv/c/6a887bcc4138
  - [v6,10/11] riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external clocks
    (no matching commit)
  - [v6,11/11] riscv: dts: starfive: jh7110: Add STGCRG/ISPCRG/VOUTCRG nodes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


