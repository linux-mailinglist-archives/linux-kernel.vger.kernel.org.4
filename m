Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4215B79F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiIMSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiIMSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:45:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0A72B73;
        Tue, 13 Sep 2022 11:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii/aVrcSOIClFIdCEwnBk2jEt0jcSBN9YtUKx8dQpN6Ocn7wAyrowtCNw1Y8eLbx9SiCSSvL5H/feO88Ritjph0clpbI0NV6XtaASUmKIc7VI6OYLHi6ux947Ybkof/znRifcnbb/wmlVL1GuDXZvEJwKBVCRFuSNSr+QakpGxvy6TkRUqZXaT2mpXtJuQ3QwBxEUOVzHiz07K+qPKWAXQsquWTDndhD30+povluVZ1zysGv3fYh4uyJWa8zYOWA+WX8jPIrhE6K6T0FNG1JiNroRmffMk03KYe6OLtkPv0Tw2Tw+rlr1hT1cvoC10te6W5tz1c31/wGlje1e/qgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zwH8VbrDX1SbLl5KCX5AxQZ5BaucmktJWsjdGYumlw=;
 b=PnfU4MqSwN+sNJtBmAwSGVj6aC0vHSQwQ/XCQW0nHBH8UaTaVqs96P+DVs3HKIQyMYwodOBmS90JSp2+IdluHVnL4GqAWQdlnraxI2dXdTCdlMJ2HdlpSxuH3pYT56dfNLJ1cDXciG8XUpUDwr1eLTHFBm9HcXpVhAPMWCFoaC8uY8wosCkvk4pIL3tz0zXRYrMfevEY1EEDKu2FG+Vx3Tx7D/oHvPC8vKA1tc+LaX3LSDMTbAle7/ybsxlvZ8L3QwD2Q9KXoPrdWVUxSW9FLAFsK1JnhsCq1mksnDP/UiQDu1c+ZCHm/t4YA7O2njop3mbimofdFJJnJmVDIG7WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zwH8VbrDX1SbLl5KCX5AxQZ5BaucmktJWsjdGYumlw=;
 b=YC6ZgmqkeNuYVUVp18s0BT80AA0PxdJm/KWGyWuPlDrOipy0x90vTgUTWku7WlnOAxgzi/1L5D2CiVKwPYpm+qMwn2GYDLsNE7OW2uL8lqQabJxaoQwV1y8flaSqFqXqh16dAZg8qmNxQJpKjw/v6QkSJjGFy0TXqeqXLxK1ZzZnR2w0m3RqFyfrYBkQI6c2+y0QdHN1NDMUdEebl/Uv189QwdIzbRhOAeEcPFUij5FWEqMbXS8cAC1Qe1Sube2kjYlfW/VNFtB/MI7QvY/UJBJqtI5h9LuXsx/DS+U+BO67DINzFkJ/59gD/BkG9gVFPZlEAnL5pqmgwrUBuxc1cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com (2603:10a6:10:2af::9)
 by DB9PR08MB6716.eurprd08.prod.outlook.com (2603:10a6:10:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 18:25:03 +0000
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8]) by DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8%9]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 18:25:03 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH v2 1/2] dt-bindings: gpio: pca95xx: add entry for pcal6408
Date:   Tue, 13 Sep 2022 13:24:35 -0500
Message-Id: <20220913182436.589713-1-nate.d@variscite.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To DB9PR08MB6825.eurprd08.prod.outlook.com
 (2603:10a6:10:2af::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6825:EE_|DB9PR08MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a6b66a-9a10-471c-151a-08da95b546a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OO6XcIvPlUcuny3Ig9RakL/k9XqIOKe7BS10w/yZI/cHkRZTWKQnKaSovuDxx8VbRwYDNaH2zG3LBqjMkf0GRMkFGJmzD+2n2SGKCy1SWJODNRKh4yxadQwVGwkJwE8SJLxhvGPWTjKgp/agbR292L7V0o0ty7shh0gy/GDxm5V3mVTOYkTWva2ubZ4zt5PlOVjvxgbUFxtpW3mGkY1Qoz4QnHb8YNX2FuO/LkEHXD5DqiBywbegF36lMz6WNlAIm5GFoVShReIkOTuMNUZMvF+4Ulq4bdN3jip5Ig0a19wzEktSwLLD+SqaAMggOMDAJevTdmOC7U+11XA4uTZ1dHlHlQCrrijo9EkqBdd/qoczAnv8ptuPEYdujazIGXt9PxZzZqj6UTsNCuPwHa4542KuVWqRyo8vI/2FuMS7aHkEuBhY/mhdnC22St8pwxv2ShlST5fqdhVFqlMV/loU5n3TDaurK8+oQR8sOVSLZSED9zaaSvYVy4fSYff1BGGTm1uRgyrISIxQtoTp4RvNdbM1XEOqtJ71e3Hfx2LuXWyWsVlEMNQsw5kU505xvAJXLvIaH/YsLp6xX42iiCl0gfLdWMQU0mOF4TLvZ34z78U8rwAHLxkoz/rBvgqBMXv7r05sN4K2/OfEiafFipYfV86LWduBACZT6F7S05eSDiFjAR8mh9oBW1cUc2Xjp+st4E+TdXT0QycGL3fco+di+8Bw1x/xbZpjF7EKiWt5t1ljXyxr1JD01DjOaW0PvwRgcuBdySXahNJ5haZOyAgn5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6825.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39850400004)(136003)(366004)(396003)(346002)(451199015)(316002)(1076003)(6506007)(2616005)(2906002)(52116002)(4744005)(8936002)(66946007)(4326008)(38350700002)(38100700002)(110136005)(8676002)(107886003)(66556008)(36756003)(5660300002)(6666004)(66476007)(186003)(478600001)(41300700001)(6512007)(86362001)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAM6PP/G9ZQUusSryi+vunSXtHRTZfLDc+2kQUGRYs5LIssUmvzK4MxwUf9Y?=
 =?us-ascii?Q?NnJSSOu+pYGNvIfUC2urVD9JNE7rZHwD5j/eCDK0Wm7qPQBe22kJPbgB5gxA?=
 =?us-ascii?Q?VWGXw4MT6QI536yBZuzfMFMeDNy7eQyqjhqMbm9WJ8Es00rE4KorNCWC8Pfc?=
 =?us-ascii?Q?zqxMlNxX+DxdQLY53a9Y+XUKeMkwo0wTc3u9M56+O8GjeO+8PbxLbH24zXZd?=
 =?us-ascii?Q?UnFgfPCadDeQgHufc325hIQb1BvnlwAfajHneNFQOrFqiadMS1+OE4aN0hFs?=
 =?us-ascii?Q?HRG6S4ea5M3OBSAc5yLebygIj0zHbmdU1e8OBXwhOSuNyTDRf3jajA6vh50C?=
 =?us-ascii?Q?psZO7jGKKxe/DnT/qwdvmtxGC8MIAtgfn+NAt6RljP4oIFz83o8vCynl9JGW?=
 =?us-ascii?Q?eQBERgeAZXMqX0E3IigKlO+QAqGOK0qdl68SoNcO3BulKKIrRfQGEWZrpCm4?=
 =?us-ascii?Q?2W8X4jnpNkEsM+sH200iPczpUN21K8YMsF8h1NaSievMHtTjGGBJlm/hp76x?=
 =?us-ascii?Q?TK4S+R6Fd2CLqJJf7QhzS2sH8qVROf9A2d+mf8XkrTZvKgsiYl2LueagFv44?=
 =?us-ascii?Q?Y22jI5OClfDqWQkL1kCpmzTM65A7PqRh0Iw0XpG+ILsWMqlBZOK9LOZSRVnY?=
 =?us-ascii?Q?I/8pPRAMTcZCoWevYNpgvpGbuZkXOOSLlsmAr+wN3Bi7/eAwWsRznd3WRs3x?=
 =?us-ascii?Q?Ub+ufjSrz9liLGEf1HPSlTjsF+xXw3fOoHBfcTBaVhMJ8gY7NknunDfnBpNY?=
 =?us-ascii?Q?kqIStaPSHzgroltsxp+lm27YvZzyIJ63s9SGp7Vqaxj+abPRILZpssIRudsh?=
 =?us-ascii?Q?zyL03dmPKocISMvh68FjHy/Ix3KS04k8HCeLAEhG0k2pqf0G8a2iYDYShhDJ?=
 =?us-ascii?Q?CPULR45Ks+1BANidJGes1bEwFWouD+fshAfyOdhaZ6AXF+7CzU/rz92EkLQD?=
 =?us-ascii?Q?TDkHQKAach5hUx5SYdqk4KkzwykEKuvYTX1AgotwHWK7HjxsjW9yoRJMLC8h?=
 =?us-ascii?Q?bOxb/Zopl2jF+7+rrnDo3Da68dyk37J+MCd618z3yY6MifO2RiDSI3AKQ7SY?=
 =?us-ascii?Q?j2qJia1unAkQ4JSUJj8woRsA/Q3gc7GU7eO6rxt3J3lwOmRCZ7tQThrIcMWq?=
 =?us-ascii?Q?AKtjF0Eupo8GTgZ3LJmHKWvA66691lCoZQAwNWBQp7rUi2VIla85aOyPY5US?=
 =?us-ascii?Q?X5AawZ+tWY6JyJC0iA8CHTaXSo6FQBvNfI02MdKSaT0uGbIBlGrZoNxJdQVK?=
 =?us-ascii?Q?dQlR4YBUUv2HPyEJltK3mwFakzFL/KudmeE7U9C+xN55uGi4Wj68KF20bgJv?=
 =?us-ascii?Q?2/JIlEYor/wfwfAnuEzKbGs7yVpdq8ww2YbOwjDR/3EgPDTY7Z2rhmw7qh/7?=
 =?us-ascii?Q?1c7z4fcWfrJ+zZ1THlVviVS2jdzBa8iDBtycqvlPXc/1lmX8wRDJs9cC5tCd?=
 =?us-ascii?Q?BhClV/rMcEkUMF2A+q8yogaCTyOaTwcdRSDoDAApoAttew99SHOSK4gu8iFY?=
 =?us-ascii?Q?vk31Rv5/OYOZKznmQPYdCONeDlcIuxM8lfIuDbA0qeoeYIeO10+6sr+NGjWh?=
 =?us-ascii?Q?/LJlYL2+tI1WCm50WxSLIqDcnhuTVRaWWhD/yzQ8?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a6b66a-9a10-471c-151a-08da95b546a4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6825.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 18:25:03.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P89cHBbRqdeBP9TUYwOMBm3MjCLEuWSiyar4Tb86BjYOZksy3NoHqSRAFL1EIbgfyYH9Q+IvKS1iLe5tS58ijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PCAL6408 is the 8-bit version of PCAL6416.

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index 977b14db09b0..05a9fa92283f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -47,6 +47,7 @@ properties:
       - nxp,pca9574
       - nxp,pca9575
       - nxp,pca9698
+      - nxp,pcal6408
       - nxp,pcal6416
       - nxp,pcal6524
       - nxp,pcal9535
-- 
2.37.3

