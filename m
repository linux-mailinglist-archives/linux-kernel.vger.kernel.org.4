Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C53721F28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFEHLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjFEHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7AE67;
        Mon,  5 Jun 2023 00:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FjMVR6gZ9b47dSMg9tIUo84I3OlzzCdNLkN+mVBodgGJCiuhtpYdkCLWls8SVfA8/N
    Qu2/G9vlua7mb/N8p/7HuUpWc2PccTd9HwNSaiMEcPhKpkqex9rluKuIx+iN2MIrt13J
    uYv870+bJJ5yL3itn+Ox1iUUgc8YgXGto2nkPtgCmuSb2mFH2IMTdSIHj/gDdUGb6CRK
    Rq/lKeUPjSRmWObaZdlZylKV7cfKRB8Ou6SypGfAj5v4LNSFqiY2bNVPW2hF0eHrqB95
    A03J4Vnk15fNjOTzAFLL1J/P2S17QA/efrvA7RX3obEhrYdckYwjRaIKaa2sVpJceg/6
    uV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=efJmgyRhH8s5qmo/MF16ZslMvCpOw40LUinz7JEKENI=;
    b=b3ocpnzbg6hmu7M5b7v3htD36KuE1LBKD7KT5+bPO5BvgCjz0Q/f3EF5qi4rLtDE5/
    oJ94HTY3jHBYsvUgD56I1PhGwXpT6vIFI+98YtCQ1QJB7Y8YKbQdMNRxHaijLnr5oERz
    bTP1PcgcKDzek5MPy3sn0PXF3PutWAWMEnuF/dPjNkM+GcCSCk69DRQtwgFrUbPskBHX
    H2YsBOpiMR10MUYbfNjD+zk/bvhRKlnWh59hL45VLHhOV0/vBSBIxpTgyKTB30h7ey/H
    Pm9F0YxBj44OG5XzonVr1lCX4gjd69FJNIAtXxZhEpEdwpWFlZQAlItrQUiEpOYn5p2d
    /XLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=efJmgyRhH8s5qmo/MF16ZslMvCpOw40LUinz7JEKENI=;
    b=qDk5En0bq1LKiZlfWsRuW79x5LCE85oq3qFZphBSwZ9N1zyxz9FMa8bhegmwftqYmQ
    iRxX8nTWySdB9Xl6OCi7jWsAfsQ3Kb/pBEijoerFBRnLOvBxpKpvZlJ6WWXyn1gq+DEm
    QDOkJa3aWDHaDMbBCnbzrJZk5tn+9iyH7QrmBWaSg2jB35nbTgdDCFUfatfjZiQROUOn
    oJPPYeOE0LoOaz6GwTtPguKXBi6y2MBy8/eiTOAKteksIj4RekqKvfyOHlaBxmIN4h8m
    HrWazsbCFu6/ZSLTBQT2Y/RFU0kOEvY+c/u8B6mUzNVpDpiC9MaPP0/DK3/T0c8MjRx3
    aP+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=efJmgyRhH8s5qmo/MF16ZslMvCpOw40LUinz7JEKENI=;
    b=qbh2q6h4lt7A7Gfmh8wBuwFebG1lurZPlYCoDtWZxW5E1z8WsBFqLHPFQZD2mH6lys
    +E464QDdS8hglku8KwCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579D8a4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:21 +0200
Subject: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
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

On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
described as remote processors in the device tree, with a dedicated
node where properties and services related to them can be described.

The Resource Power Manager (RPM) is also such a subsystem, with a
remote processor that is running a special firmware. Unfortunately,
the RPM never got a dedicated node representing it properly in the
device tree. Most of the RPM services are described below a top-level
/smd or /rpm-glink node.

However, SMD/GLINK is just one of the communication channels to the RPM
firmware. For example, the MPM interrupt functionality provided by the
RPM does not use SMD/GLINK but writes directly to a special memory
region allocated by the RPM firmware in combination with a mailbox.
Currently there is no good place in the device tree to describe this
functionality. It doesn't belong below SMD/GLINK but it's not an
independent top-level device either.

Introduce a new "qcom,rpm-proc" compatible that allows describing the
RPM as a remote processor/subsystem like all others. The SMD/GLINK node
is moved to a "smd-edge"/"glink-edge" subnode consistent with other
existing bindings. Additional subnodes (e.g. interrupt-controller for
MPM, rpm-master-stats) can be also added there.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
new file mode 100644
index 000000000000..c06dd4f66503
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,rpm-proc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Resource Power Manager (RPM) Processor/Subsystem
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description:
+  Resource Power Manager (RPM) subsystem found in various Qualcomm platforms.
+  The RPM allows each component in the system to vote for state of the system
+  resources, such as clocks, regulators and bus frequencies. rpm-proc is the
+  top-level device tree node that groups all the RPM functionality together.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,apq8084-rpm-proc
+          - qcom,ipq6018-rpm-proc
+          - qcom,ipq9574-rpm-proc
+          - qcom,mdm9607-rpm-proc
+          - qcom,msm8226-rpm-proc
+          - qcom,msm8610-rpm-proc
+          - qcom,msm8909-rpm-proc
+          - qcom,msm8916-rpm-proc
+          - qcom,msm8917-rpm-proc
+          - qcom,msm8936-rpm-proc
+          - qcom,msm8937-rpm-proc
+          - qcom,msm8952-rpm-proc
+          - qcom,msm8953-rpm-proc
+          - qcom,msm8974-rpm-proc
+          - qcom,msm8976-rpm-proc
+          - qcom,msm8994-rpm-proc
+          - qcom,msm8996-rpm-proc
+          - qcom,msm8998-rpm-proc
+          - qcom,qcm2290-rpm-proc
+          - qcom,qcs404-rpm-proc
+          - qcom,sdm660-rpm-proc
+          - qcom,sm6115-rpm-proc
+          - qcom,sm6125-rpm-proc
+          - qcom,sm6375-rpm-proc
+      - const: qcom,rpm-proc
+
+  smd-edge:
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the RPM subsystem.
+
+  glink-rpm:
+    $ref: /schemas/remoteproc/qcom,glink-rpm-edge.yaml#
+    description:
+      Qualcomm G-Link subnode which represents communication edge,
+      channels and devices related to the RPM subsystem.
+
+  interrupt-controller:
+    type: object
+    $ref: /schemas/interrupt-controller/qcom,mpm.yaml#
+    description:
+      MSM Power Manager (MPM) interrupt controller that monitors interrupts
+      when the system is asleep.
+
+  master-stats:
+    $ref: /schemas/soc/qcom/qcom,rpm-master-stats.yaml#
+    description:
+      Subsystem-level low-power mode statistics provided by RPM.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - smd-edge
+  - required:
+      - glink-rpm
+
+additionalProperties: false
+
+examples:
+  # SMD
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    remoteproc-rpm {
+      compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
+
+      smd-edge {
+        interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+        qcom,ipc = <&apcs 8 0>;
+        qcom,smd-edge = <15>;
+
+        rpm-requests {
+          compatible = "qcom,rpm-msm8916";
+          qcom,smd-channels = "rpm_requests";
+          /* ... */
+        };
+      };
+    };
+  # GLINK
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    remoteproc-rpm {
+      compatible = "qcom,qcm2290-rpm-proc", "qcom,rpm-proc";
+
+      glink-rpm {
+        compatible = "qcom,glink-rpm";
+        interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+        qcom,rpm-msg-ram = <&rpm_msg_ram>;
+        mboxes = <&apcs_glb 0>;
+
+        rpm-requests {
+          compatible = "qcom,rpm-qcm2290";
+          qcom,glink-channels = "rpm_requests";
+          /* ... */
+        };
+      };
+    };

-- 
2.40.1

