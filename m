Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23F5F56E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJEO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJEO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:57:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8257263
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:57:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1182440wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=1cMed2LuNRuueybzlo85Zm/Ah2wjLjdvNL+1Ufh61Fc=;
        b=vev15dJdQrfLceyaRC7EDjYuZkIRjbV1LTYXQlycQENBTNEpkc6Z1Tw4P0IYaiC267
         WY6yQAPyHifxKGlRrGAM8Nm68V2NUb4mrN2jUmKErMtvx34TgzVLuMeemfVmu7WQrran
         fI0AyUu0JBAMBhZ8XJF+7rDJlvnD5sHYDiwhyokbj+deW8uv1PuMUg0RGMkEdyn42WCj
         MfoDzkmcv6xd8CzAFD07HJ8UqefaBO9rxGEddoYZcvEMcJ57bEiumPyJyhwYw/mw20VY
         VsVNJ2R1tuemYMQRxdZ9Fxiho29ouVMklSENyMxZG255v1oTgLlW8mb7405YFCPftXqQ
         WMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=1cMed2LuNRuueybzlo85Zm/Ah2wjLjdvNL+1Ufh61Fc=;
        b=48+Ek/qAYZ8KvRHshsdF7AAJqYNYbG9mXmMFlYcgIR/BILTHD644LaRTqsI5lQLGB+
         ViWpEOWv/El5pdZWOB09az+iZbddnSEbk6OUAEcCuTtfer8tipGXS+uQD5r87AhLyXMY
         xedKAHlqVfsV6ILEIzsuYTulBDcfXIAvuMekCURVJvPVNysC57oea6wcyiipuxpzKIuX
         q7GYpKi17NFNYWakyHtUDKTjZ1yjjwzAH6vLjT1iTmdm2l56eRzFDU5s4S0B89IB+erh
         6wpcEBbb8SBlZqEZ8h5VtXS3ZDCWmxhUkwtYrNuIMA/DzkDp1K3CKt0NYji+m3sUYAXS
         ZZpA==
X-Gm-Message-State: ACrzQf3MyhbCZJtKYUvmbsv6JS8vLkIHU1nlMJ4rZoKHErFf4q174ELP
        Y0okIST6ZW4YMLusB88UpUt7tg==
X-Google-Smtp-Source: AMsMyM44C554QyEpt58NyqIFPm1+e7tcMo96UGJCZ0SGjBFZTpqvpezjlL0812cltP/g1RLw4Lz/4A==
X-Received: by 2002:a05:600c:4e0f:b0:3b4:88bb:19cb with SMTP id b15-20020a05600c4e0f00b003b488bb19cbmr3567243wmq.195.1664981860089;
        Wed, 05 Oct 2022 07:57:40 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k38-20020a05600c1ca600b003a3170a7af9sm2313758wms.4.2022.10.05.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:57:39 -0700 (PDT)
Subject: [PATCH v2 0/5] Add MediaTek MT6357 PMIC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFCbPWMC/w3LMQ6AIAwAwK+YzjbBEtT4G8CqJAqEqgvx7zLecBWES2CBpatQ+A0SUmygvgN/2L
 gzhrUZSBENShm87lGbCeXJOZUbjdFqdjOx1hu05KwwumKjP1qLz3l+3w8OZoBtZQAAAA==
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Oct 2022 16:57:20 +0200
Message-Id: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=tA0SxppU+jLvYckDfJF2SKYUWGuzQ981wHE1My5XCX4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPZtiEJXk5uMZSeIvSzpAFKou6BAaGk9uX++RG+R2
 E/MauyWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYz2bYgAKCRArRkmdfjHURYkmEA
 CsVE63ekHqx3iQdZSRf6ctCkpEA8P3dhM8h9M8bVeq1rpdLYy6FBkRilsmZM74dSn07LxnW60cu5R3
 d6bIO6FqiITaMGn4dxGiDTR8XoXsBxeFHsG5Gi6bkD6rL9Wue2qThuYE+9S6rosHvr1EbVJr9jnW+8
 tNNZ/QAqFRb6f9wPYPnd3IDCriDm0OLSWyEQ3ifuA1GAOUmFoOcfd4HPeg5ilIcNX1R7Jv2yumJIzW
 4y+ad/cOEZ02KD15b2TjS+43qBO0GlVP0sbQEQP0DR+sGGmxmePy4alohnHGgIrZ2GFq1AajjqhXzb
 Q5l3X26aCUFja0AyHPExKhgBzIAxYd53tZ91Xmn0Q6f4+9CtcKsguZegImefnX/lIGPem31dhQSLc1
 +MlVQgPr9qccJy5gbo7jGbVuZG+ToatHsjzNjUZafpqfiPqUwAUkdHS3rEMQyvAMX46654sPd+vJ0M
 lPNEYGUvICxI3IXnrDyg6kWLRPPUHPqZ3wXcuM8ozcaFxypqTypXHdQ+1Oc3dbNCtyA0tq2ODtuyyA
 rzWs5LiObHYom9j81mmVKQ45o/WKoiBLGjyYvxnJDNajQC1oE8fz2M3KIe2BuIITEuQPKKxTH1doHt
 lsVSrY3YRuAnvz4QAN0WtgM78KJHcNal0eLZDPnzMG6GRGn/zQNAiCMuErWw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../regulator/mediatek,mt6357-regulator.yaml       | 284 ++++++++++++
 drivers/input/keyboard/mtk-pmic-keys.c             |  17 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6357-regulator.c               | 485 +++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h         |  51 +++
 8 files changed, 849 insertions(+)
---
base-commit: 7c69ce28cba3d6ad011f86a5d18dc8c04a921b29
change-id: 20221005-mt6357-support-55308b82e33f

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
