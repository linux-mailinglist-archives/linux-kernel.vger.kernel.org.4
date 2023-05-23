Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702670E442
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjEWRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjEWRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:54:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9DE6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:53:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHofDv025930;
        Tue, 23 May 2023 17:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/9SU8JMPuxXXuVVuITSZ2w8DOP+4tHeT7XFG+75f+Is=;
 b=hchn/1iuIYo4+SWi7F73qaJf+34Lm07AJqoGe+qkz886iS96XxQu1qJ5ytUzm5WzLbKw
 6rwNy0azZhSDzPM5Y8ywFoif1SvDTP6OrVbXGBeSbYJ13uqabP1fZZzC+NPis+AGx6Ta
 jykmLhxvNIR75ZITsGIdxxbojKrcwzgWlf7rfYncj9pDwtubVKFk8K6lFhZB+jYT6ldP
 SAL6IQo9goQg1ttAvp2SyTd8rxSC8E0OLLT/LqUjN8AsWLYObt6h2TBnmUUH0Cjs0+4G
 GmEI5fmvEN6znuG8mOyJC3J/uzXpGXfiaxwWJI5xNzfy5iSYclDt8eQozmldXHMBeJdz YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qnses-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:53:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHd8m0028896;
        Tue, 23 May 2023 17:53:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2b69a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6YESzSPsElZ7tT6t5uQ1f9zwLUKKdHXVXpcT3KgoDMFcZjhDsKTHbMkmWJWtzivzndDGBJ3YMBJYkonMmuqBllagM9712A64mKHsvDW39+6tQgySznI88+CQKvZ/wVaIMoUCpTWD1b2CuUmj0NJABmdsEvEIsdpJ1fBpMMKv9K10yGqW0yX3mN4mrSL97MMCAX+zFgG66ondZQHgBYlUxxkS+Nb6gGpLRmbfFAWnWQWKoOOTtOoYWGLon/04Towfdm/9RXgSRqMj/e1pm1R/2ggWWVPwcTB0FGHac3TRvubn+3UAJMpfYP5dw4zTlsOo1PqW2WCvAKYJ/05IZKoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9SU8JMPuxXXuVVuITSZ2w8DOP+4tHeT7XFG+75f+Is=;
 b=Ue5VBfTG6E83Svh6o49xyquD6ZU6SfNGPLHdypPS6MVraqoIy87Qdl8PgYdHNzPYQMUdNY+aNSJSL753uwsTUZEfqkqQLm7cvzqK08RNeXHhSGpilpSlAczaGV37HkX1/gIZkz5onwDW/6jANJxrHww95I/zC8+EV4FRYxCJzCgDMxg/bcisp0wBSbXngYJcR/1i0n3br1opp/AmEZSGwPIh7qHMHYQ5t+v6q3oZSReXi1SEmnCmviwzY81UTuijTfY7Q80uKlgHy+ZIfJDtKXD5Nl3aKdyMQaysT4BYcX+xhZVjgvhOIihVZdgQK3UQkxSx4aBZSRKJKvAKVcH8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9SU8JMPuxXXuVVuITSZ2w8DOP+4tHeT7XFG+75f+Is=;
 b=qio4DdJKj1QpAbzVWbP/W9bSXFWze/oIvKCKA9JjZFMu3xsQgAXD7cw62IksN+8knvC6wV91MO7Ha5fD7zJxnKousZTreUuEpJYnJIVjr6H5hgXlwWvN+EBLkthZju//sd5O2qj0nnpDkNko48Nr/WIDz4/rAc6KmXKuM0eBLn8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Tue, 23 May
 2023 17:53:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:53:24 +0000
Date:   Tue, 23 May 2023 13:53:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 02/10] maple_tree: Drop mas_{rev_}alloc() and
 mas_fill_gap()
Message-ID: <20230523175321.5msehauvleqp4csn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e7f1aa-9dc3-4524-a35f-08db5bb69aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LOqWOxM7GfGJVk0h4WG89fYNmbxW7i0XMqFiFbnOJB7t7par8EBexvgFpFi3EpfwS4/8NTHWDR7qaWI+AsNcqQIf4w6R4nloJv4P8AwBgcGEOCVnYuY2elQY4D6uV/enKENJU1adSw449Qv/h1n8VPQn/hvT1M+OvT88Y6vifI40ces0Sb6wmFwCWzv5HTQHYwxdzUPHHvf9+uV8QsDDpch3W20VCM1nz26qz7wGLCL9LkmcXULkqC7Q2fR0J8xQjLm2CTH2W+BkLT4pAROastOqwTRWkevC+I6S6z2dVcnkYyOJct8FRWWqhVDuiM9kcw7NoLAs+icLG7KnyjKdsKtanKb3ZpXfJVALddGsFMjKdciEmRiBqh9il1KbHIv5cQBkuAFS4QpO3uVh6kvS5CRv3il8SYiQAOd+wBIrsxPcpux5vO8BtVHlSF/AuZ8M7K6684bgOFsIW/5i1OB0/JJqHP+CTkjuRG1D29bgpejsd428QJUWzMPrhVWIt3DI8+ELi9gNlJTXXetIzCltmwOV7tCuzLDsNzDHyXn1ZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(966005)(41300700001)(6486002)(478600001)(316002)(66476007)(66556008)(6916009)(4326008)(6666004)(66946007)(5660300002)(33716001)(86362001)(8936002)(8676002)(38100700002)(6512007)(1076003)(6506007)(26005)(9686003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Kq7FHl4Amge92slRdR0AmF8WRknLRnQa9ub1pkgzP5dfxJRmMHLwoqnwRfc?=
 =?us-ascii?Q?EToYlni1ysDLRjDgQJ25EyJ32qYVbilnXEZo4MGlHU7O9n+l1jvnN71emUYQ?=
 =?us-ascii?Q?FMUzDvA8qkp3y45xN1wIaDDdnf4hBxzvoOYsD6U7Qd8LWh8aM+WmTLEDJR6C?=
 =?us-ascii?Q?p2lTa04ehNWScnaxYoQmlKgWhMY0303oBcbTKHf6zGSfM+3oibey00oQsoRr?=
 =?us-ascii?Q?Hy8zv4qyGLryvN9GHu7Y+vL7i/FesOc/PDY1KvL3sj1C3ETNf8SogVFA7WIx?=
 =?us-ascii?Q?Ma2Cgk30L4UlHrxQpBpArEv3n/7PYLpZ49Hwu5+B5b0GRraDTkpHbxh4jCe1?=
 =?us-ascii?Q?AtwrVE1MqsigLd6LPxAK+TMat69JrGOHWOzSZnDmiz15wPXCcB7Yb5ZbtV/Y?=
 =?us-ascii?Q?+irVUr+jMpNZvtN2wYmNEVOWmKb+/k2RTVfbGrCLsPXWXUBHprhfIAdi4IRw?=
 =?us-ascii?Q?iNkg2OEqsZozDsGyR1R/Sw8JZ0SPinj1BuGVebf7Qpc0zV7kXbY6wtZM8nQx?=
 =?us-ascii?Q?Q8tzEPqAV9yVZN3PUsUGqPZ6g4RWKy8nPjpFh2FhIOwwkBZwuVXBPfCeivMC?=
 =?us-ascii?Q?UQhwTA/wuGa+8mlULUMi8lZR0SRqBeOKBSaiThAn3R9+Wil8duiw4bJ1ZqS2?=
 =?us-ascii?Q?4ljXtFfvNzDnE2BiDe1ajVoCvzoQayy+HCXjl997ZLqW6Yax0GMGTFYN5nPz?=
 =?us-ascii?Q?8pfRtf0mDHm1CkJzmkYtm/Umed7ad+wRtWMT4+cuDfggG2GnD82n/rbcU/O1?=
 =?us-ascii?Q?XvQbzq+m1iG64xD7bUThdT/WZJuZGXsmK/HSJDNaEY849cjk0a5uKNlaR6ug?=
 =?us-ascii?Q?XJousbNsbC+a8ZLa/kNTYW99XwEZnz8DhQUv35bi52K+LI6Mz6JYaddz/CKB?=
 =?us-ascii?Q?quMzHJTWhye2rjd0xiBDhR3ctobPDLrI/1J9lW4mnZgLMqlcyEA2OSrKmFF3?=
 =?us-ascii?Q?j/qL4VXx1WSPdaY0SmQxkruUq41tJvOlPkv0UNDqS0B8mksUGnZHAWnwzwF2?=
 =?us-ascii?Q?bExHLas0j9Qt0huIGphEVtjdCEhZ/JNznSexBG759OLiZwOHXcKnp3jOEiuf?=
 =?us-ascii?Q?T3UAuzmCK/3E6e4Nam8jYrdgOxfq9dcgSoicbGlfxspJH/hWPO2cjzVCbL19?=
 =?us-ascii?Q?2tydJL28UjS8ajd3oKHu+dYWoV+moPX1x9zA3WvE0m5Rzhc/b+6W807COTsZ?=
 =?us-ascii?Q?eiTBlEtwFTiq1USL8PPPVQ/sICNPzBq60SyZXNcT65J8+cLoGm1iMXQwicRC?=
 =?us-ascii?Q?CW4F2arky10OBICgjZlmcKYs3hya6UcXRTg6yMJgtVNTbr+uIFKuUBgl+0l5?=
 =?us-ascii?Q?YGLqQkogJm22oBHCCAkkRZLgvqh9n/4MttE37F3UMTgvUTCtOVAnU4+jOMxY?=
 =?us-ascii?Q?wFGfgsLIIuYelr2YsQOYP33RU0srdGzdJNbg7f9tGuDGXxk8QdFnFrrDx7Z6?=
 =?us-ascii?Q?XE3/fOgEzIGxhBxB192MYJdMSSfIU5x/EUs1yQDW4MrSTU1f7jktrwX25Qtb?=
 =?us-ascii?Q?a1stWES1bburL3qi0SOquza2O90RZcZ9gQOQfvhH54l5RqfZkEH9dKEHgvVL?=
 =?us-ascii?Q?7kI0Sdgru3AwZ2+B5UJswMb0EkJ5Ass2fOgH8nbSv6ob8qCAp8Qi0+9lWdJd?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XMJ6rlCQQqFDSgrvGnJGdUBnjWQSNL7xq2ZKZUJ8BIEELf27ER6KP/NyW+Qh?=
 =?us-ascii?Q?MJzJetwGzGE8BMIKxtr9yqrsQ/J5BKxsrR+6vU/I0evXJzRRh4ql1/FjuFqh?=
 =?us-ascii?Q?rgC32GIMFCiycTzTBm8El6ncpSQjrmvaKn6yBGgeZ0ulii3lP5cJIdsRWm/P?=
 =?us-ascii?Q?9VXhxZy2xmumsPzh3+3R92PCYQIfLvI/Kmf7AlqhAaPlRT9XauDyahiBBNqS?=
 =?us-ascii?Q?PdWie1wyHJt8K1nXUrWjKveXez0SG9hm0EVglIwDW5qVdfnxOAinXVUJYOup?=
 =?us-ascii?Q?u91tqjwh6bjapZsBOii4/fxnbkPKjac39wII8EfLgxCyAKZGFkyjilq8pBr0?=
 =?us-ascii?Q?dCKKMxQUwsLvHi++Qr54k632hRqUINRW2CIAh0Db1fAinXfEO/Emw6F635+v?=
 =?us-ascii?Q?pMK6qJFjcDm9XQBO2cwNRTRGRVTXoICGZ1hjXoOtyNgIvN6XgentDm5XEMEo?=
 =?us-ascii?Q?5iAUqkFzFvBQ9HZNRs9ojt9jhHCL0ICrViBlsOWcoycYpk6ONhcsH6nXl3OH?=
 =?us-ascii?Q?X0ijgFqQb0GIlaZmC3g7Y0/x+5+cYi+oqBTl2gAoE/DexRTmRuCTNFQIQisB?=
 =?us-ascii?Q?0iBkv2+wHay9I+5RRT+Su/XHzSO6ooscyWfX5D7oqWkFrbuiVaIE55sIhKcP?=
 =?us-ascii?Q?4aGLHPd7DtbsX2qYlopBtLxFZoMyakpNlFK/KVSz6Qa9N8zeM/C8P3DWQE8s?=
 =?us-ascii?Q?N4oPc5D3qqrfYM0gf6n2+CCmiK30HW0UY4JlOzUBkY7vHVP1q8/gJlsF9H1Q?=
 =?us-ascii?Q?RTojHneBrr9hbEBZ+A6hXLr5pUP7/K1dSsiJP27/+SeuAwsOxEnhCbI+R5GE?=
 =?us-ascii?Q?SBM+cOkHLEATMbHt5jiaBEVAe/xSyMTY82MGl193nCTeQP/IzSay5xItXm//?=
 =?us-ascii?Q?48hBQPMGJc2t3wxPZ+HBESRCZiYcUYXu8HSCVzVMM+E91pk3n3iH4mJ8auyc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7f1aa-9dc3-4524-a35f-08db5bb69aa3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:53:24.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nus0NfWYv4Pt4MurHLof6b3R2/4ou+VmiSRUIrJK/axvfUvD5MbqlfcW51DGYKTXcuv6U55U1igiaMbl8M7Wrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230143
X-Proofpoint-GUID: YBZYsIydpy2_ZUVqXWImfcjQTbbZZkLG
X-Proofpoint-ORIG-GUID: YBZYsIydpy2_ZUVqXWImfcjQTbbZZkLG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> mas_{rev_}alloc() and mas_fill_gap() are useless, delete them.

s/useless/no longer used/

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 108 -----------------------------------------------
>  1 file changed, 108 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 96d102d60b4e..263bd0ccc31b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5120,46 +5120,6 @@ static inline void mas_awalk(struct ma_state *mas, unsigned long size)
>  	}
>  }
>  
> -/*
> - * mas_fill_gap() - Fill a located gap with @entry.
> - * @mas: The maple state
> - * @entry: The value to store
> - * @slot: The offset into the node to store the @entry
> - * @size: The size of the entry
> - * @index: The start location
> - */
> -static inline void mas_fill_gap(struct ma_state *mas, void *entry,
> -		unsigned char slot, unsigned long size, unsigned long *index)
> -{
> -	MA_WR_STATE(wr_mas, mas, entry);
> -	unsigned char pslot = mte_parent_slot(mas->node);
> -	struct maple_enode *mn = mas->node;
> -	unsigned long *pivots;
> -	enum maple_type ptype;
> -	/*
> -	 * mas->index is the start address for the search
> -	 *  which may no longer be needed.
> -	 * mas->last is the end address for the search
> -	 */
> -
> -	*index = mas->index;
> -	mas->last = mas->index + size - 1;
> -
> -	/*
> -	 * It is possible that using mas->max and mas->min to correctly
> -	 * calculate the index and last will cause an issue in the gap
> -	 * calculation, so fix the ma_state here
> -	 */
> -	mas_ascend(mas);
> -	ptype = mte_node_type(mas->node);
> -	pivots = ma_pivots(mas_mn(mas), ptype);
> -	mas->max = mas_safe_pivot(mas, pivots, pslot, ptype);
> -	mas->min = mas_safe_min(mas, pivots, pslot);
> -	mas->node = mn;
> -	mas->offset = slot;
> -	mas_wr_store_entry(&wr_mas);
> -}
> -
>  /*
>   * mas_sparse_area() - Internal function.  Return upper or lower limit when
>   * searching for a gap in an empty tree.
> @@ -5307,74 +5267,6 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>  }
>  EXPORT_SYMBOL_GPL(mas_empty_area_rev);
>  
> -static inline int mas_alloc(struct ma_state *mas, void *entry,
> -		unsigned long size, unsigned long *index)
> -{
> -	unsigned long min;
> -
> -	mas_start(mas);
> -	if (mas_is_none(mas) || mas_is_ptr(mas)) {
> -		mas_root_expand(mas, entry);
> -		if (mas_is_err(mas))
> -			return xa_err(mas->node);
> -
> -		if (!mas->index)
> -			return mas_pivot(mas, 0);
> -		return mas_pivot(mas, 1);
> -	}
> -
> -	/* Must be walking a tree. */
> -	mas_awalk(mas, size);
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->offset == MAPLE_NODE_SLOTS)
> -		goto no_gap;
> -
> -	/*
> -	 * At this point, mas->node points to the right node and we have an
> -	 * offset that has a sufficient gap.
> -	 */
> -	min = mas->min;
> -	if (mas->offset)
> -		min = mas_pivot(mas, mas->offset - 1) + 1;
> -
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->index < min)
> -		mas->index = min;
> -
> -	mas_fill_gap(mas, entry, mas->offset, size, index);
> -	return 0;
> -
> -no_gap:
> -	return -EBUSY;
> -}
> -
> -static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
> -				unsigned long max, void *entry,
> -				unsigned long size, unsigned long *index)
> -{
> -	int ret = 0;
> -
> -	ret = mas_empty_area_rev(mas, min, max, size);
> -	if (ret)
> -		return ret;
> -
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->offset == MAPLE_NODE_SLOTS)
> -		goto no_gap;
> -
> -	mas_fill_gap(mas, entry, mas->offset, size, index);
> -	return 0;
> -
> -no_gap:
> -	return -EBUSY;
> -}
> -
>  /*
>   * mte_dead_leaves() - Mark all leaves of a node as dead.
>   * @mas: The maple state
> -- 
> 2.20.1
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
