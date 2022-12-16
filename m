Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DD64E978
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLPKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLPKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:30:20 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE5396F2;
        Fri, 16 Dec 2022 02:30:18 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 190AC1C09F4; Fri, 16 Dec 2022 11:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671186617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wQc6rqUCd1wvUJEJlQwdF+8hT2gQSWtY3rkQyLKlfiE=;
        b=r0buK4OM7O9DoxCj6mKDt41sTvhm4RXamiYaQJ5utImbZYO2vQwjnMIlIfgcuM3EP2RFQz
        OmcaxrKcLCyiBzbqF/jqYKpn9fQBeVfw2LwZqfCaIBknhl+bfmryzwEml5b334n3IpO8n8
        9+4PKHbBcCwh1/aCRy7PL3xtD5lTFNM=
Date:   Fri, 16 Dec 2022 11:30:16 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        lee@kernel.org
Subject: [GIT PULL] LEDs changes for 6.2-rc1
Message-ID: <Y5xIuL2XfobFm9U1@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V/KuRtfYdVY2k8BZ"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V/KuRtfYdVY2k8BZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/=
leds-6.2-rc1

for you to fetch changes up to 7cb092a0336c5770656c6742e7a7ce3042c8c44e:

  leds: MAINTAINERS: include dt-bindings headers (2022-12-07 21:13:49 +0100)

----------------------------------------------------------------
Lee Jones offered his help with maintaining LEDs, thanks a
lot. Plus, there are some bugfixes as a bonus.

----------------------------------------------------------------
Colin Ian King (1):
      leds: lp55xx: remove variable j

Dmitry Baryshkov (1):
      led: qcom-lpg: Fix sleeping in atomic

Jiapeng Chong (1):
      leds-pca955x: Remove the unused function pca95xx_num_led_regs()

Krzysztof Kozlowski (2):
      leds: qcom,pm8058-led: Convert to DT schema
      leds: MAINTAINERS: include dt-bindings headers

Lee Jones (1):
      MAINTAINERS: Add additional co-maintainer to LEDs

Luca Weiss (1):
      leds: is31fl319x: Fix setting current limit for is31fl319{0,1,3}

Maarten Zanders (1):
      leds: lp5523: fix out-of-bounds bug in lp5523_selftest()

Paul Cercueil (1):
      leds: max8997: Don't error if there is no pdata

Rob Herring (1):
      dt-bindings: leds: Add 'cpuX' to 'linux,default-trigger'

ye xingchen (1):
      leds: use sysfs_emit() to instead of scnprintf()

 Documentation/devicetree/bindings/leds/common.yaml |  1 +
 .../devicetree/bindings/leds/leds-pm8058.txt       | 67 ------------------=
----
 .../devicetree/bindings/leds/qcom,pm8058-led.yaml  | 57 ++++++++++++++++++
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  4 ++
 MAINTAINERS                                        |  2 +
 drivers/leds/leds-blinkm.c                         |  8 +--
 drivers/leds/leds-is31fl319x.c                     |  3 +-
 drivers/leds/leds-lm3533.c                         | 12 ++--
 drivers/leds/leds-lp5521.c                         |  2 +-
 drivers/leds/leds-lp5523.c                         | 27 +++++----
 drivers/leds/leds-lp55xx-common.c                  |  7 +--
 drivers/leds/leds-max8997.c                        |  7 +--
 drivers/leds/leds-pca955x.c                        |  6 --
 drivers/leds/rgb/leds-qcom-lpg.c                   | 18 +++---
 drivers/leds/trigger/ledtrig-pattern.c             |  2 +-
 15 files changed, 108 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.=
yaml

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--V/KuRtfYdVY2k8BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5xIuAAKCRAw5/Bqldv6
8nHxAJ9CbKbhRcjQhEwOZ6okOh3Pfv0/QQCgldQirwwO9ITrjp36UQZpoV1Doj8=
=6bLQ
-----END PGP SIGNATURE-----

--V/KuRtfYdVY2k8BZ--
