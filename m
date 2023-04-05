Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28436D73BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjDEF37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjDEF3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:29:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BA40E6;
        Tue,  4 Apr 2023 22:29:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id k12so6638216qvo.13;
        Tue, 04 Apr 2023 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680672584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqALPLXds7YJmJDFdWxiFjorgCC5NyAqLSL+2g2RE64=;
        b=XzGACWBc5YuA1DRAPUsiEd0QT4NndSKDDm0N1Lop01QfHj0rpnXSnw1KAP0XU3v4P3
         kX853XnPPb5VYGq9/zAiXQ8VfMoTvXbamX5UJfhf0rhmhUVKpeaD3FTtJEjVK/oVm2ju
         5RQsgu7F4d6CoJxrISnXOrgbsywIqfEspzSSQMHdRzmneJfltRQUGmFzE1cTU9UAfmy+
         9XfVHKJP5iluPOcPnEbHXls8EaV/YhWNQHYZTfqWQpJyxvSnRQE+xbj/NLkJlmTw4NIz
         AUe0BPmWCL5UaPecOYb5W0arANXsA5GRSBfrvWWMS6fmoINlN5ALhQjsHTmfv+kaFqW4
         IgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqALPLXds7YJmJDFdWxiFjorgCC5NyAqLSL+2g2RE64=;
        b=cUOvaui5E4MZruzPeehNPrsCx8+osLR8YlZ81s+H8UMFOhFiaA0bT4f946fN2f8zPC
         zg7T8I1Mcle/jkNWcWPIrcmVFitBhgeF9j2lrDh31rhQ7blSFTMr+NvpAfVJK+yLLWLx
         onF41nAYESODVrabBapLS4vPxCuAo0qU3loPH9GUyDhSVt/othSx7ZWxhv8E5zGJj7Vz
         X0DY3vZX6y7GDkld+FRVKqJ+FXPNwjWKeVkYcyzNckgoj5yU7miaWbFW+iTzyEr28rpF
         j5EWZoLdSlBGoGk/uBqwbvxFX0dUQ1Ggm6auW5e29hcB89J6eeEIYWYfojN28+uRKi4I
         1MVA==
X-Gm-Message-State: AAQBX9cxhLcSU/Ky5rL5PuNWqm1dzq3wsIYc6gES58JqJPByDNyLShgJ
        Jobk9m7FrKhaBkKCYs3KKVg=
X-Google-Smtp-Source: AKy350YhBYKekBlB8OGnt+dvshmirBOsMx/2zCS+TXNjoZCDgYVqjdJeFCIptKbzwF7vNKh8M5RR4Q==
X-Received: by 2002:a05:6214:1313:b0:5ce:7b40:8999 with SMTP id pn19-20020a056214131300b005ce7b408999mr8901304qvb.22.1680672583846;
        Tue, 04 Apr 2023 22:29:43 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f12-20020ad4558c000000b005e16003edc9sm3881454qvx.104.2023.04.04.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 22:29:43 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 07:29:09 +0200
Subject: [PATCH v2 3/3] dt-bindings: mfd: dlg,da9063: document XVP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v2-3-2f1bd2a2434a@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Document that the da9063 only provides UVP *and* OVP in one, and
therefore requires both configured. Add an example for clarification.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index e8e74e91070c..e9d5ab418dd2 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -12,6 +12,10 @@ maintainers:
 description: |
   For device-tree bindings of other sub-modules refer to the binding documents
   under the respective sub-system directories.
+  Using regulator-uv-X-microvolt and regulator-ov-X-microvolt requires special
+  handling: First, when GP_FB2 is used, it must be ensured that there is no
+  moment where all voltage monitors are disabled. Next, as da9063 only supports
+  UV *and* OV monitoring, both must be set.
 
 properties:
   compatible:
@@ -121,11 +125,19 @@ examples:
             regulator-max-microamp = <2000000>;
             regulator-boot-on;
           };
+          ldo6 {
+            /* UNUSED */
+            regulator-name = "LDO_6";
+            regulator-uv-protection-microvolt = <0>;
+            regulator-ov-protection-microvolt = <0>;
+          };
           ldo11 {
             regulator-name = "LDO_11";
             regulator-min-microvolt = <900000>;
-            regulator-max-microvolt = <3600000>;
-            regulator-boot-on;
+            regulator-max-microvolt = <900000>;
+            regulator-uv-protection-microvolt = <1>;
+            regulator-ov-protection-microvolt = <1>;
+            regulator-always-on;
           };
         };
       };

-- 
2.34.1

