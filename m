Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89136B756E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCMLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCMLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:11:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D937F3D;
        Mon, 13 Mar 2023 04:10:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNmDdC011721;
        Mon, 13 Mar 2023 11:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lIcb29IVQ0WmJBpSmHrLVYnR5uAVBvUoMqHimF8gMqk=;
 b=NRAenYvhy/JWM1YwOgFbotdoMGQtR9bT2mlwPkr5pPNDrekidcXdh7wztUYN5Jtxx2nD
 tAp1kD8xwJoobcmD5tHMpD/m1zAlbRnWflaGf4LKjre6iIN4BKJfOs0c38C3mcei1T67
 +dPnwkxv+2KL6VvOUG5WFjzTIwjLf4U3kAM74oyBHIyESy9sQzXXJ1UZoAny4eBfi26Y
 4Z0QVJSIOB/UsIPqWPPcZfYMZHQzll6O+W7EK6MowT8/xwdqz8IW8W8IJzIMCDszg2hA
 izJHstS1ZAy1HNmsMDeubU6qSyDRJs+erlqgSDe0xQW+6+jzGXBzxVHAxmqPyTgzzNaT Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3h7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DA39YD007583;
        Mon, 13 Mar 2023 11:10:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b8jtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A40fbWxEvFgvGAe7KQ+SRQ+0BfUI3DqgqxZjCAJgrnEFucAagKp6T4V1Lm5cn8T+kGM+n8RYjscwWYLztK5hyP6C0OFzSWVYp+g2UVt/2qVSnexnLCzOZ3weyekJIejaTfmDmHx1XBttE4K3I6Q0T2LtrX6m98M9bXytrRnBIsz0Dtoe4Ju+pGB3zTK2OgeR6yAGSsYssH8EC1Ric652UFW8O0KLsEWbo2bfxnLOQ20oaUWFvz64NOD9Di88xN9rseqcuSId062/AvPANWJrLcftHOM1dedAtGsqCu55EAlAE+yV8VhXUk9lyTkM3aba2bV9zGgXQVNAX8g7j1I4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIcb29IVQ0WmJBpSmHrLVYnR5uAVBvUoMqHimF8gMqk=;
 b=DFaLlz+zrfdwA+pzdPCln9jHhfZ8ZbeK60YbxGmlISSy7KGQVzBbtmPmK/BtvasUlMolDhhBMqUaiztD6JatmjfAhmtt4Jstzk40Fyh7PUY5/+AApLUPuVHH2FNe4ZNLAMA6FZkpSj3Pi3vz9j2602juHBQ0xCDfQ3kYcVcG2gy2x1KGxPxTcSOT1mxvJPYmTmYAHwgfnm/Mse2OtahrZvwfZwJuG9h7LU1Z3Xjq0uYeCUQ0NhLGoM6hywxqUpEzxE4toOGh5tg/fxW2QFLgBHc312KqqXFRKXI4jN/zQxkFgg5HBykSTX2P0jwGvWJD15s507nEt9ejNLk2EXAW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIcb29IVQ0WmJBpSmHrLVYnR5uAVBvUoMqHimF8gMqk=;
 b=r5mjM9RQo+KT9F4FnONnDuEzec5eY0D9m/7ydrhz1nltJBahaal0pv7qNPcpeJCdPjQR5byTSU2x6kqSWFQJsHR/f6jQkwRqH8drdYMeuRXR0GFoQKuhLX5f2haSIz4j5jR4Q3dTx38fOso4hSr4Kn4b9JvWQWVOQN/Hbx/rkCk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:43 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/9] scsi: scsi_debug: Change host list lock to a mutex
Date:   Mon, 13 Mar 2023 11:10:12 +0000
Message-Id: <20230313111019.1521680-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:805:66::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 08954994-0eb3-499a-55c6-08db23b39680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AslqcHWPk45G0sIGhdGhYJdfgzFK7fat+y9RvEl/H/nhMAdANgvBbKDNDGcG349YKBja6CP9YlhOqHeixpDjsqDfDls2OoFUAs3kmki2TzcvNo3EoXeexI4qM4s4QlEZy5I4bBoBYy5diE8CiK6Mwpj8eY1P6S95xmti8cAJBye+5NpHR2DB0pfASir8rqWUIPPG624Dh4R1Bm3ui6baDCgwZtxnNEBN/kvtoa/L/zap7s+a6hkzzABS1lEZyB5LztJUbGShniMBzqdBiXPoEjHjD6/n+Pi6o1cNzB0kYMO/n4ok6Jk9+fcz/IDDEyLFdai+mYtvBXujd6Kv6LmWM1IFE5T0m3NMasjUlFLIaYlO4s74EBZqA8Nir+QNsrq201WhGHlMWmJwAFEW2dfWma0VBPqi71lJ69nqj4Uf1EufIXrWK0jMrQIKgu3sR0Mm+tJCaJcujti00Y13QpcA/3O9soYIj78BwfTfZHKpsoIUV5AumMYdyA80iAQomDLxUhiBtxD0DGD+W+BVwZVF5OpFOo/9YTMQe+xaYh2010qGDALMldF7jRc4khwWoKvAWkadFgwivnTL/Wne7Yt1htRkQXHYwl0+NSWJr8GWPT1SFidD3/WELjhjm/T3eZ15lSFQp1e1NKl3m49C8834cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6dpIDE/DuVbUtcUXcqeuF4kVSQINGWB3PBzGN2naAqYESk/mIerW0XVk2U1?=
 =?us-ascii?Q?692xkc/YFgILIt8S3poLo6WmaKEUpI1E2Rmqnjsu+ni5k166NsXp288RBGx9?=
 =?us-ascii?Q?12xWg1NfbjR1/7tROo3w7NBmfSWhLb5MsctUm9/sB/a2uPG7QrznXPoAWezF?=
 =?us-ascii?Q?JFCXLIzWry/mqeaQ8FwIAA2OtncDmNh3HPb3beh1z3zB565MUs78f9dUWp0Z?=
 =?us-ascii?Q?UF5twIRfzBpORXYxFD9ypQUXxhrXDAvA2ZlooEWI3zOPrCXVX7ySRxahRG+9?=
 =?us-ascii?Q?5cnZEMoXeH3n/JKfBn08AD985GKHjUJqsSvcL7H1yl5Nl5qmLx/dKwFyQvhV?=
 =?us-ascii?Q?4OmMD1d+NTh0XkX+qsACvmFd6TrG3gWR2jOxajl6jLOGsVbgfwF4t9l2ncVN?=
 =?us-ascii?Q?BUwUoPDefhl9ucd9NccRXjMbJpmedcOY5aE5PY9nwSz08eil8lPMwXSpIkFf?=
 =?us-ascii?Q?xy46PifU384Y+oM506HEHQ1f/GmOLR+eG8DW+UxzFtK/8GolrBHlTQRE/DWP?=
 =?us-ascii?Q?pTso81IMZ8RuyBPhoHXSMxgnQPSjvukPTHdRGmgijGudVcafRLUV0DHq/MJi?=
 =?us-ascii?Q?wyG710duNjOIj4N8RaiDiL+iB7MFcnNntH8aKOOHutN37JCnIzMM+itLnI4Q?=
 =?us-ascii?Q?uNVtWvc0CJ2zym4MI0vzyuyck4M4qSwdyaU6IDfNGLuo8r8AxV8ukMDcUPxM?=
 =?us-ascii?Q?WlVXiYMFG/svBq2aF1pOZmTaOtvreItNB++01Ev/UBCWOPIZLkPaopLl5Hg7?=
 =?us-ascii?Q?x4OBS3p9fxjFgimVyl4OTnnbLe7xS/ydzwsL79XQsZnY9u1j62iYEO3Iwnkl?=
 =?us-ascii?Q?lGIM7qJs3sX6XN5Yh8sYpg2SAe3y9wg1Lzc4ttt1OZ4KXia5pIbWxJMJkMJA?=
 =?us-ascii?Q?WRfJpLeqi+ndXEOl5DlMALKXe3Z9GDPPzJaxKcG10tfW2c+MqaUrorjhBhaE?=
 =?us-ascii?Q?Fgtqeq72c19CEoTh0LcBLbp8D3xYC2fLnD8EwnfHyzAJ+Y/3DjZCTQi9KnXA?=
 =?us-ascii?Q?SQay3V6lalVD70Dyag7qBfgyieURi6/K4C7d7S/iRZ0Zndr9KQcV1+BfMbUP?=
 =?us-ascii?Q?0HFxQRDNMJCXiX3dcGq4Dji/WTFEWjBfnzJbBNwIfiDbKbYKK8pb96dNUB8Z?=
 =?us-ascii?Q?vThii06hmSdi6SG6jN9jcq181dEHIiqsSubnhbB+cguuHpEVhS+V3gQodj1s?=
 =?us-ascii?Q?bs3r8xmY3YIUVrqvEtZdzBXT+GsGTjRltXFpDdr84shdvSUInel6kllRxBCt?=
 =?us-ascii?Q?081CefplG3aJn7IsclUyY96co8RUSZfkY719Usw9Nhth5YkMKzYiUBLEv++x?=
 =?us-ascii?Q?xJ36p/Zan1+jD36C50NC8m/ZQvbvB6p1JuByFzN6b/u+63G1PK4y7X+IxGRI?=
 =?us-ascii?Q?kgoMy8TrvfRS7SDiubQEdaBeucPn3asg5whY9P+imyb4smnQsx2ssRju2TET?=
 =?us-ascii?Q?TkYTlzi03gTh59ifulPi8yJ8K0twzNXUvdCthYSOwZ7rvhQXI3YzLOx0Bw3W?=
 =?us-ascii?Q?uJNxCO4cicruoO3AfAsdJejmeCpxPSQXOEbv1AmoKLKZdvOT2RQkAyMkqYOO?=
 =?us-ascii?Q?GOhq300qdpxTwxjQ/QnNsxkY5cMOgfFDLGXNDTysli3RsbxaDvCKcRNLC4aB?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UuBiOW5O85OLkpeg/smGtVYgSov71MJZPcid46slqhfgQlnHda3R1f42PpkwWvU9jNvL1oEgQB0Fwl5wA0KrJSrAmXYXLJgOSeNTto6tOnPPqSZOw/qr7e3czBGVMZ3DcURrhpT8Y3NbLWjn5WMxph/yPM9XwtJ5+YvXnK7YEnEnKy0TCPDFfU2aYgUwmed0HMd1gWKMbLIu6Liz+K1oHNEmVH4smNZmM132ZeYCanVnTjo4d9bE5vextBmpdDipAkeKMjoiBf30yMwmdmKA0U1F7VnvQ6I2NEin/6Y5CVgBlJ1gV4uDpOw+FqbYgXwhaWNvxeKhP0AyUzZpk1A7CaEKvv2sMoqgIjsv+9pRG63zEwN6cA7/KVDuCmuRXI/Mkc8+Lgd6Ezglipx6VY6XOHaDfdwcCyv/o/f1IRUYFBTMAZb3mu7pyCe4PU69AZt2AvE7qDUfktcWof9wspQ0dLcco2G9gE8hjMSl58BHBu5lHERpqyeGkOPBHjuE/PN6kbVj0t2SQPlWr/uLSxNqgbqt8r2auA0PSreNlOFrHsXA7HN/hxvE6zv5Dnj4bTPxmb+ixKHnoU91aw8hg88Jj4t/WmxM1E+S+mnsSK8oIUyLxZO99QAgaGjJpKEzP9VHtyoZ09lfS383WikpAogmSyBK4u3qCA4uWR4yZ+pMcx4blfm+1aOrtoxwlt+ii03egH+bgFp2dCyF+LEvoYRU7vQ2q2546f52fnJHNwTzliqewsaIM60TMcKC0AcumHYV/ipnpaNqvs3qGTKXLkmJYAa8GbatBcbMihEVXSvGuzEZcfuH5gvlpNx6bbvHoMQmAXFdXfJs/TrOFrwqKgbeyNqevf4A7D420Ify2Eul/G40xqUWO2XiBT16bSLWnk3E7zMVHS2t6cASONMkr4knN3z6vfVHnPXm8ldPdq1kGTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08954994-0eb3-499a-55c6-08db23b39680
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:43.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeeM7PFV4YBgGriwseon3j0HkZldyUxAtFl9w/ffqfDTEr0usgll0g2hwvAfdjBnluIiEv0TBFXLCkKoVMW2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-GUID: VEoyahrgcChEDwkojuDX0vOJIkVeE06f
X-Proofpoint-ORIG-GUID: VEoyahrgcChEDwkojuDX0vOJIkVeE06f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host list lock, sdebug_host_list_lock, is a spinlock. We would only
lock in non-atomic context in this driver, so use a mutex instead, which
is friendlier if we need to schedule when iterating.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6e6eca694bb5..711aff1b4258 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -816,7 +816,7 @@ static int sdebug_cylinders_per;	/* cylinders per surface */
 static int sdebug_sectors_per;		/* sectors per cylinder */
 
 static LIST_HEAD(sdebug_host_list);
-static DEFINE_SPINLOCK(sdebug_host_list_lock);
+static DEFINE_MUTEX(sdebug_host_list_mutex);
 
 static struct xarray per_store_arr;
 static struct xarray *per_store_ap = &per_store_arr;
@@ -908,7 +908,7 @@ static void sdebug_max_tgts_luns(void)
 	struct sdebug_host_info *sdbg_host;
 	struct Scsi_Host *hpnt;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		hpnt = sdbg_host->shost;
 		if ((hpnt->this_id >= 0) &&
@@ -919,7 +919,7 @@ static void sdebug_max_tgts_luns(void)
 		/* sdebug_max_luns; */
 		hpnt->max_lun = SCSI_W_LUN_REPORT_LUNS + 1;
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 enum sdeb_cmd_data {SDEB_IN_DATA = 0, SDEB_IN_CDB = 1};
@@ -1051,14 +1051,14 @@ static void all_config_cdb_len(void)
 	struct Scsi_Host *shost;
 	struct scsi_device *sdev;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		shost = sdbg_host->shost;
 		shost_for_each_device(sdev, shost) {
 			config_cdb_len(sdev);
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
@@ -5423,7 +5423,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 	++num_host_resets;
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device, "%s\n", __func__);
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		list_for_each_entry(devip, &sdbg_host->dev_info_list,
 				    dev_list) {
@@ -5431,7 +5431,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 			++k;
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 	stop_all_queued();
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device,
@@ -6337,13 +6337,13 @@ static ssize_t lun_format_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
 					set_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -6373,7 +6373,7 @@ static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list,
 					    host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list,
@@ -6382,7 +6382,7 @@ static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,
 						dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -6489,7 +6489,7 @@ static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list,
 					    host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list,
@@ -6498,7 +6498,7 @@ static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
 						dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -7258,9 +7258,9 @@ static int sdebug_add_host_helper(int per_host_idx)
 			goto clean;
 	}
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_add_tail(&sdbg_host->host_list, &sdebug_host_list);
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 
 	sdbg_host->dev.bus = &pseudo_lld_bus;
 	sdbg_host->dev.parent = pseudo_primary;
@@ -7269,9 +7269,9 @@ static int sdebug_add_host_helper(int per_host_idx)
 
 	error = device_register(&sdbg_host->dev);
 	if (error) {
-		spin_lock(&sdebug_host_list_lock);
+		mutex_lock(&sdebug_host_list_mutex);
 		list_del(&sdbg_host->host_list);
-		spin_unlock(&sdebug_host_list_lock);
+		mutex_unlock(&sdebug_host_list_mutex);
 		goto clean;
 	}
 
@@ -7311,7 +7311,7 @@ static void sdebug_do_remove_host(bool the_end)
 	struct sdebug_host_info *sdbg_host = NULL;
 	struct sdebug_host_info *sdbg_host2;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	if (!list_empty(&sdebug_host_list)) {
 		sdbg_host = list_entry(sdebug_host_list.prev,
 				       struct sdebug_host_info, host_list);
@@ -7336,7 +7336,7 @@ static void sdebug_do_remove_host(bool the_end)
 	}
 	if (sdbg_host)
 		list_del(&sdbg_host->host_list);
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 
 	if (!sdbg_host)
 		return;
-- 
2.35.3

