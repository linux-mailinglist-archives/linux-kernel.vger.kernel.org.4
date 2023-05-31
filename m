Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EE718D99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEaVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjEaVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:53:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5D11D;
        Wed, 31 May 2023 14:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgZv/JSP7Hou+aQBsRz6IFhVSqA3p445+Oq8IogSnMcBUy6qYIItAmDD62HltcLUCqxHvtyx4WZpYcWSfRjBL+WKHBZvobEtGhfGZj1HkbQ5z9FHtVynPnwszRK7casIvqGVmzaTk9QadVCr1ouUgUh5R7EdgVyFKE28rzB4Fl/VVg7OW+oSbMyNu5cEH3FMh5xqQ16cFyh/ADeVIEwoeqfWKtoKcnWdfEVETqcFeZOJIKu1Q9qKlvgyoS9IGgGtRBBfPsmWPP15uHBSn2CKp8aGXHZmis+jed3qpGGv8dmADW9Iyx4W5dhumipBv69e/2CKjWTyjRopLh4Xxbbn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teAmGcFTytk4RS08rl1JVbL/T6XAMWOTB4v/mKbGBRM=;
 b=QKgA7Dszkg6ZI8loSWgJQ2/fUgGhO0ergCVMyeTaJP9arlDZQy9ARhWI2Uxqos9h8t3/PQb/YGjlP4bkgbmNZrVYL2F5Xu6KzZo8tDjYmUO9UqbfIv8PQ8GDbOfuGMdzAUl0K4/TZd38DtWg5cE89nusmzpwVJU6Jc5Avrc0StVUqktR/eSaruZbk9464DgP03UIWI9a5QYWbCF72LGAJ9ueVAubcgw1zofisMY3F1B/KgZSygO+15WHu5WXzr8lsS4unw3ZAILLDP6oLkDSPdRts+GZCTFscvDMCZwo5hIUDRI1qpYCBjrT3yIIaSmHFY4+CXTiDq1U1vrY+6VEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teAmGcFTytk4RS08rl1JVbL/T6XAMWOTB4v/mKbGBRM=;
 b=aENhRvFzTLXwhofT7oJQw7fnhKJ72IowJPiKyA44Q6ggq9PP/0otAQH3SkJPxIdGMG6vAI9upJyjEeNnQVLw9yrjJGw+tK5BTACXVsyfnUJNWEphnEoNEU0a/4Mc2vk3mJnaYGtCiZFhimI0wM7PLsfPO2jh4upmqMQMQHo2xf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAWPR02MB9854.eurprd02.prod.outlook.com (2603:10a6:102:2e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 21:53:40 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 21:53:40 +0000
Message-ID: <755a14f1-92ad-ce4b-3fde-2a4b0650475c@axentia.se>
Date:   Wed, 31 May 2023 23:53:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
In-Reply-To: <1149c073-b761-8ad3-2930-3ef10ea7cf0b@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0095.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::13) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAWPR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 112ce558-7970-4361-67f6-08db62217e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obJknQRBGHXSU6Ador+fQIisDxLRElUmVcnD5fDlN2jQbdLarvukraXFWOqrasAy6hsIw+ulFHOFFU1k7iLfJXT/urJJRoSQ7a7p0oWoPJQTZRr9Fhtimqym1ErParnhn2AmHp13nmqIZ9g5URSHvy9inMpdve8nKq9Hp1VAqQSX2iZ1AsBrGYLwiBqdMYHOWTJXMFCZofyow14S2z+AJAhfd/vmpEH8sPnb0owxbpdMmIhcRM1mzYp9k43Byv/phyg1FQjaE1USAeLUxYJ2HmK3xxFTMMJXZQGYASwzwf+ESaM7J/vfLuLi2zBUNgWbvv7mGGu8IVdtprgAcnncydlSXb0QHYbrLqLBSG5iH9Nbg7aFZJKZx5Bg6JyUfU12ncYp4BpLIwdBdXvy9lPIn0AjxPPfLguGV2bFbmcUF35RWiHxENbTGoOb86KQVgD8iEwATc/+r2OXMt5Gp6cE3Q5bj3qAwWPPGPcPqe2U2/DpvrWuOmvKkygQpr8SrXpX4ixL8LoiRNIfcBQGpmPtICYFuiUiLS2TK/maXq3c3NXt+JP8xSyONDT57/jENOtUO3p1UctlMfsqZSRJSRIqcVoNGW35SuinUyf+aGILTV6hkfxNuND2rV6C9Gr1Wdgpj5FV1jd02+QH7QgMKpJ2uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39840400004)(346002)(376002)(366004)(451199021)(66946007)(316002)(5660300002)(36756003)(66476007)(4326008)(6916009)(66556008)(86362001)(31696002)(38100700002)(41300700001)(8936002)(8676002)(6486002)(2616005)(54906003)(2906002)(6506007)(186003)(31686004)(6512007)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdWVUQ1V2FxdlAzZ2dWRC9pZzJqMk9GUDMxL2VFNUVHK2Y0MlljK0F6MWdU?=
 =?utf-8?B?NHgveFRhOVQwaEx0aGU1a1NNMUMrSlQ4V2xuY0tvVGIranYzYnljVjZtOStq?=
 =?utf-8?B?Ynk3Z3BCa0YzTWNxcGt4UHJKZkZkcHIxRkhSOWVCSkxmSGZucDQzZjBYeHN5?=
 =?utf-8?B?ZGdGZUoxdXBjcnFvbm5UWXhDT3Z2Z0FOWkphRXI3VzFraXFNcE1aT1ZIWXFw?=
 =?utf-8?B?QkdMMlRGemYwc3RoL09sZGpWVWtGQkxERkFyd3p0cnNPTEQrWkZ6Z2tTVjVl?=
 =?utf-8?B?eU9MMGw2bGNETVlkczh4Ni90ZUVoTmlYYjhwcWlndHlPcDdxM3JLb0NhMkkx?=
 =?utf-8?B?TUFkQTZaMFRLdERldURlYUhnVk5QelRDa1N0Q2JFYnBiY1ZXcUV3T1VHaHNk?=
 =?utf-8?B?L1NZd21tdFFraXMzWTU0VzVMTDFDeVc5U3k5WTlMWEZMc2ZOKzNVKzBXcDBy?=
 =?utf-8?B?TldNWEFYanlXSnhNVk5qT0I4Qkt2cm9tMnhtRDBTaEpHc213ZGVXNUVwMFpP?=
 =?utf-8?B?TlloMzVnRHI3bE9ib3ZPNE5VZFBSYXlhRklLc3A2a1FaWHc1UHRzL05JZjZY?=
 =?utf-8?B?M2FwSU83ekxiWE1WQUJFTXplZHp4RlphQnUzUFFmR3NROXpCVlA5eS9qUE8x?=
 =?utf-8?B?WG1XYy9aR0dpWVZ5NDZCbDBMQkp2c0V5U3A1K2d1STFJV2JzOWN2dlpQdHI2?=
 =?utf-8?B?WVNKWG9OLzhOMDNZZU9xYmdwRlUrbDRzUGZtYzdFNzkxOXZTdVh6L2VnS2Yx?=
 =?utf-8?B?S2hRVlFjam8zamhvcXpObHIrTHNGQ3hLdFBQeDlPa3cwQzNSWFpsN0hMN3gy?=
 =?utf-8?B?T2pqQm9NUHh2VFJJODJlZFZyNU8wWkcwM1M5ODU1ekZPQXpNT1RQY214WDZY?=
 =?utf-8?B?TEVmSFk2aFRlK0ZqQmpNUzhTZzBrQUVlYmZ2d1FmN2J1aW9hRzdad0FGMjZS?=
 =?utf-8?B?S0twVWxnYll5aTVCaFpsd3pBa3EyMm1OVFd1WXpVaHM3T0RncUxQL2RTNGVW?=
 =?utf-8?B?dFZ0RVRLVXR1RGxDVGVuNWlQWDNpeC9oRE4rdXltYnBXcWRRU3lSYlRQSXRL?=
 =?utf-8?B?c0ZRdVRSL09wY25CL2hoOGswUmgvUHVQbEZZdERKNVhJcCtqMkRIcDRUZUtY?=
 =?utf-8?B?WXlLTHJ3OE5vT3VOWktWTkhMVGRQYUNUd0JBZDlwRXJpNTVJQ3pqNUc3a0pL?=
 =?utf-8?B?bXRiWHVka1c1dkFzMVBGdmdleURtanB4UHpybGt2Y2J4M3VTZDc0YTMwdEFF?=
 =?utf-8?B?K2QrbVYzRGFSdVE0aWZRRjJ6RkY1R3dBaDJQb2pkK3BjM1JPOU5qWUU5SWtV?=
 =?utf-8?B?SkpYZEY2c2NwdE5aWkM1c1hhSW92TzlMN1JGQUdmbktPR3hzcnA0YW5acmth?=
 =?utf-8?B?VStRM1VHa1h4bm4zajRicmhVY1pxR0JnSW9kNjlyN1lIN3lOemhkMzg1eFJp?=
 =?utf-8?B?aEEyUVl2Y3hlaEFvbnhhUkF1L2JWQWpuRDVlb1VSNGZnaUpWdFQvTnRHMFBz?=
 =?utf-8?B?c3FoTnNhZlZaUmNBTU9CSjNIUEQ5TVhOeVhCSjhjTytKbk5yZFBSWHdrVXRU?=
 =?utf-8?B?MFJoUGxzQnI4Y2pmVEIrQU1LN0Ywa2lNWkRVTmhNekpRU2NlaHBqYnRnL0NX?=
 =?utf-8?B?Z3RKcjRPUXBtd1piUkxkTUJGSEpVMmw4OXdLaCtkVTdRQys0YVZGNWVrb0pU?=
 =?utf-8?B?L2ZtYVQ4Ylg5bjBoRkZ4bzVFOVkwWVpGQTgrcjFQY2hMbzdkTzFnUjg2V2s2?=
 =?utf-8?B?U25VRGhtYjNlanR5TXFRNitQc1MrOTQwa2kxVGRZVy83dW4vTXBocHEwWXNR?=
 =?utf-8?B?bENjVzZ4dXhSMkswZkFVZ2Z3SEkzMGV4T2FRN3Y4d0NOamlwdS80SWNiSE1U?=
 =?utf-8?B?aGl3WWh2T3ozSkhSRnptYlVzMnJrRjdLSTdTenBrZUZuc2dxSUhzWFVSQUto?=
 =?utf-8?B?ZmE2bzQyZmtHWXloS2RiMFBXdXg1TUFudXkxNjV4VUpiZll4YmxpWnhYWkxa?=
 =?utf-8?B?ejBCeVdPZ09mR0RqWEx6VHFXSWNBK2lQT3J0K0VpTmgrdG4yQUdWbzFBS2Ju?=
 =?utf-8?B?bHYzWW9qUE5TRFpDTkpabGk5TWpUSjc2MzU0cmhtWjlRbUtZcURtTGxwRjZz?=
 =?utf-8?Q?iCeT7ZEWSH1b6GjkHc3rZxVOc?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 112ce558-7970-4361-67f6-08db62217e73
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:53:39.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz1df+KVXY94+pA+gmmPWVGHDTnjHlUIiPLB38PsDtkv5VsXelfpj1GI+cgKSTxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

There are 4 lanes in the single instance of J784S4 SERDES. Each SERDES
lane mux can select up to 4 different IPs. Define all the possible
functions.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/dt-bindings/mux/ti-serdes.h | 62 +++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index d3116c52ab72..669ca2d6abce 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -117,4 +117,66 @@
 #define J721S2_SERDES0_LANE3_USB		0x2
 #define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
 
+/* J784S4 */
+
+#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
+#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
+#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J784S4_SERDES0_LANE3_USB		0x2
+#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
+#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
+#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
+#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
+#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
+#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
+#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
+#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
+#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
+#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
+#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
+#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
+#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
+#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
+#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.20.1

