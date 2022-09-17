Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC435BB55F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIQBkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIQBkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:40:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10659C226;
        Fri, 16 Sep 2022 18:40:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d2so3060380wrq.2;
        Fri, 16 Sep 2022 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n9n8tkr4zFtS3Gqksx14AwLvb33nBr6DZn7TLl3O0b8=;
        b=lIPZjSDpaEpyLGb30qkJZZTnrdz4VXMJzfCY4sA8XK7Lk3pWzWBBV0HneizM0Y27YU
         zzk9S3FLFJnnX43iFrRFtv41QZS2O+rOcQXm4KVPiVvILCE/gE1gGP+Ac2ew8AR18xyY
         Y9bn/cLS3oKmIQY/0z7+MBPLy5uuQ3j7h2aLvFkj/yqUNc0ez8JhhI0zKPuXVDc/i+GD
         OcgDae24sXTk07m2cPbBiqg/zFAYu5yZ0wmpv6s7Hjszq6XIksAV7+7Ps+YCJVKDzf+D
         wVvWXeaX8EWiAl0jaKTxnKzxt/v7fsekXh8/MvJYMEoSmsAt2fJPWjmNuuYNbTeUHClO
         SvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n9n8tkr4zFtS3Gqksx14AwLvb33nBr6DZn7TLl3O0b8=;
        b=mtvZ3WbLFtc/TFW9iAXsH3r233J+vYWodLj7YgqDV5tucO0pUWcf6sxxnezi71T41X
         1Opwfjnum2AbpU5yShb2ZlVqEZJHzD86pv6vUWmhl10VYq0ejLeNUF9DWB2pBNw2HSlr
         1GdKh8bqKGoDbOSJkc54cR3mNY5TSYIfZy6lZmDAO2RaGxnJhhIPjZZvPJUyN1m6QooI
         vQfGo5IWa4L+Ph20O593hXV1O2ksyCCa1WWqnzxYm+a+7Bvk6IWVIrIJN8TpxIi5mr5L
         hBtrETMEe0h/kuWhIcoKxUCPKQSZ9bgg/8DxcNX8PgoJ2WMQ8mDymx7r380WDPGQYRUQ
         pbaw==
X-Gm-Message-State: ACrzQf0WEkp751whJ0C6dDPWSuFyn5Ru4AWCz0ff3hFXD8lFgkpYRCgK
        p8ZpSukeZbGg91CLW50YibwQaIjtORsXUC9tK6M=
X-Google-Smtp-Source: AMsMyM4v0vEb/RzDwFzi8XMH1K+KBvYVKNWnXZo51ZhOesp+cgw/Z7rqE2eD3iHn7w+A53KKYl9PRUoK4tGE2QHMBOs=
X-Received: by 2002:a5d:598a:0:b0:22a:45af:1ce2 with SMTP id
 n10-20020a5d598a000000b0022a45af1ce2mr4387382wri.539.1663378818197; Fri, 16
 Sep 2022 18:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <YySdhiqZgXpl0q/g@lab.hqhome163.com>
In-Reply-To: <YySdhiqZgXpl0q/g@lab.hqhome163.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 16 Sep 2022 21:40:07 -0400
Message-ID: <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata variant
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:06 PM Alessandro Carminati
<alessandro.carminati@gmail.com> wrote:
>
> The Quartz64 board is built upon Rockchip RK3566.
> Rockchip RK3566 has two combo phys.
> The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> ctrl2.
> The second combo phy is hardwired to the PCIe slot, where for the first,
> the hardware on the board provides both the USB3 connector and the SATA
> connector.
> This DT allows the users to switch the combo phy to the SATA connector.

Good Evening,

NACK to this whole series. Neither works correctly in the hardware as
is, and USB3 was decided to be left enabled as the SATA port will be
removed completely in the next revision.

Very Respectfully,
Peter Geis

>
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 8c843f6fc3cc..1d5dd91d1a34 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> new file mode 100644
> index 000000000000..8620df7ec01e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-quartz64-a.dtsi"
> +
> +&sata1 {
> +       status = "okay";
> +};
> --
> 2.34.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
