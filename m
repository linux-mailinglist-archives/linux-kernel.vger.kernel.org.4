Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7495BD6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiISWKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiISWKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:10:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E83DF00
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:10:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JIjxQr018990;
        Mon, 19 Sep 2022 22:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sEsaWsw9EhDGmzYpj1wtNbw2DvDqm3bzTyLUmn8zE40=;
 b=mXCpAMrd2LhxOBZKoyPriWfi895ng4uDoBxGJzRe4hKqDEUkPtZXVIqn3ciInxdrMcUR
 jpJUeybf0+95/KegSSw1mo5g4R7ORc/S1z9CwTQwjjkupbkJ0YWN7U7O0Zv2U4yNRJdf
 4d5lHoNVvbw6Iv1ZP5WpKAgA99pdpBGndHoVFNc/AmlxyBuISVvbuYz9Rb6dXJ3vGf21
 tr64cAqxxzCwAyNbIJPb4LoqSDsRprGpM+35Ko0WwwVApVHCnFDMNaDnKx2S7a5Al9An
 8XjIL604lP35dkwH5SMdHwSj4s6A5k0wiehqNgDucuThBBQrAN+bfJ65sF9ahPQbqKLk BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0d1f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:09:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JLUrqF016546;
        Mon, 19 Sep 2022 22:09:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cmke4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7FU5G/yWt+79TSatk9FilnxDprbH+9uYet0WW6ad4x/r4plsPq68+gNqUk24APmTlV6x/3eJPcm4NGN1rOepK7Tri+xJb7KLEj70tJL0Lt8ig/sOuJJiWbI4Xj9KO7UEmCd2HuOjwjHZGUJb7iBAjL7o2GLVNQ0saqzjSPRMA/i4KZAFC2i19BrS9hSMWq8Ow5Ch3JGsmiQ2rEylUuwxjZTIgLeHpjuZ0AtCBJ3xoqm54q7dhd/gqMG2VUbZjaTSkjBYb1lBxZTmtAIiKVrlr9y7BaBbwx+hzShcLJ4nUv8jgszB3IlTqIwBoz3SlnC6PTGF+erhaTZMmEOLaH+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEsaWsw9EhDGmzYpj1wtNbw2DvDqm3bzTyLUmn8zE40=;
 b=lii75BjSiztX+B0gv8eu/3z9oplIdEdPm3a+oad8LKhHLBUZ1Y1Y1wiZLsNppKyX2XZwEkFab2JgaRTxo4tvDgjR9/C5QiZ6gtZT5pH/OOxlI0CLuNIJYD51snb7NeN4ucjeDICUdWI1bDClmEKADShBWsb0/IMKT1DEK8QMhq21Eva03B7CJcylNXuo6z2P/zijvG17ZszeomLEXEzn95DL0Xwf5a/Zny3WP209/KneKYw/xIQekHc5gKGFG3OIAEI1Cxy1qFBGI+yie8mEr/sTXb4rstFcc+TcAX2B5wGnb2C/GnEOubekCPXsxYTQuEC5b2HfPlfNWtEKwhTxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEsaWsw9EhDGmzYpj1wtNbw2DvDqm3bzTyLUmn8zE40=;
 b=BMfK2lTMyTmREnrPmc4oAZA+q3lJSqcrJ40w3OCMjGr4lqb+pDd0ewypH8I7dmfP4yIiyFLevGVOJp4ONmCNJq4ZHNr3Ov/ZEb23u/ps9CSr8slHqI4MofwLSF/Z0zSyQ72hi6UvCpujHHhc2LpWpDcsy4yL7nsuxa3T2yUKw2M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 22:09:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:09:38 +0000
Date:   Mon, 19 Sep 2022 15:09:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v3 1/6] mm/hugetlb: add folio support to hugetlb specific
 flag macros
Message-ID: <YyjonFBhyg814HS+@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: c89182f4-894a-4a8a-0da9-08da9a8ba35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UShYw3DsHdhLskaBXce8uSz+pG24Dgq8WdtRkKrLgmchtYSNpGz/qmETrS8e1ASwCv3mln89j0IJWROcZzQUOAUQ4LSXXZ4oUap7czbwCy9ms8JMRTLuC9z7fD2hO0Ba3vql4k+g2mxhkSYDtHKW0nQrpHW5wS7M0h29CUJw5JXlVK12kltAES3eqt95oY+45+zkcRNV+Fy5aQb1wNajgM9mmFUYZiPWa74WqJL7xLugLYVvWiVthcyZAkGGCcxNK0XdcN+/0fiVcsj46et77T2IyAzc9P57Id2ypiJHWVUgmDHRJ84spz8jZA3fiep7qToiVg67nZ9XeOgZLgnYQl56oHjcmmLZLbQfePrfptK5hWrrrxgsIuaRS5eT4BzIobDXL6eTnPWUGPtSauFbIQz+BEgfCR5wokEoWB+u1Zgsd12Vlqd0aY/a56nFJDXv5t1D4Ci9IVgDjn9F5m9v4BMNMhwWlRMghQMmdoQ7e3Bg1Pn/CO7YXU8c2FrPMN++KYnkpK3fKGqvYJ3y09MLHSjMUOfMTeVfw8j96n0z9a0thb99Ar0TNEAw5nRjOUl3t5ATiyZcG2Q5xnXifYNow+rV1bKAURWMQIhk+6bISM/WiCgReB0+PujRrbM2mGzovl7+BnAczstqJqhqb8wxVfwWnIDS/di2WdF4mbWxvqPB1dU+A4Ivctu1Cey0quUAUJCP8pNqUuCjeq6m+pPfiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(9686003)(38100700002)(41300700001)(8936002)(186003)(6862004)(26005)(6512007)(2906002)(33716001)(6486002)(6636002)(478600001)(316002)(6666004)(66946007)(66556008)(4326008)(53546011)(66476007)(8676002)(6506007)(86362001)(7416002)(4744005)(5660300002)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EICx+a6BWumvDXkBi4ptshOPi5Wi8MuD5AHFjlyeRA8mAVHr3ghe5K6A70yP?=
 =?us-ascii?Q?AOuJkTzMkGpsh+XGQNaFu0zM7T166RTNqwENYzM1KBFRryWp7kayb2cRS99k?=
 =?us-ascii?Q?KNXykq44ZCcoVBWPho89bFdY6Wt/BktpHn9+gostpY/DKpz7ONylflfdgETv?=
 =?us-ascii?Q?0AxFKYpzBn25QtDNyjIza1kGbo8jcs/z8eKvewWPB30R/Jbq+gOVUx1KoGwA?=
 =?us-ascii?Q?jE1aFhg9qfOfGmRRy6kfJ2o88facrv0E9Z1Wr3tyCh4ctQKHJJuxv1ldE11r?=
 =?us-ascii?Q?x1dlaZA39zU2LKqQeaL1ZRU7t3RkOQdPqAeYK6Sk8eKY3bb3cNmUEGXO5kxB?=
 =?us-ascii?Q?Csd4BHqiX2Mjtw8D6leO4hiPU1d61ouQh7kIhrALLV/eRRgylQmeUPPJPzT8?=
 =?us-ascii?Q?LLZiyUs4pvQmw5rBMCabYjVCZ7aKRXi08q21DnOt2/72hRVcRq0Uik05845m?=
 =?us-ascii?Q?FwbUh2waInHUbGy6XoTs9LqCewicN2D9AERM3dlylYbJOjPapmdOXPNguSTV?=
 =?us-ascii?Q?ifGf89FjffJkOy5MXWFHdY/2ZSfm0hFYQcNI/sxNM0pc4KEgahHgHt1+Ir7J?=
 =?us-ascii?Q?zyxrhzG1NFPuwTdHnT47FyXglWee8ahIN5R6LFFxz7Bz362I+jm+F15uMbV6?=
 =?us-ascii?Q?Qd75BRxirNPm0GyRyRfJKceTK5PmOxQt/gxCCmsliNxHuyHnBvpNpXHeB+k9?=
 =?us-ascii?Q?g44XYWuFJjlU+Qpf7szpI5mPucX0ArR6sj+38dwdL13mBXZU7AwC5pmjD4t0?=
 =?us-ascii?Q?GoKLVC69/9y84nlZdntn4jPPA8XxMRfBjr7IEYK/ldyzdaCBa07TvHZvOQbV?=
 =?us-ascii?Q?osptPmwTpSChSRnXClvb2rdDibwV24gfwfQCwYdBPgq7SbDelFCZ29mjQkyk?=
 =?us-ascii?Q?GVl3t2oEHzBu18kWdMCXrtPehzJtenr3uAzqFGniE2cVFtxG9WyJSG6g0jcb?=
 =?us-ascii?Q?GoZc9Xve0KGQcS8L5dEVxGwh4zUtkqdRb/RQv3dJyThOoYYyNkaJ2O5vrymF?=
 =?us-ascii?Q?Ub9J2ggNYFymESLNeJf97E3tFvt04K6ngWS8eSwrg+kELkGdjth0ne+AsXWY?=
 =?us-ascii?Q?BBnWiqnw34OWxPIfhzouDKEpCedUwfhFZBYG9b2DSKBlJA84OU+gnWqwmJAh?=
 =?us-ascii?Q?SiitpF7d3HkR8PUTHQu8P3OJkATRH90b6WhNZOqc4B8fuOn7NPs1c24fD3Ex?=
 =?us-ascii?Q?b1WPsL1IdK6xSKNA+PZsU7eNG8SX9Xe7XjHPZi9jJ69V3qgP97dcJ9/MxrbD?=
 =?us-ascii?Q?tAFZPY9vCGDuucx5iU5ZoiUm7iykeeGFCbM6EPJ6Gr60zui9E5VtoFbZhDVL?=
 =?us-ascii?Q?JX4ymhMPYhV4XDhQ1YZSeQZ+GvqCW1byEr8OhCRypAdJklPMlP/HcMZ2T091?=
 =?us-ascii?Q?Q0reB6On5fx5bSUAR8UAUufqJLYg4PJjwnUxJO4BjFrlox2v88wmdbN1OvAY?=
 =?us-ascii?Q?CJGokrQCUpequRN16PXC0UyKpMZth+mjDOhaFDmBG+ESScNGa+Ux+r+gRFW8?=
 =?us-ascii?Q?ggkU1E+1aUnhdQVapOYioQWK/x5jNqnC/TYfP70YXJzOGUrj4f7dsCvq5+2t?=
 =?us-ascii?Q?LMVIFSW7/bCYHXJ63QEUAR6b6BgFVd5rq5pt2qvNpdnNO4Ua6tMfnsLSXSOk?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89182f4-894a-4a8a-0da9-08da9a8ba35c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:09:38.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Md0OoDa+rbsIo1RnXGW7CfcGMcIPMfVCZiIwK3NhQX0jlxV4zOChhaNxxWkoZw1Ig2DNUDC4kMl0M5HMwdSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190148
X-Proofpoint-GUID: VKGniw-fuvzNFjij8mX_0SYlzf3bY-L9
X-Proofpoint-ORIG-GUID: VKGniw-fuvzNFjij8mX_0SYlzf3bY-L9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 12:37, Sidhartha Kumar wrote:
> Allows the macros which test, set, and clear hugetlb specific page
> flags to take a hugetlb folio as an input. The marcros are generated as
> folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
> temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

I wish there was more usage of these new macros.  The only usage is a
folio_test_hugetlb_restore_reserve() call in patch 5.  Usage will expand
as more code is converted.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
