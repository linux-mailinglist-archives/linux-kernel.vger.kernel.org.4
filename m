Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27936C63F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCWJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCWJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DF24713;
        Thu, 23 Mar 2023 02:46:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hsEn010794;
        Thu, 23 Mar 2023 09:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HfTBBoWYHz2kT7EBYRxC4bYLFSZHaaAwDiRoFHfzvVA=;
 b=z9PRxXvvGfcrQo3vgLB03+hC0FKv5Eu9UyJ0sJpiNqdcHVkWTWyd2idhHEl7zKsDzNqU
 TYNTqyL2vZdm6/3oiYiGjxcQ3E/6OPPjvrlv835Y452uoEk7ijvy6ATEmMbt1xNZSkNj
 hHrt1xMB/xdM5xDdn0U3ZsmNVD5ci1YkOXaSe/p3PVhM0+Gtya75U2Pd6PwH4TXChATW
 r6AS6h+SwsaVX5xq/ZdXZG8NUHsd3xPvOlAauW5uS9GkIgkmrBYwN5fAMDMUlyuN/0gW
 lG1Qv69+D/02JGIL4j7Z92BXBMfo2gaw4TX1dAKyiKRxXuhb8aPlxFVzSCqm52D6B5hP hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433u9hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiD006987;
        Thu, 23 Mar 2023 09:46:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRrq6WS6CMlTjaMIOdznYOd+uOI4n4zDYq1h6PraYm8FX3PcLPg1nKSxP6rphISYuGxyNvW1zZv1yqzYyrijp355SyiEZGVAV+aditF/+dBkgv6cJtAcOxLDXkJv9F/juhF/e0rere9iGHG5tL/BCeQLAJzT6jCF3FSA5ZgtlLIip9jW+I5kbEsTbKkwUvrnbZbWpCocy0kl5bUFPhLFP8Q/mbDfG1oDl+1sjba+9pLRqvrTLt0g1QHZl/y69m+RgRH/M6SlehckJcwSkbpviU2BWREHMt1WLlfg0A9qkcWdobnLQBaCESmyFXwP8h5tQfF59OoeWKBTxDceNMg3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfTBBoWYHz2kT7EBYRxC4bYLFSZHaaAwDiRoFHfzvVA=;
 b=U22ZCp3bGEShTElhlbYkkd53sFSyNyvve7scw1UV5NBiFvWlfe6/CzukHVEilwX6vcNBfJMKTv0cAQY9JPkcM8WFUp9UsutA86o+LugsSvZo22UdMWHTaYVTxgtFn2kCRa6BK3iXfW5NN68y/mnMdt5w9Oq4TUKOrQxkTnCFrVM0M/BUt91ALxt7+I0Vo8GF+/K5VwUNmltA7QKx/FJa64IA4Bf1qXZZJ8DQn7Q/7ATlTNdleicc/R38mAc7UXmPVHKjPknK+A3vzIRt0rGK8OzV9iC22G8cs/BlKdMVtj4XM5PEmQrjcfisZ+w+n8zppOIi9DbPLHO+F/QuAFsR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfTBBoWYHz2kT7EBYRxC4bYLFSZHaaAwDiRoFHfzvVA=;
 b=tkfEc7bon+Mzdk55mM11N7v9fdnHCPd4/1u9QcwGrm9Tpuhma9sIVuETbLmcCzzR6ebNu/N1wRjzW7miFYmbNUs7Lhb21xMNRHmUtGODPS+8YIv7YYkXzQ+MCon+xsVhc+4z79NvoJhQ+qSC1+jX1GuFTRb0NeaOo8BTW9KYDlE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:35 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/11] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in sdebug_blk_mq_poll()
Date:   Thu, 23 Mar 2023 09:45:51 +0000
Message-Id: <20230323094555.584624-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2168c3-95f4-4d98-0647-08db2b837cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2ohzUpCMqrC95/aX/WnHewORNguAk4rPPrKPxXwopU8retitbXGE3BnVkTgNVYZP0xCNmjJ4sqhVdDYoUMp9ZE4pWDkLke9upv+EjFs0xWLQfb19Xvy6XVD87qU7a+EVIrmwHfYj4t+CdgIMuauwkf57UmaAwDN4VdL/9+sBwi0lFVNizMkd8LojxtmJ0JZ058eLgJOyI7tffwTMZIftlxBIyIKLI01bkS/bM176Torf597UvgVWsRG+G+3QImTsC2EHaKJYIxcPJv2aeg/qIZNXWwgsgBuGXYKJSJwegCdUFfPGgv80yJivZaqFBWklUY6lQp9DlqJ26VORb2+zUa8PX3OVavu6v6N6Qs82RWEajoaRDDQa2Zka72V3So5SCnombg4v7eMI/jmrCE1Y3kyd2E9VAECyp7encpXcrsAPR66+Zm4MIhvXC4e9sgiAIirZb1PdZIWpFTMaO/PNm4lLLtIQPc1WYD3oiN+hcMaNKKHqn5PON9BrzOLYsjSAP363dCqlAQTVPMSbV1AUa/qw5yZCbFf13/UwgYOE6Evmfiw2rnu1GhZi34TePKQHZyrYvOwJdENKcbbfXgHXRoIdPzZt0pqDG/YNYqFBnv2G5kRrb2xSU0YVE5hYEPTO0Y6D0fPOOSw9KOOWT03PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5smE3f/AXF5eXU8ySbeW3nKHvi8f7Qa0KdpJ0aYPtKrHo3SQJcqC3R2wtxZY?=
 =?us-ascii?Q?jHjd8LDdw+9K2k4mMF2FMl/Ps+G2aTjPY/p6Kkw3aedX6edTie8ClRzNXF0G?=
 =?us-ascii?Q?2kzjII75IJNQSPjk+9wkvfPahlk6MMZbFvahr9C7GjIrP/hDLMKVFd2cff5x?=
 =?us-ascii?Q?1tGYPq4rWa5JuiwdtGrry7lDHblwVtNq50DmRudziQ73lq9P7upPYupjyxd6?=
 =?us-ascii?Q?V5vAINNdLpydeeE4z6YoEZI4aZp+DuAs7jMvUG8Ooa9PphBSpyiZzGrAb8VP?=
 =?us-ascii?Q?oKA+McTwCI7fXcL+c7saUdE+2vIY7fijySrd5wReY9eKEM7OAZ2swarWXgh9?=
 =?us-ascii?Q?oL3yUaUDbRA8ehK9BkqRRJrwx2xNEnr4oJ6hi5b83f0BXffupI8I7bGTUPiW?=
 =?us-ascii?Q?Z0htDx3lDY5uY/WFpUUXQpUUViQKuuHCA2ROX02CC+1hoxd5EEmr0OPRSYTA?=
 =?us-ascii?Q?oqtI2YrHvlj0PoZxusZRQEw/scWd9C6/p0ufK2lVfob47ozQoiLOaQFW2aSk?=
 =?us-ascii?Q?+SeiawsI3NSVLnoZClWF54kXXEdIR1Shk7DA0iIfWmEM9B/hiCZDH/yfxANc?=
 =?us-ascii?Q?2EHH7pQQq0vFdmkLFkTqVnWoXZo35mmYC+ae4/mkPEKktX3BTR0p3FCRgwv6?=
 =?us-ascii?Q?4abgqyscEzu5/FvjlxEW+KqVXibJHz1RqWBrInWDGZRd1bq3huTq1SUzXwnr?=
 =?us-ascii?Q?hc/swvs/v9Qoul0pmAXqCECk51e1C8XsT0x5fC6OnySn1mqkQ2+7grB5xcSH?=
 =?us-ascii?Q?CjttwfRTA/r6BN583IgX5Z61yxc6h+q3lP+gCeyrapkHIHxg+7I2hlx6hIR4?=
 =?us-ascii?Q?FJuAL9J50GJjV8UdqWld/zNwPUi+6F6svnyXwR2kUJgLXg5gnvo5Cfv36vji?=
 =?us-ascii?Q?aJiCQ5HnkwcFdPCGWdpgZM8YovyNOEH6MCfLw0QpbGzLbMENII2t+Sjme24m?=
 =?us-ascii?Q?q8bs/QRpVMJoFDJHdU/Z/gFNmWCkcG/6wwrE0ZVavkDQ3uoz+awlIuF1qc4f?=
 =?us-ascii?Q?QdRt80ieFZ6/psQZ2GMhXazd6A9LWQ7URKjfNa5ifgUuOhys4JbALoxAmPnn?=
 =?us-ascii?Q?P631fn6DgJyT2Ozew/5nvsK7xJr1txKc4w0oJ6bkVbMTdAj6vIyh0LyWRdC+?=
 =?us-ascii?Q?hEu5GK3ZEjhW0jSRc4GqHa2hqGqPOJJIa05kdZNI2TYAPlUiGYFwpbEffYl0?=
 =?us-ascii?Q?0vUbExsj/2aoRV0YrjYRsrDJP0BiRDY+dcSM8T39g7doONGVwrMz4FTNsGj/?=
 =?us-ascii?Q?+0eofmEwMHtIntHyLNL36WJvc5Jf6Syk+0JgdwZBPhx0idn2xjgjDZV5Whbb?=
 =?us-ascii?Q?EB5tk7sGQBLt3ZGp72Vt4B9uFrevHTEnh2pqVz4tVBDuN7A+gBEa13/yNPGh?=
 =?us-ascii?Q?h/90wEjnT9qc9isGRhkTric3F9Uy5aFoEH8gg5SRmARWS2uIAaeV1m3wax3E?=
 =?us-ascii?Q?38s7aO7rRddRODA1h4Cesp/YmmnNtDtX2xAg/flbnKLbfGrWD6zNZeDRG2R/?=
 =?us-ascii?Q?zkKeR32fcLTYAzfN7cjjNZphcMIYWeMn3R44t1U9ISNYqEik/3Ivs/hfY+pb?=
 =?us-ascii?Q?fWiIeM1VPszZzSDF1FyI31xnNLd0l9DIHmAC+jY2J/AJgEODbtxeGq/rgdWX?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3zdA92DltuIiQHdq28JWIAaqN0LImSwMsnryPJedIJGyip05q8d4QbNRiKMiJ+pyiYI9gPxAOB8S82i33CfmKgjJa7ArSUZDkQJyU48pbD7qJ91Cxg5EPHNtSia58JOLwy4nVPkzzGEu0SGx29lRk71TWwpPqVFyQ6xXH6JQ3qcrvSF0f2orBMXjdLNipvpQOr2lIaY1uSXpkLLuuCrbk2e21ynFeL2CsLraKt5IRzBYquZOG8SJ9WzOfsY5xGPI1H9fCCzpDmpbK+SYshXDWTpnvLxLdx+FdYZjKMo7lyBB58nO66ZCksryPGWBMiFemeWwz4hiF4PivLEdD7Icahbb3WUhevorfKTMMhs1M4Kjm6uNaYlz/wC7TeU96IYFRmWA4tzy4ClzlRlqSEwBtLDc66GuOiZB5Kb6+0WTyBkYRFh5D9gFFuyh8RZz+DsL/RYiTMANY8zz0arYbXemeqD1sw+7iqQ5F1xJno1CVtFo9GfIUV2ehRyRbKSLQaY3TzPpMt/J4wm7OZC4s2zAfKQ5ObQNI/M8l7FEY5jESBBfmanvSlJ23g1z2MTuKmslVGHfEYReH/5tCr89kqcXXakuJGKqvt91xw6N/BhaNOTM/1T986+PFOpGgITLLC3i06dDlgganl/TCIMwAaulkxdrHTdIHEdbGXcG6jv8/+p3Q4auc5tJ8Rzj8tNPtDY+rhGjv2hH3ScegPyh35J2+w3B6lOFs9Ue/G2pMUm9pANgvu76QhR2DTzR/US2ip/KcUQ3HWX3oEM0+Ke4oK4Flrq1Zc64vv4gV/0R97i6p+1pV2xNBFDHTjOZRCGYsFx+WU9mGnxUs1DpwUvVtsMULJSnz1A9VDLnH2XoiGOUKVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2168c3-95f4-4d98-0647-08db2b837cf0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:34.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6XoToCmXfgFwwUHjBPXMWPa3xVNMeOUmBNANZn4bjM0PmpWHaTwhhP50Ir+SpxlBMNfwJFIHJrNX963tflFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: mHb5BfZf9n-aOzpt8GguSYVVuyslwyca
X-Proofpoint-GUID: mHb5BfZf9n-aOzpt8GguSYVVuyslwyca
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating all deferred commands in the submission queue
structures, use blk_mq_tagset_busy_iter(), which is a standard API for
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 195 +++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 97 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6606e71cd0a9..627bc98c18ae 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7510,123 +7510,124 @@ static void sdebug_map_queues(struct Scsi_Host *shost)
 	}
 }
 
-static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
+struct sdebug_blk_mq_poll_data {
+	unsigned int queue_num;
+	int *num_entries;
+};
+
+/*
+ * We don't handle aborted commands here, but it does not seem possible to have
+ * aborted polled commands from schedule_resp()
+ */
+static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 {
-	bool first;
-	bool retiring = false;
-	int num_entries = 0;
-	unsigned int qc_idx = 0;
-	unsigned long iflags;
-	ktime_t kt_from_boot = ktime_get_boottime();
-	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct scsi_cmnd *scp;
+	struct sdebug_blk_mq_poll_data *data = opaque;
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmd);
 	struct sdebug_defer *sd_dp;
+	u32 unique_tag = blk_mq_unique_tag(rq);
+	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
+	struct sdebug_queued_cmd *sqcp;
+	struct sdebug_queue *sqp;
+	unsigned long flags;
+	int queue_num = data->queue_num;
+	bool retiring = false;
+	int qc_idx;
+	ktime_t time;
 
-	sqp = sdebug_q_arr + queue_num;
+	/* We're only interested in one queue for this iteration */
+	if (hwq != queue_num)
+		return true;
 
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
+	/* Subsequent checks would fail if this failed, but check anyway */
+	if (!test_bit(SCMD_STATE_INFLIGHT, &cmd->state))
+		return true;
 
-	qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (qc_idx >= sdebug_max_queue)
-		goto unlock;
+	time = ktime_get_boottime();
 
-	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
-		unsigned long flags;
-		struct sdebug_scsi_cmd *sdsc;
-		if (first) {
-			first = false;
-			if (!test_bit(qc_idx, sqp->in_use_bm))
-				continue;
-		} else {
-			qc_idx = find_next_bit(sqp->in_use_bm, sdebug_max_queue, qc_idx + 1);
-		}
-		if (qc_idx >= sdebug_max_queue)
-			break;
+	spin_lock_irqsave(&sdsc->lock, flags);
+	sqcp = TO_QEUEUED_CMD(cmd);
+	if (!sqcp) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 
-		sqcp = sqp->qc_arr[qc_idx];
-		if (!sqcp) {
-			pr_err("sqcp is NULL, queue_num=%d, qc_idx=%u from %s\n",
-			       queue_num, qc_idx, __func__);
-			break;
-		}
-		sd_dp = &sqcp->sd_dp;
+	sqp = sdebug_q_arr + queue_num;
+	sd_dp = &sqcp->sd_dp;
 
-		scp = sqcp->scmd;
-		if (unlikely(scp == NULL)) {
-			pr_err("scp is NULL, queue_num=%d, qc_idx=%u from %s\n",
-			       queue_num, qc_idx, __func__);
-			break;
-		}
-		sdsc = scsi_cmd_priv(scp);
-		spin_lock_irqsave(&sdsc->lock, flags);
-		if (READ_ONCE(sd_dp->defer_t) == SDEB_DEFER_POLL) {
-			struct sdebug_queued_cmd *_sqcp = TO_QEUEUED_CMD(scp);
-
-			if (_sqcp != sqcp) {
-				pr_err("inconsistent queued cmd tag=%#x\n",
-				       blk_mq_unique_tag(scsi_cmd_to_rq(scp)));
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				continue;
-			}
+	if (READ_ONCE(sd_dp->defer_t) != SDEB_DEFER_POLL) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 
-			if (kt_from_boot < sd_dp->cmpl_ts) {
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				continue;
-			}
+	if (time < sd_dp->cmpl_ts) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		return true;
+	}
 
-		} else		/* ignoring non REQ_POLLED requests */ {
-			spin_unlock_irqrestore(&sdsc->lock, flags);
-			continue;
-		}
-		if (unlikely(atomic_read(&retired_max_queue) > 0))
-			retiring = true;
+	if (unlikely(atomic_read(&retired_max_queue) > 0))
+		retiring = true;
 
-		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+	qc_idx = sd_dp->sqa_idx;
+	sqp->qc_arr[qc_idx] = NULL;
+	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
+		pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u\n",
+			sqp, queue_num, qc_idx);
+		sdebug_free_queued_cmd(sqcp);
+		return true;
+	}
+
+	if (unlikely(retiring)) {	/* user has reduced max_queue */
+		int k, retval = atomic_read(&retired_max_queue);
+
+		if (qc_idx >= retval) {
+			pr_err("index %d too large\n", retval);
 			spin_unlock_irqrestore(&sdsc->lock, flags);
-			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u from %s\n",
-				sqp, queue_num, qc_idx, __func__);
 			sdebug_free_queued_cmd(sqcp);
-			break;
-		}
-		sqp->qc_arr[qc_idx] = NULL;
-		if (unlikely(retiring)) {	/* user has reduced max_queue */
-			int k, retval;
-
-			retval = atomic_read(&retired_max_queue);
-			if (qc_idx >= retval) {
-				pr_err("index %d too large\n", retval);
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				sdebug_free_queued_cmd(sqcp);
-				break;
-			}
-			k = find_last_bit(sqp->in_use_bm, retval);
-			if ((k < sdebug_max_queue) || (k == retval))
-				atomic_set(&retired_max_queue, 0);
-			else
-				atomic_set(&retired_max_queue, k + 1);
+			return true;
 		}
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
-		if (sdebug_statistics) {
-			atomic_inc(&sdebug_completions);
-			if (raw_smp_processor_id() != sd_dp->issuing_cpu)
-				atomic_inc(&sdebug_miss_cpus);
-		}
+		k = find_last_bit(sqp->in_use_bm, retval);
+		if ((k < sdebug_max_queue) || (k == retval))
+			atomic_set(&retired_max_queue, 0);
+		else
+			atomic_set(&retired_max_queue, k + 1);
+	}
 
-		sdebug_free_queued_cmd(sqcp);
+	ASSIGN_QEUEUED_CMD(cmd, NULL);
+	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-		scsi_done(scp); /* callback to mid level */
-		num_entries++;
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		if (find_first_bit(sqp->in_use_bm, sdebug_max_queue) >= sdebug_max_queue)
-			break;
+	if (sdebug_statistics) {
+		atomic_inc(&sdebug_completions);
+		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
+			atomic_inc(&sdebug_miss_cpus);
 	}
 
-unlock:
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+	sdebug_free_queued_cmd(sqcp);
 
+	scsi_done(cmd); /* callback to mid level */
+	(*data->num_entries)++;
+	return true;
+}
+
+static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
+{
+	int num_entries = 0;
+	unsigned long iflags;
+	struct sdebug_queue *sqp;
+	struct sdebug_blk_mq_poll_data data = {
+		.queue_num = queue_num,
+		.num_entries = &num_entries,
+	};
+	sqp = sdebug_q_arr + queue_num;
+
+	spin_lock_irqsave(&sqp->qc_lock, iflags);
+
+	blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_blk_mq_poll_iter,
+				&data);
+
+	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (num_entries > 0)
 		atomic_add(num_entries, &sdeb_mq_poll_count);
 	return num_entries;
-- 
2.35.3

