Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29C67BFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjAYWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjAYWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:14:18 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C75DC18;
        Wed, 25 Jan 2023 14:14:13 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id z12-20020a4a490c000000b004f21c72be42so34522ooa.8;
        Wed, 25 Jan 2023 14:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SLmJ2tZeARmtluEJroV3DXcm4rIpFNaSXD75agcltk=;
        b=wMQzVz7SHOx05IY49vRGygB+EH9/EkYyJ/M5I5nkUsKXx3so8OOQ2dWN/f/fFtquVD
         fE7egTzb7bqI/jirynVGvl6tBQ6OBf7RH3weHyNxfki12SHEdnvqBVQw1RysMQ7loYFD
         xpRPUmgPtjtL5kFryPDl5hOHIqSBTTfrsCiEajizLLzDEq4R5ahdRb09dmOtV+5xXJ+q
         76F2/NrM7nfO4KCDZHRGBY51WQ/1muWNUs1eGJN8R1W057+NgC0+J/x+EIdbhUSxudBc
         ZPcHkK8Dz8ZG5ixhLdZtkCI9ThZOkbTT0j0h/rKnNC4NpZTk0PNUgUSaI24lQfdYdsi5
         qe6Q==
X-Gm-Message-State: AO0yUKXO5BTqiMCDleJSbVQK4vHAAyqbuMK8ODdurmpVcXve09s07Xn4
        SAEHi0Ld0cVCKra+OF0ZVg==
X-Google-Smtp-Source: AK7set+CAs0QByUUQL1Qok1E5hZt9YAksaekbLx/zJ2FaabAcCGU2Lyq9gUJMSy9upYoV3ZwmaGu6g==
X-Received: by 2002:a4a:55d7:0:b0:50e:332e:83a6 with SMTP id e206-20020a4a55d7000000b0050e332e83a6mr3338964oob.5.1674684852714;
        Wed, 25 Jan 2023 14:14:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a4ad587000000b004f2d3b9aa80sm2356564oos.18.2023.01.25.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:12 -0800 (PST)
Received: (nullmailer pid 3057978 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/proximity: semtech,sx9360: Fix 'semtech,resolution' type
Date:   Wed, 25 Jan 2023 16:14:04 -0600
Message-Id: <20230125221404.3057806-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'semtech,resolution' is a single value, not an array.

Note that it is also defined as a string in semtech,sx9310.yaml. Sigh.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/proximity/semtech,sx9360.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
index f088c5d2be99..ad0bb44f41b6 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -36,7 +36,7 @@ properties:
     const: 1
 
   semtech,resolution:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [8, 16, 32, 64, 128, 256, 512, 1024]
     description:
       Capacitance measurement resolution. For both phases, "reference" and
-- 
2.39.0

