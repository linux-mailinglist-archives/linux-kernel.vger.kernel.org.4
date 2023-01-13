Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01F669D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjAMQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAMQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:08:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221E8CD0F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:01:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy8so53218457ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiVMyw3ShTSsjcgREyTozP7NTsqhHELi2VMVaQ+4uc8=;
        b=B7L+d+YkqnqVSQPmpmeYlcJT8l0WFzx2YfPoDzpZbiA27BHWq5dawrNrazLcFecBp5
         JAqwJpVGX3i3L6OCktX5/iYdLvWuVxXudkA6QZ9RN/tHjT4HNu5mDYcuZf0NLXSG8IqW
         DGUqqh7nnDbYfjrR3wRMyIWYh5WxAMF+SL2Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiVMyw3ShTSsjcgREyTozP7NTsqhHELi2VMVaQ+4uc8=;
        b=5Jhbq9TxBq2nh1iC2dWx1YEe6baFseqHZhUwASx2cWVY5FtIj5Msp0jPg6gX1ky4c3
         pAD5Ip19R4TpJGWsMOyYXuNVR8cr0BjX/g3RcLiHZAHcsAKkEvJNv/pWwoKm2u1CMqlV
         4eJH/jri7GBwn3l9Q1PCwmAOj2FSzYIbdwngoFLaw6QZljPVXoRsm6SagIG675wCgYP/
         8nxLl/MujygZqq7FnY5nwXbQynHdt45N9hzzDc1bG8FyfOviCwrpiJIyoQoukCx2nrRw
         5L8kxiIBVPyabTd6pGfHldGKG27T5H1zxhOj82vLHE0tenYyrZS4AP9LpztKfZi4y+ky
         ThCw==
X-Gm-Message-State: AFqh2kpCztNb1PLfynBdEi6K768FhBbwPZ4vUxZIp42wK9/6CcHs+dz2
        6vx74JUfsx46jlzPrj+0l1HjCg==
X-Google-Smtp-Source: AMrXdXuyTbPySkmacxw6DzFlYpr8z/QbS3eo2AH3jmhS2o2Sz5qmce1w2Tte3/BMpcAn7VFmwM8FOg==
X-Received: by 2002:a17:907:3f9d:b0:7c1:1c4:5eaf with SMTP id hr29-20020a1709073f9d00b007c101c45eafmr99605990ejc.49.1673625695802;
        Fri, 13 Jan 2023 08:01:35 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b007bd9e683639sm8637010ejj.130.2023.01.13.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:01:34 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     a.fatoum@pengutronix.de,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add Bang & Olufsen a/s
Date:   Fri, 13 Jan 2023 17:01:02 +0100
Message-Id: <20230113160102.677865-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Bang & Olufsen a/s is a Danish designer and manufacturer of high-end
consumer audio and home entertainment products.

The vendor prefix 'beo,' follows from the ubiquitous product naming
scheme, e.g. Beosound Balance, Beolab 28.

https://www.bang-olufsen.com/

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621..00d2806fb13e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -186,6 +186,8 @@ patternProperties:
     description: Compass Electronics Group, LLC
   "^beagle,.*":
     description: BeagleBoard.org Foundation
+  "^beo,.*":
+    description: Bang & Olufsen a/s
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.39.0

