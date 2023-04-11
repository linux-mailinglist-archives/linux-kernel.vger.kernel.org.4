Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC96DCEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKBMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:12:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92482269E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g3so7613373pja.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681175565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RniW0EaX9rcvwsouXvZAHmibtnb+Rd+T7KCE24nNCY=;
        b=gpsiyl3tfNAOPR0m9cBJ/TsIQ63Y4mPkjCNTA+VYKozlxBjFWEzvd64Aq70fLCazDa
         1uyMQ+AZ3/ALLk2DY+vvAv/Buhv9+pgp4yyGF5lGMopZ/TUxbu+5Gvk1nwhksrGswrXO
         RVRIKItN+5FVk9g1akwV0E1bRqgaxvQIZpRcBTanTr3oAebtOIUl1lkE8gqeA0CiYfJu
         vKrMXKqTVKF+ZSLSaZLa5UVX/SV+ePk7mFlrb7qMPsw83dCiT/l5I2SWnf88TnZmW5vu
         3wnhO57QQRFkwuYqs8GXtUV8PBMKdNg3bHN9zlDFv4wFW0QMue6O/55nO9EPhrefKRFB
         Om0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681175565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RniW0EaX9rcvwsouXvZAHmibtnb+Rd+T7KCE24nNCY=;
        b=men5vTjZrAkaQPgcUhlg4xXxn7IeI8HJseNIT/HHlw4XhQ5YcE26vvIe0plOsHNYIK
         0xtOqEEYvC5Xl5WotS0dQSuozLR9p0OLXnYfBmt0Nn5mq4gRkEQZNlC6kxindvTyA0vN
         NOfX56S2jdIUXL16TzvzZd9y825N97nemSNtvVIAypKC2bbD8v63EQG7FXltSzHvw7Ih
         734XSwwpoWy7X63NBJgENZ5zkJrozUc+XoVtw5dtWqX/s9FFj55N/zUELpTFpKQHdVlo
         FEMGr7eqfz3T8WP5RaKjidWz2xMdLUu803E28VZ2xGU6Um0tNDDl9L/Slrl0vNK0u8Ho
         P2uA==
X-Gm-Message-State: AAQBX9dvvWE8VjYaMXpAQoQ8NCvXW7udCoazm8HKquyT3t7hqeX1CG+Z
        vD0V5i0BzQJFIUIBWgSjLV/7Jw==
X-Google-Smtp-Source: AKy350b/YCyY5J5TT5ia537tAFnYcxY6r12iwzfl8tCwiUKhnfagcrfekRkxq9YwRoyvVKoEBdtdTw==
X-Received: by 2002:a17:90a:e114:b0:246:cade:8725 with SMTP id c20-20020a17090ae11400b00246cade8725mr2719986pjz.22.1681175564941;
        Mon, 10 Apr 2023 18:12:44 -0700 (PDT)
Received: from subhajit-ThinkPad-Yoga-370.. ([124.148.71.115])
        by smtp.gmail.com with ESMTPSA id k91-20020a17090a4ce400b00246b1b4a3ffsm2220957pjh.0.2023.04.10.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 18:12:44 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [RFC PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
Date:   Tue, 11 Apr 2023 09:12:01 +0800
Message-Id: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Avago (Broadcom) APDS9306 Ambient Light
Sensor.

Datasheet: https://docs.broadcom.com/doc/AV02-4755EN

Following features are supported:
- I2C interface
- 2 channels - als and clear
- Up to 20 bit resolution
- 20 bit data register for each channel
- Common Configurable items for both channels
    - Integration Time
    - Measurement Frequency
    - Scale
- High and Low threshold interrupts for each channel

- Selection of interrupt channel - als or clear
- Selection of interrupt mode - threshold or adaptive
- Level selection for adaptive threshold interrupts
- Persistence (Period) level selection for interrupts

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Subhajit Ghosh (2):
  dt-bindings: Document APDS9306 Light Sensor bindings
  iio: light: Add support for APDS9306 Light Sensor

 .../bindings/iio/light/avago,apds9306.yaml    |   47 +
 drivers/iio/light/Kconfig                     |   11 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/apds9306.c                  | 1146 +++++++++++++++++
 4 files changed, 1205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
 create mode 100644 drivers/iio/light/apds9306.c


base-commit: 0d3eb744aed40ffce820cded61d7eac515199165
-- 
2.34.1

