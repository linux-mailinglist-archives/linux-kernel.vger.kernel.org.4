Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69DE6ADC86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCGK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCGK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858958B69;
        Tue,  7 Mar 2023 02:56:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783mut003734;
        Tue, 7 Mar 2023 10:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=UUx/WZkYVdmToGLEBcLIF4hOlhZTRZatODE906Il2VA=;
 b=y7xlyzwrIekPrgK18mQgqDRa1AQvkUGKdDHsGxEEU7/6n4CvQN6LdgPsSS68SLQFU+p0
 PdrvCigZcARO8pX4ItMBrAB8hHCuSqEMNGVOfMUjkX84rMDVkGJLS9mkjYLfM6qtfVfb
 7eFmiAc+oMhptdTJa0gKnFjsR4YFFmssqwplvMGGcJZBm3BVlJYsdixr0tyOilZLDRh8
 CdFFU/YSYQmQ742Qvg6Jzp6NYngwbV5zhWagepo53cyDU5RQ3Dqb4H1ausqp9pNsltVK
 vfdZ+/X+TRocVmYYINzIcumvJoUYLR3S94KdCr30G3uwVRffQ23Y5LjORDBgPSjCf/19 Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168n72m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327A0S68019086;
        Tue, 7 Mar 2023 10:56:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4tur3wkf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oefmHwhqmOzNR3M7lwJ96cgaPHsLRHj2DCxIsUjwEIVwpauvDtdL20ijc3KkpNx5t7OJaVT750c/hL2y+xMFrHR/7qBVZGdeaLvb/7doTdEmn6FEc+B83ZeifSb8RkSnqImsyXILQG9hRE4ipkrcZiX6P/mBQDOpl8GMBwOYlApv+QDchlsjTeCyPhINgHf9EaCI9DlpElrgTncWAOdqlEaJ2BlNw0AP33d/iDxFeQ1oeosvZ7IfItAUdVX9q5p2Qxf6XF/Sxbq6fnFGMSwnyuNhuxOczHljP+Rcaai6frv+XZOFFaeBMecNCvUOrfvaieSocEYu404WbsnZ0RKAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUx/WZkYVdmToGLEBcLIF4hOlhZTRZatODE906Il2VA=;
 b=YsgcLfrFDpfVC6JcGnEnnS3YoLN5GEl+LAfKuPUcEjdhgFAySCDf06EAo7o9sWdoFD0mAb931NkpcnIqC70B6uqYzyqaE66iB+cPPdWLRYZq5PNirck/LkA6APEYr9ezczHhOuAguT8b/xL+Bz+n6I/NelYu37HZsHq/5sn9OJEhZcLkXoO9ZY3AQN+ZToVnBodM/e615qpeZ4Jr8GjRPdDBErhfuK70GX0Xfo8SVVRYCipdv6DU+2qBxdev7VawdU8huk5Lhbsk+epJmvssO5pH4NkpCrewlkKxklfP3We1PgtQJ/BIEb7J2DRlui/zCy2sK8Qt7FIjqzmrabxsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUx/WZkYVdmToGLEBcLIF4hOlhZTRZatODE906Il2VA=;
 b=f+xarPhXlsYExLIoh3C6nviQQ3bDbb8q90LuRc0PAiGFwGkKOUXLeOqcEHd/pRlHM1/qdbL1k55Mgp24fTGXKeyIxgtVx7pQA91/jTydk3HbnMd8xMFJyJE76e+iK3Efh5ezcGCSYvm4JhQrBBDSLv2tkF9D52DW7cOQ6ilWSRw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:35 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 01/11] scsi: scsi_debug: Don't hold driver host struct pointer in host->hostdata[]
Date:   Tue,  7 Mar 2023 10:55:45 +0000
Message-Id: <20230307105555.3745277-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:5:80::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fbb336-755f-4392-3df8-08db1efa9e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nc9CiNDkf+hSGVfpYPW8qBZQKjdneuwlgCE668mDT6mTbW+z5sNu2LqGo1nJlFUHhac33eBDiYKoxtC9DheO3j1K4m1/MkigT1BkOIinPAN5ikx6GFgTlgfxoHrozcMl9CPC0fW3IhQgsHkKffmFVXeqp2ntgCykOTGoLEEAVjVwLvaGeSPgR6grxvd/RVXVBjRvo9fralZuCeslrfkvewIBDNVH8OYVjjJat6qgZokpUmGCgdfUI36OQSTqFYYU4RaI7OxeJWPBOhwmSSX3sSZRofJ8stnAtceCzrYJNrMafeirnKa0KlVB4bhKaC6OAJVvPaLi6cQfV9orD3oBnp7JC4BkR5smtxIuRQ8aVH5Z/zkWwn6vrJraxpKji+OHwwXMEimqXHPjjx606caCw0RRtngz62k9yvlVZErwtwxp9IX6f0aJa4bTGVZvLLRddJx6rHqRfzP8yg4uXAuPu1gxdWzBqCyOHHaBRhJUgIE/feD4I/8EWweDVX3RfHlZGQvj01m64AparswHH+9O9GCAv9Ju6hgC76g2xe1ofHJaNOn+MrZFYlC/9UQcByBCC5rzkUz1qnYVyLt+3Bh7BhRuaUUdS14h6niix51iPkOM3AbIJQJJ5fUXTcIaxcsL8FxfUiUNOk/YHqyEzOWrXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72PhEd4a7nRXLonq+hWu17ldCYoL8aOALjMq++CXUcuWMFnZblK+aW+G31Ro?=
 =?us-ascii?Q?DfWHwHAebYgo5rS9HEvCP9rheNRWl2gc1v9mdHMGCDGMBDTlpp70/CUDyEL7?=
 =?us-ascii?Q?kUhXLUQaAogzjqAn+iZDsm6AcxcwERflFoducOW+5aBbSIapoO+E79p6XneB?=
 =?us-ascii?Q?w9wTr2l7MPCzGT7/e2rsN+JI3n/iH5g1IhI4lDz+UMvC7po6mKJl+Lk2lGL1?=
 =?us-ascii?Q?Mvgz7jiiqPPWn6XLx0JmsIqZvAVhVMjMWA360vL83d4x7EaaB23/wgE5Q303?=
 =?us-ascii?Q?fG0vTiHULAGRhX4fXinEy6o/vrSbw/27+6+TvHCIUNWwFkFvUQ95/bsLmadi?=
 =?us-ascii?Q?GVnyGuZ34MjrfgPY4z5zduuGznmqk65OUzvtjZu3FFJX1bfwrFJII1SkNUME?=
 =?us-ascii?Q?6nxPaKWP8aR9W+9nybRBMm49Xx+/GsOr/Iw6gEn3Crx9yjHxG3qE8o6IIAl9?=
 =?us-ascii?Q?u5rKJ+OXRdB+YMmK7TOQW+PmI25+kijQG9Cu5dIN20yruU6fXEgcYeYAxekR?=
 =?us-ascii?Q?u2quPsl5KdEFaCxwc/GCauF+LEr27AlhMfSbs2Zw6DLCO+Ae+Vd4AziCewW3?=
 =?us-ascii?Q?oo1bl962pf9X+L+Dp7Ufj/aLZ82fa9HEpjOgoozXiy3cuow1Ied2WLDMjIvM?=
 =?us-ascii?Q?Y5w3qWRbaBovTvB6iIHEBe9tem2hhiRXLzTxaW2edyULVjm3XSZa8HME1Q5u?=
 =?us-ascii?Q?ZSPdCaodbQJFAhwX2TAUdjH4e3sAhl5GnjjltWcr7Z220GWm8r89+8Ltdhh9?=
 =?us-ascii?Q?wTToaUWPHaa1trmKN6sAOlvuewCx2JO+aLxZFWHEm/cOx/iwkyp4HrQ9XVHh?=
 =?us-ascii?Q?0SuXNFHVK7Y79f5VCRzuIA0iqjc80CqTdweZl1FkpNrFiLL6sPh22Edaaume?=
 =?us-ascii?Q?aRErcqHP9VXEbeNUOjQD4Xvc2HSxm8w9FUiYExFboy++x1jLPi/2c8cpMkAd?=
 =?us-ascii?Q?v4L5sMH9A3lnhffVIjXC50+yjuPkD7O0gFfntgoTkRvTqS+PUjeeoRqoznoz?=
 =?us-ascii?Q?Arh9zplbvOhh2zHu/EZ2e+af9jXiHH8BEBdS8WJDr2UPN9RxsMLw7YC0/X4u?=
 =?us-ascii?Q?7GtKYSW2Ool9o0iCuXv0/OEPavXeCD+MawJJDtARIwHEVjEnOhF2HSXLCcO6?=
 =?us-ascii?Q?l51flyU0wx/I7H/sRFBI6XG7livZTbintX5o8BhHpMcFbXoYOeif0ytgqn3E?=
 =?us-ascii?Q?rPOsGUPvKR76932tow3FNg9PoeK73qvePL6M9ZpsR8+vFnBNkz/T45n/5XxW?=
 =?us-ascii?Q?BiUX3X6ynWiZP4FeIZ9t+5te6UjgYefNzo8RpSOhAQAp/u4yIzbmvxinVtiC?=
 =?us-ascii?Q?b7a6ZBTRD7OEJp9CHv37PYPWEn6jVKttvK1AjDhABjLMpjWWHrTCvhpeLpQM?=
 =?us-ascii?Q?cl3yfOPiz8R+jlkNGD5pgzX2Y0HLe+FdwhumNPL/iYmh65siBKNqDgxr8lxX?=
 =?us-ascii?Q?hfRFutjjgHbHJ8kvYBBUgmInPhDLtwJzArxXtwHJnHuSb+mlc1LpqQ+KpjNs?=
 =?us-ascii?Q?Yfxu/HiFY54KIwsfAhsLtMh3ZshRViBIv/D/97wfECg0tbyDEq2aABAoCxSv?=
 =?us-ascii?Q?WtXHh1URhFwedoPGnmPhE4lx0tSFBvhZijAbRVDknJgw4DYtKViOIrEFWPlf?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XTHPC+RiUoVBO/NMW6eJsEyba1RKqlmkWAOjBAJYRWRdUR87SrASKB5N9S32R1C9EOoNx6d1tLxfd3dGJ14rLGIu6svsWKrG6IUCDgyx0Nu3pObOXjx5ftOJ1ERoTtoztlxXlVlqnyhxoQ93eAX00KiaC6BmCIWvBesn+0y0A/ZPCgBiwgyFqNP6ghAwElAW/zmoQgUIX6LwzOYhFdtd9i/1wgVnpLvHyy7y8UGQq6ts19/yMXfknCsO2XlGLVVahIG86DD2XVQX1plM28SeJPxiACNLwe4y5kv9IajnHQkBhjvCCTBWoBPJv55y9w3jHPiNo/Ivja+e8wiXiRdR3t1RP4Cy31oT5K1WSetCF4QIWCwg9sPg4CTQV8cdM+QrxKfRtHWoJX73e2Nqv0M1uLNdyus5tBKD85gLV0EIb8Q+0cqVdzU6YVv2NESzEff0rXyS+8Ij5IenE2WHn+oUf2A8e8oqO2i08nVHeDNRK9Js2180ul057pgd/nlIgvMZlM9QuiQX6BRMej0DGP9+ESOlBO5OMdaimLP4n71nTdCjZPGV+W7DWPXedRJSrPykd+47qe4MLD5sTAGLW8INR5xI7yGtKmAuN9WUrNKEsgDZqivZ6nCZiPq1p5pktIwxFvkXzPGMQ8FdLO9Y6zTrozDycV0JjnU5pj2FhRh8BhUZ/T4ca+BvtbcVAc7gprIhwdGYbdhF70qBlw2y1Ba1LMRM3b9Thzm5UbMpGxrrudYYBv5JhE8nTAj+xyOTjHKeF1b/WdsVE0VMP11LTUXkb3wbAPERczwfEVS+WUY7s6rtiqPCi18GrxIdvdIPeuMWTI7EEwLfmzucrIXCtElGEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fbb336-755f-4392-3df8-08db1efa9e83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:35.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEnGxjAnaDdZKqxlqDVFfO7rRE8xibep81zpbD5x/YMjMMwIdBf1MM8CqxLKQ9DOCLXrNZcyegC/U3zzWvCDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: R4HA9_baB0-7FUuD-X6ibh78GURuQ5BA
X-Proofpoint-ORIG-GUID: R4HA9_baB0-7FUuD-X6ibh78GURuQ5BA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver stores just a pointer to the driver host structure in
host->hostdata[]. Most other drivers actually have the driver host
structure allocated in host->hostdata[], but this driver is different as
we allocate that memory separately.

However there is no need to allocate this memory only in host->hostdata[]
when we can already look up the driver host structure from shost->dma_dev.

Also remove a check for !sdbg_host in find_build_dev_info(), as this cannot
be true. Other similar checks will be later removed.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 226139a8aaac..f713117a5f2e 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -327,6 +327,9 @@ struct sdeb_store_info {
 #define to_sdebug_host(d)	\
 	container_of(d, struct sdebug_host_info, dev)
 
+#define to_sdebug_host_from_shost(shost)	\
+	to_sdebug_host(shost->dma_dev)
+
 enum sdeb_defer_type {SDEB_DEFER_NONE = 0, SDEB_DEFER_HRT = 1,
 		      SDEB_DEFER_WQ = 2, SDEB_DEFER_POLL = 3};
 
@@ -5168,11 +5171,7 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 	struct sdebug_dev_info *open_devip = NULL;
 	struct sdebug_dev_info *devip;
 
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(sdev->host);
-	if (!sdbg_host) {
-		pr_err("Host info NULL\n");
-		return NULL;
-	}
+	sdbg_host = to_sdebug_host_from_shost(sdev->host);
 
 	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
 		if ((devip->used) && (devip->channel == sdev->channel) &&
@@ -5409,7 +5408,7 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 	hp = sdp->host;
 	if (!hp)
 		goto lie;
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+	sdbg_host = to_sdebug_host_from_shost(hp);
 	if (sdbg_host) {
 		list_for_each_entry(devip,
 				    &sdbg_host->dev_info_list,
@@ -5442,7 +5441,7 @@ static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
 	hp = sdp->host;
 	if (hp) {
-		sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+		sdbg_host = to_sdebug_host_from_shost(hp);
 		if (sdbg_host) {
 			list_for_each_entry(devip,
 					    &sdbg_host->dev_info_list,
@@ -7821,7 +7820,7 @@ static int sdebug_driver_probe(struct device *dev)
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
-	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
+	hpnt = scsi_host_alloc(&sdebug_driver_template, 0);
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
 		error = -ENODEV;
@@ -7864,7 +7863,6 @@ static int sdebug_driver_probe(struct device *dev)
 		hpnt->nr_maps = 3;
 
 	sdbg_host->shost = hpnt;
-	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
 	if ((hpnt->this_id >= 0) && (sdebug_num_tgts > hpnt->this_id))
 		hpnt->max_id = sdebug_num_tgts + 1;
 	else
-- 
2.35.3

