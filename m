Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA286C6624
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCWLGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCWLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:06:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25212CC6E;
        Thu, 23 Mar 2023 04:06:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s12so25971226qtq.11;
        Thu, 23 Mar 2023 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679569601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW/17Tw9efl+A9VHH7E/8lTWUruAqhd/zQRgcLzSatc=;
        b=PtnQ48YBtTWKj6IacZfw4DbVAMP0ZTUOzrXOCdO1yKlqj8DeErgnnrAa24Dkcnl72V
         PYO2eUPMNiyEEN7fvy1SON7Zl0D2bvfA6/VPSGrcizWsxdIxNOMf5w/0qwkZdPqxKq5R
         WQcdVUxmk/MQPrvNnWve/plCxteu6qff3AhyIMnvR7VQNOOzp6Hlvw17zSlVdCYDp1wS
         SD3H3Gxco/j3uVEUWRUlaQRSGachyKq7TraxZSFIVum7vuyD4CeiYwTNNVElYK3BgEjf
         cmujOYFX7TAErSkCVXlCbiIquPhrN5EjUUNqKJ1NqpPaJ7ZKt7Y9nCVzj7/z9Ki63SaT
         B1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW/17Tw9efl+A9VHH7E/8lTWUruAqhd/zQRgcLzSatc=;
        b=uaRvIc94/udA75Le7KC/NLZDBdioCc6ObAsTUFHs0rJnBshYz792pMeFfotyyyyo73
         fu0Bb7yrNgyjxbUC2Fo6+sw6vc+qCGLcdW+mTwR8dn4a37e6Q52SgG1flzA9k6bpsdDU
         Hc73tfDtIyl+Wsi6SAJBnKtA60XVGoulReHB3Jw3jcPRxGTMbxgiD+HWsWTL678bVVXy
         /gKiiDwyGuFmHS5I0ByHvPNaWvCIRWbcUWlsSM6Gl2XRKhV2Rbeu28y0UYxAIMUBLq0R
         hAry57kG4L9J3NxBlXNweH5x2ork8CDh4bVhAQ8yFDOZ18HMjMUMhks5Crkpb/ljGfRT
         Sntg==
X-Gm-Message-State: AO0yUKUdX7V4XEtCuvWw94SagGAM2w3MR5PbVr7nXdzGWJNLr6pFKKxO
        iYaUUBBas5mhFoMiMvWkj/6J2E0du66iR1L6H6g=
X-Google-Smtp-Source: AK7set9S2h5mRJhxQCgDXZPKYtEADtWjegSMo8ZZPfzyT4VJr1f+8hZCVs/BMNrH0OJG0BXbfSRPe4EHGs1wrWTgzMQ=
X-Received: by 2002:a05:622a:19a6:b0:3de:d15a:847f with SMTP id
 u38-20020a05622a19a600b003ded15a847fmr2750597qtc.0.1679569600966; Thu, 23 Mar
 2023 04:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230323000657.28664-1-blarson@amd.com> <20230323000657.28664-16-blarson@amd.com>
In-Reply-To: <20230323000657.28664-16-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Mar 2023 13:06:04 +0200
Message-ID: <CAHp75VcbDBUf2cH_6rRqn5RCGSEOWqE85Yn3gDhYiJPhGf1S=Q@mail.gmail.com>
Subject: Re: [PATCH v12 15/15] soc: amd: Add support for AMD Pensando SoC Controller
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:11=E2=80=AFAM Brad Larson <blarson@amd.com> wrote=
:
>
> The Pensando SoC controller is a SPI connected companion device
> that is present in all Pensando SoC board designs.  The essential
> board management registers are accessed on chip select 0 with
> board mgmt IO support accessed using additional chip selects.

...

> +config AMD_PENSANDO_CTRL
> +       tristate "AMD Pensando SoC Controller"
> +       depends on SPI_MASTER=3Dy
> +       depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
> +       default y if ARCH_PENSANDO

       default ARCH_PENSANDO

?

> +       select REGMAP_SPI
> +       select MFD_SYSCON

...

> +/*
> + * AMD Pensando SoC Controller
> + *
> + * Userspace interface and reset driver support for SPI connected Pensan=
do SoC
> + * controller device.  This device is present in all Pensando SoC design=
s and
> + * contains board control/status regsiters and management IO support.

registers ?

> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */

...

> +#include <linux/cdev.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Seems semi-random. Are you sure you use this and not missing mod_devicetabl=
e.h?

> +#include <linux/reset-controller.h>
> +#include <linux/spi/spi.h>

...

> +struct penctrl_device {
> +       struct spi_device *spi_dev;
> +       struct reset_controller_dev rcdev;

Perhaps swapping these two might provide a better code generation.

> +};

...

> +       struct spi_transfer t[2] =3D { 0 };

0 is not needed.

...

> +       if (_IOC_DIR(cmd) & _IOC_READ)
> +               ret =3D !access_ok((void __user *)arg, _IOC_SIZE(cmd));
> +       else if (_IOC_DIR(cmd) & _IOC_WRITE)
> +               ret =3D !access_ok((void __user *)arg, _IOC_SIZE(cmd));


Maybe you should create a temporary variable as

    void __user *in =3D ... arg;

?

> +       if (ret)
> +               return -EFAULT;

...

> +       /* Verify and prepare spi message */

SPI

> +       size =3D _IOC_SIZE(cmd);
> +       if ((size % sizeof(struct penctrl_spi_xfer)) !=3D 0) {

' !=3D 0' is redundant.

> +               ret =3D -EINVAL;
> +               goto done;
> +       }
> +       num_msgs =3D size / sizeof(struct penctrl_spi_xfer);

> +       if (num_msgs =3D=3D 0) {
> +               ret =3D -EINVAL;
> +               goto done;
> +       }

Can be unified with a previous check as

if (size =3D=3D 0 || size % ...)

> +       msg =3D memdup_user((struct penctrl_spi_xfer __user *)arg, size);
> +       if (!msg) {
> +               ret =3D PTR_ERR(msg);
> +               goto done;
> +       }

...

> +       if (copy_from_user((void *)(uintptr_t)tx_buf,
> +                          (void __user *)msg->tx_buf, msg->len)) {

Why are all these castings here?

> +               ret =3D -EFAULT;
> +               goto done;
> +       }

...

> +       if (copy_to_user((void __user *)msg->rx_buf,
> +                        (void *)(uintptr_t)rx_buf, msg->len))
> +               ret =3D -EFAULT;

Ditto.

...

> +       struct spi_transfer t[2] =3D { 0 };

0 is redundant.

...

> +       struct spi_transfer t[1] =3D { 0 };

Ditto.

Why is this an array?

...

> +       ret =3D spi_sync(spi_dev, &m);
> +       return ret;

return spi_sync(...);

...

> +       np =3D spi_dev->dev.parent->of_node;
> +       ret =3D of_property_read_u32(np, "num-cs", &num_cs);

Why not simply device_property_read_u32()?

> +       if (ret)
> +               return dev_err_probe(&spi_dev->dev, ret,
> +                                    "number of chip-selects not defined"=
);

...

> +       cdev =3D cdev_alloc();
> +       if (!cdev) {
> +               dev_err(&spi_dev->dev, "allocation of cdev failed");
> +               ret =3D -ENOMEM;

ret =3D dev_err_probe(...);

> +               goto cdev_failed;
> +       }

...

> +       ret =3D cdev_add(cdev, penctrl_devt, num_cs);
> +       if (ret) {

> +               dev_err(&spi_dev->dev, "register of cdev failed");

dev_err_probe() ?

> +               goto cdev_delete;
> +       }

...

> +       penctrl =3D kzalloc(sizeof(*penctrl), GFP_KERNEL);
> +       if (!penctrl) {

> +               ret =3D -ENOMEM;
> +               dev_err(&spi_dev->dev, "allocate driver data failed");

ret =3D dev_err_probe();
But we do not print memory allocation failure messages.

> +               goto cdev_delete;
> +       }

...

> +               if (IS_ERR(dev)) {
> +                       ret =3D IS_ERR(dev);
> +                       dev_err(&spi_dev->dev, "error creating device\n")=
;

ret =3D dev_err_probe();

> +                       goto cdev_delete;
> +               }
> +               dev_dbg(&spi_dev->dev, "created device major %u, minor %d=
\n",
> +                       MAJOR(penctrl_devt), cs);
> +       }

...

> +       spi_set_drvdata(spi_dev, penctrl);

Is it in use?

...

> +       penctrl->rcdev.of_node =3D spi_dev->dev.of_node;

device_set_node();

...

> +       ret =3D reset_controller_register(&penctrl->rcdev);
> +       if (ret)
> +               return dev_err_probe(&spi_dev->dev, ret,
> +                                    "failed to register reset controller=
\n");
> +       return ret;

return 0;

...

> +       device_destroy(penctrl_class, penctrl_devt);

Are you sure this is the correct API?

> +       return ret;

...

> +#include <linux/types.h>
> +#include <linux/ioctl.h>

Sorted?

--=20
With Best Regards,
Andy Shevchenko
