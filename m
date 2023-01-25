Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2952F67B494
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjAYOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjAYOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:34:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AAD5998B;
        Wed, 25 Jan 2023 06:34:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so2199619pji.5;
        Wed, 25 Jan 2023 06:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl6Yi+gm6x0jddwKUYCeMj4VHkB5ErH9lG4Oo4LvHEI=;
        b=UTCrM5Ts3D+yEtU/KCHhWsAXHapP08wO/KjKMqHYe9yj2GF1ch9RqJJf+heWVMtBy8
         Dk/Iep6KJsQQrmSo5dE8av/feMByB04hc4uRjTskJti89/F4Yb3TsjNEe/0h+RZuXDnz
         lTwBzPnyftadre+sp7SCUwyvxhikmt718eNJG9vysYXXw1nDtBy4843hQ6VyowtdLU2H
         IlrT0nyknu7PKTCYNG575dWrl3mMrhiLz13KMSKlQPocVnalREz/Br3m2wQtybHWRJiK
         sVezqiyX2i4tl/NRPUJ5AAy/Dp2/QioyaoHw7eyrs2ahqrUe5ttWkz3h0YMq4oZMafia
         jONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl6Yi+gm6x0jddwKUYCeMj4VHkB5ErH9lG4Oo4LvHEI=;
        b=OUAPOtFcazLPdEWLgjJSalVMH8bBiGg7JViwmPmDpKLakDoANy9c72CI3lcoh4zRD7
         8vobvcjUWt8qQnfZ1jSgqVIM0NKjCs0JE6+ZowtW0n5P8+L6OEmF0POpf4I7m+1FOriq
         GD8Qaj2F+uW2/tS3NHxOZWi9kf1Z15PwxRtwqNcXbIiUPS3I4lDaE/PI+02JhP2/OKh2
         fUjT/bP4+tFG/tHxxW4YlOub6GvqVF4IQocW6YFDHpbiFQSadcC/ggFjC3jbrGVYhkx8
         0SsDHN72r+PjDjAjgw6tLx5q+of4Rf5of+Tcirz/hgB+2o2+E0fCG9s//DFdp01fImnj
         DTPQ==
X-Gm-Message-State: AFqh2koAq9gzF5pwEfsLbsj+ItRaYZgiSQDLKOHFFDOKOIJWol3YZ6Yw
        nD27iby1kcn+anJTT3kubzs=
X-Google-Smtp-Source: AMrXdXtvjxXhIcJ2tVOdp1iKzinV8pzyoZgxU25wu2sydM8Afq2kh6MP3sp+3RaSnj7uV+rlPS1qDw==
X-Received: by 2002:a17:90a:f612:b0:225:e88c:33c2 with SMTP id bw18-20020a17090af61200b00225e88c33c2mr34864397pjb.7.1674657283921;
        Wed, 25 Jan 2023 06:34:43 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a1d0200b0022c033f501asm1671465pjd.41.2023.01.25.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:34:43 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND linux-next v4.1 4/4] dt-bindings: usb: Fix properties for VL817 hub controller
Date:   Wed, 25 Jan 2023 14:34:03 +0000
Message-Id: <20230125143404.1424-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125143404.1424-1-linux.amoon@gmail.com>
References: <20230125143404.1424-1-linux.amoon@gmail.com>
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

Cleanup by removing unneeded quotes from refs and
add maxItems to reset-gpios and fix the required list.

Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Dropped Rev Krzysztof.
---
 .../devicetree/bindings/usb/vialab,vl817.yaml  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 5f9771e22058..23a13e1d5c7a 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -14,29 +14,32 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - usb2109,2817
-          - usb2109,817
+    enum:
+      - usb2109,2817
+      - usb2109,817
 
   reg: true
 
   reset-gpios:
-    description: GPIO controlling the RESET# pin.
+    maxItems: 1
+    description:
+      GPIO controlling the RESET# pin.
 
   vdd-supply:
     description:
       phandle to the regulator that provides power to the hub.
 
   peer-hub:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to the peer hub on the controller.
 
 required:
-  - peer-hub
   - compatible
   - reg
+  - reset-gpios
+  - vdd-supply
+  - peer-hub
 
 additionalProperties: false
 
@@ -45,7 +48,6 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
 
     usb {
-        dr_mode = "host";
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.38.1

