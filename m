Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F56B72AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCMJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjCMJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:32:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A854C8C;
        Mon, 13 Mar 2023 02:32:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D3TCO2005465;
        Mon, 13 Mar 2023 09:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=kK9pCtHNTqfhFT/g38H3QEwWysFagv4uWiwXavdM2XTZDNPiXfazdMSC2Yq2P4e1DWpm
 d7GSdI2jc+aMZY/S+pa4umAW8SNdTXfFG3/Pnk3SZJ2WwlJZH4FOESCQ7/AIxIj3HY6e
 BGct6grOgIcRmTY3VloTA2YgUMSDGQOmfEj2MJWOCxQNh4S3HlaQMmFASUdpHOiDinbJ
 UD49+gIaDVZwCmj/BY6KgXcrOB0ESsDnFSareIe8fRtvv1IaKMTFsQj+nFt26J+MJuwa
 Jv52+oc/qsNtmxvnpmHsw/jgtrMtKMUuFFOtNA1bdMrJJBc8de4gbGJqCkN6sjbJRfpW Cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcubs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D87LTi007941;
        Mon, 13 Mar 2023 09:31:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34ck0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+rNeoyQUeLMuAbXU2r1M8BuxNiauDsmUN+63IdG7oFDBP+mDhWGzcqT8L2TqgShd2ZZJqTskOd8LccZ6Y7e8bwLgWn7yWLLNfhdUct1javR9/5i8NfW9WhppoyRmiZ49erVzDyxrfdWL8P0qe9T5xtI0U1rNs6TqnPF7d5K7TYTi9Uwyi8KBzbSiCqUV3hYdWyPrKC6nri2/eCSeQ13L3XBODPKfCBKphFficF64y6IgliMrl40+IEF9zu4fc1m5nVYZYoIX70ykOxycoHHLzLV6ly42Zhtw1HrMhXPt/JA0LnSNSv27wtg1dZpLpOyAKeinDxeMyNutYzX0CC3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=Mx67EKoXZR7HGLXxRWAnHy3PvjI7O70yk0MeDPUj8xDlOMwLAOEgNx6TIyN9qqTqYiz/RhrmRgPsHAdWN8eV0E9oi7OZX8EEXPEhGXb+4BLA8LBmzrMCOB+ZhlPlq8oIqQYme+/jeKvdgcHX0gq4f1gC6rzqWSQOrQq95EhqIdTM03dNLV+4k+UkE3IRjeqzMd44IwKfDg0Jrt7ERSI9KFLAdb1zlt42zh8F2IaIzGN73Wx9sS62Xb06J9qP7NBj0bc/PIZBoDGFOJ+kBW0me+ufXhFUjLISy/YPViM+hYCAdcv1LnZOPy6XGJKKm2jvGPOTZM53rqJt1HDQ9C5erA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5emtnqnAuF5rngG5kvp0R7AJJUPTkH1GIQnJU5Z4ZM=;
 b=xmBxtEX6/ZGFE8677YWxmvZsY836wgLH1u/Qz9piFc2PoCyAuzrGXf3GJTDl5ym8A2X54f0kdTfuCOzgAXutGkSgQEXCqyziTDM1pahoQYMllwgtJ52QpclmTr85D7v9d9BfrJqn4nuNyCsMiZx928v2l+uRYOF/xvud3bVU8tY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:52 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 08/11] scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
Date:   Mon, 13 Mar 2023 09:31:11 +0000
Message-Id: <20230313093114.1498305-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b9a4dd-b8d3-4245-76d9-08db23a5c769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7ty8+em+BqV36aA5APMVYRl5ShbVPvg1I1+q/fUSJbQb5oGhLi2HD7ygWoxk0lyiQFKo7miCIPm2UnbcqG3giB+XEOn8yWhL3zKeBTOkXv4l8ckJ/nktw+7Rg7q5L4iwTrH4OadYqJAJbWMSKn+H82AcfrTJAloF0Xd3z1TL8amQVkbLW/4cqLWAXJ4mVg3HEoeAmELerdgrojEJ+OCZZDb+NjJedCclmoTr/KJ7FmyEHsQ6xqzlYor93nKDP8ktHMy3zKNkIWKOc6D4GsGt0+krueLAVHFdyVHtvoDgBCyA6Gu59i3oSvdm0dgxjk/4lvxnqxwZ0R5eg0YHlEMU8A4xGYCFh/ttonP1Uw/UdFmN8R+NU5+93BC9NqxaejH5yXlVR7UNNLDCTvgHXVcf1x0n0tkD9IVlex0O2SRDidAbZ7+xZf/y2czgBGPkHESlobVV+c12/IITuDY+qlmpcHGNCEN9XIjRiD0tB3BsEfzyqynCo9g2Sdq3d0TALtx+DyshNp5oq5slQChIg5CV/h8l+6Yb7McouZw56XvteogRXFH571A2O7h/9Jorn8Iod9eoJ8Apcf3Oz/ufg5dvMdYlYoqDlmDRrRXZhR6D0ymjPZAwnuP+N7C3FFcMX6aW1ofci3Y9laUHqEStLyTyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptViY02FdGmH1mTkcFF0yOHzKnBtcrpTvvuIsvRPy4xTATrPIkEOXKwXBpFo?=
 =?us-ascii?Q?ZAWdgmQVtHXOGCNycAVAftfOA58OQWjFJ0sjnd084kEegvUEgRvPZET9n/kt?=
 =?us-ascii?Q?QBP6U1PyBriPEBEahTdb84t1z7VCDgpFbOsq6lphZ39BgJ90msZlMS4lZTsJ?=
 =?us-ascii?Q?SC+37HBOBqL2NtRpe4jbBhEUswwYZt0oXoeHYsW5PqLa71tSsfve5djh77HD?=
 =?us-ascii?Q?JPR0oiLtKY0swAjo2sjPtj/Z8QV69w5S50hqcyfeRNk2WhjZDp6uf0Fj5eaJ?=
 =?us-ascii?Q?tegTNshC8Di1HLR66dpwOnBSts/mLLo6QA7dEuQYmSkWCEl8EMZ5BPL54hq7?=
 =?us-ascii?Q?XE0+mmXn0Z2YgatejJ8zAJeqdd/2dxejVE0qhIcnT5AD8swBsQrcbXYg5Fa7?=
 =?us-ascii?Q?qu3fvmcWDbz6u94cYMqmGOAeen/HIOySGg3Wr47iFXVf68UEoxuR+/9MGHCe?=
 =?us-ascii?Q?m9kCeDHT/MWMwB3Ha4Le/QBzHfXhluxJC+4dUvo3IdkeBmDtkl4qCiS6Z/iR?=
 =?us-ascii?Q?G/sbAxcTcRFOKsXEDzN6lbqJ3BUgR2hM/Y+nL7p+bBx6au1gwQ2Hk+JE3z5r?=
 =?us-ascii?Q?Si0hRQmTmLWkJnO+GcCIuhZsprAOxT9/L+sTSHUgwzXU0XTTd/Qh5ABnUeqX?=
 =?us-ascii?Q?OiuOh8qlHr63ovaY6xLdDYkbKnKAYQbJKlRMpZsvSKSafvWBJ0LTawHxVzxT?=
 =?us-ascii?Q?D/i8D8AriP05wXicG110BMVeL5VI43CDQohkHLoPkEXvJrlCj29rk9MKXxDH?=
 =?us-ascii?Q?YpNge7NHlUe3z2kADnj6F0MgOxfY32jRY2Typ/ydF5UibBw4Zh9W84qOYmFq?=
 =?us-ascii?Q?estSmtlWM9rvW7xxvMFFSetpwBE1B3HKip9XPqNhqKf5de0XA5wJvTLrM73F?=
 =?us-ascii?Q?YKC7KrzyEZ1u8jcygjVDiwJtQPICeEVgsoWNqw7L7vib5qWWsh1jthYhpK85?=
 =?us-ascii?Q?BEXHP01o/tHMtV2MUJ4TyL4WA82TlUt1kgGLK/YElPQVg8YZhUztzIX0Juve?=
 =?us-ascii?Q?XSNjKAwCECT3I0yP5PobgObYd03S2P87hWKzhw56JPVY+ICxszutuCUxCEiR?=
 =?us-ascii?Q?mcggPxZMn4i+tiPnKrOUOILaHiYMMOCAKEhT3oT4CKXyRLJdDTDRelnKGuDS?=
 =?us-ascii?Q?aRG8jsIm1eWl0dlTnC/7WpSt0Vdpto+hA0rJ644Kd4AxaUxcfwcKv94y1Fjm?=
 =?us-ascii?Q?20wuchYlPu2rHoxs4vcqvckfhzlRD47WyTAaRHVa9YvgUeZ4p08qznZWKk88?=
 =?us-ascii?Q?23bFBkQSwtPR+o3wCdtsQIKufR38JNzuu1GECF/wvdf8nNaKqEcM83y0v1xX?=
 =?us-ascii?Q?JAl6hVO1NMEjB5x7IaZZtzvapAH9OOs7MRCzaXAXeNfKRxvdLHD4UTmCPq/N?=
 =?us-ascii?Q?Q5IYpyrQqQvmibXtfveVGTyXZ7Z6nqmZtSQ3qMIwb/21GjiuO3F0dFuVbc23?=
 =?us-ascii?Q?3oZ236n790VWDhwFpFL5QnHYuMxiKr2ulkGIz6i/6BTmaPsiLKwWU9Lhv5Bv?=
 =?us-ascii?Q?kxVS5xAm+lMxp36tbIV74CVZzUtv+AuJHRkZQwdGEXQv4X/fN8a1sXhn8Suv?=
 =?us-ascii?Q?UduF5gPLGxhmso6eTXKW4U7lKQDMrUkYx2VBS6S/LpC+JaPpqav1S7BCkqUR?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kThzC0ktoDddgNvgE7YTu1r40x26Mllt/05v4MmXAMMKaNWqGr5gEtN3jcftQVezIFV/rkWJUGzaiL4cRD24Bsbl+jgP+ztPTZObbMvLjhJFUVv3rExWQMfgXXOT5ud0AqHPJI8na/3kd0NkI0SRkd4ibR3oKuoYuTVY0Bu8Ao14iqIuwqOE8LJWkD/gj7m4lzeDw66qfOPoqPmYjDVUesSmIzv8Mz6YNOCPLZzp96iQMdFTeGVyRFuPB4lhvmjDqb4ANs/XHBOVOevZjTfAy4wbtlwpkdBk1zzZVILggJaEKFPKVCdkLieFVEadJg3T/6m6rA7OHusA9fBsxFmjxj1j2PvL3Rmmkfc5m9bx2Akufkfsivh4O6Gq1WLN4K1hhNiStnKhdnhkTLFgsuivNosJg5rr9qQVA2lqbTgN7qvRpVZEnzT0U10qhY6TpuXxMngiZcB37vetnUzQVN9mhcYp7NZD+txqvcWddtc16M9qUDUjk1A/fGJ4Td7AUwgPcC1gioejADAcFWyFwvF35q6GyFkYAKKuOIe1kYbEgMXcI9xTCJfdoE1f7pFyae4VSgyH+5Kb8rFq4PNbzGZNkzQ2kIjRDsYj720SHuigJtRHt6LwzKooTMt8wXolCgxjxtE4zkPriypkvcW30CyEG9iW3zZt5teSekMi9PTF7HLFPXPoYJX6st03tzcvuVBiB9m28u9fcoz1ttK0/QROjoOjLwtBb5mcDIZpgrFHF8Wr3ibtaBTP/tPdcTnn16DaaTbRF8w9Iiqt61JLxuROM7AiestToZJe6xl9wOGOXtzLrIf2ejIha3gpN6ZoTEoYR9jhkXCUFWperPFevUu6cvgOAdupEQf2wMwOvC4wzPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b9a4dd-b8d3-4245-76d9-08db23a5c769
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:52.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SItzw3ofX/Vj2Qby43WWqLTxvrQVo6XK0udK35fo1MDi0TLh1cc/65/LF/NeZexmWue7sfnTbf6sIECp4c3gkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: bsKQt3nwa43I2YQHblmw0yaqz3DqxV67
X-Proofpoint-GUID: bsKQt3nwa43I2YQHblmw0yaqz3DqxV67
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

