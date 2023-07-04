Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45094747217
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGDNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGDNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E510D7;
        Tue,  4 Jul 2023 06:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XefPT/2xkxhxFuQ9Ne+8vatFnaZWSK4rQrM+ZYbN5Y/aZ9AXraMawdPeI/p/KtkQDJpZHBVTsjZKjBEKkKr3ue8cLvKdRLXtwmigh5plR0no/q3pgc0c1XhkDSwdk1ysfDK/Bk+shCDLxqB44HpSjJ50LZmT3BNChueVP0YfwP7EiETTiUmbn48VRqI5tTJq+iG1wOEDnfwWpwGDOvQ1alub9JnrNqs8asYH9fk38HHi9tDWC0sUkJEe+S1RiO018ZR57H/u5rWYoqtjOaE/d+Uv47a6aP6B7w/Bn2B6uLVpJm2c7ldb8Y8FdiG3j06s7kfEJIA8/5bp5YhvK77qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk3iDlv9rHNRBkRhDmtotB2subvvB3BbIgxX/4xOQrM=;
 b=F29Mxygw4QeZ2HMI/jSmwWtz0vGnJvlzVYnOYbMZ14EoYk03aaVTTpb6MXKYP05hRX6LVqB4xTPaBX5eUOn7Aq6An5T9RSJQQOO/EuAViCVCuPh6jL5fPgKf68/5pJd1qKfN7N3l/wp0LHLXDN7h+9Zie4DAlgDzG/QgoVWn1oZz411GbhkU9Nv816bpS7uQSB0xEKir6c7OrgcCjp+DdWO1W+tEfhYFoAIJeHUgQs1PBJrDvUVN9LFvInZKRZtRU4XqiCDeqEE5m+VTdIPSclmNB/iEkIzk1wkol+Xu0NgwYUQN/3bNf87xVtCLdvKzT+DuKfI2rnb/b6FCk/vRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk3iDlv9rHNRBkRhDmtotB2subvvB3BbIgxX/4xOQrM=;
 b=BUJCPHvqZE53aoDvOMvi/0S8vqRRuzheup5P/RFjj2H197fRWDKwP23fNMFpr732e8vUz0PvDoGraLrF4UtGBc31OxQUSGoIRqSBvlYLq8asoxRy9o+fC8RE5PVIRR17IwHryq/gI+P0q5foxIvofk2C7QaxERON0vv8UbFuyofQIwil2Slhozq8t/+BU3zp81eoOMCDUyvglJp+9cxhDRMFJut/9u5nUqBsFAQzS0pHsQYD9svJUWNM9ZJrlWOjOdCzY+hpOYKEMXR47HF80341bllYxzToV4Q0UkEeTO7RwPYYzd2cD+ypk2iiwyj6psGoiVpRUP7XE9Gbqx8ewQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] power: reset: gemini-poweroff: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:06 +0800
Message-Id: <20230704130309.16444-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704130309.16444-1-frank.li@vivo.com>
References: <20230704130309.16444-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 336e3c78-2664-4970-501d-08db7c8f0d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIh1lxeo2e3fFJMJV0JVObMYXSanOaLYGwMR2wwiqTiURzbiUa+I3QKNtX401wm009S8tIqYy/U97LL7B2/EC6FQogI4xJLeNXD4Zh1Nc4XnSdZdhjzixjDXtoFT8Dau8oqw4DcEr9x62hQgxtxWVtp+5FGgSvCDd6jJlYcQDwQBjXkm6sTAF9J9aGRYId7cevxLeM1o8K5aomn/Xcc2W1SmAm66WC2FU0Q5ZjUmpjZbDMGDvWIYJTTMKGqTsF5S0ijxmR5kKpMAYC+fzs6RuEYPG60hPpvo8lJAyXVGEYcfgBb9DO2Nwjq7bkpYuDZixortGNuV5WuRKCFLi8hyi6HiyXy7OnTXKuASXUSjYoSiUYdkrlA/quWs6TuktYEcpG5XrmrP80bNgJlBKHP0nGJMoIcNF1GDl+yeoYoVesOvgpErEgamqxK6EPugSyDy4uhw0o6zwdhTwQvNIgtVASmH5s7YLk4Mhm0YIbSv+UMABcXwX5KsS9RTYKmcYZimFzNg1xzsbRriZYR2Sc/hSXlcTjblH1BX06CzX9C+zlPh3c586zBfhSVN/Nsx7250M05nw7xjA/HTtp6goyVoW6Bm2FK/C07tVy9dLRi0YtoK6j84pv525UavBDAfK9Qj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(6916009)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0fbaKSKFKLfpP6C1Ipy7p7fcFBPv49CGSc9AmHl11KCAF4tEv8kLIL2c+OZu?=
 =?us-ascii?Q?rci+IgNXPFIkxIpTmNmSnUZ80TtftbPgNuhakCHws1pglaKjinSDf7i76N8e?=
 =?us-ascii?Q?+Dt+kV92oMqbzH7eZ8FM5ojDlJj9YDClNzNKEUeDFA2QutKghBc+cBFjPo6u?=
 =?us-ascii?Q?Rb3+cadjqQhjTwdrvaNUdFE8B2ObVaojD0oAQyGcHRyUr+7h6Y6j2lVkMRzA?=
 =?us-ascii?Q?EZ81PkN1lCV9dW6gPjLsyrzyykz0aPF3jR6utZAqK0H22ZmqS4138+u2vHXX?=
 =?us-ascii?Q?9MW3SXL5sJ864TQHBiAhWtZafsARpIyNJ0pdiiKXJE6EZ77+Aqoap51LVMh5?=
 =?us-ascii?Q?z3ychKewz9EaSc7uUN9vaoAC+wtS2CyqOs+/DYCBvaVm6LiXjkCwSCUGdtqD?=
 =?us-ascii?Q?+hN/qu99mqiSkaxESY/Q2O9tw0syWCem5mrt7fgVPjFsAzH7F/F62lim9NPg?=
 =?us-ascii?Q?jqjoXgAKk9vXscbmweoXQor+t1lFQr8908egAb16aSlEi4kwIpDkox1BeCzt?=
 =?us-ascii?Q?03Vv7vcB+zXleAQdAe2PLtCoFzaiXe3T0xMlH40TlrxwLFt5cxyj8NE0czq9?=
 =?us-ascii?Q?1wNWszw8LTfFbG3D3WFL7kv/StWthb0vUyyz1Q9BwdtwbDq9kBWM+SXHF6CP?=
 =?us-ascii?Q?hPZj9tlzEY3sWm7AcO328t5sDJoFSad7NEBpjRj5dW+g/WwcKqeD14J+/Jki?=
 =?us-ascii?Q?ZcpjL7ysFKeQPWC6clM1Lq7ZKI2elEqG8g1tb+9uY+0IWv79l3yEoyYIrhPP?=
 =?us-ascii?Q?kmIZfQYN+7kK8Qs66GxuGZ6/Z2rEf6MAibt6znUr5780ZR0yAIm4vCLMGvpc?=
 =?us-ascii?Q?1C5X5EKFeCl8PsJPl2ogzJhs31XWq3HyGTNyysqwqxjzX72Q+n0o5xpHGI+Q?=
 =?us-ascii?Q?ssFfUMvmY+FVtCDEeJ7GLvOhGgqSkx8yg04tvVueVBZGOVXzZpR8xmPg1dft?=
 =?us-ascii?Q?pCwQ6PCYJer752d06gZVMbJxbYJ18GeJV/yIGtypqKfBtNtKjRfqEuW0M9YD?=
 =?us-ascii?Q?i7TKvZqGYfGWgQfxxNONWaq/uZTlJTSVJrQXzyCEy2daYWF7YKRC9TcMHCTl?=
 =?us-ascii?Q?iiMKtxxOAQ/2PaciEq0k4jHEl3hRH3UAI9/vkT4W0JQdCWUVGtdkmuG9ftVA?=
 =?us-ascii?Q?EgC+y9b7I81B0pD6Og24NEKiB/OCAJS8TauYbnftt+tc7hE7VA8Lp9wTp8FE?=
 =?us-ascii?Q?1lLOq5Bbqj9NnZcMuvw+UWTxPlH7rKyjfJmUr2Q0JzghV2mkVkzPxOXmE8me?=
 =?us-ascii?Q?i3xc0Lsh0zLjpODEcawc/71Z3hPI1qZm/ME5orh0UiqLksvv8PwVD5hZBCOd?=
 =?us-ascii?Q?pIVWvhYTyTObdSFHhh8jGFTYMEYA/epoYqMlpYUw5+T3I++DElUFO3Kk+PTP?=
 =?us-ascii?Q?DzeC1+OBNrSNDEMDoVHchAAp8UeOWM6h7SGwVRhrsat0yleSzs95J2UGQ2X3?=
 =?us-ascii?Q?LSSLoMQMmLOVaUu7GL8YRtXXoC98yF6uXrn44VD7yXV86fXUIbBuoFKxkWsc?=
 =?us-ascii?Q?CfMpsLidbNzQWajBpQwFI1k7z0Dlc8aUPEo70hVumtFU5qBfm2V5FXCgGhnA?=
 =?us-ascii?Q?5b/3ZzLMhUmBmaDrujDQy2YsBfSBN8z/aABb2MyY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336e3c78-2664-4970-501d-08db7c8f0d51
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:25.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swkrQUvJ+pawagnGQs464yEh+SlsWVfq/ceD3ien1SB/pb99N5T8QJlhSM3mGOmfwGZZGP6UJTe/AFbUGyD/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/power/reset/gemini-poweroff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/gemini-poweroff.c b/drivers/power/reset/gemini-poweroff.c
index b7f7a8225f22..d309b610142c 100644
--- a/drivers/power/reset/gemini-poweroff.c
+++ b/drivers/power/reset/gemini-poweroff.c
@@ -91,7 +91,6 @@ static void gemini_poweroff(void)
 static int gemini_poweroff_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct gemini_powercon *gpw;
 	u32 val;
 	int irq;
@@ -101,8 +100,7 @@ static int gemini_poweroff_probe(struct platform_device *pdev)
 	if (!gpw)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpw->base = devm_ioremap_resource(dev, res);
+	gpw->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpw->base))
 		return PTR_ERR(gpw->base);
 
-- 
2.39.0

