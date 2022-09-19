Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4EE5BD326
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiISRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiISREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE040E23;
        Mon, 19 Sep 2022 10:03:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so4150706wmb.0;
        Mon, 19 Sep 2022 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gqdfX/1lhtDbmfJeIadecs7tBJ8OWa8eyinT/PgvpPY=;
        b=ZfZ3F+T1rO9Xo20L5ZV5e36zfIvSTZwRqaV7ygVZzaSQ75HuDe4xA/hc51RpZqn5MM
         iST2P9W7JgM8TgtkvbIfkSbCJGmeKPfiKsQOBJ+7cRoVFK60lcqYLSdHc106YtDtTwTs
         zgXplemn4zZOHF0lsAvJPMr87eMjq4BQAz7V2xOEXrU6zeucfTAYKc8bvfgXLiZy4ntg
         THeiSiZH27eIjQCsjcoPRl8Bo6wIn9iHcDycodSpvC71vivtqksYXFnei2q7MRE0o37d
         JV8E1kRa3Cp7AusVUjCpc1QFzRUU4+m55nEc5dpe2+QGIumSTLpxGFF5/Zy0/G5lSk+9
         Jbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gqdfX/1lhtDbmfJeIadecs7tBJ8OWa8eyinT/PgvpPY=;
        b=4qRzmNSzMp5HvYCyuoyU3yKcC511d+5N/usgCO29XgjwhaQG3Orr3+hJC7FOVoAX0m
         XUzmZ9RhDWsKpDGklE/OPjSHJIaG/tAnPzV9eRoeA+N0m/pIAKJyYFnSvPCOkO4xfOkM
         4qv7aB9P8pHdmk3xRXKm9mYRxrubWDBI015f1V4Ifoq3JXuIyHPiGl0nojqBwpBMXSEi
         BJx8gqTx6P1o8vqVR2Dq4nOZMp2YdmviKhkaUmJDWRzaziN/LLdNWg4EioAlDJaLv7WF
         hNGjLhwn4MyIvnVDq4uvSYRWQKKXApXCA4k66Id5hREgnIEJYyB/h/iAbrWnVNx0TOV6
         WvXg==
X-Gm-Message-State: ACrzQf0RS9+vclMhcCIFtn8MNqp8ZLDphrr2Yiy8y7nKOnt98JEZhN2+
        +9nUHPSTs88NLAu6P1hz2LE=
X-Google-Smtp-Source: AMsMyM53aRgt7aTtewkEJRuCo4upKB8GdNM1JJ6NEcbMTicVcQPz3s47Zg2Ya84IFAwXiMMXV79GRA==
X-Received: by 2002:a05:600c:26d2:b0:3b4:7572:4317 with SMTP id 18-20020a05600c26d200b003b475724317mr13194152wmv.134.1663607009937;
        Mon, 19 Sep 2022 10:03:29 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b0021e6c52c921sm17562487wrb.54.2022.09.19.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:03:29 -0700 (PDT)
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
Subject: [PATCH 0/4] MediaTek MT6735 pinctrl support and DT binding changes
Date:   Mon, 19 Sep 2022 20:01:11 +0300
Message-Id: <20220919170115.94873-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.3
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
names.

Yassine Oudjana (4):
  dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl binding docs
  arm64: dts: mediatek: mt6797: Make pin configuration nodes follow DT
    bindings
  dt-bindings: pinctrl: mediatek,mt67xx-pinctrl: Document MT6735 pin
    controller bindings
  pinctrl: mediatek: Add MT6735 pinctrl driver

 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  207 -
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      |  176 -
 ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} |  222 +-
 MAINTAINERS                                   |   10 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   20 +-
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 9 files changed, 4778 insertions(+), 441 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt67xx-pinctrl.yaml} (58%)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

-- 
2.37.3

