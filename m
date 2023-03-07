Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF76ADC93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCGK5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCGK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1215BC8A;
        Tue,  7 Mar 2023 02:56:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783tAu023583;
        Tue, 7 Mar 2023 10:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=6PezMTTwtTDtsA0UTwC/AIqB1yiqVCXGZoXWdF/TFfI=;
 b=Ul1swIDqPgd5ZdWIG8xmQdCCRjcy07666FgpwO9U7HhpbJ5r+oltqBPQJW8w96e7GILr
 V6emteW7IfSnnJUc5LbNKXMSbvxTmso+2eoyAz1lC9zu8gPgl+DPsZn3wHVMcaabWx7O
 FQYgw0Rg5u9dwOe9kCehKauL+xW4EPmsOfy//Pb8V14AAI1HedTJcsNwLoQ9GYsvp0mZ
 CvdWGyGiGaEsUwq1Lqt2UJQDdORfEPvLCZQcw8xuJnSKlrbBwuFq0UyR0DRqoq0nxIwX
 7SaSaU3sQRS4av0rhW5/9tWncEQ4V38Zrl6xzkPEQCnCBQf/tyqT98Hy3kHxxKr54Q/I PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wn74y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327A86Se037277;
        Tue, 7 Mar 2023 10:56:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txeavfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzVSxYo4zZXuAUeGniMR18CBlJkBSGnnvQoYkJKLK+RDQpYuwnnrhJF1qtZ0qwG10FK7qbzhAmI9oc9q28WkmGnf0brydVsXoJ+MDBXxCb86UEx/XPukX8UGtAaFXU4Rog8I7krQTMYdKosbAW7EEIwpjJBRLgaoeQ4cSomWWqiC8ZgBxNoZHgFU/NfuB2S8Im+IC8SWiowczDGlHTV9UcK/2PPRPuM067/GAriTW3Jl88cG6TMRnyV/6JLGxK0m3TLdKl15GuhoJLBziDzAvZ6963NPOqqg0mOmRYN+8bfdCtX/xA9fLliTZZ8PfzuYTdJ45HTxxsNMfH8zj1eJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PezMTTwtTDtsA0UTwC/AIqB1yiqVCXGZoXWdF/TFfI=;
 b=nQUbJR7C1VnRhCeJfXjZU26HUVEvPOG8KZjT175AAj+FOVS+pDUMfz8Ssab0dUmeT6Bua4Jl90H7Aul6nC+oexweSlgPBA2OPZ7L4Hzn4WTUfsCTsml+3ocP4fuYHUt1IoW+pNQsBueUyHo7svXV/2WmILkjVtkZWrObG0NNkItxuAw5uf8g0tnW7tgMyyDAeUAWzwLw4sjBpcSTQwuMGV8qY7GiljndD7vD5sAA2+ehKSPew3NzU3irf58WzBsR3ggxtfIelkIkxCCLAlkHVFb82u0TnBF9Bzv0aqiWpCq4EEWszVBLjBVD9DcYdiPq3Bywt28ffGeYGkNvWHGnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PezMTTwtTDtsA0UTwC/AIqB1yiqVCXGZoXWdF/TFfI=;
 b=0UpXqjVqMXN1Y1JP3tXtaZaxb61B8Fe+uV126zS76g8RuXrw0RfJnzEM1oXn3tqv3Rn/6muisIp0rtbuhNkzmgt7oW77R1ivsEOKtlUIgmoqRFpdBI4aUbTCPbuY2w8LHRTy+7Zuc2N6Kq6f72DNVfKB1ZeNKP1MhkHsvSFwkPY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:43 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 07/11] scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer check
Date:   Tue,  7 Mar 2023 10:55:51 +0000
Message-Id: <20230307105555.3745277-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0036.namprd18.prod.outlook.com
 (2603:10b6:5:15b::49) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe9f871-a98a-41d8-0394-08db1efaa386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvNz+abhz8ELVwLbJvg04fLmecIGHqDoM8OkMIcYV59/A63cjZPBNFWPBOhDiDmKAMdFvuBOtnEZklhTaMEQKoUyohGCCYDlirjYFFMURnhUVklvNp/VMY9URSheSHgTtgYuiFjdY2lQqQc99roA3rllzKD9agPVyXQ/HeksTGDN5OJkR4xi4isvGmCO4hGHuk9r/JqkEGWN2qpbrqPtW78Gypw7jCIBRKSzMwA7JjZr9QXuh+LkPH6hl8gMOdaAY07/bn0d+9A+v68ac70/w1EOjLEn57lqb0Ac1vAKOHJeR5q3YEsqEn7G4YHu1FuLvqvhqYVpShJpyQnNi3P/UIXCeHSqPHrgrQUUrHW0gB448N8y7rKOP2m2VoUqzp4jGXiJ8E77e6lrBKnEWJMsyQnmFZdEQHz9VNDrYqLdifxQvkU3pzhu8YjAkw7x3nx7JWxrGJOkpRsxShv4zAUKXCl8CVkeAT7i1lXkpdXBrO4uvSkxMIDGlqXsTC+H+6DS5jhldkFTjnXpDkoFYps0sr5qMTlMrt8L1cAtelHHH9ng1mVsOvCW6E9AkUTyf/V2tvouoP4lnWBAllnuAVmifVQWHa/aHTFof3Lkai65E/ObvIVhf/QTv7dTvDYNrlnGeyA2s4/dJS8vt7cierEzKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QfuLknIoR1X5+psfLcwZINWD5EcuS2n9pB65MRFNiMrLvJLJzJogGXjOsFLG?=
 =?us-ascii?Q?hl84fjTAaieSi4htdxuv8qq8GFan4JavOmBVAC3BwAldsUb3tHxqvmilazOx?=
 =?us-ascii?Q?OO4TjoyueOlKuHV3y5fT1Bw+cjQAtUWqc6CODGSD/hq1W+dcYjAfcxezd4Kb?=
 =?us-ascii?Q?YWXtPAaVjoK6cdjdr0aFj+wkd9p4xVxq+4F/StJfMmSjMQxxcYxabPRIDqJy?=
 =?us-ascii?Q?T/VJqivL1PdzlEc0sQ73VIdVO8apUaDzUlcjQTIHrdDFZVHpIhzfFxbAx0Ca?=
 =?us-ascii?Q?PVfuGcZsYc88pFovMTXRcGngfDrzJfUyG0PnENEtEB7lOqjG0gtoCZpraWE9?=
 =?us-ascii?Q?CrEmuxaJj3Q3U0jjuWrB03JKrPPcyOqaYwQduseV6hpsqZv0GM594qv6q1Mf?=
 =?us-ascii?Q?Pl4darTOZvalt2XmJIP8uH9XWxMtTSzzolAJkrRY31Z0eSwqDU1kHoL/lDcI?=
 =?us-ascii?Q?FR4tuOYnFrH8Ji+BuGaiVueOMc52H+EDTqfJfrs5gQToby6v0CGn6ub7oxvQ?=
 =?us-ascii?Q?eVWexXUCiC8Nkr9V5KoKniT2RVDq/Uss097CVSi6P17Q2wTYRhZ9Pszix685?=
 =?us-ascii?Q?42RNNn5FmCEjcqHbUO0W4u+qBF39E/fIiBZvqFrDw3ZtvTKUmFiMxcUwExyu?=
 =?us-ascii?Q?szMv15sRdZAgwp2TwTRoofc4W2uAL95xOhyntKBzO3tAVZTKf+apFB4zUvqv?=
 =?us-ascii?Q?5yN2Mmtxrqx3NMe+TEohKvQ2L0I3qECxNErNnNvQG8wfZKwkNI8aSgHfsXxx?=
 =?us-ascii?Q?948nXB0b61kMfL5X4+VHC9rnR3UGRu6mAtxXmBwGPbSwkrPQN8JgywlBtcBG?=
 =?us-ascii?Q?Mulq12NN+u0rWjgWBnrsWtWzcWhJhTlFFvEQhUMIaYn7FYp8WX01Y6sgWKu0?=
 =?us-ascii?Q?17RcjP7exUO/fIW11MY1B5GkB8w00n4TNlrvvhWiLMi9qmTL2kIi5R/4fmf2?=
 =?us-ascii?Q?1f5R/SZmCV4ar5ZqSU1lswVctne3ls/RKzs2BI9FKV0/0CN6SoTVPAYKjJy2?=
 =?us-ascii?Q?QcezLe1MrEN8lx8lUzuDMIB+nLxHnSUnOx1r5dJ8S1zZCBlvpKf68IxpYILw?=
 =?us-ascii?Q?BijZ0LXKHSOCvUHjg6pfWVAm8D+T8/PtL5rBlNR8tgX9Opm1Cm9ok63buQk9?=
 =?us-ascii?Q?YGFYDD2mVHywWh9efuPUXzRQKk+WdPXqZHThav8mNMDFxoS934CMyL85ZZHI?=
 =?us-ascii?Q?V4oyuQDc/LZ6xJEEeQdph3jerQ6N00X8jBVElwmL2NqkOh5+EWpeepPR6EMd?=
 =?us-ascii?Q?vZy43+HfPZ7KA+zEctBkDIQQPfOxyGSzz9WpNg8R+oGTtkBAM+kpafnmA5ew?=
 =?us-ascii?Q?c+3ysQfEeQAEqiA0G5M0LYIJJ2Ej/NoO19Kvi6oJmu0v0TtWssPbSV3UNrSe?=
 =?us-ascii?Q?UYC3cizaUnYZGAUhDz4V/o1pnYfEByqRd/RGtdlhf5vHy6aaAOJZpNqo3OfB?=
 =?us-ascii?Q?qPXwapDnGMk7B4T9/GnVXmUH3nsK5eYzckU/zmNHWGkHja3HtIGA5SFnzaJb?=
 =?us-ascii?Q?8XhTkGr3qNoSMDbuzyEgoZCSNOerXIUvIL5r/VMb5GnKeDj3imSwtVfQIAH3?=
 =?us-ascii?Q?eJQ6QCrWUfDscNsRORMy5DlhyXRRkdIdIs+62tMqH2wWpbx/lDUvN7ACjJiO?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dv1mImbievYVzpPuiKUAflxs2uMKMankbgIQFD58YsJtRq36YnVIawzoX3kQq+/51if8Y7ZGPWMJCVWmDsERsINTWx1xPDh0At9Hfs3QyK9me/i4zeS8VgeM0OOsw5UXI9SFnEGX49P4n0MavmfNTsnJ0wnQLMHQN2osOEpoXMb76od+GpYDMWSvZOH77VK+iYudYyZzH12yXtAU++e/eCAqDqd5APRjTMo/4//Oc9N+dPCJIkafFUXPmfHkHD9KYv59EdET8L2g09M7OQfaX+S4Vr7G/1zf/UHdB7/UfS/Dd3WvIbG+bxJvXnBnTTxUsLb1T4CAeb6SCJbi/ExnsgVC33xtLFeGO7OLrcsHPTFLSxMSoTBisx/TE9Wy1Zc9jrXYQeVXbkbP+lxpSFV8lB7ZUHO2B7gKVfPrRc8w51NmhT4uctq/bP+fjurfAnRQKdQHIl/40TxfyedosIfEU+XlmCb7PruiaXxPMAnreqDd0zU4GOf1p/VZYbxgWsmgGxIVcpi0G+6gdGX73Dg1DIIffwT2fOGrtLrwlH1FrUY94URrkgrsSpBeUA3hb7AFzB6Q6lRYdo/zYhB6/ERx8pm0L7DQAlQxwhcW37KwuNOmNBeCQaQoGWFAQwOS120BvhTolHSQX8QqljwaJmHW3Uo3zykkUQAPSdPj+qZpo3UBgXqWxkNGQsBfq7dzyZGHLelj8unLP2uMqpS9EdnrJifInkaBbckV3X/aaJ3VyyhweBCVted9l3J9so40xnkcxKT29S0eDu3SpEroQv8kALReJlgMZ328H21Ng+aNG3iOjYZIymoNCWILgWGr4V+8tk14m2/SfxFLX5OitjWIvQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe9f871-a98a-41d8-0394-08db1efaa386
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:43.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/Q2A9RJB8RB5rIF094RYiB3sUbTL2RVjjnN4HWuGTq0s6Ic+DwtQnXISjIc51FEBn+tgJSmpB3hPOWfe39OoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070098
X-Proofpoint-GUID: 5c_RBjOqSlILJBrmgmy5PvcIJife8IT9
X-Proofpoint-ORIG-GUID: 5c_RBjOqSlILJBrmgmy5PvcIJife8IT9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for device pointer for the SCSI command is unnecessary, so drop
it.

The only caller is scsi_try_host_reset() -> eh_host_reset_handler(),
and there that pointer cannot be NULL.

Indeed, there is already code later in the same function which does not
check the device pointer for the SCSI command.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6f1dbd8dc37f..6707ccdc07c9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5446,7 +5446,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 	int k = 0;
 
 	++num_host_resets;
-	if ((SCpnt->device) && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device, "%s\n", __func__);
 	spin_lock(&sdebug_host_list_lock);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
-- 
2.35.3

