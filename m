Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2426B62E7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiKQWCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbiKQWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:01:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A0769E8;
        Thu, 17 Nov 2022 14:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1316229A;
        Thu, 17 Nov 2022 22:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2208C433D6;
        Thu, 17 Nov 2022 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668722418;
        bh=EQGEv3Nu7IK3z1Y1+oz4Z5dM0RTYZ7IZ6JOUOFqyWpA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PlyUkU2rJlK8veAqTZ/BsmBiuQABXeQ/8jd+06iDO56ADr0q87u3AUFLjFA8KmURw
         19Gx4WG7VHpf6VPPYkebRU/nllZg3sPVqznmkzMlU22XQuCbSWj+Vt9gR3DO+/a3Ws
         nco0VDSdOFHXTCmAdmbdGrdRFeGsB3e93zEFRnDV4zPuKSGdw3LsY+wZuitEVdvqEQ
         3aMB2bhIQiPRGshBp6yDJWpivQ9ieTopLd1QqvxFWiT4aD7JYxt/QXTDVdG5Dc/sSr
         sdtiKk+Q/l9SlBzfiV3RNrV/RVV36ODgPiQXEFHlx77UE29YeDTZ92q9mI1YzXlaEH
         J3uRR7nGwlJwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93E4CE270D5;
        Thu, 17 Nov 2022 22:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] RZ/Five: Enable ADC/CANFD/I2C/OPP/Thermal Zones/TSU
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166872241859.10037.9436719894893258084.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Nov 2022 22:00:18 +0000
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lad@ci.codeaurora.org, Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, magnus.damm@gmail.com,
        conor.dooley@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
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

On Tue, 15 Nov 2022 10:51:32 +0000 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> This patch series aims to enable support for below blocks
> on RZ/Five SoC/SMARC EVK:
> - ADC
> - CANFD
> - I2C
> - OPP
> - Thermal Zones
> - TSU
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: Kconfig: Enable cpufreq kconfig menu
    https://git.kernel.org/riscv/c/effae0e3d9e1
  - [2/3] riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/Thermal Zones/TSU
    (no matching commit)
  - [3/3] riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


