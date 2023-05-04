Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168E6F6825
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjEDJQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjEDJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:16:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B2422B;
        Thu,  4 May 2023 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683191734;
  x=1714727734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uGAk2jdLc90R+UIzHHRN4PrcSu0mUczllzTX2lVJL4U=;
  b=lOZC5wkvLeC9yPAXrcw26oR/ZW5eodgdnqgMi9zl6ex8zHLU4AhK+/y8
   6mmqnJ5YAfkZYX3RFozP+SQxCjc6E+bylYEltIk55vXArZ7kQSIZ66WlW
   LvnQ9+IFWvYhJpu1MmsCoPw6j0KQmozpPED/S/PV797bRpFm4wW+WLcj2
   aP21SyhTWcBK0ZfkmlLcnk7369l45xTZMnUnaSv0zUTwT3EGBmicPJLGy
   U0UbYZ3snikbqCghkQBQcMgUFIJvD8qAm6oUj1L/Q7PQN0NUSjLNRAdCP
   Wms/+SGPAUkRrWui5/PnJOWqkTKgSNnGDtGxwoKtOrwoQ+MB23oApZcGt
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v2 0/2] Add support for the ICM 20600 IMU
Date:   Thu, 4 May 2023 17:14:18 +0800
Message-ID: <20230504091421.2054451-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Hermes Zhang (2):
  iio: imu: mpu6050: Add support for the ICM 20600 IMU
  dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050

 .../bindings/iio/imu/invensense,mpu6050.yaml           |  3 +++
 drivers/iio/imu/inv_mpu6050/Kconfig                    |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c             | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c              |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h              |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c              |  5 +++++
 6 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.30.2

