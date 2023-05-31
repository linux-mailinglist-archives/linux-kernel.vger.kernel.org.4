Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284F718DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjEaWD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEaWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:03:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A02B124;
        Wed, 31 May 2023 15:03:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKXvUK032525;
        Wed, 31 May 2023 22:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZiPcL/vz04kMoWAHJUkjfZYcqAtTkEVetoonKg6dYYc=;
 b=JAHpH0wqmWeEodJBE/gbM7Vp1wZngIZilyobJ3S0FWMFwwzhZvn6O1DTWl1eE0PPo6p+
 ZjnDA3cujq3pXu+Bv4MBk3WFvy4yNU4AlpdX6wNAzSZWBX4hGkKdhTOY58WlBomdgw+m
 ypxjZufEKIrX+G/OeO/v8UnRGn5Fkndt/ECNfGsJSRd2Lvm25MGd/24i9+bmts5uJi4N
 KdcnXN6KQjzGgb8yFnFN5XghJoKfRyQDni0CSouDNDtZBfKVQ28qZenj1E32vNDyL5Go
 SwMLFBDALgdvfTBdj3MtVoBlO1z/svcx/7bn56kt475mBww32XZN0lTSmhs4tJVFdWXy hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb9749v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:02:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKKEo7003735;
        Wed, 31 May 2023 22:02:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ydwae2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:02:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3qI5e+eukU8bX+dwkIIaDFG8FuPIPEtC2I1bxpOl/DJ52Ajh1uL0x0vzfPUPmulkOjYPcxgXymRNESNn7TsvxklMdOqlc6EL4eBSSM20fbiFlh/b2byp/mai11nOEgZ2fnjqIcADxgDfy+Y+Tjdtyusc9DBotbVsHVBRFXEpFeU+Z46ihKtGxl256zmSqBKSUfX3BIusigl1pXZNE/Lbt/Fl1fBG8zGTCzYloOKusV7wtoaZvf2Yz2mMxaLDCZr8bLTIubZk7wSEc/GgkVWfi8TDkZ1+UzWUn0L2vLpiknMrtMibjYEr+VGpS8XUYw4RlSvxzlF0FLT2iRVRUNkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiPcL/vz04kMoWAHJUkjfZYcqAtTkEVetoonKg6dYYc=;
 b=PKhEOrulQ2FhKMz7FHlj52lWVTjEr9rJjEwupUncUMRmy10wuEvMjc6UfTzRolJ5x/gKUVNjbK9qEArEsa4a92ra4wgJIYkZSt02HHvUyeq95h9hDksyWSfdXBJxJWCLJssdPbk2MQrsnk2RYR2cu0M4CjobaCVeKOGB/l44eWnfW5IWTGcT3tQn9UIwo2m6r+L+6P4GUZrIZTxwcGVcgCjEcipTo/HUWfgZigd8nHzK03kslJPBEF4K+m/gRgOGPBqEu5T/QWPwtxRBQibnbGWfkHT6s4xqOZMTKE8WgNVi4BidlcwpPdXcVMY90vYMF4cDr4Ys0PYLU3w1kn/gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiPcL/vz04kMoWAHJUkjfZYcqAtTkEVetoonKg6dYYc=;
 b=Mwv812biyLPtLscaS5bIqpI1HdecZHyN5MEy/nbsVNquaKEC+cwFei5eYbcCsQIPyGJ8ZLUWgZkRDgCar3SxY5QlRcxsWc6e9UWoLgmUUuD7YeuoyWlT/+QJNRtpT2AE2TQp8wZstFAKntXaWrKnEf4shL5J7g657xjkHiJkdWQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7019.namprd10.prod.outlook.com (2603:10b6:8:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 22:02:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:02:51 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-hardening@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: libfcoe: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg5kcgac.fsf@ca-mkp.ca.oracle.com>
References: <20230530155818.368562-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:02:48 -0400
In-Reply-To: <20230530155818.368562-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 15:58:18 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:5:3af::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 54be031c-21a3-4437-2d4c-08db6222c74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NiY7NundsuBkh/9kHcbgNDBdRiNTgE49PnVxJO3vskI6pDkrluTuDHT+BeCWGyyJEHkmbtgGamloY49ZqLju5yZ+TggqVK5SZY82RXIlZaJKOUokWPt10WqD21RJQGZrdfIKuNMAP0+zf0HCZIyeRDGnIpLwUGlMXl86Xvu9ivsDDdq2F+F+X48WQG31OB8BWBqgVDrCyWMNlpB6ON9m7B9QfeAVboibBLZ9NbbT5UE4vaCCSZfslDU83GGCZ6ScV5lWWR9aSU5cdtBWuAlUoIAvWQnz10HK9h1bI3IOVx2M5RJDiF/mu3vZT3hNelgx/xjcHNV6YFVw5W/sAQ7QAXf2NHd4kqx0InDzxnKSfFPsVLIn386tc4b3sdNAJzCJ2qeZSRoBV1fvcfOn0d0lbFwwHhSAlTMABHRitscceX82iGcs+O55em4hIAPGPJMbIZ2QOFM7EqjrfWodQ3SuxV/6IqD6ntz08CBW1crIMruLfMIVPKsGm1tnH87vSXrTIcXK4XTbL6YMJlO4ZWQ0nXodJ6j4FYtj2qDnjYa8JKewTBY3+lxjbyVbrSaC+IGl3WeS9vAr4tHtORkItSFhsi5+pp8MN6eJwBNCfowsk7xB8BZWAzUwi9BvXAS91w6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(83380400001)(107886003)(6506007)(38100700002)(41300700001)(186003)(26005)(6486002)(6666004)(6512007)(36916002)(54906003)(478600001)(66556008)(66946007)(66476007)(4326008)(6916009)(316002)(8676002)(2906002)(5660300002)(4744005)(8936002)(86362001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lG+rda5jbecsARZl0UeZHX0dKD9BEfGEeSYqTR6wuX7E24C54+tbdks2XzgX?=
 =?us-ascii?Q?qfCYiFsC5Ibzm/8dtqMTiILXP6/g5N0r2INvnv7TXaWezig37R+5Jb5k2NEp?=
 =?us-ascii?Q?X8P0OS+ppwTXXO/LZEC2MwJgVTGHDuLdyVbSAZd+XiC1mzgAHzVd82IzoNwn?=
 =?us-ascii?Q?5vrfJ1Fgg0XUDwidD+4ThZCJM71BwOFYK904m2OOCN8oJhcLTsDnAOt7a1x4?=
 =?us-ascii?Q?qYB4k+mUHhAnrJtVTL3/gOZZMDo8yds0pETfdsKuEMD9sR7sXf15ZAUuoTN8?=
 =?us-ascii?Q?uDSR9uSRCaznDJlKvbEryayG6+TXRF+2u65U8F2vEvEx7PA3GMFLTIg1dH0N?=
 =?us-ascii?Q?qPs/0CKuUAQ+z1VEwVQ7rx6pqCAoXFIM43HXOgcjytadn4CyKR+gyse89JHU?=
 =?us-ascii?Q?JRA3uP9Jc7jOVoDDBa+BUmsvVCdnQ20uzIJHFkOOw518aUmffNgBZgigmXlX?=
 =?us-ascii?Q?AzVLvPsrmvoK3ISy1JRJJfuylU9CjFZRnruWCLey5oC/KCFg8E9UqoNjHmkT?=
 =?us-ascii?Q?tGgXgKmJdQYPgw7PJHpc0O0yFvrv5i70zhxJzLkTlm5u/zun7E+oTIlZQZhc?=
 =?us-ascii?Q?q0/MfZRdIZY100QDv4iHj4KJL4H54VvlANQ51HJeK4yFQvqPACkD7pqmAEts?=
 =?us-ascii?Q?toqD5ApyW2qKvE01yE+ke9VOJjr+VAdiVHo+f07PIe0nokD8fIlgzqm6nDCv?=
 =?us-ascii?Q?aoXDMc9GXtZP1Qb1jkVj2/muY5NP8dH2K/10u7uh7shWshYN3US/O5JsEdHM?=
 =?us-ascii?Q?pctNliMeLriFwhwhiNJ4wa8+n6th/qDr1A6OTobaTFcDdtitJnVt07MXEOXt?=
 =?us-ascii?Q?jCMf4+J+avYWDFPV8bHx8yqvvRCY6op2AYQ/va6vj4Hs97+GWzvWKEVNmwvn?=
 =?us-ascii?Q?5x7JNq+dWFRenfkdDuZfSIsuhl3glg5MBNUMGQ59fQNSLHrBmPNRBeD2NImW?=
 =?us-ascii?Q?AdheteLtz2yYstp1lfgW9w16ElTeccdagUEBwBv2T0uVIYEO5Bo1r84jvIWG?=
 =?us-ascii?Q?DJVruKuGIBerfH7Cin/rkzTLLftmtWjx4WFrAfcOU5ZaVG5wPXR2Hlmr14WJ?=
 =?us-ascii?Q?eCQNhsYAJqPbYG/qlE86j/fMlQsjllvff1GMh0fpt5Xg6YIdrtJrHwMqjrKc?=
 =?us-ascii?Q?wkPoySdO4W8A0UgjSw/s10trOZSxn7ajpy4/Vd2rTUSejXagg3FTrQQS2MCW?=
 =?us-ascii?Q?2/XFLS7X2vNNQeicv3VhhHqq762mwaAw2GUFX8zKp8fbXnODDnjC0XSYaA7T?=
 =?us-ascii?Q?x2T8J05Lmq3m5dM/1+Mf6WQJXoBHenBSjIxDD6FoaT/antdf30woEmCKZ+qN?=
 =?us-ascii?Q?8MTU2MAaNH/Axzb9TEYfYcboSI3CH9GuB7uSDwkR7aYN9Q7sNNO+ldK5DNwa?=
 =?us-ascii?Q?8qD6f4WuFUh3FjeNgMEUEqXdzu2s1j/+C/CKXe4UKV3QqyIEdNgD098zSysH?=
 =?us-ascii?Q?tf26speX4lJI2Ic0NjrnUlpmiJFFxCORDZsMAfA7fIFjcuFhknVwDiOWpLQ+?=
 =?us-ascii?Q?tPckYy7e2PgUI+qSEuwu5yitSueWf8GHv6QCM5mYBhpYYJSgGnvx5LN34Kc/?=
 =?us-ascii?Q?uz0mNyIUMr9YUXLiXL0Zy3I+MIHZHdhqYAAzQnwbHF+UaBAfT0b3BWc1+1Lj?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 09+IEHjkX9D7NkT5jdxR9m5A+Ga/GVGwfRt2uKz/5bJ0V80hgVzKgfPNh6SKloJt+kLO0onlbhr1Hn5JVYSp3AYI6djoQagd4uxWyLPhxS3igowtA7A1PrcsXZiW1lztlCvaTKoYAc91LP81T+OBnDn06IQXaABxu4Z5EHQSYEaoxbhhqCVBPgQ2PD9i+9cAqI12Uswm3B3N6NdnYRMxxesRqm2zOsWpRWx53A0OT846jxeFOCIb1vcxAU2N/949vcMBIOdDwe8nvrgSeRdZ+X2pdG8gSUIJTBymwcxx9fkdgZKHMVIQ+iyyFf9bVLVahTe+I/khcBKy2KDNf4ad0KVvnkgesbKxt9TikGFKTRHTGjdgBvcgRyYwvbR7nI5V29du8kkY0crUWsxn+KQTFGiuHRl6vjNQ8/oL0PdPJyxjdoWU2Gweoo5iQQPrw55MtTRODCftaS89hMV/3qkFAMYCapiAfsWbefOKF7eYIXan7tlbt5VDobwIdxIMYvcK71eu8LFfWnr4FRqcmSPQtrNyOtXLEf1IXZkVKUtcJNPznYZLNlCfzV2P8+gOGXRYRetz1PTn7w/shVR9AzYWOaTwCkbWei0SdoUCPPhfu3UqbO/3yyTNDNEdEONmJ2DwhTU/jrcWJpBjvseMhpT/44sHGW6bReLbW8MgF8UzHRhsEZQA+TJ9476tHNrc5vrrGazn4O5WQ89YqcCYa4oTw17FhHRJXPxICejcnR57gmcG9ET/YsCx0sp0VZto1oZCLOkMyoYV781W8okC2vXO8gAa6A5xbM+DCMOF/KDp60mVHldr2w7o1blSoVctPVXCz86JhI4bS74a21Rtl0ZOaO6vHCUCK+qK0kdDcwRf5KM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54be031c-21a3-4437-2d4c-08db6222c74e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:02:51.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt0Fs9SIlY0Krn1nE5lOzxwrLdX6ziuxT0xLGKA+hx/O04KRYPauwtM3wP5OR472zsoHmaRpN3099jD6Yu0IDfgfFDAAhWk4dBFiQsx+ZuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=904
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310185
X-Proofpoint-GUID: CdIstqDyms8CRZ1yS8A1x_Vc9Y0l6BFj
X-Proofpoint-ORIG-GUID: CdIstqDyms8CRZ1yS8A1x_Vc9Y0l6BFj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging!

PS. It would help if you could submit changes like these as a series in
the future so I don't have to track each patch individually.

-- 
Martin K. Petersen	Oracle Linux Engineering
