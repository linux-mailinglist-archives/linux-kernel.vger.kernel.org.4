Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B996B7872
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMNIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCMNIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:08:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9907DBC;
        Mon, 13 Mar 2023 06:08:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D0r84u011810;
        Mon, 13 Mar 2023 11:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=XHlX712xm68FZo87Tb53dlohUvNpiY8pf4sl6s6vR7k=;
 b=YNkTG/+fPFd/uqEuoFvJo8il2rk1qFk1po2lUB4JpjRFW0cDfzOn5POcnpb5swONTltS
 PfPdwcVl1oPV6JgyM7wZTqe0uywBgyhHjWxpfOwSF7y5TnN0+gZo41ScTKSwlwfW8kWX
 D2hG+qpFtA/d/JWP7XZ5zQjhg5h/o+/rrc9nli3lxgxacMzbkv0mz4fY5DuGJvImi/RQ
 pVSNFsF8jqriBBzAJdShejHEswSEwQkqpVQEJROUui9t2ImUAUv4dVHxwWjagyEVgEiu
 rpcrscvezlLEzSALtES/jN8dUwJzmPkZsbhnVy0vZFk3vuh4wmgovqt0SJefVdSURXBb ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g81bkrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D96hwJ015289;
        Mon, 13 Mar 2023 11:10:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3509e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGeZzh6QRpoaMNJmZ/WFqhGiCKqpqTrrneyVels08Ax9g/u8HWGh5OTnMn1b62wmVkO75+EDm9PRzVTdrcI4ggP9PpZFM9AXpkT1wQy6om4zOp+VxMGWcJXY7IqK2+Z5W4Ut6RbsxGVqJI8Bk4Jhsgqpim37tV86k5vzGwnDjjrViR08K44dumB5ULrNl20ZCxfEQrhjgQuE5VkZxqj94nAABKjHzHQDPAjB1zTWXKMzAk9FfsOApC9+Iz8KKqA81ZcVthUe96rf2DhdgaPIBbW5DX+/7CdMY0YbAQUvcYxt/llZ0878Alu0pqxSLRC8LvA8FAlMIFwlYJZmm9/kPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHlX712xm68FZo87Tb53dlohUvNpiY8pf4sl6s6vR7k=;
 b=oeJSpYiQyEmnli/2wk/7ge9o/KtWT2M8zxlr+k39mJPQP1dyA1st0QXj6OwJzcfeCJhaFSvF7IE108AnDPdkUBChVELFESsSEcIIrZAG7PRM1PwbzES6lkDV7c89RoaddM1ksO0YwHGekyFjb0CL8mzC7Pl0J5UEKFyc2P9oJD+zfKV/C3KsPYTlkZGIbWEWHO2py2TG/OP9Xo1agLzcS+QbBVZ3WInEWH0HZGHy8av6+dezLXzcFWRg2GQCsGltEz+lzxPKTG/Co2ndFLDc9zempHjMqKj1cG6Hpl8+/qrH9kP03+1gWHUXQwApvWH3N7GaY0BbC2b41ZCzgOoz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHlX712xm68FZo87Tb53dlohUvNpiY8pf4sl6s6vR7k=;
 b=ruzmXaDrly1tgJalHfY5E8v+Py3BtxQFMV8aasHv1WA4NntpAHSkXN4KxfrW4Gehb23+e7FgIKrPJFCFUJc/b0NS9MZZl1AahqBSET+nvPi0NxO13SoD3COLzbtvS/klbisAeMYcNl2Xc1/O3s6vmTj9Sri8LN1VeLtwrHYkVx0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:47 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/9] scsi: scsi_debug: Use scsi_block_requests() to block queues
Date:   Mon, 13 Mar 2023 11:10:14 +0000
Message-Id: <20230313111019.1521680-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4d4c4d-b23b-4dae-3a2a-08db23b398c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHCpRRsNfvHUyiUgVeSTNC2oZUIj+wmYusIwRTAb+1c2j6XP79C7RJH4F7CzAQI6PKG8b9bfBJ3gvWCKZMWe8jtQOeQ7z3E9VZv9kKpKFm92rmcZ0zrOGrhsRfpwDmP23p2cEhIPiunr5bzRVfjjNw+P65nkiguwN+HrMAGY7oTO9h6uzq1wRBBdyA9rOF/j/1oGAcLusZeHW2Il2xWtHSMXQsijVVS2UyseVvpx/OatGZUSjFH9rv8roi2zfr1o5bjFgzX1eI08PfJ0tkXvAJHktFGAT5CDoNCR9BfbQRQiEVFMtaUbflmXXM934nYc6n3bULELUTAX7CkbApxcJSw5E3kVgzCg9TNxvrGqmPsU4c9ZcPiiCoFLNJw0PqSm2Dzk7xccyVSa5Odbl1VCQDvJD6C3YUYMxz4RseuOcIZB5p01Zo/OSIrI0qqWB4/nKO0Rmk7r++7tg5qZ3BrW+KMcdPoX98B9jJmDjkEA+5fyde/dJaazfoW60FdVKAcKjhkxdUqGYz0dk5S42K46ZR0ae6HBqoUW6PMwTWzmvxAsMkZrjWXYhUEXMZx8gwVHs3S8rA75kMWEJGPlOrVKocppVEIDj3n9mFAZrnz7daBxmZbz/31Dxy22EYEs/XSfLUvXVe/KIb5IJw6zaNzZ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bLAKDqKws/9R+B4Bv8UYGm0OP/6zNOaXeLnBxTnZs+ujP3NYSAxYhK6D9gz?=
 =?us-ascii?Q?krEwHfMFFzqnH8bCSYTp8EKUxV9Wq01zBBTSFBAOJj2kxUZGuuzS2iwTEif+?=
 =?us-ascii?Q?KPIVbktijdKxuS7Oufi4vaClOdZknIUZSseJhPzsPvjLu4qLo8AkTjsK3WRC?=
 =?us-ascii?Q?crQN9w4Exmitz2awHagV+EU/w9RdlPNJNgA01Bad7ROKWlA1YclcX+qMIDVR?=
 =?us-ascii?Q?CCSI2LnDqHLV64zqlSMClJJUnhR+N7SmJXzsNtna1x/vb533q84rQ7QdV5bL?=
 =?us-ascii?Q?Ubt/2iPQT4PiBNkVQ6B/eCxuecF9bYI3oWvefNO6j3Io4G0hYA+d6B2RpAGr?=
 =?us-ascii?Q?z5FMdRB+nie+SZJDtmu/DF63BuhpKQA4Eu52ua0Bgvr1BfA+dtW1D8jUKWZv?=
 =?us-ascii?Q?3nlwfHupdLWTkgHYm4AS7GeBK+0YoIL8WDyAvEcXvrcOQv6693ePkeLyCQMD?=
 =?us-ascii?Q?abUqomb8+zBMfr1Q1gh+XMZgqqRgwETQNe0Es2rDAOjRCaLT3MZcoLPjG+PF?=
 =?us-ascii?Q?ndIrM1xJM0cTzxjp/KYS4zeJinhs/jqEZESLKutg7uiJmosk/Ic3E+xpFG7H?=
 =?us-ascii?Q?fxJ6GDPxsOq4W9qIRtPY/0DyQSoTICZamgy0tXgartNwKc4aJdK0NxK7+dAO?=
 =?us-ascii?Q?0wW0TMHL8v26vRbgSJWNu31WK9xAHbc9nwYikv2Gfuw3x2DR40JwStjAQjce?=
 =?us-ascii?Q?1qng1kCxMLm9ffZ7IIspC9OaCdES7TI8AxYCRggInTvQR3XKGMUiIK+F/pZd?=
 =?us-ascii?Q?025FT2AUmZD3Cf9+h68ckCXbTJ2grFH3QgbTfoOIeuH3vXtmA1uv5Bbvm3yL?=
 =?us-ascii?Q?NxKs5tyiGfU6F2f8dOK47Yxds4tNuXPTt+4a8mhAJH9J1jjgBVzONmrGMbjT?=
 =?us-ascii?Q?x2RemmqsXG4t7xQKeJ79vGFEYagVMATtE+L3IDv9JRyLvtOFF0LPfXDAowKS?=
 =?us-ascii?Q?MstQb81/iUexHrdHZ8iAV2+xsijhbeJE/Gy3lBoLMbtdg8rQLNOctIqLZqyT?=
 =?us-ascii?Q?WL6sGjH2khiVuekfmx9gsfZzC7gkHUPlyC8YrPApaSEQI5lM2ZrkesXUfgmV?=
 =?us-ascii?Q?1QUxykMqZjur8dPvJDA/cjRhHvOwsvV2EkZVlqIMpcAO4TaOmsBgmH7g13+B?=
 =?us-ascii?Q?VOOI55LtTSaAJzaJhBY/5cPU8GiFujkpRpki+musVhiVocwRtDH0AFM2/GVH?=
 =?us-ascii?Q?cEcwyYgxGGyf5nPal+W5JfaxTTuL0wZ2vtOD9LgrL8TZyS420nUK4xr6C3it?=
 =?us-ascii?Q?qA8F1MniKnI7Zf8L3jb/OswPF+osDvkzQvTvq0osjRbSmlKQvxxfVXzyB/EB?=
 =?us-ascii?Q?K4RjBp9oZViXc9LO/ZRRS/igbzr6KW7YY050/4y0oPmKFiVOatW4f3pMwB4C?=
 =?us-ascii?Q?94v7rP1egbqv6kY9ilSr15/hcde4rPpxZ9LKCWZiQ3Iewn3Fkd4hhIccralU?=
 =?us-ascii?Q?RR2rxRvZCTvBNsEIy3NJdixyweveI1zCWNzIkFWhbmjecdYPpe6ax/vnriMi?=
 =?us-ascii?Q?rqdpwM3G/oAzpgCh2T7Hdu3Z3SWLt6ltFjXKJQjC1s7f22KXp02grDegmqxj?=
 =?us-ascii?Q?PhAHINiAv39VktL4oKGjvyt7UbJkxqwT3Xonb9jwfmIEKubLbINQ753VtrWs?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +qdIgnPCQ1tqqFoSyV43Eto0PzOVnEVZ2YGthlyMBXgyiBdEEyB81BfZD8VlfCO38FuDv+4827KDDRXn5Dj33gb8AHrh4vtQWU1uuATeh/Y/PzalqSfYhV6MP0l02+0mqAzgpifzPiIcQgURfSvxmcO/6GkXClJzMBvbPmqMT8+kt6VG0QEnAuNll7Q3bMBEb1gZ9SGyJQZOKlSHrdKlew+KwMy8J0fHaoM2QuaAsFXjuhkGutn0sQpyPytucHsKro3jDfrC+4ky2q/Kwg4kwv2cI0OBalRu91JQ77lvNDRqzit+iLFx8I/fGAtw3z23JOZO4CkTnJ1Q7stD2yIby1I+E2EC3g87C3KBT+SefsqyZe7rDjNxqvGoE0WZiSnlkQ46ntJ/d/Z0LSla/w8BYYomI4MqtUXuUu+c4xDaPDFr5U7sSa4C2v2ETPMkK5Eb69mOEO2ulfwDNzT1IEx0AaEu+3FwsbAzIKwXD/QNWluFkav5J6YfE6VqccI39mqm4eP7sNMqfrCl7KIQmHI1JYt/PiP9s4a2looUGD3zkqnO+vx3FvxOo+W5EGfy9YIMPesMEiBZpum1uMktKeWWIqjhQgXdxruBlPZ6/m6BjdLg2+m75UNP7/rkWcSErUf6GWjO8oGGFnkNjL2uwrBsMTf2B1fzqMWt16DlURidh5Y8v9+39PI7hOlpZ0zX8+37vNmRVE3YLx/Tie+azvxAg8MTu30h8J3tVEbtnjX780VdQ0yvIscHOuKdaG2uP54SDeVgXYJ6JpLtKyghDPX7/ZPWnggxz9I/7TNMYDLml1q/sjCzAl1ziLJo12bVJQa1FXqTyZzPcEdokA1yrxirAZ4X83i2gCRAQ6ZCH7AO+bfjv74CfMSKh4Pdjt9EDAhw/g0wiu/okTeIwUxCivHhNu1WyRC/eDWw2ieXEm6QOEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4d4c4d-b23b-4dae-3a2a-08db23b398c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:47.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+nghzMbHEaXRETMKo4ohsFODGnqj6Ul2MDObXVo92I227RZvwUAGuSKLDwOhUFaf3Pq9qbcmBd+obF4HJmThg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-ORIG-GUID: nvMcHZqYelsIieue50zSXrG7K5x2iVcG
X-Proofpoint-GUID: nvMcHZqYelsIieue50zSXrG7K5x2iVcG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature to block queues is quite dubious, since it races with in-flight
IO. Indeed, it seems unnecessary for block queues for any times we do so.

Anyway, to keep the same behaviour, use standard SCSI API to stop IO being
sent - scsi_{un}block_requests().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index ad6002c28b6b..fecdaa5be11e 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -359,7 +359,6 @@ struct sdebug_queue {
 	struct sdebug_queued_cmd qc_arr[SDEBUG_CANQUEUE];
 	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
 	spinlock_t qc_lock;
-	atomic_t blocked;	/* to temporarily stop more being queued */
 };
 
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
@@ -5494,13 +5493,18 @@ static void sdebug_build_parts(unsigned char *ramp, unsigned long store_size)
 
 static void block_unblock_all_queues(bool block)
 {
-	int j;
-	struct sdebug_queue *sqp;
+	struct sdebug_host_info *sdhp;
 
 	lockdep_assert_held(&sdebug_host_list_mutex);
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
-		atomic_set(&sqp->blocked, (int)block);
+	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+		struct Scsi_Host *shost = sdhp->shost;
+
+		if (block)
+			scsi_block_requests(shost);
+		else
+			scsi_unblock_requests(shost);
+	}
 }
 
 /* Adjust (by rounding down) the sdebug_cmnd_count so abs(every_nth)-1
@@ -5572,10 +5576,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
 	sqp = get_queue(cmnd);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
-	if (unlikely(atomic_read(&sqp->blocked))) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		return SCSI_MLQUEUE_HOST_BUSY;
-	}
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
-- 
2.35.3

