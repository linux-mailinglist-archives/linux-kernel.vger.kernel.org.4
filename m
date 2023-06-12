Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4072C83A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjFLOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbjFLOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F332950;
        Mon, 12 Jun 2023 07:22:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977e0fbd742so645855166b.2;
        Mon, 12 Jun 2023 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579738; x=1689171738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sx560Di9qmHMvf8XH62YvKC4b96faxuZR68X3dA6VOY=;
        b=lTKBMptM2GI6gMgLSYWZmTk77BFlkMlYC/Sznsl3xba2zWifkTuGy2PUaMoEe+KKqY
         wtHiikuqKurOzdhU/Pzk07x302bx1UPBKWNvVQnrZv9+g4yG6HB+ojZi8zu/VFKAy7Nv
         17pyXS/c7oB93clINn5bgrqhr0u8DrufCoiBZoMVD6fKiEn6H4yxtmZga8Rp6RKQ4ZEU
         88Da5/pefTEXbuu4j9V4uya7y7Y+W3Hu2poUUGjCttkFhfV+m8vDwXUaeom1+TiDQVGn
         HJujgR294E+IJOoXqs4z2W0/Dsr0GWaeeWerL8GKoLlRHwPRoztGes6U6HALh61NDIFA
         Jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579738; x=1689171738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sx560Di9qmHMvf8XH62YvKC4b96faxuZR68X3dA6VOY=;
        b=QquSdZgqDPyVuQCJQIZTdVlVpVuhdJObVeNiKWRx6RWDY6tkaKV0bpMROE8UgLoItu
         k3RdH5bNksPBblPb1rQq+k0zZVdtDjOXH+qavXfwIsO8JrF22Aaddgu0FZ0KknoX04TU
         pMcsb5d6FqeNb1nWcBr79VgLhQHxvTNRfc1fNOg4vSyAeBeuSd9w/IDNHJNEBGFMGtG6
         ljB7LzTpSXNPMceVqcCPb01G9HWfOYMstvg8lbFCIkkON0TfJ60o/9LZ8osF4fGt4zFe
         gLWVSPl/Xr/I/f5AxBXPzaeZFCyXZGRY4rdUR8zMu2bcnuXEjaDIj0O7us48HFzLxiJr
         5mGQ==
X-Gm-Message-State: AC+VfDwRbLfa6iPAPuLg7DQLjlf3NCr9NiBtfkGLRTRqrbFaimoy0Bmz
        HNfil+Osoc2lPP7+tafG3mM=
X-Google-Smtp-Source: ACHHUZ65aF++UurkDgYkPRUcDi8fvtSFKsr2H/VoBqT6EYQpgt+u1QrsYJw8m0ujcJKjH73iBvRRFA==
X-Received: by 2002:a17:907:2688:b0:967:a127:7e79 with SMTP id bn8-20020a170907268800b00967a1277e79mr9415715ejc.28.1686579738218;
        Mon, 12 Jun 2023 07:22:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:17 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v5 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Mon, 12 Jun 2023 16:22:03 +0200
Message-Id: <cover.1686578553.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Version 5 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similar to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v5:
- moved the "kfree" call to match the reverse of what happens in 
  kx022a_fifo_enable() as suggested by Matti and Jonathan
- used min_t, checked for availability of chip_info and moved the
  position of u16 buf_smp_lvl_mask as suggested by Andy
- introduced buf_smp_lvl_mask in Patch 7 as suggested by Jonathan

Changes in v4:
- moved the allocation of the fifo_buffer to kx022a_fifo_enable and
  kx022a_fifo_disable
- some fixes to the regmap ranges of kx132-1211 

Changes in v3:
- added two new patches by separating the addition of the 
  i2c_device_id table and the removal of blank lines from other
  unrelated changes
- fixes a warning detected by the kernel test robot
- made all the changes related the chip_info in one patch

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch

Mehdi Djait (7):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Remove blank lines
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Add an i2c_device_id table
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  24 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  13 +-
 drivers/iio/accel/kionix-kx022a.c             | 312 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 110 +++++-
 6 files changed, 404 insertions(+), 75 deletions(-)

-- 
2.30.2

