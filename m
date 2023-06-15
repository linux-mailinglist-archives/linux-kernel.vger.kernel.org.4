Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6944731E44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjFOQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjFOQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38AB2711;
        Thu, 15 Jun 2023 09:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WDbX3UjNykRvCfTs3QEREQrRGt2ad7TESIiDF4r83+4tJ7WbjK92+3DDSyAzxWHP43
    1YiCuEOW6S16cWK1fQWER6y+1hqsXOju1rrv4Eq378KsWesELScgSWQxWw8tQ8LxkSxm
    hinnhACmhge/RszCkD4bp13gDOlcEKjvGaM9QLNW58ffLXVOBfZElmM7BfNTBdw52Nvi
    icMML5gMtCZw3iveERGsWsTBiRPN3jaJSTc8/8tEePjQ9O+tRYI5EtuoT7yRmZrWxxMz
    /jdLpZ9lldQyB0mVnJ8lqaBTb1G0rAyzMI6XZ1aF83tVTGZSylZfNfiEJCqO12vK6inl
    0+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=c9aS5sWmCuPtCgsAr94zqSy4IkYOQKxc8AhG884H8eMWTov/XrseR+SDgjmARxtgwv
    pRoMfEpIEKWXwTyXp8sNKzV1oYYfPO3SjDNhfcW7CWQiLcdjuIDuYgClGaHFk4Rni8Tc
    Wt/XQ4OH/p2Hou9RA+gNWkf2RJhTnxMwDH+LH/RzxzSdFy1FpIVNimp4H8zJ0da3sF2E
    n9voqgzZs2gkvtOwTw5nJcyozT0f9vi7tlNe8Fhv+p+pEvSIDRp/T9rGyIkMAEldCL0F
    qDMkY0T8OR29Qwk5gSYismGDtObpOxQ7KVLETSg3oW48Ix9oyvTmc7rmjkQXPbF42/3V
    qWYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=KoF3nvwob+IDTEwiktH3boiJsv8Rgj+NCM8psKe3WmelB6tl8vXiKTlqQoibSb6I16
    SCHzhtFCpBwNj59hVf/ux2u/QnMGvX+IZSkxvQeKcIK1Ypf+EWbRqPswb8gV6L7AgxUr
    Y/0rSV+AeYCO7iBS5zKtvi8mEieBxxemgBKwNpphgindHD8F7u/0Dw4tmQxDf4ytWYLp
    vJBvw8eir1PzPmsCY9BNMzmswC5V6zohpOiUtpopzTahBEiZJn5dfE8l8fQTN1GNocCK
    Ipq539PP/Pa3+kFYpOLEY91aBX0iyv1OB9OXaFUT+OC/pjcLDGeH/B06qbM4GP7AgtFR
    HDkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=6p7uVftFzAhJr6+g2iZs52N6bA++vC4kYuzMzupD0zjiSp5/lhoEas2ce6xmX0KEYE
    6dojV3kU2iFfVeYMONCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGos42c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:34 +0200
Subject: [PATCH v3 01/13] dt-bindings soc: qcom: smd-rpm: Fix sort order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-1-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the enum entries are not properly ordered, fix that.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 65c02a7fef80..fe814b991559 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -44,12 +44,12 @@ properties:
       - qcom,rpm-msm8994
       - qcom,rpm-msm8996
       - qcom,rpm-msm8998
+      - qcom,rpm-qcm2290
+      - qcom,rpm-qcs404
       - qcom,rpm-sdm660
       - qcom,rpm-sm6115
       - qcom,rpm-sm6125
       - qcom,rpm-sm6375
-      - qcom,rpm-qcm2290
-      - qcom,rpm-qcs404
 
   clock-controller:
     $ref: /schemas/clock/qcom,rpmcc.yaml#
@@ -84,9 +84,9 @@ if:
           - qcom,rpm-msm8226
           - qcom,rpm-msm8916
           - qcom,rpm-msm8936
+          - qcom,rpm-msm8953
           - qcom,rpm-msm8974
           - qcom,rpm-msm8976
-          - qcom,rpm-msm8953
           - qcom,rpm-msm8994
 then:
   properties:

-- 
2.40.1

