Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688FA6F7C86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjEEFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:49:04 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F81FE1;
        Thu,  4 May 2023 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683265742;
  x=1714801742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MIcjUSt5Rp38IkS2qQyehaQjIgzSnOJn+wVxciiOt2E=;
  b=i3uP0CkRF98evWAtziv0hyxf/X+GGYg5Y6lCEeGogluOzuCj9DgjDFoQ
   Nod7joZcGLcSuzna+joK5Z9nMDRPcqjPiHpQ8y5U3RBzuVphizjeVN238
   6A/G0id4fXzh0rwUclV5em6iPnf0cYEL0ermbpQBPo+AOjBZgQ1M6Le5c
   2TgNci9joOLfba2cl56rm7414jvJxFINCPuNLpywR27P3LlUNV21x3vq8
   SpBtCS+4KvK+Us5XH7a1EqWm6zBMEmZ5trPNTaVNwo5FlLASr94o2GT7G
   Jl9GSHu+9OaMbrxwX4L9lNZcu62kpE2AQamErwMTbbZoP2r3B42FTH7BX
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v3 0/2] Add support for the ICM 20600 IMU
Date:   Fri, 5 May 2023 13:48:51 +0800
Message-ID: <20230505054853.2155326-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Invensense ICM-20600 is a 6-axis MotionTracking device that combines a
3-axis gyroscope and an 3-axis accelerometer. It is very similar to the
ICM20602 imu which is already supported by the mpu6050 driver. The main
difference is that the ICM-20600 has a different WHOAMI value.

Notes:
    v2: require specifying "invensense,icm20602" as a fallback compatible
        in the binding, as suggested
    v3: reorder "invensense,icm20602" entry before icm20608 and add
        Reviewed-by tag from Krzysztof

Hermes Zhang (2):
  dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
  iio: imu: mpu6050: Add support for the ICM 20600 IMU

 .../bindings/iio/imu/invensense,mpu6050.yaml           |  3 +++
 drivers/iio/imu/inv_mpu6050/Kconfig                    |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c             | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c              |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h              |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c              |  5 +++++
 6 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.30.2

