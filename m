Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AE6C1482
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCTORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCTOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:16:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07A1CBC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:16:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KDiZw4024394;
        Mon, 20 Mar 2023 14:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+15UcbxVRoYy/wszlDwh+2TD3kt1TNDE68AUgOWmz94=;
 b=WpMwQqEJg9dXyhSGIKsEKL8SuEgVnACn0bkrTnrGmfOlLcAQPF6zG+IQqrhpe9fdsFhn
 8rEy3n3FptYfpyIrvZIpWe9K+jvfZHu9LUTZYepXJ+8lfd+BUSil0xrRirPH9gTYL5k6
 +h8duzGd3A5DWzztWqa6UiDVzFK3f+h46peiCeexH9+Pu/TzcG9gMd7N9HhFAH5vpW/n
 NsC562Q+ch7jf1xggjQPuj9G690Y88Iarorkb1vD9JRXVk3MuPnpwEMmc24W6FPvUQqc
 lm3MTLBBe5ehBWBwGdzg9x78NBfq3+N6dfQDQ4lGUmYLUU13fqBMhDKitdrgK6weMBCp zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uubepb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 14:16:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KDnPx3036892;
        Mon, 20 Mar 2023 14:16:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5nc35s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 14:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS4AvKh3tbM6Lx/Q1ZnGl6plhh3wfc/meYWIPsSLsGpFHA8caOJ1x47090UX/DIU4S2hLswj7EHj8EkzWvxgT5JlcbkxioRijHT7juolP6tN2IkLyUmNmEfiUIwSvtp0N+0WL+otJR9yyMh8WMGD3JmE9EI0q+3eRslj8z2I3N2hKB5JUpIUrBGVnaAu8dSwO0rg05BiESn/UwMUrDDGOcJfulSYoxZJLRNGPzUkioHqEt8P6gNjdJOahyoT9EFAn5NO5Rxj+XxNWvo7qJAXmxaqwGYv39ja5T7JzT21kFpb56pQdBDhPkShCOn1bnsDUhB+4EcK0T7JiFp3cWIjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+15UcbxVRoYy/wszlDwh+2TD3kt1TNDE68AUgOWmz94=;
 b=nQiJRtvPzUGHGFn5n4ijF2DFJa5lgEfspq2elMnK3XbNdUaM3ixAuvHLZ+KqRluAuKOAH7MwPEtJal9X8UT+FGSDQrhtMqq0nZSCWUvzfPLsVVAjBqwHvyFt2yBe6Uo3/JPKlPwZ887CA3H0jQHEbIEvsHXB0JV4qIS63WESp/wqQ24eggsRnOopdf698a+upetr/LqHD8zahAZ5j7jMc/2rY28qRmyfmKJJdzaibwwCw+bBsorSdW5v5pPJ7qLacCOab/hQpaaMt7AuJKsWlv40XNj7hqXuR6FRCl9zBU2nHfutum3zUkRIKHV/Dfs84F2mQLmV0MLqx8+AyoSpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15UcbxVRoYy/wszlDwh+2TD3kt1TNDE68AUgOWmz94=;
 b=F6rXbkWfPwgBLx/IVWR2nh/9PvYpYCVnMdWhUBkopH7F76tCYhlNWQwEZNNd4CMoJJiV9gsZf85aGQ7gTy6+8n2uvrZ2c8VJVFme03C+YsREear2wGyU1vdpB8a2pdDo/RqZIkabAwqJ+Mi3ANLSjFtGfQAZT02nFb0Jb1QoDZQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:16:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:16:23 +0000
Date:   Mon, 20 Mar 2023 10:16:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 00/10] cleanup vma_merge() and improve mergeability tests
Message-ID: <20230320141621.fm3iwh7khjhji6zc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
References: <20230309111258.24079-1-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a6d016-5cf1-4e5e-1c63-08db294daf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsYnuDYKvU1WneG28ZxfvIdinWtYUL920Qo6miFsaicT3FoS4sFiEmVW3Du2tIAytuXyy5W6byOSPhRCEW32AiXI/YofM7sW4MLNtxkeN9nGNdHjs5Dmi2nDzlXwwfYIGwcMZAcASAta0dDYx//2tCIukLLsPVE381CnEo9vYHHC+F81cOBrROIjhD51HqnEvGAOPhv4xJQQ6iAX9O9cT9NRtejzwHfSZbyitSIio9EEiVGhEd6qiJ9m4jxGzQZSDaobdgES0Xk40TDHTviTwy/lLngQwchIDWFKYh2yv/SEndOVYF3KW8sY3Vdkm5V67tvZ1q/dB4+3ZV00Dnc5vKDOLy2q6calUqG/HM7jqjKeueSxmdiij4RSKPvalkHOlMiSEtdLNaqKQzK063Tu4g2YshH0r7HdmEyiCwLbMkYCXvmjKm1XAiw/I5JVMIkHakqBz5kX35QM6lRnh/t6iciH0NhjvypmpezR4AtM4igrhNCfk6zNbxKNVqEknpQEKeTojUbS/NkvEV82VERG6b3oeagcTkw6PvWdcslSppN8Weg26IVhSybsGGJ4ACeML40nKhX/eDw20wrF2SIjerh+8YmDPRlj2+FXL6K6M5uvE+uqkgdxPcc/yZEa7kYp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(38100700002)(33716001)(86362001)(54906003)(316002)(8676002)(66946007)(66556008)(66476007)(41300700001)(4326008)(6916009)(8936002)(5660300002)(478600001)(2906002)(83380400001)(6506007)(1076003)(6512007)(26005)(186003)(9686003)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBhXLJfqAWizu+fbDkxpe9YJ8a/7g0ChnZmcJDIy4KGBIs+GN00Y89GD2yWV?=
 =?us-ascii?Q?ZHXQf7KK3HYVqYjpwU9zpeFr8Iesa4ldr6JumQovXNJrrUCjCeZhdaTkQ1sj?=
 =?us-ascii?Q?SMVrhjUQtGxFoLoWXf19Viv17lX1ls7FgnijJgZDhHLdZLkof3WIOmFhv2vL?=
 =?us-ascii?Q?A2blF+ofixuJZBwwl+j8QMbvdMQbiHREKxDVKuEvJCGWkUVUs0itVy5quBdJ?=
 =?us-ascii?Q?p18EcXGdpLAetXc9Fw0YRiKAczFG5ifTOJvGQsrL5x2rpUMVF78ExsyfOFyp?=
 =?us-ascii?Q?+eQt2sKuvPb6efGkgjbPiJZpPr8gMedxHKBKQ0sRlZhvRFy03FEcWs2Im0bF?=
 =?us-ascii?Q?Wpg4coWPqxWIpnIfFSW2XrciCWdXXAXes+iwmaUUXdVOFFwCPw9eGR17AwUu?=
 =?us-ascii?Q?8jou32ZVUqAYow4c0QLh8fQxtwTrbFL5D16dAOoYpRlJ2KFh45C0Ml5wxr/A?=
 =?us-ascii?Q?4lu2CGMqPhaMpuMw6H0k2rAf8sQAtLFNYBcDPGCSZObkZIsEINTlH7c46/zS?=
 =?us-ascii?Q?kmU10VduU7bc3rWeRjwwhI2XSlLLpqaSZt8jkvV+gLF9xUmfoXdgwZ7278fL?=
 =?us-ascii?Q?9igRl2N6g7Ew/etxs56YlmWILTbPSQmjPFY15r63YAFhoN/Fqr0+q+30zDYf?=
 =?us-ascii?Q?JYhTB/EpkWNvwS0QtaBtMMoSZL9KPaTGHOxGPKhkcw4qK1B4PG1KpDQD8tV5?=
 =?us-ascii?Q?c2+2F34oCezu0Qw9csoHnDBphNtQ9yoa8dlFfX3ehdvUDHd60QrJO2AOSDdJ?=
 =?us-ascii?Q?oIrBDXWh2bZw0hzl6Xk8LLmHp1Qe6P7LDmfjpfL+EIl3CvNxoA/jXzmELhZl?=
 =?us-ascii?Q?ZHUna/Gyn/EmiAEUKguCZ+nk2sfTLQYgEUpc4XqrofH7kKO216ibGokHwoGI?=
 =?us-ascii?Q?bkOHkNuP7q3AAltc4juZzyCU1EEBXzf/wuf1MyaRreKiQVKBf/rQqnU7avxL?=
 =?us-ascii?Q?dBuE3ytcVLb/qdlLzOMg7B4VvTwpMAWWLH2vMTkiaHU9GJ0K+HWDuVbQFI90?=
 =?us-ascii?Q?RsibSsKvc/yOwGDFJg3Vpa9T0dfib2Ua7OCodBAZukqEf/P8uF/yWx2wfOkN?=
 =?us-ascii?Q?BKlFqR8V8sLCBn5xDhe0/OiJVTLQPF9FZeC/j6RCVMX1PeJnpxtuVXsArPKq?=
 =?us-ascii?Q?YmQ+YRiB8fxRE/KvHKyWdQ7SvcBuboeAENhS3bCIs4zC3ht4iGK0W98HFqL6?=
 =?us-ascii?Q?eWun/RYh35YYF/UL7847KKjkWiDDxR7G7MCf38XgN5v2vDpUfYtcfyQphKVL?=
 =?us-ascii?Q?pCopYR/LEGuOFRsJx6vQPTCJVxW1bSmrpr8AKcQa020ahNghf44ZWO391S4m?=
 =?us-ascii?Q?tL/QaPQaUW2U5anaFkXSvXWmy96Ur5UeJy67KI18zUDeWtdUvrqZpYzkTe8j?=
 =?us-ascii?Q?Q3sxD0xV/sSEabixqIfpY9YHVhznKyGP6E0ZnWilohad2IKhVvYo6Dpqe71d?=
 =?us-ascii?Q?nN5KZjZ79boALB9L9pXSnJkMLGxbBOxLUlu+s+EgWB+s5e8sAZJqdJRsFsJ2?=
 =?us-ascii?Q?+N9aclOLxUhgooF8LiqKTYrZ4B3LjBZHDENOwJdKGDr2JXyX7sIaoDt8keY6?=
 =?us-ascii?Q?icGtm5S5X8VZLmc5t2e4zeaX9Ce9cFomEbAxVlO36PyOqISfz+5CZrVKpgmF?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u/UrxBWw/ilBfUxU79OG0VpWKVzSs6muUZhlPcp8OTXy2IPi8H40f9/ULxw9?=
 =?us-ascii?Q?pqcC2XUYg5d2yUEvIP7gHhGvi5R26JOV6PUa+4eHumbYLE2JhUNnBy1sewB2?=
 =?us-ascii?Q?m3Qoc36RtkHt0AolcIBYsETA+vlsW19y3KJhjcf7bDkKFaz8M/FTJpGFLu03?=
 =?us-ascii?Q?c95TV2+toV6V7e5p2gMCqlQTBOL+5jO+wCI/i5iOrI5L9Vd/X1R7vY0vj5If?=
 =?us-ascii?Q?2rGZMVfd3SYmGns1YhgGaWMCzTalGmx6HIFJSy54dkIdEqSCSJommZ/r3x83?=
 =?us-ascii?Q?xHodmDOdWNIvCz8fS6v4scvLxP2K75bItRWUACho6iL+I6tUv//D1XV0BUii?=
 =?us-ascii?Q?aqOXgNgjiSAE6WBasVA4H6HIlSyOGhw+8gIThJ9Ek5rKVLH+YvGK78ErcBTS?=
 =?us-ascii?Q?HSRJoE6kbfC9UZeBEzOgcB5/U2JOG+Mcd1LI2jRdkBWqBh9Ea/Q4iMZhNGp5?=
 =?us-ascii?Q?aObAIGgj1vQvXwY3gw+btiUy4tXyFWTBhQEvcuwemqz4W4PmPO38EsgBXsui?=
 =?us-ascii?Q?AAAU0UrFIfVbVrH8uCSnWxUmj/zXZJ4X3bRlJ8iig01gqiUChMVELNeEGFRy?=
 =?us-ascii?Q?iG+ESWR6s5VheJxihDRyZwmhvNkEbzXNR8YMG+7iHEWiq7iWhaNTQTifuZVS?=
 =?us-ascii?Q?aJIv3OjW3orADXBJe2QMYQekj0o+iOJB+KFfPTnp2Pa8FaQTUjv/EYWiaaeU?=
 =?us-ascii?Q?ZFM8YRsKIrfQUQG4zFFAJo+AS5cJeuS+VEiLYGuO8JuvY44PWH0OJZJa3Zqs?=
 =?us-ascii?Q?NbiQwiN0EUAIvOJgILxmgybo0GHbyY8PxXZi+MuUt4/0TN5v/t+JUh4j6g+n?=
 =?us-ascii?Q?vkxZF2F63W34IQclXQx3ofbFR/umIVLJbd9krUEyiDbpIlzevMcwMMo0vjZx?=
 =?us-ascii?Q?bxy8gnG/F5MMomUlFSyMYs91llLiqnAKVDg0LrcBD0wqJLjvEPVAyO+Sk8wP?=
 =?us-ascii?Q?1jZ2gKqsfsFprGhd5s/QNzuLN6vhfzpgOpQPYDhgkR/uzmFXwO4KKem2p4M3?=
 =?us-ascii?Q?ENMM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a6d016-5cf1-4e5e-1c63-08db294daf82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:16:23.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRKViCPw8cWvb/G661Pc4ow0atNNn8yI3tew6ECEE2Y+fJd9IIQu/vJmldO5nkxCYy5SJDqU1C1h5mXmdlfY4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=2 spamscore=2 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=2 mlxlogscore=161 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200120
X-Proofpoint-GUID: 3t0khuHe1qjscPlWpU8wYwRHbshaFrI2
X-Proofpoint-ORIG-GUID: 3t0khuHe1qjscPlWpU8wYwRHbshaFrI2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late review, I've been away.

For the whole series,
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Vlastimil Babka <vbabka@suse.cz> [230309 06:18]:
> Also available in git:
> https://git.kernel.org/vbabka/h/vma_merge_cleanup-v1r2
> 
> Changes since RFC:
> - rebased to 6.3-rc1, dropped first patch (urgent fix) that was merged there
> - reindent parameters of mergeability checks (suggested by willy on IRC)
> 
> My initial goal here was to try making the check for vm_ops->close in
> is_mergeable_vma() only be applied for vma's that would be truly removed
> as part of the merge (see Patch 9). This would then allow reverting the
> quick fix d014cd7c1c35 ("mm, mremap: fix mremap() expanding for vma's
> with vm_ops->close()"). This was successful enough to allow the revert
> (Patch 10). Checks using can_vma_merge_before() are still pessimistic
> about possible vma removal, and making them precise would probably
> complicate the vma_merge() code too much.
> 
> Liam's 6.3-rc1 simplification of vma_merge() and removal of
> __vma_adjust() was very much helpful in understanding the vma_merge()
> implementation and especially when vma removals can happen, which is now
> very obvious. While studing the code, I've found ways to make it
> hopefully even more easy to follow, so that's the patches 1-8. That made
> me also notice a bug that's now already fixed in 6.3-rc1.
> 
> Vlastimil Babka (10):
>   mm/mmap/vma_merge: use only primary pointers for preparing merge
>   mm/mmap/vma_merge: use the proper vma pointer in case 3
>   mm/mmap/vma_merge: use the proper vma pointers in cases 1 and 6
>   mm/mmap/vma_merge: use the proper vma pointer in case 4
>   mm/mmap/vma_merge: initialize mid and next in natural order
>   mm/mmap/vma_merge: set mid to NULL if not applicable
>   mm/mmap/vma_merge: rename adj_next to adj_start
>   mm/mmap/vma_merge: convert mergeability checks to return bool
>   mm/mmap: start distinguishing if vma can be removed in mergeability
>     test
>   mm/mremap: simplify vma expansion again
> 
>  mm/mmap.c   | 142 ++++++++++++++++++++++++++++------------------------
>  mm/mremap.c |  20 ++------
>  2 files changed, 80 insertions(+), 82 deletions(-)
> 
> -- 
> 2.39.2
> 
