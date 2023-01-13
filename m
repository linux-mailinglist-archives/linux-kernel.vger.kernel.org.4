Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8304166A62D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAMWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAMWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:46:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAED7D9C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:46:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DLYq29016127;
        Fri, 13 Jan 2023 22:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pGdWAeKShSEOdUatZSw1ccDvyeotIBxn/OWkxHEn6r8=;
 b=HWc/4KxEASMVsKQtqPzseaDHeehFDQ4MH5dTBEAAUZLDuv4RoZFPW/+yyrmRV29ouwqt
 mNkHmr12Lq1+2Jyi5NAd2aRwkA3wgOxpyEIk4NeyslEWR4N8rVFTh4xyTU56/wEjVvgc
 /xWCa0C32Qh9CRW9yzHbHSa4RcqJ+fYhTL1jWr75NTmYV17yGbbd4dg22uS3wGoidSaL
 6eKRM18T4zlLFcrO26wHazT6ppHkF8flAASIKwD3n3Nn4VmXUs6vSuy7jynw8gobz/rC
 EqZw3lS5IfvIXtQ2cla+NIx/jkPpni77sZbjBEOyE7TBhQ6yk9VHda1vFasE5ggo3hMg Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3av80q6n-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:46:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DLRNoQ004334;
        Fri, 13 Jan 2023 22:31:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3f7usqxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djJmpcTYxSAfPfqtoLwFbcZkvvs0VkIYS2PViOMp6uHgM+odQMlSAdY/DAZOh+VBCWHYocu+MPt4106Q3M3hGETfBILJmnwePcEGjbhHwFMEeSRyhkWHXUNcQ1vR4kZ6fnDMNAvRtS1P3F2EVnWL1Wr9l2EPMGNgEdpovVabx3Hnr04KS5UY287BoAjCb5HRS6JV3JmvJOeLEaIkCn5QeSW1jb0OsbG4ZasBadU98/gsLVtIt0QFgy1CBr7xT99aCs6ILZwabdUaT8BWWAtlLkayqM9dF0I8MgZybcwC2LTtEO6XSWmykFk4YbUydsnQp8e99wD6wtpReLY2tRlH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGdWAeKShSEOdUatZSw1ccDvyeotIBxn/OWkxHEn6r8=;
 b=m9uO+8Sr5gS0sixHPnpx6r4oWpGCUpF17yzVSz2kTWg5LYkaO2utiYDs1jnSFWG+V6doULaCkQSU+3FXRCPs4KEr32s7gvlliiNUQLhuzrrDVIUNuEcwxMLyrrrzBLAS8yk1Dfs4TvnjQtjgPhKnB2aZ/Pfw5Zia/fDLwiWMX8vvOvJeACvcuTCsBHIT/myToGlJO1WcW1se/WmejwzRqk8L995aGNpfhjb+hS9znL76dEcP9R5P9aUGo1k5hDXBRCU89gAL+9NhiGBL+gTv/USb2jeZ/6SfCxIYRReXjRDeMPmijWC0OL/jJiaXGnExVFzrVPBNC0Fsa9Q7y4fCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGdWAeKShSEOdUatZSw1ccDvyeotIBxn/OWkxHEn6r8=;
 b=A8vppx84Ce+UeRY3C3nbeLaV46E8+5FvyQcz8PSwFmsxyCVBUulEKrsBQ4IxdrMi9ttcch2LCkeYtxZO4EyOL+hIZUzFScqIfhAm6QN931yo0NSZgVtkD/xZyWUxMtxij0Y/joiCW+RHIg0IuoQ3BnsLXqqnDijfNOABl9AF7OM=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:15 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:15 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 8/8] mm/hugetlb: convert demote_free_huge_page to folios
Date:   Fri, 13 Jan 2023 16:30:57 -0600
Message-Id: <20230113223057.173292-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:610:32::31) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4b6c58-5c09-4e00-682f-08daf5b5e1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzbgcC0mDEsozysUs5PUawbs1BgWmy/bgLXBGV+sZx0tMrtN4/PGiYXhiWZHWOprygBbSSUbpc8NfsTLI6ahNkTCIrzpWUcb4v+J6E0hATekRXwypqzAgh/hbra37Y+hfQl01DaTLp2M2NBzgKMLT9Jyxzs4/vwuYUPQetQwjwx+hweGJHcSg0Vo7nV1uU0Os1+5iMgu8IsP5DsbCje9SVarfBZ1RuIMQ8bqMBI7lCI9W4ydjV1tuEUvjW3hBVzo/s5QcGA5U7jJMZZDgZ21ujH3Kq+4cWhUiApej4fSmsJy2MwBgC9h6qlzbrI/rPayX6oi7poQMivMZ8NaVMjZvtBOl5wqrfVvIdgAFpTL9QVL3lBgwIDXaDSCng0Ktah7K6Ws4cX4hkXvz3wfdBxajb2We72Uq9sa3gnQDejYYcsXK/rsO64OijVGJkjoe1R3yYOqZHykE11Iuf4aSBX6IQOZM2ME40tahZt21fM8MBFaGRUHLdfltvV3w/+/xxWWN40dPV82vEBjmi++MSWN+UWu/NQfsjdpck2N265xEnvDyi1lD7hBzdRfgJclmq3mfJl5tzknXKJYsGzCYxe66NkFhPhjbbAYL3Vqd4775vHaRVLqlauoic8lpKoKZDeEg2G/kf5TPKorBhAdhkAIiBmoTUJAhXyA//nJu2XXfD2sXdOTMAXPsUVWzAYoCj+M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmZgAVOiRNVb9Un7kP9dXsFEsPXfeS5pU3gD6kM/l09cKcF/5k7p58VV2lUB?=
 =?us-ascii?Q?mj9/6MYpLvJ29es1JBWDCoCoh1NWHJdsZ6qYS0/m8KPeKlNapCELT9wS6u3D?=
 =?us-ascii?Q?xpjSXyBr59Yr479kLjKSfLljuYa8JDPXqKqZjDxdopWiHnjzn1cWeWpByImF?=
 =?us-ascii?Q?3Povo7PGHh1y5Ybn5HfcZDl91HqLv88qmcSk6xVe+yw6oa2mrxoi9Ua4x6Xf?=
 =?us-ascii?Q?3Ye0RmlpR7wUAc+XNAY8/u8NEnZemsPFFJ6fQfP6TOr2j+Vr/FZwgLk1e4Af?=
 =?us-ascii?Q?7EAD/ICT+QDiwJtheBdEkHWQGiiw01lWConxCk+YMvcxn0jU+gbGmQJSY9Pj?=
 =?us-ascii?Q?D28uIQyo4b6VlotvFrQ2Bg3m6+7Aj9vhSTmzsrSYwe11xBwN3bJ4zlionbSW?=
 =?us-ascii?Q?dP8X8uRVuWHQHef+Ue414JBGz5tXXF9Ru8gc6MaVJdf4B+72rU/RQm2OCm5h?=
 =?us-ascii?Q?omTKcD8lmVqkUZL703SZfflWRyVWxhtVCeSoZSLUtfgTZ5ksDVsZkrW7Rts7?=
 =?us-ascii?Q?htIpOabrw8odM2w1H3R9LM9Vwz/a3GsnE/BLm3/6jdYZ872cWMIVXVd1S60z?=
 =?us-ascii?Q?iYsnrRPJnzn/cR3tUOvcrP9Jbwf1b5pLP77jEVt4STDN14SBCMcLiPEpswKo?=
 =?us-ascii?Q?dbb4IZc3IyIX/NLSJ48xYZSE30B8kK+0IR9uAmgq2jU0xQReeYRpwH6/xLNA?=
 =?us-ascii?Q?Swv/s8DufCqaTXNuoEVi21aURi4GfZvUGnUpORmY2+YwkKEFZPRo0hokjoE2?=
 =?us-ascii?Q?k2B074TlcoQM3nWV/oZg1qxYPiLYOlwSIzluLMuYCDmAYPsAS/nV3IFYKUCP?=
 =?us-ascii?Q?O/vGKitoC2YWmOetZoVmpunzu7LREQr/7RanwZFPIya14R9yvwC8KGYlFqIx?=
 =?us-ascii?Q?DN/AI+6XanKD8qqglR0+jqYxSstvqFp53QFLC8gCpf/OKparY2kKA9ldtWzS?=
 =?us-ascii?Q?kripaFj9JVEio2FFUvIZb2LrNfGlOLu0NHDEXPpoDw4pyA0PMTi60S3G4F6Y?=
 =?us-ascii?Q?Pwo/j506tBO4uLOHJGeVkuzbYJDHbNGcEjNtLqsYlYs+gpQy1dlZSOT43aRn?=
 =?us-ascii?Q?vf3u9Ue2SWCOLSkZFyEIilSNE3/wI6sVpQWBRceEqsxBubY/EJxXUZPIPy1y?=
 =?us-ascii?Q?N4dXbmeIc9O4KOkquqnAfLQY7ZZvsBgGYKxnILbbDf4UM3JszOKDJa+OyDkh?=
 =?us-ascii?Q?fzgZSlEa4hSU64rLKhF73SLMaZdY+kjWRi1szmITvvnXDfGCCGFTpEPgt9E5?=
 =?us-ascii?Q?dq1KG1MvuZZHHU405qLGj5WVVgzCGL51fs7GmUTj+ER14vAF0/FnhqgJZgLu?=
 =?us-ascii?Q?KOlZyuu2ngBtU2Yd/Z04dMx5S1shRjaoR3Z2vnOkSH7UCsO7LxWpeZVxDvZK?=
 =?us-ascii?Q?9glTHLeJ74EBipTiDxR3BP+sjGYSzVLOYEjPOKvy+19XNLYC52vWHe7yZ/Dv?=
 =?us-ascii?Q?re3JpHA4nMGheTMci3Iv2K7ZtjCPQ7FwXKy5ITIhfuY3umCuBxwvsf7thc01?=
 =?us-ascii?Q?5QhP8gBKY+TI5LGuxHWGDbuI5cvjI5licHR7I7FF0sfYlw8FbpstMM0LSCpG?=
 =?us-ascii?Q?Sipm6h3Y6NPrZ4w+twGMtbi5FDnkHZZ6hOqmbZRRlOPkqv0rpIdOYxQg66Kh?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FdaaPkQrG4M9cpcm9mwx1BfbHCB3d1hk+O5UhouNDEKv4ULrqr5bvfJER6eR?=
 =?us-ascii?Q?0d8vzBmBngUf/JY5W/xbyw8NiuTbQVsWjgGlGz5SRwrgLnrrg0DcY4LBti2H?=
 =?us-ascii?Q?LS5TTO2BlmmBgyHG/kIGt2BKDbJbUjxcsqk6jd0/PRpbENmxzq6LRhqkXtCL?=
 =?us-ascii?Q?A4PtWVfhGZ/+8yNW4WkZtPIYO1NijDaSlm2X+RfZ/XdHm3NfPLlLFfyCU/LY?=
 =?us-ascii?Q?9LAegFNrQSxjnCGsE5vjKuKuRBvet85MdzHSbQ4IJS6dBlcIuqMk97L1G0H5?=
 =?us-ascii?Q?BDp4Wr6BCYeP8fNdnUM/W41qqm5a40OETPykTSQDl3/b4gbo/NJnktCW0yhe?=
 =?us-ascii?Q?p+JZQy98jMb1YtV17bKusC9tcKR9u4NaigqbKJE7pHSqTHQ49lfmcjj/Lws7?=
 =?us-ascii?Q?ZP9R3TaDPIGaX/igtujHNWzv9kB3MI1f3AFXxIGp6IL34fbyDzTdoqha48Ti?=
 =?us-ascii?Q?QaLqP7AWWKjZAeAcZpBYfL6rHc585mw3VO0jLP0zhKl1PatQ5x0wUaSgVcsW?=
 =?us-ascii?Q?elJQ3uzfOZ/TJm0AXEs/Ykr7W/ANggYaIPfDV3Jh6kogr2dHvQyiOrz/2phM?=
 =?us-ascii?Q?FtC74PDRCJLcDVX5c/peQBG57mWa+S66dObB5J+YxH9c1QoTBI/p0gVVfKty?=
 =?us-ascii?Q?xLunfNiApBIdnbdYaH+ekyoCH/yvlI/l49QgZJemT8vBqNvn2vWgObTeB05W?=
 =?us-ascii?Q?5KGqKdvaJkU+/7ELkaSyv24fTCQIJEBweVPS1pShRhEJisBOu8hpLABFnEcP?=
 =?us-ascii?Q?16wgLX0AHQnlJaYqivjuLTfc+NHyckWrrVJquFXibd2L8O26wa+gTz+j2n3o?=
 =?us-ascii?Q?MLZb4lDgNMybJsgqRyr+c0XcODkLiA21DygK69oHb6pV0Yo3MuqLEaRKPMQ+?=
 =?us-ascii?Q?Glfw+bJviD2CQIl+dyo1E0lH+k0xdDXA/Bc8LNUddf+t9sMVzHlivi0+oGMZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4b6c58-5c09-4e00-682f-08daf5b5e1b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:15.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ISje+F35HFhK7AdM/Gtac3yShcL0Uek6xHFGyr8gLwuB9IX3zX8I04rf5hdinl4E1kVsD/SYcZQZfQe+kvKOmGIA0dY2as9woq2M7BHS5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-ORIG-GUID: x-LEmfQAOwQW5G69KFaqw44tesdE_SO6
X-Proofpoint-GUID: x-LEmfQAOwQW5G69KFaqw44tesdE_SO6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change demote_free_huge_page to demote_free_hugetlb_folio() and change
demote_pool_huge_page() pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8cd0c694fe9..46c5daacc5bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3435,12 +3435,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
-static int demote_free_huge_page(struct hstate *h, struct page *page)
+static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	int i, nid = page_to_nid(page);
+	int i, nid = folio_nid(folio);
 	struct hstate *target_hstate;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
+	struct folio *inner_folio;
 	int rc = 0;
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
@@ -3448,18 +3448,18 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_restore(h, page);
+	rc = hugetlb_vmemmap_restore(h, &folio->page);
 	if (rc) {
-		/* Allocation of vmemmmap failed, we can not demote page */
+		/* Allocation of vmemmmap failed, we can not demote folio */
 		spin_lock_irq(&hugetlb_lock);
-		set_page_refcounted(page);
-		add_hugetlb_folio(h, page_folio(page), false);
+		folio_ref_unfreeze(folio, 1);
+		add_hugetlb_folio(h, folio, false);
 		return rc;
 	}
 
 	/*
 	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-	 * sizes as it will not ref count pages.
+	 * sizes as it will not ref count folios.
 	 */
 	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
 
@@ -3474,15 +3474,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	mutex_lock(&target_hstate->resize_lock);
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
-		subpage = nth_page(page, i);
-		folio = page_folio(subpage);
+		subpage = folio_page(folio, i);
+		inner_folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(folio,
+			prep_compound_gigantic_folio_for_demote(inner_folio,
 							target_hstate->order);
 		else
 			prep_compound_page(subpage, target_hstate->order);
-		set_page_private(subpage, 0);
-		prep_new_hugetlb_folio(target_hstate, folio, nid);
+		folio_change_private(inner_folio, NULL);
+		prep_new_hugetlb_folio(target_hstate, inner_folio, nid);
 		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
@@ -3504,7 +3504,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
 	int nr_nodes, node;
-	struct page *page;
+	struct folio *folio;
 
 	lockdep_assert_held(&hugetlb_lock);
 
@@ -3515,11 +3515,10 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	}
 
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
-		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
-			if (PageHWPoison(page))
+		list_for_each_entry(folio, &h->hugepage_freelists[node], lru) {
+			if (folio_test_hwpoison(folio))
 				continue;
-
-			return demote_free_huge_page(h, page);
+			return demote_free_hugetlb_folio(h, folio);
 		}
 	}
 
-- 
2.39.0

