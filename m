Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A467FC1C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjA2BeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2BeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:34:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934E6E90;
        Sat, 28 Jan 2023 17:34:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso7234327wmb.0;
        Sat, 28 Jan 2023 17:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRsgsFOkDL2GeFrKorEQKN10FPDAyCyhKXv2uU/88Ko=;
        b=dxKQuht2s4U4X2KDPzAlSyw52WRimmYQVTovbxtRZQro32CD+XMb9O+yz8R7kpRa3y
         VQR+CWM0j+VO1lMXcYPc79YRTGc39KJSRSXI0TRXwW9Xe+pPqwfmEz7wQ6nIzmobh9/u
         nY4UVGcu7DDVxxlsfMef3JrHlHgY2U8+gKnTMdcg9zKICO85H9mZkEuoPo+x2oPlzQMx
         Pd//E1ZX+lCLNnl3OvfYxzbb9pYAjXWvEB+MDmjzhJOl9PRPaa4R/leWIeOhU8lo0vEM
         oWllPU3VOWJr4DmCK7iXDWBbwLo2dtLLzXC5/HZTi+3ui0vH7bWITd+9Ly2CSktBUbfK
         ml5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRsgsFOkDL2GeFrKorEQKN10FPDAyCyhKXv2uU/88Ko=;
        b=PLrCtIrIQz4w/4a2wVvsZ2TlomKKIbe2VB3X18KbTfr87FOqATXgKBzCDh0iyNprJo
         yxW7enWcx3m0T7EtbRgGnhnDqEpmJ0Ygjv5a6bFv4Yt+g5FpUIEeak6AVFKy6GEbNV4O
         15fXfs0+Qtop3BmbPFDmaEFISns9UOjTTYECCwlCOezJYBcmFSpVlB82Tm6cAkqmla3O
         F3L90GZaOMLhTO+31fyZHFcyokMgsS4v5YUuRqgrW54zcIyXmMrAGzyqyk+KzQ2bGuVN
         30Qc336naWM7OkgJz7gq7que9Y7pi9DS/DbAI/gMrhslZ+cUrBSpcHFM2Q+X4eQkK0sh
         mmYg==
X-Gm-Message-State: AO0yUKVSL9x/9lhFgA9HI5RSvkeBEouXWGvOAgn3MLes9XzczGhhQBzD
        peAhLVCuGZHm67mN385u+g2ajor0HN4=
X-Google-Smtp-Source: AK7set/fhMPWeoK42Zs856R1cnCCgM97Pc3z2dRdP+FBZr1l7VtKrgLVMb81esrv8NGRSCJy2a3DDg==
X-Received: by 2002:a7b:c85a:0:b0:3d2:813:138a with SMTP id c26-20020a7bc85a000000b003d20813138amr850568wml.35.1674956038257;
        Sat, 28 Jan 2023 17:33:58 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:33:57 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Add support for pressure sensor Bosch BMP580
Date:   Sun, 29 Jan 2023 02:33:02 +0100
Message-Id: <cover.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This patchset adds support for the new pressure sensors BMP580 extending
the bmp280 driver.

Patch 1 introduces a minor refactor of the driver structure to change how
the device matching and driver initialization is performed. In place of
the chips ids, the driver_data now contains a pointer to its chip_info.
To perform this change, a series of declarations previously on the core
file were migrated to the shared header file, to allow access to specific
fields on the chip_info on the I2C and SPI drivers. This change is
required because BMP380 and BMP580 have the same chip_id and values would
collide using the chip_id as the driver_data value.
Patch 2 introduces new preinit callback and unifies init logic across all
supported variants.
Patch 3 made calibration callback function optional.
Patch 4 deletes misleading i2c reference on bmp280 Kconfig entry.
Patch 5 extends the bmp280 driver with the new logic to read measurements
and configure the operation parameters for the BMP580 sensors.
Patch 6 updates the devicetree binding docs with the new sensor id.
Patch 7 adds the NVMEM operations to read and program the NVM user range
contained in the non-volatile memory of the BMP580 sensors.

Changes in v3:
* Refactor driver structure to use chip_info structs as driver_data and
  updated i2c and spi implementations device match codepaths.
* Deleted Kconfig driver title misleading i2c reference.
* Made calibration reading optional as a prerequisite patch in preparation
  for the bmp580 built in compensation.
* Break command helper function in soft-reset helper function and NVM
  operation helper.
* Fixed minor styling issues thorough patches.

Changes in v2:
* For patch 3, fixed missing retcodes reported by the kernel test robot.
* For patch 5, fixed logic paths that left the sensor mutex locked
  reported by the kernel test robot.

Angel Iglesias (7):
  iio: pressure: bmp280: Use chip_info pointers for each chip as driver
    data
  iio: pressure: bmp280: Add preinit callback
  iio: pressure: bmp280: Make read calibration callback optional
  iio: pressure: Kconfig: Delete misleading I2C reference on bmp280
    title
  iio: pressure: bmp280: Add support for new sensor BMP580
  dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
  iio: pressure: bmp280: Add nvmem operations for BMP580

 .../bindings/iio/pressure/bmp085.yaml         |   2 +
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 762 ++++++++++++++----
 drivers/iio/pressure/bmp280-i2c.c             |  45 +-
 drivers/iio/pressure/bmp280-regmap.c          |  60 ++
 drivers/iio/pressure/bmp280-spi.c             |  47 +-
 drivers/iio/pressure/bmp280.h                 | 273 ++++++-
 7 files changed, 958 insertions(+), 237 deletions(-)


base-commit: 354f23ac2c8703d170354577738edad159a7d37b
-- 
2.39.1

