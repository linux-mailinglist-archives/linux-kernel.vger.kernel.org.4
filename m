Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B37496B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjGFHmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjGFHmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:42:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082D1BDC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:42:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31438512cafso286698f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688629351; x=1691221351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbxOrjdHKbXhlnZ+lfNH9KC2jI6IqoLPXw3l3BYO8wY=;
        b=LV5oFIVWpwFHAtWyQEF9vh5vXnXRpyYR6xiAOOJ8SbAYbIHjPP7epD4KgcUrI2PEPb
         mTJz27Bs9ZLYP4Qa/Klt3kmsPjDGMilSlAz3D0colMBTei4UxUgRArdK84Y3fAxzuXPw
         G0tE/y94iFQH9z+Gxc2YvLWST9mL/AvDpEJYj07I0Q8rrCGkovGxqqXMo42fW+JfK0zv
         Wgzwg9idZAKKNq+rQ5zyBA7C1GzU4Rh18U+n7huD+7GNR/fkc9e665vJkv7gXVaaryNl
         OrHF9/CM6pMQ/hNINnQHAboEovs9o65JsbFnwQmi+mn+jhDPuaCEFRYv7rnKfPYkagly
         3E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629351; x=1691221351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbxOrjdHKbXhlnZ+lfNH9KC2jI6IqoLPXw3l3BYO8wY=;
        b=FAOqqULTxzoPvp9rZFmWa/XxVf4Lik+2ZKd3saMfQifYZKw7JmvCy7Q9M+lWnCJtAb
         F9x1peP1PAvDeHTHR4LCaYZ1Ts5NbQdFDi6ZU8fLzlqxpPIXl/lceKzwveQ6ZOCafcsO
         cMf0NAdrqj2mkRLK1sglRwLK/ROi7YshNa0dam96C9LX5t8EGDRg3Znc+2NIlQLVgj7C
         wjOrRUc875E/LI85JgLM/fDaI07Bo/DNA8E1rwVABTKH11rLF0HAZBYTxmRpiYcWKNPS
         A7PzaWdIPDt7AJlLTAPOdc2a9Ync9UZEV4QMMpnsOwQ/PZEesnO3LPdMKdIL+Fuf99Wv
         KhOQ==
X-Gm-Message-State: ABy/qLY8dPlfCuyUjCvib12kP0YpBL74y6RNPR2qYB3nbqWcYE2odbvt
        8M2c9JatZlFrjkKS1XdRECb/xw==
X-Google-Smtp-Source: APBJJlE78Dpcot4yN05l8xxI9dJuyq1KKsR5IHRaiwqI/bl8PWsDff2pYf38Ywa82zxVmsHAVbKHPw==
X-Received: by 2002:adf:e505:0:b0:314:1ce8:a0a1 with SMTP id j5-20020adfe505000000b003141ce8a0a1mr692157wrm.17.1688629351386;
        Thu, 06 Jul 2023 00:42:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h5-20020adffd45000000b00313f07ccca4sm1076798wrs.117.2023.07.06.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:42:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 09:42:27 +0200
Subject: [PATCH 2/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 allow gpio hogs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-2-fa442d5aae91@linaro.org>
References: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
In-Reply-To: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=954;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=W+4PTPflVuY/VTPXicH0ipZFRZr1GRfAPhtre5st8GA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpnBkxZQgeadpyhxnLHE7dGXL/a2+0lVvPpA4BWOU
 JGKwGOCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKZwZAAKCRB33NvayMhJ0ZA+D/
 0S0mjbLMqRomWDtTETONTeNmMXhWFdiOqk2iujAavuJhICbhbBSGXgUhXEH5oOGRmzKySeDSLjBZEI
 JX4vq5OcTI19LQzLFG274URpzZXfXwE4gctZTORzPebDLjd/E3l99I5jFVZGxU8L924zd8PhLI3xei
 VbrhEuOIQupf1teWOzlgilrKUeTNipmnDiuhqlOCak7iHoM2nFN4aM5K7t0S57qk7ZIyorEJhcDVml
 ZfHdbxo81p/pl7vPP+1LxQO6YkMchSAdlAOAELBVYppuuy+udGbSwwqJkQquyRL3t5kYfng4EWVx8S
 XjZo+6E+3P3kQdrqVPGjyiygaOWB6iaARlNFhFSuog854zEPLpyk3pqALyRSHGz1TBFJIQn1tyzs/E
 X7gplFT75ytW1PyWh/tOp3x0Gw1tfVvlk/akmhUitpfCZnxTZDNxRkfc7kd1LlDrgloPiW3JTd0XFe
 wdCN8OcychuGSg8dxvKJmNl6puE0zHHENdHC2p02G2i+Bm3aPey5gZJruMdr6kpyQ0yRxRvHG7I9i6
 kXT6HRG0Wgk3jHr52ym/3H62Bh0zfVYovOp6ZSDUPitWyNCFfS/oqH1hMvbCB+1kwUN1AagsdzHN7d
 cpjd0ays2SRMU3hRJskBX/h3yd+6/g9GW9fFHNP+gpw+fmOSUkVB4lElK+PA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow gpio hog subnodes to the gpio subnode.

Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
index 28659f0389a5..d9a8e12bfb7f 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
@@ -42,6 +42,13 @@ $defs:
       gpio-ranges:
         maxItems: 1
 
+    patternProperties:
+      "^.+-hog(-[0-9]+)?$":
+        type: object
+
+        required:
+          - gpio-hog
+
     required:
       - reg
       - reg-names

-- 
2.34.1

