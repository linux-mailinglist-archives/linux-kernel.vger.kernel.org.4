Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC05B82DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiINIYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiINIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:23:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C9B854;
        Wed, 14 Sep 2022 01:23:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i19so10385247pgi.1;
        Wed, 14 Sep 2022 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P9iChXnOlLAzZFdNLnY5kfU9Doj3uGfj35dzgStEZMU=;
        b=pE75bF9llgDlVL1tONbpIXNBJPLRnBJ9hkVccGmGOVuo021D3xEEvmTbepvrp8RVQr
         ksUoC0NRWRrNZLspcVVn15dc6H2MMgAUGlezFBxb336KBr2ISMC+Dob4DjGk0FXlLOdr
         WkFcg065fEqebST0Ysnz2LT/kpx/5VLtckcfp7gjjoudRS21JgjoxZbTi+2H4DxA0bVn
         IzKXx6LwUO4kUp22kqP9tM6yPZmYTN1qotSSkGMZmYpLiXRsvbsxLl+Ffm+JeCgEc6kX
         Ux3dTYooLnUEPTySDAWTWdTXIlOqiLvClX3trv6ZUD6Nz3p9d6P+c2/KkvUMvOIaNd7c
         buaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P9iChXnOlLAzZFdNLnY5kfU9Doj3uGfj35dzgStEZMU=;
        b=AibkY6GTBdn/dJvJGddKTAMYr/FYdlk/wBSniQscuBzFrYdhpZir85uxJErRU3hMIi
         V6XhgukqMQm2t7pkMGU6qYyBN3TbiXwj9LpY/3cThQ/ZedYMJrqdR1H7MOMdXW5M0rVv
         WlctsKHU/oG3bLUEFVpAIorU6vfi3gtNgaUjRAVZ1Gl59yUFTYxL8j6e2KweQ6/xVyRq
         1eHepmRduw0gVbNSycD5Dzq4qBbFCwg3Co6/Czhc81PStK/HhbO4XhBFy4M7qniD3V5G
         v1oQ+PEzQmEqFE6W4b3v5v2HttjxarpTeK/ALiaUKhZjQJQlVVpDm5pc/5+vMlQbFyp9
         fAOg==
X-Gm-Message-State: ACgBeo3S6okl+AXzNsQCW/67PwTpiduU/iTzP3NQiQvxVKFW+kS/jsH5
        op4PNCGuf88KW5s8O6Dpv08=
X-Google-Smtp-Source: AA6agR6dE7decz+Ly0pUJByGQRsEwzFqUinIHdNRUA3Q963/UJZSsOEZOG0jYDqSaqN70/rX5SouIQ==
X-Received: by 2002:a63:81c8:0:b0:438:919e:8256 with SMTP id t191-20020a6381c8000000b00438919e8256mr20790669pgd.39.1663143811878;
        Wed, 14 Sep 2022 01:23:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:362c:d94f:b1bb:6842:3424])
        by smtp.gmail.com with ESMTPSA id f8-20020aa79d88000000b0053e468a78a8sm9381986pfq.158.2022.09.14.01.23.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 01:23:30 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: mt6370: fix the indentation in the example
Date:   Wed, 14 Sep 2022 16:23:23 +0800
Message-Id: <1663143803-28660-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix the indentation in the binding example. There're two redudant space
charactors need to be removed.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
index 410e2d4..250484d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
@@ -119,7 +119,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-        pmic@34 {
+      pmic@34 {
         compatible = "mediatek,mt6370";
         reg = <0x34>;
         wakeup-source;
-- 
2.7.4

