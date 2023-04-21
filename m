Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E56EAC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjDUN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDUN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:56:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38A3590
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:56:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYxKR025679;
        Fri, 21 Apr 2023 13:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vn69hPZDmzF2R7mLcMZFVIO9gowx2wKB7i0XJROaxts=;
 b=IVBst64ubvb0qXSVMA65pC+3KfOMmpJemD7Dqfr8Ii9vCWDrMhjzb9immkyca+LeGx6n
 NwuYhJBoJXVRLEZQBhLX+836fC6dRV98uldEp90wW4obwdN0mJh7cnT+zSWnSioM344O
 d+cMbX64PqvstV64q6Mg2NjJGbfflf3lIh3G0lubMUtUtB7t0cQax8BUgrvR6keR5SuD
 NrnEzZYJjWGl9IOEeHcwRjNoompheKhrERhiyGRp1M+tNrIcKAaZOfFH8ZoBptkZqEso
 kgnxSpgyVtIsUXRH10Ro1eWAX7vHaqwt5hhaZOBkzKm9OmzR8HVyEp+TFH7NyPUnbTOR Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjucdec3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LD7ndq037117;
        Fri, 21 Apr 2023 13:56:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcfpwf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8trcAMbeOSyCoH9nf2bWoxnO0CVtPstuxgbkqsBfVMkm0DATdFV6XPUvzogiYVL3JJfGldZ5FK7590UXM09KIqKfTYhgV2M3tkv3RbV6J458z3OyG+vuUkHNKrjWrxCoNlufkzqe7vyjfB/SBukBB1zAxycEafKr2bFnmMisDIlV6qNrFsgg0YSY8W+h8gIA74xiG/0gU9u9t0aqswXqSQNyfjDpRED0GcUPWwffuKlxV6FZ7MEJAbrbdIOCnFn++xA/dbyYflPhOBiO4e/zHXyjU7UaOrO84JJgNfTrmXGpYXwGOqk6KxZEqcMd80ci3WBEDSypQwUwqF+Wz373Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn69hPZDmzF2R7mLcMZFVIO9gowx2wKB7i0XJROaxts=;
 b=Vu6B/2NfTCBxX9J3KPnEedFmtD2esadzZQr2amuZvBrj/TMmOgHCWqAVqFdTdT9dJ3Y/PC2d3Dcea+qT1zngeCcyF2NB55aZueXS5gwMK4mBKt04sXyUKIsMSz879nvqrWBZHCwbIfcR1NCmU6Bmu9ebNU9bsjXswliOfm9F7qW5J7ubHMEwnfy4pltMxYjEt8mG6cKErhcsREUxaZN0bSwBUvaNn9lK/4LmQ2gfBDW2UXr8fOk5Imefgf0LfILQmqY29CBzOchQDe9af8zXOZtb94JEY8jXGQD5LNCcaoW+iqwx0Mx3ZtZh/Un/vs4U3yr0vJ8yd/FI5m1J2pfTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn69hPZDmzF2R7mLcMZFVIO9gowx2wKB7i0XJROaxts=;
 b=JIxvqIl3LRVGZIHWAf+hb5ktZkDOjnIalq25UeMEJI+k0vqhhbRVcRTETbzXSJNAoqN4eOVWf1hDlzX20ibqcJFTaC0HG960I8rkOkhlcBx1FNy0MxZ+Dy2WIBwBuammkyQxI9NeInMv5Xv1Rf/eKuvOWIDOFKQVejKU8Smy4u8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:56:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:56:24 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 2/4] maple_tree: Update mtree_alloc_rrange() and mtree_alloc_range() testing
Date:   Fri, 21 Apr 2023 09:55:57 -0400
Message-Id: <20230421135559.2163923-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
References: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1f46a2-448c-4e7b-bf7c-08db427031b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDtI5XRIu29BomPVUwa14ZP84DPS4N+XPsC2EFtXXABc9y5QYtxR8AOEqbZY+yQDnk3a80rJ9xuK625Nt77NTp6SWbyJF2YeifqXiewgk3ys/XwoWMhseZFuLGFNglliHqDNdtk4oj87nB6uxfk66ovo/RLO6DCrE6W6dAc+s15uysz7R4Qc6c8JRoG88B3g0w/qBK/Kpi2tU0QmpQCTa3f8mSFGskqf16YjIb88vNre56lkviV5WUlGpmPQiYhIzOXv9zAtG7G1mllmdWNZTlrckVOnMBjadqhzVwswMU/IOeDhnvBnSM+46W2e4ywbpQ8e+9e9/PBg3NFnOja/LyxBEyB/TLZWCsb5Tg4q37oBvsnlqikYt36/mx44OzJb36cKJKU/pB5s87VQA3WWkjRCWaJ2A7rKvjAnTvs3yxc3AxuYkIpetfTSo/zOWRKj/ZIwUFUIGrogI4ut9ofa3oMIlEEyDgEtDoEiGorHmMEvFMR2RnXUHTASG1pA9SIVrY8oRZxaU0HBSoX+JPenv2js5o74jYdxFAavRVK3DIM8Gdkmbx8+ZE3U3f+EInVm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(316002)(15650500001)(2906002)(5660300002)(186003)(107886003)(86362001)(1076003)(6506007)(26005)(6512007)(36756003)(83380400001)(2616005)(54906003)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eo1dhnIB/FUlwrOsoXsyATgPv818NkFPcwAN+eGqBQMw28HnKWW7o9U/p8mI?=
 =?us-ascii?Q?Dtxc/neAiAlSom/sfjz49xaxChWUlrrtIISMcBLkv4B1rrwGTuyq50nCoR/A?=
 =?us-ascii?Q?qB1jxC2+Y+dveBL/C1wMy024MSq9orAuWQLht2E9r9uZLWGiKd0Xmbfffk24?=
 =?us-ascii?Q?ktkRCZOHry4pauIl79tP8LHDgP8n4hmpuJ7RfP4b8B1TegVOYTp5fJqKpVkQ?=
 =?us-ascii?Q?Nv0YJO+BzWMI96fJptOv4VInW/o/7xVDo91FznzGzs/Tw6IfJaGru3PJaUo7?=
 =?us-ascii?Q?UyGLoBCOPL6cJGndoH54Ff0dBOsVht5QvyzyVDUFumUK2UGnhWAzPATT86/2?=
 =?us-ascii?Q?/iq2H6ta4YNvF0QGXk/sjD4SFjzPE1IsjMsZu6e3sJdDx1yX8qjvny1ZidAI?=
 =?us-ascii?Q?HJHR8yvzYQmNR6sMveGe1Uh6VhzY4T7VtO+HPJrqwBT8JhaxUJZkSpLb9Uq0?=
 =?us-ascii?Q?seFsgNiOGA0EWO0a/XlUct+5v13tS0ognw6OEjjsCsGlZdN3ySbrOyQiPB+2?=
 =?us-ascii?Q?NxakkSydwcUUsluhzdWR3WUJtHza9P2WwLXMzF3/iiUtm4uamZ2Axh/06u0f?=
 =?us-ascii?Q?YpXC501kYT+vSu2uj/AozrvyzeCN2iE3vzqJgOnMoDAfOHyxO6XPToHCSrwQ?=
 =?us-ascii?Q?d+OGgduHhjwzKK4k7a0TWjjC0MLmB78JFOEcgkCpasyFeztEXJK15wLDHwlT?=
 =?us-ascii?Q?r8qEG5Cz5WFG0x12BZVRNXef/YCHNMU+zx8tr9kYPvgd8V0N5Qw+dtMABT/O?=
 =?us-ascii?Q?HMfcas8P6Bysyxdeg9Ijg+As/ctbQqMBJAPh7f6eknrfuxvLsNt4Evxd0AKl?=
 =?us-ascii?Q?dkM+g/iF0Ia5J0yGz8PRqaBoNOyWyvEAFBepdEDwDQvyYSCCeg7da9KM8NxI?=
 =?us-ascii?Q?GtXD4XJSOgCke3QQSiGt4Hqzf+j4nMQ6Gk6Aug6GaPom2eRtlBDvqsP+YV40?=
 =?us-ascii?Q?wb+JtqSbHVi5f8If9qandij00njWSR39wol0TUC0VJ2qKo/OgJ5HNe2flLd/?=
 =?us-ascii?Q?S/bj31DiX/R0uYfjvz8IviCyhUoJl7UGyBmLw5UW+66RP/6JUXj2lHPsaVcH?=
 =?us-ascii?Q?hGWwSrDQARaYCp6j9lb8srLf5D6Bw7MFgkVNgXG5QbzbFhXA4PPqNq7HwgKy?=
 =?us-ascii?Q?o8U0a4++C7ZDnO5f8ptXtlUDwBRo06SsOf9WQX5QVWaE+ldGwYLFajX5dn1f?=
 =?us-ascii?Q?c+1rlU032Nh1hUwmuaFOUxvcc6yKuDJJylxv4Zo0JeY9E2UELAmDWNhVCQxd?=
 =?us-ascii?Q?o3Me2VelV0mzMXW0ZHRYLwUYLMFVSGt6J5f7MHxm5wO6BtjVLHolSLNWtqFp?=
 =?us-ascii?Q?3VrjDciBU9IPoJI7GkWIlZP1NW6iD2tWTGmnimBtAaU0ni79er+3qiOWK96E?=
 =?us-ascii?Q?J4/jkfEzr+5Sv0HyLM9ajtjwZp1MOISRfmLwuN6C+tHM0HJZye44TCK8QgPN?=
 =?us-ascii?Q?Ujtk7B5e3DoXQGhkqm3TmcQc+QmPNG0Wv+2Be7pOekJqmuAR1Yg6XOpAo4S1?=
 =?us-ascii?Q?w1dCJELZf/DGLYa1/j1B+hsVyfxyYsewzzmpqETOJF6IyRawCcl/wh1378+o?=
 =?us-ascii?Q?FK43WLSpj3q0zB6MW/OdfUh4WdY/9Brcvl9BJx8d3IdcTGRxOg1MJlwU9jS/?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oCzfD3rLTHMtpn4oKlVF1+jDdh4Y5yHtHIoqjIXh+7yMZ3ZU8wjGMAJqAGTu?=
 =?us-ascii?Q?3yh251hhThnJC+ZLG/Sx+eZlc21t3r2ZfgDP3a6MNXt/nHSu6HImAkGRNGX2?=
 =?us-ascii?Q?9l2gN+K455OsOZyAbi2YNOt6ZXQLTEyFXgJAUE5va+F459z4JtM/bBSnyYa7?=
 =?us-ascii?Q?ENsifQ7iHUrw2uVpllQB4udLlI6khgjjeczHQbXcpa9XSxwxx0FnDYFgO0VF?=
 =?us-ascii?Q?133zMCXSySat4HbpScS24NpFeENIRJanlqJvv9F3kJnrp068HkymV+bzkijM?=
 =?us-ascii?Q?wTeea75gucxoqXh8ay64HyN+7Z5ft0xisnWhP/ZXeak/ZE+dLmi0fLDAZWtB?=
 =?us-ascii?Q?Yj7I/sgSBJN7KvSn5sgNliGURud8C+9p4u3TtI31Se9M2cFNmTRRw2OTbq7u?=
 =?us-ascii?Q?MFUVeYlimd+T0NfJ2Wu2OjcAB9yfMdu0nzZhMqAcnoK+YfhGl73k/9KQdzi3?=
 =?us-ascii?Q?ztI/VKqul6sb5dYXheMUIUYsOT4OjAwpaZGAJ6mP51+THEHcxztkkDi1Q2L/?=
 =?us-ascii?Q?OgWfrXmSI7U9ak/jXIQnon6BSbwL3fvOkmLdScvAlj1+NYoGSJU6RhMc46nF?=
 =?us-ascii?Q?FlIYDMd0hNjrpcZtzsvNKY1cIys6uGTuYODLabRmnkmMCmRhGMZiJuT6mecM?=
 =?us-ascii?Q?5ADgxwYc/AzK4DAYxMj6/2u54F/A6sQVQZbdugn9/ax/nGzbCEZ6t25M8biv?=
 =?us-ascii?Q?bPsSGqCWgdjUZYn0mpqewfHYfjknnzDt2PYp6czT++bUKZKe1s9KNE2ocwGl?=
 =?us-ascii?Q?UMxGQeCM7sBL8sm3GdtQs7r82/wmw15waf5D+bMPoYeeNDsGHTfuFNqC4gAC?=
 =?us-ascii?Q?VCHN675/ZCxZGcnp4tNLlgvWk1u05TAOPGexoJNad3yL561/LP/B3uWkjK0N?=
 =?us-ascii?Q?qA0GrlLDxLpG1za86VWUA56+zS/DOLLPs+zhKnr1Jkj5bovY+jdv6vHHtWth?=
 =?us-ascii?Q?m4kvGuOUffknoJjWHcDgtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1f46a2-448c-4e7b-bf7c-08db427031b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:56:24.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+7t1I/X5GdLDY0OwZXJR+2lNHro0xkyv/2VXg6av9XiTke3kH8ABc6Ngxz+AZVmUR/80UZNk4heW6isWqofcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210121
X-Proofpoint-GUID: aTtSmy5RWcPk7whHs5ncTDst9Eehnxrk
X-Proofpoint-ORIG-GUID: aTtSmy5RWcPk7whHs5ncTDst9Eehnxrk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous changes to the gap searching made this testing fail.
Unfortunately, there was not a safe update order, so fix the testing
now.

Fixes: e15e06a83923 ("lib/test_maple_tree: add testing for maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9f..4d85d04b26f8d 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -102,7 +102,7 @@ static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -680,7 +680,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -692,14 +692,14 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x7F36D510A << 12,    /* Max */
+		0x7F36D5109 << 12,    /* Max */
 		0x4000,         /* Size */
 		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
 		0,              /* Return value success. */
 
 		/* Ascend test. */
 		0x0,
-		34148798629 << 12,
+		34148798628 << 12,
 		19 << 12,
 		34148797418 << 12,
 		0x0,
@@ -711,6 +711,12 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0x0,
 		-EBUSY,
 
+		/* Single space test. */
+		34148798725 << 12,
+		34148798725 << 12,
+		1 << 12,
+		34148798725 << 12,
+		0,
 	};
 
 	int i, range_count = ARRAY_SIZE(range);
@@ -759,9 +765,9 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	mas_unlock(&mas);
 	for (i = 0; i < req_range_count; i += 5) {
 #if DEBUG_REV_RANGE
-		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
-				req_range[i] >> 12,
-				(req_range[i + 1] >> 12) - 1,
+		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
+				i, req_range[i] >> 12,
+				(req_range[i + 1] >> 12),
 				req_range[i+2] >> 12,
 				req_range[i+3] >> 12);
 #endif
@@ -880,6 +886,13 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 		4503599618982063UL << 12,  /* Size */
 		34359052178 << 12,  /* Expected location */
 		-EBUSY,             /* Return failure. */
+
+		/* Test a single entry */
+		34148798648 << 12,		/* Min */
+		34148798648 << 12,		/* Max */
+		4096,			/* Size of 1 */
+		34148798648 << 12,	/* Location is the same as min/max */
+		0,			/* Success */
 	};
 	int i, range_count = ARRAY_SIZE(range);
 	int req_range_count = ARRAY_SIZE(req_range);
-- 
2.39.2

