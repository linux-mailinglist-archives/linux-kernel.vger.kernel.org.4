Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6586EB91B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDVMOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDVMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:14:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2057.outbound.protection.outlook.com [40.92.98.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240842114;
        Sat, 22 Apr 2023 05:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VySODS0oa1bEksRDewWDWLIvgtQeDd+hmtabTgXHXhz/nxGpK86LY0NkK4jM0RkLZiDQ/O3m15C0AnLDez2NksttmPGHlXklfkLNP0TwC2fwRU5Q5YSmWzOH1d7LyyosIt3mdpais6lTl0/9qDbY2dPZnBGULjdzSFP/8SwWu33ZRdSwiCq53V3svjHHYYW2D7dMrgH5Io8AGjuU7mF74ZDnA9PnXaXHz7tHLyTF3D6rtxrNIDF3lTX8cIIE1dfYIIScyix4Mt3JfNw53EV/8ZNFgyDh4J//6WIcTA000HBlG7+73/cCG0FnkO+K44nqaDt3Vpvig/lcEjvuZTth0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY2pTY8kUUdFTh2z8x8In2ZsYg1xABHrgzb1S/dzqZY=;
 b=ZE+GmNgQHN2qbrhGdcjzcjilNRiEaIya0rNUEvbsO6sD6KUO1nNQdx1u2CiErGd3hMMU0df5JcdArZ+UY62Pqngfs4ajHqKO8nPG3NyJwZk+rdk0MJgb3BoFAHPAXoJhGifw0Hd7CUbEQb5BkTW2FKWJWs3HmSJAFM0Jyd/p3HHY66GeUeLouSyINvIwPvvjlRpHAORb30soiCHpdsFX+WBFchha1tJJlu8nAt8NUsvRwDE7UnAlQIUWByRXkVKM/k36vrUWSTC3G4p9th9x9ETg8/jYuVNyGan9MlSHlEaUYUulCW2AB86hUvYMrbUAlWDidX8ILNTJ6pyGsfRPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY2pTY8kUUdFTh2z8x8In2ZsYg1xABHrgzb1S/dzqZY=;
 b=JMb8LyIOaX7u+3HddTS/5M1+zB0NjojOWnUlJGXxHhVcXk64zP9ViN6StbeGZrTGZeF/BcTqcpzPNvTRni+twZLZ7GGPtr9qiyjKNBPQDojm/CmQQsrUC6IAQG3FjG0nwWw9xxD/Rr03MqV6FESvOa/tkcqAnihN6ZXxYpQrs/X7MH/eXxHI3UbRRkIokBu1z6JppHNMGtBuvj9cY3aO4nhvmzc/2sl4SzB8qt2fsB0efT7aW6PMiT8xrukn+HBfPtvGAmijaYkoieU8uRURzyup73SOYj0CRa5lya1kDsPKRe3a6D8nNzD/77LYSfeOedOvjbS8BWwjl2/UPVNVzA==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 TYCP286MB3395.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Sat, 22 Apr 2023 12:14:33 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317%5]) with mapi id 15.20.6319.028; Sat, 22 Apr 2023
 12:14:33 +0000
From:   Yahu Gao <yahu.gao@outlook.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yahu.gao@outlook.com, Yahu Gao <gaoyh12@lenovo.com>,
        Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH v2] ata: libata-core: Simplies if condition
Date:   Sat, 22 Apr 2023 20:14:15 +0800
Message-ID: <OS3P286MB0632739A614E451725FF697D9E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230422121415.6276-1-yahu.gao@outlook.com>
References: <20230422121415.6276-1-yahu.gao@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ymsblM7aIUj6Fec/oC+YzmVvmr0SZYSA]
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <20230422121415.6276-2-yahu.gao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|TYCP286MB3395:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e2e69e-7e16-4017-12dd-08db432b219e
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmofvZvLhntBlNaxIR7rLBomONE8DBxhgfW6gNCmm6oPZN3vQOUX3laojJYaymS+wev+8Bq4vMY2Baj5iuqPkiVyVhdoG9vQ4riduk6cJMaBs9S1QbFfuddHR/l1hm/XVeAy3nJbO70DsaWFCVy2FTEs5tq3RQ4JMzgyTQmJ6fOmyew8TNOwbpdxO4zY/xNpUqjyZotJcJ1oA3//n3DORTjYohO/IMMTway3O3Rlz1wapX+QQ90DfMaCnaV/EMnoZ1jkav1KDiVBl361gu5nWNIMHYdxvT/XEJcBNPAYlscacQx0R9w68y2fb91c/SFcwptVn9RVOdly1GjhNHN4InH31cFSr2dSsd0JJFUyicoJGZEZbvxeXrR/KoFgKvWOjhnxtHpR7I3qBI3zj68mqobq+b5m//ZdiNi6S4e8bxRpc2FqDacgrvHRdTMxdf7DJmtRbKRdS9zZ4kr2bBdwb5Usi3eHbEaGObEXX1F18r8Cwxj+gMUHpHeLHXw9VwaSH12cpD82X4Qg3Nj+eGeVaAWJVqLdDjNiq8bO1B0ZeIYk8ZrmGxjySgGlBLZbiubYN9a6kF6W+blvF2q+mS6mIBRUSINn9b0oDSg837L/WaH0EhXM9r6XvsrIaTSNeJpCU0hNxOuaBYnMWfXP4hwejq7hBbtxLGTAIaBHQ3YXf8htUjCJeuSwdZjWomG2W6NZMt3PXQKB9UXUxK9EIHn2TJvSSTUUmnxF727/EbnWgaUK/IUCZld8/BszfgRi4k7ye5E=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX9eDmMuAqBChzXV9vdG2mVqOtZ2P4MJ4D04ittunKyqWJjeqARn1ZZqXdZqN4M4evkU4e5H1qvfAwiBU48wFaCKjxg/liIAXPJrCTE3xontw5c/jc/aOAqCEcW6u9HnUFnZH/FXx0diF1vzkK67/t96XSw48B0YATRJ2z1d6o9BwKfNPTVBhZH5L8xT+POfBoxvhbCNXK85lvO1ozbYgcjqgzwu433QmK7X5DgYP4PS/hKdPGDk9SaMrcmwZjbLDBD15MVJsABKFprE+UXBj51qtP8CtiWEIHUWEts9rA46JNV7nn3y4xxZe8a0efX4MayZDHCFv/RAG0KNE6Hhba4zvftBivK1eIIjmOY09u3wFEIZn0dSVOf0+2s4cUh7CHUo7GrWAfmkfrtogyuo8YLezlz9xNndsxORua/WPJ20K1KukwgM6W6j7MId+uIf8Ho4B1o6x/V46uPsXiE7HULn70l7vXnP21IdLx5OnSm9PL292Lc6C+Ag3yl21e1NzH1h+z370SiVfZf1Zf/TlD/BMR24WvigOUVttRPtDjZoJ0CKiEh0K6CKW9BoeJOZZ+wogyYY7K8qiI8R3e3V2lJeC34+7DgEfrQG1APSoxpmRHaaZ8rfpu5osrFehFaN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJuoMRA29EDuvsLBx7zV98MjwITJ/N6u52GtSwc/XLC3etU8MJSyUEk1TfUx?=
 =?us-ascii?Q?iCJ9g+L7rDUL7gVy7D2IoPVuIl8f7xGogv5wbtUTiUvbG4tYj2hCV5sXrraq?=
 =?us-ascii?Q?NMcEmVpuUe5b1bjfM1hOUq3KqHw18YvEooP/8x4eYb+bp01duBFPubp+F1WW?=
 =?us-ascii?Q?ne+EtBnStVZZX+V9wGJfDyKmUKHgKj0CRkq4hcCpb+Vtp87VebQlGYzwSc3I?=
 =?us-ascii?Q?Re4xurboAnKCxrHrtqfQt8RAe15L9lK9eTtbo1UiELcsuxwFzOhVR5gYR+W3?=
 =?us-ascii?Q?L3OYdIQhparWTe7QE3Kaa5BbthP4cVmPQI2fpcqym11IL8+gmcW57cGfP2iZ?=
 =?us-ascii?Q?Rd+qSCwMkkxlSK+jNx4azqjg8YAd3KXaK3cG5eJ5y0NJZ1MphNewS4+RZFcf?=
 =?us-ascii?Q?lXfLrZeFhPhr8ooJgJVvTHjqX1NXyr24CZZdAXgmfHHB+UfDqi0SeF+D+PE0?=
 =?us-ascii?Q?YrekBrIqAV/QoRO5NzsNU1B4QSvo93MmwvOFxb6/Zdne2jn6uMQg9ipEFhyZ?=
 =?us-ascii?Q?YIaS5MFSH7BSGkNGi/0qtncpMyDBetGLmwIWGZblGfVJGYMb2vTf1DO02WB6?=
 =?us-ascii?Q?j/eKeQz5mzIqzFxj73VYjK52e6BESCclRxSISHUqVZ9EPf/1GNnxt4gmHjk4?=
 =?us-ascii?Q?Tb4YfMFRGLpE1u5p8EVHh1lO+NhxDoouHWL2zlgVOa7O2egAi9aXo/3lPeWw?=
 =?us-ascii?Q?LK4SzQ3EdPR8aySygNSfaumr3pMf48+gESWOLkyw+r5vO5JkDj/6+791yayg?=
 =?us-ascii?Q?TRarpEzcOgiltIFYfT3TAp0DYqTFoAuUkkC8sq3F6mCeyx8jgc7BF22bALCX?=
 =?us-ascii?Q?6/bgjKlH3+TPYa6+LEM5FXBqMNckEzmgc3B4o5wNVb0OhF5PETHWYZJJrnhU?=
 =?us-ascii?Q?y06vDWpOGcjj2xZf10ylwkpQfDyJuSuEComPdY0HbsXOTKQQ5xG8Kn4ZQHkA?=
 =?us-ascii?Q?ZhWdQDzd8krCG9Gxby/scxOkrVkc3onRZmaMLmRGIxyLpVKcpjfJhLB9U0K/?=
 =?us-ascii?Q?yYWlxVU3RGP1sESUK1yadrq9tuGdjFCi9KK+aus2+KEsUblIq1eDVjl3FppB?=
 =?us-ascii?Q?MFR6KUOi34XLMop9IxOKaQzG3C80ztzKLbhhk++Ho8M4kcT7lFfSWRivte15?=
 =?us-ascii?Q?2i+vzWbYN9fxkZa+LVcw09cyUxQsv83UJ5wCrM/zvCtvz2wwpLIxumrLmE0+?=
 =?us-ascii?Q?GUuVEC7VAiV1QYNRs4x6t6jdGiE009283poztQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e2e69e-7e16-4017-12dd-08db432b219e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 12:14:33.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yahu Gao <gaoyh12@lenovo.com>

Replace conditions of avoid issuing [P]IDENTIFY to PMP.

Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..53f65d751189 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		return -ENODEV;
 
 	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
-	if (ata_class_enabled(new_class) &&
-	    new_class != ATA_DEV_ATA &&
-	    new_class != ATA_DEV_ATAPI &&
-	    new_class != ATA_DEV_ZAC &&
-	    new_class != ATA_DEV_SEMB) {
+	if (new_class == ATA_DEV_PMP) {
 		ata_dev_info(dev, "class mismatch %u != %u\n",
 			     dev->class, new_class);
 		rc = -ENODEV;
-- 
2.39.1

