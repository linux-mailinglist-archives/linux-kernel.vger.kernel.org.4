Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67216F7C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEEFts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjEEFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:49:42 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF6150D7;
        Thu,  4 May 2023 22:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683265773;
  x=1714801773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=By1zElzEqUICh73uUeUdo6GgTEEpWsDQwesL5Ji0Geg=;
  b=mwNcx39sU/dLrQPBQ+476T1RbJnsfSdomONlpb/WpssSp0kKTP/7gwO0
   1o/HcK7uD9TI6HYu4JlZG2188qkRTgh4GngEibfNswkA/tEwlN1+NX/TR
   ANSRE3qgX/OfYvWI6IXOEhjWFWGbM7EKYjO1BFA8XV8AVUmAtmiEptb+m
   wXGsgsmOzx2trYdehAu3K+DUR1DYE4f4JQ4p0vjbXByKUg9Ud8/DD4xJf
   /BulwufqFRqjAzqXFaI3rqIQK/7vvLnmYYGAym3ylZRYbO61A8RdiKyA/
   FErQOXFY1OjdsbaiVb+g+GtLqZZmSqNOplgsVH8B1w6Eqf7+W/G+cKoS/
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
Date:   Fri, 5 May 2023 13:48:52 +0800
Message-ID: <20230505054853.2155326-2-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230505054853.2155326-1-chenhuiz@axis.com>
References: <20230505054853.2155326-1-chenhuiz@axis.com>
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

ICM-20600 is almost same as ICM-20602 which already support in mpu6050
driver. Specify "invensense,icm20602" as a fallback compatible

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v2: require specifying "invensense,icm20602" as a fallback compatible
        in the binding, as suggested
    v3: reorder "invensense,icm20602" entry before icm20608 and add
        Reviewed-by tag from Krzysztof

 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index ec64d7877fe5..1db6952ddca5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -30,6 +30,9 @@ properties:
           - invensense,mpu9150
           - invensense,mpu9250
           - invensense,mpu9255
+      - items:
+          - const: invensense,icm20600
+          - const: invensense,icm20602
       - items:
           - const: invensense,icm20608d
           - const: invensense,icm20608
-- 
2.30.2

