Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC31727859
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjFHHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjFHHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0912694;
        Thu,  8 Jun 2023 00:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208272; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XJR0jd71F+rWenXJM/58px9IFU+DcItyBaqRkBfnzIhiceDI0Y9m7OYqsPn1+Ord4m
    vBpbwPIggKYmbcwTgWsMCt7yf0Wjjnum1PBDCbKzmcfcol0lbcdGsqa1YgZ2W+QG3u/J
    fer1SQg1NZqTXSboe4WWSmbnkQjgFGJuv3h/zDVApyXK4FqjiCiota2Fa52HtkhekRTa
    t35e7KRgNS4UyQNfDpqnMw4/79TZT3PSv6nhtEx+G49UNUXm+1wG4RXL/tLVzYFUhjoO
    zT7mJSB3j04biE0ZX3xEUWeqMERY8L8rfJFxFtbQZ+dqVMIaNhA8LGgzUzT1Xoooo0Fw
    FsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=oAyQgkFBtXgvxRlo6CvoNcxbbtn60cGDHIyEcK0Vr79nVvhr3CT51WLucPuJ06U65h
    1nL8U+lzrz0SZoqgir4I8Wdqv/69/nh//O/iAuS7b5vYBgYsxZTvn4L3Nkti6XdDkjvD
    YEfSpRQqZjQv0vyaLJ1rtDcjo2XjTTwQpZlawlckdo9M+us27kdzTwRG3L5AcjhaBfjI
    Dy5ZaJ/9WRNfO7fFhpRdVwWx1h8SKbYFJiHPyuay5/A2roUT5PjDt5zr0izu6Snd+vVO
    ZJQ+hoKT3y3yG44yR/RbNuJEhwTFQz3S/ApQ7xr+E1GFMVObJkcsC1RH8inrInV/Q79B
    JuHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=p6AP9J1+JEO43kscmbckDGWYjBgA/2NRUtWRlYB8TORWIL4A2v0y3sYVbjPWUn4FVM
    XpNGrV5jpi9pCm7qVtHBT6an7OCjYc8NyCUmHd2i1rJ/1cTGGtgs8aJiQC/fI8S2p9dT
    e/lx57Kys91WDQeMQgVooCJe64sODSd48Eji8eWXwp2AkXyecsywlfV5wxDo4LD3TSOe
    PfNzGFjj1cgmmTbuRsddmkA06qNEQG6MnrMLKaSuzjNgskNcErihhGsKwAp7bxuVGs30
    jok47WQDePvrrvbFB+6zE10U7cojvFJubO8ddKHsWrMC0BCtVwlh9/fNY3OMiJMoGDhr
    zsfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208272;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=Ec6fOHaSbQq7awNDZCZfZYq2wYFk+XwkoWK/B4K32amDtAJdS+AKLPAicDCzrxNfXU
    BC4vt5dlycHx2929ipCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BCKHw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:23 +0200
Subject: [PATCH v2 03/12] dt-bindings: soc: qcom: smd-rpm: Add some more
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-3-56a4a00c8260@gerhold.net>
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

To avoid several more small patches adding new RPM compatibles in the
future, add MDM9607, MSM8610, MSM8917, MSM8937 and MSM8952 at once.
All of these have been worked on over the time by some people and are
definitely compatible as-is with the smd-rpm driver.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 78822315edeb..c6930706bfa9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -34,10 +34,15 @@ properties:
       - qcom,rpm-apq8084
       - qcom,rpm-ipq6018
       - qcom,rpm-ipq9574
+      - qcom,rpm-mdm9607
       - qcom,rpm-msm8226
+      - qcom,rpm-msm8610
       - qcom,rpm-msm8909
       - qcom,rpm-msm8916
+      - qcom,rpm-msm8917
       - qcom,rpm-msm8936
+      - qcom,rpm-msm8937
+      - qcom,rpm-msm8952
       - qcom,rpm-msm8953
       - qcom,rpm-msm8974
       - qcom,rpm-msm8976
@@ -81,10 +86,15 @@ if:
       contains:
         enum:
           - qcom,rpm-apq8084
+          - qcom,rpm-mdm9607
           - qcom,rpm-msm8226
+          - qcom,rpm-msm8610
           - qcom,rpm-msm8909
           - qcom,rpm-msm8916
+          - qcom,rpm-msm8917
           - qcom,rpm-msm8936
+          - qcom,rpm-msm8937
+          - qcom,rpm-msm8952
           - qcom,rpm-msm8953
           - qcom,rpm-msm8974
           - qcom,rpm-msm8976

-- 
2.40.1

