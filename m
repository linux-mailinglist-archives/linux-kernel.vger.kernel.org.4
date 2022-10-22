Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E966082CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJVAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJVAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:20:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38F18DAB7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:20:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDovE005601;
        Sat, 22 Oct 2022 00:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=M1eVfLKhox61XURtsV92Em7f0mRjZOe+TduXSAWyTF8=;
 b=jN6DegAd16cTwaD7/2jYEJms0GpM/kmtZzUf4lxCWJneYrw284uyVLq3QVARQ0LGBGor
 lu43w41GdiHSPld7SAfcVNTXxR1ovDP8vkd6j6246qDKK+GnciSE/hsL2erqAEzmxeuv
 I7GL8U4qlYNkvihuNlx7oNjCj0uxPFyWpRRRe0e8XWPCN/KjkzvOFaUILT2xa7KTWlwn
 QeaQmS7LbbHQkqyVlTXk5wnRrWLu71/irpBm4LQUKmRSVLJwB3fpZI8oLkU2N7NdG6e8
 sVtU8ltUwOpz6EfveRXX6YyRBxTDVyUMrpE0S4EofTQeXzHtB5/cjrnb1AOfyVPwRA6+ 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtud5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 00:20:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M00TRv016967;
        Sat, 22 Oct 2022 00:20:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8huba48e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 00:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8FfoiP+gZQcM42RCTawj9AtzaFoaEIat7f37JC91aLw+Kbsz9h2q/sO6Tez1QQw2vP3OmoOFFltUbTr/kyAqVfgFJRWBpozFsH2NSRInpPcahaLuHKnGmzqXJaagteTafy7HtNZ0oOlW0rwH9VM95VbDVw+YOEA4HFEXPqVrMTmsyUYzrWTJvae0Zb0a+BZbPd/5Q80+RUEbZeh55CqXvyAcEH7LbV21PBJM/vOOR5VS8Ef5IM8QXkJ6M9k2F+Did1n8q7PzJWIBTG1CmwUtbapISfydC/DUSrKCMNMSDuPw7z6Fhd2SXR/YQL5Qw1XFwPHwFqdYEk5teG1bwWtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1eVfLKhox61XURtsV92Em7f0mRjZOe+TduXSAWyTF8=;
 b=Niyij/XX/CUVhp9uwL3pWvwEkylsMXgYE6AmYkn6qOO2+ORZtykG73rw2r9OqgJlP/KLm4L7dvOi7tyLuvjDq1BQ/G1XFNqC4vgVIbhklg7wYtOJd6JFJKUU1TfwHMSoBS8UdT57JzBO6EsNDA3HJXf8oQ442E+REZ/14HY8jbnSNuoUhScXW73A6uxOLDcS6d+oWQ6mcAaVnBAxuY4vAS6fza2NRW0N3pwryVBOJX68gtshYgtkbW69zoGauFzasdgnKABcaN0MijLppUc2W0Fh6F6hbS+mmtNqzKNCg7USfdT46l4Z2wEu2ahHA66tGlpxtPOO8qdSTSSvc12d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1eVfLKhox61XURtsV92Em7f0mRjZOe+TduXSAWyTF8=;
 b=O+08h/09EL1VwT0e7raeOz2IuUbcXZ+9L4Lls6jOI3zrAKhA3e/0xvQI2134cczWRLVn4egYUu+WoN4b25SJeddK7/Sie+OK/m0NqefioBGgoL199MoStFzT/fu8GUCosGB/8M+ru9Y63kbAJ6dDkUIY32FB47ZnTQQ7YUAzYa4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 00:20:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 00:20:12 +0000
Date:   Fri, 21 Oct 2022 17:20:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com
Subject: Re: [PATCH -next] hugetlbfs: fix null-ptr-deref in
 hugetlbfs_parse_param()
Message-ID: <Y1M3OQSf/gKLKYwt@monkey>
References: <20221020231609.4810-1-yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020231609.4810-1-yin31149@gmail.com>
X-ClientProxiedBy: MW4PR04CA0386.namprd04.prod.outlook.com
 (2603:10b6:303:81::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8bff5c-54bc-4b93-ab94-08dab3c32f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AVwUk/jTVG+085Fe7JIuHQpuTZSF7T9MqqQQc/QGsFhFYhsDpQEradpgJzZV5zR2DNBO6/AhhRhFCfvsZpHKqWj3tI8AqZwXdkSi5wBSJNPqT4BlEzWnFNzWZgLgr/fJs1dqibsqxDy5uDkDYknC7jm1girdVFuR0xfnCDSfNJm+Mytcehr24gqGP6l4HNEpyiWZFmemxCYsUmFU6LBawcFkzNxEOOGa2Gm1TWMrB97IEa9VpmQTsWDf+UzdfFzpfQ7XCdND7aT/qtBnSF1f+OabwpCe0SYntVhBr/FmfDjw+Dzja5C/Bwk4aPD4aHrmfQYgbL0HtIxwamaJlsGh1XBY1sqQ+eADkzKIPh4+nMrnIQ8HF15VqNdj0w62EMJQQo10kRA/OnaQHBs+OPrhjHjOxAEIR3lUDHtJK1jO0mNaklsSwEk+hPDo3Ji66nrBLchgtteoVIQUOLN9DNV22YvFBtleXLC9qEc9tTo1j7YOG8s5lE1aDpiK6GP9IbV9QOQ0cLY0QEEH99XRKVhlf7iKF/T1qjFHdZl1PoAHxCbG4pQe29BmT+WddOYNElxgN7Jf8S+qo+TZvnLIeuY51vJWg9fGXS0Nf2iHMEuWVTw+q1XpO8gacdmogQFQi5t0UH2G5TKuHMJz56Hyo8hiw6sxz6SirByGLzxfaOCBBKnc7reoY6vzmt7X6T8zP3HsAULkO6euiRKknIhrMZuDg1Vjq4K2yg+2urSj7MD1dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(6486002)(966005)(478600001)(86362001)(9686003)(38100700002)(33716001)(6666004)(6506007)(186003)(83380400001)(26005)(53546011)(6512007)(8676002)(66946007)(316002)(4326008)(66899015)(66476007)(66556008)(2906002)(5660300002)(6916009)(44832011)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBWINQBUrUCQBa0+s7+GsaaTOuXE2b8EBM9ddbw6otEOWf6lLZlDseLZkAgv?=
 =?us-ascii?Q?PCB6nDu1R4ilJF5dln8UxUqUVT6JDfi+q1CKExXOT20mVzANXxOfnrpWjP+n?=
 =?us-ascii?Q?RrhWTq3iH4HkoND3zJ+h3L+a0hp31pegyPDfAasBgyWQne8QX+wevZ81LdRN?=
 =?us-ascii?Q?3dgKz1xfdBRyJWFGfvCCkaJXvEs+12cXI9rwFHs0keqy8l8Fcu0Os/+CQFAw?=
 =?us-ascii?Q?41/dQ9hSmt32bojBlGPGesVBqcLobUoKogwWLR6LWSjJkYalQZ7BHP76uacn?=
 =?us-ascii?Q?ODbIj4EhSlPVFNN9O30MomgKouhahrKSg3eGAadGO6NDQKC1kCd0vqYSEXfe?=
 =?us-ascii?Q?ACVR3Db8aAIiNLwcTar6nzx+9OlKx3HgtbScLGcNvBuj+lDkScbdIM0lIXdg?=
 =?us-ascii?Q?2+U1PBhBSqYseQnHEQbE8Gz8y+k6bcCp4RGWiNIlxTLq8QAoAnTxpi1kPYki?=
 =?us-ascii?Q?5hH1eXH//DNIJiGIwCVufAii1ZImwYIUMvzBXKjtHxm3nbqs2J3NVslnTCZ1?=
 =?us-ascii?Q?VlgvEMHdFdf4zQAuXeTiAxxE7bDSs7rYrLRR0SJLnpg5/n6D9XPIgDgGXNm7?=
 =?us-ascii?Q?zZxM0VTxFsBYwNyucEo4bdMHaQhNj8mBHXXNQBMVJjEjgok87OKHdcXD40h6?=
 =?us-ascii?Q?uH586V/awZURc4j49Ovp6K6IMm3A5Q0ADFntb/so+ivYuiLQn2zLRTQ6ioNE?=
 =?us-ascii?Q?A66VjoGkv+5+yjp46HgJXNuBDlT8AkgfArDFhCFpcbjyBIpflo1flTvsXUop?=
 =?us-ascii?Q?lY7AcQynVivppR75xMqXLrIhOEUBDmTFMUFox0AcVf+ayZp/6fzGC0Vu+9fI?=
 =?us-ascii?Q?xGQ30NT8FCObVQOktkKOwBMWpsXbs1ZsfXoi+U8hsMIucBv9uP96HTKwplkg?=
 =?us-ascii?Q?QN9WBGUo/274Js3IBkFVEThdeBbhrXaLBqzgj/j+NBopEAnPSy+qYInIIONZ?=
 =?us-ascii?Q?8jJNjf/yy9M8MCVeS7txuLTCy5BZlHq9PxtxwvRXlTD6XCEjQ1LQhY7zbw8p?=
 =?us-ascii?Q?PDhkgE98//3e/F3oORobcONBfmbF9LWH/S792A4fUqmGWLFwV1FMdx1wsnxL?=
 =?us-ascii?Q?FF+xmcOv2pHsEcrqUUwXkSBAxHG3h7XxGctUHbxMTcrwOQXQDReL3NTcPXKO?=
 =?us-ascii?Q?GOCnZZkodDfq2n9QAQvrLptbAUY9F9y9lJQSe1rZEK/imi5N6JkyjRBMKW4N?=
 =?us-ascii?Q?N/g/PTwb9l8aP/pT6IaPefQnlIFu/eNQ9onQb306/gKOvX/AiUyollikO8ws?=
 =?us-ascii?Q?tKV6Exz4ElStX+PcrJcCzfQJaUU95oIyeoo46VWMbDC5V5TtXwMbXa1A2Edr?=
 =?us-ascii?Q?uQAgLo+/BeOonskOQ87yPfsWxsEzpBQgLJyr2GILxYtfo2A0VVxi+o0Ytg8c?=
 =?us-ascii?Q?AUkqwRgzLIbfpvvrICYAfIrn4ElY4Y0ykMMurAEXWP45+/1p9OBV4IfZ4LWr?=
 =?us-ascii?Q?w/8nbLWrCyQStlpPJH1TBWPbuHSOPjc/Df9uzyw36CoR2jyiB73RHFOb3+SE?=
 =?us-ascii?Q?WQKzC83duXSM4FjBN7iqEV1u/T8NJ9DHJVgRjMh2ZSs9zu/9mh31PSzNShvt?=
 =?us-ascii?Q?YilaZ5q24WhMPoOYkrzYYDWwIlqSMJMjEtx6FgYhP6FIMSmFP55ZkvgmmxWB?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8bff5c-54bc-4b93-ab94-08dab3c32f48
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:20:12.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jO1QhKCI2o7NAkATiYQoIDld5Ycr+gF3uc/fFIvbcZaYMIKmePPTOZZuDMoOLNpMxL8ZGMwFkFeLi7U7NFbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210220000
X-Proofpoint-ORIG-GUID: ZgRNFrZtAUjP65sW9ZPi7TX6NUops4-0
X-Proofpoint-GUID: ZgRNFrZtAUjP65sW9ZPi7TX6NUops4-0
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

At the bad_val label we have,

bad_val:
        return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
                      param->string, param->key);

param->string still is NULL.  But, I assume the logging can handle this.
In the case of printk, a NULL pointer comes out as '(null)'.

Thanks again,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz


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
