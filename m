Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7C68C1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBFPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBFPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:38:04 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B92B60E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:36:56 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id a2so10485750wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pmo77UKoMzXJKQUoQ1g2vDSwLCWdCS5ldkpiJoejADo=;
        b=EmRe6OclOanTEHjba9UzNYrndAHNwQl+yKbKfLh/5PMne20zgrSKN1FV49IGkc5iz6
         qR2HJl8y5sGzInCMlnrLmSn6wxJTfbZImIPB7qhNUxD0iJJmSKruPrjjpOBAwqUa+HtM
         YMix0G2KJDeK8vu/BIOnWLeNUcBDMW5ZXiczIDR3hOOknTXjG26VoLur/VfHALQlba9G
         kKzcVKRb90kC2bM328TYUdLGkaVD62IPETxEjSa8RwhdDf6pOFSMiY7bLpCH9RpMP/Cr
         w4GySQt+OhjaEHNgUFmiW6DDSGGxgXLTleAsZ7K7N6vkKErW8E7qmBCftHw20hc9umjL
         ZtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pmo77UKoMzXJKQUoQ1g2vDSwLCWdCS5ldkpiJoejADo=;
        b=5PlxeansSwr7TAqDTEjlgOpPwxX5neGqEgcoxMO3+upGRFRnGg+X0TYyEJFb82LzU+
         S/kT1hy8h7GeIYzM7fG+EDq9KYmiT3VsTNORjvFdzD2TjwO6WOTZymh64KTsbvrHhALe
         tojXKtm6MmlqNN1lFkn1MhYZLp4usc0EQ5d07gXjsSwWzLKjco/mnPd+31f00cizZsSr
         2uz5yggrK7OOFJRitnaZvDv+kC6jDF9IjIWviGcHSkhY9ABYV1SDGSJXmGvpsVO8JV4n
         TK53KdBJyVvS+fwI6XHR85r+1wUfRPHg7Lc7UcUt6jRKFxADlmh+vG/ttfcRLtoCIpGz
         /c1g==
X-Gm-Message-State: AO0yUKXYt0YDtF8FFZ3q8lQFGrPCSPSHSJKdNrZtH0TetaoHKlO5LOSE
        XkmX2+G6TrhDnK0B/cQ3Kn41LQ==
X-Google-Smtp-Source: AK7set8VgB8x+u2fKo/xUB5QQ/nIAphdD6XyVN1SVaEXvN+z54+kI6GdvhBPc7hl+Iv0AoY2gWQUMQ==
X-Received: by 2002:a05:6000:14c:b0:2c3:dceb:4743 with SMTP id r12-20020a056000014c00b002c3dceb4743mr62208wrx.57.1675697697416;
        Mon, 06 Feb 2023 07:34:57 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e12-20020a5d500c000000b002c3ea9655easm2197317wrt.108.2023.02.06.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:34:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] ASoC: dt-bindings: meson: covert axg audio to schema
Date:   Mon,  6 Feb 2023 16:34:42 +0100
Message-Id: <20230206153449.596326-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert AXG audio dt-binding documentation to schema

Changes since v1:
* Drop 2 patches applied with v1
* Drop node name patterns
* Fix examples indentation
* Yaml fixups requested by Krzysztof

Jerome Brunet (7):
  ASoC: dt-bindings: meson: convert axg tdm interface to schema
  ASoC: dt-bindings: meson: convert axg tdm formatters to schema
  ASoC: dt-bindings: meson: convert axg pdm to schema
  ASoC: dt-bindings: meson: convert axg fifo to schema
  ASoC: dt-bindings: meson: convert axg spdif input to schema
  ASoC: dt-bindings: meson: convert axg spdif output to schema
  ASoC: dt-bindings: meson: convert axg sound card control to schema

 .../bindings/sound/amlogic,axg-fifo.txt       |  34 ----
 .../bindings/sound/amlogic,axg-fifo.yaml      | 112 +++++++++++
 .../bindings/sound/amlogic,axg-pdm.txt        |  29 ---
 .../bindings/sound/amlogic,axg-pdm.yaml       |  82 ++++++++
 .../bindings/sound/amlogic,axg-sound-card.txt | 124 ------------
 .../sound/amlogic,axg-sound-card.yaml         | 183 ++++++++++++++++++
 .../bindings/sound/amlogic,axg-spdifin.txt    |  27 ---
 .../bindings/sound/amlogic,axg-spdifin.yaml   |  86 ++++++++
 .../bindings/sound/amlogic,axg-spdifout.txt   |  25 ---
 .../bindings/sound/amlogic,axg-spdifout.yaml  |  79 ++++++++
 .../sound/amlogic,axg-tdm-formatters.txt      |  36 ----
 .../sound/amlogic,axg-tdm-formatters.yaml     |  88 +++++++++
 .../bindings/sound/amlogic,axg-tdm-iface.txt  |  22 ---
 .../bindings/sound/amlogic,axg-tdm-iface.yaml |  55 ++++++
 14 files changed, 685 insertions(+), 297 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml

-- 
2.39.0

