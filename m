Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4496AFCBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCHCLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHCLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:11:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B29A54F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:11:16 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so16752983qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678241475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhukmpQlx1anGpfCWgT8lkusinTBpaubpbPr6hscTSE=;
        b=j0nfXSXtMG6SDDtPy8jQOhpJVbk/89NLzashNbHWMTpRXtaYsB/h8hd/0Wa1btmQcn
         6Azmb6srZCKitw7RMEFili9Xjv1Kj/Z30gZB0l/XnCWJpvoFjvZrFK99F+A2bKL1QqHb
         Pd+eG+ws0dKIznpLQxxkqYPo/15lCxN6ekyzCjDRkSLizFmY5PYGHf/JHWg1QBqW51kG
         793SJ5IWw0jY/UXAKUKOMttDyJumY0ul9KiUZzWWh+wJQDwlJedwYOHnj4QhW9q/xXwG
         YBl5EbxHQwCjpksKCr6DPiNCegSoaBWXWOQ69qTGEtGOI8Jzd3cYG4+Tcz3agROE1wLu
         gRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678241475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhukmpQlx1anGpfCWgT8lkusinTBpaubpbPr6hscTSE=;
        b=587suTYm2XTCnQWJmrFpPRHn90+YdylXzkFYcmisMP0y5STkEpcAHK8Aub8EVQk2vY
         M9FsykzMKgenTVjosPxF3cOSy4rCXbuB+NUJwpPvUwFBUeJHLBGerPSV0BbZw7EO1Tk5
         3U4CnM2u9EoEQvVSQSrfXWOVdXl7a3m1Y3PGQucs01yu5GpFIMTEeZwjEQwiMyckR6fy
         V6XfkidG8q1iZZmAh6t5oxfPc+vZ6Enk6CJci40tWs0ybDgbVoRavmjoB1q0n4dKyEXg
         wYfpOLghhV9lfRvSMos5nZOOE0NouljZs6tP0mb0Ed7+VdH71hNqN9of/dQyokOlk6kJ
         mZUw==
X-Gm-Message-State: AO0yUKVrCQwfQT7YEu+rvCA3clIPMcH45jOc37T9jpI2Kf4chROoZYzW
        tRf5HSJ14OyrtKzfjv2tv2IkVw==
X-Google-Smtp-Source: AK7set/Igl2IV3ZCxE+XwTjTMNoJXFOMQWaLicowXYYQqbF3sd/378Hp+Yav2Yg9gSAUYpmtIr02NA==
X-Received: by 2002:a05:622a:40f:b0:3b3:7d5:a752 with SMTP id n15-20020a05622a040f00b003b307d5a752mr27805640qtx.50.1678241474985;
        Tue, 07 Mar 2023 18:11:14 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r2-20020ac83b42000000b003c034837d8fsm3384513qtf.33.2023.03.07.18.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:11:13 -0800 (PST)
Date:   Tue, 7 Mar 2023 21:11:11 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        pdemetrotion@winsystems.com, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v4 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers
 to the regmap API
Message-ID: <ZAfuv9RQn9eoXKPX@fedora>
References: <cover.1678106722.git.william.gray@linaro.org>
 <ZAX3243e4mejPEsS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Exj+qic2iP6fmxVn"
Content-Disposition: inline
In-Reply-To: <ZAX3243e4mejPEsS@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Exj+qic2iP6fmxVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 04:25:31PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 06, 2023 at 07:59:50AM -0500, William Breathitt Gray wrote:
> > Changes in v4:
> >  - Allocate idio24gpio before using it in idio_24_probe()
> > Changes in v3:
> >  - Drop map from set_type_config() parameter list; regmap can be passed
> >    by irq_drv_data instead
> >  - Adjust idio_24_set_type_config() for parameter list
> >  - Add mutex to prevent clobbering the COS_ENABLE register when masking
> >    IRQ and setting their type configuration
> > Changes in v2:
> >  - Simplify PCIe-IDIO-24 register offset defines to remove superfluous
> >    arithmetic
> >  - Check for NULL pointer after chip->irq_drv_data allocation
> >  - Set gpio_regmap drvdata and use gpio_regmap_get_drvdata() to get the
> >    regmap in idio_24_reg_map_xlate()
> >=20
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > A patch to pass irq_drv_data as a parameter for struct regmap_irq_chip
> > set_type_config() is included. This is needed by the
> > idio_24_set_type_config() and ws16c48_set_type_config() callbacks in
> > order to update the type configuration on their respective devices.
> >=20
> > A patch to migrate the WS16C48 GPIO driver to the regmap API is included
> > in this series due to its dependence on the struct regmap_irq_chip
> > set_type_config() change.
>=20
> I have found nothing WRT lock type changes.
> Can you shed a light on what's going on here?

Previous versions of this patchset had removed the locks entirely.
Later, I realized that some locking would be required to prevent
clobbering registers when updating IRQ masks and type configurations, so
I added in these new locks with types that seemed appropriate for the
way they are being used now in the code. I'll explain further in my
replies to each patch why I chose these particular types.

William Breathitt Gray

--Exj+qic2iP6fmxVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAfuvwAKCRC1SFbKvhIj
K45HAQD7dYrMWAEpvnoorSEWniz+P2SaeI+3v0XjdrY2dIcvDQD/c15u7LPpRTR6
IKBVIPQowdupymgDr3XjUh2OudYHmgM=
=lXsO
-----END PGP SIGNATURE-----

--Exj+qic2iP6fmxVn--
