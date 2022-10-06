Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637665F6E52
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiJFTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJFTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C93CE9BE;
        Thu,  6 Oct 2022 12:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2233561A51;
        Thu,  6 Oct 2022 19:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D540C433C1;
        Thu,  6 Oct 2022 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665085322;
        bh=Qa/IEp98zkqXY1GN2d7egKbYWHOZZyTTYwXiz93Mbbo=;
        h=Date:From:To:Cc:Subject:From;
        b=OHOdAXGgwSpRkxR1cGDDqZEAn0Mv2s+QOcVC0iXjIPhYdb3xnH6V53RYIb96QqKVl
         spdE4J+9xqI2lUiGrmNLXfxo6kaq7itbHkoJnBNEHvZk8wVQ6Jw/5wMV6BM5+d1edJ
         Fjjc6gd9Bg8ijQCCbYinI5dxoCs3iNm5c/PAmK5FHit8TD7YLPlo1MNViVu1eyW5jd
         5oQnNt/bM/0jX2LAJmshVFsko6LmJsDUeSR0NYHS2YBd09o0LijySeRn9otq9j4wzj
         4DycDDur5DUQXGBkfF0JaokZ+AAaa3F2TNG5+wvgJQ54nNkNBQt1zehweanwdKbFRR
         Appa2fmvz0Vwg==
Received: by mercury (Postfix, from userid 1000)
        id 8C8C21063D19; Thu,  6 Oct 2022 21:41:59 +0200 (CEST)
Date:   Thu, 6 Oct 2022 21:41:59 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for v6.1
Message-ID: <20221006194159.4m7ybf2lduxncc56@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivrgtbtedpypfz5k"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivrgtbtedpypfz5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a couple of notes this time:

1. This adds the charger part of MFD_MT6370, which you pointed out in the
   backlight pull request:

   https://lore.kernel.org/all/CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com/

   As you mentioned it can be build in linux-next and the required config
   symbol is part of the MFD pull request:

   https://lore.kernel.org/all/Yz6Zi7B2RS16sXhT@google.com/

2. While talking about MFD pull request: This time Rockchip RK817 charger
   driver is send via that tree due to dependencies.

3. There is a merge conflict with the i2c tree; but the solution is obvious:

   https://lore.kernel.org/linux-next/20220912130344.2e635cd5@canb.auug.org.au/

I hope, that this is all :)

-- Sebastian

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1

for you to fetch changes up to 189a2aaef9cbee4cd7c3d1bd142f790cc14c598e:

  power: supply: ab8500: remove unused static local variable (2022-10-05 23:47:04 +0200)

----------------------------------------------------------------
power supply and reset changes for the v6.1 series

 - new maintenance charging documentation
 - mt6370: new charger driver
 - bq25890: support input current limit
 - added Qualcomm PMK8350 PON support
 - misc. minor fixes

----------------------------------------------------------------
Anjelique Melendez (1):
      power: reset: qcom-pon: add support for qcom,pmk8350-pon compatible string

Ben Dooks (2):
      power: supply: bq27xxx: fix __be16 warnings
      power: supply: bq27xxx: fix NULL vs 0 warnings

ChiaEn Wu (3):
      lib: add linear range index macro
      dt-bindings: power: supply: Add MediaTek MT6370 Charger
      power: supply: mt6370: Add MediaTek MT6370 charger driver

Colin Ian King (1):
      power: supply: max1721x: Fix spelling mistake "Gauage" -> "Gauge"

David Collins (1):
      dt-bindings: power: reset: qcom-pon: Add new compatible "qcom,pmk8350-pon"

Hans de Goede (1):
      power: supply: bq25890: Disable PUMPX_EN on errors

Jules Maselbas (1):
      power: supply: Fix repeated word in comments

Linus Walleij (1):
      power: supply: Explain maintenance charging

Marek Vasut (1):
      power: supply: bq25890: Add support for setting IINLIM

Nathan Chancellor (1):
      power: supply: bq25890: Fix enum conversion in bq25890_power_supply_set_property()

Randy Dunlap (1):
      power: supply: mt6370: uses IIO interfaces, depends on IIO

Sebastian Reichel (1):
      Merge tag 'psy-linear-range-for-v6.1-signed' into psy-next

Shaomin Deng (1):
      power: supply: tps65217: Fix comments typo

Tom Rix (1):
      power: supply: ab8500: remove unused static local variable

Wei Yongjun (2):
      power: supply: adp5061: fix out-of-bounds read in adp5061_get_chg_type()
      power: supply: adp5061: show unknown capacity_level as text

Yang Yingliang (1):
      power: supply: mt6370: Fix return value check in mt6370_chg_probe()

Yuan Can (1):
      power: supply: ab8500: Remove unused struct ab8500_chargalg_sysfs_entry

Zheyu Ma (1):
      power: supply: cw2015: Use device managed API to simplify the code

wangjianli (1):
      power: supply: cpcap-charger: fix repeated words in comments

 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  50 +-
 .../power/supply/mediatek,mt6370-charger.yaml      |  96 ++
 drivers/power/reset/qcom-pon.c                     |   1 +
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500_chargalg.c             |   8 -
 drivers/power/supply/adp5061.c                     |   9 +-
 drivers/power/supply/bq25890_charger.c             |  30 +
 drivers/power/supply/bq27xxx_battery.c             |  60 +-
 drivers/power/supply/cpcap-charger.c               |   2 +-
 drivers/power/supply/cw2015_battery.c              |  14 +-
 drivers/power/supply/max1721x_battery.c            |   2 +-
 drivers/power/supply/mt6370-charger.c              | 961 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c          |   2 +-
 drivers/power/supply/tps65217_charger.c            |   2 +-
 include/linux/linear_range.h                       |  11 +
 include/linux/power_supply.h                       |  48 +-
 17 files changed, 1246 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
 create mode 100644 drivers/power/supply/mt6370-charger.c

--ivrgtbtedpypfz5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM/L34ACgkQ2O7X88g7
+ppfeg/6Ak/Qx6NU8fx4qg5l+7fwfVpgnDUvPhP5wBcihubHwfhThPo81CwWu+c+
uqLutISMGUq+YTvWPGDMrBK2y9YLzAPDIghlrRFmxaI56gjbxmHa+T8c9GCVpTpQ
fhfTC5HnNqQOMGbB2zl0fr133zs1QQfvdcPpM+FSFLMP3qhRJvA0O/nHZxYEXRec
l6x/cLCRpBPmkfKISDyKn4i3kA32IYJD0hQsQ5w84eydnozxqSCta/udXeo40uPb
7OnreRjQk3p91oBd8uKn5TUgylC89PqI0IlyjrNSRaDmN5MgcHdkhYhQKj5dLtZc
glfjyT9+MIDQ34dSKVJINWDnq4xo2MgBAQ3xkciyHr0H4jh1HGYNmNFAN6+NPPAJ
O/xUMxro2rM7jIpGH9iC0L6+L3ZJ/056iEMiBwvN2QgE+1J0NDnPthi1R3iyCwWm
WeSajMKHT6fI/ecK4qKeOBCgRIn1MXlCTjlt/mk1n/vLhL/C9cSDLOtdlkBmJ7d+
45VDDvWuy/L+7hFXcH6ms+e1Agrb2TTuOBWJl6bssLNXtE9Vvh0GO2O3KV7g751F
I+dprcr/xUPPVhSMcW8ZdrDyNjGFF4TREuejt1MwoioPLi74YpA5wlZqE7ZhLO7a
VgZos9nESGPkzG/4W1e2Jd7RYnJkBUlFYgu8Jy3v80x7UDKIWsA=
=Nplf
-----END PGP SIGNATURE-----

--ivrgtbtedpypfz5k--
