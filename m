Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0476EA480
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjDUHSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjDUHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:17:59 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06FABC;
        Fri, 21 Apr 2023 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682061451;
  x=1713597451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCdrh6crw/OWqv2/q77cIZCMSofFpJzwyXynpdc8ASs=;
  b=D7aY8kB6qeqXpVgoWG5O7pPkvmNleygVF4SbvdVRxuEP+r7ssXYUOmbM
   6DziiifFhvxWqw9/8IDy7wxXmmEYbu5b4McqojVbjCRqBziaDjG3yTSmW
   K0fDeJtpROBTuq5j/awYd7burRbuWYmDxo5LKqVSvMvUEy1iWNK1I981P
   h+Q6ONWe6o7xF522MRiANegvPi8qSaYb+Nzjm31/IsT4mCT8qLNk0ompv
   kWGUksRnqwfzzFrwcYvicgZhtiGHhBFfbv77LlqDR+rTcdCfXTgs/hGGO
   M2xlrwTI/213lZ9mmeEhTtliv8IG+Uvyx+ygFnv0ioomwVl0cDuW+Eq3X
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
Date:   Fri, 21 Apr 2023 15:16:30 +0800
Message-ID: <20230421071630.524822-3-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230421071630.524822-1-chenhuiz@axis.com>
References: <20230421071630.524822-1-chenhuiz@axis.com>
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

Adding the invensense ICM-20600 to the compatible list of the mpu6050
driver

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index ec64d7877fe5..67711bc0ee6c 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -20,6 +20,7 @@ properties:
           - invensense,icm20608
           - invensense,icm20609
           - invensense,icm20689
+          - invensense,icm20600
           - invensense,icm20602
           - invensense,icm20690
           - invensense,mpu6000
-- 
2.30.2

