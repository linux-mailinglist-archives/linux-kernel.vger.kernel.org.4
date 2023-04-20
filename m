Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74E6E9D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjDTUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjDTUWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:22:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE740CE;
        Thu, 20 Apr 2023 13:22:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a34a14a54so119062866b.1;
        Thu, 20 Apr 2023 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682022153; x=1684614153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiDtdcy06XCyhFDJKdSPPZSHud6d0q/+1DEyo40929M=;
        b=ExFVgNHV5faxTvk8ocYZh8K3qEo6Yz4wp82sGRqTyyP8Yj6pIvGNYbQNq38AaweiqB
         PxIi9d9YXgnbLyu8HvzPq6MuAmcm5GM1k6/8er5/Gcrag96tKLz+5L87T67QqbGm8lhL
         9IE4IbcWB4Cse3eAwT8IAAn0KRfQjxuk8ewpjFk7+zrSlx3l4uXkLAmnuLaxca7UWDc8
         Jg0f1UkUS82WhfCnhpyAfVZsC4tdv/e5r90LSI3J3+SlbPxcwEQqYHEvqaoGa7cP06kq
         Ic3qVcEZGeggYmaUcAt5zhJyY1pwKMHNKLMUABqRDftdxXh2KNutP/J960SszxX6d0ve
         BI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022153; x=1684614153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiDtdcy06XCyhFDJKdSPPZSHud6d0q/+1DEyo40929M=;
        b=G3b99dkTpA3PTy6eA0+BZEo6PmIJ80Ch3m80tUp4FQJxMdvDTrrf1VgstHYwjwiJvL
         BbqOPh0UV2tYhLyaIlQbsx0x0mYOzSeVf87TsfDTyHKDyZVEhWF96gZ1jAJuDlHCjTPa
         qsVx2CIOJILW/07sudL07so/sc2gF1mOGbRutDOS7xMMmfl9IScPAhaaRAYcbSMEsrsQ
         I6dl2CVVjmLe/IsWAAMIPHwoVNkXbq+1OmfQPzPbwQ9cF7LqOIQd9PEUFJXt3wgOgkl8
         uWIYZm3RMFyE/VLhk4oNx/wvsNOJCgWf7Yd/Iq6DMgz+wrCPdEr/xscqG5dbKNteQvzo
         Vp1g==
X-Gm-Message-State: AAQBX9fb0yBha6Gw93hebae5m0uSzcl1xpU0g3TdwmSImc888EyQLQjl
        GmD5FpGFAqqgFbqsguBjAaY=
X-Google-Smtp-Source: AKy350bul3Kr3GYKA7stV5VpNwADdmTA/BaTRbnjC9WHwGXk1GJRCpw4CPYawcUqH2R6pI4fej1UBQ==
X-Received: by 2002:a17:907:94d1:b0:94f:1c90:cb70 with SMTP id dn17-20020a17090794d100b0094f1c90cb70mr166307ejc.66.1682022152608;
        Thu, 20 Apr 2023 13:22:32 -0700 (PDT)
Received: from carbian.fritz.box ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm1136881ejn.149.2023.04.20.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:22:32 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Thu, 20 Apr 2023 22:22:01 +0200
Message-Id: <68466b01b967efbdd1bf2de0747d35f28f94fddb.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
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

Extend the kionix,kx022a.yaml file to support the kx132-1211 device

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v2:
- made the device name more specific from "kx132" to "kx132-1211"
- removed the output data-rates mentioned and replaced them with "variable 
output data-rates"

 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..034b69614416 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, variable output data-rates and a hardware-fifo buffering.
+  KX022A and KX132-1211 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132-1211
 
   reg:
     maxItems: 1
-- 
2.30.2

