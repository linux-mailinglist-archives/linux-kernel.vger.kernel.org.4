Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679BD5B7612
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiIMQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiIMQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:03:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01acsn20806.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::806])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3C8983B;
        Tue, 13 Sep 2022 08:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2eGIg41nGJW4UDeBDu99aySzWwd1qPz8mHLU/+Jqs67/qAEplNuH3Sf7SoBmSdLbKBXgC2EM6UtFGag6YmAMMwClsHlCLeiikj5/a58m32ogPRfEnkrI9pS6r/H0/2KMayJ/qEV1moljmGBhIyu7wuc3VyGuhnN+sZCeG+tsV/g13AqEDxMw44UYjeyxBmcmbTu0YGPvXwHgDoaxxi/mQ9CZM7xny/fNpkYv4Q6C9IRMnOoU8/juUoWYT49FVqnZcyQLzbE1hyFsvg2Wq1YsxEhygIWkUFGTPswgsBldYyGVvYdvfjO6d67fyTCWbiC1nUPjNz27jaxaLGHzA23oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzaU0vOFD0WqqmMlnLVB3WDNphkbgEs8R6xpaFVl/U4=;
 b=leJX6U9L6FubW2YPpFLb6gPYALj4wul87VUVUh2sJ/3LIEVyW6hOj5KPctmr8secCvcTOWn1Gw9noNCJuBMBi0v/TdN4WRMd8ECeweVJcq09JBZQBLF7kGtgIsJRFGrPy+ozo5ZMvpVQQLHlB2eBV1rl2j4I/Qk563rfQY5LI3NCAc5qnNfDU1rSjE3ID07Tz5djmMqVrZk7N0awaqFM4XoT/QuW5qwP+xcMh3a92ioaEbOeOiopckX0BvRC7QhGBuzs21xxYOzb5MR/+k1PE4EtrfAGsJuJqB3qdRe6dzq+2DZ6oU7IcNK+QcsMVuJtRsOczvbIa3Z3UZzXkQpVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzaU0vOFD0WqqmMlnLVB3WDNphkbgEs8R6xpaFVl/U4=;
 b=bk+C8n1buIPKIMQBPoXybPdZ0BLI7H0MPQqhhZW36McNQodmNlcZa+CZMxUsOYYp30PDEfP0WUBmzaJVE0cbTpewgKDweendPoD3FdcX3WA80/AgwNJ2jlAt2KEsIP+/ptU0YeGQvxhxcrZYN8YmJmPkNjrOJxcmMfNy4CFJThaVcuf9qVyXiOjYjUJeBilWnHVTpJMMPgfGZehr8NRi0q+Qm+Z9tmzH4PHx2cIpjElkzIlfcgJb8tSvluBtglc/Ly7R5kAaeNaQAWzP5zdW8gYZLV3hRTUn2stVqX9hAFD1NYjDS/ZvBS2A9Y8/S6ztjMVzFOva0E0JzWz2Y4FuSQ==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SEZPR01MB4278.apcprd01.prod.exchangelabs.com
 (2603:1096:101:41::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.21; Tue, 13 Sep
 2022 14:27:27 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::ec15:53f:838e:9a79]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::ec15:53f:838e:9a79%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 14:27:27 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix typos in gadget.c
Date:   Tue, 13 Sep 2022 19:56:49 +0530
Message-ID: <HK0PR01MB280110FAB74B4B2ACE32EA5FF8479@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [csjZWzQ3SpweoewkejIR6qN1+U3IZ3X+gTlHzjZUI0gbHkeYFojkGYWP6YQPGbyE8VAqRu5sctM=]
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220913142649.13744-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR01MB2801:EE_|SEZPR01MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3012cb73-4f9a-4ed8-7cf6-08da95941504
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFJLrmAOc7HXG30mnBQ/di0uFB2qXhaQdee1Dj/t8Q+T1qkU2xIF2K2hBp0Hy6RU5tEhMrPd6wZoWe/osx6QPxW+N7kaO1nROSx6ij2z53IMhNQZmTxFDNF8AmxDacKdNMLsoMpK2sqHy3opm0aignodXl8D5jsdi4+h24tJlW4Gln3Wlh+B/ANN871vcYFsKb31sWcw8c9fi+DyTp9QbgyL41dt4co63Y+1O5Ik09vixFJMz0kiwCJ56+Q0C3Bm9oq0+hEHJKwCcUnyu2jaWqK8R1lCJesYrF0ps9nLe6c0CP8lths6lPjTrEh6ZxMyD1n/G2HIT5Nl0aWBlKjTxW3iAxE2VqMWHOfZCWTod7NQxjT56ExEagQ0MNRH21Rlj1vtdQPNIe+NSgmkj3alzoRTEH8StfX2lxlvWuwvI+00ACY5Rz+THgS7pP8yebAa+oO2Tj/DC/JmiYy74H7h6FHQvLmeXN7f0L0SoirN49ixGEcW7eII+UdlPBsZXHGEiKoph9ho4zz+Kk+LxKRurpfyU/RJO7+zJx0/sSJLVEqNq5Z7270QzvqWg51YsvxFqL1ygLnPjWo2BInutCCLgufyMjE0mAs3kN2HlDpEGlbsE9ftQViPb+BxaxR+iXs8/3akRbMQAsY/GDip7ov3tg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVK9ZszuPRTK6/TeYHD56Sn9j8QOe+KNKMhIf2aV11EWr841TkWSq71Hr332?=
 =?us-ascii?Q?ArAUFfm8BIVj71RMhOJ/6PVWEgSi/Sl7S/a4SDG2wsNNIN/G5P/0XiFWWqkl?=
 =?us-ascii?Q?rAzvHfNdyiWpIFryX4tHoMmqtPVYU0UzUuyfJ0clsalV0OMmcmlhH8zJJOPh?=
 =?us-ascii?Q?VOl5w9jvGy0bwASqGbSOGAsPxGyEVbMFBz89ICeDwAJutZHNMF1VmioWgxjD?=
 =?us-ascii?Q?/DtNxtZGhZyd9GkPIWiF9y3RFjJc+nmctu+ybzXLza4QG/fEgm/s7XIqKdL4?=
 =?us-ascii?Q?DZTD+t3RnOlN0h2P1ZK/8TQogvdofle/43UL9EZ6asK2e4RH++CRz/UD8Xi6?=
 =?us-ascii?Q?y47V2auUVFLWgPanBlvIZYMTnaeqLv9YSujbfXZausVkseRH+lCmyJwoK7As?=
 =?us-ascii?Q?dOvbbJkLG8+PjKrA16Z9zmfFqtGuujcNmV71yPcg72Fiub6PJqh+hzSlCSBC?=
 =?us-ascii?Q?T/gVzvUkCe5gEFxOBqXV3OZyPP4YpmdSL0A1NdAew+08mafyA08nsOPUXzCn?=
 =?us-ascii?Q?s0hfvGxGu0h6ZixroGlfOGQeqqnCgAF1201ffzHQ8cog59egh9Y7VVbc39i7?=
 =?us-ascii?Q?Pz3rf55MIjfVCsFfvpX/jksOr4QE78jd0l0nCY9X7GcwL0vBitYHvP6jJZnk?=
 =?us-ascii?Q?Rnvg9U2c/LYNHisyWjqGrJqiG24bLa0Na1mMqupv6/WqbihT8rBuggQMqc4K?=
 =?us-ascii?Q?l7ETq8+LSD304Eqq1cG+EsvPESgxs9dbV3BM+LOVUhyubLi5l0iAOCifmNHf?=
 =?us-ascii?Q?gwv7TosoYz1UFgO/F6AwXXuUuNv9I8li0tAhgA1MuSCwylPuH9/sAhxMyW8W?=
 =?us-ascii?Q?qiAWWcsw+KAFp13NF5zkGy6qFQEzQpSCPrDTDZqKsYpzNpY0t8ueXY6M85Uc?=
 =?us-ascii?Q?g5XDzyeDFa/9feAEzgwxRMKLfni9WnJFgo8/hasCmR9W/qWMpn7/AuIX5EL5?=
 =?us-ascii?Q?PneFuHZQaeTTcfFP+0nHZXk75VEFdqbB2XbShXuKHd0amhkC4nLcLntV8c/n?=
 =?us-ascii?Q?2inJ5QLZNm/zOp5r5BORT4CmgkrGjFHTbV9H6fvsEkQkrdwZRVylFY1HdHhg?=
 =?us-ascii?Q?pczTZUpXtReA6a+tm35mnZUAXLkrzc7knA+3oLligFtMi7fR6AAucJ+zi8jw?=
 =?us-ascii?Q?7ccKmnUVORv9TbEoEVF/Eb2QXjgQ/qFu3fotBEs+7sNrEMtoMCl7lyCXsOjw?=
 =?us-ascii?Q?FtPjaGNO0vlDlFY+8QbzL+dASm4CnVzKphUJaA+Me/M6xdCQ2WBeVLbjqTOQ?=
 =?us-ascii?Q?2kyrCnHsyaZoo4p+7dNVuHZpIJfCjUJP+/FkfBOuWe1C6I+VwXa80j3AoRu2?=
 =?us-ascii?Q?hnAmv7AvPzq5YHdP0pBHUMb7oQQrFgZCaS0tqX8CT2gltWS2VxoMAqMvsdWY?=
 =?us-ascii?Q?KebOCEs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3012cb73-4f9a-4ed8-7cf6-08da95941504
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:27:27.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following two typos:
   1. reinitate -> reinitiate
   2. revison -> revision

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b75e1b8b3f05..bedda57a5015 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3582,7 +3582,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		 * streams are updated, and the device controller will not be
 		 * triggered to generate ERDY to move the next stream data. To
 		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitate the stream until the host is ready
+		 * hosts, force to reinitiate the stream until the host is ready
 		 * instead of waiting for the host to prime the endpoint.
 		 */
 		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
@@ -4158,7 +4158,7 @@ static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 	unsigned int is_ss = evtinfo & BIT(4);
 
 	/*
-	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
+	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
 	 * have a known issue which can cause USB CV TD.9.23 to fail
 	 * randomly.
 	 *
-- 
2.37.3

