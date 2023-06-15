Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247E731E76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjFOQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbjFOQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B82D42;
        Thu, 15 Jun 2023 09:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gL5W6HGm+DTIDs26J7diIqJ6ahxc8NUK0dtOvxnfNOeFIa2CPBcx8vL/0AV7LIlESO
    jKUERNcs1VbRSfUxOsLAUN3hLLVD4GfUssObop+c6LmexmtBbHstaDjhLyp3I12liNuj
    NbXihYACMorI7DhS50flLS3j+5Ap4wWe57b3CZv651oR9zf4NE+1NUWZXY+8Psf7xjfz
    KIq7Qk81KpCbI2p03bZyHDpDhRNBdS8FzTIqjsg0A56JCPfnd6w0Y4ocIKNtOuvgo8eT
    35a9nmHE+JhqSEjcV+uv8CtihX66+i6dYSza2UXLY8RCuPdvDP5uXdQNh5WUWJJK47Wx
    4Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=KrgUppjcHxkg5WE7cw9fNpAAAMFqQTAqR8SOHjITy0pAr1SYO5f5Lfi2SiAU18Jl6t
    3thzseQACLjnFrSSGia5FOojWWabzDMUw+xZrCnFDKqp34025sd9aurXH37syhZKjdag
    TI5sUz51H2lV/8rNngioDwx9ZnGK3y0i6L9ZmmH24FNhP1Uf1iit4EqLdLtIBTICvwwN
    8PtDpt7gFymaBhPAPv/lLMKG3ebRWpdI/eKxfhjaGXYcatzAEy5sVhJdqKOS0q2TKV3V
    OIZxAkqimftxTzKI4m+E4osBD6xD4t7dVkdWeb2VSstrOjLSZaHyONoD1oDGXS28+WA3
    GLoA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=aTj0sHUsJuaVXUyJVIAorOb/wyapVnlQrPkyvHmDsk9xDELDzn8LE7nIBjBv1htvCa
    jjmNq+siJxl9B11weexfCtWW8OksZa6gaDdlH9tm/xQvo+hakh4KTdbyJFHlFzDJd6+i
    lkUfjw4IyvMiM6dxOfWt9NJ/59WOY82hERBpgonkDbRm95haaY0gUlxoozTxxW2lkeC3
    Ndv/Xb+u3rH7x3pLCLQ3W21dkQaoNiUtC7QgJYZiX/7acuVrC9FKKzoBEcHesjPgyeH0
    Eews7aDIUqhEka38Ptv1BQGo+MH/uTBPPyy3hT5553zTdfiBjpf8w73ueL+y72sC+vSm
    agYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847855;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nRkyocmmJe+ZT+D2mB6MkX0aB75RjEJdyVVI5mxHOIk=;
    b=m9iFwPi6ENzDikdqnVB8mS7dUiPWcfGJMzHGD2Gk49LOiDywh53jyqqhCxkfHx/Dup
    1gdsRDNeM7jFKjnAEnDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGot42e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:36 +0200
Subject: [PATCH v3 03/13] dt-bindings: soc: qcom: smd-rpm: Add some more
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-3-a07dcdefd918@gerhold.net>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

