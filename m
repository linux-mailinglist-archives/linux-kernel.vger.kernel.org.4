Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61563B7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiK2CeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiK2CeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:34:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BE29CB5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m19so16736625edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2wIPJTHkD+bylj39gTMFm3DTXuPW9bL6vkGIzsV8aw=;
        b=kZurQYlwJIRzTT+7zqhkAVIxZypR4Ym0x21fe9bnwCAsqwvJR3TgpGxd88mHYJPm60
         LX3Zp6nshIqrm/lDU+Va90uCJdbBfnFx54Pa1g98o7iTTEH/uIS7obpjSO+yHcX+15q7
         jtfPifPzJKnKO6y1bWCOOeVy05p0Lu1/MRZ6+n6HSI3Ak1OSE5/P1MbgdRr8cP+b92QP
         coG/3EtVGGfQ9NRoOUWInj0l71Yrm5wOABzV725Ia6FZQZjeAeNlVjIZjteS9eAogSyA
         11LA1BueA/e0g3FQ6uoXH7ehNiaD42FNk/FB1CO/tGlEeiyz1+fbvFgyOSSvvpuW+F6U
         sPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2wIPJTHkD+bylj39gTMFm3DTXuPW9bL6vkGIzsV8aw=;
        b=GQQFF8ElPibABcGvtJEgavo+Op7YUQJ4NrrfafgK4tqRRi138lpuscbKigCgF9Qm2Z
         ww3oyldjSsDAU6r32O6pJt0CPzu/pM0XfM3ewOsy97IwKrWjrkIvnr+DjFL8PyCN/dQ9
         kBE9DGE8MPLmFMfAyQdKOp1N275YX1w0734nTvEA63w3VXbjiaeZP+Hui+5ODgMbS7cT
         nPZYu4zpjZDenrOAZ1TbLnY5OjoDqdkmG3Q693epDMP9ZOTRH8P2cZSPy2ak6ZtpN6km
         VjSOYL0pCQn1ubzyHGVowCvE1mqgeVNu3dmQz5filaOKZy2K5/Wk3dGFa5lMuz/choxV
         XIaQ==
X-Gm-Message-State: ANoB5pmGQAs342MXyY6TRGa+Sao/EcTsUsaFPxph5rjwtyOVUNW3wB4n
        ZqMz2AcIfYJ6HrVCXxAOeickpg==
X-Google-Smtp-Source: AA0mqf4bZWNrCN097oenITVW9XWxiWgQvZ3xepStot6lQY8viV0QFaDmX5vyZpw8BbxpzDBGEe+PQw==
X-Received: by 2002:a05:6402:4008:b0:458:dd63:e339 with SMTP id d8-20020a056402400800b00458dd63e339mr31534833eda.81.1669689243478;
        Mon, 28 Nov 2022 18:34:03 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm5733817eds.8.2022.11.28.18.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 18:34:03 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH v3 0/7] Remove the pins-are-numbered DT property
Date:   Tue, 29 Nov 2022 03:33:54 +0100
Message-Id: <20221129023401.278780-1-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of my MT8365 support patchset
(https://lore.kernel.org/linux-mediatek/20221117210356.3178578-1-bero@baylibre.com/),
the issue of the "pins-are-numbered" DeviceTree property has come up.

This property is unique to Mediatek MT65xx and STM32 pinctrls, and
doesn't seem to serve any purpose (both the Mediatek and STM32 drivers
simply refuse to deal with a device unless pins-are-numbered is set to
true).

There is no other use of this property in the kernel or in other projects
using DeviceTrees (checked u-boot and FreeBSD -- in both of those, the
flag is present in Mediatek and STM devicetrees, but not used anywhere).

There is also no known use in userspace (in fact, a userland application
relying on the property would be broken because it would get true on
any Mediatek or STM chipset and false on all others, even though other
chipsets use numbered pins).

This patchset removes all uses of pins-are-numbered and marks the
property as deprecated.

v3:
  - No functional changes; add recent Reviewed-Bys and Acked-Bys,
    add linux-gpio to Cc

v2:
  - Deprecate the property instead of removing it completely from
    schemas
  - squash some related commits


Bernhard Rosenkränzer (7):
  pinctrl: mediatek: common: Remove check for pins-are-numbered
  pinctrl: stm32: Remove check for pins-are-numbered
  dt-bindings: pinctrl: mediatek,mt65xx: Deprecate pins-are-numbered
  dt-bindings: pinctrl: st,stm32: Deprecate pins-are-numbered
  arm64: dts: mediatek: Remove pins-are-numbered property
  ARM: dts: mediatek: Remove pins-are-numbered property
  ARM: dts: stm32: Remove the pins-are-numbered property

 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml          | 5 ++---
 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml      | 7 +++----
 arch/arm/boot/dts/mt2701.dtsi                              | 1 -
 arch/arm/boot/dts/mt7623.dtsi                              | 1 -
 arch/arm/boot/dts/mt8135.dtsi                              | 1 -
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi                     | 1 -
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi                     | 1 -
 arch/arm/boot/dts/stm32h743.dtsi                           | 1 -
 arch/arm/boot/dts/stm32mp131.dtsi                          | 1 -
 arch/arm/boot/dts/stm32mp151.dtsi                          | 2 --
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                  | 1 -
 arch/arm64/boot/dts/mediatek/mt8167.dtsi                   | 1 -
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi               | 1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                   | 1 -
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                   | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c              | 6 ------
 drivers/pinctrl/stm32/pinctrl-stm32.c                      | 5 -----
 17 files changed, 5 insertions(+), 32 deletions(-)

-- 
2.38.1

