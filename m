Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED96B7296
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjCMJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED701E9F2;
        Mon, 13 Mar 2023 02:31:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D01Vc3018846;
        Mon, 13 Mar 2023 09:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=LZS83sNwbvhPI+SCeTsK2vRWpk2baOVYj0r90KCeHSeyv/3wy6rLlKxvfx/+IcHKV6wT
 OwSQH8dvgKdt7gnroqv4DVGAn/CzxPrKY1hrby0UnBGaOnRs8UFtaK8LWlQOT3Y4BpZW
 rG932p/YCFXMUWaAwafRdtp08vVYaV9pNPaKWKGamfDVFa+lecpcDjVyvOwQXz2j2CrH
 ob/4tZqbTjUBxDjE45Ma3tuXqJOmavD559VeREj7704AIE1Iv4K3yf/tq1/sI2WO1VQf
 OokUgpUDWJ4irG1Rt4O/RsoYdkbz7sbO/5beVZ1uX/TtrOD+EkwRpmyqeegoiTATGfKk GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhabas2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D846UY024963;
        Mon, 13 Mar 2023 09:31:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d2cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJBIpDjEQOQdMtGeKs4XACohclAcERegnXB2icv0d6nJbowMXuVCjPnc6mwJeZZDDpQB7fA7ZLL30DVNHdu/ecQuiAe+p9aLBX+kEt6rbhR1aOCf58DVu/sr3EWzWWlN2IgSfFzTLwgI/J21yVGBKl0dqk9wr3vlsaDoVbDESUpaeuEWccsqYDySz0z7cq7vagvxwlWW3cUrmERvFQMkk6AI1q1HFEpZaiRFiXhYYsVj7gI8sP9O2JuAD9ktzBDJah3VRg56A5UpzkHjgTyGEHRsa9ZhY0FooSCdef08kWLSqfUami89tj2EDBPKjH2NzSGGxIYRC+7Mim7QlRE4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=VYbnVrCSWmPIUXNHK9501SkD0IKmRxu3ZWn8rwwQdlLbgB+M2daH9Z0pG6woYKFJTVVVeBrpcp2AUqgeMoWazlL5WnfL50X4WEs7vS/8cp7ANcpMdya3LOv2Z/WElm1vTMtUvEYHINhmFmNhIjr5EbSQYeyfsjc75l+qB8qiavPk6zJQrBsBtgfuMIMdh9HCUzzCfI8+gagkDal9STy4DdJ08a5qAHjjjSdhnvP4jV1ZYMuyUniiObcN+JZQezGD8zwUnnnRThmHjoHrEJLCQuPO7eIrCZB5Ip78bOsWjn5H36hGhHHIF8XRK+00e38RzYLp6oFgImkFI8QASeceCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=FT/GUHaU5s/rrUru7unCBIXAoRS4GFxfqO64Q6jcgINwtUvlIy16+4P/+jL0X2UWwEKX2t+NzvmVGm+gEmFyafAkW9GCAcJ7vdxXcQPzT8YSOG1vaqXW9do4E4KDHioAR2XYRzC7ikTP++cWJPtLzIrxfcBVLnWfQI81wtf2zUg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:28 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 01/11] scsi: scsi_debug: Don't hold driver host struct pointer in host->hostdata[]
Date:   Mon, 13 Mar 2023 09:31:04 +0000
Message-Id: <20230313093114.1498305-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:2d::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 262f4bc2-f5e2-404b-a1c1-08db23a5b8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsddBSLEr6eOfK+PdZNVydwxgfCwnSgOJQRV7hvGxfo6fNCpigxSUoo1RqQpWJG3/AF9ifKcU5bEKdjm5Tqssq+dZOJNpqtShIopaisTG1J6aL6JGrh6Bb5oDXcKrAa0p7AJSw8HmdAfJc9xrEPZdSUjb9p31e7w7EzuJ9NnqHDLPv3rM5PRb7i1Be656rmyJn7gwMFSb1NE+uOyRnl/oaZ3sxhXgdD2JeKgorvMfFHx5x3AxagNLhq4OUdFysybPL63HjPNac/2VYQTrR1W3gEOe5zEs7ViOxUghmKo0CWOXL0QPAKGS20+wV3lCMyexd6xOGKA6ngSuzqPK/hCvY9vWN9ey1qRqYnroW5+MVhqyXvY8+ZE3tBGBCIFpaYQfQ80nsArTAPPAg+YiGmStgUlm/5q0fteeI/Nuxs4DOvtIHTiEhEIJudKdYsYy90VfrJar6uk4mCRxkcYzdHo6q8HJi2U1hXvWgMmw183G13fTKiAFCP0HqoY3dBz9xSxbyV1wVby+hVdPX9o4HDyzQiRTuVYzV0A+bcGKXr3HdmpT8aN0XjLRMAKqFCynWrU1rWAqPBvO1OBENrPiBD/DrU1zmZosGLKb4VsUfOTkUSyUDy5xpfWq45yDYvbQ57tEaasnptFAvT4WSA/pAXdcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhQCMw1jkV0GAGrYQXPHPqvCVQWapBLbvyZwu6XCR4WpF2k8XCNFvkrKUi66?=
 =?us-ascii?Q?hAknNSIwvVDvaObV14W5OTrwbU+wCo266VoxVQUrdJWkqPmn6u29UjbJGnOZ?=
 =?us-ascii?Q?90DcjLqLmDqRvh/ozpWGTc2AMn/fvapeY4U43E80EV2fOk9wdzViwIkfZyDU?=
 =?us-ascii?Q?xErIoNQpCPsB9TwMm/6eIGAofcjSsEhdj4KT345spQVYteLbd6ofqU2VhA9Y?=
 =?us-ascii?Q?SEXZJmTRKdSHM23GkCDMLcSvBHWbkFsj4GD6NENM/Lga9f9c+MU/m/Xsz/Vm?=
 =?us-ascii?Q?HKqs8vu0eYiXhuzQGYTWHaWc+Ht60Qt5NIz5W0YvftsvFvsdTOg4dfB7indl?=
 =?us-ascii?Q?p0OgDPM0zCQ47Lrk8vrTa0eKJt3l9sLdI8YOuG/GKuzvhhrKCrheRezjo43p?=
 =?us-ascii?Q?ShEZlt1dswfe/WpavPf8iXPbfKLnAHIc8vL8PXlSumhfXKBVKxJkO8p5vYwg?=
 =?us-ascii?Q?rt0yDrehKtistZf5K80EzwqIUvLAXY/t1bGdA2NSB3t8xEnHhuN8Tyw6Pbgh?=
 =?us-ascii?Q?ebP6IA1VXX/83vRG9UUDHOrBlfcwH6/EtnRvTAeKvhF4VWm9M+AGfR0J27AS?=
 =?us-ascii?Q?npFXfJfX2abb7YdxK1fCIzEa7sydffNz6LNWewTIuFtTXcpiLdTG+J5NSH1d?=
 =?us-ascii?Q?KFpfGKh8sPPLTer9RHfpbhs/nHjrtBr1jrssumns89+WwPSRkMGlCNP7S7+L?=
 =?us-ascii?Q?cvG+zKIRRKz1rkqfL0HJNllQmCgPG7RIf+CHXEIrIdki7t1RS8+gF8llcnBG?=
 =?us-ascii?Q?uj5IgRnGFSKyO7RaBrMi+uO9AUv1h8k58f2c02pS9dKfYaGo1A+9mSRENCpi?=
 =?us-ascii?Q?GR9hMpUb2GsmJ3wQjFiskwR7GA3I+3xIgPmKKzVTyUKgJblfvgJFSnRbqtgk?=
 =?us-ascii?Q?x1CFf5Z0KmzqBZmP1uSp3FvYfv1hjs2VUKKsHGTKBHIHjA9BC3MMenYVlg40?=
 =?us-ascii?Q?GGb0U6SPq+ROmnGgjpk2Nm3zEKbGF91lHNAPUiwXAiaf5qqeyGY6CUNdaFCa?=
 =?us-ascii?Q?Rb7vSK0jcUmWRp/LucA/epsTezFfVfTEKun68LAzY2aImCCUf2l8q1VXwdjH?=
 =?us-ascii?Q?vrvIDMyxTopfnSS/ZvEw03F4VyU+Zt507IH/fbS3K18R1kJSwXHP5yDrlI6j?=
 =?us-ascii?Q?vmrN4ACNU5olC/7Qe6tW+wUokGRIAYLo4D64EMDz475sHCUBa5kJh+JweYZ6?=
 =?us-ascii?Q?D5Ntod9xxm96pOejNHOSHlYUKX6Walnx7vK7Es767T12cWFrYjnjY6DDIhbJ?=
 =?us-ascii?Q?H27nicc30jJRuK7vabgBY5bJW1VSKAAngbWuTXmjPS83SE2DLNmEzbUDPwk4?=
 =?us-ascii?Q?CnAnNr7xwxE+l5CgVZswFDk+74Xl5dPR4f4T7LCiRm7IsZYedCZovTjcwEBy?=
 =?us-ascii?Q?t5C2dEvNW38bY47mPgfl6dc6fCBgZTRof2vBLI+nRLLoYRBZZVJF0Lq+fSeq?=
 =?us-ascii?Q?87G7UU5SB8k/ft4+doDtwt/9gwqzXz/9ub1ddbebgwv/L+zI1z3zQmw8DFqP?=
 =?us-ascii?Q?oK6LREieAcBto2X+Um+AkXbL/ERzHhEeVCWn/P7NVHhqyW/p4hT4+r6TC9X7?=
 =?us-ascii?Q?PdffIciZJg/uh7pdKTNQhVDMNdKhe0rBSqysdwjSMgq4F34XTri5z1ji/BPt?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OpdoivxQ0V6Ly3cHaoXVnF6KqQxlc+OulPr+CUkqUTyPj1zNa2ripqroQsZ8uZ7TWxM6zc5DD/v+PHh46dYYuZ8eIS4rVv5CAGHW3kAKdZzRzzJoUMePq0bQ1686+qzRilUGCqBWLVckq3SeiMag/jLBhJzS4VEvEl0G766YiJj452xwyfD9ou/aEvmlg+W+dcXjn63Ayy2L84t0iaqauIz/zh2q+teD7BVODkrThKgvN/D7puFloWbc8ZUF1BAHPvYOcMHVtFkYhmvQYSRppfzYV9otI6Ww2JYv0G2TmgzsFfkMPsRLXgASJfsnfIXsMswxAhrsVAZUdDbySnlhjRsdY3sT38mweXLs2N+rnGy058mtZCpnZ90dyhOw6fww61KDvEjz+Ur6gvD7Jc+KRTN5LBhaHt6tZphtwChVA6KtVve/Tl/AkflB7BahMCwIESFGNVC5yqnjLZ6IZ/aMzNoeJ1LK7BfCi5GyynOfxWLCkbftpeN27GIhFT7DdWfOB9z4u3QgIQDQ1EyBcK6oc5xLf+tB/AGFkPM3KkClS/1/lASkhP+M5/8oIKW0lld8oLXwaoj5qJFlC5tj4TnqNqa3haFZf1iF6Da6l9T8edY+5vBycq2taFaaPtuJ9k7fD4Vu5mKRktbvht9uCRm6cjjEkhLeCL573rQAg47tm3FZyXZejX2MGk4RCOhpCwbSkBy0n+wHVnS/YLtGUryrfLyja7UcJGW9NLt3N+NHdbxd6KKS8Nqbzny+SQiAdHNLEbqcpDuB8BFF8WOxBarwbKp3msBIA/bzStoKl4kLAs9sA+XcE63nvMIqMKOq64vSgbU5ZSlub7GZuWl4VGL303QvwlxiouQslMK8+55nH4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262f4bc2-f5e2-404b-a1c1-08db23a5b8fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:28.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohw3GPsx+x0hV02TPFDdZpQF7ONfjefhl/J0VrIGogXrGCYN0SmetQ7T/Rskj0SqcnsDwdeB/0+RVO7TwCLQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: 6KA6UJZ3iXNF4nZSdRvNq4mA_KXbgeA4
X-Proofpoint-ORIG-GUID: 6KA6UJZ3iXNF4nZSdRvNq4mA_KXbgeA4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver stores just a pointer to the driver host structure in
host->hostdata[]. Most other drivers actually have the driver host
structure allocated in host->hostdata[], but this driver is different as
we allocate that memory separately before allocating the shost memory.

However there is no need to allocate this memory only in host->hostdata[]
when we can already look up the driver host structure from shost->dma_dev,
so add a macro for this - shost_to_sdebug_host(). Rename to_sdebug_host()
-> dev_to_sdebug_host() to avoid ambiguity.

Also remove a check for !sdbg_host in find_build_dev_info(), as this cannot
be true. Other similar checks will be later removed.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 72149eeee6e6..554c03d7a648 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -324,9 +324,12 @@ struct sdeb_store_info {
 	void *map_storep;	/* provisioning map */
 };
 
-#define to_sdebug_host(d)	\
+#define dev_to_sdebug_host(d)	\
 	container_of(d, struct sdebug_host_info, dev)
 
+#define shost_to_sdebug_host(shost)	\
+	dev_to_sdebug_host(shost->dma_dev)
+
 enum sdeb_defer_type {SDEB_DEFER_NONE = 0, SDEB_DEFER_HRT = 1,
 		      SDEB_DEFER_WQ = 2, SDEB_DEFER_POLL = 3};
 
@@ -5166,11 +5169,7 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 	struct sdebug_dev_info *open_devip = NULL;
 	struct sdebug_dev_info *devip;
 
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(sdev->host);
-	if (!sdbg_host) {
-		pr_err("Host info NULL\n");
-		return NULL;
-	}
+	sdbg_host = shost_to_sdebug_host(sdev->host);
 
 	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
 		if ((devip->used) && (devip->channel == sdev->channel) &&
@@ -5407,7 +5406,7 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 	hp = sdp->host;
 	if (!hp)
 		goto lie;
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+	sdbg_host = shost_to_sdebug_host(hp);
 	if (sdbg_host) {
 		list_for_each_entry(devip,
 				    &sdbg_host->dev_info_list,
@@ -5440,7 +5439,7 @@ static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
 	hp = sdp->host;
 	if (hp) {
-		sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+		sdbg_host = shost_to_sdebug_host(hp);
 		if (sdbg_host) {
 			list_for_each_entry(devip,
 					    &sdbg_host->dev_info_list,
@@ -7165,7 +7164,7 @@ static void sdebug_release_adapter(struct device *dev)
 {
 	struct sdebug_host_info *sdbg_host;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 	kfree(sdbg_host);
 }
 
@@ -7812,14 +7811,14 @@ static int sdebug_driver_probe(struct device *dev)
 	struct Scsi_Host *hpnt;
 	int hprot;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
-	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
+	hpnt = scsi_host_alloc(&sdebug_driver_template, 0);
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
 		error = -ENODEV;
@@ -7862,7 +7861,6 @@ static int sdebug_driver_probe(struct device *dev)
 		hpnt->nr_maps = 3;
 
 	sdbg_host->shost = hpnt;
-	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
 	if ((hpnt->this_id >= 0) && (sdebug_num_tgts > hpnt->this_id))
 		hpnt->max_id = sdebug_num_tgts + 1;
 	else
@@ -7936,7 +7934,7 @@ static void sdebug_driver_remove(struct device *dev)
 	struct sdebug_host_info *sdbg_host;
 	struct sdebug_dev_info *sdbg_devinfo, *tmp;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 
 	scsi_remove_host(sdbg_host->shost);
 
-- 
2.35.3

