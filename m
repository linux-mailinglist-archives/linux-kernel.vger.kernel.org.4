Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93086C9C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjC0HoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjC0Hny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E551B8;
        Mon, 27 Mar 2023 00:43:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7UXro011933;
        Mon, 27 Mar 2023 07:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nsbdq0bx0WgEt87oVe9t/Q1PgHe29PlR8uZ5X9lCgRA=;
 b=zayWh/9AePrkurYg7Kuy0w5q7cJJAFvXpBF3l5ST6+jcjbnw3nc7bbMrr8DStsSwD8xz
 ob+0kbOWQhSOE/WP7Fr7WwWC+nG1AL1aQ75vHMBdArpXALzxdUMt2jUrfBNTWCiQyGrX
 Q0ieTruYFgd0L+xbo9xlwtYiCqI9K27VzOcuvTJEOb31465dnbqgrE5/ZipPBCC/K/W1
 +/IPJfy+DkTBc9dGvjjYZDxiJ2a3qxzpeqZ4jxv6/ICDWbbMA2AqC6qyU5F3akG/67V6
 +WVmlWtUAlimFnLpdqbABobPbAem6f7xnIE6KdeHa6NnGi8pKeDX3gDK52fvkF2VnVWk QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R7XUfS020313;
        Mon, 27 Mar 2023 07:43:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4mwa6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htHUiUk+LzT6Xb0KDSx8BdWn4n6UFXwv5f+euxK0/zScIQHdaaYEt+EIu0v8UV7vjGz4Pla2/lFew1hE+djicshwfZZtLs2Fd91T3HWygPsXzY/Gq5lnN5LfqsCwgGinodgsXmkWDIq8nXK7maKgn/jPM6uZVAr3OspCbRstWsuNA10ZpXjbJSyUD7L1NIUQIdFFxeImaDhPj9hiaLjGznC3lhtDLJa6v8yEn4YE045Gc9JkoHXCYUUEkgzr8Ur9w0UMrV1jAKsZDOdlYc8oeMnN63m2BJnzDFo6Zc7ZHshkVK3WMbA9BDLeeYYzI1oyNf33UT9L/9UNLvxdl6DQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsbdq0bx0WgEt87oVe9t/Q1PgHe29PlR8uZ5X9lCgRA=;
 b=IGKmSEnkjDeehEYzVA0fRhe6qZb29jzAJCxFrBIgB9ZtXFH9/qKBWOrb3l1VhuaXVRSHmJpVdcwRLwjUgNBYTrIYzKTXQ0VOFzXDhpjuL1uiEyd99AUVWd1AQyYHgHaKHH6O8WXCWI1DYuLKjxqqjAoqbzeaWAMzvgR0WIPgbvJFH8er9epUjUs8Mg8dXQDKzxxJ1WTsoaFySKY5mDbtIdy1HALMOoH7pZOhDl0TIf7VAvJZ4RBFhZdCuXJaFKSsjXSaz1aKYQAFBA2NVwth4xOkaeTkSMgQWtUD5UUT2IWkcuDDMm123nkJK60JMwB5Tj1uzyxRMZsOr33UohOiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsbdq0bx0WgEt87oVe9t/Q1PgHe29PlR8uZ5X9lCgRA=;
 b=WpndySI60htgAELQSNLlwoLySH3D7S2oBRhG3mqrlU2fifaj/vEmxnbDWwJF/pJAVtXZTxd6eoxkKbUGSev2P1TxuqJczNszH+J70I9EOFjET03F5j+X6fqzxceqQugS4ztOkaltVbAK2pInZBvYhERgo/XL+N/p4XwHJr5iqaU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:28 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/11] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in sdebug_blk_mq_poll()
Date:   Mon, 27 Mar 2023 07:43:06 +0000
Message-Id: <20230327074310.1862889-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c67c3fd-87e1-4b2b-182f-08db2e96f4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l8ifFRG+90hDI5Ck4K1eMxbELgqv5azMKNtMeQzFNG21wdxk+BbMUNkj11Ywux9zdz4dsfIJy4MclJDFeiYkol0+mDm/RvRqsEiXcnTZcKfqg8fceDyjeLuncC52dhe/Xicv6V5Uv50mMe1tBH0ufjZZcrpf79DHavkz2SqhreotEHvdsfYJheX+b2Q3aBmiv3j0r3a1aRW3jHJtyzMXDz3j/dESHvH/l3Cqqmg9PDck8s3A+rCp6G4Tid6iftTk3knJJqrJc1Upw5NIe4orIXtGYhKTO36Jerdfy+6eZfUnezLsZGIGhjjqPh80IPN8OpqU3kdkhgWeLkMQ/DAPgLEI8P5f2pyqOYPCJJe9m7qaj8SnyvDSUGqxiwlR4xjXF2N1VRqVcavmj556e9vgsuCl/ZZ/lZOwhIw8EAS3KQgl8BtCleB4TXPZMy66jr5Qh5jZMS72nD/yugUUA4OHdIokZyA3H+IMrlVXeeaBoPbqX4V51ks7qQWhTQlPfBvTjZQqy/iQoicpQqo0KiVxLeg7MYIh96qqE0lTbHJzVByY86CFAso1GJi2/JnVo7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7M8P1NIniIfaeWgo/4hCLhNM0XLSp4pKk+QARQYj3rW5aclLw6z1/ERMlOrH?=
 =?us-ascii?Q?RDAQNWLib5dxUo9v60mSD+kmlErc2IZfc7e3Es5CKZnxOclqgeUd0u1PNICy?=
 =?us-ascii?Q?Y2FKGAKix8r9ew+Jkwn/ACUmKxtMzHp8nonLsnD5flBtmFEbwb2v6CLqIeu5?=
 =?us-ascii?Q?SLmwxVlD+TwGQuRo66IGD2DlehzqV0hqAR/YWJgRPAjrWWonN9r38RkkPPKp?=
 =?us-ascii?Q?Ue29wvTkaBbdRyD0xbtdGK2HrcaPqPoWshjZ99HeivEFEor5WVpzu9+IPV22?=
 =?us-ascii?Q?psNTj7eGypWr/V6VHBTlZui9rEHYlD+DIciumHup5FSWbkAAIK7DWX1LenL8?=
 =?us-ascii?Q?UVQYQtsD17ZnB5IIscVSYlC4bTMk7PbXPe/ojfOCkHn8qQzrCFxZL+oSzvje?=
 =?us-ascii?Q?WBblvbrfYclvEprwyQAV6l/t9S/7SttNFxPvsbgHcf8RimveuJBedpV/NGvk?=
 =?us-ascii?Q?8lDmlkAe/AxUai1c0Fmod6ykJeadyIKQqzKCCiQXhBb6M3Myfvo5+RxnYdeQ?=
 =?us-ascii?Q?hxSrQzFAPbRfSNLuKJr3TI9QfH5KaCU5WmoEFl+ZxwD1UmzILRI4YYyh7svn?=
 =?us-ascii?Q?AI73JX9NsfvHvNobkHN6h9k4ILDUVKvG42MsEpJbvG68XigJu0TnbzyoOBE9?=
 =?us-ascii?Q?WLxMRmOU0HBgLYy0FUNI/GyDENnBmJPmcYIjppR290w+e9E/9hilmMS3Yg8C?=
 =?us-ascii?Q?oHQYozYDmqca2JX6nuVx/czcTODjM/59EEy9ouYbxOpZyPdioxSUnIL5jx0F?=
 =?us-ascii?Q?vWPElX30cCHZ3wJ1GdLVlsqNcF5o/b6zb+Dl2tUx+AwMH9sbzaGTTi0X14JC?=
 =?us-ascii?Q?xx04MkZbl0J18TduDSALQ0eL9/NWN1BNpqhriZEdNtQKArkg6ZXtD8BDh5c/?=
 =?us-ascii?Q?4IDgLwenXuRO4zyYw0RvmaspJcfRFYYgWy20x6DWHvruWbD5bu8zpX/LkoE0?=
 =?us-ascii?Q?ucZFHHWIhiUrU6A/DxZTtLT+sn2NAcqeF8iKpgQHQATgqSFQrSwv4tm91IYQ?=
 =?us-ascii?Q?90RtqQIU+xp5DL8YWKI5kMaAshOuLz5rPaThL6+vLyx72rEOvad/C7MEgdDu?=
 =?us-ascii?Q?qb1jdpMtGaA28LCO0W/taMxrajQCiStcFFvHeYsKkZJhe/JBfkovFbEddVDX?=
 =?us-ascii?Q?GyVF9NSbeJdPp2+m7wf2Sv3kouM4QL1HteqAEfn28le9Syc7NGI/bhxSiXYv?=
 =?us-ascii?Q?VhW7FwZNL0JxgCTtyuvkV9mmHAZ82bR89TxngxtEV5Ip0Yz4Up8VEMiO04eX?=
 =?us-ascii?Q?PUnZ8rzY8NSQT9s83XnwtmFmN6nFa0NYEE2Dkrihl9UC6yf1y851ENdWkyri?=
 =?us-ascii?Q?EwDBhMzqc5TImnzL5BAOaBUD0ZvgvqiHo1o1AOQIfCNi/s5+Pliv95vPCjTj?=
 =?us-ascii?Q?RFvv4nAmwCQHf8iqPNhFceptYyEI4vL76jCII1P9GPksw9IWRv6q34JGperM?=
 =?us-ascii?Q?1GtAeQGaad2cNmdgtOBYg4dLhs/N1JrxegZ+CnyDUek/o4TsWvrOvJkqmSP4?=
 =?us-ascii?Q?3cWKB8E2PJuwiL784oS+YKCmbk7QFwFScxl6zCejPiDAr5gM4/W8lakLIuTY?=
 =?us-ascii?Q?krTnVqWA87mPbvs0jirwfcAEyDZqOTSlK2RMjUh0EDUYn3XXiTiO/e9XLi+Y?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qO5jgZ3NcODGlrX63BXrH+Rf9aRk1jWr787BGNsCR9QtNJaEOH5Xw0efVeG1gC6o+gte+BDiiswx7AbODttrvGOeiNZ/5IamDLJdmuwjosXNPrrZWWkOMcArECTj+T01CBewFEPe01Qv3KJHAK2QVD+wX9XL64oEuWDbDJpj2PmsGR7J7vWGiJAqgPUKEjwJf+47ub9ULBPCvfKEwUykp6yF5AfGbCRRO/gglTFpW5sa7XuorUbQY1UusI1GV/bteEZipx1Sgodl6urMjtPLtDihTqLiFcZeiEFf12fV6IjaxQVX02RZL675Y1TumPuzPcWCJFeRwQnk3x+n/SDi3eMs4SgqFO0H1uVYq/ymJuNgsRdHA+rrFyoABmY4t13omywE9fwVNatOkjpNYywyRrX0u2l+4FsJtVw/BHPs4AfZBKcnVQXk0YdYhMw0wVerywLnP8CkgnsInQKHgUtjQ83/HiLpust2933Q4F7oprMbjiDyMaKOkHw7B3naNf7l/1rU0wAaOe9xF0UmvCn0Rt/rNslaTRUMxyUMRAG4U6Ph9TIDnNyDb9li85EHruWchQ6o3ZQ4zMToa4GO0DWlGTmjMeT572lTAg7yEl1wPhfB+LsiIxRAVPbd98lpYUdZBpeidhs+uLoib3hSghssdAKKEMER1+TTFkOckDEnjAeyijHnPrlu1QsOq+k3jT7jtgSK7KpJXik9HwR3fsYfaZKSltrCMk3JhQ2mEPyn888yH7yu/afqJ8UbwFiiY4sRhcoEsarlbrL5UX9OI/qaVVyAH0r+S60DPkHX99P+PwrVXjQDsk56OHp4X/nLclHn4as6e/DS2Ju6VivtSeLECZy8bKq4bXroGyZ5NpniWbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c67c3fd-87e1-4b2b-182f-08db2e96f4a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:28.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWg7ZSs8tGo49/81wfK1Bc/G6TP4tw8VfHssmeNeL0YuE8iv/EkBvBVELtjeS6NgfWyh2jlTsrFq4ov3ohyjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-GUID: QsS17e_DSMsJNMvtjtLqNdO_waK3lzdk
X-Proofpoint-ORIG-GUID: QsS17e_DSMsJNMvtjtLqNdO_waK3lzdk
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
index 7dd2dd6cbd6c..3330848f13cc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7511,123 +7511,124 @@ static void sdebug_map_queues(struct Scsi_Host *shost)
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

