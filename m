Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14E6026BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJRI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJRI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEC75391;
        Tue, 18 Oct 2022 01:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1383E614A5;
        Tue, 18 Oct 2022 08:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE012C433C1;
        Tue, 18 Oct 2022 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666081586;
        bh=UowTUUvEVmL7Nt2IJNzxp9eCQ0n5rjbDsLqZOF2gprs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqUvoCfo3fLUef5sdX9Tsr9E5gjICAMab8NI0jZ32ODhv5hAbs8GpRr6VBjnTVMvm
         e1tUU7Rg99YoPJ74Q+MEj/ZOajC8/tYAQ0UEru5IjFTSUfUpgl7Q/RH8jp1zM31Alu
         AgO15qzgx6+ytjMgKAU4FvGKDcXuyYwQqDk8YDX3fmvEjSe8YNfS40RLSO1xqiJ5ll
         vlRiF0LWw2TrzAy4TvzTtmxwrvBexgUxLABSxLLVRNRNK3wkUBPgr8uM2MC+bpKCjS
         lFJOMUos77609fv0+91fG8VdHgW6xAX52iSqGCrdal5O0Ljdraz3iPsc4rJ0Y8hhb/
         ALHQGCYOOfHxQ==
Date:   Tue, 18 Oct 2022 10:26:20 +0200
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: Add StarFive VisionFive V1
 device tree
Message-ID: <Y05jLAjYR+JldAqD@ziggy.stardust>
References: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
 <20221017210542.979051-4-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017210542.979051-4-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:05:42AM +0300, Cristian Ciocaltea wrote:
> Add initial device tree for the StarFive VisionFive V1 SBC [1], which
> is similar with the already supported BeagleV Starlight Beta board,
> both being based on the StarFive JH7100 SoC.
> 
> [1] https://github.com/starfive-tech/VisionFive
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  2 +-
>  .../jh7100-starfive-visionfive-v1.dts         | 20 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 0ea1bc15ab30..039c143cba33 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb jh7100-starfive-visionfive-v1.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> new file mode 100644
> index 000000000000..e82af72f1aaf
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2021 StarFive Technology Co., Ltd.
> + * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7100-common.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "StarFive VisionFive V1";
> +	compatible = "starfive,visionfive-v1", "starfive,jh7100";
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&gpio 63 GPIO_ACTIVE_HIGH>;
> +		priority = <224>;
> +	};
> +};
> -- 
> 2.38.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
