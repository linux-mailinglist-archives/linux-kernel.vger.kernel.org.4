Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272217328DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbjFPH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbjFPH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E42110;
        Fri, 16 Jun 2023 00:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLIazik4f35cIIUUsLK3+I7x3TcldgZXr2+Klzt1VSdXSI//+J1baxafSaCqgNJUE0V3JlVx+FN1Ow5wcdPxE51YZg+qAXASEF6s7M7cEyPUK5VlOSS814D9MenVxHfo0cr5JGMGtGFWjwDRPAAN8qdBC5jCEELSdS3jYBD5/AbGz85XY2/gjE2hbNk54QPhup8QyvjoAR/ykv/GMEm3GLMT/fOPmYCYq0gwCpoEuC3y5UkuhcqQMUlsmQjLGnjG/cf8VYiQplIvKvE2Ez6fLBK0MoxYlFw8sNeQ6nmDvUpOZeC5rYgvFVQiBEd6YCspOYgWOguBVtI6K0aQm/CRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCrl4ZbJ3Kh6c3qmxW6uwwiFwGgNUB5sft9lr3jk/K0=;
 b=leNV9MM8h8YzBhcSA16692qWCBl6G+6Jg1ePZUufGtOH2nTfbFRHFnC2iskFWV0FT86gsqS7t+9YaBd1omLX7mj8O1OUZXZzUFnPG4HejSs1lTTvtsxlllcUtwuRMJkBd+YI5XC0RRLOVFwQiZUrWvFKplhAvJwj/MnOM5TCebwjrXheFAghq84BqGnUx1sLMWromWqnioziii9a8kYF6/mdXyByC7OotsiDf5XtXDJS/k2dCMzNWaWPu7+ouHOI50rhWPa+Xi3RE41yveuMur2b4VCIKBpdANoJP3FVOX6+fm0OmoekzytER0JMwnjCe4PckehPnsorcZeBbtT4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCrl4ZbJ3Kh6c3qmxW6uwwiFwGgNUB5sft9lr3jk/K0=;
 b=X4a67l+3865kTscv7coywZjQRUHZn6/mtTt6hLIrxT4EzVSIuHILZQUAlUvxpy5zL8wfIAin3RRl0AFu6x1Br7glh16/unxmVqOJ0YlgQBOBCKrbU1752P0hsBRa/HAG8N7wXFK3FklzWJ7qHkrMk6tmyRHefp39EP0eUDSDi2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB9916.eurprd08.prod.outlook.com (2603:10a6:150:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 07:29:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:29:11 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 16 Jun 2023 09:28:54 +0200
Subject: [PATCH v3 4/4] dt-bindings: input: touchscreen: st1232: add
 example with ts-overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v3-4-b4fb7fc4bab7@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686900549; l=2481;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=u41+vfnnWlumMLfPi3uNqi+j7l8YievMuwAbZnCAEtc=;
 b=weaZMYa9i73fJy1hCjWn5NlMCoWNIfZ4Y3iRVyNC5bpL69dtSHvgusSHOPYx9R6Fcda5m3/Op
 QW4SrIFOKUlD5D1QCT/yRniZfm2w7EwabDe9rdHAuUZbE3sIGo7VOto
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8d9333-7a74-4369-4e8b-08db6e3b60c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUFFTODsQK6ruovUgingej42hKFKDl4emCCT5oFWqCTLlQlGiISZ6bvIFl90NYQ7l7iTjlIQSkIJ48njDWoWRvNTQ/DdQb5oQb1FyPlG/E90wNby8/qS6JpZx5Re7ILd3GHCE/jP3WW1fsh8MnmFBpoiKfV5OBJ9jbOIDqsDVpy1Nbj6aHG+D86RXCkliTx+AzsIIVgLiuyZFiX6ckbYmtcSuKx7ZuDOtxlOGVOqXbVeUEOt55o2YXiVlvXmNG117B4kmpy7YYlQgX03wxdz0YME6j/XNJ70j+cuUchAWCN9dErQi42PIwe+yebBLr/XfLImjPW6J3f2m3vggyGe9RZNwCI5CMtcndgp19aNUWDUw3bXw+SCRjADjVt2e85r53nkqwhKa8yzKUMup9+anThmk2nxsnBDQpxotqXwoua3NFdCGuad6qwbniGfYXgpxaaUqfwIPoQKgHxUA7xnbYuTKcnaLmPKhxTaEEwYdpd8zrTb/LHH2MknnCh6lEmiuT0SJa+E5mBYbesfLvRT1Ga3Wk+AchNEauV8U/zK/7wQtK1aKj+VkuZoXFqaXjcGtkREl8G9wGeNnmjuXhdDpS1lRh3EFmy67r+slYSd6JRorZ3U08/yrS3QlXbp9SWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(36756003)(86362001)(2906002)(44832011)(83380400001)(6486002)(6666004)(186003)(52116002)(107886003)(6512007)(6506007)(26005)(6636002)(66476007)(110136005)(316002)(41300700001)(38100700002)(4326008)(66556008)(2616005)(38350700002)(66946007)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RLMkdiS0FXSUJVYUltV05sdElSY2VXR1MzWi9CeEhUSC9NUi9zODdXVXRs?=
 =?utf-8?B?c2hUSDUwTXVsN1JFcEtFbUJCZ3Joa0ZRczZUV2JOUkorMEFsTDZFWFlBOEVQ?=
 =?utf-8?B?TkVRL0x4aFMyU1hIbWVuWldTdytYZzZXU0JMa2syd2NmeFZEQW9MaUk3SmdF?=
 =?utf-8?B?MUNzdGJVY0w3NTRLWFh1Z2p3SHlYSjhCbXlaNGV1WWt4Z0ppcENDV0hyY1RY?=
 =?utf-8?B?NFdxSGU4K0tLWW93Y0oyd0V0Z1Rxa3pVS0c4ZkJzR0t0Vk9tZEhiODAxeXlo?=
 =?utf-8?B?aHJNM0FFRFhSVjgvNjZZOWxkUm1uTmd3Z2IzZlJ2WFU4TmNDY3JXZk9LS2hp?=
 =?utf-8?B?SGVkUXlOci9qVU5jQUIwYmRPVTB5N3dZaGw1RVErNEg5NWZrRmZNUFFIQ2do?=
 =?utf-8?B?Q0J0Mm5yTllPNEVaUVFsVWYwbkRzNVpRd3ErMjZoSEQ0SVZEaGFTNGJHMFVt?=
 =?utf-8?B?N0RQZWdCSXFUeEhUbG1sSWdZL3lzaEp5emszdjF3Z2p0UXJFU2x2aXlDZ3Q1?=
 =?utf-8?B?REhUQnk0TGFodGJqQW0xM1B2bk1iV05XdjZwM2hZdWRYOE5LYjg3V0VPeG5y?=
 =?utf-8?B?MFlOTUE2WXJpNEh0Rk5Qd2l0Y2ZINTlCNmVMTjFiblVvdUd0UGxmaVFnaG52?=
 =?utf-8?B?M0F2MVJwSVdQZW1TaVFYYnFTd1BkY25FeE8zU0pNZFNPVTY3TmN3bUhQLzli?=
 =?utf-8?B?Y0tDOFBBQVFPSVVEK0NMYktSck4weUphVncva1FHb0w5bnVBWnFCNkx5N2Ey?=
 =?utf-8?B?bUdsVWdPTkh3dVJpaXE4TXpqNzZFbTJOeE8reitEOEF0eExzdXM3OURBOVpU?=
 =?utf-8?B?UGdXbnMxV0djK1Q0RnlObTlneFh4TzhpVmJzME9Cd0srVzZSaFd5SkN3R3lT?=
 =?utf-8?B?c2VFMnFiSTNLVDUrV09ueHdoajNPNkR1TkQ4WE5vUENlVDV1Mm0reFJMOVky?=
 =?utf-8?B?YUJCWlNSenVpSUhUSU1LTS9SdVNiQmg4SjJvazcyOE9RelJXSWNiY1NYeE9C?=
 =?utf-8?B?bnhnbmxwb2M2UEhUTGRRaktxZnZPOXVTUWpyTGZOTVMxajNGOUFyRG1LbHBi?=
 =?utf-8?B?QWlKRjREb2NjbWFQdVA0cU1jV21Sc2RiUFJsd1BVNGtyS2szNUlGUFF2VVhu?=
 =?utf-8?B?OG8wTWIwencvMzE0eFplM3ArWnNoMlp2Q3ErVjdkc3FIWUNHaFVwbUkza09y?=
 =?utf-8?B?bEtOYi9lcTNoUnNRK0tVcWdFU1hMWmFWNlMwK1JYTVE4VjRvNC80Vnc5Y0hM?=
 =?utf-8?B?bGhYalVMdDdoV3FyUVZqR0VBdXhNeGt5ZWdkM0Zob1E0d2tSUCt3bTdYbk1s?=
 =?utf-8?B?Qkg1bXpoeE5ZVCtZM2V1OXJMTXRIV0Z5dEpJZ3NqYVlMaDVvQ1dET3BRd1Ay?=
 =?utf-8?B?eVJ6K0xoY0JDVEpsa3pMYXJ0RUZxWFVlRmpobGtydC9KOTNTOTJ2SGNteWVI?=
 =?utf-8?B?dzVYc3NPTDhNN0s4a2pEdU40VmpBbEZjb1VocjVMYXplekxyajhWS0VvdGZk?=
 =?utf-8?B?SmtBTHA0YXY4RlhPcHQrcmdWK0ROOGRxMWNFbGRtNGlHNFdlUGFRM09IUDN5?=
 =?utf-8?B?TTBUMkZjd3NnTUozc0kvK0FPcFNsT2VvMmVtZ2Vob0JmZ0VZbmpaY2JwWEI5?=
 =?utf-8?B?YkpjOGw2dEJmbHdwaTVqd3h0QzF5TkRMUFZudWdZRlFzdXFtbkV5TFZOejcv?=
 =?utf-8?B?a3hkMzlrRjFOWUtNOWFPbERxalVmNk9OK0lNT0o0R08yNExPbGtJUEs5S1hP?=
 =?utf-8?B?YlB6cmdRcXFIejJlanpDMHZOS0hjanZzYzBHblhxNUJqZmwya0lCZ1VVQ0Fo?=
 =?utf-8?B?Z0cvUHZLNyszekxuL1VqbWE0S0tqWTVXQjhkbUduRlhYdE05cEg0eVVpZm1P?=
 =?utf-8?B?VkNGenZQZXdyZ2YyVEVWUGRNVzFNdmRXMmorSVhLbkZ1YjZDOUdvYlErZjMx?=
 =?utf-8?B?NHROTi92ZDBwektXQWJGejZiSkNobTdiT1hFZEhmZ3VJTEhxR2hoR293Q2l4?=
 =?utf-8?B?ZlF6cDU5eE5Sb0wrbUJwYTVDbmdUZVlDWlJZQUNCVzFHdDJQS0FGY202dWtw?=
 =?utf-8?B?SVZOQnJrUnFlckR5V3RacE81dTcySE92MnR4azlkb1ZFVDdvZFdjT2pXMFIx?=
 =?utf-8?B?bGNSK1BUbFdGd1MxRGxkcjRzSTV2QmRuMmdweWdrNkozNy82SUVNalg4a0VB?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8d9333-7a74-4369-4e8b-08db6e3b60c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:29:10.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gUUfkHwaU+P/lYEDVSqr/fb9l5tGySubc4o2OHlZfFMbyG3fUHf5q5JUva+mbmPzOhOxf21W0273UNQkEkWEy4+VDPIAUDb479hsGSlmDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 driver supports the overlay-touchscreen and overlay-buttons
objects defined in the generic touchscreen bindings and implemented in
the ts-overlay module. Add an example where nodes for a overlay
touchscreen and overlay buttons are defined.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..6cc34e4c6c87 100644
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
+                    overlay-touchscreen {
+                            x-origin = <0>;
+                            x-size = <240>;
+                            y-origin = <40>;
+                            y-size = <280>;
+                    };
+
+                    overlay-buttons {
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

