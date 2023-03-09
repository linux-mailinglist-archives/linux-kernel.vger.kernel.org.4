Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9E6B2564
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCIN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCIN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF932E56
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so3397887wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w5YJNTssgBv8u55ypKuEFSDlMhiWHrbRkco6fVeq1c=;
        b=J8unWiwU9kITAp0QE/pEkkm4DsQtEsvAs0uuH7bN5OggFOQINCj9mFpk3ZIrgEEajN
         jHX9QjpCN4tDhS7fcq3HYDfBvvbc6YMvNTBAPqO/j10thX1ZV8vwHP6R4RzzbBrDE5Zn
         4hVfvmT2bZ5eU8xWBjBc6RmMaEm83gZqQHvgziCmviV48NzvjJFBPNbznYKcKsFkgCOo
         gvTQfaJH1AWYwBA5BnrhGXjEdYI7jloC06OmPfabO5Fg+rLyc65KLMN7pr5igvt3JM/x
         cYc1kYE+g7+MtAOWYZTIUfOXat8iNT9KPVZ3RbToNSuQDsUkXMd6KQpwdInGKNgLrZR4
         RXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w5YJNTssgBv8u55ypKuEFSDlMhiWHrbRkco6fVeq1c=;
        b=R6maTwT0w7B3gU57Bfg3czZJrRW7fhrvW5O9iaXXTng+I3D13vuMVlBDItXN+Kwrfd
         bPjBT3eg0BbiFqZ7tra9tY6P1wCojEDz1nPRFwubK/MuNYTNNO+0RkGfuxAwv0uCIl3u
         HQLfNA744kKSwdqJ1hU+VS1WhZcnV5x4Gz1y34U6AHHJpR7EsXTge5yc8YRua9Xyv/D8
         cmoqBtqO6l5331Ahr3AinzQiEm2o3SIX7vzmKMfqGs7ixRzjNhsUUsYwiMpdwob2a+pP
         kfWjHXoxgAyDG7Rbsai1pUTN03ZJTR6D6liCCDAielwBryCae411VzXFdEBuVNyspnWj
         ErMA==
X-Gm-Message-State: AO0yUKXwtl8PaSygMnkyh5+SLWIzKB4WZXBJ3L/SWDKvoyk2lPhUNCD8
        HtYhorIa4Vw2+D8uoyg1ntLGTA==
X-Google-Smtp-Source: AK7set9wq9AX2OiBgsz3kXj5TpqB/JZe6piX0HPhLJXd3P/qzogAFILWp5NR8g4DOsuEmlr2FYfxaw==
X-Received: by 2002:a05:600c:4593:b0:3eb:29fe:70df with SMTP id r19-20020a05600c459300b003eb29fe70dfmr20919481wmo.35.1678368486067;
        Thu, 09 Mar 2023 05:28:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:05 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Mar 2023 14:27:56 +0100
Subject: [PATCH v3 05/12] dt-bindings: usb: snps,dwc3: document HS & SS OF
 graph ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-5-4c860d265d28@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
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

Document the optional ports subnode to describe the High-Speed
and Super-Speed connections as separate OF graph links.

The ports property is an alternative to the already documented
single port subnode property.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..bd77096f4fb9 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -365,6 +365,22 @@ properties:
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

