Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEFC5BB6F1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIQHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736046232
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917072401epoutp011469c2497a80242fb0014915496e3735~VlPqOFPuN1986719867epoutp01w
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917072401epoutp011469c2497a80242fb0014915496e3735~VlPqOFPuN1986719867epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399441;
        bh=EkOlsbEEebMKOcL/bv6fterDUppNnHaI9G4AA5NT3wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmDAU+ExtBie0WQyQtyCYJmOAQrHr+/L24K2MSoGmTgQr/OlydDrPk7vY58xsHYwZ
         3tgdYqHpjieuZ2L6r0exK5D+TnJLtQ7wkqgQO1yOegnK/2c9JUX6hGYz2sRA0h4j72
         FPsC8IR6uD3Nn6yBIjtibwp6TtfJnUdcN/F1n7eA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220917072400epcas1p3099fcbc6d8f64307611b5a65afd1ca30~VlPp0UKGs0974609746epcas1p3V;
        Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MV2Vl2VdFz4x9Ps; Sat, 17 Sep
        2022 07:23:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.1D.57013.F0675236; Sat, 17 Sep 2022 16:23:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p15d18d4cf27694f894332f975bb971bef~VlPn8VPHN0249402494epcas1p1S;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp21fac72e221d8a275023714fb8b11bfec~VlPn7nmMM1654916549epsmtrp21;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a37-da3ff7000001deb5-1b-6325760f584d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.45.14392.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epsmtip2502024b537cf289bca380d327e8ce165~VlPnqkoTO3199331993epsmtip2a;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 13/13] dt-bindings: arm: Add Samsung Trinity bindings
Date:   Sat, 17 Sep 2022 16:23:56 +0900
Message-Id: <20220917072356.2255620-14-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX5e/TDXZ4MU8Pou/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xs+Pa9gKfitVTJzzmrGB8YZUFyMnh4SAicTBlRdZuxi5OIQE
        djBKTHi/mR3C+cQoce/YH2YI5xuQ86+VBaZl29qlUC17GSX6r++AavnMKDH16EewKjYBVYmZ
        M9awg9giAuUSzRtPgNnMAjkST+40AY3l4BAW8JBY2S4OEmYBKv//8BATiM0rYCMx7dpksDGc
        QPbNTU0sEHFBiZMzn7BAjJGXaN46G+w6CYGP7BIbT5yBus5F4vHyQ4wQtrDEq+Nb2CFsKYnP
        7/ayQdjZElM6FkHVF0ice74V7B4JAWOJiytSQExmAU2J9bv0ISoUJXb+nssIsZZP4t3XHlaI
        al6JjjYhiBIliSV/DkMtkpCYOuMbE4TtIfGg+z0TJHT6GSVOzNzDNIFRfhaSb2Yh+WYWwuYF
        jMyrGMVSC4pz01OLDQuM4ZGanJ+7iRGcMLXMdzBOe/tB7xAjEwfjIUYJDmYlEV5VT5VkId6U
        xMqq1KL8+KLSnNTiQ4ymwPCdyCwlmpwPTNl5JfGGJpYGJmZGxiYWhmaGSuK8etqMyUIC6Ykl
        qdmpqQWpRTB9TBycUg1Md/pPJFwN7zu9Ldb/hagB495fRW7txYkzle50iVw85sMr8ifC/J7t
        klQTk0ufyvcyG516GObY9m0f843uP7NWuSX3Jay5aWx+597NrvDU5iOObLv+fXnnE7r9M1P6
        Qrv9VzNbFZk3ZF52yXw5bWldrlHJpbJ4BoW+f1PORewXdQ7mtlv4Mi/u7Ndqu8KNPD+lD5cd
        LXj92cJl6eLALeLrjTgv/pz1YOUFzcvzJl+r/SAemyr9utuGgy/GPGkTp/lsvgen2+7/t7CQ
        7H3LtL93cXd2arDG6/O3v2s/XTcnfUtg0MzZeTlnV3kuMivK/SjeOKdAfHn1tcy7XGeTLX55
        3DXx+eP4RPTeLMkO4QvvlFiKMxINtZiLihMBFT+NGiEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqywZGJWhZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGz49r2Ap+K1VMnPOasYHxhlQXIyeH
        hICJxLa1S1m7GLk4hAR2M0ocmdnBDJGQkNh0bzmQzQFkC0scPlwMEhYS+Mgo8X2VJ4jNJqAq
        MXPGGnYQW0SgVuLg0flgrcwCBRKzn85kAWkVFvCQWNkuDhJmASr///AQE4jNK2AjMe3aZBYQ
        mxPIvrmpiQVivLXE7OlzoWoEJU7OfMICMVJeonnrbOYJjPyzkKRmIUktYGRaxSiZWlCcm55b
        bFhgmJdarlecmFtcmpeul5yfu4kRHNZamjsYt6/6oHeIkYmD8RCjBAezkgivqqdKshBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MKxbvuBR8xWfRHOfT
        5ttOhv6PnSt/4bkSu/w9HZZ2X+s/t2X0t7/+YpnbltYye0Z0vOj+LfVJoTVc/oysdoqJLAq7
        19i7ZVV2yH4VVFvgdulU4nY98dXtKpHXMoqU9z47+7FCf95pIyXlX8yX5sm+dq6uzavJqZae
        dVdbMV/kT6W+YbNynLr+o3rx52dUyg+r8lWfEygvfB3/7JC1m9cKKfnmZf+vTVn0ftFBvWei
        L/ZsEd+aMedKdENqiPdj1iyXcJa6oxeSxayv5pw8dWqqfDjjPJsDBZcEIw6ecJRZXz6l/tVh
        z8TrnDV51iZa2xgur3hjVxYlpHLN+sSObYwVV1/e+5XGuiv8x9w3f34psRRnJBpqMRcVJwIA
        5R/ODdoCAAA=
X-CMS-MailID: 20220917072358epcas1p15d18d4cf27694f894332f975bb971bef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p15d18d4cf27694f894332f975bb971bef
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p15d18d4cf27694f894332f975bb971bef@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trinity Neural Processing Unit (NPU) is a hardware IP for providing
hardware acceleration for neural network processing workloads. It has
own virtual ISA decoder unit, and controlled by memory mapped control
registers. The IP is composed of Common Processor (CP), Digital Signal
Processor (DSP) and Deep Learning Accelerator (DLA). ComBox is register
set to control IRQ or check overall status of the IP.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/arm/samsung,trinity.yaml         | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung,trinity.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung,trinity.yaml b/Documentation/devicetree/bindings/arm/samsung,trinity.yaml
new file mode 100644
index 000000000000..cd79ec040162
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung,trinity.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung,trinity.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Trinity NPU Family
+
+maintainers:
+  - Jiho Chu <jiho.chu@samsung.com>
+
+description: |
+  The Trinity Neural Processing Unit (NPU) is a hardware IP for providing
+  hardware acceleration for neural network processing workloads. It has
+  own virtual ISA decoder unit, and controlled by memory mapped control
+  registers. The IP is composed of Common Processor (CP), Digital Signal
+  Processor (DSP) and Deep Learning Accelerator (DLA). ComBox is register
+  set to control IRQ or check overall status of the IP.
+
+properties:
+  compatible:
+    const: samsung,trinity
+
+  samsung,trinity-type:
+    description: type of trinity family
+    enum: ['triv2']
+
+  samsung,tops:
+    description: Performance metric (Tera Operation Per Seconds)
+    enum: [2, 8]
+
+  samsung,idu_cp:
+    items:
+      - description: Address of zero data of CP
+      - description: Address of IDU data of CP
+      - description: Maximum size of CP's IDU binary
+
+  samsung,idu_dsp:
+    items:
+      - description: Address of zero data of DSP
+      - description: Address of IDU data of DSP
+      - description: Maximum size of DSP's IDU binary
+
+  samsung,dspm:
+    description: The size of Data Scratch-Pad Memory
+
+  memory-region:
+    description:
+      phandle to the reserved memory node to be associated
+      with the trinity device. The reserved memory node
+      can be a CMA memory node.
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+
+  dma-coherent: true
+
+  reg:
+    items:
+      - description: Memory mapped register of CP
+      - description: Memory mapped register of DSP
+      - description: Memory mapped register of ComBox
+
+  reg-names:
+    items:
+      - const: cp-mmreg
+      - const: dsp-mmreg
+      - const: cbox-mmreg
+
+  interrupts:
+    description: workload complete interrupt
+    maxItems: 1
+
+required:
+  - compatible
+  - samsung,trinity-type
+  - samsung,tops
+  - samsung,idu_cp
+  - samsung,idu_dsp
+  - samsung,dspm
+  - memory-region
+  - dma-coherent
+  - reg
+  - reg-names
+  - interrupts
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+        trinity_dram_0: memory@80000000 {
+            compatible = "shared-dma-pool";
+            no-map;
+            reg = <0x0 0x80000000 0x10000000>;
+        };
+    };
+
+    triv2@0x30C00000 {
+        compatible = "samsung,trinity";
+        samsung,trinity-type = "triv2";
+        samsung,tops = <8>;
+        samsung,idu_cp = /bits/ 64 <0x30400000 0x30400010 0x10000>;
+        samsung,idu_dsp = /bits/ 64 <0x30500000 0x30500010 0x10000>;
+        samsung,dspm = <0x40000>;
+
+        memory-region = <&trinity_dram_0>
+
+        dma-coherent;
+
+        reg =   <0x0 0x30C10000 0x0 0x10000>, /* CP MMREG base */
+                <0x0 0x30D40000 0x0 0x10000>, /* DSP MMREG base */
+                <0x0 0x30DF0000 0x0 0x01000>; /* ComBox MMREG base */
+        reg-names = "cp-mmreg", "dsp-mmreg", "cbox-mmreg";
+
+        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.25.1

