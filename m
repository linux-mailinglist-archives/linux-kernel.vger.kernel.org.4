Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473B6C32A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjCUNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCUNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:22:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478FF28D0A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p34so4524467wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679404907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yi0KT1ucsEEq66sYgPaMAK5HL55WHJ6vgtRsWKkAHtM=;
        b=JB7XGFDzIDid9vsQpfA3Bl3NiozSqrKT9v5M4OsEXJQe5SmDMsQODyh+SorjHZeFE9
         DrJCz+CaSIZPOKS1RJvCBHrGvFKoxo7owHUgLlEEmn9eIgc4cEOsN7nKwmiYZVAbWcy/
         xhGJ/XZB4XtNqs+4Q2Pl+DBhtUAWUTBgzhd1Tk9Fp6E6xoWg53llf9djEhynyMBafeO4
         aAbrM8alMlnjQKuCnxG66pdTz4E+Aj4SB1lClMw15M++iR4TqziT6VGCERz+3F7mvTHF
         xyTwO7+5Nj69AH8B49oNSyK+ej+Gx+e+AAedn7zPX4G9j+ad9XsMfTClTHZaG3/Oi9hw
         KS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi0KT1ucsEEq66sYgPaMAK5HL55WHJ6vgtRsWKkAHtM=;
        b=Pjqxe9voZpb7nbTtPv2A9WHRFqbEOXzNwpdocBMdd3BUCgSgccUsTjXLxMPQHq32jV
         YvC3ihnGU1D5vekgwhZASnVi9p07uWJBWipYP+VGBFrUfsnYXw9D29p3fnryVXk/z9fv
         bh+AtRDYN1oapfEFTe+gzjQxLg3crv3PlB7sn0XX42KTGa9hYdEp3WYUHjxHIL7DeynP
         zCcvdX8GUO0zDcmbvbhqKUn7D/mX3HSzF+yCdXPjAnFmNlCgHbVJfLsjRrNMQeBZ+g5q
         psUpMtrjS9kbpGtzW5dhsJvkh8rFMrZcSo+ykautjiL0o/xCho/YpG/+JRo3Cshf7yHZ
         IR7A==
X-Gm-Message-State: AO0yUKVrGWdDMhXHoonNnHgLMkv3QPwmbaLQxmwvIzM+YY4PYWihmeGP
        vVL37oN4r47nwRh/Vm3GqERDiw==
X-Google-Smtp-Source: AK7set9tb2ZHl7NAzZFYjD55SvWirpj9yL0EHm1WRCF3enkmy9friWoN7zlqodYAW/VoDArhK+2ODA==
X-Received: by 2002:a1c:f70f:0:b0:3ed:ff92:dd2a with SMTP id v15-20020a1cf70f000000b003edff92dd2amr2452382wmh.12.1679404907264;
        Tue, 21 Mar 2023 06:21:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13393016wml.43.2023.03.21.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:21:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 21 Mar 2023 14:21:45 +0100
Subject: [PATCH v5 05/12] dt-bindings: usb: snps,dwc3: document HS & SS OF
 graph ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v5-5-552f3b721f9e@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the optional ports subnode to describe the High-Speed
and Super-Speed connections as separate OF graph links.

The ports property is an alternative to the already documented
single port subnode property.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 16c7d06c9172..cce74c59bf0e 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -379,6 +379,22 @@ properties:
       This port is used with the 'usb-role-switch' property  to connect the
       dwc3 to type C connector.
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Those ports should be used with any connector to the data bus of this
+      controller using the OF graph bindings specified if the "usb-role-switch"
+      property is used.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: High Speed (HS) data bus.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Super Speed (SS) data bus.
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:

-- 
2.34.1

