Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C320070139C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 03:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjEMBFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 21:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbjEMBF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 21:05:27 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877522D59;
        Fri, 12 May 2023 18:05:26 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4QJ6r55kz8z9t3p;
        Sat, 13 May 2023 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683939926; bh=jmiPjcwa0rm/jFzhpVA6NzDnRYwG9Al7Px8gaY1MZqM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MgsXNS39exjG56LOPioXveUaLSwI4np3ui68z0BkNcrIMlECmcsVs9tCfhAnwgEYE
         wiOq2LIeNoO1aDy84r5k/N1N7AcJ2C77aKhFaPKV/oT2fjDfpwfJWY7URtMalAgWRl
         boRMFTAS/ZtIAf8blOFUhKqYLk6Vp2uRObI1wk60=
X-Riseup-User-ID: 6590AB7C6FE4E8300A43791B8305EDAF9BE83506AEADA707E796E54DC187F5A0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QJ6r32F2lzJntJ;
        Sat, 13 May 2023 01:05:23 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Sat, 13 May 2023 08:05:04 +0700
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Fxtec Pro1X
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-fxtec-pro1x-support-v3-1-0c9c7f58b205@riseup.net>
References: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
In-Reply-To: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=danct12@riseup.net;
 h=from:subject:message-id; bh=jmiPjcwa0rm/jFzhpVA6NzDnRYwG9Al7Px8gaY1MZqM=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkXuJP/Vj7W+L5wD2mUZGRXR05q6n//HbXywOjl
 2qZ7bOr2LCJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZF7iTwAKCRBmyrfqpF3X
 gXV8D/9cCvADTaberio8N8QGuJUg52DuPGeqZI7sAGRhVf7CLtrRtaNqpxaWK/Lt40KLTywZNTz
 xLHwgFFDdFh6LGpxP6aT7adGcd3EwDMS+wnQvNZ1t25bCCiWcwiYTnPOrtjF2WDUNk68N5PX+1S
 KGOd8u7yfDmyLu8rVRFCXCnCxuCqPlWGqrYtaBM+oook2y24aMA0ByW2LwLegqmt1leDRl1mm6Z
 mgADDRnJ/L1JqNZM6lJFKICjZ1JnI6buVCEWGdS31eU7KH5xEiaSNf4H2znMzbkiHDaSmT4Ug+4
 Ch4x3vM7DnLa/C116bmGeZvTrVD0q1aBrhMO9ebP4iNEnr02TmqhXoCBUazDxl4MjO+4e12vAo8
 4fo4nd/DKAjnghHVQX+kO4iPf3n5m9YHWg2/3KPixo2Hnoi6hF1KoK8SyF29N6eIIJPiPUoV87e
 yMGmiwW7eSvpSI4fZ65PeogMvutmuh42LJUpZbDM3zPKk6dHqwaMjOQWwGiXREPdCrr1wyyCQ3w
 FwqoF0hldG0+yaLRE+VIMesfFOFQ6BC+ZjfeoKoMTD1ZGYi982Ls2vdgApPr8edbFdxibZRUzQG
 b2RoYSO7+DphMdy1So0tqTFkL++vvCIBe1pLF7QvkhggRaOk/xUfc7IdQn67GsiNC4NyIMwJ17s
 b9h+cPvcRoVjrIQ==
X-Developer-Key: i=danct12@riseup.net; a=openpgp;
 fpr=F09A933C0FE0331E558CA4E166CAB7EAA45DD781
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document F(x)tec Pro1X as a SM6115 device.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..767e4c22f761 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -882,6 +882,11 @@ properties:
           - const: qcom,qrb4210
           - const: qcom,sm4250
 
+      - items:
+          - enum:
+              - fxtec,pro1x
+          - const: qcom,sm6115
+
       - items:
           - enum:
               - lenovo,j606f

-- 
2.40.1

