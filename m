Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB46BDD28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCPXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCPXs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:48:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276723D81;
        Thu, 16 Mar 2023 16:48:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so14182530edc.3;
        Thu, 16 Mar 2023 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679010532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKTeFImuchKt8/QGCZu5FURqBOhMYu3n6qVwyvVOh88=;
        b=DQJzkLkRyFMJ2P7T8smpal1afba5Y16ryo44UuHnD/6UFL6W5ECkwuUPtIzXjOZxEl
         cGvOoJtwJg7fWs3CeVFoCGdjnR3CDgp3zg4hq2ERblxIolbcMJWd41rm36Kt3S3Lu7di
         CVymckMXtAlfJYF/3Klr4vIngeXCRqJ4pPoSi3yeH8iglOEhrwr0Z91WKo7ISTBP3Dkq
         Z32SrQGix0kqvJ5RNh/SAXk4zPYBqG2OOiq/hlStVOMEPbsu9DWr+LZOydMtMDTS7Cvl
         0Aw9cpNcjBTA1vRcp+06U5pTfyYQijMDUrZA8OHAhAfN7r06Fxb9UeidUgKFUpmNXg7o
         kbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKTeFImuchKt8/QGCZu5FURqBOhMYu3n6qVwyvVOh88=;
        b=Okuf1ZSX97Cxm3w+cCmB5y0wGQH67bg8/NdbsVP4NNLFFrwS0DjTD2nNJHsSyunyro
         f9jgfV/Hz3dpmKRZDPThLh2epfTBupjw6HzsDzAswdN6IeHnfVMI2Z0jEspCnZaCpSIi
         /uxyrSm9j9u0PYARgpXmoGTLPt8C7hdw1LZjJLzjVeuFdgRg0y9WYCXKfxcXj9DiiTNJ
         C3ORkDUWVsYg904UtZqnf7mdZ71boDxwtFe0B0qXMBZWb6kSt/2u5pqmIoqCJ5v0ph2B
         15x/2Wsei0l8RJBS9/OIDceoi0Ak7mXHYYHrFkmCoyzd63FhL96ujtCdQARUaNcVGOX7
         DFUQ==
X-Gm-Message-State: AO0yUKXi/oTNWWBOUL4M8PReONtmjE8/zmQC9JDlruJmOdy4iOtqQpn4
        FXljL7LJ/2fxRS4vscZ+BaY=
X-Google-Smtp-Source: AK7set/6/+tv8SttXUzQxI7L7aS5YLnca3nYeAZZwX2nxgLp5dZpjUzGMYk4K9+fGo70Kv520KDYrg==
X-Received: by 2002:a17:906:819:b0:931:bc69:8f94 with SMTP id e25-20020a170906081900b00931bc698f94mr452549ejd.45.1679010532104;
        Thu, 16 Mar 2023 16:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::a442])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709062dd800b008db605598b9sm226896eji.67.2023.03.16.16.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:48:51 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: Add KX132 accelerometer
Date:   Fri, 17 Mar 2023 00:48:35 +0100
Message-Id: <d677b957164930c3d2fee900117795b25b85c3fa.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the kionix,kx022a.yaml file to support the
kx132 device

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 .../bindings/iio/accel/kionix,kx022a.yaml           | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..ac1e27402d5e 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,22 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, output data-rates from 0.78Hz to 1600Hz and a hardware-fifo
+  buffering.
+  KX022A and KX132 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132
 
   reg:
     maxItems: 1
-- 
2.30.2

