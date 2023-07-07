Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2B74B229
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGGNs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGGNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:48:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637C9AF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:48:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367DUR4Y014766;
        Fri, 7 Jul 2023 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QbO6WomzzcZSrhmUJL2ave2xMSAELWc5J+rksJMGdb4=;
 b=ZXcHs+WWWJ+rAbA5CzjvcoPe+WM1DWvI3yqc49LOS7g7QrfvN7wRDVCo+Co+ZH8xA/Xn
 BTVb4IOKBIpcWlZuSNLK3P5YY0XG+Qat15/zrBn75HdDdk93c/WhzR46kpXaE6Ik48V8
 Iceflaqm0fvxy4BRV9n26UD7QSbRDW1wJ5rbqWSZSbNV6hOqpF23A7MtWoMs1089XCL/
 xUNMocEkHp86koaGdgQr6DLH4fsjsIYZ7TsTbWImPo8FAxqLIwQ99UiCRhGxQo+8KGKx
 N1NrqADTEu1VYongC55B18OG46hQnn0R3SYJdd9GO2OmihFSFp2Co7ZuNMM0LdzxpEoq 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpjrvg4c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 13:48:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367C4tFo010231;
        Fri, 7 Jul 2023 13:48:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8evsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 13:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnrlsX/yUDTmppLSJt6+oy6khg/jJ6sCg6a4jh1JPV1i3y0+ZqZccmsI6R3aGycHkiSmVWw7atVy0pruTLLQPhDUTJHz7owHmha3/DLn9HJwVRZSzItZBOzlz/Af8juzakzX/HizZ1rY4POUNxnIIT2ocAJ8vg59LM0340uY3wInyJJY9W9U9xu25sXz1PAplwLEAKUG4qRvFX4or9tUfsDF5sT9U2/rh/kZd0kdBInf1S+z2VS1u/+k885Nr4TmvFinBCzuxhUVZSCyEEChvcrye9EXo5EKQDQVSe2O0rM6BJgjLOmuJdb+kwZSKdS7kwd/iQt4CzPkadyr+OCo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbO6WomzzcZSrhmUJL2ave2xMSAELWc5J+rksJMGdb4=;
 b=bEGRs3jEnz6RooewHfQif56YRVf+X21DUglnToaser5J566ORzwYlOcL2Kw4vzHXIOBy8obZ0utm4eeNowI1Knt95yZqNZ0t56uQJGa+cwDXG6D285vidjZOuMyygOV4ws3ucgv/v/s4CzS+9BvmRmk58DAampOSeGBGlgzs2cgSlgcsmUWWdoqVoyoggpUr99BTLIVaZwHmutl0NMxkqM8tzqgUM6j6j1egTWztDZO3z+2j/IKu96gZ6Ax8mmfYH0yl3DGT6TSfsPQtKE2Iz3hBxxnNn4zOrHvHrPJyU3IZFEwafFmKRbApNRVCjQa5dUrILp81q4t+MQFEL0Q0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbO6WomzzcZSrhmUJL2ave2xMSAELWc5J+rksJMGdb4=;
 b=w4fJB2/UfgJ+OX2RW5KGMwmdjZhOaWoJz3j5PBNi2BMaRYOMsoHqcLUosTrrE+hi21+0xmrBmR+DzaQMjbMv+8ti6VqYGAdHLbh6m4nWxlEmbY4xtHO3isAFKa9Sm2x89RJxJrwH/Ly4yix7nPVstMQ+ORZRAaTHXd6h1lEQNsc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 13:48:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 13:48:13 +0000
Date:   Fri, 7 Jul 2023 09:48:11 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 0/8] Improve the validation for maple tree and
 some cleanup
Message-ID: <20230707134811.pn5ohuej522i4nhn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c863486-472e-452d-bfd3-08db7ef0cf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJT0oR6tfALo6tXKNfuTe1s8N2dADCzpylhNMzCb9iOHfOPTU+lf5j5ljf3qON9yA/ba+0tpBljQbQaqOipe1pNsm02UJqQjN8nVPXIVy0Zvv36THGNekxVgAPev3qbCUTlqZ3KkD9wtHa3ugIXdMl/8eGTNB9h4JPjkzV24rfIByoUD6jr78vU44oGNngvH24xdt5nsma3epXFUUoP+73E/q+WKGEE+dSR9Dq+sySCRgi+rmOWrR/Ck4KPRTEsRFdgifoQGInmZ9wTkP7ugbefAI4AZARic5uuotB76d8SYFkiwQdRBJbHsgWPPB5rAnzeQyPO3MNSxRXJlyhxMML37aaBNfBs8wEa9JzSLHRTVdkGCMyVDDq6RmmPS3rIWIKZuyU3xxsPqeKmJmxnkdJ4/5tLNvxixCZCQ7Qf3vKIygr6GP8h6DuwN7iOVSfEAz6t1u/d5zoTRZBrVm7UyH92S/dZBgyq0tUeTl1DvOfAHBDM8wf1rWnOyG8tv8N54lwUoFhqiwwbbsvfCRLxeAtvjcL4V+yZyy+IFv5SyFdJQ849G9Z1ws6PThz87jxhg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(6486002)(33716001)(86362001)(83380400001)(2906002)(26005)(6506007)(1076003)(186003)(9686003)(4744005)(6512007)(38100700002)(4326008)(66946007)(41300700001)(66556008)(6916009)(316002)(8676002)(5660300002)(8936002)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7R4yxTSMHO8aNlzOxBr+WEzE4BCOrEMVH+awSNQ7kFLqBVxK7tifUuo/vsD?=
 =?us-ascii?Q?KtWwxDjHczV9zEpPxMzw8ZgBYzRAuQD3x8aZOkW1NuaJ4JQA0Gi2/oeFXJ/z?=
 =?us-ascii?Q?wQEG54SAExPmtAdtoeTryWvqdiwC/MPaRm+h2OyYAb2pLfDMoHhbcbbvgOrp?=
 =?us-ascii?Q?C2gzY4wKZXvFA1oG8aeoxbbKFoxuJrhc5+v4nzvyuGF70SFfqyxhL9XPHrT3?=
 =?us-ascii?Q?laJLxr7cXusYDxd/Fg/O9uAnjKuinBOQiiV9FnLy6RrUUMDCqfI8HzWZvkOy?=
 =?us-ascii?Q?Nru5t18NOor+j1VljfaRL3w/B4t+a7Fw2xwTAttOJbqwDd6xGVD1q6UMW71h?=
 =?us-ascii?Q?Atl1GephC++xhw+A2RozsftudCedhhkLFi/1Kiynu9sR3NgKLdhsFAGFbqEb?=
 =?us-ascii?Q?Uu3wV+WNM4Xr9TThUUEhinoRm0m3zHW2cvfK6VzG4xEGdNQOhPXcr6uYfhH8?=
 =?us-ascii?Q?qrRU/Z1+TxbMYgcGR6R1PJjXCYQRj8p/CHzrMmIX7Gtr7efqZ2UsRsG3XErD?=
 =?us-ascii?Q?HeCm0HADLidAncocJJoFeD8jjpfL0zZYSf+/15zMjMt4kG7QEJNC5PeAzb/9?=
 =?us-ascii?Q?b3+ZWlyWbgs8UHu868y+BO1u3qbPmIoXuz4KIms+LcZGsa/hTWpaiHXuvn12?=
 =?us-ascii?Q?ss9Ob6lr/2D4gaTx+xl+zH0L2TVS7E+LDykpof/g4ALFa6Gweq5nktdJrcdu?=
 =?us-ascii?Q?C/jrdV8YphBaPfRXyQ3zC9LgfKLptIoW3yxWLaHXDE2EuaIgkFxYGvUyST/H?=
 =?us-ascii?Q?IdoJ1ndgMjKGbgPH1k/wNJ2ataZEE0EKHLfYSJ19vQPo8ztFcdmFVWfg7Hgl?=
 =?us-ascii?Q?unwZlGwMIjpXHmec6Vuh5aXPPYtNYd6eYkICAhTubC0aJFn96hRRsMI5w7/z?=
 =?us-ascii?Q?tSblPttDRVPERt6jZgrB3wlV1R81w05YvZS03vW5QmmDvIskXPEHqaa65mPD?=
 =?us-ascii?Q?mKR2D/y6ruK2UkUkJspfxNs6imv7hKgUnOpIfzalpeHPwzvncsoYhER6R/mx?=
 =?us-ascii?Q?vYIx+h/I+a8Rs53pAUuTmpIWkjPnzZ8YcXHlAXHc2MZhjTQ8uWdH9D952/ZL?=
 =?us-ascii?Q?CPjGllMdCZpQIMcJ6DP1vyJPidV/uNGyUVSjxXf2/PhmvMOhCDk0qTj8hvZq?=
 =?us-ascii?Q?UpRvLKDur29dAY3OSDmCZTo9OAywwcQtvVuExiFf6Pvfco9D0l1LgFdxv1NY?=
 =?us-ascii?Q?uX5Nk3s4EnevNmRHypmhxu/nzsn446urjnPLCVaI9rDYzyHi5cIlThI2pTBE?=
 =?us-ascii?Q?79z5/txdQ0bD2w0aBFeFKAVKO6nzNfVZkLa55JbJFf6PPzvn1FuVOyb7SZVk?=
 =?us-ascii?Q?rLGF2ojuT/NOLv6bUEKSLusbPuIUYSp6PjrywT1+I4wnyoLr43u2LJYIgzRa?=
 =?us-ascii?Q?fr0zEBJg4YrU3y8MoUe5J4ZD13uOCdiVbjEU86Kq4uBQ04Vn2FW0X74jsv4x?=
 =?us-ascii?Q?Azu54NUh94+qjtOgCbtUkjRtgPynQ8WNn6NwS+hUhhEfK2Jp02ZhGqsRFLkz?=
 =?us-ascii?Q?S1Bsi1aZfoM4ntp+woeLvXFovG8AyBisq5GH57TNCXxMMtoqijlhkxvQSakG?=
 =?us-ascii?Q?F0CLdJ1yKEzr9gcZjoXViJPFF4orSkWpY7YJjOmTJlJJkZjEsetJ3AwmQSfa?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SCwEJLi9tkglD4F1/n0Rr3N4IDHzicbAY8XqDya9h66O+TmcjsHXI4NuJPAd?=
 =?us-ascii?Q?rdf8u0ppREr4LeaLi8nFHYJtAaCj94LkGFeyOscCbqFJeIcLVfYBGwOM/Dkp?=
 =?us-ascii?Q?w8PWr0wj8q7H3BVwTDVhKVH5OIbGMijWbPR15Gqwle3zKt6CnEhavo6hn1ko?=
 =?us-ascii?Q?NKZ2HGgfnUeStGsPMm5S97OpzcIoo0U3VkT7h/+u0/UjxOJcHcYMxSIGirD0?=
 =?us-ascii?Q?OsJbL9MtyR+CjcNnkzMUBPG+2Xp9aJGzqTgD5sl5osbPGYEGMR1+L9giIHrO?=
 =?us-ascii?Q?T+5zQuZrZkKA5ZRG/SIxieNXg4ms0k18JuafT1zf2IFLr+6WyJ/41WOkmiV4?=
 =?us-ascii?Q?mbCjePN2lGCMjWbm+/LEEx0aPUyONFwaIppnwFq2RGewOT3ReATw/9MgOQHW?=
 =?us-ascii?Q?03JUIJDgMs98XYCh1IFRogoPiVvRj9dmXHbqpJjWyNmZOex7ZBCsrtur8t3y?=
 =?us-ascii?Q?AtZZsNUuT+PQ0H8nz+mbdufweS+xZJPteiwi0Vk7h5TjXvqEt1AGI6YMU9S6?=
 =?us-ascii?Q?eaqH1EhXYjWKupQyDc9hxeCELCSm0/TO4FwrUujzMlO4NENeE4fXxH08hfte?=
 =?us-ascii?Q?xGpusK/HIRCncR/odobqejZGoDG7sM2FP+sJ9lKGIS2X7ggsA5rZfmT/ARUy?=
 =?us-ascii?Q?t0NkH6ktEn+h1Fmjvwbwkf0VoTtLGRXWqVz1SlfecYP/g1dFU7S5U4+HmrLc?=
 =?us-ascii?Q?UnOGAcZJ1bQUdh8RQAOElcZLZrINFrStIKqVpT//TD/CEDXDFVnLiAWDudN9?=
 =?us-ascii?Q?FcSVSzZNVIjhhginHZR98UwbgHiB1UXAG6q0Wv4Eskv9AXA+cz+hMrHeeYrt?=
 =?us-ascii?Q?ZXNNevizNJH9B3iOG3YjaLP8g8Q8jdfxn/fDBRLLOF2V2pE0vLjRYqiu8QF1?=
 =?us-ascii?Q?AKDlTkilF8wWU17J9gMIMIqQFoFMUIXY8+5WbW+mTzWH0r9aFVJHm6q1MhIl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c863486-472e-452d-bfd3-08db7ef0cf3b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:48:13.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNso2ns3202Ly35z4Bvp1b9ltNqQu0/SqQzpFvko3LKjJ1PkZeOuWRBnhJQkKIjRifNYSUnAYBC73SmdlvK6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=573 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070128
X-Proofpoint-GUID: kV9sM66m9E7ETIM9JpDEVZPCva8-cHnh
X-Proofpoint-ORIG-GUID: kV9sM66m9E7ETIM9JpDEVZPCva8-cHnh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been on my todo list.  I will review these soon.

Thanks for resending them.

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> These patches do the following:
> 001 - 002: Small cleanup to maple tree.
> 003 - 006: Improve the validation for maple tree.
> 007 - 008: Drop some functions that will no longer be used.
> 
> Peng Zhang (8):
>   maple_tree: set the node limit when creating a new root node
>   maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
>   maple_tree: make mas_validate_gaps() to check metadata
>   maple_tree: fix mas_validate_child_slot() to check last missed slot
>   maple_tree: make mas_validate_limits() check root node and node limit
>   maple_tree: update mt_validate()
>   maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
>   maple_tree: drop mas_first_entry()
> 
>  include/linux/maple_tree.h |   2 -
>  lib/maple_tree.c           | 246 +++++++++++--------------------------
>  2 files changed, 69 insertions(+), 179 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
