Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC88721F49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjFEHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFEHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D9116;
        Mon,  5 Jun 2023 00:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948952; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E208gbJa/kpehn/E0gG34yP5+8zo/daV9WaoGeSNhQ0vgE84k8f8YMdQm/DUjEDpUh
    IzrbBVRoTs4oDPzi83ZNI8HBCPEHnNulvURj6i2a3OgUQGuzZ6NJGi1h5XQ/3GKeCWFS
    8gaqUREP8G1vrvDRUNaUf1wrs0p4J4F/IDy3KnkTwtkq8pbspyqTLkpFD81X3UQx99ON
    zEIXsv/A+7GazV7uCkEQJnOahZLJd1OBF/mu/JDDp9uVHzkWaFzqtbQH5mheEo7DBZjv
    M672natd/REd+zG3E6anAR/3lgdujlItcpcykS4v9fYEZS84TycV48Dc0Y+ZIq99Ir8Z
    AVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i6vg2E+TsScbEg1F3hvhkpF0/NiORrAwOoDXqEBB+M4=;
    b=qjrOK9RnEfV3BMjv1osY3GBzYiCCbaMmDV7BxvxfIEyVdDXQgjo1uHXcs0iVyJgsqa
    sSFMx62Lf5DOexpm/ikk3h1+GwSsJPxBAopN+0nFIgfvCvmZIZIhRBvLNiVpFgKK89pH
    kIo6C5mogDLp6ayogu2QzoFSc6lfFd81nVM1a03LBz1Rit2iuvL8KagZUDncQEoPn36h
    FNHDySrgWEkGwoQKKOGQoI91TwzE6MRN5/F5cDVwnypoDzlqpDkN2/o7+QWcTQT9+cq0
    ecc+N0L6rKxkn9ljcifL4+y1PRpibkpRLSjm2Dnl/xehJntIq5fb3JmXdqr9BAx4eg8g
    exaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i6vg2E+TsScbEg1F3hvhkpF0/NiORrAwOoDXqEBB+M4=;
    b=iFtD028ZvgMOzC/uMVYp/r+J+1P5Q/laTIBb8mj76j7L3VM+RjyYagH6nQhwggd4wf
    /Vm/QlofIN9Q7Gg7oS7BU8PB9c4YFt8CzLktgkzbfTASozUNvRPSXYVzs8M4GXQ39Olk
    tqenvJzx1XDciLnhbYyIgxYO5qYfehZTeXA3IFPEXZL/vOFhIwrzyqCUHWC0vOR0oVZh
    C9I1Qp+/sHenIqnsRmH/bs1RQ7pYl+fSy7YbdMDXND2M4DsvT2OSxZrTbXUGzwubPS4S
    pKngeY2AWcUOBjenNr5XmO0i2jUEOIC0OHG6HzRiI2PP9hsKa09u64cntaHsivHlt2At
    uThQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i6vg2E+TsScbEg1F3hvhkpF0/NiORrAwOoDXqEBB+M4=;
    b=K41haygXcVhvJoNw4z8Yf35+x4zvmTukL48AjtOCTMuJe/c0sbUV7UBoI5DY67pXca
    UW5AG9L2zrnAePsRMBAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579C8Zz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:17 +0200
Subject: [PATCH 01/14] dt-bindings soc: qcom: smd-rpm: Fix sort order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-1-e0a3b6de1f14@gerhold.net>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the enum entries are not properly ordered, fix that.

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

