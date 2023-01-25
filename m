Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB167B3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjAYN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAYN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:58:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E746162;
        Wed, 25 Jan 2023 05:58:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDjo1s006081;
        Wed, 25 Jan 2023 13:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2QtQHkHrgej4eK8SzCnY7ilgBRFI1FcvoZXEW8fQUNo=;
 b=bclqgRwXLS4074MmPtZhhBJZb7LQRuTFJCVF2qINaQib4aKG6jAxwjveAiRWauEBAwJf
 6Vp9xR1JnGUUct0TgNwUWP54s7o6e2r3p0QhMPaehHqM6paStWMAsjwKx9tjSOXrD3wx
 Bt1HaWqNKTSz8BQC1bLgNYKL8VdRWLv23/SMqiS3n9AY2sOaMaq3ZCrdZMzkhKbRGbgP
 T6Y8L6rHRgkqBcqmaZ0iY1n4M/nfMy8YsQwKvDDSp6gQ+OWkIwiHpaMYMrMY9NbK6HkL
 ZH9InGwrDdN0g4ZczUmSfllCMGby1I0eGTGMrszsDCXaV69Sy5yK57n9DBrU1BZCMidc /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa7wxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 13:58:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PDBtq9009321;
        Wed, 25 Jan 2023 13:58:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g6v3m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 13:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmdPOD8BQb1DTmyaYwCkxvDZ698IZtb/QOKak8Y2BT2S2WIphoEF1i5Sog4iArg4V7sXiC5dQf+a2UC7nculSOouxf76Jknlrayp5KVzCArKyRtuGxwuoqXEYbHobS+Q+MVk1xOQPPPnBH/xbz2upJpZHWO3ikPRI/xQbEc3CENMT436KOQlIZeg3B52eZ3rOcI2XD78FHbsZyWsCD+MwaTq1hJHnLkxysozL8yQjiMFsusCCKM7ljVwB63d+iV6KUj29oEq8WnxDXEhCW4sQUWLZFh64ES96tUyHK4GD4QNMZt7X8pwFZskQ+ZRLncTV8TlFGfpmKv+KmDjGPxVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QtQHkHrgej4eK8SzCnY7ilgBRFI1FcvoZXEW8fQUNo=;
 b=cu2I2llQGF4knQa9fSrXz0oFfjMD3fpzsNnU4srwU6avwZ9Ho3EEHt5E7Qlm+dI+Zkjsd6sPTaed0JjNYxFr53uymjb4JkzeMRw5z5Lely72D8NDxKPsyF0RP6DVE2lP7mRoZzXQvIrjyWOaGfLKBgcSEJfyShfieOG1YMqEdCyyHq0Pc1ohOCHj5CoTyaCmt6AO8pkVv09fCBNRa94xgzlN19jyb+NibPWNOH0diZeT7JODuKpExZfSSsvY9RsA7Tk2xLPUUw/wRclvpxq4O694T7crJrxJmkQkl1HnujGLachleihG9v1D8lKGaR1xR2pbApqABRBwl7+MC0QiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QtQHkHrgej4eK8SzCnY7ilgBRFI1FcvoZXEW8fQUNo=;
 b=SVTY0mIBQDfZgMC8iOY/B//DtVzcu60ex6qH3wNOTNHlh9MPbISMPd4bGR82UBzztKY1jgVTLW3eAe01avXct+9gg1oJu0ORjaZXfpS4ORVcQC3vJRKIc3dN5OdxOTCm38Wnbzfxqmt0KJiOfk6o2PzT3Dbi5Ril/gzGcQiuSIM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5916.namprd10.prod.outlook.com (2603:10b6:930:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Wed, 25 Jan
 2023 13:58:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 13:58:14 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     Liam Howlett <Liam.Howlett@oracle.com>,
        syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com
Subject: [PATCH] mm/madvise: Fix VMA_ITERATOR start position
Date:   Wed, 25 Jan 2023 08:58:09 -0500
Message-Id: <20230125135809.85262-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0030.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ec90bf-0659-435d-59d6-08dafedc33f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqcUS/PM2AbH3/hzsvE9a9efqZe3XYafsyT8D9re5pNBtF1z14Vg1Psi5uZvnk3PtOrX/zCzkrsROsv2TdAeeReaH936XKpKYOrOrlTYG3mwhump8ZckRetrzLmFMSUGdOysbPHvNRBPHz2SqzSMZk+H1MeX6ZSDRjZ7i+Kxqe0ue1bMZOnza3BNUtzYXjoT3oOE8U0aXDIdSzSKF/7vMZTwsYoYg0RyJp0Asy8ylm2MrQvVy4BHcEjGRAhTQuNzk2sVbum0ZEBQsY6Af6bUOFH5NtmQGil20absBuRjTbrd3GHQQHmHADBw/PnAzgp+O6bXKS87jUhh1jDWq3lgmPfgRUgpjc59hF7MCOCR3CcpjjEFwgTHJ6RQ8xz5c1E0arDH+6VexWjU4NHulmHjhtnjN0EVnUrWZB6xfzN8nGyaVp7JWaGb5lR+kP6porcLnAT1bqRsOKY8E6G1uGZpYIWEWl7qepB27WyF2pbYlfEEPZE/YzK9z9CzniWlZC8iWV82iBSJzZ5f0LkCx5D8bwi6TeWhVQIjLDZT1mhbTyfItuCMssk1uHJ2UddqxWiEjn6UiUlNlGh7BJ8ahrw45pm71E79/w+Z90+kW/J23uk2usrcbyOUtHexAs5po7ot1ZWwrRZ4hs1gtLSuICqllA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199018)(86362001)(66476007)(66556008)(4326008)(6666004)(6486002)(83380400001)(5660300002)(6512007)(6506007)(36756003)(478600001)(26005)(38100700002)(8676002)(2616005)(186003)(41300700001)(2906002)(316002)(8936002)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qsdp0WquBv4XAUFsaZSwcGs/1784QS4mCKmvUD2+JdiwEYI+/+AxNtpwhcY9?=
 =?us-ascii?Q?dKdwQGJpvVj9PqWKBdkL+zEubwn+Ac6gR9iTknBoO6mJlQ3a5umWQU7athIN?=
 =?us-ascii?Q?gLa+a1S5XiXU46OW4AJIvc8oXVYgXsWTlWmRMhhSNpP+oPJhvTPE8bryRBht?=
 =?us-ascii?Q?awXxqoSGuxZgdQ2nbnDpt3NVoEfGUz7xNOOFdwr/gyuy3QPSpmwc/2ed8tzs?=
 =?us-ascii?Q?eRx6VaHBY3+ykzLNahLuDJ8H+hQPnbA4QzWK/z3ireC/qPYHxu257opUqVLJ?=
 =?us-ascii?Q?QeFEdKWfaTXxdGNZjT75tsodmJdQJEUGieggj+XABjfT5p/XAYsMt03wz1gY?=
 =?us-ascii?Q?/oyHVxChPlh/VCyHEfinihq1ruoMMG+Ap/Jbr4XiLWY1pxaMNuaA53mhUk6q?=
 =?us-ascii?Q?PErV6+3+kcDkNFk3A8AtBO6c2s3+KkgAZy9BGuPCrSyOGKBhCrQqhgAnfzVn?=
 =?us-ascii?Q?RRzSTIXpN1bwhiR0LLZeEfv3UUzUGEZaXaS87ZgV/nPgIPmzrlPTmdIQz/9s?=
 =?us-ascii?Q?JMKvpY2y0kDBAT93GjNDQlh7+kk6B5m4ykBHJefrw0tZ2uYze41mqcphTUBp?=
 =?us-ascii?Q?dFvSeBgCNx+1UjV/vMYPnkikCpnE2lkDo4sk9sg/3UXz3IbG9T93DJsAsGaP?=
 =?us-ascii?Q?IZsFtRLex05ojbLttyz7RlcbXjkFpN1Tq79tKUjvA3EopnLsJwExkuLYBodg?=
 =?us-ascii?Q?9dnGABdfeLV4F0D2azLMW7x8NsEzXNPTJycJKhNoPvUvwsHaQXItfjtGQ65L?=
 =?us-ascii?Q?4xX1e1tSxbDdpWmX5x4Kvt2JA0sDMDz3a8NaIcvdgUg4QD8XDUIydpq9a+jX?=
 =?us-ascii?Q?LttNQeYJrAU/q3p2zKwqPpk/tjRdPyV90QOndkwlqIIdt9OxEHnxBAMSx0Al?=
 =?us-ascii?Q?EpN7GokcsqZGcNokwhkZOxjm46NnTjHdQ+YDHKbIEfQPoRJ9udK5MCMAHCOZ?=
 =?us-ascii?Q?2UBkLYhDkLnH8ogmzVueiK5yQmFbnPG4N2mxYIhd8JO9gCBcreVAPZKCJqYk?=
 =?us-ascii?Q?hPWnMLd2V8ggZfDkSi8GQcavifpnkyuNniNS2JGTW3Y1f2i4vKTxEewHGtiW?=
 =?us-ascii?Q?hUGve8Dw3dlsvOFddLhywkpnDYy2jSYDStkYHy9PaKKMrnb/XOiEJx4Vh3bk?=
 =?us-ascii?Q?wngE8D58xgJol/ICMDohdcJyXKsoLWhdpu4fZYeo8TlVDjWM8tLy2X7KJgz5?=
 =?us-ascii?Q?cYGHOiMeLtstenWrI9ViVasjKcTFc+X2FT3C7msVlaS3MPTTVAf6c+f9d2Vk?=
 =?us-ascii?Q?v0yJGUoBvoBDU/LoAPF2OUJbY9CfnUaPLf1glD2k1wwRPe4sV0anM8U/RIyb?=
 =?us-ascii?Q?lI8eye4VS2iXUCZlhxQNpPbkJF++NdYq0YmFOJQCtC6C9bQFze642t0dN/cn?=
 =?us-ascii?Q?GRkAPEuZo3S8z55AAoQzvS2rBgzDGJWQq/4gwjc2BxIo0GINAp/BWEHxM3vt?=
 =?us-ascii?Q?aND/a7fc5h24YbRo153W/1dwAjLWZnbJp7+idk9P4ahFUy9SKeM1kh5LPRJU?=
 =?us-ascii?Q?IxCNfYQO8ZgSacs0+zgi51dfauc/Sq8DrhC8zwXqt6a6TCPRM5w0zCiP7vPG?=
 =?us-ascii?Q?1QQIyVYirvY2zB4jg5jEaONMhdAj2CTvqOBlz7hwGhhpk5nJQIyCCERXORjt?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?z3sCGTEZABxpWF67JrEfqfSfRjDOnT0aYn50+qVC2KQtwG7t8kNuxEl5AgIX?=
 =?us-ascii?Q?DL6VsXjl547b15obBlRqANEadONFX3HiUDc/lBObZVTzyN27DYR+iZNtEXmG?=
 =?us-ascii?Q?qAPOZPgdP97BGrt0qX49U8RsQ7r5RYZpREdIE3doem1xoWPFrJV+IoGTdv5q?=
 =?us-ascii?Q?3z+8SQDazAPpAEMKM6Ztuitru4eV5nqWcQ2RGXuKZw/09UvBpbPLXjbg2Jyy?=
 =?us-ascii?Q?EZphPS6AGhNVpwdZF3nk1XaaKDCUkOi61MWgs1zbHJqJSNh3YKpi33ZF1ZS3?=
 =?us-ascii?Q?EkbsNAHjURcW2+0BSSXUYUb6tYR0dKxkJmQIiisk8Kd7TJVsKAnvyPiC3jLH?=
 =?us-ascii?Q?+IVk28vzKpsSelEk9JTsOQ4uT6OfH9TROqoCEnUDI0rr5B9i7c5rMlXNHMtT?=
 =?us-ascii?Q?+6tPbp2Z+UusYl7nTtFXeLWFPA6C2aOUfbVqs6u5ZFVRWF9fqR0xlBngWgqk?=
 =?us-ascii?Q?ehG2SyuwhHl7y8z6Fzot2hc96oW3wrtVSc0ksK4oHx/V98nmf+PCkM3CrLDl?=
 =?us-ascii?Q?NcnPp0i+/hHoSE5ttA72E68+C8ylYP6A6dcHVpr6AvfM6RmjAl0Z3wxdK2gY?=
 =?us-ascii?Q?tpNU9glA3ticmMrlwsrqNI+e/kkobLs7Qowq4rgeKEZvIm/KU1n8NjJnbgut?=
 =?us-ascii?Q?49yUZ5bu0BeA/2y4qBIo2wKQpOcjQToDQXvaMgsMjI6vt4556D4dddPMnH3n?=
 =?us-ascii?Q?MVcLPhZfISxi7zc8adt79TqHHYTLelFhU+PqPFYUCj+Pxu5Mwn1SSxGR2zGd?=
 =?us-ascii?Q?sCLNuJaLVcro4IRsuhJsN1xX3PP52yriDfjgIm68f202fpK8AEIi139X+KJt?=
 =?us-ascii?Q?jECEDhOks90spt7axnh+YhovjCNS9Zk4BpcuBf8Wv6wiza24CjpiSmkH+CzF?=
 =?us-ascii?Q?vlWlnxedM2IFqifs+cYFutQANax7vrLK1ZnRVxqONJGws/Veo93VWgv1vQT9?=
 =?us-ascii?Q?mXWb4Ob62JK6W3miiHCw0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ec90bf-0659-435d-59d6-08dafedc33f2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 13:58:14.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmp/K0SRMT6dEeoTV5kFUxZDDsfLIyqerKABWojngOMtfTqWUZsgf1JeRufBAj9hAeQ20kkapZ50fYQIwxp+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250125
X-Proofpoint-GUID: 91weMgZk_WNxnkjZJnOXjO3XL2yxb0Ih
X-Proofpoint-ORIG-GUID: 91weMgZk_WNxnkjZJnOXjO3XL2yxb0Ih
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Howlett <Liam.Howlett@oracle.com>

The WARN_ON() in vma_iter_store() detected an invalid VMA iterator
state.  Inspecting the code stack from the report shows that the VMA
iterator is never set to the correct start position.

Setting the initialization of the VMA iterator to use the address
'start' fixes this issue.

Reported-by: syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
---

Andrew, this can be squashed into the mm-unstable ("madvise: use
split_vma() instead of __split_vma()")


 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 7db6622f8293..ca672e37b38c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -142,7 +142,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
-	VMA_ITERATOR(vmi, mm, 0);
+	VMA_ITERATOR(vmi, mm, start);
 
 	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
 		*prev = vma;
-- 
2.39.0

