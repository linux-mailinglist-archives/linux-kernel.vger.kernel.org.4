Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32535F5932
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJERoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJERoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E575CC5;
        Wed,  5 Oct 2022 10:44:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so27002586wrb.13;
        Wed, 05 Oct 2022 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GOiHBfmaA8z/8lz5HmFRwUhuxBOZwEnbSHtvAmKlLks=;
        b=f41LOjaowwAFIOKK1Wtv2Lc0LAIPKpAIhKiF6Vssrb6pni0YVqAU0fw+N0lvbGDTcs
         MT8Kh6FYoKq77cx5YjBl4tcSiNjSDLoDwD22O73C4mmwzzVYxPzLApO4TnUm5sJg2clk
         4SwYXCdbBiUgxLg8W3Z8lA1/S5iMk6/iXjm1WJuv42mjnFQGNnyqLqMrPIOK+KJm2b3a
         WIlnX4YcpyW/bk0Tiv396NcEgjNMJy5enbP8zrjab43rxe9KvhHyBexwBN8QGV3AL6t3
         WhjjUtPOV0WU+bcnKg593+K7qi/eST9i4G+vZvuq01z8CHiu63EWS+lSNPCQYBUXsXZQ
         laYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GOiHBfmaA8z/8lz5HmFRwUhuxBOZwEnbSHtvAmKlLks=;
        b=lHGRc59A1kyL5ugiTemD+1o+VIO0NjLDKPM64ARJk+O2DnMvwDYNZet6WBlcrd77Jx
         REdoojNZO7K9tYjQYnTaryHpv+YQI/DWXQd5DB+E8TOuz0B0qKkKLNLCGpPVi2X1m2P6
         fkE6GEY0FQOKzDuHmK9SJj1H3PvQFVp2CWTDrwQDRQKuD6VRMurda9a3soio5CkgNE5I
         lC2Ub0S8pH85o53e/uKnYi0JTf48n8nlOAoqJ24duz66BOsm5PFrqkXE6e8jtn6ISwz4
         dMNTOafDSyOFIQTHQGJ6nj17T/KXUZAoN4PE0VuqfN5rscDE82BBFp63VmBtGkDtMWcF
         2JOw==
X-Gm-Message-State: ACrzQf2ttPS240YVxoEcDOsGoHxoAHwqD9VAV/pRlX47Jrxd54tewtxt
        nRgRa/QIDDPJ4YEq0R2NJ4yryoxgRqI7UA==
X-Google-Smtp-Source: AMsMyM5bTE3xFGk/IM9bs4NZT8IrIpQ2ces6QmIwgSu4k1Rv98OaCFr32CXpgGtu2UAnI/s2XX0Jsw==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr549084wrd.184.1664991853975;
        Wed, 05 Oct 2022 10:44:13 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:13 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] MediaTek pinctrl DT binding cleanup and MT6735 pinctrl support
Date:   Wed,  5 Oct 2022 20:43:33 +0300
Message-Id: <20221005174343.24240-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds a driver for the pin controller found on the MediaTek MT6735
and MT6735M SoCs. The two differ in the last 6 physical pins, which are used
for MSDC2 on MT6735 but don't exist on MT6735M (since MSDC2 doesn't exist on it
to begin with). In preparation to document DT bindings for this pin controller,
the existing documents for MT67xx SoCs are combined into one in order to
eliminate duplicate property definitions and standardize pin configuration node
names. Necessary cleanup is done along the way.

Changes since v1:
 - Combine other documents into existing mediatek,mt6779-pinctrl.yaml
   instead of creating a new document with wild card in its name.
 - Split first patch into smaller patches focused on specific changes.
 - Remove syscon compatible from MT6779 DT to avoid a check error.
 - Fix interrupt count for MT6795.

Yassine Oudjana (10):
  arm64: dts: mediatek: mt6779: Remove syscon compatible from pin
    controller
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges
    optional
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6797
  dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6795
  arm64: dts: mediatek: mt6797: Make pin configuration nodes follow DT
    bindings
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin
    controller
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin
    controller bindings
  pinctrl: mediatek: Add MT6735 pinctrl driver

 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  247 +-
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      |  176 -
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      |  224 -
 MAINTAINERS                                   |   10 +-
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |    2 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   20 +-
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 10 files changed, 4809 insertions(+), 454 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

-- 
2.38.0

