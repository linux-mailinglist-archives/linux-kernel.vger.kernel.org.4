Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6974B38E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGGPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjGGPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:02:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C33AF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:02:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367EnShq027133;
        Fri, 7 Jul 2023 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=POvfbSQxcW8OO+VoaMVsbAmo7lEqq5Cctdl3JZ9E65g=;
 b=XMqnQtxpuyH1tV3iixImHalHEuL9jvOcvttspCSVZbZLMQxiAQ7M/4umbB2ToNnK6QT+
 ZuWRYSRX03BdPS2agf57OAmW9EssG+nXiV3cqQrC0p9rou6d2pMjkS3qvuSLaFw3iiFU
 8sDWEGOzh0238uwf7lGpsjVW0+sbYY2C2hCFyfT6GfG4ryYAitRAvCEcS1aos7E+RecE
 +fnCp4rmMyH+U09/CCHJx5iuK1y2xHs4pW5AUuViadhw4mnpnSY0Ko2mrwP7hRTLB3x2
 lFNOETWoUlU6Mg5AmTKgYeUdM7vGh9vPMLGcuEyjLM+bHgxf8jpZqmpCDSmFfkmTKEN7 sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpmk502k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:02:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367Dkk2i001661;
        Fri, 7 Jul 2023 15:02:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakehusg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZuKijn7DHtt1wA3occCzwbZYkUSPK0VoXL3Gz7S/tW/VJcQVZkHBratEXwKeSqUYj3i0B5edgyZufhFE2QWNe1JFOWj6vvq6O/i1lw0+3SLBCvgLYmHQNLUUQ4YkWr4D3Z3rC+oDcH9FvgeJdwLtk+q3PEfB5NtCu/FgwqjVaG3RcwGbY/M+cypoZS8ZWnrqE58REtj7muPegHMfyVUj0dT8mq+V6Nzzckz2toNZBu+ci9nrZSFQqAy5WV9GAgz+KNTfHNDnvclRmRRGHiwEnPzfViSizY95n6Npb9xaoHbBL+GLJCNHGleO85Hfpisd6iQj9PbiXlcswP7xEK+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POvfbSQxcW8OO+VoaMVsbAmo7lEqq5Cctdl3JZ9E65g=;
 b=doySZ50XeFe4U9PmIu4K96w2p+Eu8FgOElu4MNsPVF58/gqLqmTN4G1LUgqYoelWUTuIl5mNcMKtLX10hKgZ3e/I6xbe4VKAAOnELcLzdO9hbVNNwrZ+dIP88gbD72/J9sr9+XhPiDXAFKoJ6OdapJYwK53qvglFgYOe2jZyZpJhn744YiHoD1uh/UEMMjKR2Mbg+NaC2USzA/BzCX1tFwPMZh/AimZbT9mq+qgkST/vlVNeYdUA8GqV2gJsszQNmF6KWVRZxwgyhHAH9oHIotzQf08hrcwa1948ecolU+YY8mfmYKjRi1p75F2n5aPMZooQiOYz3WFzXLNRHA8nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POvfbSQxcW8OO+VoaMVsbAmo7lEqq5Cctdl3JZ9E65g=;
 b=gfAdNR/lfLWnE5PlayGwPVrbweitzcad43346BA+jx3//RVhf6mro9O0p980uLa5Rbp+uV943U19b+lo9oLtXsFXj/pLtMtqk2aU+3bUami0XoyCtjrSJTtwfdLqnhmGHE5M36Au7C9K01G007YAZq+sn62Mjzhl31w6HtM1+hI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:02:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:02:20 +0000
Date:   Fri, 7 Jul 2023 11:02:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 6/8] maple_tree: update mt_validate()
Message-ID: <20230707150217.2ppiuemszsd5okfa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d6f634-3121-4492-2c3f-08db7efb29bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrotWwd8kh+Uman241KVAj8FFBZnHcokh6ejVQitzb+GPJ0kiA4d/+2kQDd66i5M3kLVb1+HqbPcrOnxGyaCutkyB8z9P+i5ehl8iS3MjQq/YwJbhIb5yZbxIGgHw/0s0z/1uwc81jrfGU7hQZeEowrLNeOvwds+RTcquPgVpkbsvOBigdi6vDhJ2KTIEn2ui9W41C7BWEAmaxkjtdAU9Wh4NvUTAiUHn661r7LYfuQiVysrEYFN6zuRrR0b4sLWVtwBppRzu2WUzrPGySshw0vzEopQCTEQk6ek78yh4TvbMOhknS127DFHZ0xma7sV/I6ZybWKgIB8128EJENX5H5cur1rvmw2KBdked/hN+Q4esr3zhd/ijIC87YOj68UOFihZDPNknFiimusyZoENxL/4mikCbTlR8k5m1VGnQIBkq4eJgzDa6JGhw2KvC8NgzAJmNw8Vzv3jXtJ1beno3R0LjGm/76mM2nGqbBSTG93UX1Q5T1CqodjsjmW5G06eooHCKR4bu+bvXpttcFps7Q6vlkE4wwCyQWexB08ihZFZ3pC74qei1BNprIVXlxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(478600001)(6666004)(6486002)(38100700002)(83380400001)(86362001)(66946007)(2906002)(33716001)(26005)(6506007)(1076003)(186003)(6916009)(9686003)(6512007)(15650500001)(316002)(4326008)(66476007)(5660300002)(66556008)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dc+q1c33tfxVWJxay39a2Z6SaSMVcCZsJ8TsJa8WdcY90hkTB6Wz3FvjCSYw?=
 =?us-ascii?Q?O01MFhiy1WPPhzjv96OA3/0pS+XhCM7187vXQ1gTSB/uodBf/jQL06M4q03E?=
 =?us-ascii?Q?bE35vtm3fzyUdpO94j7xYFPHHH5oGJj6K8vV/kiTKCIeLiQXuXmYYUVIs4zQ?=
 =?us-ascii?Q?ERW2lpuu2Gn6SbzbmFMWlSa76NPAqveeQV0ZLTYhsoMT3mieA8S64pXq1ARM?=
 =?us-ascii?Q?LuegiVAqjhCYhvA55WzRqI4/CoUJv/vN2WzaPu0PF42kLQPQyKMpmU7Tfbjs?=
 =?us-ascii?Q?sfws9HtanUB2irH1wNUcDwXLB4pM/yASy7zrKnCnIjZN5jrLInNK5NDRe/Uf?=
 =?us-ascii?Q?YeMqbQVBEW59y3oP04mOFB59rVjgYxqr8YS4m468/X3s2AjQBhexzdyVMb90?=
 =?us-ascii?Q?qqTz5ntROw3C3MYqDXdC8C0c7uDfH7yJMRD328lG0AAut+2KNhjpR3++6gUz?=
 =?us-ascii?Q?LfCzSlKy4fjcb2UJUh5HozsZ4sIdJOWLzFCP/SeREMhpGUIXdFNKpHgPpuGF?=
 =?us-ascii?Q?zqyiGQdRW3vBz0vEXVXJGoqlCt0zy5rbiJea8ZOM/35M4CgARb0TRLOfNfvu?=
 =?us-ascii?Q?E1nuxB64KL0SRR5eSyuKt92TNfCtx0TMLJgGxkZ78zGtMEYyy07IBb9JzTzB?=
 =?us-ascii?Q?X2AZmiJccNGoPvpW9rHmemcmHD3LoWSxEKqUr+SgW8fx+/Vd6RoIRnBf5lA9?=
 =?us-ascii?Q?8WX7f9UZos53FP8yiQCMhBCgTQswm2wpp+xqWivJetBHJmAkfJ1wWXCcegqJ?=
 =?us-ascii?Q?G0Hf2ZFDswfyojVWKGcM8LKSMMz0wlnv+Cpzd8B5picj9R0YtET1G2c/i+XV?=
 =?us-ascii?Q?gVdIdQ7Y2tvKLpYzJvj3CjDFTbG/M1q18vbFH6vkEEmnio88yYiPY+wGRoG8?=
 =?us-ascii?Q?Md7l3WxVRTq+NCvRM818GQt2jTK1u7cqEbu8LCnfWWBylNJ7xza0VH+VTcgl?=
 =?us-ascii?Q?7YrTUKtGK1g4RzH/vAYZLagfqCh3QT6v6BH/vIzC60MzDJYuU0awx0Gbl0YW?=
 =?us-ascii?Q?lbcyNhoMyknwukX53NgZxIa/i81C3RWoa282xsbaG/iCpcVeBenX6jeG81Wd?=
 =?us-ascii?Q?vEshjIeaXHmvzaQJupuuuTMBPPjUuaYbw6kTQxmkk/LB0LIQ5v5AOftbFnq5?=
 =?us-ascii?Q?BDAtPmYFGXi3z2ZQ+bmYDpB/2DuvGqNGRdoYQ35azyPbfh9iqXUwN9jtgMPb?=
 =?us-ascii?Q?wbBbBp9g5c0hk00qPscnjplkFy1aODOAEs2IOv9nXtQQfqmCOaTGgn0ESXNi?=
 =?us-ascii?Q?QH3mLEm8/2LbkY8E+aHr3inNnrYh3Ar4y2myPbgFJbaNDO3hCUe3nPCU5I6G?=
 =?us-ascii?Q?ZNgL+reVrsbtUMdkkG+PPNEm2i/vu4BLWYZAC4b6F0TnxZVoA72vmB/denl0?=
 =?us-ascii?Q?VmUo5DZnDmEt2LVmdv1fKA2CcHqBj9Jw0pAqA+jrVxYSNCEw2Ccb/IuXmZ0y?=
 =?us-ascii?Q?7yo7gBGgiF7YsRTDmVFWCCfGxOtDWFEqfwVUloHn/Lpn/eFWydYu6/Vpi4PP?=
 =?us-ascii?Q?K8oi+ONjYt0HWKeCwfjHrDJ1R2WZ9A9egLBZ8RYTzgn5wTT1GXiC1CzJEPFF?=
 =?us-ascii?Q?l6/mURERdXmH9zOsJIc3hLmsOiyppBiXCfNhv3NZA9XmPMid12j8lI7eSJCV?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YG/n5tZh/8vA4bChJmyofMlG4am9nhNRaslt5VNT/ccchSH/ohF9iK1VWojC?=
 =?us-ascii?Q?ceTmQnPo6pzkzJXbt0C/0AqVKQlPa1Yd70KRKLEyOxp2864u2tMMElLPK4Le?=
 =?us-ascii?Q?ZwErnxI8iRwTRIb2REBDXWVjpLxuqOaGzRcZ0/9/gCcgLm4qxcMWGzpKZBGs?=
 =?us-ascii?Q?KqJhclWlwHxo6LSvZWkb4haIckRZrtOaSEHhrPQEcwl2dBtsm7ZWAQl3Sy7q?=
 =?us-ascii?Q?sQ2aQi+PAaZAbX8fQiUnvQ/Zdf0O2n5eQMVVrAuQ7WWzQiFyv1hqbopLU2wy?=
 =?us-ascii?Q?Vk/Xu+2YY89Vb9q9Ba/zAcFNL1qe/xtewKk4/Qos2cUuZj/N22mfrl3CZmwc?=
 =?us-ascii?Q?31DtTpIqYzt2rGlFxvNMRxLS4amNz9mZynxQbA59ISYW1weab8LgTXyw8zKH?=
 =?us-ascii?Q?Gm52r7Rp72qbzX6+Jniav6wWdg7eQqr7KBvWNcyo3txzQDui/p6U1zUaG7M6?=
 =?us-ascii?Q?411H1llNOwragVBWwNuUVRPCt7WKepgJqTwJ9JiWLKPBnLZg1sT9AvI+VZWE?=
 =?us-ascii?Q?RRXlrtAUhpYAJf/yW1x0bzwYLdz4gXuc8qjwSm94Y+sYovL4mTXbM4lxwToz?=
 =?us-ascii?Q?qbVSUb+s/+3X3f6Y7V/hToAe+MbTvKeckee7sFUhPCObyc9ov7T7SSOpX1wL?=
 =?us-ascii?Q?dhIeepLoteJD0A8SUnBPOYyywcIKnWQ9M97/rSm9ugwZXlko7htQfKxW16sG?=
 =?us-ascii?Q?DNwIvSw1IRylY96ywEpR1Agburr6FnsUCwwNXTPo0NeDPz3+P/B8EeaO3Hti?=
 =?us-ascii?Q?+lJdrSL0/y89qwsKfKMfFQdbFoEbra2eKuhnsegSgVfGSx52HZ3/jIXj/K7c?=
 =?us-ascii?Q?0nWmFESNsu9aNTUV68XOZlJvP/kv4CWVIQe6c9czJnMXeS6erzalyBToUNaU?=
 =?us-ascii?Q?QMW+xrMJs8wGYpj1F3GLl+CN2wER/1swSEDbGYzjhtGQM6/du2keaFJPc4nL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d6f634-3121-4492-2c3f-08db7efb29bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:02:20.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h45NJRhIXK+zQSd1jXVDkXcqJmeq6mv8/2Zlk+PkX/BkubYd1wpPwzXVXY9KFfzwWrlp8G3/JkmSuga57n3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070139
X-Proofpoint-ORIG-GUID: EgacjXhGCmk-px9-K8STUcp3E7hg3n4O
X-Proofpoint-GUID: EgacjXhGCmk-px9-K8STUcp3E7hg3n4O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Instead of using mas_first_entry() to find the leftmost leaf, use a
> simple loop instead. Remove an unneeded check for root node. To make
> the error message more accurate, check pivots first and then slots,
> because checking slots depend on the node limit pivot to break the loop.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e84a042b6d84..3aede7deaa26 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7260,21 +7260,22 @@ void mt_validate(struct maple_tree *mt)
>  	if (!mas_searchable(&mas))
>  		goto done;
>  
> -	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
> +	while (!mte_is_leaf(mas.node))
> +		mas_descend(&mas);
> +
>  	while (!mas_is_none(&mas)) {
>  		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
> -		if (!mte_is_root(mas.node)) {
> -			end = mas_data_end(&mas);
> -			if (MAS_WARN_ON(&mas,
> -					(end < mt_min_slot_count(mas.node)) &&
> -					(mas.max != ULONG_MAX))) {
> -				pr_err("Invalid size %u of %p\n", end,
> -				       mas_mn(&mas));
> -			}
> +		end = mas_data_end(&mas);
> +		if (MAS_WARN_ON(&mas,
> +				(end < mt_min_slot_count(mas.node)) &&
> +				(mas.max != ULONG_MAX))) {

This line can be reformatted now that it is not as nested.

> +			pr_err("Invalid size %u of %p\n", end,
> +				mas_mn(&mas));

Ditto here.

>  		}
> +
>  		mas_validate_parent_slot(&mas);
> -		mas_validate_child_slot(&mas);
>  		mas_validate_limits(&mas);
> +		mas_validate_child_slot(&mas);
>  		if (mt_is_alloc(mt))
>  			mas_validate_gaps(&mas);
>  		mas_dfs_postorder(&mas, ULONG_MAX);
> -- 
> 2.20.1
> 
> 
