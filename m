Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C86E9D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjDTUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjDTUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:22:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283092710;
        Thu, 20 Apr 2023 13:22:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso1438901a12.0;
        Thu, 20 Apr 2023 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682022146; x=1684614146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTqcl8tf1Ibk/nidmtYiKCPg/Dv/QDDdm5Do4ksXgmE=;
        b=e5JdzK+uVlykkjsw0sYtxL0aC1cV6RY1Vn2duFaQaaWI2FKvtS7GmYb+e2VZzFwLyZ
         w2owUIACpZ0/UmGn7N7Czn8W3DqhOB9lFHE/uqPrtTVuvxoy/EuEmPY3qS1gvGZ/MqNO
         K8aeQcXkrLVeb9IWwr0PS3rlGjBrT2D4ZUnRHUK6fWg8UcAAArl8SfEOn1Xqoju5BeUX
         LAmowv/k/ZLk1Ub9M9FAUggouYV5FXLpKCz96bmEb5l0DP3ddlkt1+tDMpFbnhZbj49q
         SwCrVEF1O1rYeO8O7vuzm/fE15pep1zWScwwf4ayHhvncl7NnoVcCjva9AqVsaUj/PtU
         narA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022146; x=1684614146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTqcl8tf1Ibk/nidmtYiKCPg/Dv/QDDdm5Do4ksXgmE=;
        b=EsK7svh2W/9KKgHinT99EwLkBW1IzDTdhXkfTtxszKAeIP4pEqU3269bKBa8a4xzNa
         80LISFFMC5l7m8pPIdrrJRb7ROyxkb8YupM91QPs83O9ytt+1vmsle0m/o3tvTSC9YAv
         AB99q8MGstm3z3w/zlrcqgtv9SnTc9nexgwe4U4dyko5mArmfq7IMnjFje1V8VQcx6Ce
         bAJf3i8KPUIXYVOLK7iQdxmpf9s95ACDp3qVxLHmHUxVF9W/oxeQDVwl0NYrfFLN9dsw
         rwVf2zgpscV0FLj/zYhqNXdOFYo05kQhvg23TiQ++Ee+aFHCjPhRudxXEpIizvE2c+AE
         l/7Q==
X-Gm-Message-State: AAQBX9durcSX2Mh0E5gseeMP4AC2lqiHJFQ0GRbs61p92r1H0XVcrDk2
        3ZwPvPyMySyrNK5dZLTTFmnGi91UTiQ=
X-Google-Smtp-Source: AKy350ZtokotMDwsNUXxLbr/Zp4Ij+ARXhgNqXt/M3SnLX4kgIEkcbTl8S7TxxT3Q34DNX9NGwMGFA==
X-Received: by 2002:a17:907:c30b:b0:93d:ae74:fa9e with SMTP id tl11-20020a170907c30b00b0093dae74fa9emr226363ejc.7.1682022146502;
        Thu, 20 Apr 2023 13:22:26 -0700 (PDT)
Received: from carbian.fritz.box ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm1136881ejn.149.2023.04.20.13.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:22:25 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 0/5] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer 
Date:   Thu, 20 Apr 2023 22:22:00 +0200
Message-Id: <cover.1682019544.git.mehdi.djait.k@gmail.com>
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

Second version for adding support for the kx132-1211 accelerometer

KX132 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132 accelerometer is very similair to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch

Mehdi Djait (5):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  22 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  23 +-
 drivers/iio/accel/kionix-kx022a.c             | 325 +++++++++++++-----
 drivers/iio/accel/kionix-kx022a.h             | 143 +++++++-
 6 files changed, 426 insertions(+), 107 deletions(-)

-- 
2.30.2

