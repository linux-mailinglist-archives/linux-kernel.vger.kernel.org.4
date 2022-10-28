Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F218F611608
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJ1PgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJ1Pfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A17E011;
        Fri, 28 Oct 2022 08:35:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id be13so8924951lfb.4;
        Fri, 28 Oct 2022 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TN/VbXkwesW+Q2JTh4RoodpYQJLem7tSs3AFkQpa144=;
        b=kre6+kf+Bfs2qZUPhSAd3Orphb5tJDtPWCQs7IW7o0k7QKaJHNh3dXK7sVCrKuvZt2
         4gU9tYsY0IUBR21bmS/fW3cDyv/vVgglaz15/PV1rNO0ewW5i+AR1BcFUpas0WxM1lgm
         FdTMJ62fZtfZMc3LEBiXd86u+3yVpfTUQ++whI0WoehTLg397n1PKUcOlEazbmWvPh1h
         PIlaiABXqdROm1QRpvDPYtbBHAt1wIGxiErIOQKwz/Y9PQsw9fx+MbQ8Ixoz6tQlb48h
         isINRJN8PKhbTtuNvLIT12WfZ0F+rHXZidCvnp4eEZvtB452EWiYAN+ZEhOGW/JPvmlm
         F6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN/VbXkwesW+Q2JTh4RoodpYQJLem7tSs3AFkQpa144=;
        b=7cLUlISmC89TxiJDa2G9GyGxYY9nGPE1R4aqiC8mNlYCLYhcJ9Hhj0RaoIgFvHRkUo
         Yunm0MrZx4eY4dEL1lw8OLEiT4U792Tglmh2WrqS9LMsX7m/xsO4hrZ/JCJt/nhGxA1q
         WnnkEVSP1hCKRAPuDO7CMewL+nCUXo2P4yUlbEJHwPlIQGN2KFbEMA+9YMlQoKPUZcpN
         3wRMThmi//5ZbgfYb9dnNNHZyKXnbDyqqwAWtoYI+cPgi1LKGQVYdCAlAVErIOQBbBfF
         +2QsDWy7FJxFH9dtqwBAT3te5o/ulfic+iuj/OVqWEfgzIHjyTqyMcxZOA86FIqlqntE
         /J8A==
X-Gm-Message-State: ACrzQf12vSnNbCcwKDRgchCSDFDQ5mWqe0tSMtHAR4ZLIqZaUeT8UP3r
        uNz+ZFKVmEDyeTT9GyWKQwzf2hYIBdFlyQ==
X-Google-Smtp-Source: AMsMyM5PWMxFH7MgYaEUwVRyrioiTpyeD9ckYu4KzmwlSXUjziO6cc6F60LXGf+PwDYY9S6Q/icsPQ==
X-Received: by 2002:a05:6402:5107:b0:462:3014:3d73 with SMTP id m7-20020a056402510700b0046230143d73mr17041907edd.177.1666971320853;
        Fri, 28 Oct 2022 08:35:20 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:20 -0700 (PDT)
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
Subject: [PATCH v4 00/13] MediaTek pinctrl DT binding cleanup and MT6735 pinctrl support
Date:   Fri, 28 Oct 2022 18:34:52 +0300
Message-Id: <20221028153505.23741-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
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

Changes since v3:
 - Improve interrupts description to make clear what sysirq means.
 - Set drive-strength constraints per variant.
 - Set maxItems for reg in MT6795.
 - Add blank lines between conditionals.
 - Add ref for both pinmux-node.yaml and pincfg-node.yaml.
 - Make pinctrl subnode-related changes in separate patch.
 - Fix up some pinctrl subnode property descriptions.
 - Add interrupts items descriptions to MT6765 and MT6735.
 
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

Yassine Oudjana (13):
  arm64: dts: mediatek: mt6779: Remove syscon compatible from pin
    controller
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges
    optional
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6797
  dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
  dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Improve interrupts
    description
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Pull pinctrl node
    changes from MT6795 document
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve pinctrl subnode
    and property descriptions
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6795
  arm64: dts: mediatek: mt6797: Make pin configuration nodes follow DT
    bindings
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin
    controller
  dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin
    controller
  pinctrl: mediatek: Add MT6735 pinctrl driver

 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  308 +-
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      |  176 -
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      |  224 -
 MAINTAINERS                                   |   10 +-
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |    2 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   20 +-
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 10 files changed, 4866 insertions(+), 458 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

-- 
2.38.1

