Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4E6BF3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCQVad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCQVa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E452F793;
        Fri, 17 Mar 2023 14:30:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z21so25473795edb.4;
        Fri, 17 Mar 2023 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svSDOZGqlBpqSZHit5yPFayaIWAjSd1camlnzH3nrTQ=;
        b=qBjj+LCXL5CTTsQjeYzBYKmGk2JhYuqNk8h6xWpIf1IjIO8QqgA7NL+XgzI5VSAhq6
         +ESqetLdqoUO1N/V7cprhJuS4aMIcKzl8WyyAnCLi/OuHZ1sUTZ8h07C6DIRD4vFwX0Y
         5e3YVxnm8HS9IBg+N5T3e09pqbNnMHT2/bwX+OBfukrU8PuulcNTemocib1jv8O3qk3J
         3/nSSe7o6fFWVUFsBbI6oStAea9lmd962aGT7Y5SERvdxi1Ades20WQshTQUsZ6uNn8k
         Xqo+Pl8izHzS6FsZCu9vNy1z7jXMPe96DaNLv1yUfB8oo5DuzmFZU2CUsZ6vMQrqZnQy
         Dtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svSDOZGqlBpqSZHit5yPFayaIWAjSd1camlnzH3nrTQ=;
        b=KQ2wOJ8vZhPwOs43KlEwvu64hKfnJxNQLjQNcDpkKGUEzBTxJk2BJcJZYXdWbkqNbN
         adhlwFzQdp0/iTWeFhkFgthfZUEYWOeeJqmw+sXKoBM1r6swPVn6rWsXdGehU3JDEUVO
         OH10fG/QPcVli/zjvba/UHD5Wcbo4Gtoy4C1PQwgJ4ndDDwkfvxvC8domZUoiiBESP68
         1vNWItnHJmMDrE6olfUcyV+Kc9vVUAxhrAT6f8nZ4lqJpapaI4iake8lKL+Lm6XlgZj/
         SCmkeo3UJOznWwBB35ZJOh2P2EvbPcZ+7zvoPByAyrSSvD9Yo8vcz89W7d3wj7pJsvGE
         Hx0w==
X-Gm-Message-State: AO0yUKVTuhHWJc3zcL3pTOIHgtQ0CwPqK2cDU1oopzEtBWoNpx7bBhFt
        9aTTf/K2OwkrN5k1oAUJeNw=
X-Google-Smtp-Source: AK7set/pQx743ufDsmhqP+LNcld2+2C21qsGT/HHcejhagzLMOTjwEqtBzNzdsTyK4LILTlswmXGfg==
X-Received: by 2002:a17:906:118e:b0:92f:b290:78c with SMTP id n14-20020a170906118e00b0092fb290078cmr912511eja.21.1679088616596;
        Fri, 17 Mar 2023 14:30:16 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:16 -0700 (PDT)
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
Subject: [PATCH v3 00/21] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
Date:   Sat, 18 Mar 2023 00:29:50 +0300
Message-Id: <20230317213011.13656-1-arinc.unal@arinc9.com>
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

v3:
- Address Rob's indentation report.
- Add Rob's reviewed-by.
- Rebase to linusw/linux-pinctrl.git devel.

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
 ...mt6795.yaml => mediatek,mt6795-pinctrl.yaml} |  51 +--
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
 36 files changed, 1742 insertions(+), 1197 deletions(-)


