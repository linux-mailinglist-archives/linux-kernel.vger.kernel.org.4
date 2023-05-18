Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C1708473
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjERO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjERO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD51717
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Imq7012468;
        Thu, 18 May 2023 14:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4MZtDw4J06RcQX0cknN/oceBJwsIK35YZxd7Ng4DHGc=;
 b=UTPS2Nug2EG4ACSLkTFNvodooAe8r15AhwAV/HfeM4h9WbvIk9sAIqSWDmB8bzgIuOrd
 nx4Gjt9hRr5Bu/u/rbmUEJDE9XjgjhOAFKiNjEhbr+KSp5w4PM/6X5k79mHcemImmIMR
 5af738nkhZCDBh05Dj/RXYCZi/bD9I0QvJQd7pzXXVYr91byP73DV6q74wtoJYIbphSh
 NMpUxRP2sjwMJ5IpWzQ6pDBqv7/1AZkpusJ0jRMoOt9jk/w40HOgvin3yaE/+VuPLktD
 BFL7taiCBeQ3gXXIL4R8CIDEqWkS4eDRnJezOIU7j+BAVze7Wk6VdpISlprrReJhRHr9 Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrgxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEu7OT040086;
        Thu, 18 May 2023 14:56:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mpsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6ji0btn6nba4r2FoksNEv03LqUmjTyzh+mesX7yIQS4RheQV1zqls5tUuyw75A8yjT+l0FStzc5kIAn6jQsmG1nBWs8+lZoyKynXLUBcAft/H+w1VaKXLtNCvUEYLvym944iGMgiOc2xQjplhwITXmW3HNzT0tA+yEcdf690LMIZcXf+T6m0EwIETxtdnUyWasBMMCCx04udpQqEBlkC2tr5uZ33MrmxuPPbyEM/VZnYSOaOGuCeL2XCLzwL1k8wmP0+ihCwFbzf3yHMcgOyyQTHgTpD+z8zYYUxWZksJ1ODe/HrDKF5p+VBFdLwy9y0VGfVYHGQ+2P6wiydsPtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MZtDw4J06RcQX0cknN/oceBJwsIK35YZxd7Ng4DHGc=;
 b=DojWTmu1jukOhwfZWhArcPjKfYZrpx0XP5qg+JC4AE6GdHsh57Mqd5PCicsPvrZPCETlCVQBYtHw7ehuYJ+VBdPd7s+OcX9/0mctJ1HWO+0IpFG4cXyzRyjdqnrxU24MvXNrdI/OQ4xjYTCYlPGX2WcQoH5088L1Zcv4o97b/jI2X/eOavEnDEod8Q2WAbX0xfSbSf36otIb6qEJrAjJ+pEjJp9tk2zEy8XdTnvLdnwOK/Gj9dBsjGn4FNHHNdZxK6t+EFaGm4U92tQdbabmFh/92dxt9IB21uA3FAGPQ2A/LtvZyM7MzVJQDGbp6GfGNqzSZfAswwLeTOzHme+IfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MZtDw4J06RcQX0cknN/oceBJwsIK35YZxd7Ng4DHGc=;
 b=ltpZv+K8nTHe/OTBMJD1TnXVgeFaBOrTb64lX885dnPfglFCV5J7sC9Bytv+hmbJQKee1cpd7n4XceM0l2wPFdKmXlg4QVn1KoZm9wEN8kHA+qfQIEjnrVdck3Yum/n9QQZgUWQLFXgttaBXIh+3uueLXAyrODoBwGtfXvJEPgk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:24 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 15/35] maple_tree: Return error on mte_pivots() out of range
Date:   Thu, 18 May 2023 10:55:24 -0400
Message-Id: <20230518145544.1722059-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e490de1-120a-4e1f-41e7-08db57b00cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HK08ziRtqxRwF91OAShqgIea22V+zaE1YdBdpF38+9CYmhmWb5DUGTLFSk0Dgw/Xvc3vpYkKlCkm0cboHSkuH4zFERo1naGFzdOsLavt8DnPLochgdW3LE0lQ1ibF4By3/YiLdBbzoQJmtHdr9KfhRsdIreRIwzvbCQ9qW/P6KuomwffyA7hHwu0lWfcB+FFkd6IOT10zZT8Rvw0riUsgVTsaC4GvxIswUyANuoYVmbg0COzYXUmmlU2NFDqMIGdDlGssjofoITpn7q88/bCeU0RM3jOpwXnfluaNNW/DiKBH6hV278FSWSXKohR4v5wC/AOaEVv58Sa03AZN17/ftDlxCwU3DaApYMPnkd/sAcaVfzhAOdi+owEZcFezAoguuwb6OW8JfTINouf5NONPVcZ9mSttKjsZTXVGUYb4rpJbhrwZo/5QdWiAM8G/6LsI1/yiLXvvvdwecr/dDYY4mqXKGebDcbh91vnLhKYD+m5WtOnA3kF6qhgiadD5k87fDAo3vz/Tf2RmzoW3fKcIWwVgchUQ2CbNvVkBGZsGL6PWy7n0SnxISQkpD/mmgCG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(41300700001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cbzn1kSabOocGsfkNJFP7931oJQxQqIAFrnvFG5PkH31JSQ3fe8RTHNnoMGt?=
 =?us-ascii?Q?J5Qua0aDLxtrcRPLiz1PbLMVVlTrg/kp16gX0gOYYtVtDyS+2FZUEMG6z+uU?=
 =?us-ascii?Q?/sFlCGpvfQSCSAMpSwfpgBSXxm9lS4TRTHEVZ4mVgGL2GczAI5BcIkTPZctD?=
 =?us-ascii?Q?H7jdrc3eFLmYWjDS42CnVOpZTXAyoXSIhVr9d64srul5QDhMZlfuT4lmaioG?=
 =?us-ascii?Q?En64R3wbYbysR5BOShCSOYzM06dg47AYuCGbtBU3fQZzTBTvDGvwr6smgpnh?=
 =?us-ascii?Q?78tzfnH25lRHUnujbjxaEA25HKTSBOcrz5S5IudUk2FrMXJ0ijkELqVQriDT?=
 =?us-ascii?Q?5BlPlTyHla1zNxm7EbnQ5HcvIigCu7m8DDD99wSPlJPG33JczXDnogT//WLg?=
 =?us-ascii?Q?aLmKNEG83LFnRchMcd1P1ORqGl38nBLkMEJ0cj//qwnKp94cQbNThec6b2Ca?=
 =?us-ascii?Q?7kqM2mnoIMCjg6cpbC9wnfezxL0rEA4lU51p2P3KGO7ZgFb2UnhTkA8ySBrc?=
 =?us-ascii?Q?bOuF8615qFcjBf4vW9WQtBQFhZ+qVDt79ggfqHEKENP8bsbF0nRQZ/IGNyO1?=
 =?us-ascii?Q?hy0P9v6FYDimyQ7sxT8UyO9AGhxtdeLfOn6BSbOM0fsgg/KBosMB7ZZkSqRD?=
 =?us-ascii?Q?1dP6zRAZL7obkEO8URS3ShdK+6Gdzh19ogGP9jIQitLbU4pVkVEqUMuk/vTq?=
 =?us-ascii?Q?h2D7oLgWAiAK2IZKBKS/GFG1lUqD9Qv6Scsv0hLyu9aUcw6ucI7WH5488S+k?=
 =?us-ascii?Q?RIRKNbbJv+CdeZ8fU3oSYlNL+LMdfROt5sMBNMCCbQBNQJ0vStH3vPIsHjRN?=
 =?us-ascii?Q?UBfPxe/prg+b+COtsKjYCHfJu1MboNgAJcF+A07gXIlmDBTGFqwTek3rz/zi?=
 =?us-ascii?Q?36Nkf25bJt+S2ILxmvUe9F6x2Vr6MOyb9umqp4L2LPaXblsrXQkPYkt9vgkp?=
 =?us-ascii?Q?m7MTUSUyRGTJN8PfoKKDpUUfHrg3QfnJ4WQ/bR9V+m5ZywqSE1VrWv9AQzPs?=
 =?us-ascii?Q?kvogF0lslz/VE/sqKGBcU1gCkDOKY934kbac1PyoOiurfr+8rro6Dx7oPp2/?=
 =?us-ascii?Q?uNbE8DbXAgcdv7FSrEdawhdpSELg9FC1t+H4vkAaFexQ8xhn4+v4pdTlFnpE?=
 =?us-ascii?Q?Uzrf/88pV6dQb2APPS7lJM2Bw8slw4Ag3J+hVc4h4nKIMllhP8Fu+c+r9A2L?=
 =?us-ascii?Q?XWoTWnTDBBzxpjdmn8QxQ2uKJpjige5i1FyzhuARFhrFumc5OvrgvmpovRkx?=
 =?us-ascii?Q?UsfFVTWOqLDguCOuNdYphw1zgU1s0S7bg+uuMFrQm5zhbEK8Ml/8Ird4xFeh?=
 =?us-ascii?Q?UQG9/Pj/4trkLXpspDv0qvI4sLrMrbK18O0zUkFC9IbFsLgAZUHVpuhcY2jh?=
 =?us-ascii?Q?l/l/yiCj8QwUPquIkPBMpO+W38Sj1UJBXl1nv0mmOy5gPfGP33ieFJeSgZVe?=
 =?us-ascii?Q?LpNxF5uxon0tiKNEZBg9wwmJQGYDFNV7tbfB01Cr2mihIA2dHlBg1+2JcI6S?=
 =?us-ascii?Q?dqoAj/x2mnoKPjTOD7ehvBigpLgK7oHX68cZ5nPlYYYIo4H+v2HD6vVce27e?=
 =?us-ascii?Q?THfqQK2hS7k4jMF3k+FT/a4lAlmz8LUah+hbaT5RpNT8RrW7eqII+Dhlu44p?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nPHDj2uhe2ZEgZU719VvmF5bdI62Flf41ivoOlW7FdJFVHUy4j7yXqIxAWtW?=
 =?us-ascii?Q?l56kn81aNoiCEe5tZWVuC1wkbKtS5fEwTz5YchLBXysldHLaQEhBrQu+bj5n?=
 =?us-ascii?Q?DkzVt3UutbsJ9NoEjahshQ8lzNdtAf6jeb0zX6QCDLuriAXUVCI4s9s8IPlx?=
 =?us-ascii?Q?sVlvwy9GAt1vpHfJfgBFcva5sGEJefqPULTQFhCwT9RA5nB3D8RflRvwRuJI?=
 =?us-ascii?Q?Cj7HU/VE4esJ2C7lF8Eu04G3UjBM9LNfobJVZIzVWP6EEp8v5mv9I1U+zuez?=
 =?us-ascii?Q?cH4nvNnz0G5dqUL6aOxWVg+4gKDRZJmHlaVN/9lKqaUgzxQWkfsCRoF1Z0iD?=
 =?us-ascii?Q?3q1VAP3eqGbFsXyf1ekAJwi0SIuVjS8Oea4DHMt982a3i8J5MolhxPxa44+H?=
 =?us-ascii?Q?RRwv3LX2CKBCt2CSMZ/JXn5cs7a50tx991Mt0n7CgcWMGe5E6rHW+5d1RWOe?=
 =?us-ascii?Q?EHA0R9TlB9njo1mNGkPsfkiVCjrGXX49aLSSod/xLG5pJuDbomAIYpbKRhHW?=
 =?us-ascii?Q?8wkg4gxaXvzSIwO/OeHV6jx99gCia/6Qzh/2XuIT2fjQzkFn7cRJGaDMTCKW?=
 =?us-ascii?Q?TL42njSKc62Y/Bck17ri8Gc8i90tEIgJZApl02FH7nyIZuV5uh/w4280I0ZQ?=
 =?us-ascii?Q?S8CZhy2efFpZ48rcYfOoCTSYyNB5ripZR+lgI5Xjh2FdcDcXjFHmBQq8BAAL?=
 =?us-ascii?Q?jAUIzY4J4gGIUTMsT1nk9kFmwCJd9dt0L6vIXbonfCb9oK+keAyrhQuBnK3N?=
 =?us-ascii?Q?Tu9B98xLNA4QvOdmRGyyDm4yLg1yPoGBGR+2R0uQP+I0WPQzLuAnJiUqFUZ9?=
 =?us-ascii?Q?yzABdvDLtOrUmabaP1SpyDRMfMyjAa8u/QM2izYq7dtH6fmsj3Ha9RoCMLNQ?=
 =?us-ascii?Q?pH2a0RVknLOBqjkPLA0rRi6inZPEITIcUD9D/oc9yVo4d6yxpgqlVPL/GWSi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e490de1-120a-4e1f-41e7-08db57b00cf5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:24.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BuU7IjxRUEzZ0Vk9JUDPnyWEFwgps2aXefEkPcMBZr2rgA0vsQ2FVNteWkcmg4G+JcmTDX5jcJgwP9rjCWSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: v33UtgKjWn_jLqCX8-aT7Wi3ERorXtG4
X-Proofpoint-ORIG-GUID: v33UtgKjWn_jLqCX8-aT7Wi3ERorXtG4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mte_pivots() to mas_pivots() and pass through the ma_state to set
the error code to -EIO when the offset is out of range for the node
type.  Change the WARN_ON() to MAS_WARN_ON() to log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d7809a7000c5..9f3784f4a5b7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -663,22 +663,22 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 }
 
 /*
- * mte_pivot() - Get the pivot at @piv of the maple encoded node.
- * @mn: The maple encoded node.
+ * mas_pivot() - Get the pivot at @piv of the maple encoded node.
+ * @mas: The maple state.
  * @piv: The pivot.
  *
  * Return: the pivot at @piv of @mn.
  */
-static inline unsigned long mte_pivot(const struct maple_enode *mn,
-				 unsigned char piv)
+static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
 {
-	struct maple_node *node = mte_to_node(mn);
-	enum maple_type type = mte_node_type(mn);
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type type = mte_node_type(mas->node);
 
-	if (piv >= mt_pivots[type]) {
-		WARN_ON(1);
+	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
+		mas_set_err(mas, -EIO);
 		return 0;
 	}
+
 	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
@@ -5399,8 +5399,8 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 			return xa_err(mas->node);
 
 		if (!mas->index)
-			return mte_pivot(mas->node, 0);
-		return mte_pivot(mas->node, 1);
+			return mas_pivot(mas, 0);
+		return mas_pivot(mas, 1);
 	}
 
 	/* Must be walking a tree. */
@@ -5417,7 +5417,10 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 	 */
 	min = mas->min;
 	if (mas->offset)
-		min = mte_pivot(mas->node, mas->offset - 1) + 1;
+		min = mas_pivot(mas, mas->offset - 1) + 1;
+
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
 
 	if (mas->index < min)
 		mas->index = min;
-- 
2.39.2

