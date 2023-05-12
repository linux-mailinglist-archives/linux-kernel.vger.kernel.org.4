Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26B700694
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjELLVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbjELLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:21:32 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80F1385E;
        Fri, 12 May 2023 04:21:28 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C9mJFJ001476;
        Fri, 12 May 2023 07:21:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qgbybph70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:21:10 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 34CBL9Oo036319
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 May 2023 07:21:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 May 2023 07:21:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 May 2023 07:21:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 May 2023 07:21:08 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 34CBKtju000658;
        Fri, 12 May 2023 07:20:57 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Rob Herring <robh@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: hwmon: add MAX31827
Date:   Fri, 12 May 2023 17:20:48 +0300
Message-ID: <20230512142050.12204-1-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: cA0PMBUgwYGUGq4ljFu2OHp4XEAPFYvx
X-Proofpoint-GUID: cA0PMBUgwYGUGq4ljFu2OHp4XEAPFYvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120094
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX31827 is a low-power temperature switch with I2C interface.

The device is a ±1°C accuracy from -40°C to +125°C
(12 bits) local temperature switch and sensor with I2C/SM-
Bus interface. The combination of small 6-bump wafer-lev-
el package (WLP) and high accuracy makes this temper-
ature sensor/switch ideal for a wide range of applications.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v7 -> v8: Added '--base=[Linux 6.4-rc1 commmit]' when using 'git
format-patch'

 .../bindings/hwmon/adi,max31827.yaml          | 54 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
new file mode 100644
index 000000000000..2dc8b07b4d3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,max31827.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch
+
+maintainers:
+  - Daniel Matyas <daniel.matyas@analog.com>
+
+description: |
+  Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch with
+  I2C Interface
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - const: adi,max31827
+      - items:
+          - enum:
+              - adi,max31828
+              - adi,max31829
+          - const: adi,max31827
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Must have values in the interval (1.6V; 3.6V) in order for the device to
+      function correctly.
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@42 {
+            compatible = "adi,max31827";
+            reg = <0x42>;
+            vref-supply = <&reg_vdd>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..5d5359f59af5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12617,6 +12617,13 @@ F:	Documentation/userspace-api/media/drivers/max2175.rst
 F:	drivers/media/i2c/max2175*
 F:	include/uapi/linux/max2175.h
 
+MAX31827 TEMPERATURE SWITCH DRIVER
+M:	Daniel Matyas <daniel.matyas@analog.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan

base-commit: ac9a78681b921877518763ba0e89202254349d1b
prerequisite-patch-id: 7a4b4994760cfa8c07187d319e53e9956a8b639e
prerequisite-patch-id: af1a81cb4ad3137780afb102586a3489f9615303
prerequisite-patch-id: a4ed1db487f0ee9506b3aa7bb672595a7b793cca
prerequisite-patch-id: 421416a1110c5cc09e11afe2db6528cbca6d9492
prerequisite-patch-id: 8ced9e002e35952cd614acc0e2108f17a502a5fc
prerequisite-patch-id: 82d101227b696dc95c11bca8594f80b438537359
prerequisite-patch-id: dfe7b1d583daa8dbb2d2af8fc993622b65f83826
prerequisite-patch-id: 431a19e35c672a668b696858eace775c56f1e1e7
prerequisite-patch-id: 0b485820cf1c980bba3adedb9fd88b87ee3cc157
prerequisite-patch-id: 8d767b2e1313428538bea1490032f639cd1ccff1
prerequisite-patch-id: c1ef543ae6716d6ccad416250ca68c8a0eec058f
prerequisite-patch-id: 4c78ac1e346676b76fd8850f8edc2b08bdb78f52
prerequisite-patch-id: e6fa20eba19f686b0f4133b1c7bd5894f703498f
prerequisite-patch-id: 83d74aa2b6f8cfefeb14dd5e90705982b952a757
prerequisite-patch-id: 4ac1c2c31de74af80624f66489fcc87e533dd32a
prerequisite-patch-id: 77a377c5214f2cddd3455d1fcda34ccf28973883
prerequisite-patch-id: 2edf34328d29191533344d36f43abdc7479b4ae2
prerequisite-patch-id: 77e8f55f78744797df7efdc0d2b18740cfe099b9
prerequisite-patch-id: ab123ba97f1abe14016c30fae72b55a87363d5ef
prerequisite-patch-id: 7323aaafb0edd7edd51a5c6f8be1bb275f9dba9c
prerequisite-patch-id: 4a61b49c7ab4522967fd122f8bf38d679022df57
prerequisite-patch-id: 869ae6fe33242cbc0373cf1e1e92c7b240f9e1ee
prerequisite-patch-id: 12f8d3b3d21ea08368246f7cf3d42ec920297953
prerequisite-patch-id: 3cdfc61d4d0aa70f68d095a7df4e814259e9cc47
prerequisite-patch-id: 726807583bfd50c10a1090f067261266efbc6aa9
prerequisite-patch-id: eea50a388d43e8447a5ef2969af5df7a354e356c
prerequisite-patch-id: db216360c53cefee67966e28397efcd0591601e7
prerequisite-patch-id: ff327329d945c9502df11b15f4d037d355bee546
prerequisite-patch-id: a197064fc6a5e20d4c9ef5f508491b457d2564ca
prerequisite-patch-id: c0d5d63ae43075a035a632d61975ad1e1bba4e69
prerequisite-patch-id: 2c4053f5cf0ab2707bd528a36a926f49d3e678ba
prerequisite-patch-id: 2bc0059cb68aa397ea841c153b2f6bfc4e998de8
prerequisite-patch-id: d5e64ab8afa8a2761a51ec295709ed25b65f450c
prerequisite-patch-id: c8d1ca12e9e502f366bf04d98b1011b299433d65
prerequisite-patch-id: 955a12cb7b43bb60c913c097f58c6bd6d131962e
prerequisite-patch-id: 142599135b7ffa62f14d96755c3a5c2db45140b9
prerequisite-patch-id: d8415b405107d9d024566a415ad1b03a4606f9e2
prerequisite-patch-id: 0ecb6a8d2c011477889ba4db43a79fe8b0031b5a
prerequisite-patch-id: e755275a6776660db45f4c77e83100df26b714e6
prerequisite-patch-id: 61989ab7e10a1fb21144ae314bb01772fceee65c
prerequisite-patch-id: 42f546d2579f59ae937ca266ad104a745141317a
prerequisite-patch-id: 8b3afdd0e40d71a10a8170dd1be45232838cea0b
prerequisite-patch-id: dd4a4ad7eed59aff993717ec6e4552e2220125a2
prerequisite-patch-id: 02012f5d2e0f147338b267a23ed715ca452ecea4
prerequisite-patch-id: fff041f18c7d7b462d4b4c89ec5259e19ad07307
prerequisite-patch-id: 419d0a8254089778c04f24cc702caa3d365ea375
prerequisite-patch-id: 4bcb80ddab7867c8186f340897583aab541642a8
prerequisite-patch-id: 2968cce365bedd0affbb1d3b2fbf41dce3027de7
prerequisite-patch-id: 075f35a92da9f1df4040e2ede8904016276a72fd
prerequisite-patch-id: 435f2b1401e4d6bd611b1467dd95619cc58f7e94
prerequisite-patch-id: 3da11fd73cf9d6eb84a73fe2cad1865869b02506
prerequisite-patch-id: dccbed28650f98e89823e795468752613872c3a2
prerequisite-patch-id: 04589ce94898a31f50e44bc65065644651cd37bf
prerequisite-patch-id: b72c5f8e20711683185cc841913502fd0ee4e9c7
prerequisite-patch-id: a0b0736241e379dd9183620099389193118ab36e
prerequisite-patch-id: 57993217073c627364964ff45e9bda1f6466ab2c
prerequisite-patch-id: af1650070543b7eaa9196015c3ed80d02434c33f
prerequisite-patch-id: 72b63d356271003082e578ffe7664db8cd79086a
prerequisite-patch-id: 895a854faf88359013784d2b63c17876ae2afeca
prerequisite-patch-id: 0957d914360db266f0a8434542516e187739d53e
prerequisite-patch-id: a5c3cf2b3336198b7d7cc511d94b6dd093e0280b
prerequisite-patch-id: 0db3a4c3a542799cdedd61aebf4e8ae876674173
prerequisite-patch-id: 296a53f101dd57c4f932a70c57ba38fd2b787c17
prerequisite-patch-id: 0fd3d04fcb0a3cac132e978f3debbba16ae04a02
prerequisite-patch-id: fafa7c3b6daaf039bd60f5164cd2afeae88a2958
prerequisite-patch-id: c8dede88dbfb842524a21c61dc1adbe6ec2d5e2b
prerequisite-patch-id: 6c03e7d35c4f81bfe0f7897d40738c4ddfeeb327
prerequisite-patch-id: 95a510d6e4a37ae1fa3e6718281ba7f8bf296578
prerequisite-patch-id: e484fc1845969ef3556e47bd7923f827fb0314a3
prerequisite-patch-id: f3a231db2fbb4575045b246a0639af8ddee51743
prerequisite-patch-id: fa976c8bcea009372c77a66d31471654dedd1b9a
prerequisite-patch-id: 93cb412ad243b4ce378ee2cbaf842573091a7939
prerequisite-patch-id: ae93263bd307ec0709b73f2a5e27fc62e7d66c01
prerequisite-patch-id: a412aec7b2a33927a1fba5639ba65ee4b6fbd06d
prerequisite-patch-id: 5505ba1ffab06c2c65aece8f67c3fd622b41bbd9
prerequisite-patch-id: 49cf1b6bf4557be2664aa732c4dfec09d49f4223
prerequisite-patch-id: c36e546a903a76df4f347852cf98bcb5a5bd9ef3
prerequisite-patch-id: 91d94d46d985d5223d7990c3c4b56e564cd1b29b
prerequisite-patch-id: 4e3b1188de3758e6f78159f419dc8cf878bdc758
prerequisite-patch-id: adef43035108d6d0803b33ea47e2479d48768d74
prerequisite-patch-id: 6574822878421fa57e477c1d03eef02f1d1c99a2
prerequisite-patch-id: 814de8fe08a1a87455be7999ff2b5a9b16172ea7
prerequisite-patch-id: c51ad04c37f0c394ddeff7a6a81ff11ec79cc337
prerequisite-patch-id: b574d288c12dfa34cd28e7a13f97dce1ac49c5b2
prerequisite-patch-id: 9eeeb28a9379c54ed7df313427586d22c3fa2b0b
prerequisite-patch-id: 4e3917a7957cb01a7fc16786896437db15cd2f37
prerequisite-patch-id: 6c56a4f9cd863730d6a373252a89c168144c74fc
prerequisite-patch-id: 35ba8113f4a35ed06fdced77b486beebcf832051
prerequisite-patch-id: bacc1b8d2c13f0e3d5b9415f137d9485790bd02d
prerequisite-patch-id: 120f0081316830ddbb2a578c84d2fbb4d0a0bbf6
prerequisite-patch-id: c07ec668fd051742fa7c95c3837757a46e61c506
prerequisite-patch-id: 5e19ba08b46189498be3887fed503a948ac45fdd
prerequisite-patch-id: b80fecfdf09d662023b8aaf2172ff233e4dd6e3c
prerequisite-patch-id: f26f40b3ad3583c79e0e1e1a96e097858eba5969
-- 
2.34.1

