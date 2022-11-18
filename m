Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868462F42A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiKRMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiKRMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:01:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6D94A5C;
        Fri, 18 Nov 2022 04:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50328B82383;
        Fri, 18 Nov 2022 12:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA437C433D6;
        Fri, 18 Nov 2022 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668772894;
        bh=gHY8oh7bKt9m5LJsvFCMjLzXQtR+VjOph9E0FEYxKbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPtmoEZ23cwe60TX4GGMt8EKk5ditunPtY2IkkyM3Hmha/8v4AqecsM8Uiyjqc5Tp
         88Q4VRbKySxZnQbzkRs8zqGWhze60QwDd9wNe/ZSYJQl8Fa1UB6a7bYof5TToe7/E4
         lri7CcWIZhTUU7rfTA+zaXr83l3rvHQ6Gmb4SRpfTjpxpkY3mavrU+nfA0Ifpw1Trs
         2mHY6OnIhWsB9BzDICrx55F7YFIPNHjHXPWNXzV1yEybIvqZP5fKe0Rw5803kPe+3R
         V6beSqI93xmjoibE4sbzlAOgl3ETr4LvWP/64fgGThp0UqGU7QuT1xgbuvn1HJ425W
         ORNq/O2GTmZpQ==
Date:   Fri, 18 Nov 2022 12:01:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y3d0GE7msiWGlRcd@spud>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-7-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118011714.70877-7-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:17:12AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 437 +++++++++++++++++++++++
>  1 file changed, 437 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> new file mode 100644
> index 000000000000..c22e8f1d2640
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>

@Emil, I feel like I have to ask given the 2022 date, but should this
stuff be attributed to your canonical address or is this fine?

Other than that, a cursory check /looks/ fine, other than the:

> +       gmac0_rgmii_rxin: gmac0_rgmii_rxin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };

If you remove the clock-frequency = <0> bit, dtb validation will force
people to set the value in jh7110-board.dts which I'd prefer to rely on
than a comment.

Glad to see you sorted out the clock/reset stuff too!

Thanks,
Conor.
























































































































































































































































































































































































































































