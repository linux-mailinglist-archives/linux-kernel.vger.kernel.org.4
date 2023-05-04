Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0ED6F6824
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjEDJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjEDJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:15:59 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426249E0;
        Thu,  4 May 2023 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683191721;
  x=1714727721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxpfMAAVzSMsSpNg03jMBd98fL8xCc8rZorQJMqF7+4=;
  b=YyjCAEJ/9OzG4K+a/NGolnaM2Kgmc+0PNdfew71qJTmrnnAqa77MJFFW
   7poNayxZtnVw/kdppIlCWSZUIzn8ShQraW4+oma9MwR1QqgDeBJ2Xr/UM
   rDRB5BYr2JrXc5hfWSfNx3w042k4n0VG+axPVaqICAgcMbZGZItXSsyed
   8imnWyO755f2vcd47fNsf+Db7GTWZUEqZzcF+bk+8sRufcbb7SNtGSx+P
   lG8xQXri+gctXg9j2xJhzK2WFn9EkFsu4f3+JGSqSaZcS7HR6vO4vtdkx
   JvraPFswiWaIUs/xqSTPuCqUBcPjdn6nKN6dUS3oeIk061hdkc3sMzfqp
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
Date:   Thu, 4 May 2023 17:14:20 +0800
Message-ID: <20230504091421.2054451-3-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230504091421.2054451-1-chenhuiz@axis.com>
References: <20230504091421.2054451-1-chenhuiz@axis.com>
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

ICM-20600 is almost same as ICM-20602 which already support in mpu6050
driver. Specify "invensense,icm20602" as a fallback compatible

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    v2: require specifying "invensense,icm20602" as a fallback compatible
        in the binding, as suggested

 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index ec64d7877fe5..711a1beeaecf 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -33,6 +33,9 @@ properties:
       - items:
           - const: invensense,icm20608d
           - const: invensense,icm20608
+      - items:
+          - const: invensense,icm20600
+          - const: invensense,icm20602
 
   reg:
     maxItems: 1
-- 
2.30.2

