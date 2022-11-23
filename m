Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E6463689F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiKWSXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiKWSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:23:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677D60693
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:23:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANICKKI030458;
        Wed, 23 Nov 2022 18:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=M43O3/7P6Ij1kTUBC8/ILScmE1NSP/c/bb0gARw6VNE=;
 b=EU6g5sKhOzCd/sqhc4NKomT0YWj8Bga5bk0+c0VAYjdQhvKuCZi2U3fCRKSuSBwJUwEr
 NxdznHGK7fhM5df8Uh05wUnebap8g0E8TfJZnvwXONpEuOFCEpBMtjaKbuCSnnu0IZ0l
 5qt1n4yBZ8gZcm5p/lKJAqYOq/K+quSYBmYuCUVUKW48jNRAX8MJPhhhI8VbTIQyNPCu
 dJPbbcTTDgljs7P1xwF7utDp1irhm8p7+e258G7b7khyEvB2//FLmWAFWICNkgDXaUxX
 8SauRLcHYo4v5uHbAjfFG2VCDdZds3wG2KU6hMhnEJAiLi9YYGfdQtCiiQ3y/5zGyZ/n RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd88m3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 18:21:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHFM4C010711;
        Wed, 23 Nov 2022 18:21:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkdgbts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 18:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGSnm+Iasp8ibMXAVHteTHojt2IIcapPIe2vr4ROEnlmGmB+zx3M4aOV0kHoMkRB67pIN67vMUqLpEiYC5WK89qPyfTmBZaPVnrsbWdsOdwOQToRsP6Qg9ZewPZuaqGqmF+PgvQM4qRK5P5JI7Egk8jSnEMbtHgjtfWFPG1ivwbyPmWrAzjVYlBD+hhqr2muGr8qeC5h1gssYuNB8zZa9Tt68v84sOSL4RjCtXJnLUuquaqJPXxhwUdrlVJTcB+RKeAGyJddE5C1l+OlfrXzKgXyrvt/4Ov2MIWpR7aeQpLH6BX/1mWr3XqMhjDvSyXBvG1QHax0Zx+YlQUGMfDbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M43O3/7P6Ij1kTUBC8/ILScmE1NSP/c/bb0gARw6VNE=;
 b=mmmPameRB2JTA6HtqKVwIosYnzBK1dOfd2oi+AK63fIjVF+DrNZDGJinwVaTyGfNqSJvGieOKQ0QdN6g18oGaJ2i92fQwAJrP/gSCrtaoFLAejWd1HMf5XaFFnzlOYRZRRu34gf4i8aMNeabcmb6QMvhbUma9V2uzlZZxCf4Z7TDZ0Tl2R43+65n6O+y7+LLP7bov+32oLCdwjGaQS3fIq7qCSIkNX3f0fx70d9fF4vAIpP0/5h8apFoPCb7LpDmYC9WiT6/kjjOUkiDV64J4RPzRyHyNC+CxezsJVnqJwF943BWQLgpqv0SvU3Ni43j1WoB/auMJnGSf5/o02o5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M43O3/7P6Ij1kTUBC8/ILScmE1NSP/c/bb0gARw6VNE=;
 b=RuxdeRu1zW14bj9I+56e1OW5p/EETAnbXmSXu8IuZO3eg6UiUFeW+Pza/viXqzh8s5vG7o1tWLYsSa4vAW+LFOpxceRNPKPNdYnVmXKkSowDDxsKUlZQqg6xJSbW+B+59sCXJcVn4Wf4WeLoEZSXDbnqCIXSeD8osWxRArvsRrg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6977.namprd10.prod.outlook.com (2603:10b6:806:344::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 18:21:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 18:21:33 +0000
Date:   Wed, 23 Nov 2022 10:21:30 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Message-ID: <Y35kqkYQGW8ohKEa@monkey>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
 <Y343kIQ9l2d8wViz@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y343kIQ9l2d8wViz@x1n>
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ccf5c-a160-4bd6-4fc6-08dacd7f8c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QvzdYHTyGAaqyRhfXKHXa32+d3TaoSSL1/r9wYJmsFAHzRAaswUB3ON3k0l3URXe2dnktHadfMPvoT51788JsPI7LuRTQrymr/cVXWisy8ggGrIFSIPprA2LAkXsjcAClJ3j46sE3MhVMQdJVqGhz/5BEZGqAEh+UhNPFG/IV5UCKxAMm1D4NwUW1JBhxD2173F/AkTjXPn516qmI5Pp3eNfvp0IiHBRCPDZeWxG4bmoj2ERsombcuKvCZ2Qek/s3VI56bhpwoXqF2yMjfrYNq6MbToS1WF2QB2PuI7f3jiW4cmFHb1VZF56byMogUXRl+WUSHVouHSKoDUZI2KfbpKXlMNCwZt+rEPcNup/f7PM3vMUAmO2W6SunYuTVz6TaYYcZIti1sJNcJKPxNookKRDJYWACfU97rdfgqi0SNnfNZrisLzzkKl/ZNIeGlvMUGQBx/YpZnGJ1Nbt+rQkoEEwbvcwddBoVAJStalMGiHuHDFU6LF3ojVSGeLzRz+4r8klEL839HlYFayuBFFC2kJP/34biUmxtUHM7kPfYUchSfmwNeBD/b5qsZutDY/5y5Ckogh1qSKCis18IM+GFkTA/2y8Uh3z96obZf0ZZhT2hI3sXf57KU34OG91Vc5uCiDY8ddSrmALXU1Qoi0aPSlZA6IEp9jkK6tjkj4EGwi+FkqszGZ7BeZq2M6f/Twz/cOrYiuJgo04UKu+2Dau35wECsL6ENT/pJvOTMuz4QaZIVGPzJhdFVfPlUtJtMu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199015)(2906002)(83380400001)(41300700001)(186003)(66556008)(66946007)(66476007)(86362001)(54906003)(9686003)(53546011)(6916009)(6506007)(38100700002)(33716001)(8936002)(5660300002)(4326008)(8676002)(7416002)(44832011)(6486002)(316002)(966005)(478600001)(26005)(6512007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8XOMrji8hjKWbbV+qzFOHZtypZfFaO7uuyxkpeaPfbT5gkh4hUJvD53C0/+?=
 =?us-ascii?Q?q8HtUTKkIwKz52E7xX79YSdHfnklvHdH5/ZqHaGbmm1xFLLosIfqbk8ScC8T?=
 =?us-ascii?Q?C8/P6f84os/PrmRkg2pgKf00AKibW7QTX36kCZI8NFrKqlIgE6Uk9YX03Zne?=
 =?us-ascii?Q?0L2Dfv7jLf+9l9PLJiI6PWdqSS7/OHBTud4pQXwJM+wnXXtHbej2xBj3bItn?=
 =?us-ascii?Q?TL2tPiQA1nv4T/MENngbqrKbcphoZkHuU1FipQqHrypSAaE1+3QnqbdH/0cE?=
 =?us-ascii?Q?yuMS29bH0QciymET9nfrkP6mdX5tWH0BimwA1HS69/fV1ErUP0vXyuWq9bW8?=
 =?us-ascii?Q?xmdsZafCqAYqsHEyTPLKVLspRwkGhsYum7JyXFH8zio/lVkcKzlROR2Zt3lG?=
 =?us-ascii?Q?HMOldX3257MLdHsFR4mR5kjPkjDqvJQ0ZIjfVYvSm1b81YWi+osE2j/WVlUq?=
 =?us-ascii?Q?8f66B5aUCq9bm1W8hxuw0A2krQ+daKzsLRYsNWz504UuZePeHjV8o9mDyual?=
 =?us-ascii?Q?BeW14ijCwGZyS7EvT6OKah8I7o5kmRrwftlxswauI62CQ83n+dagVax5TNhq?=
 =?us-ascii?Q?YdN1YdavCm2t8BFBrZt/BlcKeE7d+ru6rKv9ChxV2npY8bIokmfKl+T7ZWvE?=
 =?us-ascii?Q?CSCuuSbv1/VCdAOTE4MduVxsoIPelP+Vz8gnV4k5nbfWmdc4oZ4nQkrY6ORh?=
 =?us-ascii?Q?6Pc9bdwMlLmRpFniatTcz1LrMuduTxzE0mMZeWdek9xKKQlZGnV8Kw1F5SZz?=
 =?us-ascii?Q?pkYjMpvucI2JLmzm8cZtiitmlbyUG0UXf4Tlt1rz3lx3r+J/YFOez/upW6cu?=
 =?us-ascii?Q?h+erqjsFjTPTeKg5Sz7h75Pr9d5c/ocvbvs/e8d1s5e6IgMjcp6yfX9CDXw9?=
 =?us-ascii?Q?mPwvU+qoeDhgTwR+L8cYjJ89s8q8G8BS5PqUUMffx8T5BT/KKWS1M8NNN0Ni?=
 =?us-ascii?Q?tU4gYeXRmiDIe+KVNwrKSv0XZ5tjjWcd1w/7meBSQZSCE9YwKO2RuzGlEJNY?=
 =?us-ascii?Q?WkGINE3IoBD9ZpvEUvtRuTcREhflv7tiIfy7lZfSuy1lm4LKAKE5KSr3dSkJ?=
 =?us-ascii?Q?u4mFmoaDpKmmkqbYDX14oU0SdCmrweIt9CsG1gnvHIQ6ozvQTkdtZpkOEyd2?=
 =?us-ascii?Q?dloPqWtbh6l9dYj3TlbxZKZxHA9dcvxHgXd8zaUeCAhjh0rwmqE6T300AMPz?=
 =?us-ascii?Q?MLoSRM+l0s040oUdqFFVQn4Fvho0npzRHHGFYML8TVqMKKohQk3CWz4fwunR?=
 =?us-ascii?Q?/trmypPXoq7DZI8yQcXDihuBO+o8RUiaR+3r60gAoSK//st+0ZkrsPpl/DQJ?=
 =?us-ascii?Q?CCnCDz01KwnlzZW00/wkGxbqQUCh5qOczwU5RDTWxzi6sVoeHDZCkvIHg5FK?=
 =?us-ascii?Q?JvpMZz+/DZz5/EUDl7iOYCUlcwM739p3YHbrwB+nGtsW59DrIH7rdoXKQ5g2?=
 =?us-ascii?Q?4EYtsnP6oE5BAzQxTU5j/mWaTEObkIDQpwoUniPlaQpI5TIJKeBwOgqctJoJ?=
 =?us-ascii?Q?beW/BhXwCbzrfTSswgCFAx7AWpIqfrW1S+N1a/6biqSFSMRatxIeC5q3lrcJ?=
 =?us-ascii?Q?k0VC4r/O4FYyr9L0XJoVDnkru5Ngdx3lx+q1OqMxn1nl/J4K1Acrqq2FF9ia?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lQoQez4e7Ih3Gsz3TX9D+tvT7ZK7+SygIia50e8Sk74thCx83JNPflMYdaWx?=
 =?us-ascii?Q?VHeVgTSec80azIRvhmhhkKqWWJb5Qhp+1eRKTO17kpcChnCCXiRHRi3QT5wr?=
 =?us-ascii?Q?9AdIbRpihAT+eylwTD9gaB35I6AuTDnnhgZ/r1xA20HtznC3Gfb/heA3di8J?=
 =?us-ascii?Q?A2Qi2hBk2yQkTI2LWixM+Stq6+MSwSB/VRyxEdi+W0U9N8wv5ucqAl7+34KA?=
 =?us-ascii?Q?HHd0BW/ei+GEtT1ZOkJGSPGPH/E+jH3apSGVha2pmgU0c/8gh97PX8wVNwXl?=
 =?us-ascii?Q?QOvygqUfSf667NS2avQ6jO3claUfejErxzkAHpUH0LTwjDIB7QRQz1+HWX2h?=
 =?us-ascii?Q?umMY0fyJnvaPqKTNN5MBc0peLMWsMWv0fhjl39HPsTHexxULs7de98NJuuNE?=
 =?us-ascii?Q?r0Lv8HrF5msFX7uCwsjUk7IwaUtlg1Q4bIrNsebwiIwazV4/7QGwOJi//r15?=
 =?us-ascii?Q?A3sudZbiq9D88EA/Hmgtrg0qBcoCzLDLe1Bd9iwiwJboZRsaGvBfpaQ4ScuB?=
 =?us-ascii?Q?oUCKtbBhsqvbhG8Ts1ARqQYwpAqC2YQCG3w2rCiwxOdQxnPUtJc0+uiFxmOQ?=
 =?us-ascii?Q?8Xhg0b4f01zG2fOKzW9QyzXW+kT9uf4WynMPWJXg9Uk2L9+4Uo7r9nSa1rdd?=
 =?us-ascii?Q?w5s3SnhjvzbsMA5BV+cjma3mH4gAVPrkEzS8rX6QjAnlTn8jyYwjABswAPEv?=
 =?us-ascii?Q?uDYtNX9KqW7rwfoLAQrDCsVn/6qWbREdCAK9zG6D1Sg9BaAqPupezwSnFe9I?=
 =?us-ascii?Q?LVTNeMrKMH7buyYyHW2PxYTj/EHmKO7ckp3sPMrz5JfAceWBlyTOiPPdgk4f?=
 =?us-ascii?Q?TcwW04cr4/y9w9gzBOlFORCNQ90eLmtA/8rpzIQ9n7sxeHmVaPk9n5cG283O?=
 =?us-ascii?Q?emWJ2KmctDx0j2PDwJvJhLOTPz2bmm4RbrZ6E87GArVmbNPcmX79raFPrYEg?=
 =?us-ascii?Q?ESh5FoDFudVDQn+1dDqsyus4IvZUdJEbAKXGf35GT0UgeXXtDO+1SPmZQWkx?=
 =?us-ascii?Q?XcFSFJMYYFE5eqpm0AlOVEsGEpVvhhcAtozFx9HgQ6hVWAuBxIIAyd6OyM/d?=
 =?us-ascii?Q?XIKLiCUEgqdRfAypvGpcNKeK0/Sy1w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ccf5c-a160-4bd6-4fc6-08dacd7f8c52
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 18:21:32.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dkw4CIl05oDqg6okW2ZKzPZ5T32HO0Hg05DP0ilPVoZe9KNYaLJ/0e3qPqE3V66bPtlciIxn/ZIdubmLoyJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230135
X-Proofpoint-GUID: nzXyAxytYMWdzzNYnLhD5A5292-nkEr-
X-Proofpoint-ORIG-GUID: nzXyAxytYMWdzzNYnLhD5A5292-nkEr-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 10:09, Peter Xu wrote:
> On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
> > Let me try understand the basic problem first:
> > 
> > hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
> > don't grab the page table locks. That's very hugetlb specific handling and I
> > assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
> > concurrent page fault s... but that's no news. hugetlb is weird in many ways
> > :)
> > 
> > So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
> > we use some very basic locking for that?
> 
> Yes we can in most cases.  Please refer to above paragraph [1] where I
> referred Mike's recent work on vma lock.  That's the basic locking we need
> so far to protect pmd unsharing.  I'll attach the link too in the next
> post, which is here:
> 
> https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com
> 
> > 
> > Using RCU / disabling local irqs seems a bit excessive because we *are*
> > holding the mmap lock and only care about concurrent unsharing
> 
> The series wanted to address where the vma lock is not easy to take.  It
> originates from when I was reading Mike's other patch, I forgot why I did
> that but I just noticed there's some code path that we may not want to take
> a sleepable lock, e.g. in follow page code.

Yes, it was the patch suggested by David,

https://lore.kernel.org/linux-mm/20221030225825.40872-1-mike.kravetz@oracle.com/

The issue was that FOLL_NOWAIT could be passed into follow_page_mask.  If so,
then we do not want potentially sleep on the mutex.

Since you both are on this thread, I thought of/noticed a related issue.  In
follow_hugetlb_page, it looks like we can call hugetlb_fault if FOLL_NOWAIT
is set.  hugetlb_fault certainly has the potential for sleeping.  Is this also
a similar issue?

-- 
Mike Kravetz

> The other one is huge_pmd_share() where we may have the mmap lock for
> current mm but we're fundamentally walking another mm.  It'll be tricky to
> take a sleepable lock in such condition too.
> 
> I mentioned these cases in the other paragraph above [2].  Let me try to
> expand that in my next post too.
> 
> It's debatable whether all the rest places can only work with either RCU or
> irq disabled, but the idea is at least it should speed up those paths when
> we still can.  Here, irqoff might be a bit heavy, but RCU lock should be
> always superior to vma lock when possible, the payoff is we may still see
> stale pgtable data (since unsharing can still happen in parallel), while
> that can be completely avoided when we take the vma lock.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
