Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9906ADCA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCGK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCGK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986157D2C;
        Tue,  7 Mar 2023 02:56:55 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783nqY001667;
        Tue, 7 Mar 2023 10:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8FhSnp/i5FW6gxnbBvylWTT8tXuOk2weQX3imZQFZLI=;
 b=VnPew6DqZr6pk3CUQerUNTlsj9L1vWrTjgnbCtjyYVb7IhfEnlJLOJL/HBwEmL/X8bgs
 brmEHpWn5epvU3rHEvG+UCRbnSQHo0Ja1eP4G/c/pQ2N55lcfJACObIq5fRDs50n48C6
 z4SuvbMlrvtACne3FLDuhMYgYaqTlHpGwiJGWoX8Amdipo4Qs2Mj2mMQRJJuEhb9wOsE
 46cbfUI9Rw9I7cJ7w3Qfu8Mh8JSCKziy1ZPFFGtKqmQYl4w8/tiI/9qNUkdE4bgVw0Nj
 gIq4m4HA5l1a+GSGZAWCXVGnbpJwlPcsV0cKCeSjBZNYceUwsldWzlWGLuwi2xU/6IGN Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hw87g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3279Yv3D017135;
        Tue, 7 Mar 2023 10:56:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4tur3wvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXZT3MEMWpPpnDEmsc8UGoojK91LibHizOvHMPX3l6LDlW3HkeYQOc0CQETZ0Bn5N0JGHs4mJy4l043rb8VN9c8OMRe2g6rHp9Ut+Ea0YyJt3wBly4TUoMwtunsYnfG2bwqvi0CJGN95vWh6ysGkU9EUoVDrrEuwo799DMjU74RXlp8m95U6odwt35iStUrHSRHGMsOba4GmdB0e6TXzg+UIS80/J25jhjHyZTS+RdnmpNN6iCcmFhfKx8Rv3HwAc7y1bgBj3ONMOzKQyaan+Bmo67nVvX3vCRxzpKHDQKRTWQuOkNrpqeifQeH7ArxMHvV+HuAPeOsJQgo5y5TBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FhSnp/i5FW6gxnbBvylWTT8tXuOk2weQX3imZQFZLI=;
 b=VHuq7nIgxtao6XQA6eH5ae9gGtjeeYaWC0zpd5+qjUWQZ5YvlN2IEDf9ceMl9DbvPgMNDgRtaxcRNt4hvOV+xubqymrxgs1y1eTR2HTfAizKC5M06lgxCspF2ZjDrMuMcDQkNu783Vj2Zh53g+soAhgA4j4XzgIJ8+oVyvt/69F/wCHADM0+lAAuhhX5eXbmalnlF/SijxVIlr8qU/6Bnuk8T29X6pH0Qk/cW03kS9aBIzcK00LVJm2tIBC1wZJeXBNscoPWVjLZWfR56mAetaIH3q2AGXOMaHtRz0sKQtzQ5qt7FzDDbwpISOYYVq46P+S1iEvJXVffNx/5P1Ni1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FhSnp/i5FW6gxnbBvylWTT8tXuOk2weQX3imZQFZLI=;
 b=JuJUpSEvpjD/wP3VMZrwuOSjDGPiR5mDqr6Y5DUcIttlfbG1L46NP2vsHvPdhcJiFY2sQbjh7GVIm+K1ncsVsKX1wUbTpAG4yn1uu2pmIJdRGisDhZIrK2GG3nQ8KKy5spYPhZp43cvRC/F0Zxrb5FQrWf9VAszbnczXhTMSpE8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:50 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 11/11] scsi: scsi_debug: Add poll mode deferred completions to statistics
Date:   Tue,  7 Mar 2023 10:55:55 +0000
Message-Id: <20230307105555.3745277-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:5:15b::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: e470f735-aab2-4417-66e6-08db1efaa75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LqCq0bIGWblp5n9se3F8r7Bj4XznANauG5MFsQCE+yAf+iHiJ24Ty1OomdhIn01YtAkj4kBpoGxsAvATwIHacPkpgOoS7guOCYibTwIdykmMKrs4ozdijFwMVZAE8duwUv3Jy4m6mMd5mFa2xTcUh3L7bHwPivMHw01ofZtssKp10GcplXrerRDLJkRrIWktECwQpfb6H+cGurNZfnicKybtbePDiFPaXw1kgdNRpOLeAtmLn6jAp4Ql84bzP5TsRSUjt8Tm6ug1xNIEQiyarjzEWHFdCxjWFt0wDVcxAXfH30u1Qi2H4BOvTeE7UZaMJSL9inLWQ8TbXebjWUNUtcd/tkLzB1ex/kAqcA9S2q1nzyEJYSNQ9op/JeHXxubRBKyOIkRuoZgcv/VmNm3xU4syeZr+m+FzN7wLl0eX1N6Mp75b3n3RwRZRKlmysKpnWC4uoHpd0D+nI9OZFocVPV/K2c4nPP+KR0D+o6ZGGYb3pryv1/WgxasmFZ0+oddfe0er5LxXhN3jGWoWWqnwdQ6dKvd+s5ZJVh5wjsSLOMSblGFD0dKpzelve0B8tIV6d7hNZ1mr6cs97zDduZd9HHQrjzUyGq83goHmBdByA9h2ssBKrdBPnXTxygVKIzUH7xQ9ao7B/KOcCkhF9DbjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bM3qlTf2+YrgafV575SaWUO/iJy/izUGwkVvTMaaeVj3DNnThsQHeqPaxcfG?=
 =?us-ascii?Q?dLq6wvc75fVai+vG3CWv/naFBRjcnwrPe14BxyLktEXAvYiZ5+xMfb4oU7RS?=
 =?us-ascii?Q?ANDWc2MU2my6giPWVNlD0jTyr2j1xyMl/M2sudkGdfVVOBx63sKZKB87JeQM?=
 =?us-ascii?Q?WtRFJf/On3kgPXih/5la0X6BjpjD8kDnOZBCiiGt36N7xVwl/PSFjCHKDo4F?=
 =?us-ascii?Q?CFJfT4AS6VRdqc21MXh7Rb97b9k00DZt/eteuyaOXUSAurQLkvheSFdXwlmY?=
 =?us-ascii?Q?o9f1HErWcwR7J3ZtwKb6fUZBhMg4JFRLi7KFjXXMy4TS2qdpRfE/kKwm/Ipp?=
 =?us-ascii?Q?Jcvj5H8kyN6o7XHOYPgbYiCDLS9h/6W8J2fIlcMXPoIuysbpoWqTczXm4OzO?=
 =?us-ascii?Q?l4fKz8JtiZ5/0uok15Fkflm7xWlo3ZmmWC17FxL0sPY1EJgaIZp63SEWZAg5?=
 =?us-ascii?Q?psP3UZ4WH+og1NL9dBQ4mv0SJBSpjG1pgXuAjSA9jZAa8KW+HLumn/71DT3O?=
 =?us-ascii?Q?lIz0QShUMy4DSCLhb3OY8xPwnBEiQSV9C5VvVazTd8B5uXdBKfpSrkTbrM/y?=
 =?us-ascii?Q?1oKyj8O2vh8zPAeaXgIW1XkaVGjQI/0zoh5E+K75as0+B4mk9FF07ELi3CPS?=
 =?us-ascii?Q?QpzDUeGjj8ak+9y+ARnBSgeZ7NOPci238SWCxxZF650/Z2DvcKvXjHFzdjOe?=
 =?us-ascii?Q?WTKSCJPrraBSTRzVKR6SUC/IAcdpv4PlzKFEw+4H74M35WoMMzXRJn9wkrrr?=
 =?us-ascii?Q?xE+0xNK/wgHYCrJsDOY+MdbRaqpHh6eh3J0l0Pwa+MdP9m6jxAU87KCqXKhQ?=
 =?us-ascii?Q?a/22nmUqhfpN8QMpQRuXbKOsCst9M9fy6n1E+fNTmEGRqSAdjA/RysbMFK3p?=
 =?us-ascii?Q?q2XEswAZ1THora/ZElqiLIBgD1VSzYALR0gwTw+A9U4udSgLpU1tjIUNe7RK?=
 =?us-ascii?Q?ZgVbwH3zNYvQIzRHyIISnWEXyjWMs0Ku+Lw730WgPjkK/tMzv2FJ9CX5FJDh?=
 =?us-ascii?Q?btPbD+0mhslt1W+GmU/t/Zk9G1LVawcQg06whfdMTNqFGSJgEYwNQHAt4AFy?=
 =?us-ascii?Q?0J9SfQxA+C5C0/u3va9+Id9xeGhzXZ3oLJhjeVyfXUUb8Y1Cbh51msLj8pjL?=
 =?us-ascii?Q?eSV2UHIvnl6xkBfGJGtQ1om8/vqL5g54QEnpUCh2+Mqx1nfphhbRSBwjvad5?=
 =?us-ascii?Q?Ei+xuSUkQJDDMWflU6+AGwRYYXFEjyHUgsHF2+wCVvikt1ZWjf8Q3sYmnTaj?=
 =?us-ascii?Q?Mm5BD5YTvcClgun+ery26rqHETzbLd8ygtN16hs4/Gi+6t6zn+DkVsw6CdGw?=
 =?us-ascii?Q?m/+an2BxQhqXyi5gKP/DheAwfyLdT5yUEN9ZDJOzaFWzFhI8ohUBrUr2UjT3?=
 =?us-ascii?Q?J3Yh8TsFRHmCvBThiZlkRH/6YmumkwJ2Qzv9b88I25e224ljefkvc1lwd6OA?=
 =?us-ascii?Q?Otd149swgY73aAWVodsUmz6G3SpoiwD2r5s3wdR4+x4vyYu+fN3OCdHenGcD?=
 =?us-ascii?Q?BFbRuAqoymtzDH93JJcRYsEO4eXmEFJ539LBZdHDvRy2HTfGpiOyGhXLxVqP?=
 =?us-ascii?Q?l8qFKpMbOzDFxRyxp29w7EWZCrno9QMlQJTHO0eo82aEImoEU3Zf58wgT1Js?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dAdg3zlCNq6crqIzFVDaIBMspPeSzxnFSKavp8ioBdG/NsMjtCoYuhoy7dAN/ntAYGMBIaoguwuaxJc5oKsDl1N2juhMZY/rjShkaWItU+/k01VdBwHeWhorhP6eiJ9nmgj01KW8uS2h8Z/ahS/3QtF9et4Nat3ToFSoIW1HxHyPZC9Iks3EXNGVYiCCNbuVIvlMnEF8Oc6DgLt6m6BGgJvfbP2pgPee86S+KaBDKXvoGyQVkGm9ha9l5lSmkMzpRXaPZLCHoVj7g48QiCrrqfmbz24fvhKiIoBgRyoHczehRJcSMdDola9zKX2ceP/mqgs8ozH3Bk5+doZ8+qfy/gsC806EGlvRM/x3WwBAEA40+QNtYgczO7f1s0DI6PKoJED4oQqCc7DVDHcYJAIQeP9nfW7Mwwztg6WRlx6wYUwudhNXw0l78EsxxMg+QGax2OBvo1QUw+l9dY644HSyMP327W6vzlqOvVcBtT884M1Ho5nr06H3zUk59VCVM5i2V/1ESdxWYnFD6kwl9Isqv+jjQOD6g6KDGskwCvUoGkYQQ7s5waHamOh+pgl9PTUrKeYQWoTdUCIvpmo1sl5ejZTV8C+05momLshlwj8TtvISIozfC0ay9utKy7Aci24O5D5+bgjHUAtYPczurw64LWIrNmOcwEgu9eW3q7UbJlYFfrnP/6PVkZEEoraxRf7OK5nhZgMrjDrKHC5qXhFsX2xuZCpbhxiR6dozauKVsABDRPgz9kNqq++6Qms6ybIBpJBMQHRR5YwUbu9ZuLWAmhUXhQFcT6tc11RNHmX+ni6XMwdrjwSa7MXrpMmZudh/zSfQ339ZutQbNwzoS0I0vA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e470f735-aab2-4417-66e6-08db1efaa75c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:50.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foj6y6vl4c22OgQSxc1m2KeZGXjf2mRSkzI5esrKQjDEEqNXfbBKoSG3RyDRTuSDJULs5aqeUCQm9RSXJz/goQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: 9wI7C015PaeOvfQfate5Z3qg_CFkiZuD
X-Proofpoint-ORIG-GUID: 9wI7C015PaeOvfQfate5Z3qg_CFkiZuD
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
index 6cf30fceab78..76ff8ca6070d 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7537,6 +7537,13 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
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

