Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D3721F33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFEHNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFEHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D950E44;
        Mon,  5 Jun 2023 00:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948953; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GtA7gO4D4tYMkUOQrXO8IA9yHKrSUYp95UpHhGV/gaiqu0kiXPMCZSlF2VG8+e11lY
    hMhOn+pxzk60lTIOACzBB1EGl8YqNm3eUPFEQEc5jERkx7dARh/nRDLG8r2orjQI0nr+
    3XW7sHVk1EGmUgofR2a5XjZuNKa2UQL9JH3fnKwOC0KglTCEUA1KYSLgmqqQkhjlpOCc
    lZeHQDFSMtrSHrAoSkvzIjvoVEo3s7RF+KwKQMa1yjqUnjEpTodYGqpNnx9SxsZ6I45Q
    6IsE1OdntpIDsMg87/be11FfKEpopMRNhRfhrADHsSC9AhYMWlsVJD2CTqOSXu2LbJ3c
    lSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X8YC1vqHGkyxsCoLtenJvedIAaQtZG4RYK8t3f+bBn8=;
    b=avwTFizxAtSydIpKHnPPUfZ7j7U8f020zudkRPdcSt5dGHoTHd5bt8HrQ3pw16zX9s
    QevUZLwLr3f99ugtxHjUgv8k9WekXXRgqky2Uq8rUNyjYZP5C5+ZmXNHhUxpZJsbyPLE
    5a2KeQWeCC7e4dCU5d2h5VQpss192SIowfpJhgKw0zTnGrUo8+1kbZJnJlYlxpEgNP8z
    eXr5hoAbkzSysk2umuPEyviAz7jg1ixo36sUGrwCNdGaNQAjXB19IcSjE8G7oXJ4zHKo
    7mfiHAKKlovxXeqyFZpOYr/BU33XSM9QVLw9at3nMihUZSOtk2xZbdQJOVSNzr6QPEL9
    4moA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X8YC1vqHGkyxsCoLtenJvedIAaQtZG4RYK8t3f+bBn8=;
    b=EHHtuy1AlSC+3q+/SaMRX2dsnUPLXCYMCrbL93sH8Rnnf8XcuXPcjC4VeI3w96gPiD
    n8pk3fVY4+s6R1cKY5csL4DocChDd/L1eBNyfmRnyJvPh6rGajXIoyEgraMnVdKIxxoH
    mPmLPAkPUBsE4aOEY88ZDl7ECzMJpaVyqsGqJFQlGlo2RfNU/gWwG0eU8Pfcy8zB1nsy
    EEbV+PxsxNvGm3X1aejSH/6l3DjIkpqKZ3eiTwiVQhehOJ+Ip5cMEU++5VLSZjg1F4Oa
    zqzzbLJyCW6S9lcvpEtpoT7MWPvbBAbm6J2eN1xdQ/BSRa1JFkx8Vp0X/txz+Akc2ZrA
    M/ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948953;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X8YC1vqHGkyxsCoLtenJvedIAaQtZG4RYK8t3f+bBn8=;
    b=5bZyGBpzhzXoD3Y/9i+TD69KNEuYGvTH7KAvHQBEMyTXTn7pIvpGLHnANjYRoQE26y
    94ym2huRDfwwLkj4guAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579C8a1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:19 +0200
Subject: [PATCH 03/14] dt-bindings: soc: qcom: smd-rpm: Add some more
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-3-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
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

