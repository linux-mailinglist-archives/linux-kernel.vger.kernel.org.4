Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E81606C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJTXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJTXii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:38:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FEB22BCA2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:38:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KMx3dU003124;
        Thu, 20 Oct 2022 23:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OQENnPO2qjP7iBKirhEUY7Cn51QHkkTsHppIfoAEyzQ=;
 b=d2gOzy5d6r0vhJISzhSNpiXXC96ejcQ6G13mAMtrMEvSUzvazuJVIt5VW84gNVjB4kHu
 wbBwE3NdDLQDEEUJiOCl/MbawcZdonMcu3AlEVbCDMcisAewif3PdQTH0Btp5rYjHNwf
 GjnPzAJsdMaRuapuxPeNBxjh0CW3hei3S7oVe45ADKAn67cEeodnKZ/glPgqFYpBWwkJ
 6KCiDxycnjH21GWHcjUBdf1vFyTGt2zJralrlPnWoTb3cYF173sv5XrBqUZgixDBnbuh
 2rnmA+k8hZkLNMGrEqsDtyxKOuo78+sS7q6luMlgnHqmeh8iu++CGk9kkuIkHLIftN/+ BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtqkgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 23:38:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KL8RHj038603;
        Thu, 20 Oct 2022 23:38:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr2qsat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 23:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNkhkUmgP0I8oG0LzTwJj65jk9dGrA9XBncdDlY2920CIAlp3JeF/GV6/R0LpcPfPWpYk/byWsF8rpzp7SKarwmyic92brCE7k8sOVSr5tu7x0//k6rUgwVdy351UgR/h/XT2SLlcer5IGQpTyRbOfqFoFWwtv+mDl11HiQFfNQlQ1G1xw26dNCtiZdYYsdUrvv5t3aZci96tLk1hiMyCf/TRB9HivDtzmYFUoNsdqYiLODptQ2mlwGDjmdMfeJxG41LU1cswR9Rl1KUJKVgUm6qxI8w0izsbm5u1IeHrioja9uAGBFyUX8suFUoVCjXnunrmq2TZ6AOGRJu7bAS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQENnPO2qjP7iBKirhEUY7Cn51QHkkTsHppIfoAEyzQ=;
 b=MPA5/gDQB9iGswMnjyHCh9BQIpWzhTkJvTkVrx98hVMvVdb/NYvL9VgvhZ7i/4a/BXofYv45SztKHEePJKxDDjYiNHm0i/Velbsc7oNMNNPtaOWaaGi/ztxR4fYDhP9oPC6q+E9f2B5mORNPmp0xMm+g7hIbHPX8xafJbq/j9Tn+W7Px0AOUg5CzJTlPp/7/GEZGC3M71a32oDRA3P4lPtzAnd5i4lh72iRYJLR/jWEPrVDudv/VLUb6KMXFu/6mlNFiSOCzpWTFyraZCOXhImIiXcCPyDKSh9+TuElCZSbWxadxM50TA7L4Mr3hD0zPQh89ipXDRkH6CAAx7t8J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQENnPO2qjP7iBKirhEUY7Cn51QHkkTsHppIfoAEyzQ=;
 b=yyWUXYv4ryoXdyhz7KkGZKYyd3xjBpHk5GaNtmvVPNUGVRSL2k/1sS4ISotZ1tCdL0VoSeWnwTuxpXBoEqxL/pgFAVLt53s2xAyGnVObv7E9wzPhR3lWJ7y60ciKllKSWIPDnaPhMr8VAu3DgOhnkmtMrKxp10OMj5gQhbutvAI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 23:38:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 23:38:21 +0000
Date:   Thu, 20 Oct 2022 16:38:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com
Subject: Re: [PATCH -next] hugetlbfs: fix null-ptr-deref in
 hugetlbfs_parse_param()
Message-ID: <Y1Hb6sIJXrRwEttv@monkey>
References: <20221020231609.4810-1-yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020231609.4810-1-yin31149@gmail.com>
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e71b08-866d-4416-9e76-08dab2f42c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1iKd1DrKXzVN4vEhcFIzoc/NW/4oUe1QCwsiYBhAFe/Hl+1xLsHEFUrQNnV9F1PRJx14zoskhfeTlDXKigAtjZGYbOXzPrSsC9sjfYCl5baFN5cp+B0BYxdTGKtmPi0GCEfDdLyx4g4aK7jQ7umZWYZ8ztvXQs0h7nL3kctO4SFl8iVHCegG87tJzSd4PrSglTwXYqsdpii3ll4NJBgmzNS7rONNsmzjG/6eh52r9PRyaY2GrSuj+hGGRPFo7vgQptgtP6LvpBL9lJoe1ri6H7U9QhyO2MZgZrIWQPDz08YEvmX2KZlVLlR3krewyRiwgTpx5U6VQRi7scdsrjX7fd6ftdXBDSY0WSz2pIGGjLWMbUWDd65p2zoXElzDujTrylYaM6bADBOZG9hU/vyxGtFLMgJdBsarKVN2zWsmwXMecPvGK4xThn8AU7QMFSrqA/+Q0rjNmGddJM/uXc44wR6GOuwtjlw1nEuwZVEbgt6mgy8IpmSnQvH3Ex7XhfqKPe+HGZP2f1wDTU+mbW/SCyO1GeNaRoJ+FUBneDfXdhg0mfmRjJJCfSo+10Hp5ILx53Plq2ECVTnJdcNKl5ZFHh7yFcWQVFy8yWZxBF/dFYgnGfgzCZu5qncSe5x9X/qIu65UQp4NjFWGC/Pllkq4TsDGtPsn1tt4cxN6YxEKnuaqHjNdETz3OmW8bR/hU2bLyxb0/5UkCzDLCKrOr3Jx1qCh3yNnk20/mksjkpXw48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(26005)(966005)(6512007)(9686003)(6486002)(6666004)(4326008)(8676002)(66946007)(316002)(66476007)(66556008)(86362001)(6916009)(38100700002)(478600001)(41300700001)(6506007)(33716001)(53546011)(66899015)(2906002)(5660300002)(186003)(44832011)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N8EBmX6aovYvMlQ1EHWJCnveMHRoM2Yt3JtxV7lR2OdMKt+iwmcowUnEAIff?=
 =?us-ascii?Q?sQRnKP+2Eh8HYNvZjUy7spiLGqTiXqYdfANFVtjCog37JeVVZypV6FnVGESO?=
 =?us-ascii?Q?Mx8+W/Bylg6n9MJQs+KlV/ULn2F3uWj+icFhg1cMbKhv8ZmFKOdM61OplsWf?=
 =?us-ascii?Q?rZF0yVWOGYoAymS7ye8sfknOvYHi+yjhYDTxw/CjWk3vjuaooxqVZSzIlzbK?=
 =?us-ascii?Q?9unlFBBgopApEuSu3X1CUl4o3Mzk7E89ftAYtEaxC+51r+qk2icywV4VxwwQ?=
 =?us-ascii?Q?p3why+idSM3im2H3YRWxnAGR5Ghsyu5rVq2qEcV1gvMy1IjedLE0f64tzjXa?=
 =?us-ascii?Q?pUyxcAPH4AG/hX8F+82EhQI/wgpf4ZXRXw7aSmhUHMiAD7p9CtxQPz7Pf5Wb?=
 =?us-ascii?Q?czajVUQLx91nGlagnqItiY2yV5Ocv7A616N6eQ8p7Wobh1N7M+IFfDweU5m0?=
 =?us-ascii?Q?B1pM3VACy7p3dY/I/eDWQEFM7jWRk/0Fn1f4uT4gMsB6QMvUqx8JdtpVIbtm?=
 =?us-ascii?Q?7gG63G1SU9rclLBJsxFw84FHXEt2xO4Bo+luTx9cLJoLoQdxD6vMlc2GL7JA?=
 =?us-ascii?Q?r86GPheQcVyBtWuGbsdA7bFomjsvzVFsiL5z+GfQc5Am0YpSgHHkTwPJM3PJ?=
 =?us-ascii?Q?VetbsUP2p8YE8pDxILs9z1S1VEvd+vKYMR5R0GqRzDYA223p4tMGBcASAZhg?=
 =?us-ascii?Q?8vcfrpCRHBwN/kZdWpnA3CrR+duM81h4CLxnjfCRy9vMxtM7VQdT55dtugce?=
 =?us-ascii?Q?8XPN68irOnzlpqchFaBk3WihmgD0Q2OzcV30gyFGt0nM0Us0FkALcWf7fbXS?=
 =?us-ascii?Q?78BX4HBl/DyKwCCN/YaItN42iSNSIpLzWfEEOM1CMOsYjG7ROr4lsSy23N6i?=
 =?us-ascii?Q?9eTpdz+U6b0g3mIErVJYPlb8BwDtRyEakD2504bYcVKCerT1F79qKsiQtIXp?=
 =?us-ascii?Q?dL5sbYOOA/KCmevSbuPiRyxwLIuvfN0yG5NVxG58oa9RplfVA1OpV1zhrPLL?=
 =?us-ascii?Q?6QGMRQkd+uQBbSFT8Gcg8gqyuzAF621vdF/R3+KX2ZRkTQHDJVozwhvW7BB0?=
 =?us-ascii?Q?V78oEK/qFYNo4XGcHHSUh/ZQELraR/EXXEP5YHxd843muCYGybothVy/8/UK?=
 =?us-ascii?Q?h+3F3dIFyZ+wi5+Mv1myT1Zpr+UEHOd2HdFH/OAUY+P3ogRaTz1K8dE8iZip?=
 =?us-ascii?Q?kYwnrCEDuDqRa+utXKwufL4I8bn0L9B5v1J1BalZBiqoz4cKiAenqRdU0M+e?=
 =?us-ascii?Q?OaOeb0JXGwU0Bkzi3ruwmprODHTMHa2zKXnnWoiNShJlqJ/fMcZRcoyRU1yq?=
 =?us-ascii?Q?60PG9bzX/zcxZx3BoSsLHpCDPKpCJ8U9BOO8rs4YjUPRIf+waMnP4XEf3P1w?=
 =?us-ascii?Q?nJaPj7t93inXFHa8ZGOqV5eCPnjkWxJ3imcUsCQLNuEPf5lOl1imLHkonJje?=
 =?us-ascii?Q?abdgr2Ltz2gQ2TLB+GwA+J+CTQqthU5QtWzDZqin/UP6jqcF+bUeeKDZ1940?=
 =?us-ascii?Q?RjXCQs+H49D+0DHcGBqQpRVhTOA9ioBzhVNnswP/AS4C0nLeAvWoeX+uX+DH?=
 =?us-ascii?Q?kcj73bQSUhbcYQfgSkpZSxc8UUHqc2utRKMpjoPzyowLEF6G57AFGwpSxdD+?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e71b08-866d-4416-9e76-08dab2f42c26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 23:38:21.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APdD142acUf9H0z1fBrkkc6S3s10iHZZVJQLkA57FZd7pLKWnbSBotyfqQnRMgG792K3cJSoZRorWm/cL1x5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_11,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200149
X-Proofpoint-ORIG-GUID: l4Nu1u4a3qv2hn5esybpbiL2IJuurgDO
X-Proofpoint-GUID: l4Nu1u4a3qv2hn5esybpbiL2IJuurgDO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 07:16, Hawkins Jiawei wrote:
> Syzkaller reports a null-ptr-deref bug as follows:
> ======================================================
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:hugetlbfs_parse_param+0x1dd/0x8e0 fs/hugetlbfs/inode.c:1380
> [...]
> Call Trace:
>  <TASK>
>  vfs_parse_fs_param fs/fs_context.c:148 [inline]
>  vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
>  vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
>  generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:231
>  do_new_mount fs/namespace.c:3036 [inline]
>  path_mount+0x12de/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  [...]
>  </TASK>
> ======================================================
> 
> According to commit
> ac369cdd9448("vfs: parse: deal with zero length string value"),
> kernel will sets the param->string to null pointer in
> vfs_parse_fs_string() if fs string has zero length.
> 
> Yet the problem is that, hugetlbfs_parse_param() will
> dereference the param->string, without checking whether it
> is a null pointer. To be more specific, if hugetlbfs_parse_param()
> parses an illegal mount parameter, such as "size=,", kernel will
> constructs struct fs_parameter with null pointer in
> vfs_parse_fs_string(), then passes this struct fs_parameter to
> hugetlbfs_parse_param(), which triggers the above
> null-ptr-deref bug.
> 
> This patch solves it by adding sanity check on param->string
> in hugetlbfs_parse_param().
> 
> Reported-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
> Tested-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000005ad00405eb7148c6@google.com/
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Thank you!

This was on my list of things to look at.

Do you know if the issue existed before commit ac369cdd9448?  Just
wondering if we need a Fixes tag and stable backports.

I'll take a closer look at the patch a bit later, unless someone beats
me to it.
-- 
Mike Kravetz

> ---
>  fs/hugetlbfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7f836f8f9db1..3ee84604e36d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1377,7 +1377,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
>  
>  	case Opt_size:
>  		/* memparse() will accept a K/M/G without a digit */
> -		if (!isdigit(param->string[0]))
> +		if (!param->string || !isdigit(param->string[0]))
>  			goto bad_val;
>  		ctx->max_size_opt = memparse(param->string, &rest);
>  		ctx->max_val_type = SIZE_STD;
> @@ -1387,7 +1387,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
>  
>  	case Opt_nr_inodes:
>  		/* memparse() will accept a K/M/G without a digit */
> -		if (!isdigit(param->string[0]))
> +		if (!param->string || !isdigit(param->string[0]))
>  			goto bad_val;
>  		ctx->nr_inodes = memparse(param->string, &rest);
>  		return 0;
> @@ -1403,7 +1403,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
>  
>  	case Opt_min_size:
>  		/* memparse() will accept a K/M/G without a digit */
> -		if (!isdigit(param->string[0]))
> +		if (!param->string || !isdigit(param->string[0]))
>  			goto bad_val;
>  		ctx->min_size_opt = memparse(param->string, &rest);
>  		ctx->min_val_type = SIZE_STD;
> -- 
> 2.25.1
> 
