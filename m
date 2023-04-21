Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A76EA46E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDUHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDUHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:16:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B02DC;
        Fri, 21 Apr 2023 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682061409;
  x=1713597409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wSLvUjoBxKRsjb8nuSXO7SpGcSgWBk04cvadMpAu3k=;
  b=f2yvT/gXKb5jghwPPJWz5CTpimmX1w3dSVERseofW+vn66RWCKGyeDrJ
   OwlOIMS+ee2Yce7q4yAPsABUo1oyAGNz2U1Ent6cBBULZbNdHnq9H96PV
   EUBXZC6KmlUwHrT5eJgVnkhuI9caf5wiXdS2F4TyFDKX4sGOPoxcYqNAm
   0EQ2vtXNvt9d1LQaNqxL1f9eVMsAWyof1UTyWyGAOD3+WPnPOpIGc/t62
   DTPAyTOGn6hzm4+OilCN6XtRAkh6mQYmjo7QwORn6jb8HDklRGshpPziM
   GwsrU6E7rO8zwvWzpU6z/HyNvZiTJfkPMP8lmZWRGqEkPG0pHI/ctYJjg
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH 0/2] Add support for the ICM 20600 IMU
Date:   Fri, 21 Apr 2023 15:16:28 +0800
Message-ID: <20230421071630.524822-1-chenhuiz@axis.com>
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

Hermes Zhang (2):
  iio: imu: mpu6050: Add support for the ICM 20600 IMU
  dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050

 .../bindings/iio/imu/invensense,mpu6050.yaml           |  1 +
 drivers/iio/imu/inv_mpu6050/Kconfig                    |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c             | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c              |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h              |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c              |  5 +++++
 6 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.30.2

