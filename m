Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49056E01F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDLWhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDLWhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:05 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E7769F;
        Wed, 12 Apr 2023 15:37:04 -0700 (PDT)
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Pxcyl0DLlz9stp;
        Thu, 13 Apr 2023 00:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Af00wCmn0A5LJp9Zm6u35n9ZVSLHJhWc+LLhfscf9Fo=;
        b=LjBnyLs6mp0oYySfaebrPmNmlxpVD3WyYxLMp5+KklvKBkX+x4D78h3J1fSBYf5G7BH+IE
        6MKV8/HejPEwP7BLerNBueNbcZlOcW/Vmmo+75ryaNdUdQllhpNAAwhbHsUn0lfZYPbN0+
        0vIvCYXdNzDb5LD31A8yzYi0nH8xV6At1Xyeu8jLPDCQRBqELZf5QqOrjuvCANWebEfaFP
        dYJUHH8nSlyiEF8WMtptp8Q8ELmzd9DF1kyJFlEME2oeECcPKFySgE4Sen3qCRb6NxmXyg
        5Cj1r/IanaRs5qSsZkUxNAaLUH/MobUMAeDP7ChLST1Gjp+RDX72D49AMLEXtA==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
Date:   Thu, 13 Apr 2023 00:36:27 +0200
Message-Id: <20230412223627.442963-7-mail@mariushoch.de>
In-Reply-To: <20230412223627.442963-1-mail@mariushoch.de>
References: <20230412223627.442963-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Hoch <mail@mariushoch.de>

Same as the lsm9ds0, except that the lsm303d doesn't
feature a gyroscope.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index c6201976378f..194aca5542c2 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -85,6 +85,7 @@ properties:
       - description: IMUs
         enum:
           - st,lsm9ds0-imu
+          - st,lsm303d-imu
       - description: Deprecated bindings
         enum:
           - st,lis302dl-spi
-- 
2.39.2

