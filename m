Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8A5B9FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIOQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIOQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:37:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42805205D3;
        Thu, 15 Sep 2022 09:37:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FGBcMN009729;
        Thu, 15 Sep 2022 16:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rmI48xytOe7jTpFlBLrebcg2J2Bb9N81jCAuSiXf1MY=;
 b=Fa0msk7kUIPeSJoMIlzQVnfXy31uSt4I97t0ip20NXja8D6C2zcg2olrTV80h4pPZxC8
 KBm9Rsc3xudqEoQFEGTOYAniUeJ8MfhBVghzsEPT2i44vmKGUkc+tVXvt9/b41maAADg
 WQrwTZu9YL1pTbsK6YECnhOCfR/t2MAAh/idPHSXZ7jWTfQTIWo+OXgi445T9eLQNhto
 7hng+bJDyBsYDdfgp5XaEjRhtyFHW+CKoxcspuopS0rwrkgiLRgCkdvFJPurmURwU9F5
 jRUvJSfJgPSDId3+rUrAIhg4xLW3nHQUZs4fXC36Z/Pmu2dOvFgqa4ayWYGCfaslsR3S mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypdvk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 16:37:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FG5TB8037201;
        Thu, 15 Sep 2022 16:37:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyek2h2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 16:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENXOoC4knUKe7eZ2cdqKNoffZbndjdDnZqztCVNV95BqXLN4CsVokmDofRnThlQu/5/tXQcYBR3vAw5ALajAP9pzrycXRNroCM4JSfIIc3Vq/+iee/cFBC/LAXaAfdyTlKWXFcNLVdUNhb9eoYDahX9FTV5JO6os/4wBGpgePasRjprrl0bfB8d3OLCg+Jm8ulXYWhYNEmC4f/GtPtauBEuBajaxxPNyhjugUY8CuNy4S0LReaQ87Krp0FMmFZuV9pMrm7M229kWzsjc7HZaRi++GlfyQUTaaF4NcdT20YOONG0j6M2um7nLoFR3lylm4OqeDSdGcYJHPffXSbaoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmI48xytOe7jTpFlBLrebcg2J2Bb9N81jCAuSiXf1MY=;
 b=PI6cOpw59hQ4nbKVMBRthf2dbeqpMk4xp4Q5eTzZLCS+YRRynZ4PE63MA9J5XltC5wmILKy0oSqbeDjA7d7Zb08ULkh/W3OkDxCIKDQB+0AbY5PaaqdIDP2i/l7Gb5eIj22faClNKGYd1yWAnbbWsET61plgnSL07IITPCUpa6LdQmKVq8Ft4rLKojx3OF8e4gGlrdDI+BFJJDE5djNpNlIwBwKwZYNd7W6cO9cMEaiYQWKbreH/3CjOpPz+ktyJyTDu1uwWQ9NHIaJ1G+0zUyWSTRm6zZcR12Qdq4Vr/wQzJE11/QDmniilmZ6TZZgPWB29hXuiOGC7DJx3vQukGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmI48xytOe7jTpFlBLrebcg2J2Bb9N81jCAuSiXf1MY=;
 b=GlzJaSAwucHgzOYqH/Wom9OBZt/oMqZC0oUN9zuw4m21bMIQZiClMuY4QPNNosKtzJJ14RERpHzt+LVz23rRkvJL5OgWrb7IvE+XYEnG9xgfkBVg6PpSJ2c5nwUCftxKhNpxXwNCHrfHaBUU0n5Gwf/7nfvmjI29IPTkgNJRNp0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 16:37:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 16:37:10 +0000
Date:   Thu, 15 Sep 2022 09:37:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <YyNUtA1vRASOE4+M@monkey>
References: <20220915170758.71068f92@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915170758.71068f92@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f18c5a0-cd76-4e59-6f71-08da9738897a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/VK9IkUcYSM+DRI2f4sPs7Vas+qqo8v7SLWyz1d/yzb7W6392PDibNTh/1O2Cxn9Sbj+9xfZ8sn+jm5oa9scKJ82VG/0xJ48j8v2Cl2YwMKylqgbXwBS5RHn+BCdkRjYC073sl/X3Kk6nbhrpVq2Oe+O8UZ/XoZN9udoIPDFqyI7xBqkcmq/PznAXPNbfBmxMS8d/LqLH0iN8XyTZapxDDC3GGxVbU8gqDfCm4OBN0euXrdykMEAeainYgAg1nxmhKPtEWVBwo2suO4Cs5hxDVixpzgaIdp+2LTirsJFpwX1/RSlUfTADT9EJFxnSX6xJQqQqq7F31y0zXaqpwRrThVAt4HnhjCyyQr0NBHAaOEvEZNhFgi+BNGa0RfnuyLBV02ZGyo6rRWcQTbpgJXKQ15LyJM4+IgzoTrp3uwoTQeMJqjCiFsi5mIDDLOxyw7INCkgWPSQem/SB+mTJiXCnzbsL9WIqUN6FQ1dEND8UkGcZ/NqIyyKjBWD0qubUvcfEgvK7oO8DI6TbE8lnDdId/4orJIwFOYcqGmdEbaeIvQQmCOtpnOkUTRQbXeQ9C1acr42bkuB2BpDk8zngwa6UNtKeMqizH+9lWwz4GdYKzsxIvOWhz7r3+BweSmpRu/COafZyUvlQPBD4Clzrd2Lf79jSaxbeU49Y5exlG47KS9AhN9rgJJOjigfJHzC2wlDa77Z4KrWI5nn1hSApJ7+T1b8GWsm0dXx/UsX3CdVdCjGyjulAsPTQulP8qb6exZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(66946007)(8936002)(8676002)(5660300002)(38100700002)(2906002)(66476007)(33716001)(186003)(54906003)(66556008)(6486002)(6512007)(53546011)(41300700001)(316002)(86362001)(9686003)(83380400001)(110136005)(44832011)(478600001)(6506007)(26005)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6GGPBaz4HlK9kS40vIzDQrdGk9iF3j4yoBG38G5NhaTwsZeufc9GkBZyNs8v?=
 =?us-ascii?Q?XK3BMGgH+0nDERa6QoyaWDH9CT9F+MAYoohQ0rjFyQlXrpw2dZFNqJzYTb4J?=
 =?us-ascii?Q?ufUA4jgp7eEhJhpZC95PB9eGpUm2tIeKTE56aEolyfwwkcCRqmB4jFdhjSo+?=
 =?us-ascii?Q?wl8Dc948peVd5EHy8gkHjiWFBOJeY1+kALhhu4nh8osP2OLQfh1FH3Et+43+?=
 =?us-ascii?Q?Ec73vJrs2p922te/VcJm7HvykF/0OYi3Ngz+BDyke/YeZ7NNL7mEP9ezitj6?=
 =?us-ascii?Q?oOd5KAN3F9PieUnt6JAJCDsVNi79qsYd/6d2ZnJ6OHjKb05yxTiV5C3Dm4IK?=
 =?us-ascii?Q?98Gv6HV8HU5VG0MZOZzO36xmphz87re4BlcCjJ0M31P/+FfeIltNiy7bMLR5?=
 =?us-ascii?Q?Qc3HFAFr1Fx9ipoVBjTkm6ma8J7+BCxnCqS/zQX/4YMZNUQoufaxsXcos3ex?=
 =?us-ascii?Q?HB2QdUp8pxgtNiVqwBjKm7ab1NJ0IXbxWMskM4VFkmibwItzno4HzzHp9OrM?=
 =?us-ascii?Q?A+N5HcI76UMRVfuCVGQq2ujQVb8h+jp1AMrG9ZcYzsLx/OHzUUECQ2eh5SOJ?=
 =?us-ascii?Q?Kyrn/BwFxYk4SfPBRE4GDYAVheetX1dgVdNp/N0DhBL89vjr3iKR+PJ7opnZ?=
 =?us-ascii?Q?PIeMQgbQHf+pCJVHXhp7GP5dXUid9uX1MiVICttxDeCauvsguJiPTotLbaYr?=
 =?us-ascii?Q?lnOjIb/5tt8LX9rApgDo00hGWWp3C+0Tcr55T7AI3WIDmbydzrA1+oobEtFX?=
 =?us-ascii?Q?ZjWrsuVRjW8vRDm1Uv8hVbUcBSYgBgsBxVPG0BhlTi4F+V1AFeERt70LmQ+L?=
 =?us-ascii?Q?nZEcp2M+AdvMf7fBAk+RWo7O32lWjSW+NljClUXqrABb01IuIQ8Imqktv5iw?=
 =?us-ascii?Q?UZ5GRrmIx0lo1HFQdesPhcv0OLJ0y3m3kNxdWTaB6PBXJp+EXwaat638x8/n?=
 =?us-ascii?Q?QuBzDLEGen4TbeKKYGk4HD5B5JBSpCexAUWVEjSyEfXgrMlRBGGjOO3eo6+X?=
 =?us-ascii?Q?dSkQtUBRhOwyS23TLUAVQ8o2g8TSCrzZiHTOZ72XfSiI7uQqXYoQj2+FC55N?=
 =?us-ascii?Q?WO/Xw0fHbgPFR0/iVSlNId1eg6ZM2898U37wbw0U34npkcHkExNxrU7XGjYx?=
 =?us-ascii?Q?07WitB5sCpJnSjrvCmXdot17E/JDn96x8TEhL1FeUZA8k7niw1V/Dg2/qFWO?=
 =?us-ascii?Q?2dsiMqWD6nE6WVRI/q7fyIzqaAieND8ibxcF78BkGf1ThOFkxdUmoQSIsMFn?=
 =?us-ascii?Q?nJvDkfNc0IsB7aJ3XXmw3w880VDjtJQRBQk7LROVyh6GOt3Fz/JzZUXUrC9T?=
 =?us-ascii?Q?Dt6bsXYvlC0OrT/NGeX4ijxw/4iuHkbj6HArW6PSMbvsJWwAtblvPAwQX4qD?=
 =?us-ascii?Q?UQS6OKVcSKzr1sa5b3qMfaaXKDdE+WTHpshPMiAs1kha9nzMxIWRdCWwGXwL?=
 =?us-ascii?Q?4CupxiRPzkT2vuWgaMkZDkHvuDXBTVDTJHm+35Y4lF9L0PMeOwKu5T0qXHCX?=
 =?us-ascii?Q?MS7insX0GfrNaHsSr5vWoqijGJA0Rh1yP4Ql8YjhccXxgSVZa8rJUqNHN1hI?=
 =?us-ascii?Q?YvR6Wtm5+b36CHO3moAVLecCtftcSKH+66BuefsmVAJmOFshmFGSnGXVxtBG?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f18c5a0-cd76-4e59-6f71-08da9738897a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 16:37:10.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HgGH8Fd7zHilnbjw3OMlZMEqLIioG2g2tUvSuIJ98avULN1Tq/PLse3T7m4E8bSdDSlISG8PpHhZtCJygy3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150099
X-Proofpoint-ORIG-GUID: RUVKpTp4eUGzvJTpCboBz1Joyi9n1u8Y
X-Proofpoint-GUID: RUVKpTp4eUGzvJTpCboBz1Joyi9n1u8Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/22 17:07, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: warning: discarding dynamic section .glink
> ld: warning: discarding dynamic section .plt
> ld: linkage table error against `hugetlb_vma_lock_release'
> ld: stubs don't match calculated size
> ld: can not build stubs: bad value
> ld: fs/hugetlbfs/inode.o: in function `.remove_inode_hugepages':
> inode.c:(.text+0x2538): undefined reference to `.hugetlb_vma_lock_release'
> ld: inode.c:(.text+0x25f4): undefined reference to `.hugetlb_vma_lock_release'
> 
> Caused by commits
> 
>   d56100904028 ("hugetlb: use new vma_lock for pmd sharing synchronization")
>   47bc61e7caf9 ("hugetlb: add vma based lock for pmd sharing")
> 
> The definition of hugetlb_vma_lock_release() is guarded by
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE, but the usage in fs/hugetlbfs/inode.c
> is not.

Sorry about that!  When thinking about the need for a stub, I only
considered the !CONFIG_HUGETLB_PAGE case.  :(

Andrew, the following change to 47bc61e7caf9 ("hugetlb: add vma based lock for
pmd sharing") will fix the issue.  Would you like to just add the fix, or
would you like another version of 47bc61e7caf9, or perhaps another version of
the series?  Happy to do whatever is easier for you.

From 8b3031350154e8e401ccfbc5e71cb95ef654d017 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 15 Sep 2022 09:33:44 -0700
Subject: [PATCH] hugetlb: fix build issue for missing hugetlb_vma_lock_release

Add a stub for hugetlb_vma_lock_release to build in the case
CONFIG_HUGETLB_PAGE && !CONFIG_ARCH_WANT_HUGE_PMD_SHARE.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2207300791e5..cc7877da18d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7008,6 +7008,10 @@ void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 {
 }
 
+void hugetlb_vma_lock_release(struct kref *kref)
+{
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
-- 
2.37.2

