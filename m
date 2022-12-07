Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB5646295
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGUo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:44:26 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4E42934B;
        Wed,  7 Dec 2022 12:44:23 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id q186so22061947oia.9;
        Wed, 07 Dec 2022 12:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qri1UnkHnC6DpGfs5kNiu0utXoeigq/E3BhX8NtSuT4=;
        b=JVwzFYQShnbCugWSNOdZywueBz/t0wP/U5y6qtbQF2ODWriVgIeCyQbVraf/aZUI01
         O4VlY6LjXUp5LF6L72Ep2zShNVDhGKOecpylREPD9fiEDoyejpezuLl/TGHegDzPss+4
         nHOpF0ATHQJBdZu88P9WCW9GQc55+GSoeL0OEXa54M6iZ4KpiStVSh6RMxqH6utYUd29
         5jP6ET7szOeyrUrtE2FX4ugKp1ZvEvMI+RjFR5gMg+py1JGYNLwljj/i3RVo290Ub26l
         STgDcUHIyIBT1qeCfLYDiSNJceEkl4Mvo0YP/I4TLBsCcFa4NlZ/2lAHpA7l7PeZeZTf
         SSRg==
X-Gm-Message-State: ANoB5plT0+qiOAdZfdoNUF2gZihSOA8Ju0SbrWzsoYv29a4RLZ3ITkpE
        sB2jX7gCgXwBUt/qoYZG08bGid87cg==
X-Google-Smtp-Source: AA0mqf6wgnZUHCcxecQbNrtcHz+rDxbZt6NKzuqJnCgOHbs8Km9Wqw9sITkoffM6FjtFfVijlhkQyw==
X-Received: by 2002:a05:6808:14d1:b0:35b:92a4:fcae with SMTP id f17-20020a05680814d100b0035b92a4fcaemr27951099oiw.102.1670445863080;
        Wed, 07 Dec 2022 12:44:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870218600b00144e6ffe9e5sm985043oae.47.2022.12.07.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:44:22 -0800 (PST)
Received: (nullmailer pid 2811239 invoked by uid 1000);
        Wed, 07 Dec 2022 20:44:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: atmel,isc: Drop unneeded unevaluatedProperties
Date:   Wed,  7 Dec 2022 14:44:06 -0600
Message-Id: <20221207204406.2810864-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'port' node scheam has both 'additionalProperties' and
'unevaluatedProperties', but only one is necessary.
'additionalProperties' works here, so drop 'unevaluatedProperties' and
move 'additionalProperties' next to the $ref.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/atmel,isc.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/atmel,isc.yaml b/Documentation/devicetree/bindings/media/atmel,isc.yaml
index cd6d7af0c768..dc8aba698d78 100644
--- a/Documentation/devicetree/bindings/media/atmel,isc.yaml
+++ b/Documentation/devicetree/bindings/media/atmel,isc.yaml
@@ -45,7 +45,7 @@ properties:
 
   port:
     $ref: /schemas/graph.yaml#/$defs/port-base
-    unevaluatedProperties: false
+    additionalProperties: false
     description:
       Input port node, single endpoint describing the input pad.
 
@@ -77,8 +77,6 @@ properties:
 
         additionalProperties: false
 
-    additionalProperties: false
-
 required:
   - compatible
   - reg
-- 
2.35.1

