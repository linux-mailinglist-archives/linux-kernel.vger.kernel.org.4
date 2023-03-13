Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CDA6B7170
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCMIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCMIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:46:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394084D621;
        Mon, 13 Mar 2023 01:45:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CN0lJq005179;
        Mon, 13 Mar 2023 08:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=JgTlblEnUA64VVgC8ItR16lB7yl4gQ40uyjs7QY5m2CGU7q71GDjBK2IRJLJPynoowEA
 dXnudo7IZGOYrSy2DokU30vqOEeVJvDKA16vC3VxpKnJa8ME7gxaoEyG1vuT76kb+Lqz
 HdRp3f2Xu+uSNGq/jbKHGNXqNCLHZluX1f164moDWInfMiRf8xhxYR1S70/IyPTgCOQJ
 DLxhrWmn0eoJPaG3BvUzB6K5gkKEc6r9l02AANV1hlTR96Z2hCO/XufUYhbEh58t7yPD
 2TEfV1DUIq/UqIsguMAEUTKDx8SJKBLLHbKIPytEduuRG/7FWwE2NKxgf1zR/IOxgIQY hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhab7s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6tIlP033575;
        Mon, 13 Mar 2023 08:45:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g343a9u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJdbHvAenDNGseKvsW/INdbzy3UkuOrRv/TWxcfNcsLrJoTR+kkT/As76AitkrgRGmg0JhtnQncBOER4ClFISkJZqd/XBakFvlXHfw9eUXv934mdtkfJrBSXU71rutqCb3TGPwjHPOiFB78o9+prpN97Ic/R3fZ3tBJ4kWoJ/v18it+K6neTp5pc0HrCodbmdGKCQxV6mGEjynu7MN1yYL1xvHy2ZSZIw3tEn3eGi99c1gikSMLqSDjO4PKKgtfZcid4JN5vkOVIMwwJKepJfK0UqcvK+sP22nyDzNaJX9PYRL+NvE/pMw8d2fDIH4NsiEC48uCSyi0nxooUrLMaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=C9+SrCk2MK3z7ftwvlGpMt9GAlrXpWq6j374cmjizyE96H6LXfgVMg7GJ75TV+bxUwtuPUSvGJ9WyKKXhiswCYUMH02BsBMJtr3EDRThMtlkYWeEbEUVbrUY2KJBzAB0N02P1qYmUDMArkGsWK9J0xNEAWssh9+ow5YgIFY0Tm2NACltfCdOMZiqxmW9OXtL+kH6LfSHKX5KNz4hLTvnuTW5jQ2vNVjJZQ39HdsAzm0jg6SmoEY+XJKDcY6FDMsOUIm/V6wL88mlzO0Ezn+16Ajf5GMvw4KQrFlvWzEI9GJZ0I6869vnLkHSelKS96svLjpFYRdB/P6e6GtWgDWbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=dReOhmijTS4IvDFP0g0VfHQKpF44I/T/zDq+ZauqJP2NFG2Jc0/Do2ehEJCjZamVVIEnL5ViK+U5ZP66Kr20kK+vvE7hKh2pbaexR8DTIjgmmkiMGm4gcBe94qmceFDszpmdJMxkzVkObBpEsdtXHcQf+nua1wQUYnmLjQI7NGo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:38 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/11] scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
Date:   Mon, 13 Mar 2023 08:45:03 +0000
Message-Id: <20230313084505.1487337-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb11cb2-30f1-48f3-d9b1-08db239f51b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roo+oVVXyaQOFLS1F8JmmIJaW7/b3p5vI9g6CGg+F0a5jGUVfaikD3yfaWm6rDTOEIwBfjqkgi/261u0H73f38iDRUwqsf70KHfJJgIVn8Rh+dcKjjfQ3hdNC/7Ws6ttw2Y8l2fUktjplx4fSeT402nBFODK4WYkZisMR1/VNz9aXuY0pzZzHrv8/iJ7AGf16ixc9+ZBRSrhnrmCp273BGxBJKm85kCiw8Jl2JjXnWFunhDGPGkmug4+SMS1asvKkwRhd9Qcuv11hqOy0cKo1Sj2WnIzWDjBttOqDLrPq68ymhiDWvdv96y4AkHvGghWwE0mZI/7S1f94Ry0XS1VxrBmOgMCN6+o4EvWetccFNgSb+oEYtoseHUOnSiC3pmDsDrg5d7TdK8AGzO1YUDyBJtp3m0tM3rc24smHMkaEAwBJis6Ntblv2nST2W5oQ9t4PhC+7FGufsa2w+GkqwzpR5owguEpvN17MmL+crQwXrBU7T6pD20uM4SGfzOo/lM2HQnskkUIAz8+JZLPeljde23IbN9UzUMLF7B1rp+n8BqXleschEf31W3RU1xYUiJkQYFI3/iTWST9wwYuSteJcxATDfjBy0P2br95BTOM8pZLHgWic6yPRY3qEq2F5LTWV8NuPUf+grgvyVA2ZUlRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ABESVRRZaBi429z+cEjXe6ipBr1OwdKQs0po2jUxWPmKXWwaqyJA8waA/qc?=
 =?us-ascii?Q?ocelp9Ffoh4XslvwtHWqz4p0DekKJDrQzYIwf1vGyR3Gw2ID2OOtOlXQK6DL?=
 =?us-ascii?Q?ACU+WKcNbJPk+LNNuoFHZnMuq1DDGaodkLrj/peeQV6Qr4klZYbtD90YlaML?=
 =?us-ascii?Q?rUfYd1pwymKAaWoz4eaat3cE+Oe0pqu8x8eAOPAWpZoVbM4kyZtiNu6umfn+?=
 =?us-ascii?Q?mCAHVFiNavwcaKYD29BzrKMF9fkZpB+Knlxg3+z0aYmAJjn0tv/5n59dVPZv?=
 =?us-ascii?Q?zvUznpeQVhE5RoPR79mSsmGM73+fQ0R1gmJwu3mTNEmgZ5+t8ZtMAdGvALNv?=
 =?us-ascii?Q?mqk462aTm7PsfqWJb2KxD8nOfpmQjz9ChaLHIc52QaCm3uPPTQrF7iPaxe9c?=
 =?us-ascii?Q?ijjcfguyCrKhmaSE/RpU/15nx0m9MPssRgaT0FfJ7PA9ktC1/dNbHSdcgI99?=
 =?us-ascii?Q?y/Y8gFjv/UJiycpguwzndP4ZlakGxgilZpcYiDSdYIcYDwlBr0wcLHXDoGu+?=
 =?us-ascii?Q?JGuHrJoa0PzYnAoyj5u41ynGwhWzwStdfkYoCSHGOMJ89/etva//18wSJ+xa?=
 =?us-ascii?Q?u9Cbw/nysrMflE6lTCVbV4LnOwAxJosecdjqzSuxdzvtjKAsrfB4c650KQL0?=
 =?us-ascii?Q?7ufJCm4e2QNfh2cjVaJtMndEZfvFI5Vcpb1tq9gVhKMVhDp9s4FKlibpIqxP?=
 =?us-ascii?Q?2FzWYXBe+YsK2+Fm3qQyZ/4GapxIotJqOBOXpE4nAxNCSqFURWba8I3bKcUX?=
 =?us-ascii?Q?NojIoz5LsKADW7BKkr12ylf64BcJmD/UXUYWaSUMlOHGYiQayHAL2k07yyEr?=
 =?us-ascii?Q?RP6RtPlWujyLXCTk8TUz2fnoIO78bQUA0ds7vSmHIiQejZFFd6bVL/CrcHGf?=
 =?us-ascii?Q?hTA17W9M4p3dF1goe44vzPajGzvfkQ5Md74oNCGwpBjtShQC6jLADgjvgs8i?=
 =?us-ascii?Q?/5lTyASm8ghWBSINBXonRfZ0CzWTIvmS7OVfHIa3PffJ63iQ3s+L/JNSvCv5?=
 =?us-ascii?Q?4jWbmx4TVBELRndZ/No6ZZq3Ictt8B6p+sh4/gjCX3HsiRgWboQBfp9pPQmo?=
 =?us-ascii?Q?NMhMOfgO1r9cJZN+gfDBLifUU15WMPxsbBBK39bkjC0htcVYzQo0WEmkjW/H?=
 =?us-ascii?Q?swZvi2SMXz/pUiN1KDDJUPD79c3MwUD2QvEYWKrIH003CEqfxnNgU9Jnq92z?=
 =?us-ascii?Q?odEk/ZCEd9AOA9y9o3nQ5RZNqy3bHPg/C8x05MvKSUxAjmRAXclWVZD98tqJ?=
 =?us-ascii?Q?2qvLfP7oQgX63iWSG4qt+y0WWP0T1v2Yn2uD6N47aNpjPENuw5cJ+PckzZ3j?=
 =?us-ascii?Q?SJ7vqiBCEGynYQXYwNvLOJP5hLsBKg03YCkqxWxkKFfy0sFiU3MT0m/B2UnB?=
 =?us-ascii?Q?6LC568GXoh9mkagwpw5H99P3Fd6Ffm1xcp6VNOMAEIYjfcHMXrPuhjTkYSRo?=
 =?us-ascii?Q?B67IzTarDg/ZHaShMnAbSC/yWSD+IHYamp6WLmqrALR7Brk+2z0oP/DY+xVr?=
 =?us-ascii?Q?fHn33Wb+Sxc0kJ7f8P/DVSb2QG2tyCa5S0j2m+l2vYX+307WFZNKmJV8509e?=
 =?us-ascii?Q?xqkWEl4pPQ2XpWw4I8lVU09j2htYthv0niojWpwnDzaXP+ajiAaSg/J10PRF?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xn1D3ZR9km3OA1q8tXrFpWLKWVUhXZlkEbfXwnYPqL1qRcm8iGPTzMjcmsaNyB8WQj+17yU8MJZ+gRlXsJh4DsMc1Rv6txyRb2OMiiiePFmozI3sb3zh1TxnzHZAdHTxo6Q87jGA8R7BMB6LRZVlel+ykv1/wXC1bCB2dqxJ2SxtKH4VjGdsSXJ7KqknJdzw6a93j4bRMtMXCKI48dy3Q1lHUxE57WPPp2VA9XfHHjNjS3on4AWs9n9OURikHIY/UR328x8Mm+7J/PcKPWlITArBQH8V0g7/pHIJvNUjOpAVCXtj0QNcc2mJnMV8GGmFPKqno8rjaPeriavyhmMMFPT6Uu7RLQeqYVx9sx8Gdtm/ad8RfrxxDuTpude4oZuKepjQjBQUh2xtNEWfDLr1jt8hpkJjaacupo/Uf+hw1aRqK1ymBOueJdQdSMVOtXnRzaySMSZRQcnYUxWUSo/PLq5haPe481DkV1eTzu4kawl+iebN6Mkftd1Ldti6UZvBOBGqKGSTwUrwuTaDByPw8sXWR93h3/dhBtq333SGmWZJKKnqP80RXB9owz60gWI93pVSwVGcjjDv62ScNTxVjh7toc2CqNvi9Y80TdTSS1eH6oBx58mCkMrwn0f5wz4d9IqmRhTwsaXlEFWW4wNDPq9fNUcS5ZB4HxX8pmPaHykC72qB+ecHv607zmPuZsrG+J8M/4lCHnqiB1lVxZPclecUQnKmXiTVCcGKgfg2LI0KzZYXgq2URCoTu9fjVCf7k2Pfs9KnxfkDVlZprTFT6vKC0tNHSpZnmwCj97pS0fPbyZJCQomJ7DeeebIntiFUqXM/OPFYsbEZVIUtIPSPoAkfaNZgZ6v4+d0557trwDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb11cb2-30f1-48f3-d9b1-08db239f51b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:38.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cteYM1yuskwtI+ZSd25KaQv+MBQFj5q0d8E/v9+K6UBBTv9aCul6INcKsfWsvzXGM2QfP6NBpUts/hbQxqF05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-GUID: R7Nq09oVXTi_-u0l8i0ICIjv9Bp-U_qP
X-Proofpoint-ORIG-GUID: R7Nq09oVXTi_-u0l8i0ICIjv9Bp-U_qP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-device num_in_q value cannot exceed the device queue depth, so drop
the check.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 47820b9f6326..0d515bac93bf 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5593,15 +5593,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	}
 	num_in_q = atomic_read(&devip->num_in_q);
 	qdepth = cmnd->device->queue_depth;
-	if (unlikely((qdepth > 0) && (num_in_q >= qdepth))) {
-		if (scsi_result) {
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-			goto respond_in_thread;
-		} else
-			scsi_result = device_qfull_result;
-	} else if (unlikely(sdebug_every_nth &&
-			    (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
-			    (scsi_result == 0))) {
+	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
+		     (scsi_result == 0))) {
 		if ((num_in_q == (qdepth - 1)) &&
 		    (atomic_inc_return(&sdebug_a_tsf) >=
 		     abs(sdebug_every_nth))) {
-- 
2.35.3

