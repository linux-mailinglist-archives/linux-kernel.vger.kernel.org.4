Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A476C0E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCTKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCTKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:12:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75C793EE;
        Mon, 20 Mar 2023 03:11:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n13so523046qkh.5;
        Mon, 20 Mar 2023 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679307115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEHX2H3FPvonaNoZg4d3ZXKZZZCxjwbRPNv3Abil3kY=;
        b=pGRG8DR8czC6mIySn8c+XY/QyPsxNJby0FDmm6hU8zH3srOc1pzYmcAtzW++zTsVST
         oIKxOe+AVWw3Q/vF2tZU81xD0VZuk+6u66OpAtC8p6jZyD8wmZhAZSJFOAuerqDP/Vo7
         TBo9jbf5dZR5AvNjqQ8y4q31DORWt/TGC1jexEA460NOlL8vYpwY1zSiFzLLTZMDoQuI
         2IZbSZnw6mQl4D81ehGAV4TERB7EvlqTNvfy4Mr9ntcUMQjf2WYyzSa68Nbzy2ZU3Koa
         P3KZ1aMChHLD6su7o5vLa3LQ+d2V6OaFKe2DagbmdM9TKAlM4Ol7RHA3UY53SbomsUy8
         z5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEHX2H3FPvonaNoZg4d3ZXKZZZCxjwbRPNv3Abil3kY=;
        b=gDMwWkABYDLCxNPiH5+aIukMq1V+wLK91mhRjvPoKjbljqOMLTNbW6YuYWn0zYfUjv
         emJ/dF791PAyftOp8O8ExSDI1rntFMUJhtSNgZAHBywTPlU197fnvFPwEyfj6wi5FRUZ
         9TWFF3qUYzxOGCkiMK6TxxgR0hpSmjxsKaxmblnWSpC6NhSE0w1+73kCecUrYMXcNWUz
         DMakMW5Ljaovd+95gtsF7jfRwGPN+l/vj/a2HzSN5Pbzmrns2t+BNO0/ux6NHvug5eoE
         cV9GXAv4r8WyRK5pJJpebd8yvq4YC9d0N0obT7DtsEO3XGVbItDZHxT9Lh8qoC7kdC2e
         wWTQ==
X-Gm-Message-State: AO0yUKVkMmSu/PayECjGngfBMkS2RuR0k333lfE5Jwh/eYeFFZHpJL0b
        MvPNKBsbG1UtMBgsG7HGsrcAQHNH/HQ6tzHVG9M=
X-Google-Smtp-Source: AK7set/7f2o3MXyyuIp0oW2dzmomSD1AeJIwa/bkGf1KaepstcBoZ2oGQTq2OW/QrKdEOrRxx9NAQwjPPU8J1KTvGK8=
X-Received: by 2002:a37:e119:0:b0:746:3c7f:7524 with SMTP id
 c25-20020a37e119000000b007463c7f7524mr2618315qkm.14.1679307115447; Mon, 20
 Mar 2023 03:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230319115925.1317654-1-sensor1010@163.com> <CAHp75Vf9kwhbZaGjZeN5Jq0Wr_yJtDdj9N48-3o79AMORqmS3w@mail.gmail.com>
In-Reply-To: <CAHp75Vf9kwhbZaGjZeN5Jq0Wr_yJtDdj9N48-3o79AMORqmS3w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 12:11:19 +0200
Message-ID: <CAHp75VeLoMPtTU8TCuPjXD_YTY-_V-TmVJYeZiBB_BPqh8EVrQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/gpio : Remove redundant platform_set_drvdata().
To:     Lizhe <sensor1010@163.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, geert+renesas@glider.be,
        info@metux.net, rjui@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        sbranden@broadcom.com, shc_work@mail.ru, j-keerthy@ti.com,
        hoan@os.amperecomputing.com, fancer.lancer@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kaloz@openwrt.org, khalasa@piap.pl, keguang.zhang@gmail.com,
        daniel@thingy.jp, romain.perier@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, mani@kernel.org,
        ludovic.desroches@microchip.com, andy@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, jonathanh@nvidia.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        michal.simek@xilinx.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-unisoc@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:10=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Mar 19, 2023 at 2:01=E2=80=AFPM Lizhe <sensor1010@163.com> wrote:
> >
> > platform_set_drvdata() is redundant in these functions.
> > the purpose of calling this function is to place data
> > in *driver_data. but the data is not retrieved in these
> > functions
>
> You need to:
> 1) split the series on per driver basis (not all of the drivers are
> going thru the same subsystem);

s/subsystem/tree/

> 2) improve English grammar and style in your commit message;
> 3) carefully explain in the cover letter your methods of finding the
> places you think need to be improved.
>
> Before that it's a waste of time to look at your contributions.


--=20
With Best Regards,
Andy Shevchenko
