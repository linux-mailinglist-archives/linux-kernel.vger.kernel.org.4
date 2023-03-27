Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1FB6C9C91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjC0HoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjC0Hnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C31BF2;
        Mon, 27 Mar 2023 00:43:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7Z9eT021879;
        Mon, 27 Mar 2023 07:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=v03kwAFn/JEZS4DGsIXLF2axqDwUz/MEVUF0vTQO60lmKm4dOXBfyNPuGNNtypwcxqK1
 1/j04H3UwrrrefVgHnP9EjJWOB6WcL3kM6A2cv32uHFFKoZehCJ6B/8Z6J5kjZLOR869
 GEdzdEHjRaTxuaJ2WURf3hn/YtjNcn7YiXMV36SuLX1e1vELTClrlaqC0ro2l51ZY7v4
 tHYvS69OS4G766yi8gy6No5ie7rGFU2SjPVCGCivptMHw35f+jh6xDwxqkV7Bn9nMxKq
 qT1vnnUCvlzqRk9vCOk/YcsDtofh78Kn86MN+oRK2LqpoIgW9LUNyYnaQU6e+blWgqi4 rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R7CWk8005330;
        Mon, 27 Mar 2023 07:43:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4d584-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcNBhSrZ4EFUrQ9kZjowk9VG8BD1xx5Bc4WAZPlzNdn5zgRViUGkF8367TGt0UrZzvuZABuxARyZSiB7C3J+beo2SVr4uw8MI0k3WzkWerpJRUTwO9rlonWXIRnKXDAdraNknOqR/cTlcjnSrINjMgFYps9g4aABc7S5tGVes9ngjGcK0WIzBAmIFHPqkmOWPmfFTqNm7gnommUcSUUvM32G5tYO+TwIxdWjCL9UVLuTyDEegEeaiGZS2LGrT3z07AmNGyuGrrgxbJmz+TpogBoDUod0lNZDQOu1Hkz9k37CdbvDJqDSJYjWC53jT4lDy2wtltD1tnZEe47KZP+lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=obUZ0WmlRJBggYBmZnQrsWV2rg2yhysLyRE7bQVc3ABVj8mow4ed0IKm7jAKTNpDLEmB+MS6VZRd9lu5nDXrPszfr/sOGFRsh/oyT8vakMJFAKZWurS8AUw3btc5D8JjeU8FXQg5LL9Y9Peo4QGQts2GNQaPwcOqWZnvxxfG0fCmm71MYgXJZfxk+6JNLfxwjNzECNoqMNXNeWxiQMtidqr6d3E6/ZRNM++9WMtncmUJVbJ3QYwW7wTAvP9ONynj2i/jN6TL8fz3KxDyh6OGIlBEYVUXkdeFwCizHFSkZqhQdrB7yAxWsl/CHQdkoX0IC8sLJIDrech6jcRbcYwIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=CYhMG+JWrJMh+jmlOLL4gGkxWij1AAYyHnt5/vBsW7QUAI4aB1DbEf1Ikwc+EL9r/+bbwi+6HXLGfUkiXTbVayUUT9x7WWXEfsI3hB38VMSSt9pClAk1moUD+PjFNoHuBhvZYw6fYP/p4A5fsuU38o6pO7ARrHTg7LMylWEKt4E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:23 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/11] scsi: scsi_debug: Change shost list lock to a mutex
Date:   Mon, 27 Mar 2023 07:43:02 +0000
Message-Id: <20230327074310.1862889-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: d866a630-dc76-4b09-ecb5-08db2e96f127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZykfMe42X3l2gJM4L4L9IInkKni9eQdZi6qfyCk48Yq6+1nuvMly6i6HrkfHZUIgWd/7wTrrezQ0xnxjLlQVubzel8c1PhnXr+hTuRDs3jJ65YqsUB/pox1I9pLZoUid6wnCXeiX+i1LbcpDNQ1J783EfejbenhCL21LG84bYlwMEpbJywXNdCFP6dNq1sUYg27O3wfWfH3a+bMq/DqVrYZleMqqe4BhyOREdoAibTWUgC/e9HG/uacBEiboZFXiIv0hPRPSo/+CDFI08ec8D9PnGxGua03XN0MJKH6gCHrQ7uVxjzmspYpXtKEyZF8lb4dqH4aRGmOTBhilrdqih2F48ztAhpEuxx3608iKSN6wHog4xLWKMwaCUtX5UZ5LRtph//XrFlsE7vM2B17JFirhNBC0nIDTUCLxtwfQGa51rotiwmyydDUmkp8EGuL3tS8icawbyEEIbIVEj2mF/UvlVkISw7JOV/mk77k2mJ1KcO9k0qxwasIDj0u4yoUxMZy5yrJqr7k8yd1lhj1QCA8d2Nz7EmHGnuzOza3pKn7aaoao6tVKWYsRaa8s8Yg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mj0BeX4b1UBcdW+jDiQBH0jVbXtiBH6jV3XsU70pRLV9XWYg/Arj4+c3kGMD?=
 =?us-ascii?Q?nGmbQrbOrXnvWzqwHOFitLumEfNbS3/5lSkt9Xx2soiWAzjnmUzwz6P7oV7V?=
 =?us-ascii?Q?mvax7pO6vW3rNUpRTkY/OPWrxY+4mUoaZ3P0zAmsM6q9v8yztcFLL0BIQgUk?=
 =?us-ascii?Q?fWVgNPtM5OqNO97S0pMpYY3/sF1jZZnYHfBHb4WsSk10vSKqjGpX+bfB81sj?=
 =?us-ascii?Q?uVzuQLOzg9v/5nBGmxbNDqR46FxytnYy8n5M6SHGX8o1enikK0EP/pM4luba?=
 =?us-ascii?Q?S7SSxd9VxzSCq5wJdBMJ1+gz7AtYC9fwbVJ/l6QW/AKXGtHhNvpNUuTErHT+?=
 =?us-ascii?Q?vLJYkTSjejeQqCBlWEtN0gnFqAdEvRvm2ZygGbuG60FAWkUVEHAmsK1+TIzO?=
 =?us-ascii?Q?/Ii2A/iiC4It0MF7s3TDBRvip+aBmprqbFg2m38CjtXCrkzmJcu3dubXKOR6?=
 =?us-ascii?Q?8yZlqojHn9WkNhlsJ5A1BYHT1PHK2GcPL0WDsbymsDkAZPR4RCe1By7updJ9?=
 =?us-ascii?Q?tr07u2Kl43h5gNY0FZSfzvqklnXvDJemKFfboCmngD3B/KPybjwA3evU2vFc?=
 =?us-ascii?Q?XSHQwJbh328an/9jZGsbQSa1QoENAv7aEELFYXXvmqggUqr+R32Ulm/EoQsS?=
 =?us-ascii?Q?aXulBmDY76ELMmYGt6mgYf1Zf75L5bUV+qq37/GL6kABmpDDOCY+5Lp9xtJY?=
 =?us-ascii?Q?Vf2lg46S8+Ebgi+p5pYaY6rD9pvZbBxWIyOhR+2bXox4PVPF1cLu7UxjpaHC?=
 =?us-ascii?Q?4tMjFfpmBEOjNVWs4hXdQuI+eyikS96Et9m3PU/QcLaLvSbI0ljkAz6jFRR7?=
 =?us-ascii?Q?hI85jswFxCexDmT4X1ucqokg1kxGvWwO/JkGTMkSxbdlbTgB3/aLlSfqy9Iu?=
 =?us-ascii?Q?DGL6f8i8jn937FBSiC9tYA0glkzP8euaFUZ8JmrcINeruslYZdSg1ixRYYb3?=
 =?us-ascii?Q?mE19z3XoB89NxImaK/JWF6sRprCeDRhBMK+Sq+P60Kqa03HYcTCBUB3T7ybX?=
 =?us-ascii?Q?0RABHdUHsj7azIAOTLbsLX6GadvTxrwN22QERDO7/qsUviXFuFNmvUDSBTwM?=
 =?us-ascii?Q?rIDlS4oeoEwI0IMxQF4fxeZLgApV1yFOCYg1cbLTDjWbY1tVjB6CQdc9dGE2?=
 =?us-ascii?Q?MiRc3irxboQbIljzRU5t2TreEVBBoSOJ0cZMd+je6bBnG6gcp6fDose1/lge?=
 =?us-ascii?Q?bOu7t3fEi0iY3lbzwrTSRIABxR5E0byBJa+qp9n2qmCmI4A+ypx4nmRfmCW6?=
 =?us-ascii?Q?ZaablfvL4WQN5xrFKsAkXZYNTH64nVlaJmdlLBQXW7/fNYcaoUyj7rTOIPO+?=
 =?us-ascii?Q?hT9+9j+t4VphPjatBAKlVnev+1AY1ndpVx73wpuylHOCU0nRO8KfnEazgcKu?=
 =?us-ascii?Q?mws8o1w/PI5QfNh+OQjAUChrotI3G/lm9PKie1RBah4mgR7OeIt1jH3P01ZZ?=
 =?us-ascii?Q?5svZPzk1cDA+q7h6I3c9kbJ9F0cXXH1SHQYlVqVhV7dClRF7TdecbBO8qtpa?=
 =?us-ascii?Q?+gNolbqh0GFG/L/ekWs5pQMvRms0RgUMhiywJfAARc2nGR4u19Hl6J+fItVM?=
 =?us-ascii?Q?kmkqI91FBfb8Oz+LThl4KtsLKLRlubovry8DMxaStdt8SsJHdYwKz/0ToKcM?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R/GyxkWWOfkAvGl2qhfj+YWC6TR9PskH9N/WTm5kdwNjGcH5NwdE5jkawdidQTzXJN6Y65/q0TDAV7/7qvz4awZ6z6O8BfBpEnVITgorm/LLCxj4Htd+ET2otcpNwxOeSuWutNFzO6x7SpH52cspathndbzhE256/VKyP0eF+TTCCcGnXottMW/zVWIrHUoKdeokTtVdqP6QT+w53J/b82x3IZx2EXzFdqXJFUn1mJfrhHAEoZgViPuGUhpAG4ydfFaA3fa+U0XhXqSGkmkiqM9j85yk9pUw5JtGDHc45lclVYO2XdLo4yhacLtwKv4dYLsJgdubasPYW0OCrr2kFIsPlGBtIBtE9lYsjC5UL96keWlA4waTd7sRYmO5OEiKqWvj0KLZXCDxKkfJo6G0Al0lvIhtB55yMX+6gVrEs4o/4zgZJJb/mA75C7e3gJh12OjsAUSBjpTKjRvHzlbaF9wZMM7gfym45TCHndtvMrSPQuvkCvNFcyLWxo0P+0fREJ4FVwHq4F03Jfb/5zF9S60y2GBhSlJ1fRb0v80SayRXiKQdSOsgRY6D96vFVdHxnxC6Q/MeXUa9l9RlToWtdpAndfbmjAyHLZHlRWWIxJkbNc07IH49CS3VJTB+Ayq1JTfA4tT83sxrlo2ZVWgSDGEVtiPts7CwjShEjwaG/yZH732pCy24KqKfMIUOwLSzJxOlqqGHWyNm96hLCpx2k7aaoX0f+Z5hKRV2WNh/Ex8OEDZ6IF88VhuAPKfQYd25AsiJgO8iSye8d0XKHF8DAuaxhz5PZzpuKEixtESaXoeWObJmCtFdoJT9p0iDNxjIgh6loWxyN33+Y3kAgIR4/7tOoxuYglfWP0uj2oly60w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d866a630-dc76-4b09-ecb5-08db2e96f127
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:22.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEluDJzxJ3IktHFiycdc+lYBBoke0B6QfwKpWDbRyaraKRdSEHmRN+BSDBvZyUy0m+ygHTwTFzx/ilUNXfUgXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: Rnz-g2SpsPBbKVlyNjHEynAihCyFNoza
X-Proofpoint-GUID: Rnz-g2SpsPBbKVlyNjHEynAihCyFNoza
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shost list lock, sdebug_host_list_lock, is a spinlock. We would only
lock in non-atomic context in this driver, so use a mutex instead, which
is friendlier if we need to schedule when iterating.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index eba6eca81e84..a61e7c31dab5 100644
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

