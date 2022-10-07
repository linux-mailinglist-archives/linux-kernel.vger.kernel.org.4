Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D45F786F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJGM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJGM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F1C0F;
        Fri,  7 Oct 2022 05:59:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv10so3628013wrb.4;
        Fri, 07 Oct 2022 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoXR88retRSnzKi9SQ+DNP62Xg+ufywzOFm5LdXFhwY=;
        b=k+mVXH4Gz8yB/q4XKu2MrFh1OKP+bdxk7cyfhuTqgtj+7CONa+B9JcYsVqr/CZr3dT
         vB/XjU8pDovv24Ac2NIOUZQHqAk/oyB3OXn21lTj1wM+a9w3/hPRwArb5CHwATxdfS34
         5feYWg+Ng0RhIHTGYtacIZdFmHn4NFQbDYIbm1koA3XIqqdn23sbfLZN4PEEgLcVipue
         tQXVpvEc6Kgu7tbmQ8/VVEq3xgoVrZSz71AmO7PmfRch8BDmRkGwRCr6v7deBE4Qz/FQ
         HRKmUub9UaKImMeQselqUYejMLKtRlgAlagEPLMpAhjKqosJBNc5kwxzs/DtLjS+f7qk
         lBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoXR88retRSnzKi9SQ+DNP62Xg+ufywzOFm5LdXFhwY=;
        b=NbTjuepipcBqqBtOu1TySP7sghcd2VjeuzvMYtm+qGHddIRVzvNGUrMAIKHWnX/scC
         MbquiGPuIjrOZZyy9OukiRpI9ciVa8cCOY0FP8H09DAa/mdgjuKIKNJ4+9qEsfjPMsgy
         cBEtDIMF4CxDSZfczYNHdxMXqm4toxJ9SQi9awTD9HJXDb0j1rEs+Yxey8PEyXwTA0Kl
         A04U68pJi/9NHF7ZAwnaSFoQdN6MWo1Xs/UW7y3PomIvB6433itpBJaXV9hkbUetwr1P
         2GI2iKmz1Q+TKVKZUNHe/tXHZYwSjcsf1WafcnEX4os2ymMlI5hpshkL23lPaXd0oDcF
         CnSQ==
X-Gm-Message-State: ACrzQf2x+2B3vD8OGHcg+gD4sGUzYYXVdgJT1dLVLa67ifnXoAsheWSX
        QYvs34CyPvfLkxFtqbBjCjo=
X-Google-Smtp-Source: AMsMyM6o9uWfQyFqAn0xA1CEOLG02sgWyrjx3yIgDqq8ibYW2qogc2VijL0OLTkJeKDzt5qoWEbBFg==
X-Received: by 2002:adf:e491:0:b0:22e:4483:a8b5 with SMTP id i17-20020adfe491000000b0022e4483a8b5mr3252574wrm.497.1665147573296;
        Fri, 07 Oct 2022 05:59:33 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:32 -0700 (PDT)
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
Subject: [PATCH v3 00/10] MediaTek pinctrl DT binding cleanup and MT6735 pinctrl support
Date:   Fri,  7 Oct 2022 15:58:54 +0300
Message-Id: <20221007125904.55371-1-y.oudjana@protonmail.com>
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

Changes since v2:
 - Add interrupt descriptions.
 - Change interrupts property item limits.
 - Move pinmux examples from node description to example dts.
 - Properly add myself as maintainer for MT6735 pinctrl driver and DT bindings
   document.
 - Remove tabs from a few defines in pinctrl-mt6735.c.

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
    controller
  pinctrl: mediatek: Add MT6735 pinctrl driver

 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  254 +-
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      |  176 -
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      |  224 -
 MAINTAINERS                                   |   10 +-
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |    2 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   20 +-
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 10 files changed, 4816 insertions(+), 454 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

-- 
2.38.0

