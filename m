Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A3676CDF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAVM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjAVM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:26:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638A1BD2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:26:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6675034wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbzwjLdm0DVC3q/9d88DJk7e6Au7jTyV/S/NQHA4YvQ=;
        b=nPDWmeaoM4qH1sAhGzDTP6Lk7+5v9b1fYhu09zSChveOZxrSgSkXYGzmmFdb14SlMR
         orOV6l+4/la9UfYkwAlXtYsnViXr7cuRWFGzu+pu78RWbMA0W3cJYgfqFxJLe39MTST0
         04p1hu5XfGHAdjXw8D33ckO9N9jG7J/50v11ONTHGYBenWKKcjCqpNA02BQoYTuOtRT6
         DyKTnyoJ8RT1UanFeTWYowKjzbh9Yxa8YcKJXxxaIub8L9QS3nlf14TwVMKR4SsYDjEc
         c2/lB/fGmZ5EjdxHFtB4vQ5/T72bJReExynR9zqRXnQkcHsPWJNtbMF+jRqPsPZCV1t3
         HEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbzwjLdm0DVC3q/9d88DJk7e6Au7jTyV/S/NQHA4YvQ=;
        b=WqgksrfF54FT4qdjiDr7nNWN4wjlDO+GKMd7EdueyqKpWp65gMDBaJ2LEEYGNj+nIz
         JcnBVCGNNIhJKanZqLHMj2fv464KZWmxL9PdBvXC0oO8jDwNiMPAWSo5ZPPJQ13Ad5Em
         YpFxd2yMXl2XYfvtwCa4LSghbKxcQbWu1hC+r1K5yOEFUB428b+d11/gRf8Ss7bO/i5o
         FlQJEGHOdt9lD1m/9FX28eNIbPXToQErS7V0FiQpPawNgRPwdmjBJ9bx+qr1LOmEscsx
         tyd3fqrmTM4m4tb6J84pgUlg8RKOJbeZ3yTMcvZ4navaINDG5BEC9T+VhE4y0Q2vW6bX
         ev0A==
X-Gm-Message-State: AFqh2kpeDdcb/g/roFvbfyFMSh4tnlP8zBbS0ocWEz58afhMcHhDEffn
        2kF1dKid7gBDXml7rbYlnKpNxw==
X-Google-Smtp-Source: AMrXdXu/6PQg++gYWXKyUi6cdUY1gDvsqc99mVb/kYG1nBNvmI6JVYY7oL9PwPDxTXg+37znE49t3g==
X-Received: by 2002:a05:600c:4d98:b0:3d3:5c7d:a5f3 with SMTP id v24-20020a05600c4d9800b003d35c7da5f3mr28557197wmp.37.1674390369527;
        Sun, 22 Jan 2023 04:26:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003d9aa76dc6asm10663808wmq.0.2023.01.22.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 04:26:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] samsung: soc for v6.3
Date:   Sun, 22 Jan 2023 13:26:04 +0100
Message-Id: <20230122122605.30720-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Driver-related binding changes and one maintainer's entry. I called it a
"drivers" update but it is really rather generic SoC stuff.

Best regards,
Krzysztof


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.3

for you to fetch changes up to 5e487164afbcd917225fb701e8956f388f43b601:

  MAINTAINERS: arm64: tesla: correct pattern for directory (2023-01-15 12:17:44 +0100)

----------------------------------------------------------------
Samsung SoC bindings changes for v6.3

1. System Controller: use dedicated/specific compatibles to identify
   different controllers with different register layout (Exynos, Tesla
   FSD). Extend the bindings with missing clocks.
2. Correct maintainers entry for Tesla FSD DTS.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      dt-bindings: soc: samsung: exynos-sysreg: split from syscon
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG compatibles to Exynos5433
      dt-bindings: soc: samsung: exynos-sysreg: add clocks for Exynos850
      dt-bindings: soc: samsung: exynos-sysreg: correct indentation for deprecated
      MAINTAINERS: arm64: tesla: correct pattern for directory

Sriranjani P (3):
      dt-bindings: soc: samsung: exynos-sysreg: Add tesla FSD sysreg compatibles
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG compatibles to Exynos850
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG compatibles to Exynosautov9

 Documentation/devicetree/bindings/mfd/syscon.yaml  |  6 --
 .../soc/samsung/samsung,exynos-sysreg.yaml         | 87 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 3 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
