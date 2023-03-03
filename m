Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2065F6A9DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCCRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCCRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:38:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6312BE2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:38:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso1709665wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677865080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuwYJdAluAVqq0350ZDdjBaUb0ds5oc80wUc9O3dgIc=;
        b=IEdFjZXlGFiOHSA4JXDNHZx7kwV3q0QQTFC67jh1aPJwQ2OS4IrnaWAL6JlEW7nJNB
         xsyDJyFt6Rqz2baaYacVM+BX2ae9UyWTVRByhOnCM+w6Z/QvDJfDIcpZrcw1Y0EkT3dt
         Vo9KrkNRHOvuPFFHd3NTupJLHlHRhY9Oxf4KZC5NLM899BpqJBZyjWwpnwyqqy17KwBH
         Ta3KoMXT4M0meBUZfWB0BIOSTxI9qKs/MFO/G8UjaIzwzlELMgWK65O3vkL3XcKO+EcZ
         o6WgBs9eDyf2EZTqnnf140V3U3ujQNNyYi/oExjMGAoi5cUL0O3V6u5a5Zl3GaWzxePO
         7IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuwYJdAluAVqq0350ZDdjBaUb0ds5oc80wUc9O3dgIc=;
        b=rBKTz/ifIGgTYS/5pKG4dSJiXjSoRW8hM0fg22+L7BhzuzT6Qsp3gK8FXTPUhIA+E2
         8UjLWRRfXAgFeYmTacyCTsT82b/E3jixIHFwcehgRAi5r64B8Fvp/simX2ndefUFi/1B
         YrlQxKiogeOwQYGGjRy7arMXNlGYekNUQ7YZozhdvwsMBenlr/KEO+2LzMwyk1mxJ9Fj
         tRHYSb08p78vEKHiISlt0UCZK4cK7rIyAHu7u22gkkeG4qOA8J+w8K4DeGETmxI8Q/1L
         Kr5trpJ4UmVWRc3EooppbLuVfhXgrtrm2XpPROG5nXAdZbCQAJ1B196EL2PyFEU10Qmu
         2pAA==
X-Gm-Message-State: AO0yUKX0r0CsZz/BuYOmhoRHbj2u3eF/vrnc/5TFlH6guC/5SCf4g2B+
        S0uvx+kRykEIL2NBh6tImw+ix9t7zaT757VVd88=
X-Google-Smtp-Source: AK7set9f8opmU2oD8npox3kSfd6u28Xe+s4D2TT5yG6JKLEWheOoAxQ+Pw+UHBu0i/zqnfmricm+Hw==
X-Received: by 2002:a05:600c:34d2:b0:3ea:c100:f5e7 with SMTP id d18-20020a05600c34d200b003eac100f5e7mr2261025wmq.39.1677865080297;
        Fri, 03 Mar 2023 09:38:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c161300b003eb5a0873e0sm2990170wmn.39.2023.03.03.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:38:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 03 Mar 2023 18:37:57 +0100
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: Document the boards with
 the BPI-CM4 connected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-amlogic-upstream-bpi-cm4-v1-1-5a23a1ade6bd@linaro.org>
References: <20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPI-CM4 module with an Amlogic A311D SoC is a module compatible
with the Raspberry Pi CM4 specifications.

Document the boards using this module, by specifying the BananaPi CM4
compatible in addition to the baseboard compatible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..4e5ae70db4cb 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -158,6 +158,14 @@ properties:
           - const: amlogic,a311d
           - const: amlogic,g12b
 
+      - description: Boards using the BPI-CM4 module with Amlogic Meson G12B A311D SoC
+        items:
+          - enum:
+              - bananapi,bpi-cm4io
+          - const: bananapi,bpi-cm4
+          - const: amlogic,a311d
+          - const: amlogic,g12b
+
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:

-- 
2.34.1

