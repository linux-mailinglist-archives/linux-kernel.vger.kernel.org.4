Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57E162F3B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiKRLch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiKRLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C69BA29;
        Fri, 18 Nov 2022 03:31:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a14so8848268wru.5;
        Fri, 18 Nov 2022 03:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8qpOHGlOhZYR6pVYrTYVhfVUaK3uhqqUMzIDSjxxZ4=;
        b=BwfGT3C99fgwftzC5OnNV7hU6aNSoYA1b5/aMNHdS1dLyOO/Hb2iAYzjv/+Bxbh/Hi
         +jnX8GWvnGy5BqXAsOmrJgvTk9G0wYpTdoiP1vzf+OUs0fd5NFGhRJb71549uzCaEKFb
         jsmQeurYWPrFWu0mGJuaBcqMv+AkmZBZhQn8PX9ohezOJvcJdBhbT605K3vvx8SluQ6g
         deLdTlMcL1+6rYuMQkxGR9MLZzeAyO/fst50YXdBLC5gmL/cqNF3ugaeXsxPQ9skjult
         D61AAzQfKKeWKI5wbI3OFSeC45wPjFzUatGDGJMGBFPbxJ+NWlTABFU7isdsKdEEO5Se
         jHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8qpOHGlOhZYR6pVYrTYVhfVUaK3uhqqUMzIDSjxxZ4=;
        b=NXQlLFRNsjbySbAP8cjWAMUqLjCfUzlEacyQgWqjKPUEnRAISKlZ1i6N2xVVyihcwq
         Zuq4uvaXv+JiABBzWhmz9JNpTSyofLK/FZEx/M6VvpLVGemx5WA7HbSpl/Sv+yMHEMeK
         V4vvFl4iyhUGSwUOz2TSAyn3egL4tO6b8owks1ZlcZayW8v5aGG7c1ELXMs6Bsr6Nnbf
         AuNw5vzIGl9+dmcV+cuDnD8yDjNDDokJTFn2otFvai/3cA2i1akI7o8YKyvIZTrtNC0o
         dWxEUXkcfRzAT4eP7N3eQM0pyP5zcd0xIryz3YYtndWqHZ9FVJvPYdHEaiBGb/u6Dn9A
         KKzg==
X-Gm-Message-State: ANoB5pnRYyWI5F9SflLPdjEfY3YkFVa2AuZV2txZtsJrLplR85cY/g2X
        QHI8rXGyX59Ezo+Qmcbw9Lk=
X-Google-Smtp-Source: AA0mqf78tC8zLLLrVwtpZodpwAvwC85+Ssq8kXfWKY0JubDzNVdSXmpR3zF4XZLm/lh/NF7M8xCfCw==
X-Received: by 2002:a5d:6745:0:b0:241:b2b2:7c50 with SMTP id l5-20020a5d6745000000b00241b2b27c50mr4081224wrw.613.1668771112672;
        Fri, 18 Nov 2022 03:31:52 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm9894817wms.5.2022.11.18.03.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:52 -0800 (PST)
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
Subject: [PATCH v5 0/7] MediaTek pinctrl DT binding cleanup and MT6735 pinctrl support
Date:   Fri, 18 Nov 2022 14:30:21 +0300
Message-Id: <20221118113028.145348-1-y.oudjana@protonmail.com>
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

Changes since v4:
 - Remove patches that were applied previously.
 - Define interrupts items for each variant (bringing back maxItems: 1 to the top
   level definition then adding maxItems: 2 under the MT6795 condition causes a
   dt_binding_check error for some reason)
 - Move example changes to the patch they belong to
 - Don't unnecessarily move the allOf block.
 
Yassine Oudjana (7):
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

 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  220 +-
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      |  227 -
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   20 +-
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 8 files changed, 4800 insertions(+), 259 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

-- 
2.38.1

