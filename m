Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963E86B5C38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCKNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCKNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:24:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAF2C677
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:24:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d36so10164083lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678541060;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=lWsAdtdarjqQFur/mMDi9ZyeCv095l4z+T660auWDWhV71MewhOJF/ddvyXaTPHsAQ
         DgLef6lo3TjpmTctVj7+snMnvx1X0QkyCqa5GkiHe51xjF9W3wUghOMNXY4IfKOf85c5
         wJp4wrilAAWwJtQHLeYRneA7LODCmjFs5tFDncB3w/bX8MF4h+vsNsgq6V1GS8jXcu4G
         VIbp4szCg6gK/W0iLPA6fDTHcFWqGsthaeNxrdzqvC5Ft7ktj5L7YLsnW0Jm4vBd87nc
         hTCgeG6cRu8T9cKjC4iLFkUZaNs14Wjvfi3tPdkoRJ5r/hckt9bGb6x0zI5LdEpY3cuC
         VIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678541060;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=BNTU20estljCRTjOJukX9PtCf00I68QX064O7pheUSgvOA3daiwHVOqnAPNxZmdgnL
         MAZXeMNn8JwR2rSAbe4L/0HaQLq7UXOT9rwWri69ywhTJIHM85S5ghT9lZKfLTYSwX1V
         PoHIFV8JwN3d1vzpqy754ZxgN91dG/CW0G2FFH7UaqtN6w+/bJwIUVPgi3QZHBxq5RYP
         4gd7jygvLT3v58ULx2B+IcF92iuY6ZI8iYu/X+dqEJUCIh4aV1385no2gAha98AXK+v2
         NymW0SCz4W5yoWTKENdyKG9QfR2v0KXqTSDgVvLlnzMFTjB5tqELxltg+xpvpozB1UVw
         D+Bw==
X-Gm-Message-State: AO0yUKW77HC2RLM0PUzsXBq8iN+jSgWIODdEcIyY+2dDL9+RRrE/337e
        cntCxMKBJ9OyMF8JnQSHK3Vr+lAHzzQOvKb2Mgw=
X-Google-Smtp-Source: AK7set99115xmrT0FiUiziW/oFNYuFDqlv+NiJnbQnSS25uBhJvlpani2x+juJG6YKQq5DTogCEHKQ==
X-Received: by 2002:ac2:560a:0:b0:4e2:523:4451 with SMTP id v10-20020ac2560a000000b004e205234451mr8946130lfd.9.1678541060382;
        Sat, 11 Mar 2023 05:24:20 -0800 (PST)
Received: from 0001-devicetree-synopsys-dw-mshc-common-add-fifo-access-3.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id p23-20020a19f017000000b004d3d44bb98asm313693lfc.270.2023.03.11.05.24.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:24:19 -0800 (PST)
Message-ID: <640c8103.190a0220.dd54b.0b06@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 15:54:22 +0300
Subject: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 8dfad89c7..2bc5ac528 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,12 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  fifo-access-32bit:
+    description:
+      Specifies that this device requires accesses to its 64-bit registers
+      to be done as pairs of 32-bit accesses, even on architectures where
+      readq is available.
+
   dmas:
     maxItems: 1
 
-- 
2.38.3


