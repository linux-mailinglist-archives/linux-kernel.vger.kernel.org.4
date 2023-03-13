Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E56B7163
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCMIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCMIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE027482;
        Mon, 13 Mar 2023 01:45:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D3TCIY005465;
        Mon, 13 Mar 2023 08:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=hfbvr1NcqkHsRWPtpCd9+dzKUWu6GxFjZEtiv897j/C+2vAEcGisO1Flok9awSBPVOng
 q1uU+vfStudfF2BazB9cQj+w/bgtt+S+46I+qM0pR6WcxQr68QaLH5OuF6XvSwHjGzaM
 5ehpbxot1UPfwYx0T8BWtgATHiBObDmv2eWDKCqp860ESipIPZ+1EL6uP/azyS406NiJ
 tHNaOlPUGq2rfyroDsT7/M3tBuK+9kgjL8lajVV7cjI8MTMZ/F+0SPL1aqBUhZB+2Unt
 3qoFJWFF88yTIjE3a+CuJwsJKbzwNe4WibxQGsgfGD3LAVgVhy0o45MSqzCJYJ3+uw6W 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcu8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6Kkq2008353;
        Mon, 13 Mar 2023 08:45:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b40ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlbJT1boRP9J095/j5evBqv+YnRfMQGZMaPfaW0eH13+YiAJ+t9NHCdefUpkmatpbLMvUUx2U9JRY5j2wfundYVG0xii/qPHln8eHyg6/WRdkbXnWV6i4KvbJvEvE7wMkyXcOf2BEvDoF7kSm9ZfWdwq1AV3zASETPRdOqN+tzq6s2KHHJN0wO5+k95vIPeZkzCRR93cOK2h4QojxS8r38dyfdabaMdF3rEAv9XH7jiNWIlpl2aDtEm6FYMc6BZlczUPku3YRiZuq59R10wKcL3i1rLyoVQaVsBqrAUEYOHRM7NBvDAftGYll6Y6/GJ5Ces86yCn3wr4qK/Smz/1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=kcusEdNR8pmmT4XY+NSo624517mlpLFBjfyvlaRfyWF5PB4nhsvCJfwJhiAVBmqo82xpVBtJvdujPEFAJUKBhWNs8fle00qZQ5wqT7TogYClWQuZch312arAm4jGO6RmEh+Vgc8vnS7Aveu89QTuDPikI9spZwJqATmdg8l/wTugdLgVIoMijJ51kXOyiXyTF9Hl58bCEJS35AoVxFyhhmjpGav6ofo9a3VXoJMaH4U6x4/UxwUP6i6pAbb4RRxd5zAjsH0HxNpFE2Kw/UoZm8Bj5ZND4eSbGvS5FahiHqDPhkq3TndPjzZKV7fp9/n/MupLfZ/8vYD0FVTswrNcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=rB4t+65phqIpDWUvaFiQpYghSGmAdHiO9Tcn9IZVq56I1XUpJ7wlpEsBfJn+zqBq3e6rd/L6/VcWK2AQTk9UEdmxhWvN/vAEQQQvy24k4htsuei3oGQ7SNzUCkWK4GZDHB6FFKlhn1r68UFPfNRXk9o5j6vslkBQhDYtKi/O8PI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:31 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/11] scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 08:44:59 +0000
Message-Id: <20230313084505.1487337-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:32b::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1e1ca1-f5be-428b-0da8-08db239f4d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCZIZ+Plyynxr8nNnEauARMgmGf+GZHPnjPt5Y0App2wmZoVWo9MebjJThbOVXbpiMpdPvylCCBMQTWDFb0ne/TfKLl2xaGT5WLU2w0g9Zr0dqAlbnLW2vZz5mhwn7jDKb79rGOYUrEc8fuyLj6r8IEqgdpa+ImAEDna8MAKpzvPgd1ESi5oayNiOYg+bA/cMcVmIiQfcN2opf0C9fGTSPtyRzX+nJPpDWizUV3ucN5h2UdFXnlS7u/cXmFc/x5CXqkoNGavjovgA6dUZ/ye+86Lvzh7wtV1vUp17Zv8YnJUKf30SXeFfARkSni2RiDHDbT4J9NruKFVrlvYGjDDcC1t6OsMMeUSsD4NbQS4TFWginmUuMuowo7FLXQQ4YHDDe3alsISyWjyJN+xMtk/1vriZ7Qm3kugKkkETrzWx6FBUOdCqjND5V5rilCu4bh7MY75o4ZVX8tIqdVUicriJXXOiFrukGxgO2b/KmVhyE6Q1+Q6v304CJ8uTNzdbt5XR3qTcRQaXgqs76SU4zAC9f/0Du1iXCLRAzqxLsywQ0kBVMNwKjzUtk34HF17Eq8fgmI5HNfKXAW3KfSbVLex9gkS7RK88BJ4T+tQTxNyMJR/Soo2huN0Eh5TCUpjfeYJAot4zkP7oHhgVu4sU95P3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dtY9QIMpc4KLNRsEymw80tCLRpH4a1DXvqtfzJ2wJgToRTu/cgfiDsBlPok?=
 =?us-ascii?Q?2RqAmngc1cbbuJpcHx0YbnAyve2RZBfth4skADicpFLpvmx/ynBqS0eVbRs+?=
 =?us-ascii?Q?A0pGTFG2QXpppgA6mFpg8llHM2JgGZvVzZZw6ZSHkhc7jSkPbPhAfQ8iHHwH?=
 =?us-ascii?Q?uHXOy2mrY8J0INtNItom3J7yGVSQyY8+D6It2+cAILQKf9E7pXUxpEy19rru?=
 =?us-ascii?Q?XYrBVs3kHdw+Nfvucft5/rRsWZgipVJbhhdJ6aR5ogd/PmiMr2d6hBpLmAJ0?=
 =?us-ascii?Q?YxwtGr5mGDvP9X6Bnsc5EVUJ1+Clh72fZpTOScyMX+BFoh8J7PgLIwJ0WNVU?=
 =?us-ascii?Q?VC8fu4a2VTmf9WDUTuDctuYNN+T1HoFwJvUEqMXbZYIN21sbKMBfZ4r1x7gk?=
 =?us-ascii?Q?hKjS2z6rGIkIhV8KcHHuXMAW+6I/KSa6CCeqKkxjZJUdQgjx3kIhVbfIXqFJ?=
 =?us-ascii?Q?FLV4WKimw+f102QM8SAWIpL6pILSKWjYlyq9eBACeRXQctjC0SvgyZKfRdK1?=
 =?us-ascii?Q?CslLT0KoDcIhE+BhtIg0mp8Q52HYrQpFjE7oqa5cuD2IFvnjz/izb7gZ5HIF?=
 =?us-ascii?Q?rhULaCo8Om/AoBYgC7/bI+xVLuyOrpQoVmYnnjG5RmWgnOn/uEUuxugp+05I?=
 =?us-ascii?Q?Co+0gOL/fH8/c6tKZGqTyI5saQ6U08wyeKv5PeH5W0wF29qnZrw9wjO+FEl2?=
 =?us-ascii?Q?pifS7q+AUsEJsxSvgtHferGOTZhU8iX7LWGCba+bnpLk0XdmsWDfO9klu/I7?=
 =?us-ascii?Q?+TmxkZ1JfOFGD9+GgjOT5UKIBbquECKAde0UX9BWbTUUg5D4n+g8Rth67ias?=
 =?us-ascii?Q?VryEoHOMzjfQQ4K5FUXz1xFkSrihrDoqQBc3TTPi1w1z7OYH0I42GLCa3a7l?=
 =?us-ascii?Q?vZrcJHWBHYoBfxycsyZKN/yhjHPd3R78+hk1G3tLYzAmCqq00vOjIS4BJiaR?=
 =?us-ascii?Q?7XHLc5At+siig2WG21xztHP+IXJ598ow09LL6sOAEb4k1qmVGKOyk+1/E2pu?=
 =?us-ascii?Q?UadHAJwU5d0iwDISUQGbknGBhUDlVGUq+9Wt/XC/81z14wYVw6w6P9CgDpvB?=
 =?us-ascii?Q?vPF1hU3bYXnedY/uPXkrjVla/DNievGshWv8RH+1e5OssH4lGzphGpqSGRKw?=
 =?us-ascii?Q?wfn6fH4BvQv38R25qlYg79oL2evAcrtF8G6aa30nqMYYFNs+C90/Sk1zQDC/?=
 =?us-ascii?Q?VvAYfVLAzRbHh0xZ0uGDIekYjYGieIXl9xhtRBsFyWM8+9HsqAGeM0NQ6E12?=
 =?us-ascii?Q?9JZjfuH1Bi2DvVEl7C2fiKHIMXgErgGn7TXsgQjxzBw0tmSsdM8VqR5xOOiW?=
 =?us-ascii?Q?l5P7FZs0vsnth6aZPf9Tk7Q1ITwJC858gBNAE2WMgpVLDJL6PmCNa5V10k03?=
 =?us-ascii?Q?R9n6eAZuAiCX11CuEadg59NuCpb1aPJJUfnno4PeQIHAF/H4MSKuDEDv9Nzw?=
 =?us-ascii?Q?Ei+SgTKjMA4HO2gu9jn+MueKz3jH5xbPweVTF8UpJHuRj22vla/QS91qCs/S?=
 =?us-ascii?Q?oR+LeVw9rJ2YAzKRv9MEhIMYdtYHihpRQP8FODPz3c88/ieYqwjHBB1NkbaL?=
 =?us-ascii?Q?pxn5pTABiVZbiF4Wi2J48fZDAk7Rx8xSwXgZbXXIym6Gx96QVkRYRb5RyfQE?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DZoHWX49w+EuoT1yq119RO6Gn8I/8bMbwyNjgv+r2NucznVZORVaQ2d8EIXozIXKkhgYqY+h+inA3Gw+Z2WjzZ4hCwNy+F8x4H/eSfBKpJrBmZ7yIfOv8xJ0TohEC9+X03I3E1Kex8RNX+seG0VcCD0BUgsiqI2trriHakVmgQqqub7ER6Rg32nJanPx5UrPFEORgftXUUeVOTv2Qcd6U+wg3mCfAStbqZEtH4ujhDtBTlkpes+c9FHfJnzK+26bJ90DQEHy/cpad89Of86KOpTBvrQJnWYsETd4+19EdzQpI/buPqTk6Kmr9jqmAY/DXM/7dWUmXOdUZS+7+/z0qGfr/T15DryMIopS3Evka5tIraNacGZBWGGbRCjMa2wM9ik/avEd0Af6R+CgBXCaVZYhJ/ivSotC9yllx0SOxUGdCy6YgX9j2RXNeFiuIK/0dkJAvAsKXYswidK7xZeF6oRMNXUESGcdXXgEkETu2kWQKnhdCLQugmDEKyfDmW8Bw+arW6Ec7sVzKrxJPbngR6k8b52yALwCFvQL14781K7p6ohNfIzFhuT2N5fLQGk6SNlzA5ERRjzmYZ0o+IaCsXJecIt3KVBYTQGZSsdnFCa+5f2kYD3k1uih2o46zsfYx2QkH3QEOnm19uHr9Dpzm/olI3sulFm+5OfhgMhwEVugg+wkjqS8g8Q/qw0dORSoGQqMeg6K+ni+wD4PadiPseWbHlpYYrwmNEOJd+9OkQIEdyIrCgYPdkiX83n/DhozBCIaUZUV4g7tAG/F+MyH+tpbwuydSyc2MPSxMU7xfLAb8Gfftld4eacBSKBsbfZl0GkMBa9KGi8lpMTF9xcAiWRpGTVgkX/5jDh67RaoP/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e1ca1-f5be-428b-0da8-08db239f4d9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:31.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60lB09Y5lrJW3i+ma59tWaqq8YeiLF88nf1kxv1aWRG2yO26vskq5v8UYltjimPlD3PYMbJFrRcQoLm/bRrK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-ORIG-GUID: uVVhkcZXxnlo_Y6wJcFeWKHF-JQJ7RzT
X-Proofpoint-GUID: uVVhkcZXxnlo_Y6wJcFeWKHF-JQJ7RzT
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
addition, its SCSI device pointer would never be NULL (so drop that check
also).

The only caller is scsi_try_bus_device_reset(), and the command and its
device pointer could not be NULL when calling eh_device_reset_handler()
there.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2c2a41b99641..5b51c24f7d09 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5372,17 +5372,16 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 {
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_dev_info *devip = sdp->hostdata;
+
 	++num_dev_resets;
-	if (SCpnt && SCpnt->device) {
-		struct scsi_device *sdp = SCpnt->device;
-		struct sdebug_dev_info *devip =
-				(struct sdebug_dev_info *)sdp->hostdata;
 
-		if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
-			sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-		if (devip)
-			set_bit(SDEBUG_UA_POR, devip->uas_bm);
-	}
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
+	if (devip)
+		set_bit(SDEBUG_UA_POR, devip->uas_bm);
+
 	return SUCCESS;
 }
 
-- 
2.35.3

