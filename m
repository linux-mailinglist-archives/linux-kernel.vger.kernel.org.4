Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126D064E3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLOWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLOWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:51:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34413D93B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:51:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFL4HOk024048;
        Thu, 15 Dec 2022 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=h7tyWssooPFHDYs0ppwY4/B49mQ8iJ1/f3x/XXDgwsA=;
 b=gixylr60OFeTDM+/RBFP9S0PPrHu5aRZNmbNCtQqIA1LyNTtRIvfajbaWqolIzoJybtP
 zKMNFf92nLB4ntMpvAVZQNdjG4SN/WQGPBG/pvNDRhtgEu/SAyHJE2d3gxJPl4hR/2Yb
 L/MuzSfY5xdCHxY185oqGQSBwfKhKrhkqdHdgV1PXHwp4YofDXNILRQsNg67AxiHXHHC
 Tx2vdQbRcqTkd5hv2kRIT0xSbDekQa2aUqjcEa8+rPDam8AaSIoEgBnDS0Jj+47D+UT2
 GC6h9nf4GNS/8x4bDyMBUBTubHMAJz4TVbC4P2J87O1ckQ3NhERVmJc751IGiEeHzwmk aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex6d08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 22:50:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFKjlnV011063;
        Thu, 15 Dec 2022 22:50:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyewh2d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 22:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBhTXrqPGNKJx7yD3lMPWbKDqJngiVDK5AFepiRVnqO5I+lPVCZvZRPndsj5XxLttU8lW12y6E68YOF07/8AyF2UdHh6eefbkYFMcxAX8xrnTgdTs4dmGBpGQgpKTW/Fcwj2Pl8af4yj0fiK9K1glrnlAWEFtkrsDCWHTaj07qra7rrHdhSUbz+CaARvAHHP+Zq0RgKjeKu5NWBVJQAjstU03IBWAPkb+6np+JzSJ+1xfpQMsNZx7G8XkJEr++BHsFMPXuP+TGP7gG1QqPosaT6AI5CT0mONecbZgs4L3RU0vULWm3GcuQMXdvDynmOLGtxp65tBxAjMSwUUt2lKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7tyWssooPFHDYs0ppwY4/B49mQ8iJ1/f3x/XXDgwsA=;
 b=BNQX69nJpfLqLviD3ltR36sa2XkhSRXZMMmX1HjTywkaoyMmX6sXBzmBVtxySlYv4kxAJjpHZZzvUdNZU8Pba5Zyr/Jbob8xdHo+dCRwGowqJLcPtnApK2ICtDSQyx0ymyVjLhYR0S0bwkGyPoyLM6+vNbgluGfu/NOaiqjADMvWSv42cEx8hmuSb+Yr5XH5Yjn2BFyUHelAIGtdYrjFclABU0bvnhGW+QFMerPHWiWXSMCAqSM723G71GR2euyKWjnVu/Q9jC7RfvnjYCrBBPbMrF9SXoQUlSQSLZObuibl+MfRGUwhRYBIJcTaOEt/4WSazqQdGakx/wWrklMc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7tyWssooPFHDYs0ppwY4/B49mQ8iJ1/f3x/XXDgwsA=;
 b=0Ao4Vni978Cvhg7dpG+G3rl2NFTzH58aH5ErDajQlj1OsttQeO1BJNfiaqZC9VxDe5JTumZSoYjU1tnyUTqhlxnMOKE90wHkYzC6VNMzqZIlhRokRKI8XiYUjpt6c+Q/sJcNF9gmi+oecd6abH/joIn5Z517SMf1iIVJ42I5ftg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 22:50:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 22:50:38 +0000
Date:   Thu, 15 Dec 2022 14:50:34 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH 1/2] hugetlb: really allocate vma lock for all sharable
 vmas
Message-ID: <Y5ukugBX0VGz8lBQ@monkey>
References: <20221212235042.178355-1-mike.kravetz@oracle.com>
 <20221215143700.232f7ef0084167269f7068df@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215143700.232f7ef0084167269f7068df@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:303:b8::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e7bd64-c8d2-4b25-9c3f-08dadeeec8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1ge0DdfksMug88KcyvDeFu6gZNMcioiUUNVPCQgxB4s9vNe+keNCRgpLNJ0YrMVK9wPY2O/RQPe4Vv5MVAr+1TC9t+Dlnvy+DnmX13eImsyEbkXBwWueBn232xaIRcvVVoPqGzM8KZ91BzPLjkjlwUf92uoaEXj8iUrE/HhmRn/C9tl+2/lO5wjzpEtsAaLPOFDpU8tNHf3MX/3Zf/GOuqslWV0UWJOKjEytO/V7foumRmrtjmCeepPXdMBDwXR58AHkwuXewiwSzk+eObcSxXoLqyOFEYFklMD3WwEsNd8IXfz+lC/fn3VsNKma/1PczPTgDxfGiVi9hHBpK//o/IamsArXcrfS79HZSGs5S7iiYE9kwQ+2X3O7m2v/9DDcZGep2vrJf4Jg2N4HXC8ua5gsuzsbkKPwVn18YghgU8BwkDm2ewqzRQNBkjn0GwHslDeVCuEAAmiAFwN+9EKqrI788IMQHlkV0BG17sGl0WKwq3dmXvTaTqhtnzizumSHgQuq2C6PHTZeUjDwVpqziJWOstCZ3P81HlO9/dzYfm4BiGzAkZdyNdAc7fU0i+amLtmnIodM7IKCwkml3eKyX0yJU+Aiog9SjSALSu2qrsQRiL8t/G3sWnMqLA/kzNQ4+kNQ9g+roDdVtYu2LAS6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(38100700002)(4326008)(66556008)(66476007)(8676002)(66946007)(5660300002)(41300700001)(7416002)(44832011)(33716001)(478600001)(6486002)(83380400001)(316002)(54906003)(6916009)(2906002)(6506007)(53546011)(26005)(6512007)(9686003)(186003)(8936002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TKGDyPNXV9wP72+uxv63XqUVhw/IIFzgiN1beyfNcw/AXnZz5LgK9lXVclu1?=
 =?us-ascii?Q?1mHYjn3V2tzxHRXnQB6GSNeP42J81ALsAHBTFCeV8bQiOS0HXpbeHw8TMejH?=
 =?us-ascii?Q?ieSh9pBV7jbbAL3XFSvDmSAfZWEHREUSldTrn10DTFcjv1RJU7qxIpi0O83W?=
 =?us-ascii?Q?SQAjMDsKXMcxEFse7J9qU15WlSXUzqWKzMh/tBi+9+aSYcDYnZnIBd6c2KzG?=
 =?us-ascii?Q?quoH6WjhUi0+jiehWAFMqoz8vvmVAjCiVH482muLIQ0PCaBsYUIGMVMeZayV?=
 =?us-ascii?Q?sejwKrr+E2Rxg09MF93wMqKHIpbSrp6hDMhtJDRm3B8mmwC3JU59k8Vq5+Hx?=
 =?us-ascii?Q?1fdKWn7JV4Kf0Jla4Y3Q/qFK3iKKMKnJqXcAHvTCoz5yuEOl26F0EG7Pzh+E?=
 =?us-ascii?Q?iUxjYiGesTYpHUs1wMzQwnHyhRQvQmfkon3AyKl3bH5pfnvHDsGuRskGS01t?=
 =?us-ascii?Q?hx9fRr8MkvIElhitKLmVOTtDegszF+X95VeNvaidazGmqIw5Un/A6/b69C30?=
 =?us-ascii?Q?TVWClNd5grvMalFtm+9DKyHYb31SsyiqJiKBQBQKD3xHs2DaiVhMkRT9xc36?=
 =?us-ascii?Q?BSiOtcFzfjKm+yPFZIlOb2vCfypvTTN7BFi9g37kUDQXOv4kZ819ROw0anlb?=
 =?us-ascii?Q?VVR6wzC61YnCWSuoYakJ+zqBgUapO3O09QQxnxIw8/A4LpFzxlQakCnm30Gs?=
 =?us-ascii?Q?irNs9FWWzDWx/CmxEg7/YhfHfrnkKf2ryb2uOMvXjtyfNDgGsyViUyzR4OvQ?=
 =?us-ascii?Q?kOYiJwaVoHK4xPFDHp1+FkhCb36t73kOkOwN+6qmeUCcm81pbubSa4/jd2h2?=
 =?us-ascii?Q?axmncYcwYG++WbhVbm5efCnQ2KvZhJXAuWtTYAAiyJJoqdHCibmd0MUWig1g?=
 =?us-ascii?Q?b3vU1qaEUF0aZCvUBtG1sN7Yq+d6Ur5afvnY9bOapqEiP8pFKUEP9X7883Zk?=
 =?us-ascii?Q?20EqcqDgEPX5vnwuhhWfWiInMif7KDbU1DIzmZniAmgwrIy3OMyas9nENNVY?=
 =?us-ascii?Q?X5/tYmjADc4sNxdaUCWeeVAWNJQI2s6DVNzFcYlznEm2nSIjpq75/fnjFghV?=
 =?us-ascii?Q?PrDZ5PjeMP3I2a0cArHEXm4A3hChpW1qZ+hG9uCgmrK6TYfdy2H94yalpLlC?=
 =?us-ascii?Q?DkbwvvtMc1nNCXhsUZ6X8fyKIVg0U6akxjiOzL1z++G4gyw2QTbTt4yLk5/1?=
 =?us-ascii?Q?Si6sb4dB6qXcMTtASVIMg+k37EwsrwWEsTiJ0yI0w8yaN9Y5zLd/RbFCKl+c?=
 =?us-ascii?Q?hB5LN1QNyOJuPbgkBuZY10hsuidaM4WHjIhFKSixjmzZ31DNS3iD84yYl2ec?=
 =?us-ascii?Q?Jah/fv736LSx8Q7ygpE2pRcwaQCeBzhANEF+xd9apvU+CO3PrauvfB0YTpf1?=
 =?us-ascii?Q?H1XS/xygbZeW0Pqf4q+stJ1yehPaBeR3usj0jl+RXKyxWeZMum8hbQAH+N8Q?=
 =?us-ascii?Q?YEL7eJwtmXwnNpsatmFOdCcufOGm0bywyj/nLMQ5dCFwdpvxMp73/QKU3wJg?=
 =?us-ascii?Q?FDEU3oN/H0vNXvmeKBK8TrZYhBJ8bR7yy2gNWxJaeWuuTMCODg8WSI/pOl8E?=
 =?us-ascii?Q?59kp29Du18fEcJie3ycPcVjxtL5ii+zB3eNhcp5qcUpUb14SXnXEJcnA0G1h?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e7bd64-c8d2-4b25-9c3f-08dadeeec8e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:50:38.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQgQOEWkIWE995gPDQWezdqwDSwLaagZZdEuSvncErBve7n0BaLuiz9BHImcIKJnUmjt/AWAO3Ewug9Ok0UlqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=764 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150189
X-Proofpoint-GUID: bplc7xQu6k19hX3nNfu1uzUk5-mpYAWe
X-Proofpoint-ORIG-GUID: bplc7xQu6k19hX3nNfu1uzUk5-mpYAWe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 14:37, Andrew Morton wrote:
> On Mon, 12 Dec 2022 15:50:41 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > Commit bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
> > removed the pmd sharable checks in the vma lock helper routines.
> > However, it left the functional version of helper routines behind #ifdef
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE.  Therefore, the vma lock is not being
> > used for sharable vmas on architectures that do not support pmd sharing.
> > On these architectures, a potential fault/truncation race is exposed
> > that could leave pages in a hugetlb file past i_size until the file is
> > removed.
> > 
> > Move the functional vma lock helpers outside the ifdef, and remove the
> > non-functional stubs.  Since the vma lock is not just for pmd sharing,
> > rename the routine __vma_shareable_flags_pmd.
> > 
> > Fixes: bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
> 
> So I assume we want this backported to 6.1?  I added a cc:stable.
> 
> The [2/2] patch is, I think, 6.3-rc1 material?

That is correct.  Sorry, I forgot the cc:stable.
-- 
Mike Kravetz
