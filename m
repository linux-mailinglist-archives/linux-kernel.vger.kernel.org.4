Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D124169A4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBQEbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBQEbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:31:35 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7F498A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:31:34 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id j5so4326980vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rn/OmYfGz3HlNF4zZ6zIKzHGJ/JlR0OYd4bSBBLtvEA=;
        b=UXYLlZtdc5jXdgeXyTyGujX2S8FoYZoQki0xcU8Uu2kOhKFR9Mi3/cT2XW2RuZ9Dox
         LcAyX9DfJJ5dOAYEk05t8jzQjcYMmcfHbRHfgy227juzjnLMlOax7DphA1tX6lVmwTuP
         5RTrc+W1w6A7qsHRPWTwfsD8PudbfnOx9L3IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn/OmYfGz3HlNF4zZ6zIKzHGJ/JlR0OYd4bSBBLtvEA=;
        b=pMA7GTVJZQfjPjOjCZcGNI2ruZWzLcGrNfwsrBx/i6PZOFcWzNOCK5YrCMSNCxxHFb
         UjDbzvI/BmfbKBvejTyRqdmf+12ESQI0So39jqkKHut2JFs0DyzUBsLLvt/zLoc4HVeS
         JuIimXdC4zKwCR/wRi3r6pvI8pue6a3qN3/Sbw+LO2rQzdmOh6Vh80I0OhNn9XNfJH3c
         R+cOfShnJWjMfXWwzSMcZC0yVUwPSvpB+6SF5Apxby4fbf8qhsT6BRYSjIIZVN1PGx4Y
         hUbtg4V/RAmBpG23JK6Vqdc9xejqt8NDx51la/I+22YAGYCTTxT91vsN7h/r2IaGEaJA
         Mabw==
X-Gm-Message-State: AO0yUKWwC9xtExKjjxvQurY/FdWiensRS66SHguVQVK+b+iRDMootm9Q
        xYdk+smDfn0vHRcotUWkpC0XChcsF3C3wAXGQIU8eQ==
X-Google-Smtp-Source: AK7set+RpbyryePA3PgFybbN8hipd8wGwv4jo+RuWVcM6nO3ydmFwiScewRsMc4d2x4qF7+myO9dlYpU5kECAXb2nOI=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1531710vso.60.1676608293769; Thu, 16 Feb
 2023 20:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:31:22 +0800
Message-ID: <CAGXv+5H7=rOwVK2SapqyeKHKnRJMwXFf1OSD-qhgjkbkoR=Zmw@mail.gmail.com>
Subject: Re: [PATCH v2 37/47] clk: mediatek: Split MT8195 clock drivers and
 allow module build
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
> option: there's no reason to do that, as it is totally unnecessary to
> build in all or none of them.
>
> Split them out: keep boot-critical clocks as bool and allow choosing
> non critical clocks as tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig  | 86 +++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/Makefile | 20 +++++---
>  2 files changed, 99 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 45b7aea7648d..88937d111e98 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -692,6 +692,92 @@ config COMMON_CLK_MT8195
>          help
>            This driver supports MediaTek MT8195 clocks.
>
> +config COMMON_CLK_MT8195_APUSYS
> +       tristate "Clock driver for MediaTek MT8195 apusys"
> +       depends on COMMON_CLK_MT8195

Would something like

          default COMMON_CLK_MT8195

help with the transition?

Otherwise we'd need to add a whole lot more stuff to arm64's defconfig,
and anyone running `make olddefconfig` would have many of their clock
drivers no longer available.

Same applies to the MT8186 split.

Seems like not all MediaTek SoCs apply this pattern, but at least MT7986,
MT8167, MT8173, MT8183 do this.

ChenYu
