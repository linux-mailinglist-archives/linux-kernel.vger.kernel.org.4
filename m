Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF04708757
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjERRxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:53:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E559C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:53:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IoKK006515;
        Thu, 18 May 2023 14:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZKKnh5tXR7cSv5pdvv3zTwdCIZvoiw2m8PYAGu4XPKg=;
 b=zusOND3jxNSaWdi6eSETaFyVoEGaqGs6TZGcV383xiFCTLKkOqWIw3EMMNih70A7/OnJ
 haksnh5BpVvkr2gldyQ3rwXWPzBWQJjeqoRBAXcMOTb+kALmWmKIFajehETrzEsA/JCE
 DbfU/UUZGtTpOBOJZ81EteI2uMgmXXTTXs1H/CZ9XqNetKVTknuYaM7uq49TbA4TiFxO
 hjAmSjHArvDLQnc0W69emoKIBLJCNmVnuJc7T8I1N68ukppm+AttIr7tiU7ruTM6/759
 gjDYUOQsUXYqwp079sEydZKtx9zqZJ7VWgie+tedITxfelNODI6njGYFI2UIczfRN2Fc LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye82ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE4MUs032127;
        Thu, 18 May 2023 14:56:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cwr77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR1fh/Zw6PREDYM+jJJHKhPIR9xjXRoQjfYHiGCz23E9cg1w6iXXsfDoV5Ln/lgh13YAx480YA+dw/hO7DnahG0WoReRQ9toJKpXC9ruFTR6Ryer+9qVRQxivFdcfU8LmrWhcXarS7FTtq6Z8y+ujsZQ+9F3dCi+9yU1QB02AENcNnxDEvFS8hiOYV3gUm9RQ+H6cabG9ohe96jN12rrZI9lDYVyLEyWtjmyeTpmAWymu9HEzwAWyKaWPXqory2PHKAiqp/O5hfB9ief0ebP+i2AHj3mxMxWPkLS4AV4sw6Dv/N5EMSM3GCeolbsXGoRpv6WFzpaXDiY0Zwd+62kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKKnh5tXR7cSv5pdvv3zTwdCIZvoiw2m8PYAGu4XPKg=;
 b=C/1PD2hMQAysd1RRSol/OuWE2KM5knbofysAgA741yYL6iQJ8WikrM8g+QwkCnZTRg3niVvEDbkPoTqMWTZ0KATXNel9pP7toko5cnTq8hd9zMmdiyevICaX9D0J9V0WsXxlpNgmdc4PHcsYczXxgsK3yvSB8Ynzsfje/S20mS+jo1YPD0TvghU0oZqFWC/fde9E2uq91kJHJrR5hV1Tj2o0vfR7+3EwpwBalmKoSab8ykiDibLOmX4cmO71/vegW4K3nRHhc7ThyxPSVocRxiYikAJ1FInoPPrtONl37z40KEHGEEQxvV6IA4OYTJz/rnRwGgcRFgv9bYGpiKA+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKKnh5tXR7cSv5pdvv3zTwdCIZvoiw2m8PYAGu4XPKg=;
 b=gAOxYX0fsswPPsmwyR01feMKdIFb3ZPay9E2nS/Ehg+ZuVo9tNBEVLGmqoScj0ttx1D9FMsXtvWM3EI1ENh932kiCUaZv6BmsaF29ozcOg96cQwtidLDHvYIXLVfsbr3tz4dcFh7UHBrS5DnOYmXVkYlN+G/wxxS318NQMI7Sfo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:05 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 07/35] maple_tree: Convert BUG_ON() to MT_BUG_ON()
Date:   Thu, 18 May 2023 10:55:16 -0400
Message-Id: <20230518145544.1722059-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0293.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8394f47a-ea65-474f-f901-08db57b001b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84zeeMybTITJcJpGcGDGQ9GaAjYjlPuihbR9wLXAD2tWtwGMtEdDTArHz9CpQa5T2oPB5J+Ndvnr9dUazNBoeRKznp83ewb6WJddY1whpx5kVWEJfEZ5VaRW+ukqPFcSIiuty13j4xWcGY4kN5aDdBqZC1IbFGbY0l07Yl+FGZRAts6VfARD0opYVI2rr7ADhUNHmNbipQGz6krIcl+bfnYaTLI6ucEFIY/9d5MQ7/bRaD6kTNPPXN1S0VuRqePIxgUg9yn4u1ZeZg0wWey1GNafPEzpxLlxMeZI4E54cLkgmv/Fyie8NUW5KrzYBYPruGqGcxY3sqQqhwXLr2ZGh4rcOwWH6X/kogTttEvJhNYmBnlwo8irEwKyB1BDOpzjqNdWqoD/QDIeTLhaXKbr5hIbsC9MKL+yPxVjAwcjWJM1yvxpZoBD460Nl7jcDmvwwyenfFlzAuYod6G9VTNr3W9mR6dahp7Risgg7AYKImfzTorKrI5dCbVNN/waKy6Q/BJ4RHgKSKrfFePqABKx9sea0KNangMRUt74ZyO9cBcstRrDSHSM6C7mHG+o2c94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ntedK5ZFawT9Jge1CXXN2Iux7HkdbxROG4SiPdjj/+UG02f+t2sjinnVEKJQ?=
 =?us-ascii?Q?9ByQoy8hnz17sUD4z+Z8+bdHZWuqk0B0vmlLNb3qZv9Fz/VTmZDOojkWBQRm?=
 =?us-ascii?Q?NgpPcTTWxhp3+EIr0+f088ElIYZMUptOJm4az2mmPlXwYVXkYS3bQPS03mhz?=
 =?us-ascii?Q?8l/nn8xw21wkDKXXLlJMWI92LlmPl3jtaajbxzifwzQtA4kfXESY17TkHrlM?=
 =?us-ascii?Q?c4DFC8K98Kwovd1qLR/27KNit/Kru2vuTSu6FO5ZhVH4bMUPGKNxreOiJLv+?=
 =?us-ascii?Q?q/qV0BFWq40TmvO5XYuHgUoSwxq7VZXTkJjudyIA0IATxtZTl76Z+T7wrZUs?=
 =?us-ascii?Q?cwlfK9jB3+IxzBZQfldNr75myC713VY0LQ7alwc8TaKBU2zscZXi9i07npCp?=
 =?us-ascii?Q?2ciGKAvWk8YpW9evon4Z4t6trJAaYbRW6vLBCnQHshFQ+h9jc46Stj10+BvM?=
 =?us-ascii?Q?uu1kkdKQzkjGinUwERZagjFmE1BBNf2q9eyjbbjsb2HsmfsptzxU3x1e9W/U?=
 =?us-ascii?Q?AxA09FajCsdVnV3DPG03RGqHnX/acEIR3Ihk9hU9nfmAxYJgEKr0P0gijoSF?=
 =?us-ascii?Q?0rPr8/XWewzz0Qf6kiqYZRKHPV43gQmekGdvFIlB7H/xwVsyiV+gwOLmrWMe?=
 =?us-ascii?Q?HIeaGfqOn2nUcugjoI2hCtwMENuyjPgROS/q5VGr73UKvD9GS9dXzbBumH+6?=
 =?us-ascii?Q?yrXre9zgP3MphG36fbPHTFriSo7+aDuJk8M/ZiajwlNJ+AR/6uUIz+i0bZJZ?=
 =?us-ascii?Q?XmM7DOtCQkObaeYB8JCi273xwd2jjU/3NgKAy2SfKe5i2XXTs743Ju81+o99?=
 =?us-ascii?Q?u3StW/oFiIVYk5EY+TlChJBwVK1UtwkgCkayEO4Yr8vmX5dFy4pc5/uGUeVR?=
 =?us-ascii?Q?vGAmahdFPnjcz0uwmyJSW39iyNiuyHKFwicUfN0kqBk6jFV1I5BrKxZ848HP?=
 =?us-ascii?Q?aJisCBQRPAaT3/BGg8AGujjaX/9iKN79iNdaK5AGTM58P7S5HV/DT251Eaa7?=
 =?us-ascii?Q?AMpcYN0IjCx/N5k+x3W1PDZZ/CJx02tHSO2NPuTmnuIxSKJ24RAeranzRdyw?=
 =?us-ascii?Q?paAuZahdJSj6Edu9tGxD7/rgsCxll76ILxxKdBGlbYzDc9F9b2zBWlAn3p0y?=
 =?us-ascii?Q?yQ7A/NxO9pI8pdv3Z2C4Euc8StaNW9rGbPM9W1bzKysOFMJnKpLPhiUy0e3C?=
 =?us-ascii?Q?/H5hB4KB2UWmcMfvb5FfnNsAZMdfU55YO0G/Szat6B9btRIzcY0Gq0MnbA8X?=
 =?us-ascii?Q?ElSe9QPsdG269gFhguP7wxZ21Goe0GvGWNkA6dhESowql3r50dZUWylH0q/j?=
 =?us-ascii?Q?bDsczM/UYuCjYsWXDtBUYvGusLk9iWy0oQGi/k7pwUiYbRhIRR3LrY8iO6Ps?=
 =?us-ascii?Q?HZoyPH/XFL8pqmp4Bv3VWPjsRnkgvVwVHW4TDJ66b55Ma9Gy9yMYwWRFt7we?=
 =?us-ascii?Q?2JIOmSDjgaN9hGUW6tUSSMu0ncKy3Bs+IHXKvYVkzkf5poOJNxLz+5xlL3Yu?=
 =?us-ascii?Q?vAc51sV8nKAukAN7tsoHicwLkHXP8BlyjTyldD5BAIMA0iqV3mkiKlZX5FVp?=
 =?us-ascii?Q?OuZYlh/bcDMSAaK1ISZ/wky7+eqwj9YLqiJh+aXDrK8me9pjTOx5KcME+j04?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 55gr7B/skj57uhRqs/0Vj3VKl3bt3FWl3mfAA29kuQ4c90lFh03o6SgiuEUbYUhKTYl52Pufh2f7OSchvTPHg6Z9yBZ9OhDeonx2CAGzF/KEcC1ZUbtnR1V8IWGOwWS732Jp+YJik4OxxhmCWNkzuwa9uMdxSjTCEn+bPY5oA6wF4GzRUHKLfrk5RxHp+hKTUQoGZfbqkii7KrJ9oMonBODwsyU5lENv7uggJSnnItslBFDyEvPr1PdngNEAk9Fr8nwCmK0r5NGMo2TiIqrTQSbA7DM+3AYgM3WvbqIEdZyy/djIkr7KY0qYayk4a6lKmNwX+2lne6MVsOEZc2fG4YYh4C4OI3e8GWf3eGFkSFkVzLxUbYpiSZXuyQuA3E/GlgGih5sJoX4JkVWSUFujyvwDHq9AVYye6bRLGEQWnjXOKj8J1CGbIkFZsfoPEIqxm3tENYF+I+O44et7Y/YumG+Dby8W6/5UnNR+EQDapPVQ6EjPp0QftxzGzAfR/p92l24rovnGrRAzBBKNzgWT1GinxQABSZ0K1nzZHbX22emgH715EKtfCfX37ie82lfXqZtRhwHWdibW3WIcMum80sT0sre2HVSc4ZTg3bltiXWLR8jbrbtcPHEm/DOrNQ66PVXpoPqNMvlx4FUzRDlOyAThtdAHJ4GcE7tschjFcGZVwRD/gm2LerQo549Wfz5atH6aboKI9Ay9GD2pvhfHJO/tzPY4uM5rfHyKT6MGgsYf1PYxqSvQBRnijh+DiSmwRE6Uld00y3sRwWqYYEESvFaV6lr5Zitw/1dEMavJXUcIV+Dx74+6BCQyDeNE/TyfFBdHPdfITa7Hii7829acYLw3Nko9CJRUl8xZqhVzNy2n9IHJLpYLncnW4WkpgfuM+DShss+Jhvyoow+mayViXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8394f47a-ea65-474f-f901-08db57b001b2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:05.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9dC7gzr0U8yNqj7CrFvf2Z9ttdvrlWmd4XGusBxDJXrAmRwnFRraO2A0TyYemV/BancYHmsS56SWqSX3oJ4nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: hl-By1MQmLTQz3hIRzHjeqrYZ4p58ndK
X-Proofpoint-GUID: hl-By1MQmLTQz3hIRzHjeqrYZ4p58ndK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use MT_BUG_ON() to get more information when running with
MAPLE_TREE_DEBUG enabled.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a28b021f740f..c3ce2bc59412 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	BUG_ON(mas->depth > MAPLE_HEIGHT_MAX);
+	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

