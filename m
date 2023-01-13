Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD1668998
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjAMCbE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Jan 2023 21:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjAMCbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:31:00 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9355133A;
        Thu, 12 Jan 2023 18:30:58 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3DEEB24E115;
        Fri, 13 Jan 2023 10:30:56 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 13 Jan
 2023 10:30:56 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 13 Jan
 2023 10:30:55 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Fri, 13 Jan 2023 10:30:55 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v4 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Topic: [PATCH v4 2/3] hwrng: starfive - Add TRNG driver for StarFive
 SoC
Thread-Index: AQHZJj/IHp8vIBNNJEO5ZoaN+GosV66aoj2AgADzXNA=
Date:   Fri, 13 Jan 2023 02:30:55 +0000
Message-ID: <82979ef41b4a4c9f8a77c950e3c65c86@EXMBX168.cuchost.com>
References: <20230112043812.150393-1-jiajie.ho@starfivetech.com>
 <20230112043812.150393-3-jiajie.ho@starfivetech.com> <Y8Bco7lBBj7CO9C5@spud>
In-Reply-To: <Y8Bco7lBBj7CO9C5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.190.108.220]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +STARFIVE TRNG DRIVER
> > +M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/rng/starfive*
> > +F:	drivers/char/hw_random/starfive-trng.c
> 
> minor nit (so don't submit another version just to fix this):
> This should be Supported, no?
> 

Hi Conor, 
I'll update this in next version together with other comments below. 

> > diff --git a/drivers/char/hw_random/Makefile
> > b/drivers/char/hw_random/Makefile index 3e948cf04476..f68ac370847f
> > 100644
> > --- a/drivers/char/hw_random/Makefile
> > +++ b/drivers/char/hw_random/Makefile
> > @@ -47,3 +47,4 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-
> trng.o
> >  obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
> >  obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
> >  obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
> > +obj-$(CONFIG_HW_RANDOM_STARFIVE) += starfive-trng.o
> 
> Is "STARFIVE" a bit too general of a name here and in the Kconfig entry?
> I don't have a TRM for the JH7100, but this name (and the Kconfig text)
> would give me the impression that I can use it there too.
> Does this driver support both?
> 

7100 uses a different trng module but this same generator might be used in
future products, so I left it generic. Would it be better to specify the product?

> > +static int starfive_trng_probe(struct platform_device *pdev)
[...]
> > +	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret, "Failed to register
> hwrng\n");
> > +		goto err_fail_register;
> > +	}
> > +
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
> 
> > +	pm_runtime_enable(&pdev->dev);
> 
> > +
> > +	return 0;
> > +
> > +err_fail_register:
> 
> > +	pm_runtime_disable(&pdev->dev);
> 
> This was only enabled after the only goto for this label, does it serve a
> purpose?
> I know little about runtime PM, it just caught my eye.
> I looked at the other rng drivers that had calls to pm_runtime_enable(), but
> they all seem to do their pm enablement _before_ calling hwrng_register().
> Again, I am not familiar with runtime PM, but curious why you are doing
> things differently, that's all.

It does make more sense to move pm_runtime_enable before registering the
generator to align with codes in the goto label.
I'll fix this part.

Thanks again for reviewing the patches.

Best regards,
Jia Jie


