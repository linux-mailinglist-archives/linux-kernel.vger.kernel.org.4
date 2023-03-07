Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275AF6ADC90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCGK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCGK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F553733;
        Tue,  7 Mar 2023 02:56:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783sRY007655;
        Tue, 7 Mar 2023 10:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MvpuJvsMTRsA31XLO/mIPNcrtilaj0qKlwFqNMZsDPU=;
 b=18M3dlsNOaEXZop0M/8gekufgU81xx1Wavt+0pQj5OG4io0it26f+v6yYx3/86PPtnge
 rrmkofSD7UUxcSvPtl8TeQ/4MN3LN9A6B5gIfTdWejd98Wyao+BeAuUXo7X3EYaZxOkq
 MCapc0WtPpYvP7IiEbzgcaxLZwjWlEE6mY1WaSqw1ctMX7R0VIEm9FCkDMSFDLKQpymT
 CsHbVCyq2/nnWF5j3f8IQYJIGHX8fI3FLkebFEdU9TZ4mqmRg25vJ7d5FWIXTnEunvs7
 vHmd1FPlzY5xixhoAoYNq37EpnJmuivgdmOAw5YDjEZOFvSj1NqJwF9hc9qXKq+3K8Zl eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn91gwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3279RxW6011193;
        Tue, 7 Mar 2023 10:56:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2hkp1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esNdDcNm9sokCshCod6eq4c/pktVi8RpwKdqtTh/AyIfvl1IMmKl1ytAJz3WvwHJDGbz5bLWJtxOqt3y+2mxAouSXnk3KigIlYFq37Js/GtMkDRatqsFlOdaSDATlmFd8amv1wwKe5Nyz1I28Nef/VMZUb2eZNKFCvtpzOMwM3qIiH1z4sU4klzpVrwJBpKqeNCDA4Taldd2uJWiRRLVFZtDaHe27XkQPrWDt3m/ZlfyhT6uQ2KYuq/TCuSkz2lFRRyt2c8LoXljAtf6mK5spqN2vkz6OhIN50ewDTv3VzAbH2H1LHyO3G4jr5FylJQhsRVBSBxe6BIdysW6CO/+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvpuJvsMTRsA31XLO/mIPNcrtilaj0qKlwFqNMZsDPU=;
 b=KJKzxBPfqnN1V0EoJA4jer5vIiJVmQIwbZCCWyHtzmYtoltFBAij/3LDpY3p8Ac/qebSV3cg1aH8ygMnf4qwnrLqTl1Q6w2ThiRfPsOw61CLydXQq7z4q7JgPn79IeXzbrOsMK45zC3J2L47jUHgVnS8WBkQcX96PcZ2aQWaZgNvdtEd0BFL6+oWBFq5yojqxO6nHTqmuy5BK54RQYq4SBIK5M7ZgNUE4FiHKMkv5KfE0RfxEYIdjGJZ3XtlMhVyVwWNQoOrr55j6wV6DbB0rvW408M0FroT39M6detYRXV8wekLHM3SqgRCR8pQo1SEFfdzIKnIDFjgcVaRG2oBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvpuJvsMTRsA31XLO/mIPNcrtilaj0qKlwFqNMZsDPU=;
 b=w42+evw41YTcpQE9/KQgGvDz74GnsW3CazQrSKmbTcMJvadNhXLcXK3vzMA/yQeRxm7GBJvXdBaXpaN9NrmXyY9svZ0XEiySvJNKu9JH/xGme1hhurot+jsV/weUeGpZVQAuHdjA0L6GZa/a06qhkSc9TAvK8umk6DnnzVbSrLs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:39 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 04/11] scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
Date:   Tue,  7 Mar 2023 10:55:48 +0000
Message-Id: <20230307105555.3745277-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bea638-15bb-4aea-ed78-08db1efaa0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HHbN4jrX63bhuF/djm6chnC25Ol+MBTnslDDO3M1GVjDo3ZvrpVpmWYpI7XmgaAVGECYhdddqfWju/QQyooIDk99D+vfqY9h7aoNgfvUbKF/lgWsHVTJasLuNKznlGU1EzDaDqmaA5pFNttDGoWUXeeXNFzzVCwF4bxN9pijMwoX0bC17BP4cDLmTiTb9hrzndFsW4OLfBztNJ74bpBirSaDt7wWdsBzHVetCaZjytrbxa9korNBBDLeifFw8IoxfFZh3DSBYefNPIfRrf5tEJGGgy08X7T1LG+7Vc3HQFgxxN6FMZK1AmM0suBv+uZp0UG40Ja668IyjRtrAe5NaSTPpmxjhgZq2bZeWsZnkkKNzFbWjhBn9is8ae3o1/tzE+RKr7OoPZO8Hg3db7IhvXnUWJPbTzg3BWQzWTmCL6IHjjnq4jiUCSxePhBGNEBlWzSRxNe6C9lT9fvjzomKOP3IOAkXYZcngYvbuCQ3lCjc3eiBCacGH+5ivI9T0mI1b631jxaN4sivXDPLergK6X8XStLivayM0+6y7jxQ7hAI4ToK/0LHOPlGphIUvl2sm6s6zQyKhPTSvUSGARpBoN2b8YXj9T3npZOi3IsSheV486vRH7fu4tW6qZDX7OaqoYG4rTkuEqBlqbIselX2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XEhQZYKJ7WU4J6ooD2H1VkctEuu6H8bpfZnEfrOkeHoCF2TnPwuaPfew5FRK?=
 =?us-ascii?Q?ShJbFKJCZck4SwqR++UfEnjZKQCcXWeccXtmY+WCbAjikj7/0zuBnya60/bM?=
 =?us-ascii?Q?WIHMjFmumRLkB+bhfJbfXipkeIU4dSMsw96yIIdPY2rN7J6U5a4LmBz6wfJI?=
 =?us-ascii?Q?jutEMcpSo0KUpSMHOpPqZI1W7Ou7IGzqngc5KV8Mc8W8P59rejdxIUEkjHxv?=
 =?us-ascii?Q?eLpkYCFuGwNDEMbZgdSphmVsgcTPz4NRKJYQeren4XSnJ8hJsKeK/vdmIaDR?=
 =?us-ascii?Q?tTWZVTtRresBs5vopAWpfs/X0kPulIVGpC0WbIcaqPzBOfS2hyEEt1bbycg1?=
 =?us-ascii?Q?79h9wOprRNBKEatxQdVBd4mIfC8fZqx1Wy8O/igh/QGymYlEuR45VwF2g5zA?=
 =?us-ascii?Q?XKcqJxd0KxN3QFVjBPlsf4gJm3rYAaZWz/hu1csc7kMAe4jBEx2WKkSVLOIL?=
 =?us-ascii?Q?KYFn4uAV2mOsoMmyHbJW0lPLiB56JwQaQXUpg0MFer/njZqoTf27jEPnSXqC?=
 =?us-ascii?Q?EtJCYeCrmUS1ii5TR2S1dZr7ZOlo91DPuDnp1/zWpKH/ZAs6q50muuQM7vzZ?=
 =?us-ascii?Q?1x7UOe//w8+W4e8shQ11SFWEY4cvaQVGQDzzvjVIqVDe11MorZ4I4DIck9dJ?=
 =?us-ascii?Q?y+uEGde/cBZWewhVy1cZUWX+/aoPWYTEMgN9ne6m6E930F2edp+jd9DgsCjc?=
 =?us-ascii?Q?ntmrPIYkogA1cDdKBedwKICHf4+NGysPIauessuLfrWFWRjWSYe3HEKayncB?=
 =?us-ascii?Q?gbXTIr5Vj14XJK4oOXCBIGb9QZHrBt3IOPrFy19HtfMYB1rMHQGohHLhNNjJ?=
 =?us-ascii?Q?PAA0nQFWIMsnZX5sQhyFNDikt/ihR18UfZQGkN2QIfpXmmzIMq8NpjsFjy+4?=
 =?us-ascii?Q?mqhyHL0Y1jA4FNQ0tZvJrfDUR7jrxkvIjJ6ME993mALk5SLzrgxfpcjJy8wN?=
 =?us-ascii?Q?RvQ5Uq0C6pXhh5rXDxqxVXMLLmK6fbmtciPnzvE9Twq+IldetcNlXmyyHDEV?=
 =?us-ascii?Q?+TkBYuWvySDevam6O+KEHGRHyPIlF8dcdikV9aZ24g3SpUQCROXCZ1DktVNH?=
 =?us-ascii?Q?dUQwMovZN7d52HJyti+p691+lTMFgsIZKPRftndSTwkjOuuipc+LkBp5To5q?=
 =?us-ascii?Q?J3A0pJo+9PVkjOfhYSuMirszPgMhg+I6QlNrcaDehUdKKw61jBd221iy3rDl?=
 =?us-ascii?Q?o/a3HBqVTlYfFbZM/9g/O9fGMlDsPvTfkduQf0DFp/yFD9OMkhBTYHM3kUOe?=
 =?us-ascii?Q?v9ciHCNH5VxBgGX3xOW33HhBm/SUIfXOxDrFyS2WtfypVPb0IKNAnW4AAe1d?=
 =?us-ascii?Q?3yhNMyqdNv4uCbNWS6HBj8H4G+cNtfMlfAumW59jGshsBB12UenONYGnNsP0?=
 =?us-ascii?Q?gzdRsmvUzTjdGDBWGW3/TM3GgI1RqLgDjOVX7jnEIWKhfqgXC26tFSvCdQTA?=
 =?us-ascii?Q?HYnm3I44ZkrytPPXoRSdeiC93WXoy7s53gxdPaf26ZgdVL7NrU7bYdyT3l58?=
 =?us-ascii?Q?m8GOn9M7O16HZ8zCNKl+LWLnNcyj8sgNXPVaiIuQTj+zQbPJwNWj3OUiWtKE?=
 =?us-ascii?Q?ktGIxnioRB9roPWzWGTYqK9mksAfBo+F8q8V/dCz7TmSBYECX+vO3tTf1bvc?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +tHJUUr+f/TiAG/f8P8AT19x1MiW6MI938vvTHvzZdEXmnWthk32P3/64gziwPVTWg5zyUwvzyuWRqmjzv7r8IaEOykQWgLpGne4Zf2MldP5O223pxrBisETcGASgZFSIUa5tZRKK+TqrSo3bqTzc2FAjuy5juJoKhqwSDAsLodYDQnGWztse/r6lr07ZW7teKugh12xVBFIcKr7YyGm23WgWl9NupH3VMFk0noaAVpv0me72i2YmrI4EafWTdWa29CWwUrzuGtx+LX4bFqKGokaZE2yBwVhmHu6TMCXVZI24WZphb5QlwjscZhtVbjefLGi4iqAKaa50W3Pca8CihHJEyTpyWwRBgRSlDxI0ahms2jwvHPJuZ4uIF/8V8/6rBH5TC5gAGAtThYAaghMwgjB2Ep6wyc6+A+cH1bw7VO7Rhn5y47/wWlQdQBUDXVFswbCAXPzOVD/gmoNDSeRPgBB9hFu1aDfkkxNqWIBZC0HGlLhYLQDMoyz5+GaGkAs960KvK+ExRg2v21nBS/f1nbfXZ8UHYg05CLA1g4rxWtmQiigA/P2AGu4llyB8ZdmitGvnFO7CnVPdxvoWh6THhXj1Yej+4SkNueWT0DXcU3p86u+BVaFhIv8ljr7Csv6lg4ct0qbcgk0K9v63lTAgSYF5trhyn+uB1/yOeM5jCw3Wmb+ajbKVkaVdyM7xeXV9c2KF7mISD34qCkXJYD01+0xz+TgZAHbl4MxDjSy8zIbfLl/f0lZ1P8kWBoBoNOXsxs9Hw3n29QZNSM8s7uxx1D4orTDnW9bff6aHlIEt7/yjP1BFagX5fq2OnzCzI38DaUFIz7LmnjdubNZ6Brk+g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bea638-15bb-4aea-ed78-08db1efaa0e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:39.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0++ctyKJtxG9UeZWOt/HSAAmQrqDvo13l3PI8J1yw/KcpGFRy5jgC9468ySECWL3+m886VTTH86X2fhOp3ZaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: Yb-Hslj-Z_CdUeKqp6_Wsj-KAJ1jooBp
X-Proofpoint-ORIG-GUID: Yb-Hslj-Z_CdUeKqp6_Wsj-KAJ1jooBp
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
index 4f971e8bfebc..b67d0c72118c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5374,17 +5374,16 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 
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

