Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BCD72785D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjFHHLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjFHHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542F9E;
        Thu,  8 Jun 2023 00:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208273; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cShnzyr+xo93DYVADPTTBpEgr/xh8ajJt2vyX6pq9tK38YF4iuvXqZMPY+NDMEvRSM
    JZwOIwjQH2dY39xi09PXXYb7sm0LcNnVxqCZUm5wIULZRQfHGHWBFBXIt23ZFPZQhbvn
    bDmqjbpl3NrDeT7nhrQuskHH9oNm0K4mW/ZC1Hawbzr+jOguCk6oGqhfEEX3FpZ6zSGT
    fFDJWYfKV0m3CpxOnlGpi8xGrM9ocTbu4SETAALFkpdIUnKvuI1sl7zhrmRFXTZpU+UV
    1VK9wRJREARrJqg0i3hQ8tuLTMPioLXoqEvh3Yxt2TnxshPvE9XhjJSi+g2qG1ZU++/x
    2YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mnN9AJ7c4MNAxnOtohIPDe15eBC7MaKxqrM10BJfMNA=;
    b=FzWA2iDDVY3dxjn1SAdit07XETuPqM9k86HLN7I7CeokOfhDY2KGehDZsjA0y41TWY
    LjDfjL9qv4c9tiG6hxU2PYOp+sKQv6xp9hDh5luNKa6jkSTYi5Kppls5Dm1Nv+xr+ih9
    VYMqUNYdLudvDjbeYOitQbEopLud1IvkEXFNDdGncZpmyGKCBVUFO7na3hmxpkpCFHld
    /3RNzw+noOALBfAEXMs3tt8M0sJ6cLD476MKhqubUZcaUZjstW/xqY6TntWHZBUufQwc
    pEmjOj1RYz1cJuVWsRrRWMteI5Gd7skMWjmxPXXDIudrlEs7BCn/52dXg7uGaZ1x1cB7
    qugA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mnN9AJ7c4MNAxnOtohIPDe15eBC7MaKxqrM10BJfMNA=;
    b=JZn9ojDbJoSd/+w5h/sVzaT0TvDUWsFulmOS+wX5FWALDkYpEspa1oWFE8kZOLA7hg
    ACeDESlykvwlRoQSVja++RHLsRABtBTtY4I5MeZ/VTbOO+QQJqa83/M3eh75PG+KVqtE
    yuC3R8YggRZHZh8RPfoh4W0FDD3p7dIJt6L8uLD/iH6TOMfdzuWuyq1tmkOjDNn3NBlr
    lAfJww29BZjNBnhqGYYt9ulQdLcwHKqc3Exl0lbaPzR341aLcEUHwz1txpPkeUCDb9jj
    a4NmMKiNYVVTf1RdG0USMMu3SBNhzBT7i930CmJ0kwtsf9m6UQK/byoUdSjls8vBZ6DS
    LeHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208273;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mnN9AJ7c4MNAxnOtohIPDe15eBC7MaKxqrM10BJfMNA=;
    b=WKTix72sytdGHHf2EevuC+NNvJ+3g9K9FnRuE+Yqa60TayX8yveF/GQ8JZJLGZhKkr
    akuUpAx2p/QtTIYkWFAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BCKHy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:25 +0200
Subject: [PATCH v2 05/12] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-5-56a4a00c8260@gerhold.net>
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

Deprecate using the old top-level /smd node since all SMD edges
are now specified as subnodes of the remote processor.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
This patch is based on qcom/for-next, since it needs the new
qcom,rpm-master-stats.yaml schema that is only applied there.
---
 .../bindings/remoteproc/qcom,rpm-proc.yaml         | 171 +++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   6 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   7 +
 3 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
new file mode 100644
index 000000000000..9c016613463f
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
@@ -0,0 +1,171 @@
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
+  - Stephan Gerhold <stephan@gerhold.net>
+
+description: |
+  Resource Power Manager (RPM) subsystem found in various Qualcomm platforms:
+
+                  +--------------------------------------------+
+                  |       RPM subsystem (qcom,rpm-proc)        |
+                  |                                            |
+            reset | +---------------+     +-----+  +-----+     |
+          --------->|               |     | MPM |  | CPR | ... |
+   IPC interrupts | | ARM Cortex-M3 |---  +-----+  +-----+     |
+  ----------------->|               |  |     |        |        |
+                  | +---------------+  |---------------------- |
+                  | +---------------+  |                       |
+                  | |   Code RAM    |--|  +------------------+ |
+                  | +---------------+  |  |                  | |
+                  | +---------------+  |--|   Message RAM    | |
+                  | |   Data RAM    |--|  |                  | |
+                  | +---------------+  |  +------------------+ |
+                  +--------------------|-----------------------+
+                                       v
+                                      NoC
+
+  The firmware running on the processor inside the RPM subsystem allows each
+  component in the system to vote for state of the system resources, such as
+  clocks, regulators and bus frequencies. It implements multiple separate
+  communication interfaces that are described in subnodes, e.g. SMD and MPM:
+
+             +------------------------------+
+             |        ARM Cortex-M3         |
+             |                              |   +------------------------------+
+             | +--------------------------+ |   |          Message RAM         |
+             | |  RPM firmware            | |   |                              |
+   IPC IRQ 0 | | +----------------------+ | |   | +--------------------------+ |
+  -------------->| SMD server           |<------->| SMD data structures      | |
+             | | | +--------------+     | | |   | | +--------------+         | |
+             | | | | rpm_requests | ... | | |   | | | rpm_requests |   ...   | |
+             | | | +--------------+     | | |   | | +--------------+         | |
+   IPC IRQ 1 | | +----------------------+ | |   | +--------------------------+ |
+  -------------->| MPM virtualization   |<--------| MPM register copy (vMPM) | |
+             | | +----------------------+ | |   | +--------------------------+ |
+             | |           ...      |     | |   |              ...             |
+             | +--------------------|-----+ |   +------------------------------+
+             +----------------------|-------+
+                                    v
+                             +--------------+
+                             | MPM Hardware |
+                             +--------------+
+
+  The services provided by the firmware are only available after the firmware
+  has been loaded and the processor has been released from reset. Usually this
+  happens early in the boot process before the operating system is started.
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
+    remoteproc {
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
+    remoteproc {
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
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index c6930706bfa9..2fa725b8af5d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -120,10 +120,10 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    smd {
-        compatible = "qcom,smd";
+    remoteproc {
+        compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
 
-        rpm {
+        smd-edge {
             interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
             qcom,ipc = <&apcs 8 0>;
             qcom,smd-edge = <15>;
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

