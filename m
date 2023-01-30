Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDD6807D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjA3ItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjA3Is4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95F18B26;
        Mon, 30 Jan 2023 00:48:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so2319398pjb.4;
        Mon, 30 Jan 2023 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dgMsTq5Ts9YEjqdpbek5QxemQ/PfLYpnehoHOo4hN8=;
        b=kRlKvwqJrudORyPXxYlY6uAPXAorGilGpcQYT9VxBv+HOC0g2w6/zeryG5O0wZF8xJ
         1hO/UFchFYBL4M00kX7zFg+5A4IrEt2454v2kJkfXXAvlLsiwDZRY1eBfjYdEwafGoRz
         3skVunpDqqgQgy+Gh445WndXIdL7eQag6l6SfTvwTjz2+VD8zocooGY6yf3sLTDAWTSA
         zVxnnOycc0BZgmmJk6Rj3zT0rn/rf9C+FDI8jMzf5MuRH/BPNjmNIWSyLye0UY7cB5cC
         iMj6VpJQ7lO382Mr04hN2ECiwIhsjcwhao8NVosolZwUiT+0W1r5MrMeBMEcp4KLTtP/
         8GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dgMsTq5Ts9YEjqdpbek5QxemQ/PfLYpnehoHOo4hN8=;
        b=TnRHrskK9Bp/u4jUcQ5UnaQqVtF+R8cPYSxaM/0FzTXuLSQ3tqqiNABN+1QoBaxwER
         Dnr23LrfcKdoW3mc6vtyX8Rc4OeP7jM0oNW/dQwVI6md0f73LqEJF4b3TMKHMLZeDOwP
         L7jdzpa3YA7cEIZtr2Luq0sBZE9wmu8CiWxNrsGUR0x3s6GEZSSRO1J5TPUrVkroLg9j
         TVcYtsq8QuTafhJ84oHgqqLhq1UMyMg/ojJWYjLznDuemVeOwWOt34oGT6QBNwFuthS0
         9TStCBiK3PGVu3VIMZ/mDVj9dlQw84G2ukpQoavLE2sNrY6+kMAN0JJaOiooS4RRbzBh
         2gnA==
X-Gm-Message-State: AO0yUKUUJLoNQVrB6Lt8Q/pfUFTQn1noD+qYziFKS3Msxsty67/nXEA/
        tMnba2HIeiFvu9SPp51A3ik=
X-Google-Smtp-Source: AK7set8Nlmxdg0CtwUfU9uT+3YiRsDDX20CZDBHXxQPB1hfblLlao+qqh6ph4W22gi2k3hBv3FKL7w==
X-Received: by 2002:a17:903:11cd:b0:196:8d33:f083 with SMTP id q13-20020a17090311cd00b001968d33f083mr1179155plh.28.1675068502630;
        Mon, 30 Jan 2023 00:48:22 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b00192d9258512sm7205284plb.154.2023.01.30.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:48:22 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v5 4/4] dt-bindings: usb: vialab,vl817: Cleanup compatible, reset-gpios and required
Date:   Mon, 30 Jan 2023 08:47:43 +0000
Message-Id: <20230130084744.2539-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130084744.2539-1-linux.amoon@gmail.com>
References: <20230130084744.2539-1-linux.amoon@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v5: added Rev by Krzysztof
    fix the subject as suggested by Krzysztof.
v4: Fix the subject and patch description.
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

