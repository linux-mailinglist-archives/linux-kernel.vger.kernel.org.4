Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A46B75AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCMLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCMLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:15:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D4E388;
        Mon, 13 Mar 2023 04:14:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMgpIi030831;
        Mon, 13 Mar 2023 11:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qBek8aEeVGcHmQdGCFkM3zwMwz52I7bLMI+rszc1Txg=;
 b=J5iGl7I+WC7qU0sSOcPowrHtdEcjyJKyB7AJvgtlAdtiSQWY9cC0LtAeNP2+I2UkJ3HQ
 nu17vihQX9MeeNUe0QWSv5TrtdYqO3qK3yR957NEWQoMVJw6hRacuWT3mclVUkAsHnZo
 NYn9zKk5icarolJg0nBbibAmladbWnCwnP0kinYsDerntZREGWRWwFrlP2H1qy4JYBkv
 ubI6YTky/JHRtCcIbm08SI3DNf/0R12drYrET7a1p6u0XBxSv0yFe0LK0xw6rpYbSXyq
 wbZi1R4ENTQ0w7Kp2lz2d9kx5FKoqs+X6j2qGumDIWHCgofwmhzflnNILV4cOS9mAPmS Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g81bkrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DB0QKl002455;
        Mon, 13 Mar 2023 11:10:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0kb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQGvnCl6SzQyMslz+hg+r6nZkqQbbkkdMKoyrJSPZe0CGzwTvCzqkosix5UQL17FRvdex/UTy3k4p1VYHBQ0z8RPrQCpUnd7/v/FCucAMxQUc40wJVTkueDV91hUGxa7H0q0xjF0k3dvyTsXF8i3sjeyQfCBngnj648PcIdhrsr5xu8TTOVF0Zn+SoeW/SiEpmUzzxodCbvewpvdSHtHVOOG6zqbPAj3CoX7MmvPpnWqo0A99GLOGdcyLnw0HNx9JmBE1KSmZ3V9ACnnQIk1ho+D+ritaEkqQyI1DKa4ypzvDOW8W+uQBP2rH29lZcGD5vjWACx4khUGb2LZ5GrBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBek8aEeVGcHmQdGCFkM3zwMwz52I7bLMI+rszc1Txg=;
 b=REwDZxxDKq1QCu+2mSC+cZy7YS4nfQ4TUfndD1rTnOI+ghWwCjWwuT17nCAmy+PUIy+VMOcFvnfXV43dhmFw+4NGcl53ShTMorUtiDJHeAqrH6HnaJ0OwTltKnszzjfYpIieGuGcid+uMXj1vIuO8NmmFDDDVujE3a4hgr/qngd7j4l6sEGTO4JKYF609mDokKe54hCNGEQqlTKvrYCqAcmZ4d3MvWAZ1PDoyq4dM96PTRGn1aMSP/RSHJmnOnKXzaFuCDiwPV8r+059oTC9ghKTdKz9evF30C31w6NgWflMaCXuaeJwe+AgenPomDxOzm2lZr/bC7r3YdWSKyJP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBek8aEeVGcHmQdGCFkM3zwMwz52I7bLMI+rszc1Txg=;
 b=IDR9hyCtXO31O7IrIzwNSbpLBKvFvcviOFTlmQnJQj0ktPRo29PtfWsiXZjgSBRhIWKelKKfd7suFWgLDqTmY+VgQw5qziODP6t98SaXt224ZrZZIiQy8zj4ppo+OHCBN+/yotibNFJHbwfW949+uYbYQsQw5Neoz+EbleLaLro=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:45 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/9] scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
Date:   Mon, 13 Mar 2023 11:10:13 +0000
Message-Id: <20230313111019.1521680-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: af2722a2-3ce0-473a-533e-08db23b397a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AciIa62oCgYTFaKF5StbCupflN2I88Nq+Q/2ySYtOGPLB/XqZ9VPfBLmRJqdhnfAVLInC7zE/Ox8+yuZeY0nuzt10azsmjcS2cyfs2kk4SJENrcSmiLtb9LJesgGOSxIOnPcq8R8KHTm2S+HU09LfiHlNl6D+QQVtUWYtULYP/rTPKYtIXeoD5AlXdYcPxeI7EGN0b8GnBZVK8mhGq6zYE+KqZVoD1EC0fQhcKQTls/KoN+Q72wJ9dyEwXCjYob8mTVlMukzxHoexDULIwV4aG9F/LkbvBA5Gjfu6HUWSI6K31M6X8eGOb2J0G9Tj2Bya9uzVDpIxhVh+4uAerPCmlrkLc4V40L6DnNRaU8yKFCZrEsJ9B8TJi7FOU2iIpN1VeCeuPWEFem0achiA0BWiVVPTcYLYR7HKpwmQPrAh89aFrd3fhbvF2CkyFrG6xvbv34E60EdcQUK4NlrUisdr+hsOYsSbrPZAH7rTK/bsNQ5vQg9YBkxcQzb9M0auLCyh3NZkjnqNVbw19F3NPb3m4/7tzbSoixwbykmew6si6xeQj4gCM96FuCaiaNZk/ZiQn5tB1EVpt08NcYA/0WHrv5r2HSCjgte96wPqryspuihbHe8CiEPW1TPMPPIo4aiSRjBhVyDjqnLRD20VmVMtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+KHhzbAT//2QzghGIIhYH5PbEE/J61N9DeJR1C+dxWiTFvPWhoB3JHrAibSr?=
 =?us-ascii?Q?c9ndk2I7GqqBwgNsvpHxY9/3siRRB5JphjKA4l/elPaNBCAynWHku+kfVf4T?=
 =?us-ascii?Q?DerOKRRRCw4sTZkh1pBzxGuMknk1nUcq/xqk+Q3RMYW5uEv0whgPRo2cDA3C?=
 =?us-ascii?Q?Ebs/QeHu8+PMz1BL+n54eaf/obB4nwRJzrv3Ah8iXKHchlUzd6Iqj0KMrbmo?=
 =?us-ascii?Q?Mit78p2yxEbe2bDrAYhrfLcogO0yoDzK/6dIlOpWB+QaPd67SzLxU3YloAD0?=
 =?us-ascii?Q?Z1au+Pva2PA06NsIUp1FXi9+IvmEjl5k4tQ9IjSLN7TAlIpKFK5J6HK9dg22?=
 =?us-ascii?Q?yLRERVJCmMLdFUwOSSVn5FtFj/ndTX/eLSiTobtxpFcWl8bPtb8T/oblSSSk?=
 =?us-ascii?Q?IqDnJ1HPK6t9e/CKUm+yT01zKp4y+LKcHtlfI6YdE0CR/owJUWSPrqIWwHtJ?=
 =?us-ascii?Q?MgVk4fkRenuMbiGLd2RunTnnTO7nG7RUcg2RrkPSLB12+N5nuuFRDOor68nJ?=
 =?us-ascii?Q?qcSTa5vzr+vHQhx6OGJWkbNZrpKWv494DhL9RB0mBGgOCnNucGWD5cetL0sT?=
 =?us-ascii?Q?CAvJ34AIZ90RI8oQflpKtqV//MXV46kgMKwo22hsDVwkqrbWcAF/tJV1ov64?=
 =?us-ascii?Q?DHmH15ImEYYh9T2Ysa5meaHipHUt+cWw0bsvegLHZ4Vc7MjlozRLFRD9Xpne?=
 =?us-ascii?Q?AP6Whr6H8sXEJfRa1SimWCbfJpZplX4b/Px8bDqtRrSYuD5VY7jzTgc/lViw?=
 =?us-ascii?Q?DRg5T9KKjsftU88mz759rB4VIMvn+KnKJeMDiBMU4yiZeeeDfD6o+E2VF6k3?=
 =?us-ascii?Q?eu+wONHPBZ3fCtFm2jGLe+kqw9ZBM+wu/NDo0tswwBZIqJSdr/DHz5U73qX5?=
 =?us-ascii?Q?HHNPAlOp5tRAFtWTfNSP6Kb2fAhu3N1kwjJF0E97jfatLKjFdCQkqrNKNGBH?=
 =?us-ascii?Q?MGuQknZlmdYhZuz9wPbWH0wiwhXO/pl9z47iqE+ngbUyIh2iZGdkWF/SwXqx?=
 =?us-ascii?Q?5G7MtYwLDBtZSgcH1yuJ3XW7UThV/2Ck46EfpnHiFyOk1sjPRbAFZO1jWRkG?=
 =?us-ascii?Q?DIEUhEiOGgRVGT6aMwJrb0LaVOYDvF0WvHLdVzb4MW+39hWd31IxnN3eDyTl?=
 =?us-ascii?Q?yMzYrctWUVGUN+uGvhVicibXqNqC6oLnap5dWi23Dc4+KB7+r7QBTUDuxTIw?=
 =?us-ascii?Q?xWR/8Ss+B6GkFPO5Selmw9RFkryHbGhEFzHzAG/uz2R8sYpSmCuN6IbyMhMn?=
 =?us-ascii?Q?/n2zTh6xYYFsM6OaQ96+d0v6N7AIYLWhy/BuVjqT7YyMUg7Aefxn5gbnhzLE?=
 =?us-ascii?Q?E/C0fVMLlRqgIRzzfrMwfC5LV9Pu7O4ym37HbcB5yKqcvZjEeGjYKf3t70J5?=
 =?us-ascii?Q?ldtghOVXq3W9r6twyAzRlYV+H079T+8vfJuDDKG4mG/oXICPe/bJOAI2+1aA?=
 =?us-ascii?Q?5rbl5FfLoemGXQL0zcTQa3C1o5Brfp1FDu3nl64zmoB6biqhq6DATRtcDiXk?=
 =?us-ascii?Q?yZFaO9d538foBulp3wFv1ZVws95iemRL2Xbb/DpMmClBrNlCwe6d/joyx4g6?=
 =?us-ascii?Q?hF2w39WDvopnigmGlrDLC0Y6QZserc+0jftBT2qCnJb+8EEeTxSnf+s6F4RL?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N4zTwvaGDF9i974PTTMort6fwV/AFs6XN0H1KU40r2HfJFW0j88HACqf9jfuJD/Bpb0rQwv4Md96lP2PbpHRv0hPwNp6oIbRfP4DQLZJrbRRhBTHz9/5gD3Q5+tPpYPAlxGK6Y4OL5ayGK+QpvU3nlAqU+oeV3TLfWlR7YVKxbKMZQYulMNGrI+fCycoE9dRBo3e9Ytp/9r/96L8q5++dBGg/+Dgxtj9sdidEKKdTbHhNREErhOqsxRGVtoX0VfS0iEC9+lg26YLSAnTqzsXAtuR0emy5DhsMKxH4hVDX2dCYjPtwoKSt1xJq73AXeZfd4io+mJNiT8HmyrvECn1RBK+0rjV8L5+QHA5+yTlSPz/IH7XJ1J+ZrHV937O7w1DWzsBsaAEeAVOZ1xBqpVEQ50jQgmludTgzr/n2sitLWoPMKBZKyKIDv0yTmQqqXx34dY2QzqlqjBbHNfyr7taFrGG0BQLrb5I+Nrn1XFTQzjOT2D+2zv4XreJ00En5pElym3/M/vHdYuKJj8soAdORuMY6wyyAclMqS2ahFMjp0rMUHWkz12gLc/k2hhaVTx1JRoSTk6cKzhiNP93N8W0+eLb1qRdBKVNemr3jsmlMK6VARHyqs0jRI7oDIGM4HFBV1qCrcYurarBHPIWqp7DDP/Am9lTNc3olqUpi/oDpWKe6T2B1175ioLMqVFd6RU2u+KlohDQ/flyCUUKKI9do2eL3q0+YNI2O6KoCigoWrhtob+yAC8BV23qsXd5IrTuxa/2AlJZ1oNpO0SllHLlV9FXwXIspVUT7ZzQRvgtLwvgmEJxRYt4iMt/TzkBly3+0Ez49tV0/vNxi+OPXtcABQTz9XE77iFbN4K5aTw9AqjTjYDmtEsm4rWYbhd/hVjCb/HWOB3SB0uLgShJKoZNYzcmLM/ePCWKWAUQMsJOBxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2722a2-3ce0-473a-533e-08db23b397a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:45.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xICXIoCrVnqoDqZVzWFYNg636pH/iV3iSY0aSpeLpyBeyMUHnlap5DBzbkEMKkMrj6Mib6lYJuSNW/Pv05Rofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-ORIG-GUID: qzdzWcooA2w117xqfscZAqXtFCbtvx9Z
X-Proofpoint-GUID: qzdzWcooA2w117xqfscZAqXtFCbtvx9Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason that calls to block_unblock_all_queues() from different
context can't race with one another, so protect with the
sdebug_host_list_mutex. There's no need for a more fine-grained per shost
locking here (and we don't have a per-host lock anyway).

Also simplify some touched code in sdebug_change_qdepth().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 711aff1b4258..ad6002c28b6b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5497,6 +5497,8 @@ static void block_unblock_all_queues(bool block)
 	int j;
 	struct sdebug_queue *sqp;
 
+	lockdep_assert_held(&sdebug_host_list_mutex);
+
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
 		atomic_set(&sqp->blocked, (int)block);
 }
@@ -5511,10 +5513,13 @@ static void tweak_cmnd_count(void)
 	modulo = abs(sdebug_every_nth);
 	if (modulo < 2)
 		return;
+
+	mutex_lock(&sdebug_host_list_mutex);
 	block_unblock_all_queues(true);
 	count = atomic_read(&sdebug_cmnd_count);
 	atomic_set(&sdebug_cmnd_count, (count / modulo) * modulo);
 	block_unblock_all_queues(false);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static void clear_queue_stats(void)
@@ -6036,6 +6041,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
+			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
@@ -6051,6 +6057,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 				sdebug_ndelay = 0;
 			}
 			block_unblock_all_queues(false);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return res;
 	}
@@ -6076,6 +6083,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
+			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
@@ -6092,6 +6100,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 							: DEF_JDELAY;
 			}
 			block_unblock_all_queues(false);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return res;
 	}
@@ -6405,6 +6414,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n > 0) &&
 	    (n <= SDEBUG_CANQUEUE) &&
 	    (sdebug_host_max_queue == 0)) {
+		mutex_lock(&sdebug_host_list_mutex);
 		block_unblock_all_queues(true);
 		k = 0;
 		for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
@@ -6421,6 +6431,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 		else
 			atomic_set(&retired_max_queue, 0);
 		block_unblock_all_queues(false);
+		mutex_unlock(&sdebug_host_list_mutex);
 		return count;
 	}
 	return -EINVAL;
@@ -7352,7 +7363,9 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	if (!devip)
 		return	-ENODEV;
 
+	mutex_lock(&sdebug_host_list_mutex);
 	block_unblock_all_queues(true);
+
 	if (qdepth > SDEBUG_CANQUEUE) {
 		qdepth = SDEBUG_CANQUEUE;
 		pr_warn("%s: requested qdepth [%d] exceeds canqueue [%d], trim\n", __func__,
@@ -7363,9 +7376,12 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	if (qdepth != sdev->queue_depth)
 		scsi_change_queue_depth(sdev, qdepth);
 
+	block_unblock_all_queues(false);
+	mutex_unlock(&sdebug_host_list_mutex);
+
 	if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdev, "%s: qdepth=%d\n", __func__, qdepth);
-	block_unblock_all_queues(false);
+
 	return sdev->queue_depth;
 }
 
-- 
2.35.3

