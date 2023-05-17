Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B55707091
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEQSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:17:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C41708
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:17:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGo7p018161;
        Wed, 17 May 2023 18:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tASWncjPADylDgnpoACb3LBc5x45OyeTe9+zoKbYAF8=;
 b=OKXMoudcKA12aQsXmickaKaiOem1PetdIXokUHoZzhisMnSFAy3+WPcYG1uS2xLeuhV9
 0t1JH8S05TbqG4GTsBQkR956EP2Cmdao9Cinpc5g/kMvnC7S36GgTZXhcthy+uExGyNT
 yxuQb8IhxsBclZP/6Ig5fmdzMV8WmfJbIXOqeysP7y617un0K9mashZdvGt7RTZUS1IG
 8S09rCnC6sv2KO1Pyau8bVF0ufBGYxhFgHrFepVAXgYVKXBLcCENrwJ3MNQXJYk/V67D
 zftBxObTxgAr1s40r+4g7HFqiVihghRjl02A9q/y7l+3fg7LbNz7rTpaujl8btbZ8h06 VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye66t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:17:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HH8rr3025022;
        Wed, 17 May 2023 18:17:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105s68d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajD7vuffP/TmVmdYFlZB7y1R9w64p8+pHyWaPxfF1Q2xXZyvJpPiJjroObgKa8u1EceA2ZD30od4JIGM4Yqs/eyF1VJ0+5hP/+UPlNkMA0ao0dEWR/yVAHj/QfYt9eDPe1TeXsXBvbrOd1RW3+zVJwgEbKV3un/5DnIARaKVDy6IyMatvDHMgd5sNu1lBr+FDz3yCp0N5yPpwKyinzyX821hTFEp92oDFNxsDnjTBJIE8EyGcKzrYzVIt/AbTCRByRhB9WH4udqWaC0KEhWMKrH6LU5NKud45Uky7CmSrAWk88kMQAUtgdfqgDos+WovGtQCkZ8nM2jTU6DphRB+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tASWncjPADylDgnpoACb3LBc5x45OyeTe9+zoKbYAF8=;
 b=F7K9PvbjmI6xs+XaQJQA1QWHu40EAUowofDh8tmasveLpS3kn6lNDjra9D95guDEMZuefelGffHw336Z63KF0JeTgJa9BPjfVM8YyxR7sav5mGctWcvjtsHHV+tfqQGpowOKUh5efFa8oajh1E9SgwSjrrM0Q/I6LDKwfo2LrlNZUP4dLzryQ1/Ym+5nEuCrI81Pi6wx1VG6K9GRzLt2Y38E+FbrnutUyrZyLKmc1pvAuN3g6iutUZ7nEVmLxwad8DyYElb6/Q0YIQvJIR23QByx5UsBdha5hWcOoXNuzhgT8i0Shr9wZflHftwhWd4uPBE4ATaYhqHqeSWN/Jiq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tASWncjPADylDgnpoACb3LBc5x45OyeTe9+zoKbYAF8=;
 b=PIUeSVDqUIJTl4MkbJDhg6d3jVa5EhIvNTS7dLuIf1YiSdaSn1VDCc+uuKcS+VheGnDD8+y3985HzEeYjIdeNgVezVy4/vNJebw4hXcT4QlavTrgbbGL7vTVjORo5GxIxPhHehEnGn/k5yynG5ED7eDjs/IQJIrCQ/wdHiPDNOs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 18:17:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:17:08 +0000
Date:   Wed, 17 May 2023 14:17:05 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Message-ID: <20230517181705.rdfffvfhqzlsjjlm@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517085809.86522-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 6926948e-3dc0-49ec-e871-08db5702ecfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5dyHZt//1llkRefBkgJidZCFZahFDvbn3PBPo7/ECHr7R/M4JG7ftK6fivlafqzI+bAxxHDGr5Xju2hoqu4RW/cNjPprJbpKHybdXVyST53eUYcJpF1zLMF0Gu7+PfKD1MR8mnDF4j6X+anNST+xbCu8kofSsboY5976AQWlQvcH2cwmBby60ki5CZLao1MZQe3tfKVVTf3ysSWSHxLrUpPaHz+vost/Y+BvaU712FJKzY/sk5ACWMxDhY8D4HwURLUEtNcaw7XDXf5x95NvrMkTpvcfIGqhGde81K4IICTieTIs5+G2xDcxqTiVafhtxm55+vFQ/bBsgffZnv9wVTvcbi4jp0wdGbI08nosMjpnOagohQt1WBwBv9wfiaZdBa3v6htQWCx81QwGHk6onyiojyexpxpprj4yrZ/1j3J68Uey6aTOo6+PpKGEI5dDU1uwY8hhm7UCWCAlHNkOk4BxPJPg0xQgZ4NuG34kGVPaeZuZlAPIrwJpdSZUCFOJE798oCHKF7eGP72bYSNYt5tlCJEon6x2krK/lIP0UlOPNDrKa9tEdiScAs+POgU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(86362001)(6486002)(316002)(66476007)(4326008)(66556008)(6916009)(66946007)(478600001)(33716001)(3716004)(8676002)(8936002)(5660300002)(2906002)(6666004)(38100700002)(41300700001)(9686003)(186003)(6506007)(6512007)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hu7LosuobAS87F/vxrazaUcwABeqMJq/00ZMwOIKLCyGu9zYL0aHNpUlO2TC?=
 =?us-ascii?Q?XaAe+kKYuvfb48+90aMiPIhq7gLF6zWl8AMrjcIcX/QQ1uIdHPfp1XGPl99w?=
 =?us-ascii?Q?2qiix7s2OHqYhbSkOkpH+ntXRuRXr03RRPvkGgSQ6rUgWTytVaCPbsU5LYus?=
 =?us-ascii?Q?se1Suexe2zRD9vHxA61TmmJ0lKw7d/geKNNDbswcULCh4z+dTjYt2Lu8tlpp?=
 =?us-ascii?Q?3sJAsxnECzrYNzcip3h5Ez5/ARSkheCQVgZ0ir10e7Ey8J5LL4bTC+pv5keC?=
 =?us-ascii?Q?KMNUuL5Hsh8vH1nTDABJzz2wREkKjKtfyDY4xgHWU/EYhO9+LDCYelaZuAcH?=
 =?us-ascii?Q?xgeZ7PiBgI8WEJwKcpGDOLQ27zQggi8uAljOld4ZC+tqxw1Kvvishc1ycajW?=
 =?us-ascii?Q?pE3w8pFV/BLVYsvptpNaXcnO1KKkaCD0rgKzy1h3mnXPToCAjV73VyiTzl3+?=
 =?us-ascii?Q?6ft0/XrekpBjt93uLLJNntswdE7Yg7G5tdvFP7VfFuArmpzrzJQMYCdi2VtK?=
 =?us-ascii?Q?QHmrS8dNKEsXC9gBy1IaeuF9cH25qBrJY9SsveYnJ7WlUmu6tIfbQkaNqM2V?=
 =?us-ascii?Q?Y8KRKy00mJxRgw798eAPX0xCqmlugMCy562iN7WuHiMJTJ51+0cO1+RIKAcI?=
 =?us-ascii?Q?C9ZTf7nPw8nfJgXiGTaWZFJ9/I8XeqXRcDuZdVAf8ZgLbDaeJcO2qni6HDVM?=
 =?us-ascii?Q?jChoS6uiLP/QobMv9Jq1HdVhk0elspaYoE3sDkbaWpthMxPiy0f1g74oDo8n?=
 =?us-ascii?Q?hwHMToJE5rZ0lX8FJtDLvXJ7PTyF3jdXxfPldsgHmNm4xo3buWyC0zotEJKT?=
 =?us-ascii?Q?fHGC9wZzCRfhjzxKo4nPgobrnlInv9i20FppjHwdTyUwACDbD3kkJJbmLKyK?=
 =?us-ascii?Q?GXpJGLLWXES2woas6ZVIrYILYBEKDgzGKRaM8+oQv5bewyaiuu3P3z3voZXG?=
 =?us-ascii?Q?Ko3SpVjFXQClDZ12EmiYeo3bUeeUhaCZidn7/HOFHrtNZsBsQMaHyyYeHcdy?=
 =?us-ascii?Q?VNtpxeG7ElkiZzfxUiTs+FoDOlERSYCrlev9Ezrv4P29ki6686HD9YhVofjF?=
 =?us-ascii?Q?cVm/NfbffJ6cytP/NeoCWISSSe2pgDoXvODYwbxW0C3vOXuM+EczGm7LXuzD?=
 =?us-ascii?Q?9PEBdo3zC8vd9XMKWCQaMrGa4/rfpo8dAL2cviYFCrcB3a9D6TESg/15gFn7?=
 =?us-ascii?Q?TTbAJ8YzBwh+Uqvml06EGgzCyHg9OMqmwi359+CyiMyLZBnpYbo61ckE1s33?=
 =?us-ascii?Q?MrhLVQitI0a59cyrMorQM2SMDWKZhSc6m/vxnDbM2h0Gzc1KtnfG+CHxjzx1?=
 =?us-ascii?Q?dgh1BAYK0Fk5KKehE0rH2Xv+6G1nJlvBYVwTKTKJ4c3IBCXkkofkKWP+YCV5?=
 =?us-ascii?Q?M+Y7lcOYeMgvTYhzHIMznLxQLjmpysVN4ktzeQl2lNwzGfqd+5FD/aYEDuCa?=
 =?us-ascii?Q?wWshCgprhZWNgcFTEtLytvs5+mye8dUVq6d8eUNw02l7LE4btd7MY5As7Kv2?=
 =?us-ascii?Q?aDkhgZYw9r9kdnKeayW0KdivS/vq6qIc/CSy/OricOCDw6eA970v+10+wHFZ?=
 =?us-ascii?Q?FF1mm5dEWx7dGecAE1z04WcFFyNQ/3fEq5n5827z+Hd/tNej3qRE7niNnoPp?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W7Y+CLD2lkHZtv6OY1U27Acqnwoz+y59xRaDreMODPw5MMVvq1EtJlBrX32K?=
 =?us-ascii?Q?Ghn95i06w9I3lldJ4rGPtSklmEaif/WHVctz6JW0jfpJFTLYAqbubkQ63Xxw?=
 =?us-ascii?Q?8lPcKrXDvlleKpqSvKwnO1dsUcRZNrhHU9GmavQztQ5qhnA8i7EsR6qPRqVz?=
 =?us-ascii?Q?KccDbz8GKj2SUoHcNUah24rXwEMNosywqzPxxvPktgekUTUodGqnTXHHjveb?=
 =?us-ascii?Q?62mt53yeyuNAUVs0C/KfUyRrKbRXcFepV8I3b0rlTvCFU37us5eaUXaz+Mcx?=
 =?us-ascii?Q?EThnIvfDsqwteSgsBW8UXJ2xCCd4yvp1H7cR0pB56Jp8D+EAZZYTCk3LmUaC?=
 =?us-ascii?Q?4jFBuTmMECKahBr1KNOWOg1ypgCvzOGlpBkASxI06R8XIxbFYPkbFV34k+/P?=
 =?us-ascii?Q?wp7fISgFhFAt9BJU7z1MOSu8+dkxQMAa6eVqFHiwL5WqCBFh9RyN5ANX22De?=
 =?us-ascii?Q?JHeCQBlOF9p5VfGC8YOI6OjUYmcRQJg6a5+SmWX1qTV/OqUHFuBc1ZNe4Aia?=
 =?us-ascii?Q?UiTXeEbZAPGPafDpvGvhwRnJZh6gAhQh4MBeUPdONnSO8ZGNq7v/IBOVfwxJ?=
 =?us-ascii?Q?d3+5ZzFETjDbnUvPVyDiEjqhznZjaduw5HBDJkoRrIQMFmYDqQZj8tnB7tEo?=
 =?us-ascii?Q?VWsVXEG/wD2Os9jqIWQDtcAAWHRixBLCSI10rfHy1lno3CsGSp/Cj+1EXSWS?=
 =?us-ascii?Q?WRBQuG5Bv798tuci7uzJLCjn/8qla/T5ifN6n6XI6jSiELrV5XJ7ehcQK8Mw?=
 =?us-ascii?Q?bINkPDNTQIROaqEAKgHu4whQUoV5QJ9aygQWy5sIGGjCiUO8H0dLxDWukhzn?=
 =?us-ascii?Q?E3pm31WoSXjmgfMh89+LHH0TYJf3huvnBG1JiwBo/DiOJyyl+DZ5J2RaJHsZ?=
 =?us-ascii?Q?6dX6XA7DyU6GwlvjcdMh6dtm6v87lKJNvFBA+e3JVQ36bb47viSvqF3Fm+iN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6926948e-3dc0-49ec-e871-08db5702ecfa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:17:08.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sSUaL2a8IveJC6Z5Uz0VU03I32OJeP8y6OZjT4kbeFyO1ExxCy+jiCUUuIR17M0ACYGDE7IXiqrVcvL2G8SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170150
X-Proofpoint-ORIG-GUID: 1va_yLocrJJsfl60pwhVTPfyJDaesWHJ
X-Proofpoint-GUID: 1va_yLocrJJsfl60pwhVTPfyJDaesWHJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:58]:
> Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 63 ++++++++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4eb220008f72..e1820e90f167 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6493,32 +6493,31 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, min);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
>  retry:
> -	mas.offset = 0;
> -	mas.index = min;
> -	mas.last = max - size + 1;
> -	ret = mas_alloc(&mas, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> +	ret = mas_empty_area(&mas, min, max, size);
> +	if (!ret) {
> +		mas_insert(&mas, entry);
> +		/*
> +		 * mas_nomem() may release the lock, causing the allocated area
> +		 * to be unavailable, so try to allocate a free area again.
> +		 */
> +		if (mas_nomem(&mas, gfp))
> +			goto retry;
> +	}
>  	mtree_unlock(mt);
> +	if (!ret) {

Checking for a mas_is_err() should probably be outside if (!ret)
statement.  If mas_insert() returns something besides ENOMEM, we will
not detect the error.  I'm not sure if this is possible today since this
should never return an -EEXISTS, but having it this way doesn't add much
to the overhead.

> +		if (mas_is_err(&mas))
> +			return xa_err(mas.node);
> +		*startp = mas.index;
> +	}
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_range);
> @@ -6529,29 +6528,31 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, max - size + 1);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size - 1)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
>  retry:
> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> +	ret = mas_empty_area_rev(&mas, min, max, size);
> +	if (!ret) {
> +		mas_insert(&mas, entry);
> +		/*
> +		 * mas_nomem() may release the lock, causing the allocated area
> +		 * to be unavailable, so try to allocate a free area again.
> +		 */
> +		if (mas_nomem(&mas, gfp))
> +			goto retry;
> +	}
>  	mtree_unlock(mt);
> +	if (!ret) {

Same here.

> +		if (mas_is_err(&mas))
> +			return xa_err(mas.node);
> +		*startp = mas.index;
> +	}
>  	return ret;
>  }
>  EXPORT_SYMBOL(mtree_alloc_rrange);
> -- 
> 2.20.1
> 
