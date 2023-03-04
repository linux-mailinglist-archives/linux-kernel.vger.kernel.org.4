Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22786AA88D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 08:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCDHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 02:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 02:30:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548D1A4B3;
        Fri,  3 Mar 2023 23:30:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32472Ckb020519;
        Sat, 4 Mar 2023 07:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lF90XkmFDiiU3C9v8N6BHBWjK/LIyFMCHZVYRvSl6+I=;
 b=W2H0VZXE4rvTeROqpi2T7mhm9fdc3ikpAO/gHKvY5JP4UtH0T7hxXofS/3HBdPbSmUot
 MWgfjZ/rp66s1Tpanu6M6ITLZj3ClQcpG7Et6zZohYa5i4n+qXDl4o2ntJdc2x7rTfME
 g9pp3ZZ9Ab4WCxOgb+dBKkWGnBbTjCFamTlCXa5zdGl5r+5brDAdaxqN5stylqyiYhdb
 W5wpKRNgeWyVTWewfJ63IOMw97EcAoMZnVSwoh6hCTryL7pHR+QFgMG/r8jLGldLZXvt
 RDYyqpgK/zG0n5DKYjsoB9FIpNAEDBXVEvH/ea5EvpvY7GkF6mI28rxnSZxA0CCDPRi/ Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415600r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Mar 2023 07:30:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3245XTMv011821;
        Sat, 4 Mar 2023 07:30:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p3ve270se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Mar 2023 07:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G21t17A1S41Wl4f3wvTthm9p58Cy/sUayNlwaM5ZXik/1ndeyhpm2vyTGrvuTk/y6HdgtW3CbAE9f7MhMMaFNaNDrKBRq3JeckfivR8PzBNxwlfBu+gcDaVnvxEGhQHaF/iXahvkCo4gE33aM70FRshWTh52zRnTeMtbsQus3QtTq38dO/9C6Dy/Z+ctaNlKzrHUGD3kEpzoaqgRUlqSrQal5jZ8x3NXot9ftnxLasXcuTzs60yK2pDMqVDVuSqjShwznziN35FW7cCmYU32RNA4FN5NmIBi/ofiXPZZmkl/X5Es4jglSqih/Xec4YTLAASP2dp96ZRjuycrUA9qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF90XkmFDiiU3C9v8N6BHBWjK/LIyFMCHZVYRvSl6+I=;
 b=bjMpR/ivPE1PVvS6XH4m3pQBBOx/fOYo4Fjixc1WNjg46HMUfTOq7U81XdIjpZf3iGES7DGmSl4IsP9Ck5T5ALycQ3Dq5Orhh88Bui5T6bR1Qx2kxQ9nv9nCJJBKZ46AtpLgTnQcnzqgaF5UTS4sPYWLog1BcvGdvF3efxvITYqX8HDYBV3PW/oSqjAVWlEGRA8VLY3bN0ZqmF7qB5/WaQ6rME542v+90JTinBU/jtR43ulfMMg+n/9z5PL37ahvrPzKfLCRPnFP/2ncRZdj/bcr9Mys3WqLZX6s1S+wjlj1M2WRatCjb908RHBx9G2Ind+GMnp8zvbRBBXGcTu2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF90XkmFDiiU3C9v8N6BHBWjK/LIyFMCHZVYRvSl6+I=;
 b=lsMamahUAAUPATOU72ph58QgDL0qdl46CYD9G7uivuMezgNT4GAb8JQG+bWld/xFWQoXh3jXrXx449XZ0i/WF1xp7rboyiiXmWa5pwEzUIo0JbINYHmfLsxnnWUBOgt8SpfYfmwTJ1DatTGOFycKugYP3RMTWjPNV5PzFvWxn/8=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.23; Sat, 4 Mar 2023 07:29:58 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::e7b4:258a:2ada:db1d]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::e7b4:258a:2ada:db1d%4]) with mapi id 15.20.6156.019; Sat, 4 Mar 2023
 07:29:58 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] device_cgroup: Fix typo in devcgroup_css_alloc description
Date:   Sat,  4 Mar 2023 12:59:23 +0530
Message-Id: <20230304072923.286534-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d593fd-88e4-4644-15bc-08db1c8241e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aR2FZix3K/SiUZpGpZ3noWRy9FnO9Vuo3HJ9VVkaumFOP65rIgvqT38DEhSFw0dJVmyhFreGU7DqHrHNDDE29p6GEaf8OXLK3ErASOdufv889uRz2JKRD9njDwbsZV5+22j6l3ouGQRVRFNoqNcPuvSMQCenzRj+dZ0yU4wwGjI7n6v4TRV+pY2M15/IlfB2BJkBmpEd8PRxl06tH1WVjTgM1XI4U/RgT5bgsJ1IuYcXINh+9ix5VxhtTBWNyF3E4kU7iX4Uei/Z/kEuNfZ1M43TPY9hG33lSIVSVOeLAuEh7f6KFyR0ciA0je0MECs+LXCQtYs1AnrTQRqQKfCY4a2dErJm/qNA/L/kq7oyEa9lk3mApkVpQ63NsGQ96JXQm9QymdFgVP+hCtfS8d+z3o3+osE21QKKRvNdFZwvJ2BFH8iSDflzVEGsz2XskQBY2kfxqYsa8JjK4xP6kcS6BrqmoZS3eBdUHo0VLfk1vsuyF4nlQkUh8wMwzw9U8xgVKYehlJ4DOjWLd58v6DFjQSaVL29UEmtEmNmQ6BsEC7o7QcPvcruRqLl9RxShw0QmZiClqtceAF8BkGL25KzezX/KCG8oKTH7iwgzJO4zrJgpZh2TSlSwi8AGAl2rurV4jJb7QWCMzaWaJd1yysl+hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(41300700001)(38100700002)(5660300002)(4744005)(8936002)(86362001)(6512007)(6506007)(1076003)(6666004)(186003)(110136005)(6486002)(2906002)(44832011)(83380400001)(66946007)(66476007)(4326008)(8676002)(66556008)(478600001)(2616005)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLTo0+FnEYGvn2nKZgDfetcouPpW8NPdLrHbJAbqd2kt3oAQundxIUsqc+iw?=
 =?us-ascii?Q?XyN6HwT6sRpNHAtoxm8W8Sm2TMnK2miPiBbLo74Pr/vPoPmz1XEiX1nkXrRW?=
 =?us-ascii?Q?GNNrfKWZS0XbGG0BQqlXweyyIglXgpVn0yuXyFec9JnsFf2kMrKVzBzYSQ/n?=
 =?us-ascii?Q?96UbmkXIhQR9qT0tFEnpMTgSeEbpGdt+fdJX+z+MNnfcAZvAC9PizJ7YY2CG?=
 =?us-ascii?Q?NC9FbeUjTAjDsg00jWjFzCdHiY9t28NRStn1al456N8PKis3uhzpEes5iwPT?=
 =?us-ascii?Q?wJdprBS0Hm1GFsoqACh++/je37QFCFZhnaw33IiRIpWNRKuoPLo1gvE9QS8E?=
 =?us-ascii?Q?pLhB0cS2CFlgqn9OfOKLMfuXbO0kLsmDFhLZt3EDkT7tF5lL/Yoafz4lIvaG?=
 =?us-ascii?Q?1mfOJ6ndOMxOX9yQk9V6TmpwM/mG4XlLrq5L6DEjs3CAZieq2sTgKlVfpVq5?=
 =?us-ascii?Q?Jc/kQDmFhX52ICI9djQ4+kAEipA0qGm/CuROZQhp2TzK5tSidDOTHCRWWbvF?=
 =?us-ascii?Q?baGOYOh1i16YdLRi/g30xKXN4RNbPZ3/QisCMKGBtIs1i34dzNBwZLxitv22?=
 =?us-ascii?Q?jGQHm3ujm7vgcKLvwLz8QSkZzv5tRlg79xaE+plkpcUfOk+BlPge4pMJvxJX?=
 =?us-ascii?Q?qg+vc6sbwAdTcvN34o/rSRhmzckyD9CspFi196dveuqDPlBkiXLT6XO7012H?=
 =?us-ascii?Q?MksGG4fPpf6VfAKLXH/B1o1gCtO0qSKDKkX+oHTvFz2gQQHSwzhFblxZJM+K?=
 =?us-ascii?Q?xDUuhEP5XcmLGJ08SZ+p6LaLHhdOWRVAnDqPpQ12DZMbYUEJv4kZ7CfafxQD?=
 =?us-ascii?Q?huN2EuYPcRfTqB9drlGGaAQxuQf+ndKbv5SspXZzxMdapO6vqGG7Iqi8pajF?=
 =?us-ascii?Q?QGpjFa7gQ7UxTGSecYLDUP4/cJvnmOTn4SK4JTTItoAXRrKHaS9K2nbo24fJ?=
 =?us-ascii?Q?cDA7pMEvXzI67CInf5Ph7sWWVXfCltkVFCm7zNOPJUDqXtjqeNhhwI9iq8Ce?=
 =?us-ascii?Q?BsnQqS0c+BILfmh+LBGpsh42SGVFjikgt+3qYOJoA71TQHn6a3sINydG51pA?=
 =?us-ascii?Q?PjynK01Y4kURzhgLNlzhSRPD+0M0IslZOAleTKlWLx6cP/7oqG4tNDpk/QK7?=
 =?us-ascii?Q?pUsMc4k8UAw7UTwmuI3dxcLN2M9/Lmqx6U25CCW5grQnp402Q15zOmQdhA1A?=
 =?us-ascii?Q?15TZgFWqIL45VphQwmEU4zvhAS2qK+o3VIpyII4odyP4SeYMbwFvwxtKKVdQ?=
 =?us-ascii?Q?BIFwlvmPAgAN38Z7UzPY9j9AagjcgxNe5PwVJ60XV/ZOw97Ixrb2PoUt9wYG?=
 =?us-ascii?Q?qUbPZCjpfZ/DRrkm1IC5/94V3SEGK4o8W6R4Ix6Pk/L/rUjZkpBIgAGlW90l?=
 =?us-ascii?Q?fMVxzeTCSBjwsQ+MFbGermWNHbUvuTj6DMXgxuO3riE1PkkFBLK6FhpbHCQL?=
 =?us-ascii?Q?f1iMUrwXhs8d0Dn6F7VH3Z7dEDwHOGYj2yMuOjfnma5MO+mXXDDGKNmqc5Rm?=
 =?us-ascii?Q?ueR6PDa4eFyM3VCLn75sq3RbEJE2rrcbld9uyHuhx80f6kSc+6R225Et/xjG?=
 =?us-ascii?Q?VdvUkKKth4oVc7PqmieQL2GTVmDtvw4mL6FYAikGbBCwuRJZzOX6G2BkT45L?=
 =?us-ascii?Q?kU8zKpDufiA39z/aQ4wLza/ptZnynFfANjFmKIFrlC1FQIjjnpLkBaMA3S8C?=
 =?us-ascii?Q?3LI1kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mZZYeieJXQwJeHfq8/qey1VtYgGPc7JGd299RrtJ8hE4H/n2OdfXumzeHARDt5JmjgYboqMzPTPMe4X9zOhWcNBHXiftvbleg4EbIZEWo2Ah9vUnsuhliGON3aqqsZfgnj/v78zypV4JR6QU/+iLt9SOQIS3+GxDc9ZcDHOQzA7bD6eQ3j6levbG6dNve82BnyzDLJk8yHtEVHHXFqqqK87RwKW1NkusgoNN87vdpn867cM8MwupWpdsjlZzZQfDkHtMW9rq80NLgGPS6MmcD4EckjA2g64ZsPP7Nk+Aj45E7wuF+ocSL0bluFZZEbmJuyB+xGIMYxoteRSJIlUy3J9wBf9mYJveFi/rBMDV2rt4h/DlyRZZ/gu5ZoAGA2CaVgIY/oX+NfkwfT4lbD7V2jKfNDBSgzLjpmpyC1mx8Z3JcG8ErOMQjEUba930VYTzdqObZbUhXhLIacTUXhl+A4QEiw73XeIePzueWwzIERruKheMstIcE3E51Qhnnlupf6Jgcv5tYsa7WNOz00GvuQ530767r5Fyye3X11m1rTzAhcIDOlV8q4A4JbJzEnmlS0fB9/5aVkWsdFxatulo7mMsyFqWil3CJsLAuh5pFhLyksfW1N/b4ZS8csH/h4Ra9rlpD3tBVheWBW+TUMtplfeJ3TXTWHJNuO5eiIk5Hdg6/mIrwiHedLmASYIGg7KNzdQLV3fKqcEfQ9yCKnn8QVayUwKfOM22YjDetE4tEpQcC6BSIHX1gzmENusy5X67md292PWGH/e/Rae+lsjVkYp1EQ0CuBEqtkJGI31zNdlhv83DtpjTqvZfs5LAcHOe0fXh2DZ8FXvizo7nT0bm1zBU+ku7RnuHdeD1P0KKibk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d593fd-88e4-4644-15bc-08db1c8241e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 07:29:58.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3tSTOhXgh1XlmPUKpbNwAfCF/OaLZRblV4+dbxh6V7yh4op6T2Eoex/VYFXrGiUjQB/LfIJq/o5ELk4IX9R9Q3B1OL2ULLu50HTsN+DsjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-04_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303040061
X-Proofpoint-GUID: MA74rWQnKjMu1-dn6fT3v_X2PbneRszH
X-Proofpoint-ORIG-GUID: MA74rWQnKjMu1-dn6fT3v_X2PbneRszH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the stale cgroup.c path in the devcgroup_css_alloc() description.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 security/device_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index bef2b9285fb3..7507d14eacc7 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -216,7 +216,7 @@ static void devcgroup_offline(struct cgroup_subsys_state *css)
 }
 
 /*
- * called from kernel/cgroup.c with cgroup_lock() held.
+ * called from kernel/cgroup/cgroup.c with cgroup_lock() held.
  */
 static struct cgroup_subsys_state *
 devcgroup_css_alloc(struct cgroup_subsys_state *parent_css)
-- 
2.34.3

