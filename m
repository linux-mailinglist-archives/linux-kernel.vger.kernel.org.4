Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A06C63EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCWJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCWJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E5244B6;
        Thu, 23 Mar 2023 02:46:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hoNR019252;
        Thu, 23 Mar 2023 09:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=ZLEfu0aU5nRyIISajjzbq9HtR0f0nof4TqpHNrtk6AxbZn+Yz922SMar8toz6Z5yA7LL
 8aldaGHFmo24ZWA1Pad/Y59Jmj/Ksb7p145UN7S22L4bpxOKX58tqcDPo+2XAZLecvme
 kLMSLupyf+uTFv8nWtSdVSD0Wvz4UH4K7p9t6b2dLOrbVCb9oj8BCwjDvpxiMTNiK6wa
 XQZRjLoLBMfTmKMQQXdit+BdDFU7+R/aBJMNFcUb1+Ly6AdWJ8YvILPvcBAgs3Y+T1Ip
 t+aQlOvgQ+gXcrwjeV3wZOXHW+MkNbGW8QjbIjg/a1IZejOnoXWVkOR449FWCFPd1c1t 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bckbpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiB006987;
        Thu, 23 Mar 2023 09:46:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIicn96HZJgYzqtC+UnF67Vo25gWI+s5GuvJys279HF7oNeVK+czhF/X3z/kAlVz0q9JLTkxSQSXqsRYQKfuczuQeLgASlcSwSWtna02FTlWb7O9KX0scAiOYLSslIVk1KjGLUKdFiwSoaPsMO9p59V2XFt7C19NfzFwI1MNjp72TEElnZ9jBpkBGnIal7IG3Y1QnQ6uFC01J0MJTJiaR9L7mhZhINE4C3wfYYd/dzrqziQSgbUNXTejA02uEIknPbVT8/PvIa4Ld8g9uL7Ska6nRaCxQHGhqhO5DtcO6na+SquJj0udMkxUPe0Pu26/LkTAhRZSCSC4ngYG9svWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=buVX/vQ85lApIrSdUj26eFtuz0J6S1otHUOZYG15r0mpI8i4u2OSqnUEs3FVAfKNEBCB8od17Zcfv32sXmNVlkwHI7xW+K2VdtVc1iC4lWFMqBHRzq65TJi0VjxmSUix/CXPqlwgoe+6Yb5SqCsjlD9U/Il6t8ShlJtVnGGNT4Dvx/B0dbNNuFTvzbtFDIXCv4AAxfv/3NZvcNnfgd44fcNUdsg0+0Kykp+bkcTDGe94bkfx82foCuV2a4LQ6XNGu6LIqMbF7amqGPCp77YcQlF2h2HSVJmJarnEkZ6YPWCbSsLCyEG80c92Wt5gz/5RPhfybUgNsBz5EvTdNjkmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=drociXgot2iypFeJbtd0TAapcl98sqvXjljHspQHzmxTUBiHM6+proAoCwDDxQ8JhJCM8T5iNdUHkfh39KAeRYbH7KDCZSINS8CeAKOD0zMcDo77YhcDb5wJOgEc4etaZlfnctZxOHFmMoDaMj5mgwxEA8+/5ZtD5A4UbKy2Hck=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:19 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/11] scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
Date:   Thu, 23 Mar 2023 09:45:48 +0000
Message-Id: <20230323094555.584624-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4547d2db-dd60-4754-734e-08db2b8373ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bi4q1vi8Jw9ZryzDEp68RU+9mhG8leO8/G6UprtoF/xO6K1ea9Shh0RVFhLPoiJHIeuZBYNp5YtZiatB4+b9Yszx3YOlALRRp4abYYBfj2U3RziXGXDDS0UhOVZFufSogaMd45WP90AERmeqXjCGSylxhAU5Wt4Sw3cUkmjA3WZ+5kKWPX/6g0SjjjWd5lDwK3DG9smq2fxSFDLrWbGWC49DoNxFHZPHrizGb0PxYv50CsVNZBfO7qglWj3SjG3hP5oUa3F46yN3ht7mB2an9C1FPYE+IX6AHRce552Za7olgqnUP7nQFRiAt53jmPXL7GyauqU5aJP4voq5b2HsebVdgk2OIAwXJUsgvxdz9jTlt4PYV3LyVSfYP/fqbkt/n6fXT5f0TNA1lUjC6PJwTqtALIGaYc6w/369+kXi13xZtyMbVoR9MLF3UE7m/q9i+pFTG4nQ4ibST+i9O3oT3rlxexk+uYQoW8jQx0Q4+I1F9dSFjPi2oapWLDYjOotC5kLLWIZXpW7A9Gg6evte83g/ezrAdCNqcCiC3qiu3kKMKcueSXGH7815alR9QGaNEnnYVyTXusp5AEDhvWvywd9oTLlDVQPV0+HpJiTI+u9KTLEqFUH5xeGfLmx281lUPSJNCsFwN1f8ER1xUzTDsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fd9aQldii12fZskf+Elbp5fT+ChopAAtcp1ovOk0si977CC6wmtROja4PZmZ?=
 =?us-ascii?Q?KXj53L4e9IVX9iQgPyUyoeYgbIMLW6NXUMGMPsN+b+c2PoYSuc1c8UIvWFCi?=
 =?us-ascii?Q?qtzGfsquBrWKoPURfcBlES23WU21HMTfYG9yXp3irmArd7N9wOUbs9EUJot5?=
 =?us-ascii?Q?k/+XXmrS9IEiz7J5daSDhvUNXkTjw5ju9RomhIVmC2xZ8QjaRBnnKAfU8RsU?=
 =?us-ascii?Q?XLszKsEVmoxOy14BQd8D5lD4m1BTPmO3Lrdy8OJjwntN9kgxki4YvkxuZwj1?=
 =?us-ascii?Q?pGC/VEZVXSLyCri0i7bwdvP3WKl5QMeubC3/t6qq5Q5HlzhPduqIdCfkks/P?=
 =?us-ascii?Q?7wQ2TneoSpNyL6fHup/nr2H3rY3e2754P6EWIcb+ev1C3dgzgr/+8Qf0/JJF?=
 =?us-ascii?Q?AvUUSpBXrd2yDk4PN4WosB1ulwCKy4W07AoxBTzlpN+H4GJztbz3E0GslPoU?=
 =?us-ascii?Q?gDVVk4zlZ4oyPZZVD0qeLPxshpd1P5+ZSdR6sLNTgfBjpf0/adBdGrFn8pwv?=
 =?us-ascii?Q?Dd+7kf35FdMcy+dP4g0kRBCUqhkDCUsDa6qCqiaB5sYSaCkfx/xh6h56SrBZ?=
 =?us-ascii?Q?lYcbZft0UYrPNHLfjRzQk3GLaQx+XfeBdgpIuFWPQUqbB42iMdk7UnYANFFI?=
 =?us-ascii?Q?oFpYdf28EgW45BTePrgvo9HOBjoTVJDalwY1F2PTzowjOI4Kn/P1UlSxI/PM?=
 =?us-ascii?Q?3dKvkmwv50dvAMi+vdyeu1Q8jTE53ezWsrJgOzqU6rtSBbt1LpeCi4InBmHW?=
 =?us-ascii?Q?9WlbfSXI5w3suV6Gmpl/Yw5e03dL5BTUuMwg6X8u9i1FxcrWjCgchLpxVDJO?=
 =?us-ascii?Q?ueGrFuysedrb1MR4mzwyMo8gNSR3P12MRO2HnUjYwyPIZ+ltc0grBsqrX3l3?=
 =?us-ascii?Q?6s/xWB2YZNE/hjuDna9rLSp/8955qeZN+yv6zkEVAEsXh3N72S1IPNkKLVuZ?=
 =?us-ascii?Q?pyKHzaxhL2lbwR/6E0ZTLjloWumz373N2faC/FmHNZlxUZHbE8XpC6AQ7Sc7?=
 =?us-ascii?Q?hD8QAMeDVOQ3CkNVZDCAi/1cR77JDCzMIystYn32vP55FXdcty5/+3TUyKi/?=
 =?us-ascii?Q?cIp5vg+Bpla+0zlI+tzuWoRsss9xuZr/kxYCizktrbo/69ZXjyCltYlikAHT?=
 =?us-ascii?Q?Z1sV1wFD7CiSmzdQP3V8DQrhk1jiSEe4wvir85IuFYBy64vb4pdQUV2yYfPg?=
 =?us-ascii?Q?VEy4oAV6RzRMbYLdusZyy/3QmkRvs5jLYp3FIpFbVOjjpAY/nSjVdTx6UCAv?=
 =?us-ascii?Q?PoBjxM4ZCy7BANTDxQzSNNe0wiI1PVyGl3fbZnunib3i9vS+Chx6T2VPJP7G?=
 =?us-ascii?Q?bQXDxKiqYPOUWiSjcoKL1KWeNntvS4BOf7hY7piZz7B/76fkmQj4grJYptdY?=
 =?us-ascii?Q?9jZHE5KFb4oWSzKUjp/2DpRZiMcCCqY+UBMjz+GWofvtqnKJbQEjC+tx+15A?=
 =?us-ascii?Q?DOahZF+MS3rfD8E0+8sqWg4I1AYOCg14jbUtACAa1KwvXHfP0acprtspviBJ?=
 =?us-ascii?Q?qyD7XqZ4dsWLgjLMPYXuCP9eDCfmiqSQfrEFFdjLUsby6gS8GfmXpFkt2vEI?=
 =?us-ascii?Q?b7xVHxZUdFFE51d4OWfMwYLtT4D0Wy4NfxVv/CsoVuHaD03qq2jdaHf8cnYj?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fMDNF8ASjeaJrwersL24AlI1ng92/vqcKOaNp1FSgCz/4NQw8jrio9EPD8vzBLTdtLUCb7u1mlKW1jf3PUKw3y36EzWKUhnzxI67RwUanRj4QcLmGDTebyDLNyF/Omzmjo44dvPBiMXkC9/GRbbgMwmWouUJISrWEg6nujhFMtzA/NslRCzyS4H4rRAgBaesPaJLbS8/OwS+LYA3iOfKfh4KbZimUS5OSawEFqAAnCv9bKRsjAP30QeIs3rYO6W5wN6bxZfQFbmZnN9pY7YMKutyAdyEFPdZ58jxzai2oAkJYIdiU6n58K8d3TJ7jYm3ayK/qkK/HrM3KlMTUL6o13Q7f0FctNS8u6RjTBO06COu0sGVUW+yhdevX+/Q9uR4VcTaJSKTD7bsIfId5IhYKPoxJgiPx8KG+ktl50L06QA/NH2f1qrt6X68znSKh1xm8TFRNVV4rt7/E2xjDkBTEn3FY366yImMvpg+ZWYuBJv2QoMdWhP/dvbqR7mqx0zxEw9XcAwM4PHB/uiWuhIlNCJZ4jVqF/15N0kiRCBFql2LFmNBVvFOFUFeqHWvtTesA42fa/PKyQrLCBHSH8b2VXDwsqXPb8WHOMwYAY/Ii7+OsPBTr8pCp/s7bcG71yqaJtWHAAdf8Z0oaE2FYTpBSHHsfFlmPcz2uuwGUwFSP18/T4fL6/C525jObklHLXlICgzu1ihum5txR775IJm73omnv7uhpVXqbxSuLnpt1W5Wen4z7SnZt83UxxJcTU1SDwkdv5qJhjIUu0gFz4JEKhT45/NI46nG1PwGhGV5ybiwZ5RkSLSpEbFdVrddrDD35cjNnf4+x4GW40dYj8zBbmAd/cNtvaQUwjT5zZTlMNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4547d2db-dd60-4754-734e-08db2b8373ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:18.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GpVY/S5RaPMerr6SFBcNtnhWq3AJUUzmBcV3vN6Q20fwik5+ahs/rzwftbGkXBNSK/KTWnmURldT+dcOGnNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: 7QhtkHXvG-_ohpPUear8TdYOo29lRViS
X-Proofpoint-GUID: 7QhtkHXvG-_ohpPUear8TdYOo29lRViS
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index a61e7c31dab5..cd05e2f87417 100644
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

