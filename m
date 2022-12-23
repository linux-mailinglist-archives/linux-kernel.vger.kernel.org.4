Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B978B655639
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiLWXdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiLWXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:33:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31B1144B;
        Fri, 23 Dec 2022 15:33:12 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNEWUg002705;
        Fri, 23 Dec 2022 23:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yGFwuojaQ5ML4dsz23/al/799O12g89UeuaQci4f9LM=;
 b=ZfH2zS6DK5rpX5GZjoafjeymkB8WPG2GwMP3uTopK/XKcUtucbHH93txeI/TSYQX1U8L
 JGXqPb3Z2zjA+hq2gF/4kQJbiaznu6CS4SvdIC6AFeaNWZBbG78nAGuy26iler0NKQ3U
 y7HsvwPIX31HFhyZGerAxCBm2OdUI2+76Ro9BkGA+h2GaZDx2VkNuB90N/CDanjX63no
 XoIssDorvSKKKd/TPIIarDWMCIYxB6Fu10R5bXSn86bWw/hu4QD1rXvETNoT1YAyB0l8
 GoeURMaNupwKzMCg5QUTt1hKaoTm6Sj522Ka28WbznTP8Kx0KM6yocFMYiD6J6vkhl6K LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm3cjx2m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWlg4016927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:47 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:47 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 13/14] ASoC: dt-bindings: Add Q6USB backend bindings
Date:   Fri, 23 Dec 2022 15:31:59 -0800
Message-ID: <20221223233200.26089-14-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2JYvu9tMPFuec4M5feMBaPsJNbJqnWGK
X-Proofpoint-ORIG-GUID: 2JYvu9tMPFuec4M5feMBaPsJNbJqnWGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=936
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-binding to describe the definition of enabling the Q6 USB backend
device for audio offloading.  The node carries information, which is passed
along to the QC USB SND class driver counterpart.  These parameters will be
utilized during QMI stream enable requests.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../bindings/sound/qcom,q6usb-dais.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
new file mode 100644
index 000000000000..e24b4d52fa7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ASoC USB backend DAI
+
+maintainers:
+  - Wesley Cheng <quic_wcheng@quicinc.com>
+
+description:
+  The Q6USB backend is a supported AFE port on the Q6DSP. This backend
+  driver will communicate the required settings to the QC USB SND class
+  driver for properly enabling the audio stream.  Parameters defined
+  under this node will carry settings, which will be passed along during
+  the QMI stream enable request.
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6usb-dais
+
+  iommus:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  qcom,usb-audio-stream-id:
+    description:
+      SID for the Q6DSP processor for IOMMU mapping.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,usb-audio-intr-num:
+    description:
+      Desired XHCI interrupter number to use.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - qcom,usb-audio-intr-num
+
+additionalProperties: false
+
+examples:
+  - |
+    usbdai: usbd {
+      compatible = "qcom,q6usb-dais";
+      #sound-dai-cells = <1>;
+      iommus = <&apps_smmu 0x180f 0x0>;
+      qcom,usb-audio-stream-id = <0xf>;
+      qcom,usb-audio-intr-num = <2>;
+    };
