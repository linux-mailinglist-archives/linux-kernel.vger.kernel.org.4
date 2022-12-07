Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E264628D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLGUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLGUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:43:34 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014F2C65B;
        Wed,  7 Dec 2022 12:43:32 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1445ca00781so16131950fac.1;
        Wed, 07 Dec 2022 12:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clsoCCY66HioZ8dD2GeAWKW0zSQrMxZw2XXN7NxYt3A=;
        b=LLoSKIukcSrUDGWNElsslTpBqGb/p0xu7LBNlhTn9fq3TwZqi7M8HEIYtp6R5frnWq
         4vAcvyShuebmweOPVVPECvqk2/58prb2Vn3Hw/b8ZODN9GxTBeZuiZ3VrmNfMKN07j2G
         DUYVHRQv2kGGc+JPDaf7B9TShhSIWty6yI+KrZsXfuXUPoWlnH9sn621uK3cbNvfTexk
         5hXjzuGPsyN0f6DOL1T7No0lV3mi0+GMAXms+XSXGAJk75CNckrS0FQNEvFRyahughne
         K/9q4XlOpAODR4syMW9tjvpEffP/7jOfwkJqq3Id3tdbq/+GHX/e92j2x03/7O6nlbaq
         ow3A==
X-Gm-Message-State: ANoB5pmKkv7NLsxUrHbgNBchnshJM++8MKualfIfB6YZgOAAsyrGn7wo
        0Wsx+hFppXqpFSeFVCUXVQ==
X-Google-Smtp-Source: AA0mqf7uG9MBmgLp3fO95KnMvzIt6eIUOGbfoadp1aCxQjPuXRTndixvrCmpsYIPYUKNQruFQ5Ps1w==
X-Received: by 2002:a05:6870:c18a:b0:142:870e:bd06 with SMTP id h10-20020a056870c18a00b00142870ebd06mr48346239oad.181.1670445812066;
        Wed, 07 Dec 2022 12:43:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a056830410c00b006619295af60sm10798290ott.70.2022.12.07.12.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:43:31 -0800 (PST)
Received: (nullmailer pid 2810095 invoked by uid 1000);
        Wed, 07 Dec 2022 20:43:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds: intel,lgm: Add missing 'led-gpios' property
Date:   Wed,  7 Dec 2022 14:43:26 -0600
Message-Id: <20221207204327.2810001-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example has 'led-gpio' properties, but that's not documented. As the
'gpio' form is deprecated, add 'led-gpios' to the schema and update the
example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/leds-lgm.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
index f8d7963c3a13..3f13db0dc915 100644
--- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
@@ -64,6 +64,9 @@ properties:
             minimum: 0
             maximum: 2
 
+          led-gpios:
+            maxItems: 1
+
           intel,sso-hw-trigger:
             type: boolean
             description: This property indicates Hardware driven/control LED.
@@ -118,14 +121,14 @@ examples:
           reg = <0>;
           function = "gphy";
           color = <LED_COLOR_ID_GREEN>;
-          led-gpio = <&ssogpio 0 0>;
+          led-gpios = <&ssogpio 0 0>;
         };
 
         led@2 {
           reg = <2>;
           function = LED_FUNCTION_POWER;
           color = <LED_COLOR_ID_GREEN>;
-          led-gpio = <&ssogpio 23 0>;
+          led-gpios = <&ssogpio 23 0>;
         };
       };
     };
-- 
2.35.1

