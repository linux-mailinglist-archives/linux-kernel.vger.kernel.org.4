Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BEF613349
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJaKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJaKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:09:27 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F2DEF8;
        Mon, 31 Oct 2022 03:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZC+pVVNvMN4oM8EVvRiA3sOOw/39zKPuTeqbx7lmsvITUGqa51+41Y+9hrwUX3VrsXTWtGhbuCOQSFFqYj1N6W5NQLbzKJhSPVa7MSXS9jw2JXGV/u+bbh1iCP4oKgF08r9WDdm+p9o4Dw/+7KvqeUg7KumYYO+dokxiNKShHgq76uhtdq3+RGeksJ6fZrdnPEOz8ybBg5zvTecGJrMu5eDjNzwh7N9VbfakzwO+ps8qn/iel50w+7zXoNBG03gzjxd3vp6KrHykffmzNfah5W7x6lZDUvCjfzGJVlQ1Sgc70OmhQmbBS2ZFQbrkVRnioVWweDTzp8EbcSD/SEJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huVVdILTJCAEFHYS19X7k6dqMz7IAtXdnu9nM3EBHoE=;
 b=IL/OA1KJicRVw5ctwHI30gCDMw46s5l2UjTenqJ8KZY4dCKu3OUvconl01B4l/8maV9tKoiGMcFoEmiLcTXei3Z0yAt5EqHOnBW1c8uq0BDQjS/qBIzrN9yQbXjm6Xudul67lX7sJXL3WzJ7W7+v5spWA2aVw/+jKfdF8NpLfiZF1hWLVQ+NKqoyi70MKdyfg/mExuFVZqP4BFg8xYQN7HxhH0m8vUB7+qB8TvgQ2HoXo3zsS8hhBW1t5B6arl8DBDs85cZ7Pxt2dld7E/BnRxIQQNyl/lm7lUqayGu4fd400hmUTQCIdXQL77rTeRvwcibyPl6R0vCxhG8HESE4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huVVdILTJCAEFHYS19X7k6dqMz7IAtXdnu9nM3EBHoE=;
 b=UVCAUGx7fvlOGGoLga3Ucinp9qv3jhSSqrwW3QEK2vwM3Jf0gX/i1l/pMrFP764sIRm9wygUmOW/wiTcjs3KwDkjBpzQJ7GyZHFsxkQurkoypjhC+dcn28L6vz0HciZEySs3/ed0WtzrRHdgKaPIruNtSIz8RqyMTDgu53m3fU7xWQEHWlupq6zFBseG2YUbHjvGDFsxL/eaLYCSRUfGjNMrgi17myTlWQlTVarX+iALSdKxg5L9ycyPxJXVE6M9mAZNZcISGa+zv8wuIzDj5ZWyyc6lkHdcwpIYoLbu6jE2qpuW/4wtYHLv9+Vsrd6ud7u3+u2OP3lKGGEYHRQiKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8886.eurprd04.prod.outlook.com (2603:10a6:10:2e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 10:09:23 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::41c4:5b70:6fec:a963]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::41c4:5b70:6fec:a963%7]) with mapi id 15.20.5746.028; Mon, 31 Oct 2022
 10:09:23 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Date:   Mon, 31 Oct 2022 18:08:42 +0800
Message-Id: <20221031100843.14579-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031100843.14579-1-clin@suse.com>
References: <20221031100843.14579-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:404:29::26) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5f7a76-03ca-41bd-3074-08dabb27fc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuP9GnS524Iz6Q7xr9CfzmDYzeQeMMx3TokUydVQJC08mZQ+e8JeKJcENxexIdEMLotNRf4RSgiZfWWs+XELtF7Zs9o6An2CIjPlUpnT7UNumI5oAK6GGpsyM/cBM/hIA+XErSm6yczvbhAAy1tQyf5V3TeaZRyY3D0ZHpmbtvYhtSqnhH/Y4R49MbTgYAu36q/uyDNBTot9nsGGjJ+7gUR1ROFjTLGRAyfco3HzvnklkxmSVGautueOij0s6HV3/mJ5HexT1LCD/Zbx3CVpdPDqnQFQYwFKVOpwYw8CZ8lwQUqdIq//Twuu3urYkdEQD4VuYKuLYu0uy/clc6clHeaHoJF9W/ajrsV6kCsU7gOXY/hCNL/DgUMAnSb4WgSxEMprsXD/jTfyz3OlyygqO0k2Pg68Lua9gxdSe7Mn27Gcuvl0JyFlFeBE1H2GbDeuWcpi7xhQL+BnVYBaB5MHXFB4X/yUUP2yE3Cb9ZBpcZk1uDBuPJ8MwcSGGCyqmIFq+YxA3GDN8+q4156gU2YuyQ8ZTQ4c6GuOMY3mMV4AVdj/VgCpASonHUbiHjMP8KW/z4jQAqUT3RCf70Vx4okCFWQSLuFAh4aFy72Ec+Ji9F2+s+UIYxthj5WKS7ESncGMblGS9BAmkw9b3eLNwrQV3CjX8JVjTcR64WCF55X1osGG1BlNad8dvZ0z8XV2C+vaNT24ivTWY/zaJdDOpSMOnT8c2YKhueUQWSG7FKR5mG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(54906003)(316002)(5660300002)(4326008)(478600001)(6486002)(86362001)(8676002)(110136005)(6506007)(6666004)(107886003)(966005)(36756003)(38100700002)(186003)(7416002)(2906002)(66946007)(26005)(6512007)(66556008)(66476007)(2616005)(40140700001)(8936002)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJTFkbC4Ybm0vd78PBJnlt8oERro7C0zABbYdub+Xn8R+VTLZfi+bVFJ3+04?=
 =?us-ascii?Q?//sfRXCWPTqcLKd2wL/i763UPPX1CdLSuYi0Jxq4BvkveWf6tpgcHGCkw7Dx?=
 =?us-ascii?Q?r5pF/WKqxtREnUOrA4BKJyZr8E5XyvPDYm38R+KQRvdQzI3zKoNxa4ae/Yu3?=
 =?us-ascii?Q?I0VxcCPEhgd9CMkYbli3RwobIYadN3reG9oEYRW3Gkvw75v8Q+hLTKiQBmW9?=
 =?us-ascii?Q?kzeaNGMohk9JPBgxtg1aKyDB7JdPVUe8R2KUiLWvkJxPI/p6RwpbQ3JZTz1X?=
 =?us-ascii?Q?dXA61N4C5x+Sm9EmON/+SZj4NlZKxLzB2fDeirotFd7xfcTr3aA3L8Hm0g57?=
 =?us-ascii?Q?phAZGBwlRWsgVSQa+YC57qq6NuI59raptTErM3yEfy9vn3iKFr96VaxJtMGN?=
 =?us-ascii?Q?3HKdHXB1lWlesqjWDlXehTKDgMUIw2DKtI3LCqjeF5M52nFvidAbP8/gcd3x?=
 =?us-ascii?Q?7sH5HzyaZFiubJP+ACTlmRy183ISPQ8JcyAYKx65XFB+/mmyqwA0QDyEc8ON?=
 =?us-ascii?Q?lqOjdy1GiA6GQo5Zd80Nyd6Sv1dRQXAbXvAgUOVlcDEo6aZzvuEOgSjRwsEL?=
 =?us-ascii?Q?fzPSQ8yLfqHROWSKDuK8APc+Y0mohesKCggU7e2UzJQmDBc5O1xNuCh+joaz?=
 =?us-ascii?Q?aJV+Zfz8fQLCra66PtsBSivQ6NoS+Od8SYSt+Q4CWXICrJv+hDBP9A585UTd?=
 =?us-ascii?Q?uwGS8EbvT/mHBHeBRx1KMhmz/opA2SlRcnSSrD7/u2BJ69m0Iu0eRnt0UMT+?=
 =?us-ascii?Q?oH1d5BVLMdmfUBpDNOcwy44eCLAqAqVlg71p6+H1fumLTICQ9vtRjCFLTNrW?=
 =?us-ascii?Q?ntUcqzaGzmllxPN8/3KCBl8jShvU7W68Ult0B68KmzcfeN08IlM6bKCS2FeY?=
 =?us-ascii?Q?jMOx4c15yv0+bzvhOEHekGORGQT16kPPzDU7x8kisHqBjZlYDvEnSyQu7106?=
 =?us-ascii?Q?2vlbYa6Acv5BcuQhSgTkMewlai91UAi8tPdznuazuKEnb3GpSGGvUxkuNDPc?=
 =?us-ascii?Q?ZRNTAQTHpzZkv9MjArAIyv8Qd//9BeGfhC85JdYmCRxB+RsKZpUIMsvoZtCn?=
 =?us-ascii?Q?OliLZ0wVZHB0ZaTDVFJG3L6hhV1gb1LCzEU8G7Xz9WoDfmxUAWee2uVK8Hqs?=
 =?us-ascii?Q?Ra0JQaGv+XhgUDzXgyanBS0Cy5Y0yjA/EPSQMeJ0B6UjMa+E3vGUv6hjmXVl?=
 =?us-ascii?Q?cRDP9gjJ3o0VLJ4sMsEzLGin+zHSF3fVcYUGfsoM/A8Y+U6uph1bMG7u4mJO?=
 =?us-ascii?Q?AOLuL8YGxVdeiSzPn77NhGLWbUZ2+DdhVBcF0hmokjVtl+XPpX+jZY9Rbp+i?=
 =?us-ascii?Q?taFAqdBUlm2iGxYVfGE+tuyBQWYvZJ1v8zbyvhv/NZvJOk7qAd5l8Vo+EiWx?=
 =?us-ascii?Q?um1uWDoXXzyPD+sPhjKQrhMQvS7hWMZssVqZulcmgJxbG0TaU/kenCs6YkTh?=
 =?us-ascii?Q?Cl/Rl0im9fL84izAEGPQog0x9hrlECQszY3SnioUdWn8AFST5wgy1iFoUZ9L?=
 =?us-ascii?Q?TTE1Um9rs4kWp7f3YsfElzMinxWvkbgtT64iGYG+dHdUJFtCT69astVTx63A?=
 =?us-ascii?Q?OOtXVCvq/wgxdIfeEVU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5f7a76-03ca-41bd-3074-08dabb27fc34
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 10:09:23.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLmn9ydyEkqtjdMdLYATSjIFRtic7b+meMuqgzskDTw77RppKdOAx0hdAU2wN97M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema for the pinctrl driver of NXP S32 SoC family.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
 .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
new file mode 100644
index 000000000000..eafb9091cbf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,s32cc-siul2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32 Common Chassis SIUL2 iomux controller
+
+maintainers:
+  - Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
+  - Chester Lin <clin@suse.com>
+
+description: |
+  Core driver for the pin controller found on S32 Common Chassis SoC.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g-siul2-pinctrl
+
+  reg:
+    minItems: 5
+    maxItems: 6
+    description: A list of register regions to be reserved.
+
+  nxp,pins:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      A list of [start, end] pin ID boundaries that correspond to each of
+      the register regions reserved.
+
+required:
+  - compatible
+  - reg
+  - nxp,pins
+
+patternProperties:
+  '_pins$':
+    type: object
+    patternProperties:
+      '_grp[0-9]$':
+        type: object
+        allOf:
+          - $ref: pinmux-node.yaml#
+          - $ref: pincfg-node.yaml#
+        description:
+          Pinctrl node's client devices specify pin muxes using subnodes,
+          which in turn use the standard properties below.
+
+additionalProperties: false
+
+examples:
+  - |
+
+    pinctrl: siul2-pinctrl@4009c240 {
+        compatible = "nxp,s32g-siul2-pinctrl";
+
+              /* MSCR range */
+        reg = <0x4009c240 0x198>,
+              <0x44010400 0x2c>,
+              <0x44010480 0xbc>,
+              /* MSCR range */
+              <0x4009ca40 0x150>,
+              <0x44010c1c 0x45c>,
+              <0x440110f8 0x108>;
+
+                   /* MSCR range */
+        nxp,pins = <0   101>,
+                   <112 122>,
+                   <144 190>,
+                   /* IMCR range */
+                   <512 595>,
+                   <631 909>,
+                   <942 1007>;
+
+        llce_can0_pins {
+            llce_can0_grp0 {
+                pinmux = <0x2b0>;
+                input-enable;
+                slew-rate = <0x00>;
+            };
+
+            llce_can0_grp1 {
+                pinmux = <0x2c2>;
+                output-enable;
+                slew-rate = <0x00>;
+            };
+        };
+    };
+...
-- 
2.37.3

