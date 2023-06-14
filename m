Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C72F55F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjFNHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243259AbjFNHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:04:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C48268F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:03:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KWk-0000gK-3G; Wed, 14 Jun 2023 09:02:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KWi-007IK0-Ac; Wed, 14 Jun 2023 09:02:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q9KWh-00E8AO-Bi; Wed, 14 Jun 2023 09:02:43 +0200
Date:   Wed, 14 Jun 2023 09:02:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v7 06/10] pwm: dwc: split pci out of core driver
Message-ID: <20230614070243.humqlwukw3smc5jr@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-7-ben.dooks@sifive.com>
 <20230216213054.lge6ugeay3uxh2ye@pengutronix.de>
 <5fded01b-087a-48e1-6b38-2f52ddb190ea@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kph55iy6kwh54cyo"
Content-Disposition: inline
In-Reply-To: <5fded01b-087a-48e1-6b38-2f52ddb190ea@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kph55iy6kwh54cyo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:22:34PM +0100, Ben Dooks wrote:
> On 16/02/2023 21:30, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Fri, Dec 23, 2022 at 03:38:16PM +0000, Ben Dooks wrote:
> > > Moving towards adding non-pci support for the driver, move the pci
> > > parts out of the core into their own module. This is partly due to
> > > the module_driver() code only being allowed once in a module and also
> > > to avoid a number of #ifdef if we build a single file in a system
> > > without pci support.
> > >=20
> > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > > ---
> > > v7:
> > >   - re-order kconfig to make dwc core be selected by PCI driver
> > > v6:
> > >   - put DWC_PERIOD_NS back to avoid bisect issues
> > > v4:
> > >   - removed DWC_PERIOD_NS as not needed
> > > ---
> > >   drivers/pwm/Kconfig       |  17 +++-
> > >   drivers/pwm/Makefile      |   1 +
> > >   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
> > >   drivers/pwm/pwm-dwc.c     | 158 +----------------------------------=
---
> > >   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
> > >   5 files changed, 209 insertions(+), 158 deletions(-)
> > >   create mode 100644 drivers/pwm/pwm-dwc-pci.c
> > >   create mode 100644 drivers/pwm/pwm-dwc.h
> > >=20
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 3f3c53af4a56..8c5ef388a981 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -174,16 +174,25 @@ config PWM_CROS_EC
> > >   	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
> > >   	  Controller.
> > > -config PWM_DWC
> > > -	tristate "DesignWare PWM Controller"
> > > -	depends on PCI || COMPILE_TEST
> >=20
> > You're loosing COMPILE_TEST here, as it's not present for the new
> > PWM_DWC.
> >=20
> > > +config PWM_DWC_CORE
> > > +	tristate
> > >   	depends on HAS_IOMEM
> > >   	help
> > > -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> > > +	  PWM driver for Synopsys DWC PWM Controller.
> > >   	  To compile this driver as a module, choose M here: the module
> > >   	  will be called pwm-dwc.
> > > +config PWM_DWC
> > > +	tristate "DesignWare PWM Controller (PCI bus)"
> > > +	depends on HAS_IOMEM && PCI
> > > +	select PWM_DWC_CORE
> > > +	help
> > > +	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-dwc-pci.
> > > +
> > >   config PWM_EP93XX
> > >   	tristate "Cirrus Logic EP93xx PWM support"
> > >   	depends on ARCH_EP93XX || COMPILE_TEST
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 7bf1a29f02b8..a70d36623129 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
> > >   obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> > >   obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> > >   obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
> > > +obj-$(CONFIG_PWM_DWC_PCI)	+=3D pwm-dwc-pci.o
> > >   obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
> > >   obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> > >   obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
> > > diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
> > > new file mode 100644
> > > index 000000000000..2213d0e7f3c8
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-dwc-pci.c
> > > @@ -0,0 +1,133 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * DesignWare PWM Controller driver (PCI part)
> > > + *
> > > + * Copyright (C) 2018-2020 Intel Corporation
> > > + *
> > > + * Author: Felipe Balbi (Intel)
> > > + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > + * Author: Raymond Tan <raymond.tan@intel.com>
> > > + *
> > > + * Limitations:
> > > + * - The hardware cannot generate a 0 % or 100 % duty cycle. Both hi=
gh and low
> > > + *   periods are one or more input clock periods long.
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/export.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/pwm.h>
> > > +
> > > +#include "pwm-dwc.h"
> > > +
> > > +static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_devic=
e_id *id)
> > > +{
> > > +	struct device *dev =3D &pci->dev;
> > > +	struct dwc_pwm *dwc;
> > > +	int ret;
> > > +
> > > +	dwc =3D dwc_pwm_alloc(dev);
> > > +	if (!dwc)
> > > +		return -ENOMEM;
> > > +
> > > +	ret =3D pcim_enable_device(pci);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
> > > +		return ret;
> > > +	}
> > > +
> > > +	pci_set_master(pci);
> > > +
> > > +	ret =3D pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > > +		return ret;
> > > +	}
> > > +
> > > +	dwc->base =3D pcim_iomap_table(pci)[0];
> > > +	if (!dwc->base) {
> > > +		dev_err(dev, "Base address missing\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	ret =3D devm_pwmchip_add(dev, &dwc->chip);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_put(dev);
> > > +	pm_runtime_allow(dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void dwc_pwm_remove(struct pci_dev *pci)
> > > +{
> > > +	pm_runtime_forbid(&pci->dev);
> > > +	pm_runtime_get_noresume(&pci->dev);
> > > +}
> > > +
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int dwc_pwm_suspend(struct device *dev)
> > > +{
> > > +	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > > +	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < DWC_TIMERS_TOTAL; i++) {
> > > +		if (dwc->chip.pwms[i].state.enabled) {
> > > +			dev_err(dev, "PWM %u in use by consumer (%s)\n",
> > > +				i, dwc->chip.pwms[i].label);
> > > +			return -EBUSY;
> > > +		}
> > > +		dwc->ctx[i].cnt =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
> > > +		dwc->ctx[i].cnt2 =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
> > > +		dwc->ctx[i].ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int dwc_pwm_resume(struct device *dev)
> > > +{
> > > +	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > > +	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < DWC_TIMERS_TOTAL; i++) {
> > > +		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
> > > +		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
> > > +		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > > +static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_re=
sume);
> > > +
> > > +static const struct pci_device_id dwc_pwm_id_table[] =3D {
> > > +	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
> > > +	{  }	/* Terminating Entry */
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
> > > +
> > > +static struct pci_driver dwc_pwm_driver =3D {
> > > +	.name =3D "pwm-dwc",
> > > +	.probe =3D dwc_pwm_probe,
> > > +	.remove =3D dwc_pwm_remove,
> > > +	.id_table =3D dwc_pwm_id_table,
> > > +	.driver =3D {
> > > +		.pm =3D &dwc_pwm_pm_ops,
> > > +	},
> > > +};
> > > +
> > > +module_pci_driver(dwc_pwm_driver);
> > > +
> > > +MODULE_AUTHOR("Felipe Balbi (Intel)");
> > > +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
> > > +MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
> > > +MODULE_DESCRIPTION("DesignWare PWM Controller");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> > > index 56cde9da2c0e..90a8ae1252a1 100644
> > > --- a/drivers/pwm/pwm-dwc.c
> > > +++ b/drivers/pwm/pwm-dwc.c
> > > @@ -1,16 +1,12 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   /*
> > > - * DesignWare PWM Controller driver
> > > + * DesignWare PWM Controller driver core
> > >    *
> > >    * Copyright (C) 2018-2020 Intel Corporation
> > >    *
> > >    * Author: Felipe Balbi (Intel)
> > >    * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > >    * Author: Raymond Tan <raymond.tan@intel.com>
> > > - *
> > > - * Limitations:
> > > - * - The hardware cannot generate a 0 % or 100 % duty cycle. Both hi=
gh and low
> > > - *   periods are one or more input clock periods long.
> > >    */
> > >   #include <linux/bitops.h>
> > > @@ -21,51 +17,7 @@
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/pwm.h>
> > > -#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
> > > -#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
> > > -#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
> > > -#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
> > > -#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
> > > -#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
> > > -
> > > -#define DWC_TIMERS_INT_STS	0xa0
> > > -#define DWC_TIMERS_EOI		0xa4
> > > -#define DWC_TIMERS_RAW_INT_STS	0xa8
> > > -#define DWC_TIMERS_COMP_VERSION	0xac
> > > -
> > > -#define DWC_TIMERS_TOTAL	8
> > > -#define DWC_CLK_PERIOD_NS	10
> > > -
> > > -/* Timer Control Register */
> > > -#define DWC_TIM_CTRL_EN		BIT(0)
> > > -#define DWC_TIM_CTRL_MODE	BIT(1)
> > > -#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
> > > -#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
> > > -#define DWC_TIM_CTRL_INT_MASK	BIT(2)
> > > -#define DWC_TIM_CTRL_PWM	BIT(3)
> > > -
> > > -struct dwc_pwm_ctx {
> > > -	u32 cnt;
> > > -	u32 cnt2;
> > > -	u32 ctrl;
> > > -};
> > > -
> > > -struct dwc_pwm {
> > > -	struct pwm_chip chip;
> > > -	void __iomem *base;
> > > -	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
> > > -};
> > > -#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> > > -
> > > -static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
> > > -{
> > > -	return readl(dwc->base + offset);
> > > -}
> > > -
> > > -static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u3=
2 offset)
> > > -{
> > > -	writel(value, dwc->base + offset);
> > > -}
> > > +#include "pwm-dwc.h"
> > >   static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int =
enabled)
> > >   {
> > > @@ -196,7 +148,7 @@ static const struct pwm_ops dwc_pwm_ops =3D {
> > >   	.owner =3D THIS_MODULE,
> > >   };
> > > -static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
> > > +struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
> > >   {
> > >   	struct dwc_pwm *dwc;
> > > @@ -211,109 +163,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct dev=
ice *dev)
> > >   	dev_set_drvdata(dev, dwc);
> > >   	return dwc;
> > >   }
> > > -
> > > -static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_devic=
e_id *id)
> > > -{
> > > -	struct device *dev =3D &pci->dev;
> > > -	struct dwc_pwm *dwc;
> > > -	int ret;
> > > -
> > > -	dwc =3D dwc_pwm_alloc(dev);
> > > -	if (!dwc)
> > > -		return -ENOMEM;
> > > -
> > > -	ret =3D pcim_enable_device(pci);
> > > -	if (ret) {
> > > -		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
> > > -		return ret;
> > > -	}
> > > -
> > > -	pci_set_master(pci);
> > > -
> > > -	ret =3D pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > > -	if (ret) {
> > > -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > > -		return ret;
> > > -	}
> > > -
> > > -	dwc->base =3D pcim_iomap_table(pci)[0];
> > > -	if (!dwc->base) {
> > > -		dev_err(dev, "Base address missing\n");
> > > -		return -ENOMEM;
> > > -	}
> > > -
> > > -	ret =3D devm_pwmchip_add(dev, &dwc->chip);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	pm_runtime_put(dev);
> > > -	pm_runtime_allow(dev);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > -static void dwc_pwm_remove(struct pci_dev *pci)
> > > -{
> > > -	pm_runtime_forbid(&pci->dev);
> > > -	pm_runtime_get_noresume(&pci->dev);
> > > -}
> > > -
> > > -#ifdef CONFIG_PM_SLEEP
> > > -static int dwc_pwm_suspend(struct device *dev)
> > > -{
> > > -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > > -	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> > > -	int i;
> > > -
> > > -	for (i =3D 0; i < DWC_TIMERS_TOTAL; i++) {
> > > -		if (dwc->chip.pwms[i].state.enabled) {
> > > -			dev_err(dev, "PWM %u in use by consumer (%s)\n",
> > > -				i, dwc->chip.pwms[i].label);
> > > -			return -EBUSY;
> > > -		}
> > > -		dwc->ctx[i].cnt =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
> > > -		dwc->ctx[i].cnt2 =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
> > > -		dwc->ctx[i].ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
> > > -	}
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > -static int dwc_pwm_resume(struct device *dev)
> > > -{
> > > -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > > -	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> > > -	int i;
> > > -
> > > -	for (i =3D 0; i < DWC_TIMERS_TOTAL; i++) {
> > > -		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
> > > -		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
> > > -		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
> > > -	}
> > > -
> > > -	return 0;
> > > -}
> > > -#endif
> > > -
> > > -static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_re=
sume);
> > > -
> > > -static const struct pci_device_id dwc_pwm_id_table[] =3D {
> > > -	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
> > > -	{  }	/* Terminating Entry */
> > > -};
> > > -MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
> > > -
> > > -static struct pci_driver dwc_pwm_driver =3D {
> > > -	.name =3D "pwm-dwc",
> > > -	.probe =3D dwc_pwm_probe,
> > > -	.remove =3D dwc_pwm_remove,
> > > -	.id_table =3D dwc_pwm_id_table,
> > > -	.driver =3D {
> > > -		.pm =3D &dwc_pwm_pm_ops,
> > > -	},
> > > -};
> > > -
> > > -module_pci_driver(dwc_pwm_driver);
> > > +EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
> > >   MODULE_AUTHOR("Felipe Balbi (Intel)");
> > >   MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
> > > diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> > > new file mode 100644
> > > index 000000000000..68f98eb76152
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-dwc.h
> > > @@ -0,0 +1,58 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * DesignWare PWM Controller driver
> > > + *
> > > + * Copyright (C) 2018-2020 Intel Corporation
> > > + *
> > > + * Author: Felipe Balbi (Intel)
> > > + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > + * Author: Raymond Tan <raymond.tan@intel.com>
> > > + */
> > > +
> > > +#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
> > > +#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
> > > +#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
> > > +#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
> > > +#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
> > > +#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
> > > +
> > > +#define DWC_TIMERS_INT_STS	0xa0
> > > +#define DWC_TIMERS_EOI		0xa4
> > > +#define DWC_TIMERS_RAW_INT_STS	0xa8
> > > +#define DWC_TIMERS_COMP_VERSION	0xac
> > > +
> > > +#define DWC_TIMERS_TOTAL	8
> > > +#define DWC_CLK_PERIOD_NS	10
> > > +
> > > +/* Timer Control Register */
> > > +#define DWC_TIM_CTRL_EN		BIT(0)
> > > +#define DWC_TIM_CTRL_MODE	BIT(1)
> > > +#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
> > > +#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
> > > +#define DWC_TIM_CTRL_INT_MASK	BIT(2)
> > > +#define DWC_TIM_CTRL_PWM	BIT(3)
> > > +
> > > +struct dwc_pwm_ctx {
> > > +	u32 cnt;
> > > +	u32 cnt2;
> > > +	u32 ctrl;
> > > +};
> > > +
> > > +struct dwc_pwm {
> > > +	struct pwm_chip chip;
> > > +	void __iomem *base;
> > > +	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
> > > +};
> > > +#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> > > +
> > > +static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
> > > +{
> > > +	return readl(dwc->base + offset);
> > > +}
> > > +
> > > +static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u3=
2 offset)
> > > +{
> > > +	writel(value, dwc->base + offset);
> > > +}
> > > +
> > > +extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
> >=20
> > If you respin this patch for the COMPILE_TEST issue I pointed out above,
> > would you mind using a module namespace?
> >=20
> > That would work by adding e.g.
> >=20
> > 	#define DEFAULT_SYMBOL_NAMESPACE dwc-pwm
> >=20
> > to drivers/pwm/pwm-dwc.c (before the includes) and
> >=20
> > 	MODULE_IMPORT_NS(dwc-pwm)
> >=20
> > to drivers/pwm/pwm-dwc.h.
> >=20
> > Best regards
> > Uwe
> >=20
>=20
> I tried adding these, but all I get is a bunch of compile errors.

I guess: Add a ; after MODULE_IMPORT_NS(dwc-pwm) fixes that?

To talk code:
https://git.pengutronix.de/cgit/ukl/linux/commit/?h=3Dpwm-dwc-for-bjdooks&i=
d=3Df3ebe7f1b46f57afee44d42cb8ab3835e8f662c9
works for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kph55iy6kwh54cyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSJZhIACgkQj4D7WH0S
/k76gwf+LFD3FNbXJU2K3dCDECtPI2s4HK7F6iQFEF1JXKp8kv6oUty5r2HtHKLE
HByLqf1+aJIT+s6kODuuNKX8T7kjpyJmfccO/vTeRkPJ2KPPcuiWyrwHcE5bvkry
2ycqA6mqUBDjZS7ZEcIfjnCYpXH/+/Q1ZU480ldW1yvkiBBaaNWMItguNG7cvguS
4Svq8WOlnTeP9ZY/VdHvGbzYmWiVDMVxphMHVwmjfBzGhx8xiljgi3O85e57+x3T
0nIaP32YHrK7SKR9N6Nd/Y1nfHWLckEiK4rg9rPxIpAhL9nXczZUMtm2L78nGfJV
H/TwgB+uCZ1IBjoWHIbcL7nVSdKrAA==
=xAyr
-----END PGP SIGNATURE-----

--kph55iy6kwh54cyo--
