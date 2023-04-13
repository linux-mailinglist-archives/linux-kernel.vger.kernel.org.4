Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69716E04E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDMCxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDMCxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:53:48 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08E40F9;
        Wed, 12 Apr 2023 19:53:35 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PxkN56w2Sz9sqQ;
        Thu, 13 Apr 2023 04:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681353653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlxmi8TjfHTxZJwdTO4o4SDvKTGV2TgJ+RNBxFINEus=;
        b=WhPoteKKHBOkFD2G/ED3bs1NLXeYQWqTunVzagAWi2FcijiIXxrXdQ83VSta7v0CXcIr9H
        R3j274R80yfAwna7I6f+e3GN1wg/6JLxWcZGU45k9QetGTe/7z5oVatCop6nLDKN47vuXX
        AAjVgdAhdGwMSPwVSZTdcx4zI1YZw+oR4ZTIn5r9a8X6Uf7/BCB1YcH+iGta6l+vPm+Jie
        suVX4HWy4rCJv2frtBuQWnau1kqMzoAsGntywOnEulk1hG3gsLlMueaEcWxMWNIq0W85c0
        ukjRhCHPG/yKBJ9iWZWVMdQ/8pl1cZ2ycgtXg9VDZ8BkWMzYyiXuQOgT+Yn+WA==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v2 6/6] dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
Date:   Thu, 13 Apr 2023 04:40:13 +0200
Message-Id: <20230413024013.450165-7-mail@mariushoch.de>
In-Reply-To: <20230413024013.450165-1-mail@mariushoch.de>
References: <20230413024013.450165-1-mail@mariushoch.de>
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

