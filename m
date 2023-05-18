Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD5708478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjERO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjERO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724818C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Il19012457;
        Thu, 18 May 2023 14:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+Mxye0KY7tWYyadVwkLe4uGBperlmwR2B6BWsR6giWY=;
 b=iXBVlSKh9H7S4lCnaEMQGylVd3Ai1LbYcccQ9POcDtt8Sl9cYtR2ZJojZVFexyfsLuJy
 D4nfQZQK8ykPvXd+hl1+anC3AC2saZOKhubsnApoWdolG7H360y7hxrohhcpjFBMI/RQ
 WMKjXdElNVkwkXuRIXSt2Htm8N1/GV616WmMGovOThnUBQZ1xBu/aANnyQ/OB+7q6OYW
 OXBWy+8xkziBHfObbUSqZVhHYbKMsVexMNuFGzAyX03r0DP8JuhqtbMsyOUquctYVr6P
 oXjhcKAElh+HJj+wodSzG1stPjzYbHK9hsmdFSBTCdBCSf8La3XtJRFgHERr6qa5C4YR pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrh1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEGfoF032234;
        Thu, 18 May 2023 14:57:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cwt6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNIZiQXlliBMTjk0ldo6Xkct0QN7w7wEiQ+yK5M8INGYYO9UJFrwETd6xlrQYHWdkIDodCi6paZDLPXnZiA4czW052k3b7K2FA8MOC4kX1iQNpvZKNZp9Rbm+duvnnE/yMZWrfvih8q0xAQnHvIQYdLvOrimoqgz+Zxbms/m03Ool12dcDcWk711xtlQ5mZ00hdDzkCseyUn9e7F0ZpMs0/fF4inkkVMBk9+TcRX2qO+z6VmbZnsY83FMOjLOyBTIpSGMWuOf5UMsPd4sZWBgpPGJPEQ1mu+Rlf0EyauhFoXtHBGumrDRaDXa30CRFauduKnyuof6J+wbLZcgCIT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mxye0KY7tWYyadVwkLe4uGBperlmwR2B6BWsR6giWY=;
 b=KKyTHl4YTHAIKlKewEfLi3B8/9e/CIDfNTcRswcNrzClyRu5IYqtVIhgbuhTrCa6qMX9mD0Skogu/6EqBdg5zvm58yV2/I9IGqtW4n/1hLjILkZhHJ6hHqjWvusKhN6mTps4hZxbvmS0ed03lnaWJs4/ce06d220guUegNzFOa2Gqj+qbeKdCNkKKW7QM1zTkOqcXQVgX8qlQibrfuL+uT/5zBSzqayFMtmnkzsDBFJrSlsPkK7RiKhOb//1rlqOeDsMmQVMNSxX5ySdLWiacnI2+son3VsYVmjEJBANl9JbgfVjc6eL7PF5aDePyUEYRddCrPRGER+WyPtbHy+A1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mxye0KY7tWYyadVwkLe4uGBperlmwR2B6BWsR6giWY=;
 b=DhvHMG4aMS+E1SxrEonO8a1ezGo+FWrSBlfjQliP7cOI06kZGgK0lfNZ8SqjVpIHz2PV2IzsMf7Gjrtz+KMH263gVaoxSPsjLhDITgm3PEl6KLmqUpM2bZxXjuzJC7VEQ0b5fs7kU31lM6bw37OI0NUlJOeGQfkCWJ4Solv3a6g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v4 31/35] maple_tree: Add mas_prev_range() and mas_find_range_rev interface
Date:   Thu, 18 May 2023 10:55:40 -0400
Message-Id: <20230518145544.1722059-32-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 1194ff93-a61d-4110-c2de-08db57b025ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4/Uq0rU3e+p6aNviz0xfoWAvLrmndxGqhfgFnpyXr8gAG3VUxDst5QxuLwKOyYn59MW1su/hbH26HHrAJCnhSFyBEPdKH9g5ZjZcVflOALQnpgx3wBh9yRy26rVL6Zke9vif7lYF4+w09n/85tX9QXXOYETixv2ZzWy5jc0GpLg0KgPJxz/bIK0fe3QBPDNqxcDqZbtE+qGB9NjRyRaIczpjw7Izc9jhySoHu+8m09Y2g3MYFc/lm7WFbWhznEvqQKiRQt0NtjNhDk81h3tvhosEZoKrZlPWCkHSr73BKpIVuoox1TM2LR4C7aA8lbpefsslt5HRjZ7HHZPYtS/uOITgY5yoAm9oEO83oQpXNUjlBfYIpI+T5wNVMrDiMIE+N9EKXk1H/DPuJ3IYveH0HDezuOeYl5vevcrVIpPyiJ6eupH/h52xMIzBgc7SNhLhA8ccQ9HwkkAlOitygBiwhS8r2MDfisSe7FQYf8L0BwbEGoXPXY0ERTmNbvPJGvkfOvvNif4fpk1YLF1XhcD4cffje2iEiuzvRvyN9HSaZ7/U6RyEgMIrUqGZAb7eNiV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzMiPLPXa5rF3pyEZ/Ehh1qHPPv4ibaOjBXggGe8pO4Ox3tWxeJFbN3/fynZ?=
 =?us-ascii?Q?ubhk57TTjsx3ZnhehLekp2ifowP6kRdaPSKwRIor0xmm6RjScoziutOFx7dC?=
 =?us-ascii?Q?FdubjDBpF7tZ9o8uyFu+l2udVlmEyliGE2yVbIdxaje568JhTFoCaH3TuICX?=
 =?us-ascii?Q?bNi/RrNDnrXMpj9OgAmGZSHquGy6uvBHVp+jZP6Nsn1APq/xlxsv2qdzSh8w?=
 =?us-ascii?Q?bK2W5m7fqxqQyZjCoW+sxcitP7uaIOqf7bT+b787PNjQ6QjTdmgiRKBHDLLx?=
 =?us-ascii?Q?dMMSQjDmUREnWop7EVYfXOFx3HV+vurzPB3n8hteC7Sp1o9xXo4C/Thur92O?=
 =?us-ascii?Q?JxS6RFsgChP+muo7MfHjBRxgboLI9BQULeKS4NyCDVzFld67o3n9Qfusgc0v?=
 =?us-ascii?Q?ocwjhN6DesEH/f7dt5+/c4ymcHVyOpayM5S3pJCgce8BnA5b1PG7b5GvOuo8?=
 =?us-ascii?Q?VdaSqXX5Q0i8k8U3a98/LPclneQbU2UWswCyI56euFeQMBXU7il9vabKxE/T?=
 =?us-ascii?Q?8qkvCoa31FMgt49DmGCa9VE8xR6q6wghdeduk7ou/Jk6BuOoStxScLJeu4ua?=
 =?us-ascii?Q?uyzrcxkCxp/C6vQr7T1HdszXZu1n/xE1EkdUIDbETcnj2oE/wcFZCsUemxOW?=
 =?us-ascii?Q?W2GDU7lqUp12OIXcTfGUjBrHFb/2HprnLGYG0KIz2lrMjg0t3kT9TGKChXZC?=
 =?us-ascii?Q?+XQ2wQF+X/4zvXg2BOdtKudymTvzp5K0MA0vB/NR9ZC1CMyirHf6U/OtfhwU?=
 =?us-ascii?Q?MA6mjlaCxfnRRNGyLI3BpK4C9A33/QXLi7WpZ2mnCJUI66uiQTiMR8QgAj7i?=
 =?us-ascii?Q?1MzLeYDFhSWOvZW/3KoFU5EKKTzbIpgGtQlwLD+RNDWXt51jHs2Nsc+4Aw/x?=
 =?us-ascii?Q?A4WM11Li0rBuXtsFJNT/65AUx9zi59IwLs4zcjo8835c3vlC8GrQP8nav+fF?=
 =?us-ascii?Q?NO/QVsqeqm5/9dA0DDTK4XNsQFqw/wUWFM2qlVLKGUNklIPTRMnNIrf3Dgmv?=
 =?us-ascii?Q?VXOSU1+WqSFJ/IK/aWamlrtjoqBw1up9eAetbw8u1q4HcgOfT2eeoqDBa1e7?=
 =?us-ascii?Q?UNFZjPvgAgvDDB+JQ2zmwdmMD7AFyEhb+qX/7cUDLBVC4CSgtD2MLVr4UfY7?=
 =?us-ascii?Q?BCwTx6yV4GI1Cp3EbIGZbKR9YLFu31c4ojgZ6HGdCuzjkWZ4QkRppGlQ2rT7?=
 =?us-ascii?Q?bed7WVW7T4U9LA18GQ/+IWJZlgVwz3QruTHDUmaAi938gDq5BIUjYZFKOmgq?=
 =?us-ascii?Q?mlHJMQ8ob6sRrWeVDlSk87jsOktU57lUJ+3dTlVIDDuqg81xb5tYs9IQ//SN?=
 =?us-ascii?Q?qi6jVr5xgy63NMmTK6gG7MJYLaX07lVLzRgZnlulzjXUCvvMUDCgzCZ+yjRd?=
 =?us-ascii?Q?JDgiQj06jLwA1q+7Qq+yyO8kkVkJmF6ar4/+DEISMmgaeynShaTv1ISfEaHZ?=
 =?us-ascii?Q?UxVt3bgeyWhA6Rasg+7xsy4k543xuunP9CAHKjtkvuRwDJcQmrnLuGLN3eic?=
 =?us-ascii?Q?WtGmx7ZOt0nck/F0zfniz6Y82u8Be5JXos3Y49GFKkXKAsFbNFhrWIaHmeEm?=
 =?us-ascii?Q?Z5BPqD4qv+N0YhgaceiUKc/wIplruu7aUuGRf4F5BihpBOsJY3c9Kr5Nr2OC?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sG9R34682f9zaLCYZ8ZgD8Usr5lyJadvI4E+sklZGNppcl9uPN8DNJ/l1LKJ6YISU9S4X1rBsPn5p1QYTUGZr63YfZTpiuQhNddPOO6Wx0ZSYYOalPPgBp90OOv/cJgQ9VkjaXxgjyxkgSEoy/KWv30rOfXg/ciZ7r8LTCcTHt5t+1rOl06A3BfneDdQAry0V3bC/15WRol9OKPxrgzY/4gcigfI9rGgxqb+r72k8tUf6vs+3DY1MWLmJ0b8TykEcfJ6tBxKpSzR78DXonr9ZgHEOkb/yo5KaAlIVASH5OKzVbUF6uRUNpHv3Ntv2NRAm/9S3IELmY2tz197W32Bn5pTNeEYm7tmLqYBnfP0oeJV6t21yhUF3HLB6xsLi7TS6zgMfzQ3qAZHcJcOxYrjVNkiAYkkwTx2G8yilcu9kuDDDsme754f0UWS2EezLE06+NuyuQZikleT2lteKTVBOJyI4T4Wb4/qaU4rgEy48gmAoH27P44MNMt7rV6Iyc+i7VWy3ZpVEqm0T8Fq9nOsDJ0hRfvmEayQyPfbWdnDzj1JmUBKAdeYJL8JNdy/ZWsIUPmN9qW1e+UtFTDPWISKGxz5kzhhET2lQSkmIwqwFGaAMk4PZSaw270fKoWnrvvrb3FsB2VgvYbHEdA2Z62K/3KOle81bLdaZoSYDtaPO9jZRkxqe6g3guWzMVeDmDm55pGk+mSedwwJDLT2omrEqGdskgoDucYyrurq8o8C2F4lFqaWwLS+KB9f4e8FhPjwbfN/M0l3v8ECX+lZD9xXllfVhgWP9Eolv4fgyfxA7Em5EKohbH8Z09afdbt2UIq6UC9gfPUq18/lD0hqg6W7LW2yPELPhvFojFPNCxrhCGgxz7KHknlvIYWP4LMQFDqgkdSAIjA2cYPLnRDV7q53HkhZY9zUiaG56SIncHQA4EA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1194ff93-a61d-4110-c2de-08db57b025ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:06.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek8qF3rooOtXOUxdVmLAgV1SaJ4uEhPgb/3qGtThYmA88X9R/PfxgHdHWeQKQXd8D488ksjzeLZe+vDOyjjgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: M2n6dt1vGknjeqWWHdDHZJEkCgmqfMpb
X-Proofpoint-ORIG-GUID: M2n6dt1vGknjeqWWHdDHZJEkCgmqfMpb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the previous range
regardless of the value stored there.  Add this interface as well as the
'find' variant to support walking to the first value, then iterating
over the previous ranges.

Cc: Vernon Yang <vernon2gm@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   2 +
 lib/maple_tree.c           | 161 ++++++++++++++++++++++++++++---------
 2 files changed, 124 insertions(+), 39 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 9d040043858a..541675229568 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -457,6 +457,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
+void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
@@ -467,6 +468,7 @@ void mas_destroy(struct ma_state *mas);
 int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
+void *mas_prev_range(struct ma_state *mas, unsigned long max);
 void *mas_next(struct ma_state *mas, unsigned long max);
 void *mas_next_range(struct ma_state *mas, unsigned long max);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f0e9ce5b0515..fe481d4e5e6a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5924,18 +5924,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-/**
- * mas_prev() - Get the previous entry
- * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
- * searchable nodes.
- *
- * Return: the previous value or %NULL.
- */
-void *mas_prev(struct ma_state *mas, unsigned long min)
+static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
 	if (mas->index <= min)
 		goto none;
@@ -5953,7 +5943,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		if (!mas->index)
 			goto none;
 		mas->index = mas->last = 0;
-		return mas_root(mas);
+		*entry = mas_root(mas);
+		return true;
 	}
 
 	if (mas_is_none(mas)) {
@@ -5961,18 +5952,64 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
-		return NULL;
+		return true;
 	}
-	return mas_prev_slot(mas, min, false);
+
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_prev() - Get the previous entry
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, false);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
+/**
+ * mas_prev_range() - Advance to the previous range
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev_range(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_prev_range);
+
 /**
  * mt_prev() - get the previous value in the maple tree
  * @mt: The maple tree
@@ -6119,20 +6156,18 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 EXPORT_SYMBOL_GPL(mas_find_range);
 
 /**
- * mas_find_rev: On the first call, find the first non-null entry at or below
- * mas->index down to %min.  Otherwise find the first non-null entry below
- * mas->index down to %min.
+ * mas_find_rev_setup() - Internal function to set up mas_find_*_rev()
  * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * @min: The minimum index
+ * @entry: Pointer to the entry
  *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find_rev(struct ma_state *mas, unsigned long min)
+static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (mas->index <= min)
 			goto none;
@@ -6144,7 +6179,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
-			return NULL;
+			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
@@ -6152,14 +6187,12 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index < min)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 	}
 
 	if (unlikely(!mas_searchable(mas))) {
@@ -6173,22 +6206,72 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			 */
 			mas->last = mas->index = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
 	}
 
 	if (mas->index < min)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find_rev: On the first call, find the first non-null entry at or below
+ * mas->index down to %min.  Otherwise find the first non-null entry below
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
+
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
+/**
+ * mas_find_range_rev: On the first call, find the first non-null entry at or
+ * below mas->index down to %min.  Otherwise advance to the previous slot after
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_find_range_rev);
+
 /**
  * mas_erase() - Find the range in which index resides and erase the entire
  * range.
-- 
2.39.2

