Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42918721F26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFEHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjFEHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D5E40;
        Mon,  5 Jun 2023 00:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=firyi2QPnDTmhb07A+Iwk3GaICVfLEGDtQT22CHyiReqc87dnSRyih5sDeBhUXW6HL
    1b4uMjMvYSl7oBROKGZLIB4yUFj73EpPDzmI2EGCI/c7QoIeMpzxNA5QTxr++ty75r2M
    3S1eVl+QrwWrgMbP3Xwe0QYIeTkyErjsF7lHsm23kjrjq/XrpmOWS4RohpB7hJDso0eD
    cfNWem61mVxnd4lJOkaKBRJXV+QId1j1AWjHNcEu2+j7kVERALDy5IhYsf/gjv8FHQP8
    X7RMXJaMQacwOgWDrAot46CfznPojwnznWD6KAX9Hs2ru5i73LcgOE6IL9e4bn+etCwd
    gzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LroyxGmPsORINdm0ugVL8qOXahKCwgL2YccLdI7xQ88=;
    b=pox1t7YsTPCjBPP3dzASlGuwnSNicpoDepQdse3RgSwe/gLMAIg6PLJzygkRQHQQ/P
    w5c4+pYK0YRm6IWBrvBB1Rag3obxdzlfv2Z+cXvuGL32UBt49MFgdR/edy4STHMAczNG
    wRRg5r0DHdCIXY7dzJev2SElFNzacJpGoVfoCMx5kRUOR6zmrTdfIT2BOFzC5g6Llj7+
    EjNWGEPbn4xib35vYtAAJ8jZ5lb4S97pwxCQXGGs19s+lsNt2SIf555HvzoVNtcCypcT
    RT28dThveOnUgtzXp+9fUNaIP7CxqN3E8GiRo1npRXqfByqgHBH8HfXaJEudYuXgdAMy
    hvUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LroyxGmPsORINdm0ugVL8qOXahKCwgL2YccLdI7xQ88=;
    b=Hw5eABjdPclupclhPHF49pE8nEsO+hERgM9JZiB8Qx0Ykpeaz0xbAMlYoF08RB2dCX
    D1Th36xzG9WnTT49sVbbHFHXBrKAJYHcd7VEkFMJhFPPqmkYC92yLSUYZczOx5trgbad
    qh+i1kGLbMFK02oP64XpMcw2UBNO2JtU8naPgjgcxbFCea6GoKyhau8kKypP/y+pSQWO
    huvrs44o9M4RIp0m7dGBks1/HTJSZOKJUI/czu8uAUmmHleDpqc5xo6sb48AOkZx+FkV
    7JEpOjhFxBsLctZx3j+y6yFF1W+oqgNntkv9QQSbNnV88GE2nGD9bvBJhywcTTvPJV1l
    bnSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LroyxGmPsORINdm0ugVL8qOXahKCwgL2YccLdI7xQ88=;
    b=u1WRKqVDJ5YE87fl/jm8mK7j+g/epLSBty+io2ofEanGTTjqW0s5sJelgCJtRIQC8S
    P/AF+vZc3AlAjxdrCJBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579E8a6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:23 +0200
Subject: [PATCH 07/14] dt-bindings: qcom: smd: Mark as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-7-e0a3b6de1f14@gerhold.net>
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

The RPM processor/subsystem is the only user of the /smd top-level
node. All other remote processors define their SMD channels/edges
in a "smd-edge" subnode inside the DT node of the remote processor.

Since the RPM has its own dedicated device tree node now as well,
deprecate using the dummy /smd node.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index 063e595c12f7..4819ce90d206 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -15,6 +15,12 @@ description:
   The Qualcomm Shared Memory Driver is a FIFO based communication channel for
   sending data between the various subsystems in Qualcomm platforms.
 
+  Using the top-level SMD node is deprecated. Instead, the SMD edges are defined
+  directly below the device node representing the respective remote subsystem
+  or remote processor.
+
+deprecated: true
+
 properties:
   compatible:
     const: qcom,smd
@@ -37,6 +43,7 @@ examples:
   # The following example represents a smd node, with one edge representing the
   # "rpm" subsystem. For the "rpm" subsystem we have a device tied to the
   # "rpm_request" channel.
+  # NOTE: This is deprecated, represent the RPM using "qcom,rpm-proc" instead.
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 

-- 
2.40.1

