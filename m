Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA95B970A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIOJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:10:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865B1A80C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:09:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F8pwbb008401;
        Thu, 15 Sep 2022 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=yNwxhMisqAhIW7IiO6GbxjfRORdlNQcglq+vHZV0F4E=;
 b=QZ704lcd7r8X92GeH6w4Zzv4s5p9jhwpxxmN7bSpv8+gA2bhbX5Zxbt13jk0JemqKA1b
 q0kyiNZDrbkAG3NDQMi5eTe3py33G2QEyHpOnW1YwauFrqH1GC62hRKgxKtYlwzmRnyj
 CcU4Xb2m5KgV9c3pW2ADRlxAS3D5JWqwIOZiIDnW54+bAqnmb7uQSshukqi5jNNIQyiR
 gcibk2DTEmSkxMI0P2R5ZBEDJcdXOKLgp/GWmpeUCGkF//P0TeSq945iK2ooTLNKiNgi
 7domDGIGNh4jVMYaOfVr+mSOv/N/MTgkr36Sf1POuwBe9Klgvk86/BG96OkcPdfkNutn UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypcs3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 09:09:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qUnJ001360;
        Thu, 15 Sep 2022 09:09:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2c5dvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 09:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJQfF2KxSAPWrbc9/1DWI9Ayg/k74xxQgtsWAAeyz9j/uCoPaGtg3ZVCh1PttKgvgxiC+IfYkAguy/SA5gHqqxy6aDpJUsKwkHV2BiP8wHiO24fMtAwPxRqTJGjupYlr6WouQ69zuXsXcja0g1vuDHPXN1//HT2ArlWJreIHevyMOjYjzaTvDxdTHTIIiozE+I1krTpDzjpHl5ok+NPbGUJZoCr/bsNElN454v1q4gZBOmKQjrF9g1zaXpMWHecss+vW3ZkGh/n76kAVHJylLdMqUlDYpe7NtzEagiYYs9kN/D+rWzZXYJBg7UlyEiwKsEteFm8+1GSGwT2eFBrHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNwxhMisqAhIW7IiO6GbxjfRORdlNQcglq+vHZV0F4E=;
 b=RPerg/SnyClX2gY/YgJgdxwcAVd72IsiQ5PCexoP11fvNA4mmiDoGBJD04aIsPY6tH0CHs2PRfOaadkfIsKwLCNdiL9NZ8e9Z5VHxfOznXEm3HtzgZaYKVmO5mkxuAHN+CidaKIbz8YJxH+hVY+BKjQJjpt4kaBdSLv/GH/OnB262takAPpYgUjGNFslfTFjOPo8lvCdgRcyw2QdFvztQd0/oPDf4Gq2t+OjsZP/Mul6ZUzkgs1gu5Mp1fXFJJ5Q/+LwrXhzdc0vEBgHbH8Rq4nFLPTJEREf/O4Dsw2trrKBPzlCvn9iT6+ALafHcLjVD2BkMb1vUkd9Uv63DeRitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNwxhMisqAhIW7IiO6GbxjfRORdlNQcglq+vHZV0F4E=;
 b=HapcEeY4fwaA2QOLLMb5kKAwtxbebIMyacdzTOYDp0r7wtElQEIHh5n83en8wuSvPL/b8crf4zeebOBsZn0LLzJABRD/2Wlfd3u4xD3w+q00nLObLQzpc1KKSbXafZdrfmPymd4aisegOdWBKnSbGdSD94FjhR8VfwtF4Jz1cjo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5661.namprd10.prod.outlook.com
 (2603:10b6:a03:3da::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 09:09:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:09:38 +0000
Date:   Thu, 15 Sep 2022 12:09:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Huckleberry <nhuck@google.com>, nathan@kernel.org,
        error27@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        trix@redhat.com
Subject: Re: [PATCH v3] staging: octeon: Fix return type of cvm_oct_xmit and
 cvm_oct_xmit_pow
Message-ID: <YyLrwW0qHpgxq4MK@kadam>
References: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
 <20220914211057.423617-1-nhuck@google.com>
 <b66ea89d-c62e-4772-b3d7-6e236da837af@www.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66ea89d-c62e-4772-b3d7-6e236da837af@www.fastmail.com>
X-ClientProxiedBy: MR1P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e9d467-a427-4130-781f-08da96fa0409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQENh/jnb+L7paNEpkkLClGZIsDWXE84SkFBdhHQLUIUnRu600app3U9BNfb1wHsEiKT1+sE8LXHxFjFrhvvPWAKBl0oD1aK4yPvWY2bgk5VoFnT8osM8jIARCdEoFy6mNJ520ECu4j2yHQoILV/OSn2AuDfQem3aw6CKdxv7DXEtn7pwi+7KKVMjxDblC0CYDmKHh+jw1LITtYHkj0iElPKinRN+8HEQM0lIbD6+KKcBkMqyKeLBMhVkerOglZx7/CbtrxrNCb9twIDdNtBSTPU3xw8YqFKNvnvooc7/gRLrTzabMzlmcyM75XJMG5iO1BTVfar44V7xu+mtS6kDvqyu0Mhd5SVr+eHZ6l2hou3QWxYgtQ6mb7P50yVpw3WMMLegq/2XQfltWzIBUlhiH92y8xs+MLyAkp7NoKwQW8pWfxRbJFwZTwWyEUV1YEGVo3JtVh1J8jogA0KeJy7GwYRWgHPBMa2qlIhlzJ5alPyVYraJZKT/C5oBmwq3snHD0C02i/4Sz3kkYghJVOYsISZCccrdA5c8uzPPEFFsamvQ1OYqfwDdjIEUOy2n58ZL9WiZuBK766rYSXzx5mwXUTOY7ND1Hlm6A1O7Glx/BfXJsSry89E5+6aamsr5IYzfuE7JJIaBYcQwRIkYr9oKQjTd2MxOu9n80QyHLGScQ0Xl+rwe2cxP9Uuj9IF+catu5qYnHc+IaY+hRzYSPcsUhQjTZVfrUZ3ZQABsu1O17s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(41300700001)(6666004)(66476007)(8676002)(66556008)(966005)(66946007)(4326008)(54906003)(33716001)(6512007)(316002)(9686003)(2906002)(5660300002)(44832011)(66899012)(6916009)(7416002)(6486002)(86362001)(83380400001)(186003)(478600001)(8936002)(38100700002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isSVGDepO2me1Dyt2m+NsY8eG7Epith/oCPXKbmlSWzTl+Jh0veQGcX+GI1S?=
 =?us-ascii?Q?3LH+KUVnHqX3oE0QB8D2xhkmSlkpL6mIP/17TA0zavEHKXTVTkGqkaU2YLec?=
 =?us-ascii?Q?SkTUl5TdHXqPsaaGr788IqpuaY98TMsIL2eb9Y7u4Ie+jAqBGIDPhemVHf8H?=
 =?us-ascii?Q?GzfiiS7HlZlkqjhYrZuQCFbnkA0+PhihWXOQgqtfVoz1U1Eki+IScrqqZ2mQ?=
 =?us-ascii?Q?6wQZi0YXu/HL3gS+SdU+ILWt79qGFvJE4RIUpwMbOOqxu1w2VHXej+J8zi79?=
 =?us-ascii?Q?sH200EPRx52mJDBr5bS9kfvdD2ngvNtWdoAcClGdpcR0SY1Wu2KJGLWoVgWF?=
 =?us-ascii?Q?Ads9NQg34rbHpnYy90FNq1qkX6QgBc6gyQ//hPZoX+rNTaVAO1Vr2EByUhvn?=
 =?us-ascii?Q?a09LZ+3kZbq97FUGmsYFOIFto2LR1OpqbWYHDby8wLXphXR3SCusQJMpbnxl?=
 =?us-ascii?Q?xsEpe1uxm8DklK0sEkB2VhwLIS0AaX+0J8OhEzBjWw6FpaMsXaVlPNwqyx2W?=
 =?us-ascii?Q?542h5/pESv34OlzqGdGZhUz7mKZKM4hWXqJzNCgX5qR+Y4QNrGKOlaDHawgr?=
 =?us-ascii?Q?mHWSeQ82xwOL6q7unP/4Y/545Sv5V0TAGCG9hd+OQTrZ2C3aGYMIMWVXQjxi?=
 =?us-ascii?Q?BxiWPC0IA9mzJblywotgB13a02YPB/RHljkZJwN2v0eFXodw9PEEdOXs9EGN?=
 =?us-ascii?Q?cUnRzzuGuLMg6jo+Hy6N4Q7DP7440iuIvVCFWzpgdtLCyRF0EOfnwc9cojZI?=
 =?us-ascii?Q?uqgDtT2OA0bCRgacczZnNrBM83qj5rpHOH1JKm6ux/KUsQPQIU0qpwEjee4/?=
 =?us-ascii?Q?rzsaVboa1MmFI0lvFLkBQa0laG5K1zFHzzVs0ekbKnZv92uJqjnCyg7imfsK?=
 =?us-ascii?Q?Br+l/O/dU8ZRzP09ak8ANue2YkQl5Ch5nqrHhRSY1Xzt6we0RDN0U86o07tH?=
 =?us-ascii?Q?1ThHWBzQiwZ0R/mPXHa0PsOUgPqTwe2zvDy4kgQd6NlXuOy7T+ODWe/PHTkP?=
 =?us-ascii?Q?e65N890rzsVcpz7k9p8QihHWDF3Y7Ibh327H5hzcObkPH2bpPG5w9wNVOzd9?=
 =?us-ascii?Q?kmzp+j1/ZiYjQD+wEBGbEzZ0xtSkkvP2WxsyljkE4c8JHQAduzwWS7UYAgyH?=
 =?us-ascii?Q?GsyIAGKEN8RsPrm1OGFRas3SJ8XhrviCp14fFa1GYFksPpHQ2/s2aMhV560t?=
 =?us-ascii?Q?EuMAQKGR3JTSrYuu1YZFvmvy4U0D3yt0Iq4dcOcNzSysH1NnOkC0DREGJnkE?=
 =?us-ascii?Q?sMcCeMryoj7LDzfY/UXT11zbmIXMEdRCYF1wXiMkgxO2oN7BE2hvVSY1xig9?=
 =?us-ascii?Q?LNoILf6R04IgvTFn929GaGcd7rNVAM6MKIWg/7+KRWC+d3kBdyOYkxpCTzTl?=
 =?us-ascii?Q?694YlbVY8/cU+8CPExSf4G+/3qptPhRc9j2yxPQKS+lGIDTr/FcMbyOVsizw?=
 =?us-ascii?Q?wWGQymJDMftylt7qZmFoigwGxwa/fYZChgJW5jy2Gl125x5YupXLQJxHh7xr?=
 =?us-ascii?Q?njmZTAkYafsB0La3IL6dM/rtH1oBBZXq1aiKeTJ3SyYhzXY0gzo2KbXtJO+8?=
 =?us-ascii?Q?fkkRHM9GDyHUVQ0lwfQgYg15+PR4ILYCMqwcLsAJtnfU+KModIRHsKDLFoMV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e9d467-a427-4130-781f-08da96fa0409
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:09:38.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0XybRdipiE0jpBewcGyQHoyaZux7w/nEqz+0mfIUCVMvmCyuHXGgNGUshgttulEqrWZiqUHaRvg5CEkaKjn24fAYN7wv5X5JzHw5o19eSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150050
X-Proofpoint-ORIG-GUID: 81MaRgJtbO6499EpVp0Ar0cCtb8ggz54
X-Proofpoint-GUID: 81MaRgJtbO6499EpVp0Ar0cCtb8ggz54
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:21:47AM +0200, Arnd Bergmann wrote:
> On Wed, Sep 14, 2022, at 11:10 PM, Nathan Huckleberry wrote:
> > The ndo_start_xmit field in net_device_ops is expected to be of type
> > netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> >
> > The mismatched return type breaks forward edge kCFI since the underlying
> > function definition does not match the function hook definition.
> >
> > The return type of cvm_oct_xmit and cvm_oct_xmit_pow should be changed
> > from int to netdev_tx_t.
> >
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > ---
> >
> > Changes v1 -> v2:
> > - Update function signatures in ethernet-tx.h.
> >
> > Changes v2 -> v3:
> > - Move changes below the scissors --- so they don't show in commit msg
> > - Add reviewed-by tag
> 
> The patch looks correct to me so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> but I have two more general comments:
> 
> - For your changelogs, it would help to include the diagnostic message
>   from smatch that you link to.
> 
> - This has probably been discussed before, but why is this only
>   reported by smatch but by clang itself when building with CFI
>   enabled? It appears that CFI enforces stricter C++ style type
>   compatibility on enums while the warnings only catch incompatible
>   types according to the normal C11 rules.

This is not in a released version of Smatch.  I wrote the check and
attached it to the email with the bug reports but I wasn't really sure
how enums are handled in Clang. It's a gray area in the C standard.

I'll release it now since no one complained about false positives, but
yes, ideally this would be built into the compiler.

GCC does some sort of surprising things with enums and the kernel relies
on it in various places.  By default enums in GCC are unsigned int.  If
they have to store values which don't fit into unsigned int (negatives
or larger than UINT_MAX) type is adjusted to be signed or a larger type.

Also if the enum is in a struct and the type can be made smaller then
GCC will.  And example of this is in union myrs_cmd_mbox where the
enum myrs_cmd_opcode opcode only takes one byte. The SCSI_MYRB driver
relies on the struct thing and will corrupt memory if the struct is
larger than expected.  This is the only example I know of in the kernel
where this matters.

Sparse and thus Smatch default to unsigned int as well, but they won't
make the enum smaller for a struct.  There are some implications of
such as can an enum be less than zero?  If no then there is a potential
for if (err < 0) being a bug, and if yes then there is a potential for
array underflows

regards,
dan carpenter

