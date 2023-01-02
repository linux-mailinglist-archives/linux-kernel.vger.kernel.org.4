Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793965B4A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjABQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjABQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14924D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d4so18688247wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=yjXxn0Gm+72C4uouOQHc+bGyejQ/xXoLI7xGm1lh+LU=;
        b=DBhyN0p+sU1au65Ro4tSm2WuyZt+j+NaZhAKpfNLICLjbM5H/QpGwLLOMeHbFxv29y
         H2FlN7VBQzD1hnwe5cLzuwONwYvpbzHQqAdMp/KBaOPdguNJeXfk0TaTvVhTLTPa4/fq
         MBVDWtDFs+WXwOI/D7b0Z6vx9YZk3z4OwzGK65RdYmDJ9mKCvmqhTvbWqWR6xH7oVfmN
         FJqXLe5bKSGnGQY7QINUHY6fmvyNeiJi3V0yVoCQLstULLKPmi+VCgezoU96MP6JMuxZ
         R6ES20SFZjBXVNEdmzVvST7eUycLV2N4JRTmKRW4kfrKckVDWMqkNJpal7R7+tXgTo5T
         H7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjXxn0Gm+72C4uouOQHc+bGyejQ/xXoLI7xGm1lh+LU=;
        b=dask/PqYdGkgRXATZ5nkm9OGQe0AIAYZ0AugIJ6KVy+Fky6pSKKlaEn2l5nSLWfoXR
         QLYgb410a/Wn04Od6uiJ1P+/vohnH9a15hx6BK4efqy1JTf43dCPA7IezWpO7lwt69M8
         48psSp2NFAwEA1G34epjKjxrArmxXrzjh/txQDl7K/ix2I3h+OMJ6Qhv9hMhlhmH8rso
         87iAbgJtnGhESCUK5bdyvWml2Gf+FRShNVFxOxUZaD5qHlHN/SrmDuMod582zLN0OKn5
         rYjPulXIZuHHH3bF8NTCOpRo06fbn2TnnAhorjTbBJdSEc941cvyrYPqGgXaDr3F1ABj
         OZ7w==
X-Gm-Message-State: AFqh2kqsSaS0aTyj44Ew6+WgOS2vKdKgXdr9rk7IKEK08xW9amHuljYC
        OMc3negUFOXTyLCmguwut5tsag==
X-Google-Smtp-Source: AMrXdXt3Pchs9Wngt3PAgATIOjyl4UrTNzJyUg65G9w7v3CDUOM+cQRnPVTI6yOPy8Rw40P8egVifQ==
X-Received: by 2002:adf:fc4a:0:b0:27e:315e:d279 with SMTP id e10-20020adffc4a000000b0027e315ed279mr16343571wrs.32.1672675582751;
        Mon, 02 Jan 2023 08:06:22 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm11868020wrs.33.2023.01.02.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:06:22 -0800 (PST)
Subject: [PATCH v8 0/6] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAOkAs2MC/33QwWrDMAwA0F8pPs/DkSPL2Wn/MXawYmcxpEmx00Ap+fdpO44sJyEJPSE9VU0lp6
 reLk9V0pZrXmZJ/MtF9WOYv5LOUXIFBqAxBvV1dRZJ1/vttpRVI1rj2UOydlAyxKEmzSXM/Shj832a
 pDjmui7l8btkAwkf/3obaKOHhjhAhGhC987hMWUu6bVfrupTtM2eC1YESoYj9bZBhgOhPRdaETACM/
 rkjKcDAc8FFMFLK3aIMdp4ILhzwYnQDug7QsdpCAcCnQv0IxDJBQ04av9+ct/3bwTziJL+AQAA
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 02 Jan 2023 17:06:01 +0100
Message-Id: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6715; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=y+wz6c4W9HrqoN7G2jonBGgIm26tMVUUbm/Y5LjIEto=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjswD8T/0NFNmSdPBmNpUaUOCEMfw/f8dvxPpEtDAY
 8btKQJeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY7MA/AAKCRArRkmdfjHURd15D/
 9nQyB3IXZ8ob1pZ4iFKmdX2Ni08WDhAN66H7D5b6P/dEaDy8MrzhS+PKlh4yC3ofgAzpEQOn5GP+ZJ
 6CanCOubi0s4dnuueTlzQLCjjGWg2UwEc1zfLsZ6e495w4Z2OS8UZOfjYZvzhU5lyvrjVByk9eQ65n
 JXItaBpLqtTI9SVV053Ej2sNEoqTiHBKv63Ae0huQeGq9M+GamEtsYuy68ODlOjixJYyj3M9n4VtNy
 STPvi61fWp9vLjRkliWxuaJ7bMjSHrLSZZQw8nuPA/U6igBlO2EmR8l0SKdAc8er+LMSFP8IIyrkHG
 e19KCkiMpbFXBHPIozh7e8+glnpdLJX6KX83stIoi9/48Yl6HKmTVInOh7R8zxo0I/xoe/GeDnOaAJ
 i2/BdY9RDAMR5PkllXuTeIleZB7M6+v5dC8yf3ABj9iPEowKtyqaEyK7lhCu607N++fzN1OEaPfLLC
 iT8Xfp3Fp+IKDBzmLAgISeUYssrtgwmTBwNB12oSCfCEZ7bIqdylPsCadwlMIKa8dD1fEkaMFUZkrn
 H7nuZeaWX4pfSpAfyn6jjUzODNz0fHbBBOMcqad/90B5i1JismpGzT5yoSa+H1IBOWxwZWUz6TyT8C
 C87sbBxBKXuFhFxBITAjLbH28DCf1eAqZXLbdb/z/smgoSUErI50CDItGQDQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch series adds MFD, PMIC keys, and regulator support for MT6357.
MT6357 is a MediaTek PMIC very similar to MT6358.

Currently, MTK bindings related to the PMICs are not converted yet (still .txt):

soc/mediatek/pwrap.txt (all PMIC parent)
      |
      V
mfd/mt6397.txt (support lot of mt63XX PMIC)
      +---------------+----------------+---...
      V               V                V
regulator/...      rtc/...          codec/...

1) Convert pwrap to yaml is ok.

2) For the PMIC bindings, there are two option:
- Convert mt6397.txt to mediatek,mt6397.yaml and continue to support multiple
  PMIC with only one file. IMO, the file will be hard to read because
  the supported features aren't the same for each PMIC.

- Make a binding file for each PMIC ref:
    - mfd/mediatek,mt6357.yaml
    - mfd/mediatek,mt6358.yaml
    - ...

3) All PMIC daughter bindings (regulator, rtc, codec, led, ...) aren't fully
converted yet. Refering to the two PMIC convertion options above:
- To be clean, all daughter bindings should be converted. This is hard because
  a good understanding of each device is requiered to write efficient bindings.
- Only daughter bindings supported by the added PMIC should be converted, that
  allows to do the task conversion step by step.

In the V4 of this serie, I chose the second option.

Regards,
Alex

Changes in v8:
- Remove the 2 applied patches (v6.2-rc1) from the serie.
    - regulator: dt-bindings: Add binding schema for mt6357 regulators
    - regulator: add mt6357 regulator
- Rebase from v6.2-tmp/soc branch, got from kernel/git/matthias.bgg/linux.git
- Link to v7: https://lore.kernel.org/r/20221005-mt6357-support-v7-0-477e60126749@baylibre.com

Changes in v7:
- Drop mt6397 RTC schema conversion.
- Integrate mt6357 RTC schema directly in mediatek,mt6357.yaml.
- Fix unit address in mediatek,pwrap.yaml.
- Link to v6: https://lore.kernel.org/r/20221005-mt6357-support-v6-0-4f589756befa@baylibre.com

Changes in v6:
- Fix typo in documentations.
- Remove mediatek,mt6397-rtc.yaml example.
- Align pwrap convertion with the original .txt file.
- Remove unecessary include in the mt6357-regulator driver.
- Link to v5: https://lore.kernel.org/r/20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com

Changes in v5:
- Add missing maintainers
- Improve RTC binding by adding rtc.yaml ref and start-year property
- Split the txt->yaml conversion in one commit and the addition of the
  new mt6357-rtc compatible in another commit.
- Improve PWRAP binding:
  - clocks and clock-name have been refactored.
  - reset-names is now properly dependent to resets.
  - additionalProperties change from true to false.
  - change example for a most recent and popular SoC.
  - "allOf" part has been simplified.
- Pass binding tests with the updated tools. Here the command:
  "make DT_CHECKER_FLAGS=-m dt_binding_check"
- Link to v4: https://lore.kernel.org/r/20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com

Changes in v4:
- "dt-bindings: mfd: mt6397: add binding for MT6357" has been applied
  by Lee Jones
- All fixed regulator are now refering to fixed-regulator.yaml
- vfe28 and vcamio18 regulators have been added
- pwrap binding has been converted and mt8365 support has been added
- mt6357 PMIC binding has been created
- mt6397 RTC binding has been converted and mt6357 support has been added
- Link to v3: https://lore.kernel.org/r/20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com

Changes in v3:
- To be consistent with regulator/driver.h and helper.c, shift
  variables have been removed and the mask values have been directly shifted.
- Remove index tables and rework volt tables to use set/get helper functions.
- Add comment to structure and function.
- Fix Fabien Parent mail address.
- Link to v2: https://lore.kernel.org/r/20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com

Changes in v2:
- Rebase
- Fix typo
- Remove dependencies with https://lore.kernel.org/all/20220415153629.1817202-1-fparent@baylibre.com/
  which is no longer relevant.

Previous versions:
v1 - https://lore.kernel.org/all/20220531124959.202787-1-fparent@baylibre.com/

To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen Zhong <chen.zhong@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Fabien Parent <fabien.parent@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sean Wang <sean.wang@mediatek.com>
To: Pavel Machek <pavel@ucw.cz>
To: Tianping Fang <tianping.fang@mediatek.com>
To: Flora Fu <flora.fu@mediatek.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-rtc@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Alexandre Mergnat (4):
      dt-bindings: soc: mediatek: convert pwrap documentation
      dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
      arm64: dts: mt6358: change node names
      arm64: dts: mt8173: change node name

Fabien Parent (2):
      dt-bindings: input: mtk-pmic-keys: add binding for MT6357 PMIC
      Input: mtk-pmic-keys: add MT6357 support

 .../bindings/input/mediatek,pmic-keys.yaml         |   1 +
 .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 111 ++++++++++++++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++++++++++++++++
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |   6 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   2 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  17 +++
 10 files changed, 283 insertions(+), 82 deletions(-)
---
base-commit: e32caddfc737a96f6593754c2a08be6b8c1e0cec
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
