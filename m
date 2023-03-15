Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E86BAEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCOLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjCOLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:07:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440D888EEB;
        Wed, 15 Mar 2023 04:07:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u5so19585070plq.7;
        Wed, 15 Mar 2023 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAqG1Kr2Uolyjf/GxkqX22B3ljt5De835XrdxJINeQY=;
        b=CZnaHbV27A42TrjHQe+T4hgAkd3u0QBLJNrHYmNxQh/vgyC8J2YcmmNSWutL9J4Ceh
         jFvMJLrlcj98Gmxelxu78rQJ+W9C5z/G8aNNp4wA3M5345xKwGE++1U12GrwffHbss//
         twoi1SXVewa8Dy3kWjjUcRr4MqWM/wXwhM+ahex2r36hNOUrUP84eq+1PgciW7SVwPlu
         veRBkUwUOmi9wnLLkW9kGMgBkO15+BJCNVVzbG0TkWt91a5r6uWrtdUdar3rPurkr5j+
         pw0APzRkjBpjUr3grHd/PA+YV/Z7dtTeqGyqDzLu3rpAMbX0GtnOOq/dFbQZpBF8Zn36
         l2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAqG1Kr2Uolyjf/GxkqX22B3ljt5De835XrdxJINeQY=;
        b=eEtSWBZfllFGlqR680AX4YrJRJ7yUYAum5COJg5Ip9y12WcoZOlrP9It/MQycISf2t
         PB6vb8MS9ICqFShUxl3gXxvoCpL+a1tV+ZnCKnRYFUahJa0QgtiKWjDawwp9zmDvKoLg
         XnzBdyOvUUwltfrCEnSePKF/g0evAbRhOSQdKqKScACH2b/kndRq0kJcnkT8TrI1Pd0b
         zym53upag1iMev3LIOiqZAFia0S9fC1l1l6TR9QX9Nw3oUGMJvSWn1R1eJQPxmeeu1EG
         ckjefMLVLoLxUe4nZCvtPhhJSwes9UxGcg4+8g0S6gBzKhDaL418aja/p0w1pmIXv3vc
         +lNQ==
X-Gm-Message-State: AO0yUKVE/YgiuMG4J40OtKnBpDr5JCvhc3YTcozPS8oq2eSmnwbvP7G3
        BJrtxtcsC+A9F7DRYdX3x56mH9GYPH3+3A==
X-Google-Smtp-Source: AK7set/3Y3jEPnvR1RngK4q5SDmu6erxClP8orPtqlpRlvLoscW0Q5Hkc86iiluUlokORxnGbKaTSw==
X-Received: by 2002:a05:6a20:6914:b0:d4:90ce:ae1d with SMTP id q20-20020a056a20691400b000d490ceae1dmr9879234pzj.20.1678878422327;
        Wed, 15 Mar 2023 04:07:02 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005892ea4f092sm3337489pff.95.2023.03.15.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:01 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 0/4] Devicetree support for Loongson-1 GPIO
Date:   Wed, 15 Mar 2023 19:06:46 +0800
Message-Id: <20230315110650.142577-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update the driver to add DT support and dt-binding document,
along with other minor changes.

Changelog
V2 -> V3: Explain the reason for changing the author name in commit message
          Drop the patch "gpio: loongson1: Use readl() & writel()"
          Restore the calling of __raw_readl() & __raw_writel()
          Add Reviewed-by tag from Krzysztof Kozlowski
V1 -> V2: Keep GPLv2, just convert to SPDX identifier
          Split the change of calling readl() & writel() to a separate patch
          Let gpiolib parse ngpios property
          Remove unnecessary alias id parsing
          Remove superfluous initialization done by bgpio_init()
          Add MODULE_DEVICE_TABLE()
          Other minor fixes
          Use the same consistent quotes
          Delete superfluous examples

Keguang Zhang (4):
  gpio: loongson1: Convert to SPDX identifier
  gpio: loongson1: Introduce ls1x_gpio_chip struct
  gpio: loongson1: Add DT support
  dt-bindings: gpio: Add Loongson-1 GPIO

 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 49 +++++++++++++
 drivers/gpio/gpio-loongson1.c                 | 71 +++++++++++--------
 2 files changed, 92 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml


base-commit: 0c14f3aa388d3becd38923869e17f9947a5e5926
-- 
2.34.1

