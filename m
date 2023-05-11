Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD186FEEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEKJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjEKJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:26:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF972D064;
        Thu, 11 May 2023 02:26:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f42c865535so29051815e9.1;
        Thu, 11 May 2023 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797175; x=1686389175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naMkvWEs3370p81pkc0ToJJhjYw14du+DtHvmy6+xsA=;
        b=X/mP+og+F06qY9A76itoLCfvCOS8gzBQC7Ecst1MjafxcQUstltS8AfWAMMmf/mwZW
         Vd5AVLs4ojGcQtBkLmVjOi1zr9GTs8+/ekEcYqbKQvXnjtP09mj/YdQO9z8X2OnSI5NI
         Epd7XMQZ5ZZek+MFRb4bIMBCUYJZJn4PSNa7566LJNS3wbkH0zSKb5ohuJxKkZP54/L1
         tJ/flLm66Nl/And44PKMeL1tTeYusXjnIJihk27pSlTpj8Cavp5KKKT3UhZwUWeh35wZ
         WUoRhL+TRNEGY+b8h8Vvs4969R79L5BSYemrVFQUAxHFHYxdUZNBcT1UQFSCwVwH4DXi
         6r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797175; x=1686389175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naMkvWEs3370p81pkc0ToJJhjYw14du+DtHvmy6+xsA=;
        b=f8sCwbGF4GkCV1u0lclUkp0FkyP6l9aGKmqvI4/Nn7gobz1vp408OeqV6rIQvZPDny
         7gyfa376HZ6KW+7F97G/NCLebWsVQM2TbC8Dpz+3HE5hdxnOpJ58R//VDyXA25xiVx24
         hIutRLKbT4hQ4UBFktkGGn9Z4kNNsIJa+x3IdAfrteDjlyULSxnQiKoY9BURO+bBzekC
         UBaYCuQWexoeBMTe2LIgBwPe1oyg1xZWY0xlEcQ7bPoqC+TBy/Nkk+CmkNSGBzDotVQo
         fePFxH/hO0rLjmMxEcFM78pDbKCudU/ZGnpimWykihsgXYLHVUdoiBEJCda5uo60o4kv
         RzDw==
X-Gm-Message-State: AC+VfDwg4tVzJwL6hYazrp+RmTP4PbXoI+lzDLlD61ss9IBXz8x6Rxd6
        8mx3YWKQGwrFiqcYY8cE1to=
X-Google-Smtp-Source: ACHHUZ6wbNfWDR4BvMm+/wT6JWheNheYlaqor9hV/81g5ObEOBQeaoLZvjKPDuBdRtaDenDAMJfSJQ==
X-Received: by 2002:a1c:720c:0:b0:3f4:27ff:7d54 with SMTP id n12-20020a1c720c000000b003f427ff7d54mr7570705wmc.3.1683797175139;
        Thu, 11 May 2023 02:26:15 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm25289853wmj.39.2023.05.11.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:26:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Thu, 11 May 2023 10:26:09 +0100
Message-Id: <20230511092609.76183-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230511092609.76183-1-aidanmacdonald.0x0@gmail.com>
References: <20230511092609.76183-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 PMIC is similar to the AXP202/AXP209, but with different
regulators, additional GPIOs, and a different IRQ register layout,
so it needs a new compatible string.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1->v2: Update commit message
        https://lore.kernel.org/all/20230510151542.312588-2-aidanmacdonald.0x0@gmail.com/

 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index f7f0f2c0421a..9ad55746133b 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -90,6 +90,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.39.2

