Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F86B72A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCMJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCMJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:32:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F12CFC3;
        Mon, 13 Mar 2023 02:31:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMFvgH003364;
        Mon, 13 Mar 2023 09:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=wBHo6ZrYomxda+Xv7puzR3KPhi+syECKq1kMnIfgwb5qyrx12YMcheqER3v+Lsblg3gj
 ApP6TdNLMN6MQaRcMVJoA5b1PcSwKvBzuOOSC0dNMgMjcawIe/OByzfu2zzLIXHlhxkS
 3hjnEn7u9zdEOIy9gggHTf/+PkA1HmI7xNTKbaOZ1iX3SxcdWpXNMiFRm4Ny50TKyvqc
 QxwiJWxVIhB9yaKKNXxBpRdk33fku5A8+Ctc1dDupR7qL2A+YUm9JzDiNvZ4RzkiHaBd
 yZ6Yd+/FNdZzbY/XtKFRG2mAwxlRyzSbV5pmuFR3OQSUQuUICW7t2CAE1bDDfsm/6z+8 6w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbbdfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D81psB015281;
        Mon, 13 Mar 2023 09:31:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34w4tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVBFR2jfISu+x61OhbapHHNniyZgHKrWwiv+7UZ0Lnaaqgo8XVCrnGofDbiApMNxpsckwpHdW37/YgxTDd+pqHyMDS53nhAd4HrVKOeCo4rgVehyKDDN7jDnx05pMnea7LrIpSNHhfDSAoO6vLVaz3Cgh9GtChY984O/bs3LA45UkZHPeTk8qXmTUlw/WAQT2H2ymJ9iJlsuIJrHueMDpKTQAvmpK+ennp5O9tvY5MslOSlQ/E13lvSXfMd1qyyQqA/Gc6Y+vXfWOMtaGpfDUQCFxTsUQDHfRmLB4trX1nMyxHS4O4tuFy1r+OgPOc/mYHBYjRvG5B3RHhWDq4b0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=PPJqvtnBjg5OGKK8xOEHURmhTzLPy3b922mmgLbvLB1EauRUQs9WKUP6CQLE1LRdJsCAUwUh3oGzJL3yrbErZ1PBO2s53MmYWzFUH3L9PO3ZzBfWLkaW2GQDiiWdxByf1uqNwfTLoCzBl8cYOZB9LCh+Aaiiy28C9yQDs7hZAKKA9OxGmZz36BrRfNtEE+3WDXVLj4GW5Gi92GBTsGOXkeQ0z6fiPsz9ttMidsjF3SbDO1C/0QHY6P3hVase9Vkh6ENbYnRIWtztPdzUEXUm1RhIIJZ4dNj5ay/Do6b2X5S3XfpDE9QWLSp2PHJKFNptAx8xipFtFeAYxL1cMEwlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=sM2SDmlCBLuN2FlIzQmV471gxxs3JyvH7/UxQnCgDnxCdKChPyetG071owL45pDx0C++m7nTA1a5QGvOcmDvCpoUZvHOVVAxnOCdyy9koRdQW/BwwVGJ2uZJ4xtdOqbi2yqLJJAh3708ld1dLv2hustbuCoJfkjgOg+Wh/3hoWM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:42 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 06/11] scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 09:31:09 +0000
Message-Id: <20230313093114.1498305-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6a2bef-ec0c-4e9a-2bd4-08db23a5c18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lWp6J9h2mSRSfvnKEf7T2oxIpr1YYfcDaf/DbAf+DOxl7Yo6kGSBZkf+olhc2nrVcJ6QiboJPR+F83rST2wvmoxhMauAqLEmOG+mj8vjXJLpACf3Kp2YrLFBYRB9uUvx5YVb5exbARm86ICTuxWANAkHG0x7yggk4Jl07I777z3YQHk71q4o0sETud1OxkUskS3eVE8ULZ5EOKX9iPAt+swI90U3fsJNNp14tmtZe13vaAieCQ/2DxFTDYBOzjsgkYDlt6I4jsaX1i3+1PWcH5umrSnZes+pHk8pOIC6VBIVdjoF3FIB/76qAZC+eZXZJmDS/qg3gFbwenHaOsuHFZUmnbtx8/ugziDpgcpyh4ICp/aSvTDYW+sGKbZSDahaF2zcr8apfI2FysYNh6jgIiUWTTSydIJZb+twdoAXwa2PlL6ZDT3Vk0Zme9r3cHYTCRaqF4giaTo9J2yzuipBnpvV362bhf1RuzJ6mhz6UdjsX2n0Dnc5ax6LiDw6Sy4YmwaTpuzB0mJI7rjFfbXR/4LfZ2Rx6qPdBrpxrUKsbQU/c2DfbcdmZOgpD3HarN1aUqx1vu1UQml35uHwZKaNG5vpGqenErAeSDIXIrM3e0Xsxdz5VaY5GoKomvrt4Skjq/EINGnbCTP0X3x8NwBIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxLWKQh04cPyV6uP85lj41mNKBJDVtaGBaKrmZ7gbppM7lwQTq6j8yYJciSS?=
 =?us-ascii?Q?OMjuFaaBSJbmk9jKh4R4JC9MsJafhBicv1JrDrZY+LRhrqcQziBXeYIBKScV?=
 =?us-ascii?Q?2TahHj6sa16bjAG8eeP3204G2Y84qM1Say+VSbMEkXuiXb8xPUNLP9JdXnRN?=
 =?us-ascii?Q?sFNllucEe5iQ770e/zSDvv+NKrzEa7QYsNgTMdiB01F/7/lmcIHYLTYJH7MV?=
 =?us-ascii?Q?zjaP1XzUG+PlFR6i0IiTNt5PpWk0AQaoiyatDObdtREz2U6ZuUXbeK64QGhp?=
 =?us-ascii?Q?1SfJSxUL7b/Qg4ey+zg6agYgBoRgL3dcbJFJT4NrsjQ8RQ+exVbMvO+WQrUF?=
 =?us-ascii?Q?sJePo69JfzGkqE8oT0OkISHv0GPwHEh/hKneEhzrSq7zbjTaFmxzm93F1KyG?=
 =?us-ascii?Q?RK6TAiphZCt3vmvmgJ4aJKf2ZdKrYlC2LE2cEx+n+oNCva5ZQRlQgR0jZd8K?=
 =?us-ascii?Q?54J6zoKMni6ZyH8V4geEKJRtgOhV5IyYa7g85IT09R/qSUy99qRaC0rtl+ny?=
 =?us-ascii?Q?GpDo4Tb0q6XxbkbE0i6AXgldC4BZOC3tOzSTAvlgaoZGxNoF1GYwMHZ6Gbi1?=
 =?us-ascii?Q?P+dZUp4SeT3W+hDGKbwMiaOkCm5yDUE2OSrv4Y9Yg40CNVNd96y8Axbyk6Gp?=
 =?us-ascii?Q?f2zAdU+4AnltqElthpHk+qPhd5zn9wUnpJweNCYYtmj19NfPveB9UCPMRLbT?=
 =?us-ascii?Q?8hjzipB262AHqhmT+zcuVBH02ip0HR2s+M9yoBi2fU8Eb++pJHSdTpBacZK9?=
 =?us-ascii?Q?aY2iiBMs1N4Va+TXfmdqHYvpRqdBvXsfNDXgXMt1lzBWMpz2+FbUN+R/dRHs?=
 =?us-ascii?Q?1lLrKdcjn9KChe1XbrSDRDmbvEa3w/3hLsT04ArO8IvNxTvn9dd2uj9ehRWb?=
 =?us-ascii?Q?W/Nhr1KowmETTRiKI1N6Y6I5O/vMQelvkR8r7vsD17nNUzm4VZqaKceSzUjX?=
 =?us-ascii?Q?+AMfhWS3HTIBWRTUF2nr0S6rifVLDXw95x9AmwCpSJmo10qXRJcq//r6C5I/?=
 =?us-ascii?Q?V413DJ2BShav5VgLDZO8Xc2TP9CDk3Uwx9mnx74qMU6j5nWOQZNiidoI0KoP?=
 =?us-ascii?Q?YB9NLCGSRnAQJMaTgVC+hdxRcr6lJSZ87usb+O/4t6ovAe3mc4nk/V9PNA5x?=
 =?us-ascii?Q?cJjdsSnzruNhlpdhFKL9B0Hv9oZHdfUMx89AvUhat3v6cdESq23+DZ0Qogg5?=
 =?us-ascii?Q?48ZypiaiXS/DUtfVMUtAjYbUvfL5rnB8oRXmucfEDUggd+n7N5Ukrl7CLUiY?=
 =?us-ascii?Q?D10eImYt7jtQimEDRGLVYd5VIKCGNXrk+JhVkTGKPAl4oK27dzRWd4Rx9HmV?=
 =?us-ascii?Q?huPh6ZH/M/p11V10o8sSxAorpP7QSVEDcKNeRQ+igAJzR9SRYTGmsfuA8Qwo?=
 =?us-ascii?Q?1d0eUZT5SKmMYdZfkznPMmLcGXMxtJG+ZBPx2FbbJegb4eHQ1xHdPC4de4gx?=
 =?us-ascii?Q?k59zMW/1AbTBsGGLKUASMbWVXKxV+exf/t8IsUBRjaX/Emg+Hx0Fy/S023ru?=
 =?us-ascii?Q?GbuL6ci3/nslDibGNk4VB5D7dIds3chEOwHRTlApNXz2RTMdaCtVPA6eRVu3?=
 =?us-ascii?Q?PExBBZKlHVckKhvtZ7nA7ZMX9mBou5hhtuR+EAO0r24g90lxaGH8d7ZOGTUw?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GDTGhSgekD7rqvOIZ6Fez2kQs+ZjD23x911WlAmttX6R9L61oIQ3aaI/X62cn+2AhP2kgXGx89RWJ26Ay/JLWkx3WsYypJayCwksIevNzH2I+tFL9vLMJLPSbpTa0+oBuBxDeUoZ/I3/gDEXoMoCI9rUln8Kuef95bar354V/T4gbRoEuFEB+iuzd6G3yEyGoTerKR8KKzkv37jXcC8966qOd9Qzo91xXxMY/ZPR5nPXm4Zq45kwOFTUVyVB68yw5MpJ1qfhr8mCiPM/cXbF/BtDhSMtDuazoJqV894OVArvIRTqXFnrABwr0z8DkqQJQ5gQ5OKphZ0MGbsAWz30YZqRU7WaivYrczAKXQgYe3d2xW2eg6zQa+UunBNGnmVbflIpodOxbRcwKZ7Bpg3AbR455xYlHH0hjggwvzkdGvub6tC9aK6i3PJrPdz5IIjQvW572HVCX7Rgx8p5u7/pB0jFqSW6Y/Sv1hBu3+A21AG3yTgAHRMzTRM3ZCl5sZu+PqhldqKbQJRsC8pd63BTiHkFxOHqBH509OJmHgHkal5mywBdtb8Y0Ibg+X6jr1EcwDzQHstM+rw9t9Mfn4nhI2sWMcKz2o3ET9EbuuYfdBvnB4R6SoiBD6yuAqUOLlzlSAZ64H0EiublRDuENpfwXItCgZeB2KJuemm/qDQ1nez9/Cq3IgZ/UkMgYsvv8dmPpayypCKWIrdaLm7No4MtiurayQFsIPR/y+HsR0W4HaZuuXsP6dWTKcQUdVC2soAjknv51DcApLbU1o5EW12FtjRaQjhhAbkkMQouswEy3fRoyfaAsdD47kMEB7YBDNt2MLVAZ5ricKbrqYCUyrpchFV3kzuIYjzrKAiLsA8ehFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a2bef-ec0c-4e9a-2bd4-08db23a5c18b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:42.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+MLO1AFzrfMsG3UhYXs2NDKwtP0jispD0kQLMcI/o+aAY2A15R1tWGfaFF6mz0Eu9m8OoJohFxthfN0fzY+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: st3tDyEGrkd01cLSeN3prXjwU80P8rk-
X-Proofpoint-GUID: st3tDyEGrkd01cLSeN3prXjwU80P8rk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for SCSI cmnd, SCSI device, and SCSI host are unnecessary, so
drop them. Likewise, drop the NULL check for sdbg_host.

The only caller is scsi_try_bus_reset() -> eh_bus_reset_handler(),
and there those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6364d6f08861..749358b48335 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5412,34 +5412,24 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 {
-	struct sdebug_host_info *sdbg_host;
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_host_info *sdbg_host = shost_to_sdebug_host(sdp->host);
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
 	int k = 0;
 
 	++num_bus_resets;
-	if (!(SCpnt && SCpnt->device))
-		goto lie;
-	sdp = SCpnt->device;
+
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (hp) {
-		sdbg_host = shost_to_sdebug_host(hp);
-		if (sdbg_host) {
-			list_for_each_entry(devip,
-					    &sdbg_host->dev_info_list,
-					    dev_list) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
-		}
+
+	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
+		set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+		++k;
 	}
+
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in host\n", __func__, k);
-lie:
 	return SUCCESS;
 }
 
-- 
2.35.3

