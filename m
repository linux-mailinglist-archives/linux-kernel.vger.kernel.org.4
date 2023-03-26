Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111D6C9659
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCZP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjCZP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:57:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646904220
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:57:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so26107513edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJiERgJjFmjq6ufszGCigy5Vlsps238BsECxW/NhOGU=;
        b=lcRScbIkrRfWyTQ/AC4YJgKYK83Vd8/4zToYCbMDyukTlg2QUTVeaWy+dmLOdG2dyD
         AneFjgNe41hS7/i2CP/iQ1olGipPY4ii/VqONglhchS4lCEYjJXiG8xCdf9ekarlbcQh
         bOeMesZ8YOiGUsok86tlrATAOymLtdBiV0uniDhazyN5i9P/ttSqPyiSq2A71fUZfZe1
         Z53++3PWgcz/qk1yFLg2keO1rsQXOu8W1ZujwJvvoxP4f+06y+TSGX1s0twEC9s4oFtt
         E0athx/WhxGEYaw3J4wueTZz6gzq/JJRFs7WGzXkJZ4xvEk1/7OZw9fvMDWJzxicbW6T
         Wr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJiERgJjFmjq6ufszGCigy5Vlsps238BsECxW/NhOGU=;
        b=rsPnNw8pR1Za0hblsWqKrXZmn/in+7jz6RnsZvxU/9TDGadYAyoshzS1kX7oWWjWWd
         4gVWgmFuitEyBM0I/hubwkymYHpMgwUfoI9KrnFnFv9GSHaSNtqmN/4GOngfhaFA0DXd
         qGmZaTpyXw0yXEu5QnI2sF/f5zws3/7RB5/LS9nYv2ex0bnl0TasaEW3bH2HIugMTdH0
         RbGBDLFzJr4Og0YfgqX7m3JyNmsIrsMsIkqAPDV5bsH3GH+03TZp2u1BYmwxbMgNw9jO
         57r6sw5NVCzNKQh4ZEDN0igvjCpX/DiCCbQHktABaY8HcEVyrQRgqO0v3TT4Rvv+YM4E
         XzkQ==
X-Gm-Message-State: AAQBX9e39a+RP8OORA1eRadwW8HGsJIKTplvCm3YfCjeG9WvJLbjIkTF
        E+ljTvWvN7lgGD+QyIgWdWXmbA==
X-Google-Smtp-Source: AKy350bnPao5Y9l056DV19xv4Zp+jsbHp3RjqRR6PV+UctItAqokSzyBYgZrLZK3odSc5hO9vj96Nw==
X-Received: by 2002:a17:906:801:b0:92e:efa:b9b4 with SMTP id e1-20020a170906080100b0092e0efab9b4mr10723318ejd.22.1679846241924;
        Sun, 26 Mar 2023 08:57:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id rv17-20020a17090710d100b00932fa67b48fsm11881475ejb.183.2023.03.26.08.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:57:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: vendor-prefixes: document Novatek
Date:   Sun, 26 Mar 2023 17:57:19 +0200
Message-Id: <20230326155719.91780-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Novatek vendor prefix already used for Novatek nt36672a panel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5b7795766eab..5b9dfc8b8680 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -937,6 +937,8 @@ patternProperties:
     description: Nokia
   "^nordic,.*":
     description: Nordic Semiconductor
+  "^novatek,.*":
+    description: Novatek
   "^novtech,.*":
     description: NovTech, Inc.
   "^nutsboard,.*":
-- 
2.34.1

