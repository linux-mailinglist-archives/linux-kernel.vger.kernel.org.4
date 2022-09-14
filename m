Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6C5B880D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiINMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:19:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DBD8034E;
        Wed, 14 Sep 2022 05:19:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d12so14940587plr.6;
        Wed, 14 Sep 2022 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w1u1QjgfZ0N9sUT1Wc6TvU2kFDl3IhIVmb6A0VsNvkI=;
        b=hr/iMAUXe3d/YBk7uEmQUV4szBmzI4eJ6qlNO1hTZ5p/lVw9COZgEpBbCAVvmHt8Ck
         Ay0z6wAbj2flZSQEWv7hvx0OqD02MXK+lJS9KwzXrAkBt6apy3g9qyXvYjkCdLzMqVwN
         vbPK2kx6kyC4q3bdoeIIQOgUPMFHwSMuvw9+SIc4CzFquGWCWLRlaT1E3H128ldEAgHg
         VVtNHi/TNDPstbDNSgO8qhBrKjWeocYRFgA5DhWh7nt6M/FGzhPr4aGqQhYB2+JjMKB1
         /nF5Ts8VshdzLKGvd/+Py5j8Cj3pA+3m5GIeH2G4dDymvpIJtGQrwd6/TpkoCiN+vQ32
         Z9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w1u1QjgfZ0N9sUT1Wc6TvU2kFDl3IhIVmb6A0VsNvkI=;
        b=BGugZTHT8LLuzMqHaew8QkhpzbbbP05IsYWArHw8BJlQ5qCa8UD+EDwd79wdQL67Xe
         MeJWK0beVJ8pnVaQ/PID/bpNAAQRMptrK1kY3/bGmOFA8OKHgqkUJW3JChl3EYb97S84
         fCGi++etOoMyeFOiNp+0/yh+Ln+eX6vX5li9rs7qwNl0Ehc64PGdYk4kUlTJZJbMmLlt
         3aFQXvMqkjbT7dWQ/bdj0bhiL9C08+ABdLeH7vnbKpOmGFByP2kQyImw/veL0qqRcjUO
         nmfvOfwUf/MmD68BtclVXpLs6eR7AsRRDaWuuknJaS9oWNWdRmRZcNZo61m/oJxRjKmV
         MKVA==
X-Gm-Message-State: ACrzQf2iUTtzl+bu9ISm6z+F0tfe8E2mo5LeeSm9sqRQST7q3mOdbvRH
        JlHZKePEmxeCJicb3hyCeiE=
X-Google-Smtp-Source: AMsMyM4sICcuIL9HdwoRkkEzyRd5zQpiv5IEkYNBp2LxG8TS3Tw3nh/DMyF+q4aySWwCKMo7B2X6CQ==
X-Received: by 2002:a17:90a:b305:b0:203:d59:6ff5 with SMTP id d5-20020a17090ab30500b002030d596ff5mr4503332pjr.166.1663157944270;
        Wed, 14 Sep 2022 05:19:04 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-145.dynamic-ip.hinet.net. [1.171.4.145])
        by smtp.gmail.com with ESMTPSA id c15-20020a631c0f000000b0041a6638b357sm3844176pgc.72.2022.09.14.05.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 05:19:03 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mfd: mt6370: fix the indentation in the example
Date:   Wed, 14 Sep 2022 20:18:56 +0800
Message-Id: <1663157936-5010-1-git-send-email-u0084500@gmail.com>
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

Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2:
- Add Fixes tag in commit message

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

