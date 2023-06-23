Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C073ADB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFWASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:18:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2048.outbound.protection.outlook.com [40.92.99.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467C2128;
        Thu, 22 Jun 2023 17:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPsMHffo+cO7hSxpfs/frZVl13dChnbuvnm0Qf77dX0ooGIn7FE4S43S/TNiu1p8eoFvf+7f2MK/ReQMhzPk/SuNdLUr0JaIoT4l6Q/QUTzgJ4xhGO9pzwkCEfVR9uR/5R9lAOpA0h9uDxsCXb1N7Yole70FWVhLFQzeWMj+4pwHFRdSSYbj6GviLm9nD3Kyb/fRtiQqgzBxOZnbUivpRV3rcanXCd6NniBB5NBbgBHFf/u/O0rwfoQ/sRrS1+aBdDn5E61VUF9D8dAxJiLsQ8SvwXhbA7NCC2ezHtv0VBU1dFdx9Weky+XJPiN0amjwBoxY/eYxc/6osqEuXKIJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1tjXyGQ2hMBSQ8AGnl0Fh2dgb6VbauHG9WDLynSSJI=;
 b=Mu+2TBEP+HrKO/IXNRjXBAeHUIQudwqhaEdldijPQeBUxlD4U56Dze0eB4j73AHuBkcZBXnGxtppS91/rMkzLoaTAX1eTxLuKrpCnhapct5qtGDgTrlwSZMaiZMeWgpHNLJXTmuw3ZSfRMFy8WvSjljrhas1a2DJ7qJTry1PwqufzxYW/MwRWTngdx5uoo9LROyBmzzHqdx2q/FUYtC38FXMo6/f/8VfYdlU+ioBo0vYLPkn/Wm95GP2izG3uYT2OpHlV1etlYdsIb6E4Zpd7R+LBDWRoZ2+ELjz6iel3jwLBzJMobLPl7ORij1is3R6uOgEgRCPQVjZUlaiAsk/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1tjXyGQ2hMBSQ8AGnl0Fh2dgb6VbauHG9WDLynSSJI=;
 b=sjTYaSZBsoncoL7yZEkUcjf2CbGNPa0oOXM9q2tkltzbcezQHJyUV9K6hS7ALkcj5M9QNUvhM+h7kJ9nMj12XeZ1vh8V3y7z191yNqupGKmbDyyUHq8gq8+j5VJl+ZqJHSc/L7nIdgF2Xk6JWTgo8PuGQBLi3kiri0vJJTs76BJY/FoaUQ2aYiyvUGJK76frxD+xAh5zvL8GwMJZKbt81TGqBmXkyZNMxn5fj3rTYvSs6k4WwxtGtPlxdhThaCGqEyi2KXCK/hF+VmJhNW85jevtqkcSRod2nx8MjfZ5GwtqQdwgEcZw471CI6YLWRo0eWaa3yrcbkD5Av0mEMN+lA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY1P286MB3293.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 00:18:24 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 00:18:24 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-mips@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: ralink: match all supported system controller compatible strings
Date:   Fri, 23 Jun 2023 08:17:48 +0800
Message-ID: <TYAP286MB03151148AF8C054621DD55C3BC23A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Q1V5j7U8pJPSPVbl8APDxOdcsrN5fRnu]
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230623001747.333-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY1P286MB3293:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a0dbbe-c0c0-4bbc-2890-08db737f5ba8
X-MS-Exchange-SLBlob-MailProps: P1EfU6pZOd+G7YiJHccvLBka2AYivzpBpAKHsFT+1E2rPj2rhz0tzGn4I5i7zxetFLbKdsllsVTXNbnw878oFeSal56idifcc9R5MtY+0f+sxgXoyzmPyzZmFsNqhhnUKSx4Um+u0hO3dzL2Fko/LZUutNFB9B8BtlCoZqYll4T4TKlRGSa/sFkVBy74g3YZpEHsXCUDYCjf9Y+P5/0l+UFIfSOaZqcA5RLrXBNWSAdXs1h8OVQfQJ9srlislHSE1MVJFW0MKck0VVc1y0b0jm+Cq3EKVs+E6XwuyoPb/Ist4Tt3wK8rrAGvxrUPgW+/qu67BSxnjkHOmN1Jh4+R+gHnil52akufBreBEmnKcbqPPU6xzBEVaAXcdMMbeHHJPY4mbGevtBMB12cZlM92hCk27aoLVDpBrQGVuMhvhDDZrHuFPVcY/Wtd76qV6EYANi9GcZ0zu3kXy16UUCmJBq8Buo+Y7U9qH58ShbEuFpQzR7n0Apr2BTH5bcYmvU2TTtAGBSbGCSZghOMScxd/vxXI1MdE6I3sX+7kANLJYv+8k5ruijw6ZxEU3rRO/J1WGtcCjSaATN9j3wIs9Rqig7I76aFu9Gp/OUIrFVQtk61CbTuxhrIMoxlEiC09BDX+UfkEo7iKozUDotGSP5JE4+qjMEHGNCjgRIk3PhulbxCMUw/VKztz+4Ko/NPE5ahUT/6yEdZ92vudGIkb5vcqi7w7kelnQiUAMwz8lpvmK0f0ZNcA3i28iX+Cu5PLb6QzibfeSEapxYV1WidLpkUbR2Br5zcPlUsqIjxy7txq+Mh/YgWIOaURUw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XH4jrps0r9pQ64Ww0+XNNhnwQ8fMMxizDGowPgGgMiblk0VkupGvI+7t1ntiOFNuS/PwDFf5KhWg8Dr9h7iQP2ndiyj88i/U+wJafLrsaVi1FMfX9zDO0fMowN1mTAIGkAC+wvWCpSnHt1NcAgTzc2rkyZt9FaDv3ShDq1n8AwmJcOTtuEMBfHnttBQ0GgPslVWZ0DirKViFkU98WVfrcboVKEg3U4JxZdBLr/Vu5+io0l+jthdYkzC7ktUrkt8Q8OIrBVDKSJJOaQX4/anERidcc2FAqzzcTrl+pUx60m2op+lYy4IlzHn3VN6LxcEBr9oatKMx585UoDuZVirUaxCRLpBzapQsiYBGDhT6X0COIf/+1qgGjiO4DZZauCl0D4gpv1LPj1JOuPDQnABHPnGYSTsCESbEFxkELQ0fZJSLfWEj+HorVRsOUAIgaij43DhM+gGScp7ENNTatoT3YEA49LGvQwknGUla+G2qkr+hJS2mdqVwqNM5NA5qmC4txDeCGaz2tkDkcF3HMj/OJgkpb3rUiqsb3rT9AmjpE1Z9iT10ywoBjzMxjmEiALmJgTHCwdSb1XS9oV/cdwQ4imCd68Kdc/2y1W1pQdO1fk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDDsSi2daOdkJhzoOnGbhTtCOuHgUYOMUev4IMYz1b0G45UEMvsEwVhvxp/X?=
 =?us-ascii?Q?y5gGMJoJQIPLJsm2vBQnR6ZUEmle8hosU7zMce/iyIJi0quOqLisAYQkrFTy?=
 =?us-ascii?Q?B2s6X3LYz17pOtDhfWq2nbD/XBLf2br8G6ySb0dFxGvq8m6EWwYV8BxmhR85?=
 =?us-ascii?Q?f6I++qPI7ceYVa5UJXm0rH7EmxD+YutZUABDDVc/OjNcjnCRxH/B4eXCI19J?=
 =?us-ascii?Q?m7elPbnXO8F0nj8XK9oD0pNYN+kOX23bOh4UY3txTfNoSC8Reqta9OD3+834?=
 =?us-ascii?Q?wL2JztBSr46HRCiT2sx0CCXsLgbkq7JYwQ760TLbI4k4Nl12lbdoNrqi+Rwf?=
 =?us-ascii?Q?puCK2MMAGpLSSemi+XniRBsruNSgRwr/dJaHarAEsYyNeBSNCrkf+8qLNqOv?=
 =?us-ascii?Q?UovM4lzzDvtCXQCHb1OcOQD7X0Z+coHLPMPEKkNYXiQ7toCxcJdzYM2LnTRR?=
 =?us-ascii?Q?uv9jkEQT1pG9og/F4CVCj88kTuIKI4XSbHnbb3I8aC6KaRO5HaSshm71Jftd?=
 =?us-ascii?Q?d6//PjEo5qdMx1Um0kHmAxMSgb+yNOCtWnk2JKBg+lGrAtqzvx9OS4pnuuuS?=
 =?us-ascii?Q?53o5J8caBT7BXNQQgvTZ3qK4mN6Kpdrv9elDEHMgIkL8sSDl4DzaO+Op/nKn?=
 =?us-ascii?Q?VOD2Mxu9KRg7BVTBynEaKX/5/ao3Bvht9UPAh6g/PUQpZSUwRWwhB8IA7nY4?=
 =?us-ascii?Q?t2xrWBM6AN9HyzSec1qVtrGxwLba23hJQY3wG956NHnqQJ0WQBy5gJqTrrqd?=
 =?us-ascii?Q?STcoI+qhURngVwqEgaW4CwhXlIe+ggGx8dD+Ur2SQeHv7UKfFCKscRByGJJc?=
 =?us-ascii?Q?OoHS4nwPur75BBW/IHy8n7UAMadiTC3AMhlL2OUcPe7E4jsvG7z02LlnPnYc?=
 =?us-ascii?Q?EECDAYYZihI4M8zbKRSEXCN+WY/fy6x5nDjDAiAzTHPKWC2B4lLnFRG3n/Dv?=
 =?us-ascii?Q?oa5cy4XkGS0A+QxLmvawXAb0lwepbZOUuTaBWQ0koPfCtiOgK08oOGH7p05d?=
 =?us-ascii?Q?r/uMs0tGCz58xKvux6AetSZSEcasovd7IBpANQmKXArfNUglLqfC9l16feYe?=
 =?us-ascii?Q?vIW0x7Atdpk07EtBbvF7LzKvquicTpr7lfH2X4r77YFk6Xx1uMjbNIfuc8/3?=
 =?us-ascii?Q?c3R0gG9WQuVb6KaZ1sOCwXDP4bR/Z9Y7jYXHFves4FGVcMEsYRzBCU2KQG3v?=
 =?us-ascii?Q?HJZ9fLZstCDjO0wMkSHKLEwQFGzyIrl/HVOMPi1t8+UIU/pp6HdnXoPWJEc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a0dbbe-c0c0-4bbc-2890-08db737f5ba8
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:18:24.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, A new clock and reset controller driver has been introduced to
the ralink mips target[1]. It provides proper system control and adds more
SoC specific compatible strings. In order to better initialize CPUs, this
patch removes the outdated "ralink,mt7620a-sysc" and add all dt-binding
documented compatible strings to the system controller match table.

[1] https://lore.kernel.org/all/20230619040941.1340372-1-sergio.paracuellos@gmail.com/

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/ralink/of.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 53a2ae9ee..1c6c953d5 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -40,10 +40,15 @@ static const struct of_device_id mtmips_memc_match[] = {
 
 static const struct of_device_id mtmips_sysc_match[] = {
 	{ .compatible = "mediatek,mt7621-sysc" },
-	{ .compatible = "ralink,mt7620a-sysc" },
+	{ .compatible = "ralink,mt7620-sysc" },
+	{ .compatible = "ralink,mt7628-sysc" },
+	{ .compatible = "ralink,mt7688-sysc" },
 	{ .compatible = "ralink,rt2880-sysc" },
 	{ .compatible = "ralink,rt3050-sysc" },
+	{ .compatible = "ralink,rt3052-sysc" },
+	{ .compatible = "ralink,rt3352-sysc" },
 	{ .compatible = "ralink,rt3883-sysc" },
+	{ .compatible = "ralink,rt5350-sysc" },
 	{}
 };
 
-- 
2.30.2

