Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488146755CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjATNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjATNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:30:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B804CE46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:30:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3689002wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgsO4ptzjusHFO3gycfIfDoeA9QcARHbIlhsJgco61g=;
        b=BbMMo4XEDehJIPhXkY61MVtSq81hj9asMqcRzlt99iCRLNuu80K2RyKzyF34qTe/U/
         CGFSOnBU76l1GfpgNJSIECNd1a6P9cdsPE2BdJ2HrXZIrua1lr25BW5yVgNy1N2Ji2h/
         cgoOg5SuLj+M9RECe9C7dC2+MVjUcLNNLNF3FbGNmfeSLsELzLvjBRJ9baMMDPbRv1t6
         btfdLQJ8/qR+uBkoF7bsdLt0Pizr4+4Lic1nJFDqZ6z8Ikfi0y52ci274HCC/Ic9I1zL
         lQs4p8JDdkIDlYkCXqf3mwFeCdtrjbKhQcc4SlmkoCmni4mpzLiYPB2/xB0DMD1JmroN
         uTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgsO4ptzjusHFO3gycfIfDoeA9QcARHbIlhsJgco61g=;
        b=Q+iDOcZPcgMhd+uXEnRwAgF7agxXWmuAOkpgXTVXvYydjqzvszN+7RwwBaiOwi4BTz
         UCVvmNl6mf4OTea0O1ACM++kt1r06y3p+xKIKP6OzJWx5BUxnQnpkIqMWLMzDo9SW22h
         zndFgXOvrQxAIlDBrBlrlpOCRH4IOCu8ZDLikFrodfWyChq/6I+fpFf6xU8niR2LYIrS
         3c8XRKYn/aLv/rHekEX1jQeSAuVPNo4RNYn5ywolPLKyKCqmsugTL+WGeVhBVHYEv4gz
         /SPryejCRHzppdrmUQ0MC9MV6l+spN7mGsllJTGCWievvMHFimQzVOMPKYHNMWq4d5yV
         K3bQ==
X-Gm-Message-State: AFqh2kqO5eX1ZIdFvNGQTiYjxMwUAQXna6aAcoKiAqa09MPJBtpbuitz
        WkRXgpORl6cL19XcXIs8peXF4Q==
X-Google-Smtp-Source: AMrXdXsfwMFkDc4wbOov+poNB94l3tt0c4QI+qWq6VvWJ1slp+vb4JOC5OjZhRR3NHAZcP1iJFujTw==
X-Received: by 2002:a05:600c:1c01:b0:3da:fc07:5e80 with SMTP id j1-20020a05600c1c0100b003dafc075e80mr17313412wms.12.1674221413175;
        Fri, 20 Jan 2023 05:30:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4a9200b003db07420d14sm2140424wmp.39.2023.01.20.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:30:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] regulator: dt-bindings: fixed-regulator: allow gpios property
Date:   Fri, 20 Jan 2023 14:30:10 +0100
Message-Id: <20230120133010.299797-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'gpios' is in general preferred even for single GPIO specifiers and
there are DTS boards using it (exynos4412-p4note.dtsi), so allow both
versions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index 84eeaef179a5..48af7cba4652 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -35,6 +35,10 @@ allOf:
       required:
         - power-domains
         - required-opps
+  - not:
+      required:
+        - gpio
+        - gpios
 
 properties:
   compatible:
@@ -49,6 +53,9 @@ properties:
     description: gpio to use for enable control
     maxItems: 1
 
+  gpios:
+    maxItems: 1
+
   clocks:
     description:
       clock to use for enable control. This binding is only available if
-- 
2.34.1

