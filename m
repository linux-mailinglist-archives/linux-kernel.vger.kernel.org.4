Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD656065A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJTQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJTQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:21:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6D1885AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so6186416wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQaH8kLuBy4zyHgqqB9tZsey4wfxoCGASmgyFWFngw=;
        b=thziFT6DNYotuZscweGhf9OW1tixZcOTuo9h57iHpsIH+H26bkct4tE0xoxQwVjt1q
         Lbm1cRWnAIbwV3fFDyE0g/+K5FSCh/r4UFSTYHw+FJJutHO+p7p+9WVfvcIT2Bed3Ha3
         I84z5iOYFroBA7YIh5h1/rREzxBUIbJAdgr1Lx7nlVpqZGlpFzULGA/hpQSoiVs4u0bu
         l0uLPB3GlC+4jEmrGX/LQDTL4RUdV2HVp7/1NDYV0A1kSWdL0Ny+EN0v+Z91NUNvjg7l
         eSll1il8fGyG4hkGh080dyVFauYSp+yERMUWNKN8aKLFL0SZGOk0vNDzVD/eoLfcAv7D
         Yk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLQaH8kLuBy4zyHgqqB9tZsey4wfxoCGASmgyFWFngw=;
        b=kNPQ5uO36LYP6z0mlEUMVh6hY78DVlMvZhTlyK3787cAbdT2TxZipQ7gQ6gCAldOeq
         xL6EopvRfIdeH07M6LvMMttUlgq8UZoyt5HzwO003Qo31ygCSSuQWRm6AV0YAgGqL4bv
         bvO8g2Fbwfa/U2bJhQVNJe12IKvIvRFNczVxVZ8h5IHKcS8QjYfHTFaxzf/fDqqUH+Uf
         gbWcRCziiCLobprWEsop5QwZ+qzmfKtO6peHBMiu02ebd/Muiji9G/Vqp7BRx3hLCvlp
         8xHJKsAnr26eYzvJn8R8ANpjJbQM261tILFfKY5cAaHML+yFrcXbvsA52DQXJdQ7/rtd
         Es1g==
X-Gm-Message-State: ACrzQf2LIVIg/l6qj4IY1PhoCGT0ukFq27SlbOkm1jlgmt9O/usgS8W9
        Yvxdmiw7Z7EB0MfvAtmkJPROOw==
X-Google-Smtp-Source: AMsMyM6fgd2aVPbZkJzGj2cE/qWnqPixgyVyRefkSahrpYdsZfcXFR1KBGOo7OW4gRXCD7Ic7udFfQ==
X-Received: by 2002:a5d:4748:0:b0:22e:32c1:d11e with SMTP id o8-20020a5d4748000000b0022e32c1d11emr9426454wrs.672.1666282869644;
        Thu, 20 Oct 2022 09:21:09 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm208028wms.48.2022.10.20.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:21:09 -0700 (PDT)
Subject: [PATCH v3 0/5] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFx1UWMC/3WNzQqDMBCEX0X23C1xQ6rtqe9ResjPWgOaSBIFEd+9ofeehm/gmzkgc/Kc4dEckH
 jz2cdQQV4asKMOH0bvKgMJolYIhXO5SdVhXpclpoJKSdGbnljKAapkdGY0SQc7Vi2s01TL0ecS0/47
 2ajG6+/eRihwaDujyZET+v40ep+8SXy1cYb3eZ5flmqp1bQAAAA=
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 20 Oct 2022 18:20:44 +0200
Message-Id: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2596; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=wWh5SRjmED4SwyZ9UHZwZdSkaEuoagXKZt6zSsawvDw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUXV05CtA7G4yM+g6ZR3/d2uEFP5CCn8oCzeAiGa9
 eRV4aD6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1F1dAAKCRArRkmdfjHURcP/D/
 9OBECu2FN8NBAfx/FBvllaSMGjLY31S/qRwTAbxYplcM8+L9FUiEYMvQBFCDCcLp3Q+DieQGQ5eRHw
 z5aUwVcTOQepKtCP/25LHSjlx2RhMBnwMZydbNlDuMc+C11h8TimWqIMRFg9Qe3yb0EVsZTj8jdu9y
 F1zXIE5Z8bkbjnIec7vRLmPAIaViDqZumDrCnFQDoFXjXQ2xc1Kw3lLqPYml8MScCGb+82BI7ZAtAO
 gEoAvYSSBKdf1xTX1T2DHm3tCV4tH78v+alYuUttufkB1hpfLl5sTfD8UwKkkMCYbkja0rjFwgvEK9
 hQna405lQPO90Bbux8txtOfnFzQsx/G0NL7AbjD9W6FOFygjBe/tzG/CQoRBR8Fz+BR3j6jpqrMwGr
 tW+N4/Y63DUF2pruZG44NkL6MyE3NBBU9LlqR5ZZiwm5BR0Qg0F1UxE9PF1HWiL8DQG73S+A1afrIW
 tIS3X8Kpjq9WgKyoGa8H8SJNMKoEOQfR5iLCfgjavpMgBtjmP7arIPGsYYhvV/cRbpJ3FZRO5IuCa2
 tZpg8I3iuVeztN+bjVC4KhmaYbvIePgH5FysNsUJm8dKmyo1b5Uk/3lpLx9aWMNtZB36OBAMUASd8w
 dbcLc0pnsxPHu759gG3Rguq7GeYcNS851ZQXnFZMen5y0fouEVZjOiEZVVag==
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

Regards,
Alex

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
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (5):
      dt-bindings: mfd: mt6397: add binding for MT6357
      dt-bindings: input: mtk-pmic-keys: add binding for MT6357 PMIC
      dt-bindings: regulator: Add binding schema for mt6357 regulators
      regulator: add mt6357 regulator
      Input: mtk-pmic-keys: add MT6357 support

 .../bindings/input/mediatek,pmic-keys.yaml         |   1 +
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   1 +
 .../regulator/mediatek,mt6357-regulator.yaml       | 292 +++++++++++++
 drivers/input/keyboard/mtk-pmic-keys.c             |  17 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6357-regulator.c               | 453 +++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h         |  51 +++
 8 files changed, 825 insertions(+)
---
base-commit: 7c69ce28cba3d6ad011f86a5d18dc8c04a921b29
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
