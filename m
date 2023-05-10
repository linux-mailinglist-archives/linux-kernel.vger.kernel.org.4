Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17B6FD98B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjEJIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjEJIfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:35:00 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2047.outbound.protection.outlook.com [40.107.239.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE8659D;
        Wed, 10 May 2023 01:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObU+QvnZk9PQ92J/cZAaCKstVH3Vts13u3Ifm0u93kTF5mDdaobmP7QiP/XwsHfz3pIwu8Smqeu7+AZxyMzjkbInX51F2SVDeiW6rOK+3JjrylGM8AAyiwDLvWfr4W3UM/jVBYf4lQv9XPo2V7msGxFTqpIH4poy0RIuCUc84Nz/qD2+i9z35bmOE0b9gi4DX2YCAY9DQ2DKTJX3XODgt4Mcm8/tZ7DaDFyndWu4zsPljjfBuaZHc8WlW7/D7Kvui1p2xyvVFILrIk9wGDi6uYk82C3AtGLAkKre13o9GGyju7i9aJ1dcmkMFm9ZdhtrwNVuQrr4fqupttsCTk0/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbP+dM3/qh4RC7MvRUQm/6ZBXiPHo1sZnQHPwxhQciY=;
 b=KIjAtlH+3VOLtbPfUym2ZwxRllaJM08C0ABHGXOzOdFgZj+Crd8DUrfQ4oXFduoZDCnoNxMJTDq3X0tnqMUks9AEYlD/FLXuFlk4SvmsfiIF7MLNB/r3/EUdzLSNAKQpceYkVXrbI4iOiNZu8nw1bLObnGZmaE73CiOvJCXfjbmhcwPaYDKnxKjYVVZLAJSSVPm6n+r55xufqOCN2Gp7fF0WT082l99KZCsCnGKjsyak0JT1dyTvt9peRLGM7eq3qVzhQs+8cYyzX2oPvqeC7LDciQJc3H8D5dQngZHjyI/r5uOIBI9D691SWgNpMDfiPU9Yk320U9rV40vEjAiRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNXPR01MB7204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:34:01 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:34:01 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: vendor-prefixes: Add Emtop
Date:   Wed, 10 May 2023 14:03:44 +0530
Message-Id: <20230510083346.3692555-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNXPR01MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c9f14b-14e1-48ea-97ce-08db51314e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUi4kNMaEmzFBrrXwxpZ8QuX8SI1ReQnI7dO7M4T91lG6XV5HBOoY3X7SjRw1xpy4BKwPv8RmwECV/acZ1JoiyuDHBQwD6ROI6+Zn7lhJi+XusZVCbIeEPfLDcUdL2WwuFpiaaqrtpwjOQ326Ajb75ezpiq+XgUoDWWBa6BvzfE3sTGFOJjG/+7FF/eY+vTjCzE7jm1DH/NlBh+CC7UwEv9xqMR7EndSZCw56KBs/Uk5JsF7p2rXf6IZOsbMr0zzLVdtfk9BDmGx0xG0bjz+E4fp3N5QrSsX83LrZ3mQyBNG8YSInYHoVQ9sz8zDwf6w/UQ/nETqCNvsVsw/QRmn3RBvYWfKme7sBMjE8hkkOGb57hv0eWKe/F0wIUWhqd4HaKp8YUvbrh97VoqCzk4N+Vw60FqTT4fGbjkT2jugArUEW5GIWHpRajwBTHRRoXDtEbGUrCiwzxT1PmDSKjbUPdyFpc3eme9k/WwPr/LnbxMqIMcKBjjV/8w1nqfAN0dL4kljLtVvpNrgc/5o66rI03+43cskvpPbyMgPkLKBXF7CBZrw9bnTV8ZzBIvFuNK9qVg+zgPTY7Rdp1fg7LtToFpG613z7L4rk4UNgPxQyqw0HEO5/0vSTQ7e6v7sJY4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39840400004)(396003)(346002)(451199021)(66946007)(66476007)(66556008)(2616005)(86362001)(38100700002)(38350700002)(54906003)(52116002)(6486002)(6666004)(186003)(6512007)(6506007)(36756003)(1076003)(478600001)(26005)(2906002)(4744005)(316002)(4326008)(6916009)(8936002)(8676002)(5660300002)(7416002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RdQjG6Ko068tzishcrxJIZ6qh1xmQfnICchB5anXqiBHeA+D4J8edNCNWD+?=
 =?us-ascii?Q?eDmhpZzNQ4fBnn/cJyd7DJj9IL2NHn+gs//AhZ5rKqx1uJoXGpgq4wDF4skr?=
 =?us-ascii?Q?kVryNeutLgn7Y2maFFY056EstdBUZ7jcwWu0j0jhaw58LqiXICZy8E7HpMUC?=
 =?us-ascii?Q?iGJQuJemBhKrCwvOoXKBcOS+wXDMRYK1IsJxaHUdw4eLWSKjX0sZTRqnuVOo?=
 =?us-ascii?Q?Cg64p2XyLltAiNHI9n8hV4Z1uRh1cBdjR4cf94yrukMBAAY+L/F9XHUqQDFK?=
 =?us-ascii?Q?WSP3uS+5fkDtKRCzbnYQ9UxnBoYqG3l/Vp3F0maAMdu71Ih5SbzaLMAZaexZ?=
 =?us-ascii?Q?Nwk5cbDcHT8p6+GISJiBg90sShtiN0nZEYppsYjn8y698/1vb7cjQqCD5Qtj?=
 =?us-ascii?Q?IflVQzobNg1lDsGOh1tOd94HX6ssDjKNIxEhGTWlJ0d2+4msSU9Wq/wMYchy?=
 =?us-ascii?Q?Rtc/d3S0Tccox+vfwWVOJpIhMNLrSQx3Gyn/BBST+5uUVTJUaTzPLXf+2KX3?=
 =?us-ascii?Q?z9PUlFG+IJWUG4mZwaIisTb5fB/M9+FAhmt6R0qa53jOLDiY2SXuUn1ib/SI?=
 =?us-ascii?Q?zyLBSRYC4irJAZ304G7IWuRE5VsDzsKnVJBGrIgwHxL4GE/BuD3WwDOhA0cM?=
 =?us-ascii?Q?kzC62MTKkSBpdxqsI9RaedBqa5AaPHZYLtzsh7e/aqfXDwi+byU8oPOWbSBe?=
 =?us-ascii?Q?RTABNdU7tWKk8jmqB3JqCD4cpH5sRUcqS+hPS80H89Ly8HuOIlusUbLGsXIi?=
 =?us-ascii?Q?fTI5HZNbZyKOYrNC2RQ324W7ybZpT+jw1QZBgwC6BKBRHLOIhsCJ0tRvBmdh?=
 =?us-ascii?Q?HLcxL0KBFFPFu7bwasEF3ebUvTCgdUVn8LQOxGKFmRTJcyGu3FfKThjgzFH6?=
 =?us-ascii?Q?WLruswS6rb+DduHFJgQLHvQfL6SKHXl3ZXGeepYmYvCex6ykFmoqvDRP1jpd?=
 =?us-ascii?Q?xdGiGMFzBqgM7bT3ansXTseq2r5Yz3hrzpRPNPqBaqrPxAoc/xjEWe+k3Ktv?=
 =?us-ascii?Q?yMOFY2arqUnNnRmdBkh2yGSt8Gjky7d9OuwZPEpQCuYUqXglLzOvVUsUw2Ez?=
 =?us-ascii?Q?rgw2wp3hmFrqEJZd8Bddr3F76t8aAOs0ufBOZdn1FJiUPr+jVOQWb3QfsaJa?=
 =?us-ascii?Q?wsRZ5DCTdzQ5pxAtFL0F3kWveOv+idj6fcswAKRWsJa8upcnFf6+uQBViYZ9?=
 =?us-ascii?Q?KMT6zuuK8/Kcb6vTEX+v3/KA1UhPB04X6Fn2mFVgj3ucqbq53BfEFSJHUlwr?=
 =?us-ascii?Q?6dqmrf7Fvn86JmQ1IhKivEogrIy7/09d9kPibrEtilnNAoNqnQlshH2ti4ab?=
 =?us-ascii?Q?PBUdgcMjKLvSG7agjjpIFSxEFDFcHzkHkmcsUsvzxUgjl4iPUL7kR1PqrXUr?=
 =?us-ascii?Q?75YQPWIzVVzjFvEd32hJfFutG1HiSFX1vf4mY/V04PWD3ssxhxLNWeuW9j0d?=
 =?us-ascii?Q?FXvzzvpNLhmXEHPT3Zl3ykmkcu1ScgETiQWdbVSlSr/o9aGik9aRIjtpM2xp?=
 =?us-ascii?Q?LsOelACd3yaHxF9Bz1syBFPW6TjqwXrraEVeonrQ+xoGskFl7JLQwOxF2wpo?=
 =?us-ascii?Q?PdI439H0KU5XBpg1YZZj4x4vuz4fPAmthveivILJ9Jv9B/OI/5zs3SdTjTkT?=
 =?us-ascii?Q?8ZzgjicTmNPMrEJxal9CL2A=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c9f14b-14e1-48ea-97ce-08db51314e99
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:34:01.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WQ16bsZkQuabxFAZUnDaWiGN3g1wB0lqhzqt2ajlwh/Cq9seH0fCZBYo2a2bwBuc/79sDQTHRmttCepvkFv+HPovQ/3srskbLfnZy9Pua7UX3P7Ht1oOw1qOmyOWQXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Emtop to vendor-prefixes.yaml

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..e6e3c99f6ac1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -412,6 +412,8 @@ patternProperties:
     description: EM Microelectronic
   "^empire-electronix,.*":
     description: Empire Electronix
+  "^emtop,.*":
+    description: Emtop
   "^emtrion,.*":
     description: emtrion GmbH
   "^enclustra,.*":
-- 
2.25.1

