Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3822874EDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGKMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGKMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167F310C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so92144921fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077908; x=1691669908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wKqZuebC0/DNlU3YArXv0CU05fgiLNPi4ZrsgdcBCw=;
        b=WKIt9VI7VJ3uXfTMs1BXr+QomiovZ7rSHNtwxKGNAK3FIQdok2JfMO1I7E+ZueunP5
         CkJaXnjOvT+Ln3G8eLhAghX4R+wvEBRMbfW/7al/oHjA50IrXBNdY2F0tOFX16rcRJGq
         KmHi9fSz1G2Ho1uPijA4gQ3wUPBoGR/vsSIif9vYrvnJ+V8rI2FpRfSkgyG0yB2JLp6y
         g1lwIGmDPNtyphI+qKGqbiMmP5w0qAyKBomC5K4TewkEs93laxZmkPhMLnFzHNA3r6TU
         ojuJ60L0sWrXaBvwoFj7n0SubltRpRjnVfONXK2Ok2uWrpd+taxvpMN5D/ixeQtiUmEZ
         jTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077908; x=1691669908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wKqZuebC0/DNlU3YArXv0CU05fgiLNPi4ZrsgdcBCw=;
        b=mF3uhx5E7pTJDxk4XBytyulOOsFRT1gPwHtKik9QUOtzJjFz79ClFi/umeQksAdHA+
         pShlVtndvDX3xImx7GZo0kAyljJ7qajk5eMOQQe3GHX6PBsP+yAUxLWP7H2/wMx8JGah
         fnxoXj4hpUviqWX+Zbhjc+nt1wTsBIY7TRkYfB5xwLiHnk3jyjZQFyaLDvoAy+zYYsoP
         zt9WK0RGhmZY86arJsIZjHSCaXWpMbRXJ1UlLsaSXivL2QoMI1PZdOQ8yF7Qi/kAVvNo
         11/kTxAdQ7tTaDxJA675Ae8h2uuWykD63NeavWgfiEDv2OahAII7iEv4IUgNhjedwQFX
         6MhQ==
X-Gm-Message-State: ABy/qLZuW2ZQmltodH/BlNHaxxLdo7Zfn/BW8Rci2/a6/gp0+xW6gf3v
        pH9dQu9XWBC8kBqG/+pqTjgQmw==
X-Google-Smtp-Source: APBJJlGFkoNLOi418Dus0WqQX99QCX3C7IKzXbumFFa8qic1h0VzMt3LwPo6s6NWOhxVmAEzfz6uDg==
X-Received: by 2002:a2e:700b:0:b0:2b6:e780:97c9 with SMTP id l11-20020a2e700b000000b002b6e78097c9mr12619568ljc.18.1689077908368;
        Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:01 +0200
Subject: [PATCH 02/53] dt-bindings: interconnect: qcom,bcm-voter: Add
 qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1777;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1YdtkjCpwqfCeGyrzm5y0lnW6+XAD6b/nL964j7XiAc=;
 b=xos5lY2485rsc/Fk8rtrxCyUPIzjqnRyhiyLpKu+58DpQKwGajPucJDjZBVy9wi9zJJ9gfdh6
 VLXTFNZnq0gAaPF4VFj/7ocVEN6NJ6MYG26wIQmS+2QDKR9YXajYKvP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to (at least partially) untangle the global BCM voter lookup
(as again, they are shared throughout the entire system and not bound to
individual buses/providers), introduce a new required property to assign
a unique identifier to each BCM voter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index eec987640b37..09321c1918bf 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -38,8 +38,14 @@ properties:
 
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  qcom,bcm-voter-idx:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      A globally unique predefined discrimnator, identifying each BCM voter.
+
 required:
   - compatible
+  - qcom,bcm-voter-idx
 
 additionalProperties: false
 
@@ -48,8 +54,11 @@ examples:
   # as defined in Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
   - |
 
+    #include <dt-bindings/interconnect/qcom,icc.h>
+
     apps_bcm_voter: bcm-voter {
         compatible = "qcom,bcm-voter";
+        qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
     };
 
   # Example 2: disp bcm_voter on SDM845 should be defined inside &disp_rsc node
@@ -61,5 +70,6 @@ examples:
     disp_bcm_voter: bcm-voter {
         compatible = "qcom,bcm-voter";
         qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
+        qcom,bcm-voter-idx = <ICC_BCM_VOTER_DISP>;
     };
 ...

-- 
2.41.0

