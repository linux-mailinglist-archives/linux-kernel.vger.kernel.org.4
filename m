Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA267E2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjA0LJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjA0LJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:09:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3EE196AD;
        Fri, 27 Jan 2023 03:09:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t18so4665000wro.1;
        Fri, 27 Jan 2023 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isAaPgBeDdcHxcgXON9D9sIMsPD5VNAr8JbS+XxPvnw=;
        b=onA6YQq5/uVWw7YaxNEnf5K6JGQj0hA2+dIlYS8+OPNSL6lqXdTMos5iOw/I3W4ltO
         /nrrafXlkDxBlkKtUnWX7ZRyr9NfujL6IzZNaH5wu/87HKtZhE6kABZ4HoquwOKJ8R36
         SUFixppOFQvMviZkPNSfhOGV+e8dJMlFSqFDrs/3AayDPvzAjDuMZlMj/70RsWwmuJ4h
         NiFyBiDEjib87eg5ZqOK+EovtXvxIGBtXZns8uu2AEe5pMmZfi8cb2oB6/nPTK3LXYEZ
         gkI9QkeIj84hy2kGCu1SV0IwlNEqWCFI4YjMYCIYK+DGQEx9obvdfz8ZIJo/GEtrV0Qq
         FUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isAaPgBeDdcHxcgXON9D9sIMsPD5VNAr8JbS+XxPvnw=;
        b=klAtIYemGn2Tdd9PC+FV5yLrCsUNB5QA+rPv0lnzcY6U/34I2KNk1haQtvpYyYNJHq
         w27q0gI2flqrxWAYFndD1mZ9typHk6gv4dh5ePMcWc1bpYEj7oRBEO5mEuDITkwJt/vx
         MKNyj5/IGQgiyeWmi+MiOp1r3E0j127h8wgn0p3inznA/txBpMA07uNsRB9lcaaR4Ckt
         E4j/7ecNtXRZHZ8EuqnJnLPMystSmwbgPrYzji+8pOuVW9RN9zeHU87jfxRoeuzeeI/j
         191T4iiFN6zHdR/rw4H7aNOccuy0xI3lGxpXQeuSGh0QpNNZo9HTkA8maMuD9pk3YjwJ
         xiuA==
X-Gm-Message-State: AFqh2kozAobkJgw/6k7wOue37D5zdBdm9vUbZ0euaAZIg39szjD3xtGz
        BHq+Z/7J+IQtz65bG5qOrcs=
X-Google-Smtp-Source: AMrXdXsDpz6xvjzOlbveXGOY9ueHKhX8OWw+Xd0swYVWFPnwkqCcjGgjSJiOH9ZpVy79L/lK7SUb+Q==
X-Received: by 2002:a5d:5c07:0:b0:2bd:fa1d:5291 with SMTP id cc7-20020a5d5c07000000b002bdfa1d5291mr38022885wrb.67.1674817773386;
        Fri, 27 Jan 2023 03:09:33 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d7-20020a056000114700b00241fab5a296sm3662106wrx.40.2023.01.27.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:09:32 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Radxa Zero2
Date:   Fri, 27 Jan 2023 11:09:27 +0000
Message-Id: <20230127110928.3387654-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The Radxa Zero2 is a small form-factor SBC using the Amlogic
A311D chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 8aa6b6a92c29..6e3cb5a0d879 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -154,6 +154,7 @@ properties:
         items:
           - enum:
               - khadas,vim3
+              - radxa,zero2
           - const: amlogic,a311d
           - const: amlogic,g12b
 
-- 
2.34.1

