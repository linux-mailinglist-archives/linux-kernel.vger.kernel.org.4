Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23B5FC116
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJLHJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJLHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:09:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B73D96;
        Wed, 12 Oct 2022 00:09:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fw14so14524823pjb.3;
        Wed, 12 Oct 2022 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6aE/yeSlpqCwXOc17W/RYuPLvzETNRc+g+Ynkpn/I0=;
        b=Ry5AeookqtrVVx3rx+ac4anAVW83jmYImeAAMWIg4BjFTpOiZjA7VuC9w7RWYpOSm3
         MduhLk6qeEE0VfGdT/lwlAM36dNx2/TiTkLfi8ZzqdY96NAZvREZOUXAaDkqdSsHTLF6
         60EP+F/e11ZiwxmzffRA432q2MCjy8P/neVOUCd6O3O1GmRFHS9TmOhYA8cVTGrVPbo8
         ON2aUbmURvGvH83d7aNkpiwbuJPnJvWGyVyWiEEU2V4EbyeUKCUtUPzpub/SqT8CgRjm
         zsrTlLN3I2ku8b5uragm4/pNVLD/DEDte+8jOnj+UGTYuwxacEQAODhIRszHSxdeY21T
         iTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6aE/yeSlpqCwXOc17W/RYuPLvzETNRc+g+Ynkpn/I0=;
        b=kUNpi7juF3oIqV4g5YBCGFr3SfLKfefXGHVN0YzpYDG0tsj0XB36qs+9FJhEPAXV3a
         nyke9tr9GMkzfoPIB/SxcPn02jtI5jAV1onXMi40fIpcqTd+N6i8bx1alQ0yn74loG6d
         zJUt3hRk3/RTSmCRAVQsls8pu7z4uw7qvjMJ+VrC6WvaKkdrALKcJIXf3uUTornnDvFR
         x/L11PzQ/e95qvDiCPB4ARkyLQLWoqBqIbae6geKZC7JgDLx9NoiHSSEcr5km0ONOlXY
         /R+MI3XNgUpHs0bpgeV5JsX5iQL6YulfX/JusfqVqSsHEAQ4H+ptH92NlU7paIA1ntZ8
         KFWw==
X-Gm-Message-State: ACrzQf0t7Oz4J5Y1a7jOl3irIAqR0M3MD/zYiJKedu/L1HxSvhS86y9g
        t87z+uDKQcM5+s0ulkpwAA8=
X-Google-Smtp-Source: AMsMyM6bPrQwR4o8Tg5xTHuN+LnmoIfJo2PlT4D3Y7exSshUyvDBB8SzJKz/Bx+eYwbBiBicbC4BeQ==
X-Received: by 2002:a17:902:eb86:b0:17f:f884:a62b with SMTP id q6-20020a170902eb8600b0017ff884a62bmr25664464plg.153.1665558578328;
        Wed, 12 Oct 2022 00:09:38 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-44-170.emome-ip.hinet.net. [114.137.44.170])
        by smtp.gmail.com with ESMTPSA id z13-20020a170902cccd00b0017f5ad327casm9813496ple.103.2022.10.12.00.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 00:09:38 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, matthias.bgg@gmail.com
Cc:     sre@kernel.org, chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3] dt-bindings: mfd: mt6370: fix the interrupt order of the charger in the example
Date:   Wed, 12 Oct 2022 15:08:14 +0800
Message-Id: <fcf4e7e7594070a8698dc0d4b96e031bcaa9b3a3.1665585952.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Fix the interrupt order of the charger in the binding example.

Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v3
- Add a 'Reviewed-by' tag.

v2
- Revise the commit syntax.

v1
- Due to this patch modifiacation
  (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
  there will get some warnings in linux-next when compiling the dts.
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
index 250484d..5644882 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
@@ -139,8 +139,8 @@ examples:
 
         charger {
           compatible = "mediatek,mt6370-charger";
-          interrupts = <48>, <68>, <6>;
-          interrupt-names = "attach_i", "uvp_d_evt", "mivr";
+          interrupts = <68>, <48>, <6>;
+          interrupt-names = "uvp_d_evt", "attach_i", "mivr";
           io-channels = <&mt6370_adc MT6370_CHAN_IBUS>;
 
           mt6370_otg_vbus: usb-otg-vbus-regulator {
-- 
2.7.4

