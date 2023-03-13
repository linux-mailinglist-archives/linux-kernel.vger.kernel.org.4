Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C16B8355
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCMVA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMVAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028F84808;
        Mon, 13 Mar 2023 13:59:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x13so6733088edd.1;
        Mon, 13 Mar 2023 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clG8kMvKt8WSjuvF5NCWvQYiJ04cwb/jYow6A+hKr4E=;
        b=KtD/In2gR0Za9xDMzjRferPOBx/btX4MyGerGbdhQVIIS95VrhGki8CA14iF/5pYBZ
         jFztYdpwDGH7SjLbmhUuAiXZsGaJl6L3wCEuJWrwHw8x/YHHy9z2qZngLlbj3qAYyP0k
         wRIFZinNF5irrpMxU1Nl5ZRxImJc8YYbOIiyTurdVgAQJIguRuWy9V0jcdPEyRFknqjv
         jo8gk9/pDn5f6zYo/+CxvSF3+QuEOBsAgXFtpSoHAhAN8e78E2/rSRHwIOGlj+oS2oRj
         j0EpnpRsHTqqLkKOdlVrRguM3bm+Nrg+2qW5BTgXF3qBJGT4ED5QR1uurhKMOFbkQos4
         YC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clG8kMvKt8WSjuvF5NCWvQYiJ04cwb/jYow6A+hKr4E=;
        b=uTJP3GeDoeWD3XMDiibTQKo86BHSwY1gYDdzf5D3E4UZXI6Scq83LtTJ2CGCsCgjCd
         l56DAb3HX2gG3vjYGj6UZ1jD83NTvKZmxadD3KnbvO3ccT19HeT1+0dHfGjGi6vnU61N
         GN12hQO5cULwQIphVKwvpOMinven4Ns5qbdKv6dqTtlM4xmJ9TYcItDAocrr9/qnq3u/
         15eNHYCQXMtVx11wbkyAA3ICx5zkjHZc2IWuX1wX86GK6/Zk4E0WDBz4JBo3xLwd+uJK
         Sn0z2tiPR4fde4Gc6EzpCO2F166fYOCn+Z9q21aVzUPcC8Ys2fbieVPb1HcdFKZK71ix
         ekFw==
X-Gm-Message-State: AO0yUKVBmjNFevGckzYO/CrgtB3LSr6zxDQP2fU7aobg9WqhOsPE7y9X
        wVTjj3XF12m6VwOpArjfCFSd+7gQlO3en6Yn
X-Google-Smtp-Source: AK7set8LdIjCZD10owBtNeRy8tit/0u7lbXw3YqjC210RIL5GUaWh1N8ZA+yROCO+JoF/SpRl01dSQ==
X-Received: by 2002:a17:907:3e2a:b0:929:bd3:eab4 with SMTP id hp42-20020a1709073e2a00b009290bd3eab4mr6017338ejc.68.1678741192216;
        Mon, 13 Mar 2023 13:59:52 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:59:51 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH 00/21] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
Date:   Mon, 13 Mar 2023 23:59:00 +0300
Message-Id: <20230313205921.35342-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an ambitious effort I've been wanting to do for months.

Straight off the bat, I'm fixing the ABI that I broke a while back, by
reintroducing the ralink,rt2880-pinmux compatible string.

If you take a look at the schema for mt7620 and rt305x, some functions got
multiple lists for groups. Like refclk on mt7620. Because mt7620 and
mt7628/mt7688 SoCs use the same compatible string, it's impossible to
differentiate on the binding which SoC a devicetree is actually for.
Therefore, the binding will allow all groups listed for that function. For
example, if the SoC is mt7620, only the refclk function for the mdio group
can be used. If one were to put "spi cs1" as the function there, there
wouldn't be a warning.

I address this by introducing new compatible strings for these SoCs, then
split the schemas. I also separate mt7628/mt7688 from mt7620 pinctrl
subdriver in the process.

I wanted to split the rt305x driver too but too much code would be reused
so I backed down from that.

This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
introduced new SoCs which utilise this platform. We're moving the Ralink
pinctrl driver to MediaTek, and rename the schemas for MediaTek SoCs to
mediatek.

I've renamed the ralink core driver to mtmips. I decided to call the core
mtmips as I've seen folks from MediaTek use the same name when they added
support for MT7621 pinctrl on U-Boot. Feel free to comment on this.

Arınç

v2:
- Address Rob and Krzysztof's reviews, add Rob's acked-by.
- More more cleanups, hooray!
- Don't add new mediatek compatible strings, we don't do that here. RIP
Chadwick Boseman.
- Don't deprecate ralink,mt7620-pinctrl, we need it now.
- More slight changes I can't currently remember to mention.

RFC to v1:
- Address Rob and Krzysztof's reviews, add Rob's acked-by.
- More cleanups, hooray!
- Keep ralink,rt2880-pinmux deprecated.
- Deprecate ralink,mt7620-pinctrl. Another one bites the dust!
- More slight changes I can't currently remember to mention.

Arınç ÜNAL (21):
  pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string
  pinctrl: ralink: rt305x: add new compatible string for every SoC
  pinctrl: ralink: mt7620: split out to mt76x8
  pinctrl: ralink: move to mediatek as mtmips
  pinctrl: mediatek: remove OF_GPIO as reverse dependency
  dt-bindings: pinctrl: ralink: move additionalProperties to top
  dt-bindings: pinctrl: ralink: drop quotes from referred schemas
  dt-bindings: pinctrl: ralink: add new compatible strings
  dt-bindings: pinctrl: ralink: {mt7620,mt7621}: rename to mediatek
  dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pinctrl
  dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pinctrl
  dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pinctrl
  dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
  dt-bindings: pinctrl: mediatek: fix naming inconsistency
  dt-bindings: pinctrl: {mediatek,ralink}: fix formatting
  dt-bindings: pinctrl: mediatek: fix pinmux header location
  dt-bindings: pinctrl: mediatek: drop quotes from referred schemas
  dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
  dt-bindings: pinctrl: ralink: rt305x: split binding
  dt-bindings: pinctrl: mediatek: mt7620: split binding
  MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl

 .../pinctrl/mediatek,mt65xx-pinctrl.yaml        |  32 +-
 .../pinctrl/mediatek,mt6779-pinctrl.yaml        |  39 +-
 ...mt6795.yaml => mediatek,mt6795-pinctrl.yaml} |  43 +-
 .../pinctrl/mediatek,mt7620-pinctrl.yaml        | 298 ++++++++++++++
 ...inctrl.yaml => mediatek,mt7621-pinctrl.yaml} |  17 +-
 .../pinctrl/mediatek,mt7622-pinctrl.yaml        |  34 +-
 ...inctrl.yaml => mediatek,mt76x8-pinctrl.yaml} | 252 ++----------
 .../pinctrl/mediatek,mt7981-pinctrl.yaml        |  35 +-
 .../pinctrl/mediatek,mt7986-pinctrl.yaml        |  80 ++--
 .../pinctrl/mediatek,mt8183-pinctrl.yaml        |  32 +-
 ...mt8186.yaml => mediatek,mt8186-pinctrl.yaml} |  55 ++-
 .../pinctrl/mediatek,mt8188-pinctrl.yaml        |  80 ++--
 ...mt8192.yaml => mediatek,mt8192-pinctrl.yaml} |  57 +--
 ...mt8195.yaml => mediatek,mt8195-pinctrl.yaml} |  51 ++-
 .../pinctrl/mediatek,mt8365-pinctrl.yaml        |  30 +-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml |  11 +-
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml |  89 +----
 .../bindings/pinctrl/ralink,rt3352-pinctrl.yaml | 243 ++++++++++++
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml |  11 +-
 .../bindings/pinctrl/ralink,rt5350-pinctrl.yaml | 206 ++++++++++
 MAINTAINERS                                     |  29 +-
 drivers/pinctrl/Kconfig                         |   1 -
 drivers/pinctrl/Makefile                        |   1 -
 drivers/pinctrl/mediatek/Kconfig                |  54 ++-
 drivers/pinctrl/mediatek/Makefile               |  63 +--
 drivers/pinctrl/mediatek/pinctrl-mt7620.c       | 137 +++++++
 .../{ralink => mediatek}/pinctrl-mt7621.c       |  31 +-
 drivers/pinctrl/mediatek/pinctrl-mt76x8.c       | 283 ++++++++++++++
 .../pinctrl-mtmips.c}                           |  90 ++---
 .../pinctrl-mtmips.h}                           |  16 +-
 .../{ralink => mediatek}/pinctrl-rt2880.c       |  21 +-
 .../{ralink => mediatek}/pinctrl-rt305x.c       |  47 +--
 .../{ralink => mediatek}/pinctrl-rt3883.c       |  29 +-
 drivers/pinctrl/ralink/Kconfig                  |  35 --
 drivers/pinctrl/ralink/Makefile                 |   8 -
 drivers/pinctrl/ralink/pinctrl-mt7620.c         | 391 -------------------
 36 files changed, 1738 insertions(+), 1193 deletions(-)


