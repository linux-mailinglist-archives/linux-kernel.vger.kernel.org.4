Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD6703EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbjEOU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbjEOU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:57:36 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B449C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184253; bh=PTnWKOVwScKl+WCgTZ/8M6vIAo8mTXk5S55Q7MA7xKE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=kKGzwWqRKpguxDZ6mAEHK2jo/7plMV2/QW2A7dQlCtYSmvTM/2vL8q3Y3hOawWM5H8OGFZRORiprs4SnyuKlXVmIa9hv95qE8qNlQoIdZwLC81q9dHnp+ITqGLfVqO9ew3oTrXAXI7wDPmpRnNdSPMCIEgRhRXc8ty7daGA42F4Dkz1iy4qfin9F9AEfDBJWORHqOFGRhqzkOGw9gahL6VzlUynzeDfwqZi8pB3KUKPBx67wnTs/OHe9AaqJy1WS/ywL/ALRGLx/yZ2l4kUX5rcXUuvef1lxI3AYJqq0aRsHaPf6c/ObCooNSl/REmKw8dugFSAr5TKYx0dgYduw+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184253; bh=3UZj6+IUbu1dpgrCiSSAmArtJ3E03R0SU/FNwslWfcm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ahJwCd9pPmQr2Gh74FjyXDln3OQKdA3BJQlJ0uZCfmPTBhMt7ghD/ztn1Fk0S+irsiFUY2fGihEdLTTQtOPS9YIIkJkHy8Ha6Z/Yt/CSVryK1RguTTFSPfKNSumQMwZ3dUt5iHUDJJgm/6in4wmPCLXiu7vT8Z/5ZKLGt35nB+4TEqqrcX/NId2L0d/YdcY/ipmjebzjx57wuK20mUGR/BHh2jjXJf8N6wQFwxBYe+rCRPixoTtBA81Gced3syLStoarohEO7tx9iOdj7GdEy4ebfzvALhbITBS6v8VVYs56vbF+ppIgwYo42BVu3CFRmux8muSfwQ7kM/y+PL5vDQ==
X-YMail-OSG: ZgSqx44VM1l6pv4qLXh6meoNUTjgGmGzVKAe_XDFLeE1Rt5yBwuVtHORvMBaVLV
 BFb8Qutd2s6mH3S8VSpDoPSMW_K9x6KiU4VSCU39G93BwwBy8URVzddnWRwJpfxMHSxv7JZUCJ.x
 lCGOLMzhNBjBAGWYxVsMKV.i6Bg3ibAeZbwIjcJmfpss1B08uauzFg5sBbYUv_w84zZuKGMvqj97
 PA6momNAf204vcq.3acaTFBqJxQDAkf3tvWfZZIYS9ZINl_XCWReSuB6n6ngbKaw3ZCz1izZBCYx
 ceRPXdMeT7NrRzUWp.uURRjJcrmGLJWodmoaXuYlaeKOgW0D0czF9a71ka85q3FTH.GZsZHYEA9m
 WnyjXwrlHqn4ecDrrMMbRw6HWNc1GLripU3r0kSvQMRCews3eH7ucwFywrvYtHPl7DXDJHpOqYiT
 W3fLUJN8.M4k7GXOznOAtmADbYtWs3qJGuHhnVp1YyjrU9U1S1EN7Na15.MwolxgE08tjzQbH2_.
 aIhYHpx9Ke2mPwevCy06p6ch7XkaYy5DwSrHdzSvrgM9rhUztR4ZOSQa1CDv35eZcIKM8PYHyIlZ
 XTqz_u2etKBbsFYPOJTFJOlmwjSyaxQt5owjeKVcFXXZA8_maotSaNRGtlTIgy9FlqFqXDDxDEUz
 5IHBjmYf_cF5BFs6chuSGqjGN58KfW2ddZYERnXwsCjkYdzToLDQE30m5_U8LTQJBiDpr6MgqWU2
 ufSu9RGU50RCy9_4aAo5o2M7k2CHgMZ08UnTOaW_bdH3jIkXR1S2o_vzuRv9FLzzGDsQU8fOVq_s
 6m018t4a4_5VExUQOCLYoZ0HsWs5eOIAJZeauUP74Ib9fg0_4mba5GE9MWCV.3iM5f.o803g.Uto
 an9vkZlLTDMsDOP2i7v7Yy4_TIXw5S7Uo1ZY7NQUWegz9XMKu2t9dK5gHE8IXj_p24IaQHEHx8Rr
 pDSowvwcNmjhCgjvoGHq.Ea55clQooYDRrz2vZCyJzGezEif0We3XhESSE1rWPBQfMxORGL6BnyV
 GPjPpkRCUUcGb4N7qiBvEfCOunYGHbkTQbrSvUjmNwISx_qO9zw5PmuSX78bB7QNHWv5FIa1lPxT
 Xm1rP3tUMwZWdnOcu4W9_Kl3jAShCUFoyRBRm6cg_rSJp6gkh.Yf8gs1zfWL7habIu_VtmqhM0he
 g4hItp4pwtqVwf3ZV3BGMcAf17zm.PNWfyjhaZ0_qbSX5J5kUsM9M9V34PqSMbR2C7inlFZamdXP
 5vYKtUiz4tvGARTN1.CbEa_pv0zWfxtAwmaL.mGiH46mC0CNygvI2YHUI1j.WC6FvfOctyhk3MX_
 SMQ0e60lSIJQdLYyTAvdClbm0k_qj48dmA.ix0BtaWPKGIbpZpfXOvN2FiBoAQpgGsa4rodKKPrg
 ujhzoyjoZHAKIUhi0FKaECdoqIMj.gOErhvN4ajpYZ2nTY18DKGMNqQKSzqjmzdNgrMgHP6nXBsL
 Ps.r7RiH5f1fDHdMVlteoCXZos0DguUU9xrm0lDBQGPdzukk8vPtWPLK4UlKl3aontFC1rmw4st_
 cQ1XFAYJU9QX6xaZCkErBNBcub6L40BCJLBiPVI7DCmEcXh1m_2rS8ahLHbszRas97HgoIDePVGG
 XJjNdX4IV3Sy_5vcZLc7lIsOks4DQWUcwh7MLDuYvT4kyUc5MckBZ7V7QtWN.VKCPpbtCQen_xRs
 IjtzwmmQyqFuw7SHQ759xJpXX6TrEZQUBkx3Ccd1sSjOzqo2kqNRQv9CmSPgtBHTR5GzbkB_hjy7
 QUyHas5uEoftbjTI4GeLglaalgFKsL9vLyaPLiCPRN8h7IVyseeZRG6E88omIrsUiyqA32fW6gm_
 d7ebWP_CYPpw3TFRwdS04qj_rSUb66oLG4xY2RXTmNUMeDzw0qwJQEXXR7ZZ_JhVmgTuikS1p3MG
 r8fW4YtXfNRAAf91QjvweiAH2IljNznHjhFwej1RyekEL6di7biI.3YVVgXiRUy3u6v4vJDHxnkX
 OotTqE5y1phbuQpenfFo6IeJoxZ42CdJ0HXIAzkSKcourKbFbWbovXqAC1XvuE2TG9EcLPWXWv9_
 QZTwJkq7HoJzGdUZCQTWJ9QHACyz.M_h6Oza0540Q5DqJO_FZ3diqJbS9TEpHEvGInc9OTPdu8Qh
 5GK5Q.qygug12a.GkQLaKf4NdVXTzp7J0DZhEZq08ULUtPYn31Raby9XxG58Dzax3.fHH7LbAZFU
 9G_XpMh3xeWTuZtovVty8M4qppJOt4yU5QObJuRdxveOopNcoQawrnGRcar1BZqWOHcbJ2GtJEWW
 bnXyTv8ZoxxNLjyD.xQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 71a0360b-f41b-4c59-ae84-6f36526fd548
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:57:33 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9295bf04d78301a0059f933a0cc30ae0;
          Mon, 15 May 2023 20:57:29 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 00/10 RESEND] Add RT5033 charger device driver
Date:   Mon, 15 May 2023 22:57:09 +0200
Message-Id: <cover.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the charger driver "rt5033-charger". It is part of the
multifunction device rt5033. The patchset is based on an older version by
Beomho Seo of March 2015. For more information on the history and setup of
the patchset see the cover sheet of version v1, there is a link further down
below the changelog.

RESEND: Sorry for spamming. The first try of sending v6 got interrupted and
was split into two threads on the lore list. Therefore sending it again.

Changes in v6:
 - Patch 5: In function rt5033_charger_probe() after
   calling rt5033_charger_dt_init() replaced the return value from "-ENODEV"
   to "PTR_ERR(charger->chg)", as suggested by Christophe.
 - Patch 9: Changed the patch from adding "power-supplies: true" to replacing
   "additionalProperties: false" by "unevaluatedProperties: false", as
   suggested by Krzysztof.

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t
v4: https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#t
v5: https://lore.kernel.org/linux-pm/20230514123130.41172-1-jahau@rocketmail.com/T/#t

The result of the patchset v6 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v6/drivers/power/supply/rt5033_charger.c

Jakob Hauser (9):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_battery: Move struct rt5033_battery to battery
    driver
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: power: supply: rt5033-battery: Apply
    unevaluatedProperties
  dt-bindings: Add rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++
 .../power/supply/richtek,rt5033-battery.yaml  |   2 +-
 .../power/supply/richtek,rt5033-charger.yaml  |  65 ++
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  38 +-
 drivers/power/supply/rt5033_charger.c         | 744 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  24 -
 10 files changed, 1034 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

