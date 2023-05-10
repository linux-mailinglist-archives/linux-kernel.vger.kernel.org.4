Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8806FDF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjEJNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjEJNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:52:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D232130;
        Wed, 10 May 2023 06:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHYTWhUVE6QZZNfpPBt9XQveCJFJnW9xiSntG2UzSXceRza06YHaZCUXZkQg2DG7VqjFqOe143FDTKBY6mldWCMchZoLuAKn4HmwvzXuc986z0AO91b4y6sle97Z0ssmG35LNgpzvfloymfC03NbQwEYlDuH8HEaz7ove+c0rgZNNPaX1QwId/M4usZl9DylaBs1ejHmnMHCXAJnp7stPuGapOqevwxfpfRBWAVXnIf2X4q+ewjEQ89vxE+hi9o3KtwQ4I0MO9SyCIctp4D3BRzLi/9TOizZT86YmRZERux9rX4C6/bLr0uIX+v0LLk8LP6w3GxL6VyOviO42OBHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/w98p7Rv9XfeHIsLTjEjGeRBBY+/4FbzuuN0XWRfwI=;
 b=MsTR+tyipsU7lsIwkkWcPeOjmoMlyz5OJDdhgY9VDIativyC9xJNzASDTjdErEg6167vEQ/w5IQs3PzpQPwoSrmzIYq/nGQNrf/X/t5VPxkfG8ZoV9gBUZ5U0zuNgq/je8jk7t6TKQGDKlICvuMu1HfGfvQgY58zFEglsOHg9S15aFxXATr1/eoHmzBP2n3b/KhzxdpBiqUcV5CQqyIMGv1I49CLQaoi61FdIM/iXPhVZ6+qw4dHbaND3TK/Qa9QeQwKr6AHcabPD7OCIcOOgcp0Q1JO4joHnDpy7MJ1y33VJetDABxQyoPIaqh/6d/pJoTzyrHNMJwEaHaJCKAtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/w98p7Rv9XfeHIsLTjEjGeRBBY+/4FbzuuN0XWRfwI=;
 b=RNCI5YYBjSJGmFCf95qXXXDtm/nBgNN9bnj2dNIlAnmZ7wYubVD0bZSlkEF3IZRQ9LU5Tae7GaUMnMtECHcC5L4WMd24vT12sVgKPUMHRJOqrW2RiVSoypvIqyDabINMrZ+PysnCT0kNlrjrpDuhRXlqyDShMbYFBlGuTa1eAZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB10212.eurprd08.prod.outlook.com (2603:10a6:102:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 13:51:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 13:51:13 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 10 May 2023 15:50:49 +0200
Subject: [PATCH 4/4] dt-bindings: input: touchscreen: st1232: add example
 with ts-virtobj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v1-4-5ae5e81bc264@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683726670; l=2481;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=L1HZGtYon0Lsj8171GCXGrnNhGVlNBwOHdE3pp0WTB4=;
 b=lkvjoEGqMVKC47UUSoWEIcyfEkqJJWQlBhDKJ2MuLqTvnXUPdFUa/PY90PH6/aUs7HED/PiEp
 H6a1SMtjfugACpmVRfiLZzual2Jj7vCv3QLDdgSkjlJHX+QDQc3W3jN
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1341ba47-dcaa-46a8-6d2e-08db515d9e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhcUYR65ibgG6bQ1MmzsMtQrPzWsyq7SRwfelWJSrUAITc0/9yZAYD3Z3pEewxZNIGfd699M1hRepUwKgRibULLDoN23+O7A9KBYiIWbAgm0OBqV1nhZQe5mxp/+yYwMZ/bAHq9v0ZxBHdFLLFns1FPyY6aTGfqXp9JrdfRzG098V0Ab9JMl+YimYETXfQbCoQbVqQnywOkffuK/jf6jkoNTrGvm6Ui6qtbvQeyQ7mSjU7GU0uclz6lwEqeju6eqv01+YN7QCYvZI/XRHRLNetdSyLsyCtBDfHsDTGv3lLNg0rBuNs8bXyYvv/413f+EVSeCXZsGhC17Pixq4opc4hMBaHkVVPl5mJ1b8S+JyDAkf7IUSJCtheq4h+d1gIoaSc5loLMqSBHxsSSCeBLSFgM4moDVTr8nsN/p+tN4I2d7sKi7EDW9ruREvsi+nV9R2bq1DSaJjrzcBvy8nxFFqW7NCP5S/ucN1Ea0Yhs5eOJ0zLU0iMEAX2ObxWwMNuMohl8OUPa3lwo+mrUEgWMZ8tryeAl+Qbaq1ggV/Roi0gh5Yy/LvXIO3+Bh8mTxg9t7YQMwWUE53yCDoGKVofcN+TYoJnl8mMTMX8wwLiIkacg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39850400004)(396003)(451199021)(86362001)(36756003)(6666004)(110136005)(316002)(6636002)(4326008)(66476007)(52116002)(478600001)(66946007)(66556008)(6486002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(38100700002)(38350700002)(186003)(2616005)(26005)(6512007)(107886003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZKR0lCVFhNZFV3MmdXRTN2eWlPUlF3ei9UT2o2S2lTL2xHcndUSXZUWUVR?=
 =?utf-8?B?MVBPT2l3NlBMNlFiNDZ2b3JIWlpmSnJkeUVVV3pVd2NkVmZoNW5EVEtSQlpW?=
 =?utf-8?B?NEJ4VXBVdytDZmFpRDNzTWx3YUdPS0RkbXhqV1UxSTFWTzNyTG5RYUN3OWM5?=
 =?utf-8?B?azJJMUROcFVSTmxEanY4R0N0Y2NsOHV5RytRTCsySzU3WEowQ2RUUThGanRM?=
 =?utf-8?B?dFc2WGR1Mm1VRlZTRStCeWVRZEpHVWlHT3duUG9qUTVXY2NReTJnVTVDWVl5?=
 =?utf-8?B?amFQc2RPVzY4cFd3YnpzbUlqUk0rY0RwVWRtSXJIMWswelhpU3V4NkN1YjVs?=
 =?utf-8?B?UFk3YzNVMEZSTThKcFpuNVgxOFh4SG5qWXAxMnhpOGxOdlhDd2RTU0FKcjlZ?=
 =?utf-8?B?NWtZV2tWL294enV4V1FOS3NnOWJLQzZ6dW1TaFg5bDhHbWZiMEkzUDFYZk9s?=
 =?utf-8?B?VmF3bmVTSmZlcmJpTGIrUld2RGk2dkhlc1QwbUZJQWxVZk43dUZ1SzBWYlR3?=
 =?utf-8?B?ekJIaWg2VFhyS2ZjT0Y0N0NNSFpmdGI3RUtkd2xsdCt2NnA4Z01maFRRSUN0?=
 =?utf-8?B?c2pKQjh0YzNVMDg5UVhKczA5YWFPTVdsY0w4cGxyOVJwaFNHMUw5WnQxMGsz?=
 =?utf-8?B?OEI0NlQyKzB5dlJwQnRwY1YyNnhWNkJIdzZLY0QxcFRTYy9peW1rbTRMQ29D?=
 =?utf-8?B?c3BUbW1MUitQSnpqMG5KTHhNOHRuRVpqenhVamZtTXBPZk1kL2NYS3dySzRX?=
 =?utf-8?B?dUV2YUlFTDhBMURXclhZM1BMUkZ3NkZBVDBRb0lCZVlWYnNuYVNUdlJxbG9R?=
 =?utf-8?B?cVJyM0R6Qkk4OHlGNldkdGVaOWtVMjBMdFAyU1U1R2hVcEhSUlJPc0pSVGpq?=
 =?utf-8?B?RUlvSjFaaHdhTENNVDdVUkdvdHBLUWFPNmxDZzVVeXF6cHJRc3p4a3F2VHN3?=
 =?utf-8?B?TDQ5bnVUWUZwUDdsckdJVUhUSjNIRFQ1djFIWVhtQ01kNVo5eWtQRzF0MS9Z?=
 =?utf-8?B?MThXb0JqNXQ5cEZPeDdDV0k2S2NkeEQ3QnI1ak1rMFNGOFY4aGNyYW9mQ2NN?=
 =?utf-8?B?RjJETXc0MmdQQTZLUDFqbUZiczNadGZLNlR5dlpWUENnSktQeUU3cjN3TzBJ?=
 =?utf-8?B?VUxnNTBmUFVXZUVMVi91dUpqbUdhZlE1SHlSMjlzZGVjcDNmZnNnbUhqNmpG?=
 =?utf-8?B?cWNBcm5XN0RnYUZPY3NiMTF4ZGw3dG9Ib3F1NTFFclh6dm9ML25tNGxFOHlY?=
 =?utf-8?B?aUFuREJmRFZyZVZlTC8vTjg1TnJOdjlGQm1mSS85d05EWU5jWE9USVBUOHNr?=
 =?utf-8?B?WFdYUjZ0bTNsNzFUblY4cEt3M0hVMFNvajBiRWZ0MkE3K1BYWHZmWnZOV3B6?=
 =?utf-8?B?L3VySGw1Ym1FaVcwd21IL2pNVXNoVUxEeGJZa05UWm5LVGQwMDh2QWFnK3pT?=
 =?utf-8?B?cVNRZ2M0SHRLRkY1bjh3TGxlbU1CN1dNR1FPNDV5YWhKYlNGNmkyeWpza2ox?=
 =?utf-8?B?QW0vRHNaWWw5WTZqVkNXZVNlemhtd01qcW1CZWhUa2Z0bStOaU8vakFVSzA0?=
 =?utf-8?B?eUFxOTltTWtnSXFNMm53NGsvNGxrUFBkVVpHNmdHcEpacWcyTVhWcjA1ano3?=
 =?utf-8?B?NDhRWFpNQSt0SUNZSnZ0SkpnQnM2dUNRZnNBWnhyZjlXYy9MT21jQWo2Njlh?=
 =?utf-8?B?UGtLNUQzdkxseWd3ZXpJclFxdkUvZHppVm1EamZ0OTlZLzZXS0YwTElsYXNI?=
 =?utf-8?B?ZU5vMkh6eFU1aWhtUFlPVGNIZTBlR1FHZDQ1TC9mZ2J3VE1UUCs3Q2MveElD?=
 =?utf-8?B?OENpMCtqT1ZWTXdkTzdOTC9zVllQWlJldE15eEdDSzh4QWlnY3AyQWdpWWpp?=
 =?utf-8?B?WlZ0Y2tFM1kyYU01cjNQMmUwQmdxMERjV3RmeEpNYnpaekROQ2pLOXlKUXk2?=
 =?utf-8?B?VzA3ejZreUVlZUI1dUVTZXJ5OGpONFNYNWt6bG81RGM4MzBBcVRZYkR5N0dm?=
 =?utf-8?B?akh0b3QxSVY0OTcyNVN6QkRBYzhENlB0MCsxL0VETm9rdnJwb3lQQXpKZ2VC?=
 =?utf-8?B?eHpFOXIrWW93VTBaYXFFRzIzV3dYd2srVndiaGw0eWE2WU5yQU4xOGRqWU5y?=
 =?utf-8?B?V1RkRXZXYnc3dDF3dFJyQWgydCtueXR2VS9QSDc0TGdTaHZtaGt3TUpqNnVB?=
 =?utf-8?Q?TaUlK8kjAXbjeUd1ZEy+7+k=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1341ba47-dcaa-46a8-6d2e-08db515d9e5e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:51:13.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk6bCu9Eg6kUDXfLVxMpOI3DMS7hq6bZnrnAZG2FprnsCIXwOgmFFrRG7HavRubFa+pF333LdAA/+u93A+ANEsrw/m7XsVCsaTLw2p+DVlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 driver supports the virtual-touchscreen and virtual-buttons
objects defined in the generic touchscreen bindings and implemented in
the ts-virtobj module. Add an example where nodes for a virtual
touchscreen and virtual buttons are defined.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..97a2c063b47c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -48,3 +48,43 @@ examples:
                     gpios = <&gpio1 166 0>;
             };
     };
+  - |
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            touchscreen@55 {
+                    compatible = "sitronix,st1232";
+                    reg = <0x55>;
+                    interrupts = <2 0>;
+                    gpios = <&gpio1 166 0>;
+
+                    virtual-touchscreen {
+                            x-origin = <0>;
+                            x-size = <240>;
+                            y-origin = <40>;
+                            y-size = <280>;
+                    };
+
+                    virtual-buttons {
+                            button-light {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            button-suspend {
+                                    label = "Suspend";
+                                    linux,code = <KEY_SUSPEND>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
+            };
+    };

-- 
2.39.2

