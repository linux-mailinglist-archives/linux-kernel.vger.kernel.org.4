Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5469DA01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjBUEBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjBUEBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:01:14 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88092449E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:01:07 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id c23so1049119vkn.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aOkHbt2DwM0CDgIvRL/mxyEHP//aQl4XeYjeyOBey4A=;
        b=b+iylTa6pifiuUsPWtginkR3amD5g+GUDC7Wh3+CzjrYhHuyjRXSLt3A4xbnXF4qK8
         NlizL7XQPzOTWet6rwrDA0QE9d42LG6k274AJXjhNjDZuRyoZN0r7er34Jxvekq6dIue
         YFF/a9h1WcDzSV5Jg2o9lP3QKhAqSsYC1CUjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOkHbt2DwM0CDgIvRL/mxyEHP//aQl4XeYjeyOBey4A=;
        b=ynLv7zZinsy6ldq9Uzr1xNMk8msAjft2suda+bI1fDIx2yVJCHdyX6KwlBcg2e6/hs
         4i7uAcWdLV19d+ZRht9wyg3ozejQ8EbNYX19Ol+anCJuTGm0MN+EdpzhhD3XfAvaRf3O
         wsf6yk0TuH8tgD0m6N2wkrs5vhv1hpwUlKa11SFWzfy72JCG2ZtXLBIFQ7jQlonSeUHU
         ADDQWnLdyM/BUIxW9bxijhXjOjG7CXTs/0vS//5HYDqXtxoDGl2pp321NVAeeKpsrdD2
         5tebU9bFDTKidY0+I1WHLz9kdyV4bbnp9gF4W4qfJmSUrK7lXgjciJS6Tbv1GDsnF3cH
         aPOg==
X-Gm-Message-State: AO0yUKVBl0i9dRebSepYTHtuOrjer5lbQfGNQ+GHOd9AoUwgljybgeO8
        L7z/41KfeXa5cCbAnGw46uqom1LWEozfuh6eykk4gA==
X-Google-Smtp-Source: AK7set8EYzfpFS4t09iZSiGn9H8yH0KJIAf4682oGD9YBvGRiuQa0HIJxKrzUp9L/87daw+fVOjn7JpM6sxEWLIM/Us=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr815514vke.18.1676952067008;
 Mon, 20 Feb 2023 20:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-55-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-55-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 12:00:55 +0800
Message-ID: <CAGXv+5HOEa0+FrL-97HPsfe47taU4i8xfm-A+FytAv2v9FOj6A@mail.gmail.com>
Subject: Re: [PATCH v3 54/55] clk: mediatek: mt8135: Convert to simple probe
 and enable module build
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Convert the MT8135 clock drivers to platform_driver using the common
> simple probe mechanism.
>
> Now that all of the MT8135 clock drivers (including apmixedsys) can
> be compiled as modules, change the COMMON_CLK_MT8135 configuration
> option to tristate to enable module build.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig      |   2 +-
>  drivers/clk/mediatek/clk-mt8135.c | 110 ++++++++++++------------------
>  2 files changed, 43 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 90691261cddb..a15fbdfd3a53 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -423,7 +423,7 @@ config COMMON_CLK_MT7986_ETHSYS
>           required on MediaTek MT7986 SoC.
>
>  config COMMON_CLK_MT8135
> -       bool "Clock driver for MediaTek MT8135"
> +       tristate "Clock driver for MediaTek MT8135"
>         depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
>         select COMMON_CLK_MEDIATEK
>         default ARCH_MEDIATEK && ARM
> diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> index 8785d58cb3a5..39fd919900e5 100644
> --- a/drivers/clk/mediatek/clk-mt8135.c
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -5,8 +5,10 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
>  #include <dt-bindings/clock/mt8135-clk.h>
> @@ -18,6 +20,7 @@
>  static DEFINE_SPINLOCK(mt8135_clk_lock);
>
>  static const struct mtk_fixed_factor top_divs[] __initconst = {
> +       FACTOR(CLK_DUMMY, "top_divs_dummy", "clk_null", 1, 1),

The dummy clock stuff deserves another mention in the commit log.

Once added,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
