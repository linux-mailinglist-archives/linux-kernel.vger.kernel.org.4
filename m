Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3529666C15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjALIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbjALIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:07:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670FE0BE;
        Thu, 12 Jan 2023 00:06:23 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u9so42860070ejo.0;
        Thu, 12 Jan 2023 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw4BILlZdZjbYgmMptkOXd4Dpap1q3LZNS3gplMIW2Q=;
        b=gkXvyqOUMBx7o6gX+uWc1L0fJyrnDYD7QtMbjHb3cnpE+H38OQ2jdhXwRGx071aFCy
         O8RVZC8A5Hg6FZ6GYT7KxpSV8gA+KjDINw6yaV+cHsCWwflNr7hQWtwgUZq3qfHzrHTD
         VSM2gPIcHmRPi1gvt70e9ygPTaOFr2K011h0wsO8araPF/Mfbo0Jj2x2hI80t0i5M0HW
         z/pr8diJ58BMySU0HxJKvLYnmH47/Zo8s0ZA3hg3Ccy2etSpjX95tsvysZAPVEVsjqPK
         sMjPUJ//qZS4Z3xhKI9q/7V9By19rTrL+QOtoEjk4skUsVBK7uRmoz7LPdtgxLDyMpWX
         tu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw4BILlZdZjbYgmMptkOXd4Dpap1q3LZNS3gplMIW2Q=;
        b=7kDGB6CsFDGSbLp5JJUfDW/PJwugfj6I768fvXuSo477/QHGUd1dk/hgjy91VkR7KQ
         SMDlZy/XjoH5ABU0Px8RjnmOPy2bIevRN/G7LKCYjfFz1nXB3ahksqGBfvI4D9ixRGdN
         C90dn9I37ykvmQ9+c+IAdX9buoXqHOJis4tXTqeeNrj0nCYdnpKBOMDOe/QGZyd5Pav/
         6ShDzqQTpU27GlmRpM9MPdxbk0b9iTzj7uW+Sk229N/irPl/i9uzWaMuePQuGtcaEfFe
         m5oireug6z2tUZ7LrTl0kkIe/ZxlgNKufSNnkWipfk/Z1Aqq4sguI/bhV0cNPGZQ2x0w
         jO/Q==
X-Gm-Message-State: AFqh2kpXKJAikafrO8jyJ2AbohB5G5JNEGKNCQ/1wlK6ZRx6tNEIOF51
        kqdgdaOTma0NdgEqtQGrm0OtwYwX5vl/ugGzh48=
X-Google-Smtp-Source: AMrXdXvBRi0nQD/oxYIolRa9daxh8Y9GPaXFQKIOKE0ortGJM523cOw335TpwrJkPS6sl8cBAtDfz4KcB/P+UAIohiE=
X-Received: by 2002:a17:907:c30e:b0:84d:2078:1fca with SMTP id
 tl14-20020a170907c30e00b0084d20781fcamr1548407ejc.551.1673510782234; Thu, 12
 Jan 2023 00:06:22 -0800 (PST)
MIME-Version: 1.0
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
 <1673256674-25165-2-git-send-email-gene_chen@richtek.com> <46838aa3-9747-e2e9-a982-6a3b349f853d@roeck-us.net>
 <2af0661f930d4393bda9f7e771654bac@richtek.com>
In-Reply-To: <2af0661f930d4393bda9f7e771654bac@richtek.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 12 Jan 2023 16:05:52 +0800
Message-ID: <CAE+NS34UupGuG++zXnpWCv5yZ+xw_pra5TEy1LXDty0tuDzYBQ@mail.gmail.com>
Subject: Re: FW: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S
 tcpci driver
To:     Gene Chen <gene_chen@richtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Tuesday, January 10, 2023 2:52 AM
> To: gene_chen(=E9=99=B3=E4=BF=8A=E5=AE=87) <gene_chen@richtek.com>; robh+=
dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; heikki.krogerus@linux.int=
el.com
> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; devicetree@vge=
r.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S t=
cpci driver
>
> On 1/9/23 01:31, gene_chen@richtek.com wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Richtek RT1718S is highly integrated TCPC and Power Delivery (PD)
> > controller with IEC-ESD Protection on SBU/CC/DP/DM, USB2.0 Switch,
> > Charging Port Controller and Power-Path Control.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >   drivers/usb/typec/tcpm/Kconfig         |   9 +
> >   drivers/usb/typec/tcpm/Makefile        |   1 +
> >   drivers/usb/typec/tcpm/tcpci_rt1718s.c | 349 ++++++++++++++++++++++++=
+++++++++
> >   3 files changed, 359 insertions(+)
> >   create mode 100644 drivers/usb/typec/tcpm/tcpci_rt1718s.c
> >
> > diff --git a/drivers/usb/typec/tcpm/Kconfig
> > b/drivers/usb/typec/tcpm/Kconfig index e6b88ca..f0efb34 100644
> > --- a/drivers/usb/typec/tcpm/Kconfig
> > +++ b/drivers/usb/typec/tcpm/Kconfig
> > @@ -27,6 +27,15 @@ config TYPEC_RT1711H
> >     Type-C Port Controller Manager to provide USB PD and USB
> >     Type-C functionalities.
> >
> > +config TYPEC_RT1718S
> > +tristate "Richtek RT1718S Type-C chip driver"
> > +depends on I2C
> > +help
> > +  Richtek RT1718S Type-C chip driver that works with
> > +  Type-C Port Controller Manager to provide USB PD and USB
> > +  Type-C functionalities.
> > +  Additionally, it supports BC1.2 and power-path control.
> > +
> >   config TYPEC_MT6360
> >   tristate "Mediatek MT6360 Type-C driver"
> >   depends on MFD_MT6360
> > diff --git a/drivers/usb/typec/tcpm/Makefile
> > b/drivers/usb/typec/tcpm/Makefile index 906d9dc..db33ffc 100644
> > --- a/drivers/usb/typec/tcpm/Makefile
> > +++ b/drivers/usb/typec/tcpm/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC_WCOVE)+=3D typec_wcove.o
> >   typec_wcove-y:=3D wcove.o
> >   obj-$(CONFIG_TYPEC_TCPCI)+=3D tcpci.o
> >   obj-$(CONFIG_TYPEC_RT1711H)+=3D tcpci_rt1711h.o
> > +obj-$(CONFIG_TYPEC_RT1718S)+=3D tcpci_rt1718s.o
> >   obj-$(CONFIG_TYPEC_MT6360)+=3D tcpci_mt6360.o
> >   obj-$(CONFIG_TYPEC_TCPCI_MT6370)+=3D tcpci_mt6370.o
> >   obj-$(CONFIG_TYPEC_TCPCI_MAXIM)+=3D tcpci_maxim.o
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1718s.c
> > b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
> > new file mode 100644
> > index 00000000..305b39c
> > --- /dev/null
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
> > +
> > +if (*(u8 *)reg =3D=3D RT1718S_P1PREFIX) {
> > +xfer[0].len =3D 1,
> > +xfer[0].buf =3D (u8 *)(reg + 1);
>
> Pointer arithmetic on void * (see below).
>

yes, should be xfer[0].buf =3D (u8 *)reg + 1;

> > +}
>
> There is a lot of context here which needs explanation. The code extracts=
 the upper 8 bit of the register address and drops it if the value is 0.
> So the address is either 8 bit or 16 bit depending on the register addres=
s.
> Also, this only works because reg_format_endian is set to big endian.
>
> This really needs to be documented.
>
> Assigning the values to len and buf twice is really bad style.
> Please use if/else.
>

Because of rt1718s address which is more than 1 page(0x00-0xFF), hw
design i2c pattern with register has 2 byte to access another
page(0xF200-0xF2FF).
The upper byte is set to 0xF2 indicated page 2.

> > +
> > +if (*(u8 *)val =3D=3D RT1718S_P1PREFIX) {
> > +xfer.len =3D val_size - 1;
> > +xfer.buf =3D (u8 *)(val + 1);
> > +}
> > +
>
> Same comments as above. Also, typecast seems wrong. Shouldn't it be
> ((u8 *)val) + 1) ? My memory may defeat me, but I think that pointer arit=
hmetic on void * is undefined or even illegal.
>
>

You are right, I will fix it, thanks.

> > +if (ret < 0)
> > +return ret;
> > +if (ret !=3D 1)
> > +return -EIO;
> > +
> > +return 0;
> > +}
> > +
> > +static const struct regmap_bus rt1718s_regmap_bus =3D {
> > +.read=3D rt1718s_regmap_read,
> > +.write=3D rt1718s_regmap_write,
> > +};
> > +
>
> This needs documentation: Why not use standard regmap functions ?
> Yes, I know, it is because of the ubusual addressing format used by the c=
hip, but it still needs to be explained. Not everyone should have to read t=
he datasheet to understand the code.
>

    Should I add comment before declare rt1718s_regmap_bus?

/*
 * Because of rt1718s address which is more than 1 page(0x00-0xFF),
 * hw design i2c pattern with register has 2 byte to access another
page(0xF200-0xF2FF).
 * The upper byte is set to 0xF2 indicated page 2.
 */

> > +static int rt1718s_sw_reset(struct rt1718s_chip *chip) {
> > +int ret;
> > +
> > +ret =3D regmap_update_bits(chip->tdata.regmap, RT1718S_SYS_CTRL3,
> > + RT1718S_SWRESET_MASK, RT1718S_SWRESET_MASK);
> > +if (ret < 0)
> > +return ret;
> > +
> > +/* Wait for IC to reset done*/
> > +usleep_range(1000, 2000);
> > +
>
> "RT1718S will not response to the I2C commands for 2ms after writing SOFT=
_RESET"
>
> Timeout needs to be at least 2 ms.
>

ACK

> > +return 0;
> > +}
> > +
> > +static int rt1718s_check_chip_exist(struct i2c_client *i2c) {
> > +int ret;
> > +
> > +ret =3D i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
> > +if (ret < 0)
> > +return ret;
> > +if (ret !=3D RT1718S_VID) {
> > +dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
> > +return -ENODEV;
> > +}
> > +ret =3D i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
> > +if (ret < 0)
> > +return ret;
> > +if (ret !=3D RT1718S_PID) {
> > +dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
> > +return -ENODEV;
> > +}
> > +return 0;
> > +}
> > +
> > +static int rt1718s_probe(struct i2c_client *i2c) {
> > +struct rt1718s_chip *chip;
> > +struct gpio_desc *gpiod;
> > +int ret;
> > +u16 clr_events =3D 0;
> > +
> > +ret =3D rt1718s_check_chip_exist(i2c);
> > +if (ret < 0) {
> > +dev_err(&i2c->dev, "check vid/pid fail(%d)\n", ret);
>
> Double error message.
>

ACK, I will remove it.

> > +return ret;
> > +}
> > +
> > +chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> > +if (!chip)
> > +return -ENOMEM;
> > +
> > +chip->dev =3D &i2c->dev;
> > +
> > +chip->tdata.regmap =3D devm_regmap_init(&i2c->dev,
> > +      &rt1718s_regmap_bus, &i2c->dev,
> > +      &rt1718s_regmap_config);
> > +if (IS_ERR(chip->tdata.regmap))
> > +return dev_err_probe(&i2c->dev, PTR_ERR(chip->tdata.regmap),
> > +     "Failed to init regmap\n");
> > +
> > +chip->vbus =3D devm_regulator_get(&i2c->dev, "vbus");
> > +if (IS_ERR(chip->vbus))
> > +return dev_err_probe(&i2c->dev, PTR_ERR(chip->vbus),
> > +     "Failed to get vbus regulator\n");
> > +
> > +ret =3D rt1718s_sw_reset(chip);
> > +if (ret < 0)
> > +return ret;
> > +
> > +ret =3D regmap_raw_write(chip->tdata.regmap, TCPC_ALERT_MASK, &clr_eve=
nts,
> > +       sizeof(clr_events));
> > +
> > +chip->tdata.init =3D rt1718s_init;
> > +chip->tdata.set_vbus =3D rt1718s_set_vbus;
> > +chip->tcpci =3D tcpci_register_port(&i2c->dev, &chip->tdata);
> > +if (IS_ERR(chip->tcpci))
> > +return dev_err_probe(&i2c->dev, PTR_ERR(chip->tcpci),
> > +     "Failed to register tcpci port\n");
> > +
> > +/* for platform set gpio default inpull_high */
> > +gpiod =3D devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);
> > +if (IS_ERR(gpiod))
> > +return dev_err_probe(&i2c->dev, PTR_ERR(gpiod),
> > +     "Failed to get gpio\n");
> > +
> > +ret =3D devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
> > +rt1718s_irq, IRQF_ONESHOT,
> > +dev_name(&i2c->dev), chip);
> > +if (ret) {
> > +dev_err(chip->dev, "Failed to register irq\n");
> > +tcpci_unregister_port(chip->tcpci);
> > +return ret;
> > +}
> > +
> > +device_init_wakeup(&i2c->dev, true);
> > +i2c_set_clientdata(i2c, chip);
> > +
> > +dev_info(&i2c->dev, "%s:successfully\n", __func__);
>
> Nore logging noise.
>

ACK

> > +return 0;
> > +}
> > +
> > +static void rt1718s_remove(struct i2c_client *i2c) {
> > +struct rt1718s_chip *chip =3D i2c_get_clientdata(i2c);
> > +
> > +tcpci_unregister_port(chip->tcpci);
> > +}
> > +
> > +static int __maybe_unused rt1718s_suspend(struct device *dev) {
> > +struct i2c_client *i2c =3D to_i2c_client(dev);
> > +
> > +if (device_may_wakeup(dev))
> > +enable_irq_wake(i2c->irq);
> > +disable_irq(i2c->irq);
> > +
> > +return 0;
> > +}
> > +
> > +static int __maybe_unused rt1718s_resume(struct device *dev) {
> > +struct i2c_client *i2c =3D to_i2c_client(dev);
> > +
> > +if (device_may_wakeup(dev))
> > +disable_irq_wake(i2c->irq);
> > +enable_irq(i2c->irq);
> > +
> > +return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(rt1718s_pm_ops, rt1718s_suspend,
> > +rt1718s_resume);
> > +
> > +static const struct of_device_id __maybe_unused rt1718s_of_id[] =3D {
> > +{ .compatible =3D "richtek,rt1718s", },
> > +{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rt1718s_of_id);
> > +
> > +static struct i2c_driver rt1718s_i2c_driver =3D {
> > +.driver =3D {
> > +.name =3D "rt1718s",
> > +.pm =3D &rt1718s_pm_ops,
> > +.of_match_table =3D rt1718s_of_id,
> > +},
> > +.probe_new =3D rt1718s_probe,
> > +.remove =3D rt1718s_remove,
> > +};
> > +module_i2c_driver(rt1718s_i2c_driver);
> > +
> > +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> > +MODULE_DESCRIPTION("RT1718S USB Type-C Port Controller Interface
> > +Driver"); MODULE_LICENSE("GPL");
