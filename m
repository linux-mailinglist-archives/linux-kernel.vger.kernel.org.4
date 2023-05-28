Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E88713B61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE1RtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1RtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FEDA0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 10:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA31860F39
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59ECC433D2;
        Sun, 28 May 2023 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685296158;
        bh=n0XjSVQJWh6Lb4Vx1+EgDOuRbghMP0wZrgLFKU4OEOE=;
        h=Date:From:To:Cc:Subject:From;
        b=Sh8tlqSnXKcRowe999sDEXJ9+eBSCjU9Nt3/MaJ3vowzueCSLkOV25UwdkpG0rzHd
         bwmYmblWF1enu2NTzjN2S/FSu3O1vS/whk0yo5fZ+CFqGNy+OUF8imCA5CF2LOexid
         jVWU1HYUS7u3h0dUTB77tO3iJ7HYfJcc5pW+7FiZhVyB4rRFpaUk9G2kSL7K31EEEL
         lVx469yGit/LeQieXvJTpEtRWXunhPbruECJ8fg/HK9p6FzESqJZwXjCXVeOLfheer
         LRPEqA8TG3508NSsy0jd5SbnElBOI9p8i/GMyEmigvFcKy9ZJIWhxeU7s16n9+Drel
         Xk2J7W804UV9Q==
Date:   Sun, 28 May 2023 23:19:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.4
Message-ID: <ZHOUGa/W46wBDwmv@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6AtvqCyFjE72FhCo"
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6AtvqCyFjE72FhCo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive couple of driver fixes for generic phy subsystem

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.4

for you to fetch changes up to 2a881183dc5ab2474ef602e48fe7af34db460d95:

  phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc (2023-05-16 19:4=
8:55 +0530)

----------------------------------------------------------------
phy fixes for 6.4

 - init count imbalance fix in qcom-qmp-pcie and combo drivers
 - kernel doc header fix for qcom-snps driver
 - mediatek floating point comparison fix
 - amlogic fix register value

----------------------------------------------------------------
Johan Hovold (2):
      phy: qcom-qmp-combo: fix init-count imbalance
      phy: qcom-qmp-pcie-msm8996: fix init-count imbalance

Krzysztof Kozlowski (1):
      phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Neil Armstrong (1):
      phy: amlogic: phy-meson-g12a-mipi-dphy-analog: fix CNTL2_DIF_TX_CTL0 =
value

Tom Rix (1):
      phy: mediatek: rework the floating point comparisons to fixed point

 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c |  2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c            | 10 +++++-----
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c             |  5 +++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c      |  5 +++--
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c         |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

--=20
~Vinod

--6AtvqCyFjE72FhCo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRzlBkACgkQfBQHDyUj
g0dwPA//SW851Yy9IfLvwIP+1/3XYmj+SlYo8n07K0OxJiyM1ffeSHCxJq70db53
x6z81RkkwoNzvp73WmXt5scofLmdRoczXQr+UYj02Rtccz9756d4K8mrFooQnIOy
mZy7NhtCFhMkYx1wTrxWSHZF6uJ6BjsebZ6no8jtTS7oyE8rVU0lSG4ISlFlXFYk
jqpwrwwKij/0TNQPXlld5b2GNtfrVqFKVdC4gcVu3uG7sRLHDqBw9is+OAA3p0ef
B4s3Sb//4NUd+Rvaww2DHE7k4KIDeu4UGj9V+wAFw47zqBNqRCXcJjxvm6egiORK
gHz19pBLjLWKQSo2UcIze1xbuo+jgXxTApuzJHBxbZc/x4R9h1MXuUO8zwbNjYj5
IcBpYFafchNYFb45N517Z4QlbvuWl8o8HIgy9pmD38LzknEpRhMdFT9YPL8FVxJM
SID7isBIHngRli/9HFhzkbh56lsKylKLONcxdBf6ftLOxrHlj1gfJW20aX5RSqY/
mqisxmFuT+vXO9SYA5IkLwqoDPTJQlRTVB3DQGcFcu3TwQFlS6M86HrUO5HoaGwu
hKJ8crPI6PrjqvDD2sKfVetm+zE1Ha4R29qtVMwTXfhWPsYO2H4T4irYYD4iRd7z
rEfHTCsLFCHRcgoW1SoKWEhM+y3A0lOVsd4gdI+hAcGOdK5JqpA=
=DzrJ
-----END PGP SIGNATURE-----

--6AtvqCyFjE72FhCo--
