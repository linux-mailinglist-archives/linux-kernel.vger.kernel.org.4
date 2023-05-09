Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AC6FC4DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEILV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjEILVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:21:05 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2059.outbound.protection.outlook.com [40.107.222.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C149E6;
        Tue,  9 May 2023 04:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkKhHeJNqfeUomAL1EJ59i7vcgZsL6HlhR/fblbmKXd3LY+1kjPK+pv3z8NBXrDkwag0/dUHmIi/Xgy8jrOFP13tvRpCOi/ZHXTBJu5K/XSzfI6ug0jjNczuLk30FfnzG/ro37QY2170ypP/kZNmwEcAqv2DBhiBn9YMrIGHE2W8r68JKcd/8OlbvTGo/cURf4uO8uBPJiR0l94mjXLItiEBFLgrS0khrSoKFo+xuVBCfcL/OXu+2Ptezl4GPjlL04H6BF+JwIaAyLg69HuW8atfunfnDbYaaQthGWcHH56q1eTsV9ThMSY5QLRVpJDBAjEAMSxVXeyO7oHcuAX/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBjZJbsndlSTvMYZKcN7mtZmf5i4w2Txuvy10fKxE0o=;
 b=kEUZqY1faTeIO4dgQzV0qx4XJVs5bZL30dyXcNYLhdjXWxLBwwAywytCb6A8PKjAW9mzZznZ63FZ+isIKMixH82Wfx5Fw2otTEt7F9K1AHr4IRY4LefRxJIkUZdeaxjgLP64eTboaNSArV+WuukBfxuyPdwJATQLg6PvXj1C9qFaOBBvw6KoYGMKZlCB3tXX9NAR5+ZcZrXVDOUuJh/YOPJ4GiLfwIVFpI4sASQK4kBk9vFrsScOuOnrFUXqoCV+wGbAY8y4uyyjnkJTRCD+hgxxIbJj6MhFKMhksZtoO+XGqisT+Igkm/hbsYhqcYDF9mAVV/5HJBuS7suAjO+Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by MA0PR01MB9627.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:20:46 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 11:20:46 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     marex@denx.de
Cc:     himanshu.bhavani@siliconsignals.io,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Add Emtop
Date:   Tue,  9 May 2023 16:50:29 +0530
Message-Id: <20230509112031.3301766-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|MA0PR01MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c614912-a841-43e1-aab5-08db507f6f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKfwWUJBddt1cw8lgbvZTdvNEGT2e/5GqEfce1Fiv2xI9jd4C/oIYRdZPmobcFNa7oO3P76bpjd/XTwDKKMCq6+VpkZryHk26eCW1599NFb0CyHsatv8bn3jdfPvp/qrsJC7NqLiqs8X9Z250WDkURXvMakqPBjTtBYFZNND/MQTsoHV2shjV93UqxQTmX46Le1lEtGkI4pk7Ey1CkEqr3HA+yH8zTzRw9AOJRRAh4gH/94vZIBPAgV1Zepx8wWZdXb3j4/7U1NeQ1lcqm+DijOKUOaqrJs7Y/QIXji6QI+7SgAZRu7RN0f7UMnyvchjZXOz/wrOGkXbwXuezDN7jpUzjPTsKStwcIM4a1WBAU4yG3rP7wsHyjgKAUy9RD9v+LAZz2dPxjGgcusQKm+MxQ7qaNZk8upKfmCiilhEdZ8j10II/DTmnYPu4aGxQVpkZ/xQjzw7kpT6juKQQ0FmPlpYyrqJPHD0Wz0fFKdF3IJeUZbvRJQamFJmk49F0scZ3GbcTS6gFktoL15V1rOtcPNqjEw+JMbWX5lBjmbwgB7gee6DudYwYls9x1u0XS9TR5D3T5l1ma4vjIiL4Cyjc7bjCL9DZF2TXyxb+avZhWNSkuoysnq+D7XL3q866z8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39830400003)(376002)(451199021)(186003)(38350700002)(4744005)(2906002)(6512007)(26005)(1076003)(6506007)(36756003)(38100700002)(2616005)(316002)(6666004)(6916009)(66556008)(66946007)(41300700001)(6486002)(66476007)(4326008)(52116002)(54906003)(86362001)(478600001)(7416002)(8676002)(44832011)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ve6Kx1lG0uz2CJFgf/9a+7NYWASBmZBrWUUWyT8AhUZ0D5KmeULrN3AwRmE2?=
 =?us-ascii?Q?MRbmJPbXBjqDq3kMZmqI8rx54Bq3Yk+NvCjRjMMomWtESC+dxtH6Gx1p2m9k?=
 =?us-ascii?Q?t9AVmOWRt54ca6lHKX9jnPY40O80WsH0bI5AbknOrJF13h5e9mLSPIDaqMr7?=
 =?us-ascii?Q?flbpFBa5gQmwKRCM7hv5JMWnmnA0CYQhGfolkbipnfMhktg8XLK7g1LK8klL?=
 =?us-ascii?Q?ABfwF29PtVY8uK8uQOGO6tYZBNAJ7n/YCXYLiG3F/K0pSYQFSF6it3h08k9Q?=
 =?us-ascii?Q?6f6aR0PHWn1gJ+KRmXZ98gAHsjgN7xQBrubKCWCVjkUEInVLr85aQan5rjIG?=
 =?us-ascii?Q?p9JIsb81xmbyUVe5I224vKDoyyvCDhT7AKb5OLY7MK7tkGTSUr3GRLOidDK0?=
 =?us-ascii?Q?Ogjn6QwxWyCA/24+0WDopcozsxIbfOkVRWiKiuQumXRydJHQs2mEU1PDp/7b?=
 =?us-ascii?Q?OM8LDZiJRlG+hkYjg/PudymkBeMaJ2Z2bDdv3Fip7uzHvMtBwTyQqGcYCXZx?=
 =?us-ascii?Q?9j/nl0SEMzh2h+xymFISkfHvV/SzHul4/tfF/aoLr9AA84efKj7ehbPXvPog?=
 =?us-ascii?Q?uUAnzbg7a3dmvseSXTHZfTEdSrB+uDMWayCMHtomFX8wfdgPRX5jcGK6ZFuH?=
 =?us-ascii?Q?VNFu9GisASmUSTzjElHTpnOIdBx6PPDGoiT2VVcG5/J5iesH5oiDRohr8N+U?=
 =?us-ascii?Q?/FyTenFX7q0tbcIT9C171vPTGyCn+BCvBVXGupqrS2WFPuDp0EGmyO0bfhCQ?=
 =?us-ascii?Q?vOTJiq4jza+89IK8WNd9aKAxyPpE29YOmCqH5notWoj+JDStCNrorN8lKDAJ?=
 =?us-ascii?Q?ElxjTY4YvB4OUcQF+bXADipPK/jdlwGfTtSCuFMzR7Ytj6qG1jnjw7/xy0ru?=
 =?us-ascii?Q?iB8PWo67VVsw3F0s8zdEl0/xLgS7CSFpl3/2iVbSc1E2TACgAnGQxMhY0Elc?=
 =?us-ascii?Q?8QSBrH971br3gcPMl77mXfCvv+3/LWsMlHZ9cpuWk+Xqae4tZe2+IJKb+ucD?=
 =?us-ascii?Q?jcwybmruZmvSIJamax2n7p2c6UZeiUiskvmCZrwlcsAPsX3GudhRSQHQFxrp?=
 =?us-ascii?Q?B6PQ6W7Q0G3YSB8RvvzAflMCiNdJmTLcingeLV9XC9IVvTZ/1t7RMEXtikAZ?=
 =?us-ascii?Q?p/wEFyk9FPjygXFUdzTnhA8jT0esGQuO26ZelNMQNBCdRz/jZ2e1jhYnvX5a?=
 =?us-ascii?Q?uc/rOowZB7Tuu4jFwQKbGwMMwDYtNPHqEZ7PGWKKiiy9bLHchYMltfz1Vrx7?=
 =?us-ascii?Q?RLIbzBgiUml8LTyfhF2WSZGqQfuqJGQGLrTZEsOa0IT7bVwaCt9hCcCFRo2V?=
 =?us-ascii?Q?xzip7oPz+09/IYrjVGm6ibr4Glfq1NwlIWtjbN/DXwRSJn7xkBcKG/QH3gG0?=
 =?us-ascii?Q?lh9NoG4wPGCm0P3SULxLLgDLeoHjw61TdiTr8Rjne1vval1nncJ82HB9L6p7?=
 =?us-ascii?Q?AfUChEA6yjlZWzYLAsCo//QUq/Kjge4mVjryjO5VqO4y5SzhAtt55lsmQUs1?=
 =?us-ascii?Q?BLq/6S8sZRQp4NlVSm9uM01VHiqAqlASaDYbRrCr2S+TC55QZmTt2NNHw4j2?=
 =?us-ascii?Q?RCGo/OuY0NHf/nRODRAe6MjLePEZSDZWsWQt2X3RHJXE/8dX7pdPgpR87O/l?=
 =?us-ascii?Q?G8ECDJeCzQX9Yg2DesVCGrQ=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c614912-a841-43e1-aab5-08db507f6f8c
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:20:46.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qftj96UnaeKGkieeGseLiv96nWa/ADR3xkch2yAIbdxc5fjXQRYxgxADF4EET/XBgbxSz6vh71caqKltDHUzqv1lCJ8hgTposxCirRWiwWoi9aZvOwSrqAGL5ogbIhtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9627
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

