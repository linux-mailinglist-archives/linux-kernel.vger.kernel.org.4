Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227E6B7177
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCMIrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCMIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:46:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247E4FA9C;
        Mon, 13 Mar 2023 01:45:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNs1kb029642;
        Mon, 13 Mar 2023 08:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=26rGXgIJXd3NPR1eXA8mbNVNmg3HXE5Z7WYqE69dFytBuRstziiH+/svbDyhRCC0l4+k
 fU3RBiXJebJImOp0X9io5mbD7oHCqdijAoDi4O+bKnT356hwR44Dv2Bq/njdCMv7TFkU
 /xnMe4rfFQgndXcmiDwK36vMhc6MWATimXKi5aDhg+iU6n/vqr5GYMOV/xu1pfwQgAYP
 UNA7qX3OSTm+KQZRine4GDx+zzgDv9zGAcaTB36lTGInDo0Coc8CifXpC6Y6PVb1nLQe
 S3v2LWHLQgdbzGD1KAPdBAd3NxzhQYYrgjTOEQ7vzPRIEiEVakod7mA5HVUe5T0UEMb1 jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g2dk9h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6qLeA008167;
        Mon, 13 Mar 2023 08:45:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b40ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFBobgykvfExvtTFiTOQFSTZWkVl4Nhdmb+lXb1tCw8te0xo/gd9hLmF53coGujyhG59NDmH3byoEYGnvqQFeKHRL+tHcEU46Gc6IvP+EgyJX3SwDMCU/gFqyo0MjRyhpJGRBgDzuiMye0KbBfrW//YciC5rcBd59kN6Gbqau16UlbGYQHViG9QNGfwykr77v5p6C4lZWkKuO33HSjMTl9wHRPO0pmlhEctBzBEaNs+jMzJtQnNgUeLULxWD7AemD4r7nbExvnN/0brgeH8VFmosDaRNM30Q2Rx/e9yFot2armVkH2RMGz//tCyBcFULCpHzfhvgHy/v+6HOr5Zong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=R1ZOYzdjBnlM2PI/3JNz5oS0O1iRXFikrtIwTQUjSVstALU8ZdGta243WVwSr9Cg1R16xSY8yzSXtYD1sLk28e+EMVXTyDP2/vipiMV7Ih3+AyEXpekNUof4Y27PXRUtjxjaGMvzqJXwORqis3PYV4WvkhfDB0myeJ/+Ygl46DidiIE5XtSPvsS67gFp2sTTrvvQIsvI77qowoPO8cTErZeCVIdtogITpWzLDcje30rLnPAA2f+CT4KLs2kI/7RE2Fsd/u6kpgxyzEyuQ0308ETbtRTha7r4nQaEyOCXGvBPp28zNgeAKv00H3n2FjZURKBV8VV8p2qu4/nH1DEJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=zzoCHqF+MRnn4JBAadTx8ph/hrJ2pDDRTphf/Q3MB3kClakFsVVMDWJiY0wkmD7xYTXW6RRbYjsFcJ4QqVyfeeCxQu6bWSQqMxPZsDGUl5+Ih1h8O8fRAcishOJV36+7Mvyo019ib1AvLKYFSByGvmSQGyozlBfnHrjZaLnyZqU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:41 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/11] scsi: scsi_debug: Add poll mode deferred completions to statistics
Date:   Mon, 13 Mar 2023 08:45:05 +0000
Message-Id: <20230313084505.1487337-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:23a::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c94330-84ca-4ab7-e252-08db239f5371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMoBSzkFDbgjeBQKG/eEDPG8jQ98UpPjLddqdWYRTXW7QCyDhWMHMZpM/Eih1Jq+xIltFL/PhGEO6cubUHXf6ZXnSKl5qs4Dra8KDrpyFn5Tk8nzIWRXMQ/iK4Epo5c4wjg7i2f2CzQ0Cmz5QivBhk72HzgsnQjc6Dupz1GDHe3oTiSlvtu8em2/QAXd4XPtwZvjHdz2+cFqz+jtaSVrAd497RbKm/L2iylFNZ/mFgavVgXv8zwzzQCJaYCQXJozPScRr0ZtTXHEjB4iMfzArKcOwH44JG1ZBlNEYZZ4cD5ScgzfKdKG1BNU4Bp5UpblFke/I5Mqu+ClPLjXWabCotyhV2MvxRcEAFtAl+2v0/MQM/fwkTOONVxirfqnCAurrajuPlyql5ljhGlFae7vzn2r5tKVIOngmGTUUgxtrU/cy9vKWuDMqb/so06UbFdA6DeHT1iyK9C03c5fkxWb2r4qSotJblhd0rpAuy5TfkuTXWlpZrAejRv54uX8Dzk5cWhkyddXl9WA6DL5DiFm6A+ck3HlGSWyV8oLQi6DrtXN7wiHeeSrUIvIZ8O6yCFQxBcc5EEuRPQEVmi+CYGPiRB4Gptg+4TWuq30gVIrrUnGFBmrnD5RT6dM5cQn9AP8tkX+g6qCuCp3S5UUvcn2cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KsdeJ6JNLPUiM+vqvqgjx0c4QS4RHkf/cVVy8/KovxyFBeaIV8EFu7gKSkmU?=
 =?us-ascii?Q?EzgRerwMcxY+MQwwCKU5i03TOJNSSwMYGp66gLuVYltSPjKle4+3R+RqSIwS?=
 =?us-ascii?Q?G8ylVYvlb8H9VRmIg8Sxeoykboi5YYYVNFiRus/jFs5Eoggi54QtGRT4qqvD?=
 =?us-ascii?Q?D+wC9ns+v6aY0RbdZAg+19CuFjeB3Q9wALFwiQzKpk0q1PTAdvlYlQXxQfb8?=
 =?us-ascii?Q?MPpO6TDqq8ciYdcH4GpP9jLS4PfZlI1vDLsGv++CvWM9XleXRvW07wjQUD4b?=
 =?us-ascii?Q?67PbZsCQHDMJp8mWZeHfS1RsEmjFNJWybCYi0HkIc9WgOtB48Q3QBZyi5Gdz?=
 =?us-ascii?Q?wCs8meZAUBGxtPr6YNE8QZXBeD3PGzBcgMo0f0zowUSeC5TncTX8V0lzwTTq?=
 =?us-ascii?Q?P5Vq7AAtUbobO7SD+ZON7AfUkBizg/3Qqd8Ym42NBb9V8gg2xoJqczIMqZ5c?=
 =?us-ascii?Q?aijXO+XVWfE6RU9AGFLrtbxX7poCxAskFkb1JkYWPg6/nAjV/YpDbTd683bR?=
 =?us-ascii?Q?Ft/95cOxYdUJ4sN18QCNEhVrGXDmo7sIE/FerekbNPsHULFtaCmBKGCDuvP0?=
 =?us-ascii?Q?7go0wpVLPLBWcG6zw7Embt1+I2JA4BIk8nPsDLOtI+gwb5/McX4KE+lfXT0t?=
 =?us-ascii?Q?Ae801uP3uL4xF0ExNHjy1+HQWNRF09bdnAVcqwddoB0ccXGwAaTaShRTKQYx?=
 =?us-ascii?Q?NTDem2IqZIETSGoSmDbtRr598D+ICLHFQIJ84gN4xmwT6B1A+FdWNN9qADU8?=
 =?us-ascii?Q?YQzh4lZPgUB3XHoHaDhD4jgfcknblyRuCLRwJkVLA1UCeJ+laeW4uWWInPBY?=
 =?us-ascii?Q?zT8a6gzSKWZ5tnnnJW/GtCjuw5W249Y/jzt6KQk89jZ0NZQ9JL4P6BZwOhYp?=
 =?us-ascii?Q?jBNpjT6nAD5YX60PryRqj7gzBLTnhXRbik0oPRA+Y8c5IMCfdTCDiZBtCEgk?=
 =?us-ascii?Q?LzOVf8kae+6gAg5vXw9EC2VWnHFMgxo/hSqLJMlCF3zXnsDBSeiyiu2BNCGQ?=
 =?us-ascii?Q?yCyAuFkqdyn0xUeIt73EAFGKTm8mOGmWpj11xIAzq/lDJJydLuiwwxIKOtTW?=
 =?us-ascii?Q?eL8s1T6jcv7ijp2RLVdnHqnu6HtGt6r1En8Cl+A45ce4lu4ELgvAQ0nhCuov?=
 =?us-ascii?Q?zNxHS94tgCPJfhZIPUxHgnGfFFMFOPQodJ89E3661eHehJYATEca1LKeyXOR?=
 =?us-ascii?Q?R/STpK6TXCAO6NjlAgb+yK5YcAn4n0STVpNDg9+nkQEH+gPz7RCd5jrKmryr?=
 =?us-ascii?Q?CKsSXvSrrYdTMlWVuojB3XQH9dX6rMPD90NvZ+P0RVhQu8ZxMb27nYOyjY//?=
 =?us-ascii?Q?pQKeUI4lOI11jpcQSLRF6VpdL1z0RgWu+j/hU/nlWJ+RyKy2vnkco1Sj+NMb?=
 =?us-ascii?Q?9/RAKaWk4PPVYwCGrVCekmT+mD61hV+m98mdW5xlWvuwHGs52GVqXWfUjkzX?=
 =?us-ascii?Q?mk1ldjtEaQQplT4EK49tdLGowvtrCdhI0VybRgSlTSe6pgQVdG55pfoQWtnS?=
 =?us-ascii?Q?r87DbZ1m8pAuzhbLEZEnOdoeCVrtBDxa4xOPXPO+yHWEdFdt+OzZdyy6mD99?=
 =?us-ascii?Q?otgk8gFHhIxM3VX3jPX2shAvMH6A2Y0T/HZIKdQZUdK6mfBGezukLqgNm7L7?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tWB4o/3ieU4+Jy6yipQMqKePI1lHK3Mq/v1it1QaQfNEqq+8Aw7tbKyYpmt6S5454IcBKc+zzmqgXsW/F23QGowVf08dP7iAJuwTHYAi+1QslBfy41/5/Q/wSRPiQVmBzDjyxnHttqCUhiLmttkFxmj9+k0gztzOmAYslhrzvmuBF9F57DYaFMBJC6keqGHfnT0AYrMWnc7aFwADgpma1jXTfI7fQRRtDnxHCjDkArhwJrmDZDXXqjQ0ush6MOEubn72ZgZ5VJ7lMUy+XuvV9iGvUGFF6PC8AXomN5PPddHVnm6ftBtW/yIURLEeYorjxROENVG3rsx467qpBaftYPLs0aDQrP1+g0LFLPG0erzKYEqKSOWmDPc8468MmBYY8HmKkWJY2UXbx7qC2XNR4V4LhF9UDqWzPQbPviZRgTtSsw6ZEW7piEkid2cd4x3uYFHPVYRK0Irz16OGllgrDX/txXR1aQ5V7d4jOo/bHCaXGkYLO3UqyHho7+2ecS1FSdDNP4F3SUDc1ciWrcsKoNo0ORN5EX+wgfqYc2Qrhe2qoVrMDB4QD7Z4KIgV5akSeNGfi9Da5BcthqCiBqAUS7QUwc6ygXvNWmoMbDgnHGZm11LRgHiQ6bgooYSfzj2LSS+geH7rSc3cFx92bbi8NXQlEir7epduHKKqgTuBsparlKNDCUNkCnj5mlP2n9ba6exxNeVgRw/Zga+zpwDstUACZk1jrb+wPCv8F9+84WF9+fFPe0VN/qjbUnkiDVbgNMoYtc6Ru0F08JcVnp9qzQ+nId5eBCqlB84PNRM/VXZJ9+tjCL6dwrHRPtnH1kJ9QGqmFh9/PG9TJlE37DYd8EPuDb3ixxQWVrnXHDePLSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c94330-84ca-4ab7-e252-08db239f5371
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:41.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxrl/grSJ97Cvd9QkwfZWQn8IcPnQ9GfNDbK+EcpRdHCrczAYrflZzY8JqsNztT7qMT3BOaAhrhzhW/tqFJ7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-GUID: XuDan-Ux_XKbNY9uY49hEaVuO7KOG6mD
X-Proofpoint-ORIG-GUID: XuDan-Ux_XKbNY9uY49hEaVuO7KOG6mD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently commands completed via poll mode are not included in the
statistics gathering for deferred completions and missed CPUs.

Poll mode completions should be treated the same as other deferred
completion types, so add poll mode completions to the statistics.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1463e54179bf..073fc02f9fed 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7531,6 +7531,13 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		}
 		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+
+		if (sdebug_statistics) {
+			atomic_inc(&sdebug_completions);
+			if (raw_smp_processor_id() != sd_dp->issuing_cpu)
+				atomic_inc(&sdebug_miss_cpus);
+		}
+
 		scsi_done(scp); /* callback to mid level */
 		num_entries++;
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
-- 
2.35.3

