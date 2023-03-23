Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349F16C6400
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCWJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCWJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F724713;
        Thu, 23 Mar 2023 02:46:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i64B005171;
        Thu, 23 Mar 2023 09:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=csfUpvnydue3c06Gn5zRcv10idpsejsfMA3qvVv5VuA=;
 b=JF864nGsQYEheehAf5jiFRlTA51IiJcy80n1ehI2/XVxWvftEauZ8oOo9RKuLkc2qBDS
 V+KhnEyFh1ki7yFFxMK16SbiHetZCeLOg+bgPJsn/rmUApp5E0FR3fuVihFW8cQ/f7L2
 Yps5Tq3gY/B7lw9hrtWFYLzajC8xWbJXLIkakMtSgrkToi0EzbhHQ9j/M59xmOENJ3Cc
 Of9sbZa8s5ar6B1qX7rFYXO9X+u2Nct6Nc1s3LMt9l9bkAeQ8SihVI49JJ/D861Eb3Z+
 ASaWFcIq0QpyHOo5jT7dfaZaxNzdBmf1AdInS0JlVYUe8atiDja2Sv5vMjYhsygZjvmb kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdu3yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiF006987;
        Thu, 23 Mar 2023 09:46:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGsCgnSwrZA/gbqGKXNXB56zurH60jyeO9gVuTx/Jn030UlW4hHADfisGhx9o+40EV5MCn3WLl71bGQtV8CltgaadTOMmJj6Ca5hvIFRjczztAwFzS0L0MJ1mRvh9q/iDfgafJJezeFNDyQmquqhCfc0H7yXbh07FFbNbJNQoSGfmT9A/uHsWmODo8f9wtLNgvhaYMIXuuNUcngYhwPAt35NLhEeciI6bSA5NdwdGa2vN6NFBQrp29I4M8yql0Fgt2GY4vMEKcAPvd3hqiZ818G28s0QmhPLYcoe+tReYvrLV123Orf6RcAY9AgvKKpv/xU3f70oB5d5DlGhqjWeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csfUpvnydue3c06Gn5zRcv10idpsejsfMA3qvVv5VuA=;
 b=abppMY43BUR8ow4n5d65L+gYGl0rDLu6u12Nhu2/PTTn+K3lJUGOfLJInMKdVB8RLorBkQMWwL5/eRWihjU0bDSUksRjW0MlizzR/RfD5uvleyQlV7GNMbmMyAMecR3tBCuvdHmGxh8ImgCPegxqy2St8OJPI6BA6Zb+9A1+r+4Fvq4nhri+57O+lw+9KF2VmkWpDDTc4QbtoHgLep03bSgkNPDCS3WF9ulsKKFzsARVySlzik7Z6x16IWo4Ye4UmVBbDLWLEWa76rnxk7ajjl1AQ7100M+41Genc2MYnOWFcdk6KSqvIUBOwBtvufb71KWGHHXZ3jV2zy6Bz71PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csfUpvnydue3c06Gn5zRcv10idpsejsfMA3qvVv5VuA=;
 b=ajGpBkq2ltGyBY8+rLgVo9uE0vjw9JSoK8xUs/NMgQH0YGZy8/6GPrSeBekouut0ybas6p3i4zprNNW1DpcXvoo7SYGZNM5L5ESXUSNXJJLPY1CSS662RsT0QMlNDauT8vhkoqk7fsi7KW4Lx3Q/h4qbyjP1N6egGx2uyzftIUE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
Date:   Thu, 23 Mar 2023 09:45:50 +0000
Message-Id: <20230323094555.584624-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 44de09be-26ff-442a-9adc-08db2b8379df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Har4RembVgmSXYd7HohqFOQt/TJV9h/xIr3IhOSDieEkvqiYPkJVKNaNcJW5uqPUEOnGtli7cL8Ad62WWqw4ROinCa4qkQ7phW9uD03pYFkEKQQ6R1bgWvZj1w6QGsvhCNrWaaCJ18hhk4zseyAft/BhCeh/MOZWyHtCLC1QSrnNKpDpOxizpyULn4lT9pvgPN82prUslPB4bu6N34IYN92SzQ5PqDjwC25bP/9vkOcwmPgcxPkROQyvNQI6nuYrq9UU4uumwtGxCjViFUIXSfy8sWDVyO6H7qutRJ4GwP3Gs6OS10/1IqQZ2AVbg2heY454undN3Hz5vOstkbfalzGKJrN9Ov2k6PiaoZDpsJJb8+EalR1MHCKuT+vIT3ZMh3isz0vMp5hvcg9WueS9ObFl51s2bdw/OfQJlY/4OqLbhFG3LFm7tqyTbL9auKTzb8KBHKSSrS3pMsYRz+SL+8K14Ojn+GsiM+Ga6BN28bRHKtRck2SmuchR2wRAridm8sdZuuvwIwC3EDkW4sdYfUp+luQxGAnUhwT+CBnGONy7/6QI/EHQLLxa0G7KV9DWtmNtL51tQTg01NQbYppGUY1JIDtnpQ23wHr/qqS8uX59v12OOQGl5tPqwu3K8nQC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(66899018)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(30864003)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zg9svyiH5IkW7kH5xxDh03MRaINZuP7pMthEoV5VUMJCpL1ghBf2LUzBwa34?=
 =?us-ascii?Q?enkBjscOReI5CU9M5hMwjQiyxojd8L5QygN2j0GTqz3zJEzhxkB6J2f15IUB?=
 =?us-ascii?Q?QFC1YZ/WRlRNddgKpELkIcYMXBMLGWo9voeO9Oolhui/he5l7lcTXgIWpBEP?=
 =?us-ascii?Q?WDo8d43zF3UGx8poxiuzviIhXenaqxo5pO9ND7V0jMkoxtTBf1e8CFaoOBGP?=
 =?us-ascii?Q?hVgIzscxw3m5BnN5zdanJwb8xzPmNcETwNrSiCs69u3cBhyW/P9CrAs4se4j?=
 =?us-ascii?Q?mzzvH4mfa6fMZVtG+f88mHmldn2KCwNtYrGpu489qV3j+kj0rl6dUbjPAS/Z?=
 =?us-ascii?Q?IPANMPRvwU6+LJlbJnF96Yh8Wy0x9qYYNoRZeoSY10vE7moKuv823XsTVUy2?=
 =?us-ascii?Q?+fOYJ92CcqbZFbJWwloDzJGr4vnGPKvQ7z1A0D8iEzlAnPluMMGUA7wTxHmY?=
 =?us-ascii?Q?burshqSP67MCAW3xXTavYLejul9BUW/60YsqzYmmgdBB3UuSc3To4HUkeZXr?=
 =?us-ascii?Q?vrQlT5Ng2rJr8ZQShoHa7h5WGe0mGgz7A7PS2mWNSWLbErDn3topLeJua59b?=
 =?us-ascii?Q?+Hlv5suvvInVvHlVqSsWtI9lcGX7CnB4YQhKOMbRUFDwFZ8W6bzcB0IrMoNu?=
 =?us-ascii?Q?mcNBSI9OdNirvKNRttIrr3EhWO4elllI3Pq80Q1h79ds+swTX5JRqTjNdLXm?=
 =?us-ascii?Q?+rD4NK/UUDqnSh0H0POo0PnZRzUiXpDx9zG5PcTT4nNmnOubdJ3HYRJJxkPv?=
 =?us-ascii?Q?BrJ7k34fY8iN9SR3enNnn/uI59aChLcfuOT+B0b1huxC0VumkfTJbKoBLP8x?=
 =?us-ascii?Q?zcs9aiZTVLsAQ8FFf+QtdIDSbaDXHmymtkbipIoLEmCd66Jf72iDomiKs2ri?=
 =?us-ascii?Q?7E0toD5epZQnp2H5FYkDlxWyJk5jzeA8zGnDD/62/CcJB5pM6T9KWHXQLMR/?=
 =?us-ascii?Q?79MfKU9zdhKpbRU/Fykmg/EHNL6nWpbPStWBi7qJaXSsUnCrV8JZaecaoqE1?=
 =?us-ascii?Q?S84hQf8E6J51hQj07EDcu0ONFK6a75NnuzfwnnPEHrXcyX5OKxM4HwWLPBt6?=
 =?us-ascii?Q?qAk/eSLF1LIloIp+aQXTfiVHJSXRiErj3ns2l9WUioP2UUcFK6qE8hcRqg9O?=
 =?us-ascii?Q?P4kg0rTQ0L7l8uOJC1fsmQcz91uTAhwHUgD91SGc+FSfNELd3q1xdsgxLW7Y?=
 =?us-ascii?Q?5B4xe87/TyBLSpadTWkur0RBRmHU0G0rH2uGPNQMV37hGtjGB7dPCj/5Xyo8?=
 =?us-ascii?Q?KxEYpOFDAwijh1dUQgiQBYi4ka2F+MEeF8S12nRrJvNZIE+vF/69+G4cCvVK?=
 =?us-ascii?Q?VT+VOmD/HCeLExJrZSOurGtSrmp4kmXSqH8ISevBZK56DLeqTVdPEVMHFh+A?=
 =?us-ascii?Q?XmuNr6lB49nm7nSZirwzy2gorFeGz3gz1Qo1wfq5Em8X3VfbPuD6tTQyD6hg?=
 =?us-ascii?Q?yg2Q6aoLuiDlVcJnJlinY3Eb7DKmZBvhIbWV4k6ZYstUXFIHuW0i0bpAwT9l?=
 =?us-ascii?Q?DiKZ6+tQRfFczcdPGddVB4qWosHl7sxirQq163/KdhmZdoln1MVk5YF4uclM?=
 =?us-ascii?Q?WdSEI8FT/RV96G9zSeSs4U8p7pp/evL87DIQ8VzX10k4DD7LaqdpaQy9EBw9?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fFtiPIakjYutDjtAkYXsKGO3+XaWs3Fgu36JVaVmU2tBdnrCAu59BGGJKIV+IUX0UgPlzktEOGc4V9kMtx8aSunoAhbPOQUbNs3TpICuQ5NKntr8gZ0AlUpfcLUZAkyikfJR2JKya9cm8DyKf5dzTSxxDyywdK7aP4ZQI4QcO6AiWj0qTcJ/cXkke0V4g61rU1dAljpKmiqDN9QU6mqN97MArtW2s/qQMSgwu3IZImoAzPo/0UYGlnQrFJRnVxtF+wEWlWwTguqpmVjQhfXyj5qXUewIOC90qNElUyw/Oy+muvthjjUAmTE01aJvWbtu1tcqgnQV/m0P1W5BtAVOz2xWtlaDDNtxt+cqczLzy607ziBqBGZ0ceoeO/eX6i+AxPWSM55Q1Zq4Tk9ATs7aexzxgXsNmmmgLpI1nlNG32A+GWFL1ALzFmY/SLX80Hi/WU43U/X3xdduqIiFz4VZxNJTCRfOOHxxibJELZ7gs0wKLHJM7181OG1aGjK65I9J3dGXgr2065DBU/I5+FOcagfCtu3ABIGPUaOx3mEeB3QCs6gp9L3UEwG1oJ4jhSm6u7aqRIJ1mle7zwpb2vy8ELDUk5E+kYJ8/1pJr9OMNUR4eB7TE1hRO7ExMPMiThOFhCMCSMb7mSyI9PZbtKoOBXE/5cFdd01sXgdsp9YQ9znA2dKJHHnaZ7XEBmih0gbUjwUZb94u/4WwSjQRL4TVKnAicdfPZ8zSsP68vKqdks27G642Wnp4cGV4iQ2+hU7ReLXp3/VkhjO4GUBdIM4xIr5lue89hgBinZr1EUQUOS602wiiI6qoE8zTinqsEIEwquL4WIO86TB/py1b6RsJ2N+01FxvaKsUjK1ZarWQ14k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44de09be-26ff-442a-9adc-08db2b8379df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:29.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6lWuSoV00sIXC4cvQjIky0YZw8eq9Stxg1k0dKllNrl8uItkRNvP7XzYbAZvHnjzE1Z7Z/LZXgiKkWhQ8B8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-GUID: 0SPmGYgqHW_V3uvCUuv47JwPdD-tYmSy
X-Proofpoint-ORIG-GUID: 0SPmGYgqHW_V3uvCUuv47JwPdD-tYmSy
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventually we will drop the sdebug_queue struct as it is not really
required, so start with making the sdebug_queued_cmd dynamically allocated
for the lifetime of the scsi_cmnd in the driver.

As an interim measure, make sdebug_queued_cmd.sd_dp a pointer to struct
sdebug_defer. Also keep a value of the index allocated in
sdebug_queued_cmd.qc_arr in struct sdebug_queued_cmd.

To deal with an races in accessing the scsi cmnd allocated struct
sdebug_queued_cmd, add a spinlock for the scsi command in its priv area.
Races may be between scheduling a command for completion, aborting a
command, and the command actually completing and freeing the struct
sdebug_queued_cmd.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 426 ++++++++++++++++++++++----------------
 1 file changed, 252 insertions(+), 174 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index f53f3e78aaa1..6606e71cd0a9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -250,6 +250,11 @@ static const char *sdebug_version_date = "20210520";
 
 #define SDEB_XA_NOT_IN_USE XA_MARK_1
 
+static struct kmem_cache *queued_cmd_cache;
+
+#define TO_QEUEUED_CMD(scmd)  ((void *)(scmd)->host_scribble)
+#define ASSIGN_QEUEUED_CMD(scmnd, qc) { (scmnd)->host_scribble = (void *) qc; }
+
 /* Zone types (zbcr05 table 25) */
 enum sdebug_z_type {
 	ZBC_ZTYPE_CNV	= 0x1,
@@ -337,12 +342,8 @@ struct sdebug_defer {
 	struct execute_work ew;
 	ktime_t cmpl_ts;/* time since boot to complete this cmd */
 	int sqa_idx;	/* index of sdebug_queue array */
-	int qc_idx;	/* index of sdebug_queued_cmd array within sqa_idx */
 	int hc_idx;	/* hostwide tag index */
 	int issuing_cpu;
-	bool init_hrt;
-	bool init_wq;
-	bool init_poll;
 	bool aborted;	/* true when blk_abort_request() already called */
 	enum sdeb_defer_type defer_t;
 };
@@ -351,12 +352,16 @@ struct sdebug_queued_cmd {
 	/* corresponding bit set in in_use_bm[] in owning struct sdebug_queue
 	 * instance indicates this slot is in use.
 	 */
-	struct sdebug_defer *sd_dp;
-	struct scsi_cmnd *a_cmnd;
+	struct sdebug_defer sd_dp;
+	struct scsi_cmnd *scmd;
+};
+
+struct sdebug_scsi_cmd {
+	spinlock_t   lock;
 };
 
 struct sdebug_queue {
-	struct sdebug_queued_cmd qc_arr[SDEBUG_CANQUEUE];
+	struct sdebug_queued_cmd *qc_arr[SDEBUG_CANQUEUE];
 	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
 	spinlock_t qc_lock;
 };
@@ -508,6 +513,8 @@ static int sdebug_add_store(void);
 static void sdebug_erase_store(int idx, struct sdeb_store_info *sip);
 static void sdebug_erase_all_stores(bool apart_from_first);
 
+static void sdebug_free_queued_cmd(struct sdebug_queued_cmd *sqcp);
+
 /*
  * The following are overflow arrays for cdbs that "hit" the same index in
  * the opcode_info_arr array. The most time sensitive (or commonly used) cdb
@@ -4919,46 +4926,48 @@ static u32 get_tag(struct scsi_cmnd *cmnd)
 /* Queued (deferred) command completions converge here. */
 static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
-	bool aborted = sd_dp->aborted;
+	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
 	int qc_idx;
 	int retiring = 0;
-	unsigned long iflags;
+	unsigned long flags, iflags;
+	struct scsi_cmnd *scp = sqcp->scmd;
+	struct sdebug_scsi_cmd *sdsc;
+	bool aborted;
 	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct scsi_cmnd *scp;
 
-	if (unlikely(aborted))
-		sd_dp->aborted = false;
-	qc_idx = sd_dp->qc_idx;
-	sqp = sdebug_q_arr + sd_dp->sqa_idx;
+	qc_idx = sd_dp->sqa_idx;
 	if (sdebug_statistics) {
 		atomic_inc(&sdebug_completions);
 		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
 			atomic_inc(&sdebug_miss_cpus);
 	}
+	if (!scp) {
+		pr_err("scmd=NULL\n");
+		goto out;
+	}
 	if (unlikely((qc_idx < 0) || (qc_idx >= SDEBUG_CANQUEUE))) {
 		pr_err("wild qc_idx=%d\n", qc_idx);
-		return;
+		goto out;
 	}
+
+	sdsc = scsi_cmd_priv(scp);
+	sqp = get_queue(scp);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
-	WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-	sqcp = &sqp->qc_arr[qc_idx];
-	scp = sqcp->a_cmnd;
-	if (unlikely(scp == NULL)) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("scp is NULL, sqa_idx=%d, qc_idx=%d, hc_idx=%d\n",
-		       sd_dp->sqa_idx, qc_idx, sd_dp->hc_idx);
-		return;
-	}
+	spin_lock_irqsave(&sdsc->lock, flags);
+	aborted = sd_dp->aborted;
+	if (unlikely(aborted))
+		sd_dp->aborted = false;
+	ASSIGN_QEUEUED_CMD(scp, NULL);
 
 	if (unlikely(atomic_read(&retired_max_queue) > 0))
 		retiring = 1;
 
-	sqcp->a_cmnd = NULL;
+	sqp->qc_arr[qc_idx] = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+		spin_unlock_irqrestore(&sdsc->lock, flags);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("Unexpected completion\n");
-		return;
+		pr_err("Unexpected completion qc_idx=%d\n", qc_idx);
+		goto out;
 	}
 
 	if (unlikely(retiring)) {	/* user has reduced max_queue */
@@ -4966,9 +4975,10 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 
 		retval = atomic_read(&retired_max_queue);
 		if (qc_idx >= retval) {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 			pr_err("index %d too large\n", retval);
-			return;
+			goto out;
 		}
 		k = find_last_bit(sqp->in_use_bm, retval);
 		if ((k < sdebug_max_queue) || (k == retval))
@@ -4976,14 +4986,19 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		else
 			atomic_set(&retired_max_queue, k + 1);
 	}
+
+	spin_unlock_irqrestore(&sdsc->lock, flags);
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-	if (unlikely(aborted)) {
-		if (sdebug_verbose)
-			pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
+
+	if (aborted) {
+		pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
 		blk_abort_request(scsi_cmd_to_rq(scp));
-		return;
+		goto out;
 	}
+
 	scsi_done(scp); /* callback to mid level */
+out:
+	sdebug_free_queued_cmd(sqcp);
 }
 
 /* When high resolution timer goes off this function is called. */
@@ -5233,115 +5248,126 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
 	}
 }
 
-static void stop_qc_helper(struct sdebug_defer *sd_dp,
+/* Returns true if we require the queued memory to be freed by the caller. */
+static bool stop_qc_helper(struct sdebug_defer *sd_dp,
 			   enum sdeb_defer_type defer_t)
 {
-	if (!sd_dp)
-		return;
-	if (defer_t == SDEB_DEFER_HRT)
-		hrtimer_cancel(&sd_dp->hrt);
-	else if (defer_t == SDEB_DEFER_WQ)
-		cancel_work_sync(&sd_dp->ew.work);
+	if (defer_t == SDEB_DEFER_HRT) {
+		int res = hrtimer_try_to_cancel(&sd_dp->hrt);
+
+		switch (res) {
+		case 0: /* Not active, it must have already run */
+		case -1: /* -1 It's executing the CB */
+			return false;
+		case 1: /* Was active, we've now cancelled */
+		default:
+			return true;
+		}
+	} else if (defer_t == SDEB_DEFER_WQ) {
+		/* Cancel if pending */
+		if (cancel_work_sync(&sd_dp->ew.work))
+			return true;
+		/* Was not pending, so it must have run */
+		return false;
+	} else if (defer_t == SDEB_DEFER_POLL) {
+		return true;
+	}
+
+	return false;
 }
 
-/* If @cmnd found deletes its timer or work queue and returns true; else
-   returns false */
-static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
+
+static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
 {
-	unsigned long iflags;
-	int j, k, qmax, r_qmax;
 	enum sdeb_defer_type l_defer_t;
-	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_defer *sd_dp;
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
+	lockdep_assert_held(&sdsc->lock);
+
+	sqcp = TO_QEUEUED_CMD(cmnd);
+	if (!sqcp)
+		return false;
+	sd_dp = &sqcp->sd_dp;
+	if (sqa_idx)
+		*sqa_idx = sd_dp->sqa_idx;
+	l_defer_t = READ_ONCE(sd_dp->defer_t);
+	ASSIGN_QEUEUED_CMD(cmnd, NULL);
+
+	if (stop_qc_helper(sd_dp, l_defer_t))
+		sdebug_free_queued_cmd(sqcp);
+
+	return true;
+}
+
+/*
+ * Called from scsi_debug_abort() only, which is for timed-out cmd.
+ */
+static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
+{
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	struct sdebug_queue *sqp = get_queue(cmnd);
+	unsigned long flags, iflags;
+	int k = -1;
+	bool res;
+
+	spin_lock_irqsave(&sdsc->lock, flags);
+	res = scsi_debug_stop_cmnd(cmnd, &k);
+	spin_unlock_irqrestore(&sdsc->lock, flags);
+
+	if (k >= 0) {
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		qmax = sdebug_max_queue;
-		r_qmax = atomic_read(&retired_max_queue);
-		if (r_qmax > qmax)
-			qmax = r_qmax;
-		for (k = 0; k < qmax; ++k) {
-			if (test_bit(k, sqp->in_use_bm)) {
-				sqcp = &sqp->qc_arr[k];
-				if (cmnd != sqcp->a_cmnd)
-					continue;
-				/* found */
-				sqcp->a_cmnd = NULL;
-				sd_dp = sqcp->sd_dp;
-				if (sd_dp) {
-					l_defer_t = READ_ONCE(sd_dp->defer_t);
-					WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-				} else
-					l_defer_t = SDEB_DEFER_NONE;
-				spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-				stop_qc_helper(sd_dp, l_defer_t);
-				clear_bit(k, sqp->in_use_bm);
-				return true;
-			}
-		}
+		clear_bit(k, sqp->in_use_bm);
+		sqp->qc_arr[k] = NULL;
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	}
-	return false;
+
+	return res;
 }
 
 /* Deletes (stops) timers or work queues of all queued commands */
 static void stop_all_queued(void)
 {
-	unsigned long iflags;
+	unsigned long iflags, flags;
 	int j, k;
-	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
 		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
 			if (test_bit(k, sqp->in_use_bm)) {
-				sqcp = &sqp->qc_arr[k];
-				if (sqcp->a_cmnd == NULL)
+				struct sdebug_queued_cmd *sqcp = sqp->qc_arr[k];
+				struct sdebug_scsi_cmd *sdsc;
+				struct scsi_cmnd *scmd;
+
+				if (!sqcp)
 					continue;
-				sqcp->a_cmnd = NULL;
-				sd_dp = sqcp->sd_dp;
-				if (sd_dp) {
-					l_defer_t = READ_ONCE(sd_dp->defer_t);
-					WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
-				} else
-					l_defer_t = SDEB_DEFER_NONE;
-				spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-				stop_qc_helper(sd_dp, l_defer_t);
+				scmd = sqcp->scmd;
+				if (!scmd)
+					continue;
+				sdsc = scsi_cmd_priv(scmd);
+				spin_lock_irqsave(&sdsc->lock, flags);
+				if (TO_QEUEUED_CMD(scmd) != sqcp) {
+					spin_unlock_irqrestore(&sdsc->lock, flags);
+					continue;
+				}
+				scsi_debug_stop_cmnd(scmd, NULL);
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				sqp->qc_arr[k] = NULL;
 				clear_bit(k, sqp->in_use_bm);
-				spin_lock_irqsave(&sqp->qc_lock, iflags);
 			}
 		}
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	}
 }
 
-/* Free queued command memory on heap */
-static void free_all_queued(void)
-{
-	int j, k;
-	struct sdebug_queue *sqp;
-	struct sdebug_queued_cmd *sqcp;
-
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
-		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
-			sqcp = &sqp->qc_arr[k];
-			kfree(sqcp->sd_dp);
-			sqcp->sd_dp = NULL;
-		}
-	}
-}
-
 static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 {
-	bool ok;
+	bool ok = scsi_debug_abort_cmnd(SCpnt);
 
 	++num_aborts;
 
-	ok = stop_queued_cmnd(SCpnt);
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device,
 			    "%s: command%s found\n", __func__,
@@ -5543,6 +5569,33 @@ static bool inject_on_this_cmd(void)
 
 #define INCLUSIVE_TIMING_MAX_NS 1000000		/* 1 millisecond */
 
+
+void sdebug_free_queued_cmd(struct sdebug_queued_cmd *sqcp)
+{
+	if (sqcp)
+		kmem_cache_free(queued_cmd_cache, sqcp);
+}
+
+struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
+{
+	struct sdebug_queued_cmd *sqcp = kmem_cache_zalloc(queued_cmd_cache, GFP_ATOMIC);
+	struct sdebug_defer *sd_dp;
+
+	if (!sqcp)
+		return NULL;
+
+	sd_dp = &sqcp->sd_dp;
+
+	hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
+	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
+
+	sqcp->scmd = scmd;
+	sd_dp->sqa_idx = -1;
+
+	return sqcp;
+}
+
 /* Complete the processing of the thread that queued a SCSI command to this
  * driver. It either completes the command by calling cmnd_done() or
  * schedules a hr timer or work queue then returns 0. Returns
@@ -5554,15 +5607,16 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				    struct sdebug_dev_info *),
 			 int delta_jiff, int ndelay)
 {
-	bool new_sd_dp;
-	bool polled = scsi_cmd_to_rq(cmnd)->cmd_flags & REQ_POLLED;
-	int k;
-	unsigned long iflags;
+	struct request *rq = scsi_cmd_to_rq(cmnd);
+	bool polled = rq->cmd_flags & REQ_POLLED;
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	unsigned long iflags, flags;
 	u64 ns_from_boot = 0;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
 	struct sdebug_defer *sd_dp;
+	int k;
 
 	if (unlikely(devip == NULL)) {
 		if (scsi_result == 0)
@@ -5606,22 +5660,17 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		goto respond_in_thread;
 	}
 	set_bit(k, sqp->in_use_bm);
-	sqcp = &sqp->qc_arr[k];
-	sqcp->a_cmnd = cmnd;
-	cmnd->host_scribble = (unsigned char *)sqcp;
-	sd_dp = sqcp->sd_dp;
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
-	if (!sd_dp) {
-		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
-		if (!sd_dp) {
-			clear_bit(k, sqp->in_use_bm);
-			return SCSI_MLQUEUE_HOST_BUSY;
-		}
-		new_sd_dp = true;
-	} else {
-		new_sd_dp = false;
+	sqcp = sdebug_alloc_queued_cmd(cmnd);
+	if (!sqcp) {
+		clear_bit(k, sqp->in_use_bm);
+		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		return SCSI_MLQUEUE_HOST_BUSY;
 	}
+	sd_dp = &sqcp->sd_dp;
+	sd_dp->sqa_idx = k;
+	sqp->qc_arr[k] = sqcp;
+	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	/* Set the hostwide tag */
 	if (sdebug_host_max_queue)
@@ -5673,12 +5722,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
 				if (kt <= d) {	/* elapsed duration >= kt */
 					spin_lock_irqsave(&sqp->qc_lock, iflags);
-					sqcp->a_cmnd = NULL;
+					sqp->qc_arr[k] = NULL;
 					clear_bit(k, sqp->in_use_bm);
 					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-					if (new_sd_dp)
-						kfree(sd_dp);
 					/* call scsi_done() from this thread */
+					sdebug_free_queued_cmd(sqcp);
 					scsi_done(cmnd);
 					return 0;
 				}
@@ -5686,33 +5734,28 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				kt -= d;
 			}
 		}
+		if (sdebug_statistics)
+			sd_dp->issuing_cpu = raw_smp_processor_id();
 		if (polled) {
+			spin_lock_irqsave(&sdsc->lock, flags);
 			sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
-			spin_lock_irqsave(&sqp->qc_lock, iflags);
-			if (!sd_dp->init_poll) {
-				sd_dp->init_poll = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_POLL);
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		} else {
-			if (!sd_dp->init_hrt) {
-				sd_dp->init_hrt = true;
-				sqcp->sd_dp = sd_dp;
-				hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC,
-					     HRTIMER_MODE_REL_PINNED);
-				sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
-			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_HRT);
 			/* schedule the invocation of scsi_done() for a later time */
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
+			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_HRT);
 			hrtimer_start(&sd_dp->hrt, kt, HRTIMER_MODE_REL_PINNED);
+			/*
+			 * The completion handler will try to grab sqcp->lock,
+			 * so there is no chance that the completion handler
+			 * will call scsi_done() until we release the lock
+			 * here (so ok to keep referencing sdsc).
+			 */
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		}
-		if (sdebug_statistics)
-			sd_dp->issuing_cpu = raw_smp_processor_id();
 	} else {	/* jdelay < 0, use work queue */
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
 			     atomic_read(&sdeb_inject_pending))) {
@@ -5722,30 +5765,21 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				    blk_mq_unique_tag_to_tag(get_tag(cmnd)));
 		}
 
+		if (sdebug_statistics)
+			sd_dp->issuing_cpu = raw_smp_processor_id();
 		if (polled) {
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
-			spin_lock_irqsave(&sqp->qc_lock, iflags);
-			if (!sd_dp->init_poll) {
-				sd_dp->init_poll = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-			}
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_POLL);
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		} else {
-			if (!sd_dp->init_wq) {
-				sd_dp->init_wq = true;
-				sqcp->sd_dp = sd_dp;
-				sd_dp->sqa_idx = sqp - sdebug_q_arr;
-				sd_dp->qc_idx = k;
-				INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
-			}
+			spin_lock_irqsave(&sdsc->lock, flags);
+			ASSIGN_QEUEUED_CMD(cmnd, sqcp);
 			WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_WQ);
 			schedule_work(&sd_dp->ew.work);
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 		}
-		if (sdebug_statistics)
-			sd_dp->issuing_cpu = raw_smp_processor_id();
 	}
 
 	return 0;
@@ -7066,6 +7100,10 @@ static int __init scsi_debug_init(void)
 	hosts_to_add = sdebug_add_host;
 	sdebug_add_host = 0;
 
+	queued_cmd_cache = KMEM_CACHE(sdebug_queued_cmd, SLAB_HWCACHE_ALIGN);
+	if (!queued_cmd_cache)
+		goto driver_unreg;
+
 	for (k = 0; k < hosts_to_add; k++) {
 		if (want_store && k == 0) {
 			ret = sdebug_add_host_helper(idx);
@@ -7088,6 +7126,8 @@ static int __init scsi_debug_init(void)
 
 	return 0;
 
+driver_unreg:
+	driver_unregister(&sdebug_driverfs_driver);
 bus_unreg:
 	bus_unregister(&pseudo_lld_bus);
 dev_unreg:
@@ -7103,10 +7143,9 @@ static void __exit scsi_debug_exit(void)
 {
 	int k = sdebug_num_hosts;
 
-	stop_all_queued();
 	for (; k; k--)
 		sdebug_do_remove_host(true);
-	free_all_queued();
+	kmem_cache_destroy(queued_cmd_cache);
 	driver_unregister(&sdebug_driverfs_driver);
 	bus_unregister(&pseudo_lld_bus);
 	root_device_unregister(pseudo_primary);
@@ -7493,6 +7532,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		goto unlock;
 
 	for (first = true; first || qc_idx + 1 < sdebug_max_queue; )   {
+		unsigned long flags;
+		struct sdebug_scsi_cmd *sdsc;
 		if (first) {
 			first = false;
 			if (!test_bit(qc_idx, sqp->in_use_bm))
@@ -7503,37 +7544,60 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		if (qc_idx >= sdebug_max_queue)
 			break;
 
-		sqcp = &sqp->qc_arr[qc_idx];
-		sd_dp = sqcp->sd_dp;
-		if (unlikely(!sd_dp))
-			continue;
-		scp = sqcp->a_cmnd;
+		sqcp = sqp->qc_arr[qc_idx];
+		if (!sqcp) {
+			pr_err("sqcp is NULL, queue_num=%d, qc_idx=%u from %s\n",
+			       queue_num, qc_idx, __func__);
+			break;
+		}
+		sd_dp = &sqcp->sd_dp;
+
+		scp = sqcp->scmd;
 		if (unlikely(scp == NULL)) {
 			pr_err("scp is NULL, queue_num=%d, qc_idx=%u from %s\n",
 			       queue_num, qc_idx, __func__);
 			break;
 		}
+		sdsc = scsi_cmd_priv(scp);
+		spin_lock_irqsave(&sdsc->lock, flags);
 		if (READ_ONCE(sd_dp->defer_t) == SDEB_DEFER_POLL) {
-			if (kt_from_boot < sd_dp->cmpl_ts)
+			struct sdebug_queued_cmd *_sqcp = TO_QEUEUED_CMD(scp);
+
+			if (_sqcp != sqcp) {
+				pr_err("inconsistent queued cmd tag=%#x\n",
+				       blk_mq_unique_tag(scsi_cmd_to_rq(scp)));
+				spin_unlock_irqrestore(&sdsc->lock, flags);
 				continue;
+			}
+
+			if (kt_from_boot < sd_dp->cmpl_ts) {
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				continue;
+			}
 
-		} else		/* ignoring non REQ_POLLED requests */
+		} else		/* ignoring non REQ_POLLED requests */ {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			continue;
+		}
 		if (unlikely(atomic_read(&retired_max_queue) > 0))
 			retiring = true;
 
-		sqcp->a_cmnd = NULL;
 		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+			spin_unlock_irqrestore(&sdsc->lock, flags);
 			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u from %s\n",
 				sqp, queue_num, qc_idx, __func__);
+			sdebug_free_queued_cmd(sqcp);
 			break;
 		}
+		sqp->qc_arr[qc_idx] = NULL;
 		if (unlikely(retiring)) {	/* user has reduced max_queue */
 			int k, retval;
 
 			retval = atomic_read(&retired_max_queue);
 			if (qc_idx >= retval) {
 				pr_err("index %d too large\n", retval);
+				spin_unlock_irqrestore(&sdsc->lock, flags);
+				sdebug_free_queued_cmd(sqcp);
 				break;
 			}
 			k = find_last_bit(sqp->in_use_bm, retval);
@@ -7542,7 +7606,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			else
 				atomic_set(&retired_max_queue, k + 1);
 		}
-		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
+		spin_unlock_irqrestore(&sdsc->lock, flags);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 		if (sdebug_statistics) {
@@ -7551,6 +7615,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 				atomic_inc(&sdebug_miss_cpus);
 		}
 
+		sdebug_free_queued_cmd(sqcp);
+
 		scsi_done(scp); /* callback to mid level */
 		num_entries++;
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
@@ -7733,6 +7799,16 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	return schedule_resp(scp, NULL, DID_NO_CONNECT << 16, NULL, 0, 0);
 }
 
+static int sdebug_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
+{
+	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmd);
+
+	spin_lock_init(&sdsc->lock);
+
+	return 0;
+}
+
+
 static struct scsi_host_template sdebug_driver_template = {
 	.show_info =		scsi_debug_show_info,
 	.write_info =		scsi_debug_write_info,
@@ -7760,6 +7836,8 @@ static struct scsi_host_template sdebug_driver_template = {
 	.max_segment_size =	-1U,
 	.module =		THIS_MODULE,
 	.track_queue_depth =	1,
+	.cmd_size = sizeof(struct sdebug_scsi_cmd),
+	.init_cmd_priv = sdebug_init_cmd_priv,
 };
 
 static int sdebug_driver_probe(struct device *dev)
-- 
2.35.3

