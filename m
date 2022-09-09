Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E45B3BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiIIPbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiIIPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E189806
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:31:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so1642483ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6pvfiV9+INyHP8EaVtPQ3L9iXK4tIAduG9OAalFumKI=;
        b=hwk1svK+XLopgPNDQPvZJKu/HyCXmOIB1A8uXEuCruJEFDkKPfXEfTKn3DrP2Is4eG
         ZlKFNn226WYx/iEBQwxLJvV7/VBZO5lpkxNOMYKaXRYEeAMXR5i18Zs1kEHBcM67gJIr
         u1zuscueTlI1HpWz/ushy+7rUzoOFWprY7sqdfKySHB0bnDvAdRVtf6yNtrNWVQTRc/g
         g0xEE3VPY4fKF0A21tgXgBMwzfsz8t0xYCCZZgpOFbL6nCLY+y/tBrd2mmMR3+2AHrhg
         q3wxi6mRJdLKtbst0PcJTVSMrSJ/J38Dqn0WynOlhEcI8rMyEFG4eBB7ZXcMgCAEPl/z
         rCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6pvfiV9+INyHP8EaVtPQ3L9iXK4tIAduG9OAalFumKI=;
        b=LxIXBDzmQbHbLVd7XdCIeuyghx2hgY5CptOi9bzGSjPtHbn8mhssSvDN67zgIcHgQF
         1NfDz7J05yYmHlA6JOW+Db6wTjECV//J3lwjNDQ4W0d9M9oHh2lxPDAO5IM1UxH7+O98
         s4m5sKuMoTRxjawFGnsvSZAImzDsx+dMgTptodmDuv9IzVYwjbtZFwjjZkl/oL8bxZCb
         N5j5oLgLrRJ96TrXrHGeGYAsG7D+SUxPk2npHLxjneSUEnD+KEW+FQf72pCo9anmCJZJ
         z1UNT19Bsgi6PNdY6nU3hHsHwb+DkNDgEDDctJnDL9yVrdRbesKYjWrENfIEJk2JN2Gi
         H/jw==
X-Gm-Message-State: ACgBeo2+vgVE+clsIBwWHvgZEGlEUAnARgOauywQkYeA1weG2VfnQRs9
        LqZE5lrHpyg1k9BC24J0Yai8Rg==
X-Google-Smtp-Source: AA6agR4n5KrMjwQPqMuO3rRwLQzPyLiIDI0c8ve44qmA15f6wlpOq4lsqfMl9r91o5ooRpyyA4R9nw==
X-Received: by 2002:a2e:8344:0:b0:263:8194:9a83 with SMTP id l4-20020a2e8344000000b0026381949a83mr4287428ljh.368.1662737444747;
        Fri, 09 Sep 2022 08:30:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0026ac3fedd20sm117314ljr.86.2022.09.09.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:30:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH PULL fixes 1/4] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez
Date:   Fri,  9 Sep 2022 17:30:34 +0200
Message-Id: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
Access denied:), so change maintainer to Peng Fan from NXP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220817065946.24303-2-krzysztof.kozlowski@linaro.org
Acked-by: Peng Fan <peng.fan@nxp.com>
---

Maintainer update for current cycle.
 .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
index 445e46feda69..2b39fce5f650 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: i.MX8M DDR Controller
 
 maintainers:
-  - Leonard Crestez <leonard.crestez@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
 
 description:
   The DDRC block is integrated in i.MX8M for interfacing with DDR based
-- 
2.34.1

