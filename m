Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E048360E02B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiJZMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0121EAC7;
        Wed, 26 Oct 2022 05:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61453B82033;
        Wed, 26 Oct 2022 12:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B7C43141;
        Wed, 26 Oct 2022 12:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666785853;
        bh=6LTuX/xQ6IMZD8m/CLE4a7GdIxVNvlWbr19szbGf1QI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBIkrKlpZIrs7WEu4uvfJbkp+tGD7CpMplVUIJpjTbuvUtn8swhzoEVpt590lywyl
         ijkRYpN6ie87eUZb9mwiSiz34UPOZj274H13DduEmgkXs/A4ztPYruEeY+O5hO8Bph
         iA2xfKOEGpahAwkyo/5bhGSia5tL89QSNGd1N0Sj9wIznTfC0qmozFAvD6Hh1HFEVd
         i2Q4Uhi18cnImrXDWC0VOgEKcYemUOvLoZBqvqmMY/DqIflQBKzKGTxejJl9mlmTd4
         oOldE//5xKH0fcTB74SVTZr6YLn6ypI+XFkTXC591HMD+X1hB2kqCtdOrFoGmHTbx3
         Yf20MAvPc7JUw==
Received: by mail-ej1-f45.google.com with SMTP id t25so15048763ejb.8;
        Wed, 26 Oct 2022 05:04:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf1l96CWUjzEBkKjHv4oZsJK0+PU8IGHpKLCIzeWxLRvoFpiToNy
        hO88y9cpWLspZv+6jdvWUVM/ieawpWZTGH+E0+I=
X-Google-Smtp-Source: AMsMyM6b4UIXWLoTsQpMjRB4UKQywbOMmW91BTJZlw7mq+lzs5nHy5Q4XTZdyDvnaIupM/uAgrsH5IkA6cfbPB+q4JI=
X-Received: by 2002:a17:907:2cf7:b0:78d:c7fc:29ff with SMTP id
 hz23-20020a1709072cf700b0078dc7fc29ffmr38046370ejc.748.1666785851109; Wed, 26
 Oct 2022 05:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221026030256.30512-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221026030256.30512-1-zhuyinbo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 26 Oct 2022 20:03:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7jSMei+EDJ_vhoBh-kX-MVxs-vtwQwjsDnrx_zCSFAAw@mail.gmail.com>
Message-ID: <CAAhV-H7jSMei+EDJ_vhoBh-kX-MVxs-vtwQwjsDnrx_zCSFAAw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: add loongson2 clock include file
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

On Wed, Oct 26, 2022 at 11:03 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>
> This file defines all loongson2 soc clock indexes, it should be
I suggest to use regular names, i.e., don't use loongson2, Loongson2
or LOONGSON2, use Loongson-2 instead. (except in C code). And soc may
be SoC?

Huacai

> included in the device tree in which there's device using the
> clocks.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS                                   |  6 ++++
>  include/dt-bindings/clock/loongson,ls2k-clk.h | 29 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 include/dt-bindings/clock/loongson,ls2k-clk.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0be0f520c032..b6aae412de9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11907,6 +11907,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>  F:     drivers/thermal/loongson2_thermal.c
>
> +LOONGSON2 SOC SERIES CLOCK DRIVER
> +M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:     linux-clk@vger.kernel.org
> +S:     Maintained
> +F:     include/dt-bindings/clock/loongson,ls2k-clk.h
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>  M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
> new file mode 100644
> index 000000000000..db1e27e792ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
> +#define __DT_BINDINGS_CLOCK_LOONGSON2_H
> +
> +#define LOONGSON2_REF_100M                             0
> +#define LOONGSON2_NODE_PLL                             1
> +#define LOONGSON2_DDR_PLL                              2
> +#define LOONGSON2_DC_PLL                               3
> +#define LOONGSON2_PIX0_PLL                             4
> +#define LOONGSON2_PIX1_PLL                             5
> +#define LOONGSON2_NODE_CLK                             6
> +#define LOONGSON2_HDA_CLK                              7
> +#define LOONGSON2_GPU_CLK                              8
> +#define LOONGSON2_DDR_CLK                              9
> +#define LOONGSON2_GMAC_CLK                             10
> +#define LOONGSON2_DC_CLK                               11
> +#define LOONGSON2_APB_CLK                              12
> +#define LOONGSON2_USB_CLK                              13
> +#define LOONGSON2_SATA_CLK                             14
> +#define LOONGSON2_PIX0_CLK                             15
> +#define LOONGSON2_PIX1_CLK                             16
> +#define LOONGSON2_CLK_END                              17
> +
> +#endif
> --
> 2.31.1
>
>
