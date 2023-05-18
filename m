Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670870889A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjERTuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjERTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:50:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC7E67
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:50:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDTi018335;
        Thu, 18 May 2023 14:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=s3ex6HS9UhbpN+9ia8BU0WmPJxpM6tKnuxn0TPH+HDw=;
 b=ZMFuZTSnU6tJKATAIHyu7csPrZbJUm4ahaunzio6NrMuPl2P1aOy9+JqMjsC8ZN9pROA
 D98c+C0Axy86si60/iVucpe9vv3T/4cnkLPOAIXOFK0H5O4XuIiM0sSqVXgMy8498/Wd
 gZqBn+zYxm/w8bF0fDnjAkwW9L+qhm5PStYQdm1P/0GlCUwtg0TKvQVkQID79/rsj8JD
 VnLqQE5GIVXOlKDGpcw/7WImuVbHM319LEYRuDwijycNBSHoWUotcQ3TxryySflInJBy
 zRnLFUvFEobV5OHqLrWsHiAhZ2i8ZWwAXO7mq6PuK5J/d6lovoBksZmLUkanJzrD0yOv jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IERmLc036399;
        Thu, 18 May 2023 14:56:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w40g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYQItWPl6O0zmatgHVYRaKtzF+uhmAVqn+uIaNkVR6joM2aR51oWOrcvEP+mJulI//bOBcQ3iEjUP6UmcDGFtLogT1tQXShnWqRAwQWTirNpqZBBYWHgJ4Qzwl3Ck9E3Wnt2D+Xpv3qac/n3BQpfsViTULbFm+g8BSjSas3xtcy6iyeLws25eV4FoFt1ivzbrPQGmGOpwqA9AwVvj5XDsICRsmnNjORpqh697v6x1R5TZX2B3ymjPtFfExex3FGKXqsM+SiAnG4ZxMV6oq/5qz4JYE2Yjf5KWy97j0LN3TQdKn2hzmUiV1LKy+d3ry4PK24CnIBZAeNGtMlLgkV1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3ex6HS9UhbpN+9ia8BU0WmPJxpM6tKnuxn0TPH+HDw=;
 b=XiH3ntTychzLzLOo8ytOF/7RoIx7fw1AVwyaEmOmovOWgPe/NLdgh3k7/MgDb4g4QiQR88GvpOKdgUN0dmd1zMWPNQ6Tc8wKlAXzrcJQg+/DPTyvIoYP74lf3sogXPrDhhWYPJkJYw/uHTMyJqbSctvpXIgwUyBe0+oNzRWLxvP3+4po06w6pN9PVCI8F2VQkue5oYbPkt7uXIcrEIhb5kzFTM1oToSYhNlDJTZiIT7NprDAz2TAdpVwD23ze30IaR+2qLoYGabXclUSkBZaLrs4ceI2Y+rezU46hornCLHUtZqYfgf0OtVXMkxqHOLcTLM5wcXymYhaXk3Q+h/Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3ex6HS9UhbpN+9ia8BU0WmPJxpM6tKnuxn0TPH+HDw=;
 b=lGxiMc7rhwHfm87SvpaclvaoBrMJHSm9370t3mfpfVLteBBumoZ223UVMoMqPFZspRaOEeHp5Tc27+Dmz0Y2NXyNdDit2gTy0WeRipTA3kxWWehD0ithnlvubnWpcWPiOn19oRDqtHt8kZbAwpocnUrXzWup05ljBpx2sHgidaw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 25/35] maple_tree: Revise limit checks in mas_empty_area{_rev}()
Date:   Thu, 18 May 2023 10:55:34 -0400
Message-Id: <20230518145544.1722059-26-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e307035e-966e-4754-5a73-08db57b01c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKnU9p+paBAiAAlbECTG07aiRe3QDE9wHddbg1Zp8cvVcgRf4TNNBKtSt541NpXnONzILjwX4HHkT0JJxD+fqz5zRXU+A+0ALNVPeSCmr3JTd5rHsnBxvxwvJ5E0J2YBRha9ksUzAA4WdHJdk9YOQBIxC/aaIKQdZCV1zBM4KG0dat1ZM9DxlEvBSQLOP/dTZZ95KJGPXwdp347gaFNryjCvUGR5jmy4xYr7GVeVLM31nTSXUYatIa7s3jf4J0pU9ibfwMZWq1VPNDEbwW8sZSpdNlBdD6WtH+wgl5+fRn00+zWkFHy90G4OzSTyKps/LvWox0UKlmgupI+/adQ824AdnwlDoYcdbufCkwekTIt1XRM2pOfE1Z5m/VNxyKYLrm8eWmfcM/0M8VEcpT+aUmFbiR10zfU2fbA+iqghIEFzrxV85YYTUP+Ah1ikgJ+Ot5SbMTh7LQZvjptY13/ax0afxb5nnJ/K24/Og5ur8T9xIDUkhbZ358k1QpqicCaBPqFPls6qczRUxcLmP9L7BfGyyV8OM/ZeZPeBJ31lRj49ow5ulvf2PzKjW7ajkTO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JzbKU+kyj5wjSycZpdsepaWhksNbLpU+mn20Y00mBVAeOE73Yr2GfD2+F02z?=
 =?us-ascii?Q?XMfbbjRkH9P9Lgo7DMfDln/Wgq8n1CZILXLhps1POjAvLy312Dq41vpe9aJ8?=
 =?us-ascii?Q?xWRwSt5Sdn9tll2TWEqPmvRDidgWcjMTvgDFPB6tB/3kA/TIakMlnw3MBqTF?=
 =?us-ascii?Q?auD54WOfYfRZHhrvrRrOe3TI9B9pPsaw+UoTMVfPRn1JA6kRn1GDlDuEexRp?=
 =?us-ascii?Q?MTtjeppFrbH45sdJyAq0OK2lgTXVldfMq4qUH0CiRe+rvFSyH6D7KhZ3jkLg?=
 =?us-ascii?Q?pTUaXt7pZeJUE1YKIZn3xhI90JnWUXRMXJNpE7iGzCRpm0I1j7yNKhm1fI9f?=
 =?us-ascii?Q?ERo212iamJI1ZVJQ4s8bhjCkTfByZTMx+ADb6GlSy+Fm+tABEQxx4qXBX+Ap?=
 =?us-ascii?Q?C8WeANggXdw2lpsH9erO3+XCTr8vCV8UqVZfaQJrYy9byhPy/SwLsPU6y7VB?=
 =?us-ascii?Q?dt7t/pY9ndmEbIM9HfLVaK2nqHVb5tsuo06meR53kwv1MQcLsiEUMVkoshp4?=
 =?us-ascii?Q?sr1vYr9u4uXHx9ScRnbnmzOhR2+fwUt524eq6EaIgRttMkTuphfY6nNqgxWd?=
 =?us-ascii?Q?fJy/Sx2KRImE8sIhcnkmyw63Zo9jblrKRQr/MZTlOMUsYv0ZFPgEeWvwSAqr?=
 =?us-ascii?Q?zY7W2pxYCVzX4ztyjxWrWDTxa7zDIQYgWcyh3s6AnbY+jn4H1a8u6A6Hp9Og?=
 =?us-ascii?Q?YPPP0tU/9Pva1MWP2Q4BT8iOO1chwoIy5WQiazv7Xn0sWNDxr6mK3IqoWR9B?=
 =?us-ascii?Q?HershFKdv+6fqYMGxeYi3LOxW1e/LUQXQpWtEKKzg/ewXpKM7YN5alT253oh?=
 =?us-ascii?Q?r9avgshzFy9e66mfxwOCyFiNU6J/odJTTXkNEitjpIPp4NONOI2pQvJgUBsG?=
 =?us-ascii?Q?uoNGc5TXUdk0SyC4V0pVSdP/34IpRaWC756Lp//YmRFbeiET4WdnKY76sW7f?=
 =?us-ascii?Q?yvWer0WfjH3jNz2b06P4dkJddc9i7kjT5h8UcWkvbJUCAGG1+FcxFChhHXbK?=
 =?us-ascii?Q?USwlNeVKjAcRsyg2VfhCGzBfs6GArnJ+dm4s4s867MJoRlt1LUhKhqn7Jtvc?=
 =?us-ascii?Q?cWOjQgxaYBwoRLHf5ysszOBrQC9g1pgEFTdOxKqsyHpL1PiJu5+7t9yIld3E?=
 =?us-ascii?Q?qKIui8gcWhBP5/rm/lY3AG9+LPBIirY+Gt9ng31EEX+mPVJZ8FrwRnC71nM5?=
 =?us-ascii?Q?WVeyRVKWAzQJBGVi5h4MYVzCEbpI+uvQP868zVRdJ51O+c4n5HptAWqNAQ7Y?=
 =?us-ascii?Q?QE1kYES5XL3Ub00rcrxk1bCe9ad+e/b+Yf/1r87xS5AhtvXIoG0GAsEp07FL?=
 =?us-ascii?Q?VeEW5NP8en1XI9jikLnUlK6SUht0i1zNqzxE1gU0P4KV4xXnDJdNufg5sBH0?=
 =?us-ascii?Q?CFjgpIUPDcA3f2KdqiHcwLcqxOtGcpZ0UPHEauJJbRqNYdqL2bAbnCQPx95S?=
 =?us-ascii?Q?N3C8i/Anda2UnhdikFXSW39Y4vUntngwcp7lBHNnTs+zX1XMlbsdeMmdVKuy?=
 =?us-ascii?Q?DN041E2UttaKtU4LWk2SroiuGcmbWpZy1waQAS5lUdE0IMgvGMrXW8BNwvT7?=
 =?us-ascii?Q?QIhKGfmviCqCPLyImE24yFSBMzdOz479u81+twyMYYyMA6SLR0qvWuw8/Fon?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EamoNGCCnpcTm5WnU0AglvvkhksoaZDXkZ9KO3BN3oV6Vka9s4u5L2BiZMTp?=
 =?us-ascii?Q?/mVqlystBoTvXfhEsK0nQa1peSFHptp6p4oTmLXUdYpZZOSJV5tAI+EjthYx?=
 =?us-ascii?Q?wzwr59fhA75+9zddtfbVgLXyhdyFf2DYIvM+1ygZEm43mMz+qVSsqM8ck4Q0?=
 =?us-ascii?Q?tzzA0EJ+PD2Z62BrNHkXfA6g2asmVr+j6FrxRitNGcnrM3zUiXGuY+dooPYR?=
 =?us-ascii?Q?ggEU9nwuBaVFETa9hYetAluc4tscu40I1eSd5CT2Kt/BsXjnA1zu7/tfm/fh?=
 =?us-ascii?Q?uEZJhlnOZC9CYy4WULnpeDz1CBmUg7v6GPewGzqkNNWQoBGyOSSgjLbzLZr/?=
 =?us-ascii?Q?V4uXYLtiqCc/O8xf5TE6+CI8eCCsbnvBZEjB2uQHVLwXvnhW6tK7oIgpWjEF?=
 =?us-ascii?Q?OtEnbUEOQ+YFCs8udukeOiN1/PxiL/FxqFRIuXdBUmRvjzaN7V3YzrhWyaxu?=
 =?us-ascii?Q?IC+pdFKBUnkQ/FqQEOzQw4xNMsvbfMnGaN7uBnnxUGygbfsp01/uQ/djf/EM?=
 =?us-ascii?Q?6lbiqp2JdA9PCkKillxOqJ4Nf9LPCwHq7Kf/sLYwIl1UfWyn9EbEF2UMGSH1?=
 =?us-ascii?Q?UKohqjzqrOdGsTydutkOPQJDkqJL4O8e7gyVGyX1VbhESssfOkytzuY55yRt?=
 =?us-ascii?Q?O9ttXykfskFv2bgWgnUmnIB9HplELF6ePsQtYQPYPVIki8dw3mLYMGgQWa6I?=
 =?us-ascii?Q?d+9kaqmQnep84N0aZLgAUzj3rjHE/6RiBoKANTSQBAe8/WWIqS596lRHlRNg?=
 =?us-ascii?Q?kx9tUdDN9yN5zWzf8lJmxPA59njYrF/FzPr7cgaX8kuLlNBb7o2xhemIpMm8?=
 =?us-ascii?Q?pvPASoBgKdUd5Gczv4b4C+2YFzQoh4JOsNvi0KfjtuMkUwfL24+c6uXpqfeU?=
 =?us-ascii?Q?YM4HzW9AoKoN/6SdNfsPJP1n4gyiYaEQdr2mdDVrFDX+9GeyG4T163dDwJ2k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e307035e-966e-4754-5a73-08db57b01c68
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:50.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxPCoepSsoZO/Vt7JvHz2YX4gbYH0mtiHmS51Y1m24+2118+q8ZtENTxSDY7wwOMrbGA3sf2SYZ1RXkYtMQDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: t-7l36pYpSjGvibqjHlgkJZlPc8D6Qap
X-Proofpoint-ORIG-GUID: t-7l36pYpSjGvibqjHlgkJZlPc8D6Qap
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the maple tree is inclusive in range, ensure that a range of 1
(min = max) works for searching for a gap in either direction, and make
sure the size is at least 1 but not larger than the delta between min
and max.

This commit also updates the testing.  Unfortunately there isn't a way
to safely update the tests and code without a test failure.

Suggested-by: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      | 20 +++++++++++++-------
 lib/test_maple_tree.c | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 425ad922bb2d..580310741d89 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5282,7 +5282,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas))
@@ -5337,7 +5340,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas)) {
@@ -5373,7 +5379,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Trim the upper limit to the max. */
-	if (max <= mas->last)
+	if (max < mas->last)
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
@@ -6409,7 +6415,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, min);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
@@ -6429,7 +6435,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 retry:
 	mas.offset = 0;
 	mas.index = min;
-	mas.last = max - size;
+	mas.last = max - size + 1;
 	ret = mas_alloc(&mas, entry, size, startp);
 	if (mas_nomem(&mas, gfp))
 		goto retry;
@@ -6445,14 +6451,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, max - size + 1);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
+	if (min > max)
 		return -EINVAL;
 
 	if (max < size - 1)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 19b130c9ddde..f167d6ef8159 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -123,7 +123,7 @@ static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -701,7 +701,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -713,14 +713,14 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
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
@@ -732,6 +732,12 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
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
@@ -780,9 +786,9 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
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
@@ -798,6 +804,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 
 	mt_set_non_kernel(1);
 	mtree_erase(mt, 34148798727); /* create a deleted range. */
+	mtree_erase(mt, 34148798725);
 	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
 			34148798725, 0, mt);
 
@@ -901,6 +908,13 @@ static noinline void __init check_alloc_range(struct maple_tree *mt)
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

