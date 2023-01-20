Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79A674929
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjATCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjATCGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:06:13 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA7A5CEE;
        Thu, 19 Jan 2023 18:06:11 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id d6-20020a056830138600b0068585c52f86so2325829otq.4;
        Thu, 19 Jan 2023 18:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nm7T3cB9z8oAZoiSna2rcEe0UaeO+qhakn6LYQvnBg=;
        b=frdomgPrqMHrb3iPEWbydtpD2Qd4OAbESBTqAuqBsR/QCuV9gk9OLP2djwj6XpUeF7
         AsnhxLK1BZQb6mVzXRUFQJvFRMS/zEDfaOJdbyMn/W43hXy8bKSW9KAYdnXNTJN25WMJ
         WksUZh8b+4AcWzG2XcEjGneRavk4M3ukiceGgmglYT2WgqYn2xBJOidD0Ixsn2n//U9h
         UzzwjGqmxzDqUhbgp5xCYiyXzfDjT1DfQV05chOprzDMce0rgJNtLCDZ01GHKjzIGFA9
         YgnMRzKU77Q9bqL0LtpA1n/sghbfRL3HZ4v0BgQHZJepNg0FTaXoD6h9Q6eGi+ohdUd5
         GrLw==
X-Gm-Message-State: AFqh2kp3oUGez/ldBYan841JgWoQCktpRrL2GrOpSNl90TwNcy0KgNAz
        hRD5a3OkdjHo65zVFKHrCw==
X-Google-Smtp-Source: AMrXdXsZqMJ01fIy7d7PUUBs3Wv8of2EK9yDRO1FLRX2glt4/ap668+v18tGF3gXQ83xxGlxPtfX7w==
X-Received: by 2002:a9d:74c9:0:b0:684:ca02:2500 with SMTP id a9-20020a9d74c9000000b00684ca022500mr4682397otl.25.1674180371160;
        Thu, 19 Jan 2023 18:06:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g72-20020a9d12ce000000b00684ccbfe012sm11506064otg.27.2023.01.19.18.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:06:08 -0800 (PST)
Received: (nullmailer pid 3232512 invoked by uid 1000);
        Fri, 20 Jan 2023 02:06:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Restrict 'mpp' child node name pattern
Date:   Thu, 19 Jan 2023 20:06:00 -0600
Message-Id: <20230120020600.3232001-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just 'mpp' is a bit ambiguous for a pattern. It allows any prefix or
suffix. I couldn't find any actual users, so update the pattern to match
the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 72cce38bc1ce..891a7385d7cb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -74,7 +74,7 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-pmic-mpp-state"
       - patternProperties:
-          "mpp":
+          "-mpp$":
             $ref: "#/$defs/qcom-pmic-mpp-state"
         additionalProperties: false
 
-- 
2.39.0

