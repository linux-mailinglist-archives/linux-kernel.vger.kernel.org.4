Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1696B7166
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCMIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCMIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000927D72;
        Mon, 13 Mar 2023 01:45:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CN2mh6027099;
        Mon, 13 Mar 2023 08:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=D6rWCbfGb/EHwGBt9kW9QrNP8Ecw/rCtFGlSIS8qV/ItBqe+BQfUfr2GUAld1vzUrVYQ
 atN8m2QlYNlBdoiy++lhaL5ZxhuR83v+73dKltxmbIaNO8wMii+k7BbE6+r/48IAdZXY
 Vba5T+itYwE66qUDSMYJkUs2sKZYJFrG6WQNxMZkz5V7uxLosl5uXGbz+Nytj4fMRJw6
 QeHeeEkD0Vaptl04rupewePed0S52bq3ZIloPvfQSBnsJVubJzT7NTzCcZ1rc4U9un0Y
 fzpAbqAI1eMtNtGKo/XlnfHo4lN40h8gbuKUGY8zCfNG8dovhAkBz4ZmGdqjYIDHr5+r LA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3833-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7NBK0024989;
        Mon, 13 Mar 2023 08:45:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34bjuf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhQKI+7N2KG+JrtsGnoTTRQdOkAM4DVUOpGPtCCCnMw+sngyKAVbFx9SjcCGxkDWVMJXSNfNx3p4sQtGmQCz747qJUDKCGlg++uy8hI9JbhE2fHKLWqlWHXlHDo3vqPnAWdu4AwbKq1MQZFtjs9tw9CLpWxFAW0+4N/PKk806Nzw1ItbbhGBzC/qxVAYy8uplLlJqh41UjUdrLT87FIey0lQVKvAgmeGWKKijuZQDoT/uecNS8uEth47NXYNRvjzGd6KmXZIq+X5jGS/TeBcfhEBw+IJqVUqpjdS7aXXf6/Z7nJHBwEB7Bq/eG84qZLF6DfW/EElYyUN+apHJ9ewBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=JiauRJusdu7F2u9dU7S1U6+HSN9/0WtPeKwyo1XAeBmxuhAGPsJpNHzT0CtR7lLht6TqHK1ciB/wBsN77cOCFfFSa7GZ9XnK8j7J98f0Tv9z2apsc+4vIfSmUtCXEexuKWtgDotQMBsiTt3+vdLvS6lQshn+2IM2yIZocQaW+1o0cPQ6bK/rqXW5aXNw+1zziwjYvUPqrHhP5XBwa1dSFxD5ppVdzM48k06XO38eoeNy8kZf6fwFZpiFfLCiv8cxfTyMjmmQXnOkwZvKbBV3wD1ssjl3VWfFtjxpNEploggyDAGsVE6b13YfJmO3sJDUiQ4Ep2ngRH6SfAb4FpEl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=BbNFGKoXAZNWQ4nava+Q3KEdedjzlJT/iVAwpQN+tWmgzFyDwJJPIFfeXg9A+S384EMcG/F6JBQL9L1xE8NXw7hfIiW4EshrQRx8X3me5RTE7eASbLlUw/FxfY26t5LB75v5coDFJ5fMg5a+2jqzwz48OkfWKbuo9lL98eljZhI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:30 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/11] scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
Date:   Mon, 13 Mar 2023 08:44:58 +0000
Message-Id: <20230313084505.1487337-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:2d::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f9de51-a273-48b5-d925-08db239f4ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/SZwNHXBiRJPLubvBlpKKbL+k80os4fkU/q+iZRoOXjRLJXzcUcGh/FjPcWYcn9/g8K03lmb1c9R6fIsWSmFM0vHKapX74y+OPbORojLMUlt+tSOfhoMvx7taOLvMbJljfOl1L6Ox8u9SRLOEtMdwXgq6dBP6Cz5XWvbqn066m3cJGu6Yow3uLlG0Gzb6AF4D42L4ASC06cGfR62uL3H+jTR14XLWPCVEgoO8PGeNyHhpzLX0SxLgsD8dAfeK4ODF05QOzBty4I7F86teIozyEkvwh1RcL0o9f/v9Z9L4l37KQ7lBOLpOnsiKVEnKnW1x75V2k0Kl5lRs/ZxP/NPvWgpOUt89l1SHcIBwjfIOYlrq98SzQcx2NkGa9b7jcyoSNW9XtxOBQZ9XV9fNeNkbcB1KHZD0uDF+FvCxFQzxyOlehaS8uXGmC6iFD8FvxNh9Ldv/XW7nB9MNfcuDyVNEM+eaucB7KFhN+fnrfrt+ACRZ7dfjW8KqZGZDXkmEgcrPhT7eJvGuli3RJAgyex+MFmFdsUc6RWHSD1+DmS3f8EX6GDHCADWm401PzWPP6OIosJ97Ha4uNwnvw/QH/L7+zufWEJhKeFELbLTwVXRipIjHE2tyJjqGdh4ilHKcU3fJO3gp6pXubCu8NH29MKGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6lLIezmgAuvPjzS5vFZWqBVIfq/YxhEEjg7aSwQOqC8qOzTEToOiPo+ogpc1?=
 =?us-ascii?Q?eUsN3bR3rxwslrQSbLCBA+RXKLQHUYx/OFmmp46ojJRhTtv8OhG9qf2aIQff?=
 =?us-ascii?Q?ZVHw/Ndte4GprBC7mc2Ln+a8gHA/8woq9C+RXTdnOqnzPNWQqx262CXPNMkr?=
 =?us-ascii?Q?vDddR4YfKZaVkJp1ZCXbGawAcklPZnU8QgMol3XXuRW2NjgweYaVnX5QrmEb?=
 =?us-ascii?Q?3EVSz6AFb+ChTo4P0OugFvFGDtQRFhcz9jwDI4XIRF5u6LQwYpMn0FpwIqTx?=
 =?us-ascii?Q?DN9Lk4x2ntjk72r50h2CFHS/bO6IQl3A2LybBtQlmjn6F5oQ4n+Bw/4mJsGy?=
 =?us-ascii?Q?YzhpfUMvxtNA/I9Qi6q54KGr5Rv6UQwpk/ElHyBjZDfXa+m+JD8eLA2HWYOf?=
 =?us-ascii?Q?taQgu6gIHFd0TFC9HKy5+J1hoh41AkKF3raES/nbAb4ygAhBGdWvPtgNeNCJ?=
 =?us-ascii?Q?rVZtKDpx1l5+R491CBPZLT0EkmotXccFvqaeWaGwaAESaQLWr+AkLPeESXVJ?=
 =?us-ascii?Q?3/jDlQuxNKS76d7cV8LAP+wIkHqD6bnEcO/WoLiwfQeMlz9eh0bfTcOsFkQT?=
 =?us-ascii?Q?dNOtatQLvrjo19qt1F61JuKUiCkkWyY3R+/qTnwej4qJWdv/kHYpVzcDnJSF?=
 =?us-ascii?Q?doGWOWtYAqyJcXp2kPxW8GVZ6hqtgL1pA3LFdFfEOhdtaATT4jaQATCxK04i?=
 =?us-ascii?Q?JHaSHKdIA0XS+MuvZdhpZ2xzHsNu9SEViRjW0+34fNACzk2gJW8KxXEJqXf6?=
 =?us-ascii?Q?BRM0kh9LQi+ubVzwgaN9O923CM605eLa9W8rJwI9ezlk6pAI47MqcbyLdzHe?=
 =?us-ascii?Q?U6lVCqPvAuJk1Hd4nlZ4hv40NmcN5gUjgWW6U6kzlXeCOnI4DOTCwfMBTRnH?=
 =?us-ascii?Q?oJU9XafJd1MjpMBHqV0VJpP55QWdduk4SGB1Zy9MzBrqi8EzZEfts3MqdhPm?=
 =?us-ascii?Q?2M3mNUADel1adHuhhsiGNkHEa9zkGOa8D176EZ0uyZCEBa6VDrMd8Xl1jG6k?=
 =?us-ascii?Q?FnBwFptn9O5v/XBZpjjozzUWrF50SsI45tfgZ9cJBCiAdzr5r9WromS4wPpZ?=
 =?us-ascii?Q?1ZgUAK5n14npSuvbd9OjOWM7sc+mQHOrPc8iUOJtvvYP8OErGg7W4E4onw05?=
 =?us-ascii?Q?YF+iNsSubc1aHbFQiJLG7BKJAu9CZzkXSTzk7mAWVOev1OqNwQ3E1NUOLaL+?=
 =?us-ascii?Q?6MUIisYhxYfbheAc1FAlCwyCmR4+MWlrXbBPpu9V+KCMiVuD3NMC03GXw61E?=
 =?us-ascii?Q?qSulJwQsGbY8hKnAbKkj7x9vXra6HPYC/xX+Qna/D51IZZAAlZoIBiC3nOx4?=
 =?us-ascii?Q?9EeLwNODgEXLNUUyCkzPwG4+ZKaCghkKSkuvDElaBFi3MQRY+AEjqNz51FRz?=
 =?us-ascii?Q?Iu6vHYMrStV5oIWghgYF5znW9y3hTK8DWh3QhIp+DRbzq0mbIXngpV290jNC?=
 =?us-ascii?Q?dNcuQdjQwANBXfOnJ1bW8Gq7H7B7fn2EeLIEa3+WhluTmC39swAZpPyjHQ3F?=
 =?us-ascii?Q?4EQBhwNSnCkGPpVdPKXW6TQtXeSeQT0Y8ervDxPhff1P5fDpT7ciqq5lGwZY?=
 =?us-ascii?Q?H8qeFKdCHKN9X5SQD/AGSkSZHynbSf2BPKRhouPEzs4DlFkYn96OY3jYgPlB?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +GoIZDkxvSy8wXUaR2gdwln+L7m9mklplfFaDp8zXAIx7hq+tVeSqjD0hGQhz4+lzYsev96WWaUKFbIqeJmtl4WpGUN/aVJsR4JQFU9fuL4tpEGdE8WH3GYY9uR+Oay78kB/ZqagRF2QU8w33lcvbw+MoqC+mbD2kxvLUhFxELdTCJT2+SLpeU2DLVMX4QlizFuyyDVqIsamDGMP/dLLDhRIDh+jdOMROOsbrdP+AiYkOyU2PnnXGRT4yyC1YAtSGy+R/rzCLIsE/T/vCTxu+mtvkNbN9WOgwuddm/4ZX9h33nXiHyoy59oE6XbhfuTHUNhbzXrHa8syjlX6v25bLRa0JEv8UTW3945Dj+P6K8CkJ6hoY8obzguyjT9OxjnDhE8LzHL5R5cC7Sq8rmyABiA5g1RzW1lyW837acl6doBYoOXLvCSFmr3gBJmwZdA4RBxdgbVu+Ol54Hpy65JhI/LrkKTNblrXNVWwbTBOH1SrNzBj4uRn+EwpdfaeAuWGUU2LHyKuswjk5Zrp6bzE7KokgBW/3EFcArT03T8QGQdXBUjgTvCQrQDOTapfua9j18u9fSF1JmlXv/BFvptDWfc5XLZzj8rsV/CPGp5MBe5R2z69ZYDVVqLbL8WTU5NJK4rhCYtIow/F/7L1w5gRtbJEWufL8pKmdfHb5Iiz3VnJkMdYIvN6Olb8+zJsKqk3bMsb/g3YrJbDud0KTdAFS8cRW5ry4EXKJxQ3VN/QA8EQJcRYlS1vR8MDbjtYEx29JpdJxVbiNnVRVECCXWfnsJg4IGQWQVXcc5KeybKWs5KFj4KCaP4z+gB70pdWuuNfzEP3WCADg5D8ObNOgofwbjOWFn5S/otJ9EnH+pbyT+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f9de51-a273-48b5-d925-08db239f4ce0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:30.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V7RLdfG/t+Q97FN2Sh+gb7EiOjXxBapVdhV5YSsJ9FI6pgL6nfa9acY+53bZQqsiPs/JhbGVLQKZOnv4OoGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-GUID: l0aqOz1-sYPi-MlXSGfLUOcIvDaqs4za
X-Proofpoint-ORIG-GUID: l0aqOz1-sYPi-MlXSGfLUOcIvDaqs4za
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI cmnd pointer arg would never be NULL, so drop the check. In
addition, its SCSI device pointer would never be NULL.

The only caller is scsi_send_eh_cmnd() -> scsi_abort_eh_cmnd() ->
scsi_try_to_abort_cmd() -> scsi_try_to_abort_cmd(), and in the origin of
that chain those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 4c60a055610a..2c2a41b99641 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5360,13 +5360,13 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 	bool ok;
 
 	++num_aborts;
-	if (SCpnt) {
-		ok = stop_queued_cmnd(SCpnt);
-		if (SCpnt->device && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
-			sdev_printk(KERN_INFO, SCpnt->device,
-				    "%s: command%s found\n", __func__,
-				    ok ? "" : " not");
-	}
+
+	ok = stop_queued_cmnd(SCpnt);
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, SCpnt->device,
+			    "%s: command%s found\n", __func__,
+			    ok ? "" : " not");
+
 	return SUCCESS;
 }
 
-- 
2.35.3

