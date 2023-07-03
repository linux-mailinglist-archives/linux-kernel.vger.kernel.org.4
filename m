Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4D745E30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGCOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGCOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:09:05 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2080.outbound.protection.outlook.com [40.92.65.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5FE51;
        Mon,  3 Jul 2023 07:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARs+kX7hjJnGqC/ZGQ9sdJLBy/FNjKRHAXzcEycU3FG/1SWtMVHOpqHQQMkS0fkKOsmDtFD6MwNg5oRuhXR+jIWZxBaLUPoZsTB48N3NphL2+VzTk+dxKYNtBOGdvCXiTfYFR7URhGg1CEowGwB9lqlGq5ltP/yMcNKG0q0t0X+itkKKYAb86aruLDmEfxn90D87rezYCyQJn+2MvJEUu3+Rl/0t2K3y/00xkDRYiOXmJrxrFxBEGgZOlLDPDcxAN5zPVE/U0JA1/wTknBT8gvd4+4CeAd3lzmO276J3a86eg3utC/qjZixvQ+jXZyU+GgYr1xuIoKbauhbesAylMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv2o6+vjhzW6qaV1JOzkZVGbSpstwXHterdeoFQmHBY=;
 b=KIG3tfFhBRvMByCYb9wsCoTE1rIT7jKy8eaGCwJVsnfXIjQUb9xwSfl/WkTwxfwrt283IJKtbLkOjJsonT09EOAzdbMk+6Y+tRf3yThqZgWnWrj3JnPfAEqnBdFVlr/1bvauNwXqaL7wL5zItLd+7kA+1JD4mCQEGFGv160SW30MZiWLCPEcTjv+mVLw9ZYW/vIFuIJD1S4sIhjs+7z//akojBt/vEYzIhEhIDWuLbxeB/K5nBeqDsCj+abC8WdJB6djAeFWfZfLJFKGx0lSMdq2lI4H6KGS/6Z8Y/YfBrqosNrJdUTEAiT8OFfsoLR/NzBzMhcLLnbDDDOHAhx+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv2o6+vjhzW6qaV1JOzkZVGbSpstwXHterdeoFQmHBY=;
 b=bxhS3yAZ3wr1lOqfgpDSArdVYcv0ZE3Nv6AU+MDGylJ+J0kGE1wjbs5AbJ0m4kVGA/skncshv/5xPgtey/05QkH7FvQTNlOOSvw9bcQXr3XHchyD5MIjCOtqsnbh4GKyRWIZNfQYn6v39i+JXHbz14igGoaX6gdEkLZmpwO0RtQ8UazeeA5Vwo+4lZ0XXADPUpPTmAkwWQXW3lkqfdyBY3YDTTCmeigvhtq61BuzCeBz/zSClcW4rYbU/IQtC/OiwPjkbvNc6CT9EH85MoYti2kZ/jnTEOZWSjphicjJ3DfvcKLIhukuGFjGV4mCRG5lwmt8GUnLcnOmEJBhVtDB3g==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AM7PR10MB3891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:09:02 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:09:02 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v3 3/3] dt-bindings: hwmon: add sht3x devicetree binding
Date:   Mon,  3 Jul 2023 22:08:18 +0800
Message-ID: <DB4PR10MB6261295D96DCE88F712910B99229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
References: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/ddmm/QR9sWj20GwZqie23rmJjUZLKm8Ob13MgHFT2xvFEa++P8AjNrO/8KP5INA]
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230703140818.427403-3-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AM7PR10MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 85df2f39-12c2-4ab5-cc1e-08db7bcf0d5a
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3kEq9VXjGDAytWtg2idpaP2lvHrdBLMU6TPg+DoSr/BcBlxSPh5WIeSeH35jKzbkThEp+MqXj043GmRiXAmQODqd3AVcHk3dKMXsAPid2lH5qsekcZD8zl5C8RpLHhdBK48LyXcZ6ndMBPw0jJ0397tDRAmR786zDcKMvqGRz0qtf2587LycTmcWDi81oAppSXR6Bt4dsIYy53ZkYghhjSh7ttuGXI8aUInFXc01fyWPZGAjmLPdy6RwyhqjIvsF6KtlH4iO4FEUkWKW67FvLCDyBNApS+v8BT4KnvILDVbdwVcPCIbUCF5uLBcxzLSF/eTSnF8iaiHMT4orl3Z48obYpZDjbBQsXvlnC51W9Zk/fIYvViyvGYHrq6YkeH2Mk3aBjFJIxg8PhukdMIYH6S+5gz6873XRpIV8LZTtg8vA6zGGpYh+5gOi3fmT0nMFP5Ii0nrqo3HBYe91g6upyN7QZ0doKbqdtaQuuqNgnv/l4Zs6/yeoQ4wO99BolRydXuKJSaLYK8HOSwmYoMOAKzzlX43W/72QRk41uS+vef+mSD0igMReOz/H9kgtybUgwbM5Q3RjWfW8Vewuf1mV7HDrUoiTGKmGOOmpDSe5Fo9KBYTu5Xa6HqU/mYmzSlg1ZuHA8S/iAWByrwN/vxYMFpcI0EJChVe4nwh/GyMZCGuiQi3Ck33fXx1OEtPIZsKklmYzN5DVhWLIE9wZcPnsTW3YeQrZN/ZJ0jT6H9tA3YYE6U02PxsFbLPQJBGD8+WDMyBx/WuGN1s7G8Gh0pd6dhw
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK7zSQUfbnNUJXeNtc00+WpHx2G17dgcmbIkBPsbr+aMvmP/Lak4+5p9/JnHurSUvg5PrrIJ436EXy2FKWrV8dIPHZ7PKYvc0PDrRHnZWDI1df7IUSKiEhYyR9mnv13U32VvFXZFXfTIpdCLXMCGxzw0cwsUtwqz84rbPxEgUSevPyyM9hBt4eV3QApbUWAtWkIseq/4PACmMcIdd62UzVmAoA2MIPEfd5ITxpHDMaczpJRUldYjNwarmLFvcEISjOzbvp2ZmOaBQN3+0dQlvKthVU7LkgdhxVexjxio3tCb93e6BdxmcCCGsiEUE3eSj+d+vprx/TqOJMZmkyiCdNOZR3Y/3G3+yIKOG4kGzEn8QXmXqV5ng2oAp+He5tsy+Oma10mkMM9fgIEWWY18/RjM41GVam27WtCqBMJEzQ4s1gfgAlT+unoBWo/Na8bPmc9VG6mEHKZJosNuB+DE+8vZxHh6moPMnQDGP9Q+pI7sRtHWssO0gPRVFO6jc8IE/U4kQ23GAuDS4ZoZ9/5bSw/ai/B33Y1RbrFKPiGMP8mZB8v3Yj/B/5csG00GRg5bvBsMBm9iim9IYkPtzQBrjXoa7bgmnE+rqT3Ye4Q4ZxoQq2G8NFkuBYvljnZA0EW8j5OygqYI+Q0864TTs7n/Hw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hm7jS0IBtWu0i9hC6dEZE5blPXOQN0o1XUUmnTl10BNgBL3aayC7Uecwjx77?=
 =?us-ascii?Q?oj2S2YOwZbMnI3XnV63ZcyGqzr/DGuoA6p8GJMQ0wtKoyCrL2fjc22EjZqCQ?=
 =?us-ascii?Q?UP8Z2VaBKsh2Fp3/sMlbbHqfOqIj4pk4/J/ZqFbhXuyNbGm9VeUdNmBlncpn?=
 =?us-ascii?Q?oeFnmUMHaIqG4MJOBW2AbaCB9QyeSwwGKPK8bskCEAT/8Pt+8SOB1wRZtkOA?=
 =?us-ascii?Q?7Bk8wD/VURdS4za2mMwKTKoaIPkQT89wruuHK++Ps8HNvraNcE9XiRyVAnjW?=
 =?us-ascii?Q?CIL3hp+wYzx9f6vYqwM130rJ2B4YmYehvIM1sh2HdYip8lI4d0PdwNdWr82J?=
 =?us-ascii?Q?oAuDCn9YBYwArKiPLMSeBEylLlDPxOes1qS5t+vpXZ/VOfhJi3dLdK7zbfHX?=
 =?us-ascii?Q?Fx2a9CMRUU6eIUduZJ12rdw0A8YaoMCaPDlrPyQ6EQc2Yfkjt8EpPBJNljAs?=
 =?us-ascii?Q?jT+O4E2ci6z0032AHSRSy602tSx3s6p033hlasQWCN5kDrj6IkNzJXp6BkZk?=
 =?us-ascii?Q?3q1Jy/Cu4bCaWAzIYdbkiE+S5dqYSVso83uDVEFrZvKXnYePRJWm+47selhO?=
 =?us-ascii?Q?2LcZ7ITjIq4LLweZTKb+DL5h0JcnUserLwnr5yxhnHGyJZmMSuHQlS1efPC7?=
 =?us-ascii?Q?sYx6Y3i5A/9B3pYjW+P3vJ7QHP8pMMNEVi23tqrQ5zJFZdGTrqsmVyalCN4I?=
 =?us-ascii?Q?UY8II9xqGEjNHNqQyZHM0+KrcXcb4ObDyxKqgj6pfxYg+Q0P57SUws+aV/Db?=
 =?us-ascii?Q?pexuHNZu+izClIl4dT+nKFPE5ye2QuqThU2GYWUJreuImpmNwGJoRx0D20Ax?=
 =?us-ascii?Q?rB+W71HnUJ0y/ZJinxa0wdwW7nrjpSV2SxYdUJlaBKCJ2IQPCfumfP9RFtdK?=
 =?us-ascii?Q?eMiKn7kQDdHH+q9VPx0lkbBEefReFMAnh/cejSFVirLAay677e3cIvm/iHYB?=
 =?us-ascii?Q?FPzhsDCC3JffJv1BtFt0ZjseYBCFv5oALwG14ENwWmuSAFPW9fWQdfZVcNga?=
 =?us-ascii?Q?yS0pdYk/o6eQuBCLX1lOdQxOa+6J1J9r+hSh+Y08vJEdvpmUdVxFvtbOwMBC?=
 =?us-ascii?Q?fUjy+18etK+wkOyfZW2rTW+LWgmT6CjH6P7agRvEddqQFXmOeqD/+y836G1k?=
 =?us-ascii?Q?U9KhX+7qNwYoy8iXiCvQRmnSTjie3IscorrmbhhYLO1raqa3R0xN+OLkVPIm?=
 =?us-ascii?Q?uo5SMJW9P9oBGLxmRQIh1giaDpYPJBiVmUtrPJf3xymrr6zev/Gk4g74J5mq?=
 =?us-ascii?Q?S0Kxtyb/UejsNOQiY1YU0+8GUOxX+feinysdKs7rZl7Okm7HJYIveb6nqnkq?=
 =?us-ascii?Q?Cmo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 85df2f39-12c2-4ab5-cc1e-08db7bcf0d5a
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:09:01.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add sht3x devicetree binding files

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
v3:
  - fix wildcards problem
  - add vdd-supply property

 .../bindings/hwmon/sensirion,sht3x.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
new file mode 100644
index 000000000000..bef2eb492a47
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sensirion,sht3x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SHT3x-DIS humidity and temperature sensor
+
+maintainers:
+  - JuenKit Yip <JuenKit_Yip@hotmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sht30
+      - sensirion,sht31
+      - sensirion,sht35
+      - sensirion,sts30
+      - sensirion,sts31
+      - sensirion,sts35
+
+  reg:
+    maxItems: 1
+  
+  vdd-supply:
+    description: regulator that drives the VDD pin
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sensor@4a {
+        compatible = "sensirion,sht31";
+        reg = <0x4a>;
+        vdd-supply = <&reg_sht31>;
+      };
+    };
-- 
2.39.2

