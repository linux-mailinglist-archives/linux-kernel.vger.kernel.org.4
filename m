Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224F86F5DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjECSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:20:35 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAFD2698;
        Wed,  3 May 2023 11:20:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8185E1C0CAF; Wed,  3 May 2023 20:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683138028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QemKUHts/yq9sHoylEthTGqd+ivWENoo+l6iqkH/nhg=;
        b=jWYO2fuZy/LnlQjFeicdoR0ikWzwDmntwm4FnyXcMMWX/iTdS0hmvyuPopMSFA4FMZC8W9
        +XqudtZkaV+oFaoP32qlXz4Eh83CBBFVfzuSoBYeuTcLTkTdaQad4DIwSyMM7w7aAaCqwo
        hyegxIi6s6HnapI81v3d+eNZQ95ow1w=
Date:   Wed, 3 May 2023 20:20:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] LEDs for v6.4
Message-ID: <ZFKl7GSNlStABYXG@duo.ucw.cz>
References: <20230502162524.GJ620451@google.com>
 <20230502162815.GK620451@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9wAuCQuJqZX3eVV5"
Content-Disposition: inline
In-Reply-To: <20230502162815.GK620451@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9wAuCQuJqZX3eVV5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Apologies, this is obviously LEDs, not MFD - long day!

Thanks for doing this. I guess it may have something to do with the
subject, but please keep linux-leds@vger.kernel.org in the cc list.

Best regards,
								Pavel

> >  - New Drivers
> >    - Add support for MediaTek MT6370 LED Indicator
> >    - Add support for MediaTek MT6370 Flashlight
> >    - Add support for QCOM PMIC Flash
> >    - Add support for Rohm BD2606MVV Charge Pump LED
> >=20
> >  - New Device Support
> >    - Add support for PMK8550 PWM to QCOM LPG
> >=20
> >  - New Functionality
> >    - Add support for high resolution PWM to QCOM LPG
> >=20
> >  - Fix-ups
> >    - Kconfig 'depends' and 'select' dependency changes
> >    - Remove unused / irrelevant includes
> >    - Remove unnecessary checks (already performed further into the call=
 stack)
> >    - Trivial: Fix commentary, simplify error messages
> >    - Rid 'defined but not used' warnings
> >    - Provide documentation
> >    - Explicitly provide include files
> >=20
> >  - Bug Fixes
> >    - Mark GPIO LED as BROKEN
> >    - Fix Kconfig entries
> >    - Fix various Smatch staticify reports
> >    - Fix error handling (or a lack there of)
> >=20
> > ----------------------------------------------------------------
> > Alexander Dahl (1):
> >       docs: leds: ledtrig-oneshot: Fix spelling mistake
> >=20
> > Andreas Kemnade (2):
> >       dt-bindings: leds: Add ROHM BD2606MVV LED
> >       leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver
> >=20
> > Andy Shevchenko (2):
> >       leds: lp8860: Remove unused of_gpio,h
> >       leds: lp8860: Remove duplicate NULL checks for gpio_desc
> >=20
> > Anjelique Melendez (3):
> >       dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
> >       leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
> >       leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM
> >=20
> > Bagas Sanjaya (4):
> >       Documentation: leds: Add MT6370 doc to the toctree
> >       Documentation: leds: mt6370: Properly wrap hw_pattern chart
> >       Documentation: leds: MT6370: Use bullet lists for timing variables
> >       MAINTAINERS: Add entry for LED devices documentation
> >=20
> > ChiYuan Huang (4):
> >       leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indi=
cator support
> >       leds: flash: mt6370: Add MediaTek MT6370 flashlight support
> >       docs: leds: Add MT6370 RGB LED pattern document
> >       leds: rgb: mt6370: Fix implicit declaration for FIELD_GET
> >=20
> > Christophe JAILLET (1):
> >       leds: pwm-multicolor: Simplify an error message
> >=20
> > Fenglin Wu (2):
> >       leds: flash: Add driver to support flash LED module in QCOM PMICs
> >       dt-bindings: leds: Add QCOM flash LED controller
> >=20
> > H. Nikolaus Schaller (1):
> >       leds: tca6507: Fix error handling of using fwnode_property_read_s=
tring
> >=20
> > Krzysztof Kozlowski (1):
> >       leds: tlc591xx: Mark OF related data as maybe unused
> >=20
> > Linus Walleij (1):
> >       leds: Mark GPIO LED trigger broken
> >=20
> > Luca Weiss (1):
> >       dt-bindings: leds: spmi-flash-led: Add pm6150l compatible
> >=20
> > Lukas Bulwahn (1):
> >       leds: rgb: mt6370: Correct config name to select in LEDS_MT6370_R=
GB
> >=20
> > Manivannan Sadhasivam (1):
> >       dt-bindings: leds: Document commonly used LED triggers
> >=20
> > Rafa=C5=82 Mi=C5=82ecki (1):
> >       dt-bindings: leds: Add "usbport" trigger
> >=20
> > Randy Dunlap (1):
> >       leds: TI_LMU_COMMON: select REGMAP instead of depending on it
> >=20
> > Thomas Wei=C3=9Fschuh (1):
> >       leds: Fix reference to led_set_brightness() in doc
> >=20
> > Tom Rix (1):
> >       leds: flash: Set variables mvflash_{3,4}ch_regs storage-class-spe=
cifier to static
> >=20
> > Wadim Egorov (1):
> >       dt-bindings: leds: Convert PCA9532 to dtschema
> >=20
> >  Documentation/devicetree/bindings/leds/common.yaml |   35 +-
> >  .../devicetree/bindings/leds/leds-pca9532.txt      |   49 -
> >  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |    1 +
> >  .../devicetree/bindings/leds/nxp,pca953x.yaml      |   90 ++
> >  .../bindings/leds/qcom,spmi-flash-led.yaml         |  117 +++
> >  .../devicetree/bindings/leds/rohm,bd2606mvv.yaml   |   81 ++
> >  Documentation/leds/index.rst                       |    1 +
> >  Documentation/leds/leds-mt6370-rgb.rst             |   64 ++
> >  Documentation/leds/ledtrig-oneshot.rst             |    2 +-
> >  MAINTAINERS                                        |    1 +
> >  drivers/leds/Kconfig                               |   16 +-
> >  drivers/leds/Makefile                              |    1 +
> >  drivers/leds/flash/Kconfig                         |   28 +
> >  drivers/leds/flash/Makefile                        |    2 +
> >  drivers/leds/flash/leds-mt6370-flash.c             |  573 +++++++++++
> >  drivers/leds/flash/leds-qcom-flash.c               |  773 ++++++++++++=
+++
> >  drivers/leds/leds-bd2606mvv.c                      |  160 ++++
> >  drivers/leds/leds-lp8860.c                         |   10 +-
> >  drivers/leds/leds-tca6507.c                        |    5 +-
> >  drivers/leds/leds-tlc591xx.c                       |    2 +-
> >  drivers/leds/rgb/Kconfig                           |   13 +
> >  drivers/leds/rgb/Makefile                          |    1 +
> >  drivers/leds/rgb/leds-mt6370-rgb.c                 | 1011 ++++++++++++=
++++++++
> >  drivers/leds/rgb/leds-pwm-multicolor.c             |    4 +-
> >  drivers/leds/rgb/leds-qcom-lpg.c                   |  160 +++-
> >  drivers/leds/trigger/Kconfig                       |    1 +
> >  include/linux/leds.h                               |    2 +-
> >  27 files changed, 3091 insertions(+), 112 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532=
=2Etxt
> >  create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.=
yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-fl=
ash-led.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606m=
vv.yaml
> >  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst
> >  create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
> >  create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> >  create mode 100644 drivers/leds/leds-bd2606mvv.c
> >  create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c
> >=20
> > --=20
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--9wAuCQuJqZX3eVV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFKl7AAKCRAw5/Bqldv6
8lqeAKCEnEr20lj12P9tUbCmZYm5rsTLTwCaAifvemvnOc82fBa5Qanuu/WNqJQ=
=FKRK
-----END PGP SIGNATURE-----

--9wAuCQuJqZX3eVV5--
