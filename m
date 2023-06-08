Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5B727844
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjFHHLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjFHHLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:16 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A41BE4;
        Thu,  8 Jun 2023 00:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208271; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JfzrTN3jjW7ZrfuwFaz+gKLBQg4XKZVVYBtregthYkc7xihIpIA9ucQTg+nnJRDAGC
    NYy3nlTDLHcc5m4R81hxnL99VYRYN/0j3bjVTsr/FoQu6CEih8Tkm4DdMHS1MmNG68hU
    e1WLL67M/W6rIjt2RAeuxSn7t6fShQAGwJDQfBn3KyYm41YB2U5t+l0nNCvOa1wLZY+U
    Nin12b8og9IXr1AQDONuPToC4DSA05R51V1KyrR+dfe3mjGFxiBFpI7tHoQcZ+iUzahA
    Euj8dFt+4mn+lJ4oa2j3Cw+a82L9QByNVWa7CrtmJUdrYh38+NniVWYRI0CyoaHsZgOc
    P+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=cosQvJKDkdkrDrAnZ39pL7eZCSrRqIWrq2ImIHTmE8imnFkbHEdFPIji3YJcovwYpK
    GVWc10IvZyIkmnqTXE07wgVDUIIVye7Ker9exIKiFVeftLajLKGgbTGoBXtSJQe/7s6a
    YXUrV6eCmxbhEsW4HRRy2YawP8KoFofBrP1vXFslwoGg6Od+nGXptuNrwBOORju3ynA5
    M+GaaPK5f8baj9TnhhoXTyOxhZbJpF88I1F16JfbzNRLoApUxj0QP4IrvfHHpc8eegjC
    aSX3upPWDLwXnZLvyxNX8F2zb5cmvwrQSBINv2iCs+cnpgreUO6N3MCw8j+oh9RCAX6m
    o8+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=OlVaVGarKokY0C/zxiTpglpS/Y/Sf5b5id7jFoZtQAx6oq2GkKFyfye/GLabo5NA20
    IMtJSeTsG56fFblk0Qr4YvUJOqukGbQLkc2vz+m6Fo6MLGtprPT+2rZBR9/2zVYm2drO
    rR/qORY33n05vRYhXLdyJLC3/YRqaMmzE1So5D6eSHjbhNfAWBuhus7KOyLIG+KeW3vd
    Yn40H8xYG/SsjOZTNW0M69jD/b2Hmfdbguz+7R+FBdUWma7VLyodJQJBSGDBn7PoTdUb
    fGMWP/Q21QbIuZdLYhUVWuv5jQCtoXAXA3lhxRrStVa2l29N05XAhZ1NYlYSjEr6iXnN
    W1Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oE3ou2mgJ08zgiqHPDSR6aNlOJa/SmAfuDKO8qDHnb8=;
    b=7raMcyWZFG/PHwY3zFgQOzjYtUWBqw4EUNciDv+x1eb5Zr+z7To0sR4/c3AzG9oaXZ
    ywB8uw0VC1C5I+JzsTDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BBKHu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:21 +0200
Subject: [PATCH v2 01/12] dt-bindings soc: qcom: smd-rpm: Fix sort order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-1-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
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

