Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61867E9E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjA0Ppr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjA0Ppe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:45:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7787364
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so4875498wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7O3B7/vLpCaO2LpJCG06vJuxF+jy+nD802aTy7BRyg=;
        b=jN0fna7SWiAQX6BRCXoOI62/7XwgmaqMcj4KJg01mPjQPYaoq4EmXBzeOQc3sbqEvE
         80SoBCSY1Cd7ydMv3JK3yEnvhruRKxBQ244HGbXnHEyPVh+OTkook+3orQAZL4zIjuv2
         2A8iUmR8VcPklgQVIsATo5TIOM7sKayDvxGajvlJuXE2arSuoUfZSqnV+zepWzvRTICZ
         DYR27G2BFypdcK8+KDTJN9G+CjA1tZm/5pR6NmpI7tgxjyBXsWKHjI4gnPZp3Jnn+fGF
         3DQQfjiT3Ct3Kohs6N7BU1aNulx91aQSwFdFid/xtow99yOk1kO7dkaqQS/z4GFxC9sr
         L7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7O3B7/vLpCaO2LpJCG06vJuxF+jy+nD802aTy7BRyg=;
        b=WfNtTtfmIo8XVomLoiM2B7SgG4FMm2+fFXrHNSZm48tQF8Dc3bFPNhI6C56R5TV6GT
         XFrerh8iGil2hQkPtTYeGRZnj/XHrCDJmIEmZmUQ5atuATyYaQMhnfCtRK62DafOpOOF
         ztG3nqwyWGA6IWjpjJwGaRUiO3i3+oUKPgPL6pQcTjjD38SEwQnBhHvKqB7wYadoUdK6
         nuhuZtVIqpytbBuSt9W58fw+AFeQsolA/0tQOXmsGJig5VQ07bb97sQqNpy/iS4ucnoj
         mTVCV52fUGTLBGzStkoveL0pVrpQQfjCnRigkEKdHpnUZIpo9qvZis1mzu/3wi3e81ui
         oMZQ==
X-Gm-Message-State: AO0yUKXAScvfToX/unlGN1JxTF6UgTeQhO0NVlWSp6bcZAjbR1YYcNML
        j1lFkjgew6Mn7pP0wOBcMFVFjA==
X-Google-Smtp-Source: AK7set/1N8OKgU6tc4kZzvVACzpKa42p7Gmqom6ltJ7wxHRsG05T3LCbFnCz5HHJ7SEML+YBFO4jtw==
X-Received: by 2002:a5d:45c8:0:b0:2bf:b11d:91b with SMTP id b8-20020a5d45c8000000b002bfb11d091bmr12646769wrs.44.1674834314420;
        Fri, 27 Jan 2023 07:45:14 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:13 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v9 0/5] thermal: mediatek: Add support for MT8365 SoC
Date:   Fri, 27 Jan 2023 16:44:42 +0100
Message-Id: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrx02MC/43NwQrCMAwG4FcZPVvpWrpmnnwP8dCsqStsnbQ6E
 Nm7GzyKoKfwJ/xfnqJSSVTFoXmKQmuqackc+l0jhtHnC8kUOAuttG5VC/J+lclYJW8jldlPEkvK
 F176YKALxinbRcFt9JX46PMwcj/fp4mXY6q3pTze39aOx+k3vHZSyQEc9tFZaxUe0T+mhIX2wzK
 LM7Or+5NyTBFGBTFqCuEbBX9SwJQ2BBFRARj3QW3b9gIa15CHXAEAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=1258;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=6laNfaEfbdufAfkWmKX8igRePO4WwHhwM194Js7Oc24=;
 b=VrYSZmEuZHHpu/DIvUiw1+OoJp9kJ0ns2YRybFA00Pgpx5duuBgxFl5MKSq8AKPJxmqHJe/Nw97f
 ngWcKRl6BKE4TxP5RwaNXrh7pow6KtPPdB8dQ6Jsv+KWYo0F6an1
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds thermal support for MT8365 SoC.

MT8365 has 4 thermal sensors, one for CPUs and the rest for debug/dev
purposes. The CPU thermal zone uses passive cooling device with
CPU{0..3}.

Changes in v9:
- Use delay between bank init and the thermal zone device register.
- Link to v8: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (2):
      thermal: mediatek: add callback for raw to mcelsius conversion
      thermal: mediatek: add delay after thermal banks initialization

Fabien Parent (2):
      dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
      thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
      thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 117 +++++++++++++++++----
 2 files changed, 96 insertions(+), 22 deletions(-)
---
base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
change-id: 20221018-up-i350-thermal-bringup-ad386d37056f

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
