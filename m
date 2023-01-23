Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8B6787AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjAWUZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAWUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:25:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0172700
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:25:03 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKDkWr009712;
        Mon, 23 Jan 2023 20:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ldapDEpPRHIJo5jVjg1txg/5YKHge8AqOQ1FyTlMWVM=;
 b=tcN3Syks3oOuzuNSrJZA/qOqXEAtdj+5TCjQ8vJ8T8MsSDzHX5gfav1rhaRoTH4pGsZb
 hGr6Mozj+Wj7WGukuRNUO1VelSBlyfea+tVffqCZAC3MrXZdFekiPOYxlTcSR/BFllcm
 7g1tRZWKCu09540Q+ufIOI8V8xApes3OAjvj31KK/4PkNaqtrhBl6KBC4di+Gyg27ywT
 SI2Rn31FBKKHbnuP4q6juHzePYmBfNUYcULBIGMPCaRdRZ42uSFfWTHQ+wLKVWScoeii
 qvE9gPssE1czuEECA6V9cZJTWg9K08C6zOhBIYs9kRoKAEQzAtigay6R1RKub6WLYHH6 dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c3t3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:24:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NJLP8G039602;
        Mon, 23 Jan 2023 20:24:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gatwx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG8Fp+r3NIDgniswaCNasYX0kljGN9q7hlqjWv5JVpHeFBx7y8ipmyqNG23paHd1KP+wNfVz2oJQ0flIYX79mjowq0W6oPQdoTituukMg/huEsUNYtcQwQHGt18nO/myCTV1cygjxnsnxsvNX2r1qketU4aC0n8x3JdQJwV6cuBF4Mxdsk5ubvO4D8mlNB2XxDhiXl2+soR5Ce3HENChC7qCIyv+a3LRBAtsd8uE/Q3YkCxFVkMcxHsCXJiy5pRicoasKWE+CBVirK/XjEa8uPiih7hTZBLdOo1pJh7kCs+OJEJvopiRly6TFDWpYQ0YPn3O1TKDSZ/3aQeR86GkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldapDEpPRHIJo5jVjg1txg/5YKHge8AqOQ1FyTlMWVM=;
 b=Icp1F/DeR2iswuXoBl0W6coJdUwThstWqZCd77PDsY3a61wJbJzvzsPry7ymuWLaXigJgFPnb756GQzAKcxMOQf+4doyWm5Fc2oWfYUuxZGVgvopaw1jHdKov9N06sgV+b4uRdcpmrqumNpcxHN0Snk8/UR1iHek9q1JHKjaBwtEwCG6wwQZmOwINHfC7RDNvo7DSLsUcuTi4dwqmK/ecjKkEpiPoBwOJf/tLZt9dA1V594UI+/HO6r1TiUj8E6jm+SvfCxf1Zq9AK59FhfLJmkaxeh5aFL6JlJtDzSKlwFjE1Q87ZatsA/8AQf/C4rsyUJpM6w33VTm19foe2oqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldapDEpPRHIJo5jVjg1txg/5YKHge8AqOQ1FyTlMWVM=;
 b=tR3fm3OZ7Nb5MSQdHPlLPBtB0Ci6vAA1rvMFggVzBORl0+0WxKXaYs/GSq89xxzsT5wnPOcayXc7+82dsuSjgpalyrxlRZ4wfzsYWphyS9fmtN3IGdnPV8BusQ3cN5ZVwvNRC81XVRpSK+3hKKTB+ePTArp8gBaWJu62/nNTZ+o=
Received: from BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14)
 by DM4PR10MB6013.namprd10.prod.outlook.com (2603:10b6:8:ae::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16; Mon, 23 Jan 2023 20:24:46 +0000
Received: from BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f]) by BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f%4]) with mapi id 15.20.6043.005; Mon, 23 Jan 2023
 20:24:46 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        osalvador@suse.de, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/2] mm/memory_hotplug: remove head page reference in scan_movable_pages()
Date:   Mon, 23 Jan 2023 12:23:47 -0800
Message-Id: <20230123202347.317065-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To BLAPR10MB5106.namprd10.prod.outlook.com
 (2603:10b6:208:30c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5106:EE_|DM4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d4d287-e4a3-4d6a-80ab-08dafd7fde4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekP/Uq6yCiybEjHKYLM0B8euZPZET0LWvnIHvJDKRDARhGsAtAeKrhDjG7R4fABxOYwC0indBMQ1rwobZxuCyONr7Tx5Tn1QfR3+pXYHMNSCxDLxR0KzznVbzh4ahBBJeXf9ztVfIIXSSrAyqLXskX8QirLJreTw24gW1HTETybv8Xqc2lNLxiGcKfnulzbhV9X0S0kw5wT8QkY57LvSd6v9GF7ufPrfCaLagPXzDDYyKwszkEV2TJJEm2GNehcX19WDOZZN/T5du0D6UzdgLSWLO1TiGAFkYflA5oAHXtwyuvGkG5zgg8f5ZDweQVCJ//TsyRMqu92EAD2n14NuRy/RO8qmVCLvUUizDLCXGXutGunYSWudvF1v/CND96b88WD53HxpxBPEc8B2PzZyhSWDAhQI2ULetiB8qFIQie13YTnb4kTNDpIuozQaK46Amb4G+F15Y8z+USsACsWHlog4qbSDKWii6CNS0eMQzXUYZr2R9LnoeseSHX4h3NlDZFqXY0st0u6B1eFIphA45QDwqNSYE+15FQWmTRF4EcV8cHWbjsQn53xvYjbdY9WRsP2V3TcqRbWYGCnCEbAfF1shfdslSAUCkgfDypA2vswdf00lAdx8oC8fpvlFXGNS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5106.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(36756003)(316002)(66476007)(86362001)(66946007)(66556008)(4326008)(8676002)(26005)(186003)(6512007)(107886003)(83380400001)(6506007)(478600001)(6486002)(2906002)(2616005)(1076003)(5660300002)(44832011)(8936002)(41300700001)(66899015)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1UQ+3J4HDmKhfvhJ5uSXlnaTuwdfaZeu1/1MIgkakigTjx10/nd57d9sj1U?=
 =?us-ascii?Q?htfYgTOsE5bi7x4EHZFRJZwjUjRM+/Vs/E178ocmtDaZ8fCMtk6GZesPlX05?=
 =?us-ascii?Q?AyV3vR0FKJ7PAqTBTy2leGm2PgalNqOk4WMZqVhk8fD3IbQ0fSK24rGk0SSc?=
 =?us-ascii?Q?haI5SoTokGo0hnlXSBLQMO3oiq2wH/0v7r4QzvfxWpLjD1kJxgZtE5Tfo76L?=
 =?us-ascii?Q?EHg+awwOZvxe7twt/uzMv95dr88SYSPkzVqJDddE1ydaF/6r/LiXnqX6z94r?=
 =?us-ascii?Q?zupkIxu3FobziaN9lscjz1R8QcNWKHuG9uVHGave8xiCy7jTdqKDzbcbvJ6z?=
 =?us-ascii?Q?cx0rtN9f50xw9atO56MxTsgQi+si7NvsKTVT775RPWg/6PspFeg8KisVvk9+?=
 =?us-ascii?Q?I/zDPfI/2qOuCb5119cqX1ER6MtFgJFwB+BNkq6bYMTDW3tCrnNJgm5Cduvu?=
 =?us-ascii?Q?c6snxQd+QbRAQKNa4kLmf7fr2vY2ywPRp4LiwFYra3rpCBl1ETPGyrQvNpgK?=
 =?us-ascii?Q?Dd3vihUVFZy2iQ9NHaYJjWxq7J56yGj3qW33ml7GyA2ZEgMW4lERw/2Z9csL?=
 =?us-ascii?Q?JuUIrw1Bbxy/eKwmvlwIRJ6230TG49jr7PpdCie/BF/xaT+2nj83sVXMNI3a?=
 =?us-ascii?Q?qSlA+mDWZ/enedKuNQN7Ek3biY9egIGx79Stu6om7WNBGLUAdyCDBdTDJ+70?=
 =?us-ascii?Q?uX9IGT6zL3TXPp22yl+KYS8/ZSSsX2OCMzCEhsLvu4m7islmQ8+m743PxhXF?=
 =?us-ascii?Q?N8WNSaFKoAjgwhJ3Lk2kmCdALmzS81T4M//pEMcbBT7zBxvVrmmTk4G6/b9c?=
 =?us-ascii?Q?fAQsjlJ6pTGjblqjbWvYwhBInKcFYPcKRqezrsgkHrKwygqGzeDJSqSZKYRw?=
 =?us-ascii?Q?ZYtgssbevMRE+PC/JC9R3UQYGkhR3dI2m3SvscD3umXUjnXNHH79c3ixxOFG?=
 =?us-ascii?Q?K1IHrHB0jZH8DaBNdmv1HPFvqJ9k3znV3b35neA5th/ElxIAQ/Rlq7j8AqUn?=
 =?us-ascii?Q?xCRoesuXHi1np9Jt7+02r1Lsk4nstqVrPNZZi/byNB92U7TaOcAuEQ3aVfYp?=
 =?us-ascii?Q?jiyZotrujBuLSxlT65iBurRaZNQ9u1smx9UsXXumSihFvXaUK9KdhPBo7Y4U?=
 =?us-ascii?Q?51llAF+hrZOmZH7Zol4EPBBoTWUTy3lWi1gMTvuwVNtHB4+H+eHgmjRt9tE4?=
 =?us-ascii?Q?zdhpcYxn0VfzmItsutwzCVDKHeSdMZ2/ft7rlvGUGtDZwUpEqut5Fv5AQcXi?=
 =?us-ascii?Q?Chq6nWtlE+55frXFRmxrR9wcRjJY6vHshNvXvBIznQhTFHeSYGfvoxDnoRzL?=
 =?us-ascii?Q?WhcNYHPds/K5xppVxjzuGTaaQfgEVD1+Zlzv6xySmMV+LkTD4F+mK2aw1TVR?=
 =?us-ascii?Q?eBFZ+iRM74sqP6F1epYXnWGcz/HpUjWeA0ELTKgb8One+q6/7/utTQwdC6Nt?=
 =?us-ascii?Q?Lk0TPPTrFnSY2YwfzAlLu5pnCZMRpYt1nKwJs0+o21902+xH/MViTiRoYcyP?=
 =?us-ascii?Q?BEcFBmDz3ytym3t2YmM2sPTa+8/4G8hJ20wL7NQX9l5Epl8VzBz7SNaA3q6f?=
 =?us-ascii?Q?FU8vSUy5+lwGwDNhON/kS2YVEO6PxLCVJvTzi/Tc5teMlcPZuXhlro4TFMco?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hR5JV0WQv6OLErBIYCT5g8dJVStHzG5D5Dzj26xZqekicnPX9a+hZ1N2jCf8?=
 =?us-ascii?Q?f1RW3aE/d2hLAHRxv1gNjTbGLIpA3MXUj+J6dZsKVxAXWW2jQY0uMj5KBE+B?=
 =?us-ascii?Q?i6+7rukQNa0DMZMW4OIgZj65jikqm4AJhzBpJYk+Haqi74kObs5ZkjX7z3QN?=
 =?us-ascii?Q?M8OuCVnLlqRLjjkpBurlj2nFbEaNj3B0ST8Prkrgl8TnEbwG5XUCcAwO7WIG?=
 =?us-ascii?Q?rmeGVgxEvAgOuj3Kf2CZjh20Ge5VKJXoB+qaFArq+mYCj5C775zr0zPLZNbi?=
 =?us-ascii?Q?m4oFO90T97gwDbyRR3DOzTeDydffu2mgYWRveKMNm8rFnbA7t40qnqi5mLxO?=
 =?us-ascii?Q?E2qIS+m+o/5XlpkvyjCu0rgIqN+pNKt8c+joqyAThGLApYXT4vgHBPmSnyB7?=
 =?us-ascii?Q?E4K4cTwGrrhyvOaPd4j6mSv7LtTg9fHiTwCTtZUHVqF0NlYUOAcfjaVgK4WU?=
 =?us-ascii?Q?OU52g+nyjL4w+3exRGlUlQQa3FEJi2c3EwCkXah381w5p5b6K9swUnVi/2dU?=
 =?us-ascii?Q?I6M3yQci/8P/75lIt8IRpecMtbdyPa4tyWc91GPRuXqR3ZEFMaCPgR8Eie/r?=
 =?us-ascii?Q?eRZ7tPR8APw6T1M1RhjFJ2HHkSIOoIBnO1A+rYluNvKIQt44cWxG/YrD6znH?=
 =?us-ascii?Q?4AuUI7VxRW8lNiyQqGWcQpkrr6Y7Zvd02gWgYF8+0RrR5dC98t+pteqk6k3u?=
 =?us-ascii?Q?MMI/Th+WZzapiDxm/oVEwbllqiSGs4g2yOZaKF8X29euHcs7HkkG2jDm3oCO?=
 =?us-ascii?Q?Jy8JEpdGN5i/ECPlUDfN2y0tt0XzfBpk4Y9cU1waXAFI1DfSv8vFhoyC32hv?=
 =?us-ascii?Q?cr5aX6FybrCQniSMbC9xxZrao8uX++PITzIGvJqAsrA6Db2Toohn0el9T1G4?=
 =?us-ascii?Q?I0FB3GizrM7ZiaXp3rPJSFmNRQrcvZr6zPaFXG4SnyND6/DYpbHbCKk+lfNr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d4d287-e4a3-4d6a-80ab-08dafd7fde4c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5106.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 20:24:45.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4giiI72e62MwjFA7PUYsQuft7Qzcb52CUAYbUtRhiPOAFOXMYs6wyGASgRLNdjoKFCuPbJUpVXMI9tHDDdaTBtN8EPmwVdFiri2yC94Urk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230195
X-Proofpoint-ORIG-GUID: xMeph6Oma-ZxrFpBPPjhdF6Thl1ZPNFV
X-Proofpoint-GUID: xMeph6Oma-ZxrFpBPPjhdF6Thl1ZPNFV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one user of the Huge Page macros which take in a page. Also remove
a reference to a head page variable by using a folio instead.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory_hotplug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ad09189786b1..d5a0672cdf3a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1579,7 +1579,8 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	unsigned long pfn;
 
 	for (pfn = start; pfn < end; pfn++) {
-		struct page *page, *head;
+		struct page *page;
+		struct folio *folio;
 		unsigned long skip;
 
 		if (!pfn_valid(pfn))
@@ -1599,9 +1600,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
-		if (!PageHuge(page))
+		folio = page_folio(page);
+		if (!folio_test_hugetlb(folio))
 			continue;
-		head = compound_head(page);
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1609,9 +1610,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 * cases false positives and negatives are possible.  Calling
 		 * code must deal with these scenarios.
 		 */
-		if (HPageMigratable(head))
+		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = folio_nr_pages(folio) - (page - &folio->page);
 		pfn += skip - 1;
 	}
 	return -ENOENT;
-- 
2.39.1

