Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DA7030CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjEOPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEOPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADE10C2;
        Mon, 15 May 2023 08:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJhYjWBw/SxGZ4mV2Ot7i5X7/oa+UaId3qbumUTHnpMVcoW1J8lsHV18pYfw6lO4wYD/irrzVHfVfZf5iKPuUfuvn3iMy8ubA/lPX/S3UTAbmaR45xlgwoRm7oRJCUFDXmiklRFCjH7vpaoEnthZjRvPrkuY8PGrpi/bVPk2G4Pn3EmKVi0qK4Vsiiy40Bfb+XCZEHmqu5u1SuwtX+VdhlGW5U1N7BmzSPHPKQVpH9H0NzLY/PiWhrDl0jKOF4hhGtPvFl62PelQmv6FQbIMtzPuXD5L3sSWVqm6fTytN/2uHzkmnftHBBn9DQ9fGP7fnv6V7EczA7HjVF/mftAJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/w98p7Rv9XfeHIsLTjEjGeRBBY+/4FbzuuN0XWRfwI=;
 b=n9ci8VstWoSt076hQ2rFXYIY/4+jfVq93oqY/1Uj7ECz2cdnzd5MTblsNznyPtSBQujkE2WqRdlOH8y8NVoLRFuIiM94nf61exbnZTARmepWBFak+5TlpJtv1VhOxsktaJ4p09qUhwnVhZsUZ9Im2fyHtMqKgwehz2M5iBJCE3Hu1lAoI2IKlo0RKRrVSvf3Ena7mcMO+Sb1IPQ8c9BumQEpmqgFTpycgiDePsOwD5AWrbT0d+A3O2EJRxh/09Y4PPmXDC1fJ4b9pCivgwW3CNKQzHiW6ki39wOU8l1+0KrR8tnIQrsmHXaUkBbyezSwK5qWYZxnBGcmdj6S7zT1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/w98p7Rv9XfeHIsLTjEjGeRBBY+/4FbzuuN0XWRfwI=;
 b=bdsTSG7+0ALEC3wpmZpJovQT8XTXyHgOdVpwm5DU4pBPVWxM3OYB7IrSUdsqmJVDF/0GerhMji3QsP2WLCdSRG14JwRkqYG4m5ivsAttbh+bfTvKhGD1ZI5FvznRKq8AN+e99tb+xYr58k4WXbkXL3DvLLycRgeehNI/HajhF9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB9982.eurprd08.prod.outlook.com (2603:10a6:800:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 15:01:07 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:01:07 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 15 May 2023 17:01:01 +0200
Subject: [PATCH v2 4/4] dt-bindings: input: touchscreen: st1232: add
 example with ts-virtobj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v2-4-f68a6bfe7a0f@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684162864; l=2481;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=L1HZGtYon0Lsj8171GCXGrnNhGVlNBwOHdE3pp0WTB4=;
 b=RSy6sQKnTs6FG/8jZef0jKE9dkRm94wCFi/4KxuvfB+Rs8qPhYEA48oMtppQ9JwfqxrNt5msj
 vqFQwsd7XH3DPE8jgcvH4+Vq0+sIUu9FMeAHXyINW2XLW8hyDAhUyRl
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: e10db002-eaf2-4670-8c10-08db555535aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmbw5sfIxWM2Xys/rjbaLGVb5Qes4/kWvLUfijxQTQVPvarI8io9gjEI6/Ho/CEDdGbrYLNEJixwUSikFMdaGEfQXMtZIVI2ukTZn6H2T/i3t1i/7EFpVbL/1qsb4Ua10XcNC+MXXdsNtEpTiFmqLO/XpMSAMLYQ/MY15kFWIQvEW5ySreLr0+XjcHGr3BtUpt6NSgpkz2nLD4WfNeIUkdwwfSGjTjjkZm7PlAwwZZ1o6A9MtjAqKwqC+uzr6KYEjs+91Q0x/hb1L0hL+c7CJ/U89wURXKoJKSS6WfcIiXvnw9tZjgVB0eRSRSCMTAZVYp/7/Q00rdyFSDRzlc+kHRZqvraf/B6g77ZdQcPWVYUoEk0zMH8fqxsHxmsSFnEp4PKDkN2qwqxiv9Q2HfdMvLtIZMc4ZmAGihZHf2/CdmCqL7OXnGIn+H+SwGsV507ybCTvEuQOxScFBVzQCWHERmnRhzeKrkzlb2kUX4iMhJVQGhShSF/kr5Tt3iCtKYP/B3YwgmqvgUxiLscX4ZfymAClK5MByhL2oZPswNz1erI/9e8YUaqXUC1b5+UnKSX/qnnEBvOHv+CRdBIByaiVE1xZfySsC48qD2664V3ECc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(478600001)(2616005)(86362001)(6486002)(83380400001)(6512007)(6506007)(26005)(186003)(38100700002)(38350700002)(107886003)(36756003)(52116002)(6666004)(110136005)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDR4UG1xY0hLTHZKeS8ySFZITTdtQWhFME9zZHJIZ2pUY05WKzZIaW5sOTJo?=
 =?utf-8?B?aEI5TitZNEdOSkEvUkkvNVB5aEx1OC9LT2hnSDF3bVZVNFltMnhaS05mQ0VK?=
 =?utf-8?B?VXhtSmpScElSL2JxT01kU0lBK3lVOU8yOE9mWVdVYnhhMHhYbjdlSENyVFNv?=
 =?utf-8?B?Rlg5eE0rdVpFNTl0N09NaTQ3YmtYeE1rUnFBdVAxYnphUDFvVUtnU0xSMkc4?=
 =?utf-8?B?d2pkeVFQN0ppOGxKUzBrOENGUnMwNlNoVk56alNlMXFVZVVWTkZ3KzhWdVdQ?=
 =?utf-8?B?T045Qjc4QzczMXVKcndPSjVVQVZkYkZYZ21XNG1YOXV5aS81RmtZR0JjNkhp?=
 =?utf-8?B?emZsbE9LYzNNWEx1QVpEVVRHWVhYQlpYTU41ZUNOd3FMZVUxbThxSE5DV2hF?=
 =?utf-8?B?bVNKZWJQdnpuWWpqZE80VlR2a0wvK1UzblNOVDhZMEdQYVgwZFJEWmVRRkl3?=
 =?utf-8?B?eXNySVcwOTdKN1NUNVg0andRTmxBQnNtQXlvMzA0cHlNVXZRdXBhQTJrL1Bl?=
 =?utf-8?B?dHpQWWFWdWJZZVhGOUJKd3hpaTMxSEhkNG9QOFNSQTlJNnhRRExSL2tLUFJO?=
 =?utf-8?B?anVwRTBCRHlHVkJFNlUwMCsrbE1jQlppOGNRTmFBZm5WZHRNbGIvOUJPWXdl?=
 =?utf-8?B?MGp5RzZRdUZmU0RSSkZ4NHRvMVpiVFB1RXZFNUNTUjVJcks3Z21RMWxzcjJa?=
 =?utf-8?B?cHFCZ0UzS1plOEZ4OXdYWk5LNjVycE1tL0ZFVHd6dlM5Tkw3OGhOdlhaWExY?=
 =?utf-8?B?RllaUVZXSi9iSlByMlJJR1lqSlk5NjFhRDlFMktBa0RMbUNTaXJiZXhJMDFZ?=
 =?utf-8?B?T0RqWmIramVkOU1HRzNkTlE0dk5QdlRlY3dQSDdJWjZhdmJROHNCamdkMVpB?=
 =?utf-8?B?WklRZ2hGcmhPSkFKZzJvcURmNjBSalgzMWwwdzNQdVF3VG5QZy9ZQVhuZ25m?=
 =?utf-8?B?VXE2aGU5SnhsL1VaUlQzWFB6ZjhPYXRRVTQ1K00rb295dlN0WEhFNFM0OVJS?=
 =?utf-8?B?RElvS1djSEdKK2Z6MG5rSVBWdThuRlNYeVZQd09EYXVQQ3R0Mml1S3JTcFZa?=
 =?utf-8?B?QnZCSTBtYUV6eFlYcXRuZGNOcWhQdnc1VHc1QmJaTkZNWVArY2R3UXRsRDVN?=
 =?utf-8?B?UGdzOFA0T0hHNStHODRmdUdVUVZ3NmZKb0ROcXVoUVdscDE5Rk93dGJtS25q?=
 =?utf-8?B?UTkvZEtHeWFLbmsrVy9Ya256YlR0N2FRRGlUNUV1a2dYUWdEb25oMVFNRmZH?=
 =?utf-8?B?bzJRUkplRlJHQ1JEUm5lU0doWmtwY1hwUE50VUdqL25YWjFRVC8vQ1hLaHp0?=
 =?utf-8?B?Tm1SREtEdlV0MW1acjdCeVRDMTJneW03dVZZZHZiaTMvTkxBSUxGaUU2K1JC?=
 =?utf-8?B?QjlwNTZQbCtCMmViZkF2b0FqUzQ1cldoVHNKSWdUdG1ZZS9TdTdZUEtEcDY1?=
 =?utf-8?B?YlV3c0hwbE91b21rRE5uNUpRbFhnazc3WGhBKzJaczFScDlSMmhSZi9rTmo0?=
 =?utf-8?B?WmZHa2Y2eWliUC9US05uWDNBTURuQjdhNk5EUG8xSVJ1QzJXSnRBei8yUWl6?=
 =?utf-8?B?VnVIbm1EQnN6dHNPTGdxODNuVm9NNlE2NmpjMjd6cTA4cnBCZ3plNUMzRU9K?=
 =?utf-8?B?ay83cTE1alJ0WEhJUXdoekwrNFJ0L3VueUxzS0ZUZTZqM1JaM0tnRjJCMmZy?=
 =?utf-8?B?OVg5Tjg1azdOaGJWTExPQkdFOXZPdVVWR0hhU3NJY2hCVXBCRTJub0QrVklC?=
 =?utf-8?B?SnhrcXRydkltRTZqWE9SZC9Vd1hJZjB4L1k4YXFpS3dKeVlZUVNjNG5SY2JM?=
 =?utf-8?B?UldaNTJBNkppcWFOMTQ3MkpPMUxqMkdHcXNtTGs2VkZYNDRXSDlLZGsrMzNZ?=
 =?utf-8?B?ZC9yK0s0dHZaekVzME5JdUNQWk13eVg1UjducW9vaW9mTmNZcUN6ZEQwcGtE?=
 =?utf-8?B?ZXRqOW84a0NZM0JpWXVoT1lkV0lwVG9zMjRPQVRUR3ZQaDZNVGZxeVJjb1o2?=
 =?utf-8?B?YVlidGxOWmRReHBjL0FTSkRDVjZCanRIOVdjNUhzWVNUZGFLelZKZW5yOXlh?=
 =?utf-8?B?ZENBcmF1TkNmZUE3eHRjS21NL20wWGNZT1djME01dnZRN3VBdHorVnUyTkpN?=
 =?utf-8?B?ZDNON2huNzRrazcyNzdPUFo4MENiWlExY1ZSZWIweHpLZ01HY0tRbnBCU29B?=
 =?utf-8?Q?abpHOcwEcKjvmJ2f+m3A3/Q=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e10db002-eaf2-4670-8c10-08db555535aa
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:01:06.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXi775TUX85mmcGOgMuxCzHXBEGtHsWp/ED87BAKO3birnhG7whwIXlkcRgybdyaQL5jgXgKNx1XVYzzEZ3p0JKwu5D9mYNTubR4iXvwlZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

