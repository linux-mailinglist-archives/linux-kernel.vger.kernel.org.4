Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD6702122
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEOBaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEOBaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:30:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE50E5B
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 18:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqUw2/Ag3LYlGZmErQuIgikrJFNKZKQ+fKwZ31Zinztk7Wn9YViNoLpFwHuhwALx8KhiorjEKeLbi350f2chvTe5xwLozu7qz27GK2vFCMJv4909mp+fRnMXqos0XAXaS/gD8C0z3vH5R0pUg9Gb988KIc+zDLvxdydpKk2QbZxHmiWEKgvQoXP/MBXE48lvjQh10EcVVXBJOs6uTfefhCzRwxlfXZM6+D62afYYRY8HtwlBDowCTaAylIBhc1iMbioGnHjdJrQlS4gghe/R3oMgG7N3VPiv+SiVsshanoY9WxNWhPn9MouReWsS3hEqPdesTUJqNsqzDkwCJuGvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlEfbgHhc93JkeKx8egqnHtMj4fC/UdtrVTgsqgjOvY=;
 b=Chwdg3xAAjucJhRZ1AN2uaArRxs/SVC53k4UKSRor8lBXxN2NNjB9ZgTwM5lDgSsRu6stttm1ssnSbDfIGmhxyx68xv/7QZY2MMnt1W6/MNoLRl2fqTd6PNmMBs9sXFNAcy7s6LISLPI0m6k8I545hodE2VYOkGUJtFk+CayKJ7HfOW3Gen1/3mysB3rC02mqbyg82QOdzdCW5iEP7Wbakz4epzM6O4cPTIL8cKBO5Z8bSxCHHZBnBw3zGcysAMSVeta2x4xjXoCcR4eQIcr6IkAYFmrM74XNtAQGdFaNfvvFYeGBq7n1RH+lJmDgz3auMflhSe9qew96YFNbxU6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlEfbgHhc93JkeKx8egqnHtMj4fC/UdtrVTgsqgjOvY=;
 b=CsMTzEtSCmksjRu9WhXGQAyDd0OyYqtWa5fAW7QkcA3Ivg60/Mo227vDNxXd5NYGOQmfG+RFWAbSTJa01+4iPSDErqF0529MBH5yvwt+wyim+7TYQKQGzEDUF14N2dHOnphWTwTZ9EoJ5nfBOSxKLSxiYOiq1yJuv8bFero5C7Kdim4/2ggxovYwpYB1JhLkKb/nl+AESiqejBJrrzIQ2wi9xqGQUTDeRZfbvOj75om3sZbkzmTptg2TRfKjmLi8H39JwuP+utsjc8mcCJjmx/mNsFqGXJ0Zk6b4ejg0kwHuZAcm8om3vhjCxiVY1M8Y4dNEJd8CC2SidE5nhIi1Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by TY0PR06MB5609.apcprd06.prod.outlook.com (2603:1096:400:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 01:29:58 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::85b9:972b:85ce:4d8f]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::85b9:972b:85ce:4d8f%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 01:29:58 +0000
From:   liming.wu@jaguarmicro.com
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH] perf/arm-cmn: fix compilation issue
Date:   Mon, 15 May 2023 09:29:30 +0800
Message-Id: <20230515012930.946-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.34.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To PSAPR06MB3942.apcprd06.prod.outlook.com
 (2603:1096:301:2b::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|TY0PR06MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3085d679-205c-47cc-5dd6-08db54e3e511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+pDGN/0pHKBVBVje4JVmenXNN98LX9Lg61rIwdauujSJMvP50xAZBTcKy6x/n6CnfLPXTugxWIkBJU5scWgdf3Fe3uGkpnldZDypqIgfy1s8rHGJCo+xAwPr22nIZbrxMaLQFaPNIW4skcd/oLNuZCMBaxz2fEPqjesaXOO/NFxsH8d4zDRKbNvDouMG4rK3XgoxI8bBc7RDNUkkd9ZgAbA8LpVE5Dt2ZKV87jK6V7+pZHBEeLvKPPtAhWrmAvwaqXGq1VzBqn0Afv9OyLE2uwd9N4ebX9dPfpB0N5+XEIFKEEqQGbzlkgMghXR75mrcelbT6bwhjZiJYwIyFJ2voL74zc4EyHmCMUVwGr8UF0ySNqmghwaVzhaGlUPKlI+lN03s77eFlZ1PBpstBQDYHAgLsrzzLm6PszAgvtszQ2GFSmTwhGopr7xruuN5uwgK4qS8UCfWOABYJWJ0h3VLJC5W0zaoSRU9elCZ9WjymjtgPoSLpKY6GvWFlG/bZVANyZ1zAHwY28MjnsHOMuGAYcGyWlvGqOH7VyIptMRC808kz8/mJiC+KkWXRyyOlnqPHi2JAKURmnToDfO7df71LxVQov9nt7kyaor8zgA/CC1UEankjQa4fhMz4kwOlg1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(366004)(346002)(136003)(396003)(451199021)(83380400001)(4326008)(316002)(6916009)(36756003)(41300700001)(38350700002)(38100700002)(9686003)(6512007)(26005)(6506007)(6486002)(52116002)(1076003)(478600001)(107886003)(66946007)(66476007)(66556008)(2616005)(86362001)(5660300002)(2906002)(8936002)(8676002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2R1TGtBK3k4M3RKaCtMR0ZuT1d5cTdlZFJGZi9WWjZ0RXEraW5xRWZ5aFZ2?=
 =?utf-8?B?RGtlTlZaT0pPUDRBT0dGMGZoYi80UE1oSWVPQ25rcDk2YXdOaVBKaEFhcm9J?=
 =?utf-8?B?WjFXTXR3V0pIWThGOTNwajlQZXN1bkcxZmJhSmNvd0pIS3hpbU1sSzVnRVZ2?=
 =?utf-8?B?NEl3bmVQendPb29iQzFSRFhCbzdqTnZlQUp0YUtHNUpwU1liQWJlbDJmUmVR?=
 =?utf-8?B?UVJjZ3k0KzhQYU54YkU2Z09hOWk4TkFGaGV5QTdMUGNKNXNHM05WWlZ5c1U1?=
 =?utf-8?B?eDBTYmpOL1dOR3lGTklqb3hEUXVzUDdmTkVHU2RvRE9QTi9xbXdXQzZobjc2?=
 =?utf-8?B?Yk9aWHNSeXBTUmZzaUU2dWNNa2hBWG1lai84azhqVDZnQ29OMnc2ZzN0bHVI?=
 =?utf-8?B?VHRWOVc5bHhVTjcxWXVJZmg4emtYem9UYnJQZDFwR1hmZnlBbEF6dmVjYktj?=
 =?utf-8?B?UkRuL0VyV3VGamhtdzBKczFsTFQ4THZiZHBLOCszbWQvdkZORTBYU01pMjNo?=
 =?utf-8?B?WGxLRUhoTWFyS2dRNGJZQlg2MXdjQmdseTVHMys3WW5uSHlqbGVKWTBSMmkx?=
 =?utf-8?B?STBiSVYvT0Mxclh1WUp1M3QwYXBNQzRGSUhSV3B0YkloVEc2VzRNV3lXQTJ5?=
 =?utf-8?B?cm9ua1lzN2dqZmFOZHhRdTVwM3k3SG4vMFRDWVZqbG13UnhUUjJhMXNBSk5a?=
 =?utf-8?B?M1d4VXJJQlFIS3JCWXlwNVhBcVNSTkVTamF4aGwvZFhhdy9ZQ1Fwd1Z3SzJl?=
 =?utf-8?B?S1pYczB5QW5IcVdFQzcrdTI2bnE3ckFXS2h3SEpldXlQWTF0elYxWkRmc2Qz?=
 =?utf-8?B?cS9qMU16RjNxMHA0VkxTaDliU2s4bkNpdU1RMjI1bXFscG1JM2V4VGVGa2V4?=
 =?utf-8?B?NUJuTW02c3lJekhobS93Z3JSalVxUVJmbldyYjFuQUdxOEtZTU1hajVHSWM3?=
 =?utf-8?B?VFNwcXI2aHk5OUV4d0dwT3JtZjExUWFFNk9wRURhV1RhaXNKQjFHb2ZRMWRY?=
 =?utf-8?B?Y05xODNSUkxaVmdMa0FFOGIyTnlEYmM1QzVFOW1mM2duYTNud1Y2a1RDWU1w?=
 =?utf-8?B?MmZqNm9HaHVMYW9HWFl0VXFRNGhWcEVuNVZ6VXNYMURDdHlFL21DYTFrZHkz?=
 =?utf-8?B?ZDRCKzNrZXFxOUhZUkxWY0wvcVBXNk0yYU1yMmpoUGVZNmQvRUZsQjRnRVNF?=
 =?utf-8?B?WUhzS2RDNXczc3RwbVRMNkVKT1FIWngvSUl4S0dVVHM4anQrQ0dxQ0wwS25P?=
 =?utf-8?B?KzRKVnhrUjFvMytya3h4UVlqZ2QrUFJZNFJ0QnEySnllMi9DazdJSEpMN3cz?=
 =?utf-8?B?RDNqV0pxT0kyZkp1cUI0SlNVUFNBY2x2bmU2UDcvKzdaTXo1RFZmSWZLNXZj?=
 =?utf-8?B?RHdrWTcwWmpLZnZ4TWhvTTY3MFZkRTFZdTlKZSt0TGVlb0g2TUtFZzhMT1FJ?=
 =?utf-8?B?V0JNNWpZaHJqY0h6RTVRSmNGZXdaaHdNMzBSa2ZoNU9aTm1QZUxDME9oR2VV?=
 =?utf-8?B?SzBSakVnaTJCbWwrakt6MzhRT09DeU9uRWRjNldiUUU0VCt2ci9wOWdxTTFF?=
 =?utf-8?B?dkZwNThyNStiWGw3cG9KNWRRSDZVTUhlZlFLdUpwUVplTjdOSk1PaTdtaGVp?=
 =?utf-8?B?QnFyTXNJVFR5MjBER3ZYd0NaU0VsYkxUWmQzelY5TkRVdTdIMlpIbFVsVFAz?=
 =?utf-8?B?dUZyMEFZeSt2YkZmb2ZYM0ZNVW5rNUorOHRyRGZLYm9Dd01WOXYwVS9rcWQz?=
 =?utf-8?B?OUNSeDlQK2hlOGplaVZYa20zQk1tTGxFcnNQR254MERnOFZFZTNRdlp3UWdp?=
 =?utf-8?B?WUVrbTJ0Q2h1MVJzSHlRN0E0MUt2RlRMOHRsb2dVSWJ4b28xcXpnZ3UwbjBY?=
 =?utf-8?B?UXNJbGprN1NEbjhIL0xFR2RWZk4rYlZ1K0xaMzVDa3ZJZXFxa1hKdHd1RFZ6?=
 =?utf-8?B?aVZWK1QzdmdDNkgwdk5meEdBdER1VTFuLzY3VUp3UFppTGJGR3g1VkJUbncr?=
 =?utf-8?B?MUFITFgrVkd5NnJRQmtxRGJQTlhWblZUL3ljbHMyZW9jQmdxejQvTUI4VE9y?=
 =?utf-8?B?Y3BhZ3M5anI3dzJXN0lOUXJrUGtXQlh6UTI4RDBhdWhZZHR4bHRKb0laTkxJ?=
 =?utf-8?B?SEYwR3lMSnp2aFM0eS80QjN3V3NaM1ArbGlMNFMvL0JoMStQVGZyd2NVMHRj?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3085d679-205c-47cc-5dd6-08db54e3e511
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 01:29:58.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJU585FHxKAD6RUasv6WM7sMl6gI1lktDlAxH3z9jXrTNx718HiJ5M0rsMU3+I+htAe/jWoWAfDGvyacQz7/qQvcGi/zzeWiHqmSsR4qrRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liming Wu <liming.wu@jaguarmicro.com>

This patch is used to fix following compilation issue with legacy gcc
and define variables at the beginning of the function

error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
2098 |                 for (int p = 0; p < CMN_MAX_PORTS; p++)

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 drivers/perf/arm-cmn.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 47d359f72957..2299fcde5b4a 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2009,8 +2009,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	u16 child_count, child_poff;
 	u32 xp_offset[CMN_MAX_XPS];
 	u64 reg;
-	int i, j;
+	int i, j, p;
 	size_t sz;
+	void __iomem *xp_region;
+	struct arm_cmn_node *xp;
+	unsigned int xp_ports;
 
 	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
 	if (cfg.type != CMN_TYPE_CFG)
@@ -2067,9 +2070,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	cmn->dns = dn;
 	cmn->dtms = dtm;
 	for (i = 0; i < cmn->num_xps; i++) {
-		void __iomem *xp_region = cmn->base + xp_offset[i];
-		struct arm_cmn_node *xp = dn++;
-		unsigned int xp_ports = 0;
+		xp_region = cmn->base + xp_offset[i];
+		xp = dn++;
+		xp_ports = 0;
 
 		arm_cmn_init_node_info(cmn, xp_offset[i], xp);
 		/*
@@ -2095,7 +2098,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		 * from this, since in that case we will see at least one XP
 		 * with port 2 connected, for the HN-D.
 		 */
-		for (int p = 0; p < CMN_MAX_PORTS; p++)
+		for (p = 0; p < CMN_MAX_PORTS; p++)
 			if (arm_cmn_device_connect_info(cmn, xp, p))
 				xp_ports |= BIT(p);
 
-- 
2.25.1

