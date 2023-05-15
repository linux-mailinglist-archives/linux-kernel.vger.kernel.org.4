Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB6703F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbjEOVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245482AbjEOVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:06:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E01249D;
        Mon, 15 May 2023 14:06:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7576516c81fso1023913485a.1;
        Mon, 15 May 2023 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184768; x=1686776768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnW5odOIl209ldVWmskt+AjKdinI022npGq6Rl6Tuk4=;
        b=lt4/tFJNniCL3BGJWHEnW6vpGUnYqkAy0C7U8Dz3NtyXbzr5rD/Vi/x/cDFCk1EgoY
         vSdjvsF7qGVCtbzF5XmkcoFn0p9XfYbw3Mg/OdEZRfVgxyu8di/coB9NI5gZh/K73y5X
         uETQqs8xYYmzBkt0YfZidhmC8C3VZ6UP+LOKgEGf0/3VlKwE+9keseBVxK/Cv9ckaDPB
         /qCtKdmvvo6arEwnhmzlNorKTqR/sFMoHVUGrMjvlnNVxOn2WUvlLlYylWSbBsPUmDTS
         V2M1q6P9ejQfryn/OTWI3c3ZFKiN4Mk8OBUAGLTVtI4MQvm/9N2HGWmyUX0DROCQh4wl
         ieag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184768; x=1686776768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnW5odOIl209ldVWmskt+AjKdinI022npGq6Rl6Tuk4=;
        b=J71Np63CyOMaMTVTRnTP0/zm+2MsrG4PQP1CN1qFWZ5uIUwq02h23GNcR+sWeySo6M
         Bm/rEOxg/5KoJhYEDvGfdbBi3uETqB/j7AIWaMRR6Su7GPvsr2b07CRIp6vNLi/48+8X
         u9J4Im3VO7I5X4rb1HcW6VwJz67rHp8aMMSChtD2lcPdZWwIgHONVfmOFLZwIWeu38ty
         vmW3CVRjgPnipHvcLPCwuOsvZcwCks+BYIjAQ0B9XMLrA2/bemJth6+rC4Eha4pGfZ1m
         NOmsQ3WF7c97DfmH3fBAf+rLITRl5YHCDLUCPh4c5Zq6Qd2WDO53tFfG51rXj4My/aq8
         dm7w==
X-Gm-Message-State: AC+VfDzNzAUFOIjjxHPssAYgl19K6I8IEoaThkm4F9GcgO491ctjk/41
        TfnlpHSm1thNj2/RXjmvkEJbmbTXyXLiQgv2YR4=
X-Google-Smtp-Source: ACHHUZ59JIYWfaOAor95geBeywF1zNMCbQCXuKjUklIfS1gTt5MWGz1M0FxPTDEGMfsN/Tr45qn9TSLm9oYKAK22T8M=
X-Received: by 2002:a05:6214:260e:b0:616:5c8b:582 with SMTP id
 gu14-20020a056214260e00b006165c8b0582mr64910908qvb.37.1684184768478; Mon, 15
 May 2023 14:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230515181606.65953-1-blarson@amd.com> <20230515181606.65953-9-blarson@amd.com>
In-Reply-To: <20230515181606.65953-9-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 00:05:32 +0300
Message-ID: <CAHp75VdsfcHOOUHuAVA38kdUyq+vwMKFYCNxScogGAJDM8ywBQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 9:18=E2=80=AFPM Brad Larson <blarson@amd.com> wrote=
:
>
> The Pensando SoC controller is a SPI connected companion device
> that is present in all Pensando SoC board designs.  The essential
> board management registers are accessed on chip select 0 with
> board mgmt IO support accessed using additional chip selects.

...

> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/of.h>

Unneeded inclusion.

> +#include <linux/reset-controller.h>
> +#include <linux/spi/spi.h>

...


> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];

Does it need to be DMA-capable?

...

> +       spi->chip_select =3D current_cs;
> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[current_cs];

Nowadays these require API calls instead of direct assignments.

...

> +static int penctrl_release(struct inode *inode, struct file *filp)
> +{
> +       filp->private_data =3D NULL;
> +       return 0;
> +}

Is it possible to unload the module without releasing the device node?

...

> +       u8 txbuf[3];
> +       u8 rxbuf[1];

Same question about DMA.

...

> +       ret =3D spi_sync(spi, &m);

> +       if (ret =3D=3D 0)
> +               *val =3D rxbuf[0];
> +
> +       return ret;

Can also be written in more usual way:

  if (ret)
    return ret;
  ...
  return 0;

...

> +       u8 txbuf[4];

DMA?

...

> +       spi->chip_select =3D 0;
> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[0];

Setter APIs.

...

> +       spi->chip_select =3D 0;
> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[0];

Ditto.


> +       ret =3D device_property_read_u32(spi->dev.parent, "num-cs", &num_=
cs);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "number of chip-selects not defined\=
n");

Hmm... Shouldn't SPI core take care of this in a generic way? Yes, I
understand that you need the number for the allocation, but I would
expect something like spi_fw_get_num_cs() to exist (seems not?).

...

> +       penctrl->rcdev.of_node =3D spi->dev.of_node;

Use device_set_node(). It helps to modify the data types beneath.

--
With Best Regards,
Andy Shevchenko
