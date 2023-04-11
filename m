Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F716DD67E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDKJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:21:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B11FC1;
        Tue, 11 Apr 2023 02:21:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u4so10766477qkp.11;
        Tue, 11 Apr 2023 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681204879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22gDPxW19cMTzdI2UhZhZwmtD5x1mNyQ4dBwOLlhZII=;
        b=HKAWQACd1BNdP9u4q1d9uEtrMUPhJuCx/jDIszfAwS87wK3UHR2MWEgOlgHm3Cu8oi
         o9ZUbfyM/dfLOJiFbz5as8miyRY99sryRpOUigRlnHUnvhxZ2h2JqBw0VJr+k/FABAvX
         VPnHPYz+Owo+2XzfkW1klN6YOGdOXpQQLPn3pkuBeifJqlCXd6xAopXkxggwtCGg8B2o
         RMA1VskLCWd+M8k9AkkqUwz3Oyfdax7kFPNdubEq+xJxMX1fHiPgjyM+4ilMolx1fQr5
         FDvU0wu/jdXCxj2ho/0yw9YhIA/py/1KRXlRdTXA8h2/YbvD5lDhmyehVXm6Zg86lNU8
         Cbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681204879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22gDPxW19cMTzdI2UhZhZwmtD5x1mNyQ4dBwOLlhZII=;
        b=j5S5J6upRqLnvmvQPjLhmiHBHL5pYQ4f/KmiPO36b1dzV8GUaiNJvzXohF+LMAPH9U
         ikRVukWOw3k5pGNSjCOnmDwta6Lr5H4j8JLqUygTC1RQ7K/DjQ4I1BjxElAG+aCqx8D4
         GvTUUl9myx0eIFKRq+AfN8RoQ06CMennBuaLr+AFhO0cOaRfvo+h6TRrQ8RRcovFAP81
         oEh3NltJQQnNK+w1YXVTj1ftRdiXw2j2JzEHqhB1bDuDVAXixH45vpy7w+RJ7fRZP2uX
         vrwi06EzN7M4325phyxWcvshwc374TmUvBjqGzJCn3d7A9mCmlUtbBecWH7RY0+LZrs1
         Q3zA==
X-Gm-Message-State: AAQBX9et+WSyiTGhdnqlKm9JQ2MW2uf1QRxLqZU6Iw0Xh8rtGXztG1eh
        e+0ohEZhAJ1HU9aNtGwdxZklk5y7LIHar420DFs=
X-Google-Smtp-Source: AKy350ai4GhRDj+9tWUfu907SY8Mp4Y+3HcbuSVSCBzAmG2vHJwTCZ9mRm8qy/TdKub90t5rC0KW0Zhf6a2sDPeYbmM=
X-Received: by 2002:a05:620a:290f:b0:742:412d:1dc6 with SMTP id
 m15-20020a05620a290f00b00742412d1dc6mr3955959qkp.14.1681204879411; Tue, 11
 Apr 2023 02:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-16-blarson@amd.com>
In-Reply-To: <20230410184526.15990-16-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Apr 2023 12:20:43 +0300
Message-ID: <CAHp75VewhdOwqkuwHKT9e120Zgfhnp5x-sgaayWJPC4kZ=VxZw@mail.gmail.com>
Subject: Re: [PATCH v13 15/15] soc: amd: Add support for AMD Pensando SoC Controller
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

On Mon, Apr 10, 2023 at 9:48=E2=80=AFPM Brad Larson <blarson@amd.com> wrote=
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
> +#include <linux/reset-controller.h>
> +#include <linux/spi/spi.h>

+ Blank line?

> +#include <linux/amd-pensando-ctrl.h>

...

> +struct penctrl_device {
> +       struct spi_device *spi;
> +       struct reset_controller_dev rcdev;

Try to swap them and check if the code will be smaller (it depends on
how often one or another member is being used),

> +};

...

> +static long
> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       void __user *in_arg =3D (void __user *)arg;
> +       struct penctrl_device *penctrl;
> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];
> +       struct spi_transfer t[2] =3D {};
> +       struct penctrl_spi_xfer *msg;
> +       struct spi_device *spi;
> +       unsigned int num_msgs;
> +       struct spi_message m;
> +       u32 size;
> +       int ret;
> +
> +       /* Check for a valid command */
> +       if (_IOC_TYPE(cmd) !=3D PENCTRL_IOC_MAGIC)
> +               return -ENOTTY;
> +
> +       if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
> +               return -ENOTTY;
> +
> +       if (_IOC_DIR(cmd) & _IOC_READ)
> +               ret =3D !access_ok(in_arg, _IOC_SIZE(cmd));
> +       else if (_IOC_DIR(cmd) & _IOC_WRITE)
> +               ret =3D !access_ok(in_arg, _IOC_SIZE(cmd));

> +

Unneeded blank line.

> +       if (ret)
> +               return -EFAULT;

But it seems you can actually rewrite above in less lines:

       if ((_IOC_DIR(cmd) & _IOC_READ) && !access_ok(in_arg, _IOC_SIZE(cmd)=
))
         return -EFAULT;

       if ((_IOC_DIR(cmd) & _IOC_WRITE) && !access_ok(in_arg, _IOC_SIZE(cmd=
)))
         return -EFAULT;

> +       /* Get a reference to the SPI device */
> +       penctrl =3D filp->private_data;
> +       if (!penctrl)
> +               return -ESHUTDOWN;
> +
> +       spi =3D spi_dev_get(penctrl->spi);
> +       if (!spi)
> +               return -ESHUTDOWN;
> +
> +       /* Verify and prepare SPI message */
> +       size =3D _IOC_SIZE(cmd);
> +       num_msgs =3D size / sizeof(struct penctrl_spi_xfer);
> +       if (size =3D=3D 0 || size % sizeof(struct penctrl_spi_xfer)) {
> +               ret =3D -EINVAL;
> +               goto done;
> +       }
> +       msg =3D memdup_user((struct penctrl_spi_xfer *)arg, size);

> +       if (!msg) {
> +               ret =3D PTR_ERR(msg);

This is strange.

> +               goto done;
> +       }
> +       if (msg->len > PENCTRL_MAX_MSG_LEN) {
> +               ret =3D -EINVAL;
> +               goto done;
> +       }
> +
> +       t[0].tx_buf =3D tx_buf;
> +       t[0].len =3D msg->len;
> +       if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len))=
 {
> +               ret =3D -EFAULT;
> +               goto done;
> +       }
> +       if (num_msgs > 1) {
> +               msg++;
> +               if (msg->len > PENCTRL_MAX_MSG_LEN) {
> +                       ret =3D -EINVAL;
> +                       goto done;
> +               }
> +               t[1].rx_buf =3D rx_buf;
> +               t[1].len =3D msg->len;
> +       }
> +       spi_message_init_with_transfers(&m, t, num_msgs);

It seems there is no validation for the messages 3+.

> +       /* Perform the transfer */
> +       mutex_lock(&spi_lock);
> +       ret =3D spi_sync(spi, &m);
> +       mutex_unlock(&spi_lock);
> +
> +       if (ret || (num_msgs =3D=3D 1))
> +               goto done;
> +
> +       if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
> +               ret =3D -EFAULT;

> +done:

out_unlock: ?

> +       spi_dev_put(spi);
> +       return ret;
> +}
> +
> +static int penctrl_open(struct inode *inode, struct file *filp)
> +{
> +       struct spi_device *spi;
> +       u8 current_cs;

> +       if (!penctrl)
> +               return -ENODEV;

Is it possible?

> +       filp->private_data =3D penctrl;
> +       current_cs =3D iminor(inode);
> +       spi =3D penctrl->spi;
> +       spi->chip_select =3D current_cs;

> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[current_cs];

Hmm... Why do you need this one? Isn't it a job of SPI core?

> +       spi_setup(spi);
> +       return stream_open(inode, filp);
> +}

> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u3=
2 *val)
> +{
> +       struct spi_device *spi =3D penctrl->spi;
> +       struct spi_transfer t[2] =3D {};
> +       struct spi_message m;
> +       u8 txbuf[3];
> +       u8 rxbuf[1];
> +       int ret;
> +
> +       txbuf[0] =3D PENCTRL_SPI_CMD_REGRD;
> +       txbuf[1] =3D reg;
> +       txbuf[2] =3D 0;
> +       t[0].tx_buf =3D txbuf;
> +       t[0].len =3D 3;

sizeof(txbuf) ?

> +       rxbuf[0] =3D 0;
> +       t[1].rx_buf =3D rxbuf;
> +       t[1].len =3D 1;

sizeof(rxbuf) ?

> +       spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
> +       ret =3D spi_sync(spi, &m);
> +       if (ret =3D=3D 0)
> +               *val =3D rxbuf[0];
> +
> +       return ret;
> +}
> +
> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u=
32 val)
> +{
> +       struct spi_device *spi =3D penctrl->spi;
> +       struct spi_transfer t;
> +       struct spi_message m;
> +       u8 txbuf[4];
> +
> +       txbuf[0] =3D PENCTRL_SPI_CMD_REGWR;
> +       txbuf[1] =3D reg;
> +       txbuf[2] =3D val;
> +       txbuf[3] =3D 0;
> +
> +       t.tx_buf =3D txbuf;
> +       t.len =3D 4;

sizeof(txbuf) ?

> +       spi_message_init_with_transfers(&m, &t, 1);
> +       return spi_sync(spi, &m);
> +}
> +
> +static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
> +                               unsigned long id)
> +{
> +       struct penctrl_device *penctrl =3D
> +               container_of(rcdev, struct penctrl_device, rcdev);
> +       struct spi_device *spi =3D penctrl->spi;
> +       unsigned int val;
> +       int ret;
> +
> +       mutex_lock(&spi_lock);
> +       spi->chip_select =3D 0;
> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[0];
> +       spi_setup(spi);
> +       ret =3D penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
> +       if (ret) {
> +               dev_err(&spi->dev, "error reading ctrl0 reg\n");
> +               goto done;
> +       }
> +
> +       val |=3D BIT(6);
> +       ret =3D penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
> +       if (ret)
> +               dev_err(&spi->dev, "error writing ctrl0 reg\n");

> +done:

out_unlock: ?

> +       mutex_unlock(&spi_lock);
> +       return ret;
> +}
> +
> +static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
> +                                 unsigned long id)
> +{
> +       struct penctrl_device *penctrl =3D
> +               container_of(rcdev, struct penctrl_device, rcdev);
> +       struct spi_device *spi =3D penctrl->spi;
> +       unsigned int val;
> +       int ret;
> +
> +       mutex_lock(&spi_lock);
> +       spi->chip_select =3D 0;
> +       spi->cs_gpiod =3D spi->controller->cs_gpiods[0];
> +       spi_setup(spi);
> +       ret =3D penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
> +       if (ret) {
> +               dev_err(&spi->dev, "error reading ctrl0 reg\n");
> +               goto done;
> +       }
> +
> +       val &=3D ~BIT(6);
> +       ret =3D penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
> +       if (ret)
> +               dev_err(&spi->dev, "error writing ctrl0 reg\n");

> +done:

out_unlock: ?

> +       mutex_unlock(&spi_lock);
> +       return ret;
> +}

> +static int penctrl_spi_probe(struct spi_device *spi)
> +{
> +       struct device *dev;
> +       struct cdev *cdev;
> +       u32 num_cs;
> +       int ret;
> +       u32 cs;
> +
> +       ret =3D device_property_read_u32(spi->dev.parent, "num-cs", &num_=
cs);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "number of chip-selects not defined\=
n");
> +
> +       ret =3D alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "failed to alloc chrdev region\n");
> +
> +       penctrl_class =3D class_create(THIS_MODULE, "penctrl");
> +       if (IS_ERR(penctrl_class)) {
> +               ret =3D dev_err_probe(&spi->dev, PTR_ERR(penctrl_class),
> +                                   "failed to create class\n");
> +               goto unregister_chrdev;
> +       }
> +
> +       cdev =3D cdev_alloc();
> +       if (!cdev) {
> +               ret =3D dev_err_probe(&spi->dev, -ENOMEM,
> +                                   "allocation of cdev failed\n");
> +               goto destroy_class;
> +       }
> +       cdev->owner =3D THIS_MODULE;
> +       cdev_init(cdev, &penctrl_fops);
> +
> +       ret =3D cdev_add(cdev, penctrl_devt, num_cs);
> +       if (ret) {
> +               ret =3D dev_err_probe(&spi->dev, ret,
> +                                   "register of cdev failed\n");
> +               goto free_cdev;
> +       }
> +
> +       /* Allocate driver data */
> +       penctrl =3D kzalloc(sizeof(*penctrl), GFP_KERNEL);
> +       if (!penctrl) {
> +               ret =3D -ENOMEM;
> +               goto free_cdev;
> +       }
> +       penctrl->spi =3D spi;
> +       mutex_init(&spi_lock);
> +
> +       /* Create a device for each chip select */
> +       for (cs =3D 0; cs < num_cs; cs++) {
> +               dev =3D device_create(penctrl_class,
> +                                   &spi->dev,
> +                                   MKDEV(MAJOR(penctrl_devt), cs),
> +                                   penctrl,
> +                                   "penctrl0.%d",
> +                                   cs);
> +               if (IS_ERR(dev)) {
> +                       ret =3D dev_err_probe(&spi->dev, PTR_ERR(dev),
> +                                           "error creating device\n");
> +                       goto destroy_device;
> +               }
> +               dev_dbg(&spi->dev, "created device major %u, minor %d\n",
> +                       MAJOR(penctrl_devt), cs);
> +       }
> +
> +       /* Register emmc hardware reset */
> +       penctrl->rcdev.nr_resets =3D 1;
> +       penctrl->rcdev.owner =3D THIS_MODULE;
> +       penctrl->rcdev.dev =3D &spi->dev;
> +       penctrl->rcdev.ops =3D &penctrl_reset_ops;

> +       penctrl->rcdev.of_node =3D spi->dev.of_node;

Either redundant or wrong. Shouldn't you first have the firmware node
to be set for spi->dev?

> +       device_set_node(&spi->dev, dev_fwnode(dev));
> +
> +       ret =3D reset_controller_register(&penctrl->rcdev);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "failed to register reset controller=
\n");
> +       return 0;
> +
> +destroy_device:
> +       for (cs =3D 0; cs < num_cs; cs++)
> +               device_destroy(penctrl_class, MKDEV(MAJOR(penctrl_devt), =
cs));
> +       kfree(penctrl);
> +free_cdev:
> +       cdev_del(cdev);
> +destroy_class:
> +       class_destroy(penctrl_class);
> +unregister_chrdev:
> +       unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
> +
> +       return ret;
> +}

...

> +++ b/include/uapi/linux/amd-pensando-ctrl.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for /dev/penctrl
> + *
> + * This file can be used by applications that need to communicate
> + * with the AMD Pensando SoC controller device via the ioctl interface.
> + */
> +#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H
> +#define _UAPI_LINUX_AMD_PENSANDO_CTRL_H

> +#include <linux/ioctl.h>

Not used header.

> +#include <linux/types.h>
> +
> +#define PENCTRL_SPI_CMD_REGRD  0x0b
> +#define PENCTRL_SPI_CMD_REGWR  0x02
> +#define PENCTRL_IOC_MAGIC      'k'
> +#define PENCTRL_IOC_MAXNR      0
> +#define PENCTRL_MAX_MSG_LEN    16
> +#define PENCTRL_MAX_REG                0xff
> +#define PENCTRL_REG_CTRL0      0x10
> +
> +struct penctrl_spi_xfer {
> +       __u64 tx_buf;
> +       __u64 rx_buf;
> +       __u32 len;
> +       __u32 speed_hz;
> +       __u64 compat;
> +};
> +
> +#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */

--=20
With Best Regards,
Andy Shevchenko
