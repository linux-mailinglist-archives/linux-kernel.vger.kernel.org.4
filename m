Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3F63138E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKTLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKTLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:09:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF23F068;
        Sun, 20 Nov 2022 03:09:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CCD60C37;
        Sun, 20 Nov 2022 11:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADF9C433D6;
        Sun, 20 Nov 2022 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668942569;
        bh=vnyH8G1WUbHbEn7eQvky+ZPnOfOJ4emdGiMvxdIUtSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgiEMPVSngYVdZ7fTokegvHRQhWn8tlEaWT0A86kyG7WIt11GOw7N5AkaEYp+sTy5
         2f552pb6+g4zD+BL0IqVvHcpgnrNc32HZUPC1OBnl6O6OP5P4YhBtI+Aybddao0OD4
         6neM5gWBr5j+i9oR+t5Gq9mH3n2EZSUXeXgUydZFaBYwBGZ7OugaPWGPrgLvRaTfQ4
         2SrgomtnHgXi9Q3LT2BBV7C60NKqEOd4IqYgDnmT3p7o7IT3+dmGQgYiV95G9ypQ7v
         Q39Xu32JzP1L1wlHPCsZ78qcG4Pb8v4aRVTOwIMULtlLcSuFCpQiEPtHd2mDyGc95L
         +SIoaaVCGE5og==
Date:   Sun, 20 Nov 2022 11:09:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 6/7] riscv: dts: bouffalolab: add Sipeed M1S dock
 devicetree
Message-ID: <Y3oK5B2yYL8+JzLs@spud>
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120082114.3030-7-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 04:21:13PM +0800, Jisheng Zhang wrote:
> Sipeed manufactures a M1S system-on-module and dock board, add basic
> support for them.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/bouffalolab/Makefile      |  2 ++
>  .../boot/dts/bouffalolab/bl808-sipeed-m1s.dts | 30 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> 
> diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
> new file mode 100644
> index 000000000000..42e17e1a97bd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_BOUFFALOLAB) += bl808-sipeed-m1s.dtb
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> new file mode 100644
> index 000000000000..64421fb2ad67
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "bl808.dtsi"
> +
> +/ {
> +	model = "Sipeed M1S";
> +	compatible = "sipeed,m1s", "bouffalolab,bl808";

These compatibles also need to be defined, in a bouffalolab.yaml in the
riscv/ bindings subdirectory. Otherwise:
arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtb:0:0: /: failed to match any schema with compatible: ['sipeed,m1s', 'bouffalolab,bl808']

Thanks,
Conor.

> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:2000000n8";
> +	};
> +
> +	memory@50000000 {
> +		device_type = "memory";
> +		reg = <0x50000000 0x04000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 2.37.2
> 
