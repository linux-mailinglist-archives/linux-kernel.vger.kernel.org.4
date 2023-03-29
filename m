Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD146CD552
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjC2IzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC2Iy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:54:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1E35B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m2so14845663wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzdO+lxAfOJTORFrou5SxAjDVdCRcCpSAaKg+Ly9+Yo=;
        b=4sW4i7rA5XGJYWXbRj7E9hHI/H8WM4pXoWaXpU/eM7Y6mgfqcI722Nvfi0AtZr654k
         Pf2WGcgNZXvzbYJ2Jf3ecdD1GMyApi+9xQeRVG993cYY891D1SS+UCHvfaTQauRsEjtG
         a7/UgoT92z2OdSbT9YrU1bTuD3i5DOZzn9CwY0V3PjMe1nAsGQbvNbDYu5ePqQYCSVtd
         I/uM2mEn7ZvBLKTQdm0lXx9NOj6W8JpKz6jMqkjljdXmRhh84m28diVuwRoEYGb2igUe
         OZ8mrFZN0uHCTY5CQaLKZTHgbE2ejaRty8T7OBEe8fG1LKeYLjqXKsMV+slOMPMbkNau
         aiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzdO+lxAfOJTORFrou5SxAjDVdCRcCpSAaKg+Ly9+Yo=;
        b=xhUXDR3PmPs+T5GWvd3nHZy1FpmYDX9TPlOjyEUfxU0vLO7CBempHmpWhs9fPGDuFw
         9zYQ0JPbFyTPDtgtHzOoiwoTXcYREXJ21e3CuMCDvoozpXFA3KnM383PTNMDjNOimPnq
         0kdbBp6IcX8/e+ELi8SGuouJntmEYBSsXAH56Lu2RVbu5vO3PYju4nj0VD+KQvW8pXhB
         5kJ/2Wyr+iqfsI/0p9vnuMu5bHJH8/y7GLd+PPDJRF8kUKydETu4KN9IOqCmFwpa6dP2
         megTSib5LAREk7zfT15unYTURdIC1mm/5OZ2VQItVfmB5EqYAgz0x96u/o9PhSE58zSK
         Xgew==
X-Gm-Message-State: AAQBX9eFA4w3axHRrZZVvKJVT3wOnkKKs7JevDqIRSZJK0kL3Wu7QjVF
        KCTP0SC5jTfJPvoP3XPrHvjj+Q==
X-Google-Smtp-Source: AKy350YBJmqeUhUjQyfCAqVgv5XtFtzTflowmykdXvxURkGr/ltJSCccPuaqoPcUxGCCy4NGiuPXBQ==
X-Received: by 2002:a5d:5229:0:b0:2c7:1c08:121c with SMTP id i9-20020a5d5229000000b002c71c08121cmr15195510wra.61.1680080093551;
        Wed, 29 Mar 2023 01:54:53 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:54:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
Date:   Wed, 29 Mar 2023 10:54:21 +0200
Message-Id: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL38I2QC/4XNTQrCMBAF4KuUrI1MEtuoK+8hLvIz2mBNStIGS
 undHVy60NXwHrxvVlYwByzs3KwsYw0lpEhB7RrmehMfyIOnzCRIBRIUx/rkNpnseZnHMeWJ+9Z
 qc1Qn9Noy2llTkNtsoutpGedhoLIPZUp5+fypgs71F1kFBw4dKKmhPQjfXqxZhmAz7l16sRuBV
 f5FJCEdOu28FeDc/QvZtu0N/ksqGv8AAAA=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=g3X31va/VDwpY2eFLvZJUQe6Yd+D9Pt4ItUQKxlH3oA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zbKYL5HQCSxV8z4D6VVyX8VhpZc/3jth3XoWuF
 qJn1N86JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP82wAKCRArRkmdfjHURScIEA
 CvYNYx5SNpOC5jRj/ilI2B3OdPkasa3RaWWW303TI7JDD0gGDMXX+bHpcCYqVzFg7FlcnIcGBjRs7E
 Jr6x1jv3WkPl5+mUAELpby4F5zh7pegFOCfcrJ9HtcHX/cdLEiRJ2umjXGlu5VQVuv3ZmQEOcV3WJh
 tfPh92mwf0eLS8lfXw7tOkky3kpD387xb1JgnN9gsUCDBsjUIU7MRcJx7HHQcjiuUrrytSt5klBcwP
 9RZ71pZfTDDD7VRiM9VxlvU3th766j4bA+UqINLHM2IohbGpCr6NbhVrD7JdqJF5gJ9eOP4LshWjqE
 0+vNMsXOpmmcpugJkEQ7zuL247NHfgZU29xmUlpq7KtYjW2YXseIG7G+p5SpKY++45RS4GdgJMDIl7
 E0wUMxMkzJ5BgIea5tQTfSJ85Ooozh+mLb1d1svXE0aR55EV7xMvr/RdL/c89cCJe+F1btaWHk3rUk
 4Qdgrma2LVv/C+4vvTt6csqs2Zl6YN10PeMMsEpPTHlfZV+zcyQ40vAvYMBS+SPPoN5Tc9rk9rRglf
 Vrx1rY1XqtGk8xcwjoVxdp+k09y3RfKcUJuouOkpVUefkghZJrMM1r5dkDP8irJkJB04SiQB9CkCH7
 ESqzmMQ6PBazV6JhB2Ilp9LNDGhUWQvC6MYaVdy3ipJxNsnZzVPL/SultYNA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits are based on the Fabien Parent <fparent@baylibre.com> work.

The purpose of this series is to add the following HWs / IPs support for
the mt8365-evk board:
- Watchdog
- Power Management Integrated Circuit "PMIC" wrapper
  - MT6357 PMIC
- MultiMediaCard "MMC" & Secure Digital "SD" controller
- USB controller
- Ethernet MAC controller

Add CPU Freq & IDLE support for this board.

This series depends to another one which add support for MT8365 SoC and
EVK board [1].

Regards,
Alex

[1]: https://lore.kernel.org/all/20230125143503.1015424-1-bero@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v3:
- Add trailers and simply resend.
- Link to v2: https://lore.kernel.org/r/20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com

---
Alexandre Bailon (1):
      arm64: dts: mediatek: Increase the size BL31 reserved memory

Alexandre Mergnat (12):
      dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
      dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength property
      arm64: dts: mediatek: add watchdog support for mt8365 SoC
      arm64: dts: mediatek: add pwrap support to mt8365 SoC
      arm64: dts: mediatek: add mt6357 PMIC support for  mt8365-evk
      arm64: dts: mediatek: add mmc support for mt8365 SoC
      arm64: dts: mediatek: add mmc support for mt8365-evk
      arm64: dts: mediatek: add usb controller support for mt8365-evk
      arm64: dts: mediatek: add ethernet support for mt8365 SoC
      arm64: dts: mediatek: add ethernet support for mt8365-evk
      arm64: dts: mediatek: add OPP support for mt8365 SoC
      arm64: dts: mediatek: add cpufreq support for mt8365-evk

Amjad Ouled-Ameur (2):
      arm64: dts: mediatek: fix systimer properties
      arm64: dts: mediatek: Add CPU Idle support

Fabien Parent (2):
      arm64: dts: mediatek: add mt6357 device-tree
      arm64: dts: mediatek: set vmc regulator as always on

 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  |   3 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt6357.dtsi           | 282 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 254 ++++++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 196 +++++++++++++-
 5 files changed, 731 insertions(+), 5 deletions(-)
---
base-commit: 555b3a55823ec063129de4403899203febb58788
change-id: 20230203-evk-board-support-d5b7a839ed7b

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

