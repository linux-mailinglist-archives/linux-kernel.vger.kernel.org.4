Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91960BD66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJXWaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiJXW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:29:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A9171CD2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:52:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKIhiK021690;
        Mon, 24 Oct 2022 20:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=q6V41le6HaKV814qv3BCjit96vzjU2VO+yMpgfBecZM=;
 b=FphdA/iYg38ctf5Ob0C7M1gzlD8bhcYoOmAaUrqTRlS3gIe/YKUnvrKILc/wPjZndU5+
 WS38FI2sZJB6b+FYw2AscuboCmDCla4ZImZ1SvoHZZpiztSesH6dlC+eqC492P4pCTju
 bVdve290cvx3qPsyk6dR6WnQf4sBU4KWsbH7W1Uq0fKY30BVZlvGDYBDUvcoJa/alJkI
 9/ZUuwkoi1etU/I0gb9Apqss9vMOF/FCkFo+44nl+BgnbCBYya+/VpRpb/w+jShAkD1D
 UFA0BL0RHtarjPcheJ6152DZebIfHvM1gQYnRkFIGQ0aqvnaoFh14Y1kxk0QEuz3ISJv Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9395rpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 20:50:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OJSmJV012738;
        Mon, 24 Oct 2022 20:50:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3yj9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 20:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSlMXctFr4dJL73ZFy6MTzCsk/ucOLaISxdYmJhRfnt74uyBBHTSvpAt3UlvE5xvZ+PKOUVox42plgzdtAIgO9OiNeEijvuIHmiWdtzau1FQ05cM+4PVtrYl60oWgspeaBtW/JBY/cpsnHnbFj2nqhQQju7iEPtgHpw/l/ERORPxMwrfw3YSL+aphrk/MaXTjXOxUbLvDx3XopAcm88ANpst1Xd/rwiHTFiSVeQ6Hlrkat/7R+NQ8CsqZqR4MKdLQjCJuzHpaFkTsdQw6gOO7kgnDVaUo7feTQBnft9PJJ+h8Dzbh5gNaYg6FafDynnY5OBlk7HD7/XbTg6OlGAZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6V41le6HaKV814qv3BCjit96vzjU2VO+yMpgfBecZM=;
 b=N2CHoriJho5yeo41wjzatFcrwCO67p9urU/M1+YD6nwaKMwKDkgnyRA5RmkIiw7REUhkHUaEHscaKarGCHH7AEXHlJUHK/QCArEuY89YUAmnEv0V0UYtRxghinKXns2zR6hLTS1jVPytJljLccmwXbogSISEXKok5M1YCEsheM6ht7EKuXKOAJs0LsaaVrMW80qAmriTx7yGpCafGCPdbr2L9yrIiPZgFLCdyaWvj1gtyaRMj1qDXdqfhta5KDx9tfR/HKFoH7QEayiTQSxBFK2eJfa8Ofcmdk14gvDn3kvVSq3UO7++5OP80gfJ2nfVJ0zetIHJ7RZm/VnFxawmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6V41le6HaKV814qv3BCjit96vzjU2VO+yMpgfBecZM=;
 b=c58XMmcHWq/gTTAE0envaeGFJmEprC8JIvfCXrCRChi5PezbOY/gEo4eiguFJ2OTdo0s++tYkdIjAHxf3hvoU8RVR8c3FajTRFl0N60Bb1BBbJ5PTqkUIP6QbASVdLY4ZzO2eorZHGU7o3qwg2RSgcVfgIrKkHcG0b4hdyvxkVc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 20:50:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 20:50:20 +0000
Date:   Mon, 24 Oct 2022 13:50:17 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/hugetlb: Unify clearing of RestoreReserve for private
 pages
Message-ID: <Y1b6ibUpZee/4Hed@monkey>
References: <20221020193832.776173-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020193832.776173-1-peterx@redhat.com>
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 738a9419-40e5-4366-d6ff-08dab6015d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fpm9t1bxR6Rpo8+a/ZYdsR6S05uCu9SBGdMFswH2xu3Lh4I7HU/a7KwzbSq5H1fEB1f/Lt3UbqPCTl1FEhG9Sq+Oh1Kbe0pTiRvoS1i75EeWz6khXKrJkpcUnUgHDwOApRG0R8grHti4aK/7WWznJquWfzyEJtrX4vgn5Y4SL03YO1NlcRNshPBsEaYxXSLaTi0bewm+hYqwtDCuR9ybAYG8LH2xjAadzD00IE3v+0YBxeeSx9uVNLlas0G1AKzC9l41CKHNpSyRtJzS3+O5MZSJvRxSCoajF+rwPi4XwkrAsh6IM4WcnpTVH5iCOEsKqsZA1ay6OrT/7OHQaHTTuRbvCVt6toGOsK5sXBVle9FihR+m2pGKev3AZ7DUCNl161lTNDdX6YpzaDBsFoTucjRoXWU7X0P4DIajtKV4a97uj2Ki4R49W1QRm4ZRB4Cbyno+0/UZNaom3Ru79y4OXEGOG8A3jmWVogUrEy24dofeVGhb2305PMIalPYuko3yweCskgeObapBshRuG5X5meA2BM3y7pTQufoTKQQfVWoFJpUlLuoxBWNOHcN0AvMq0r3ysjDhjEA82dJE/d/GFEyh9K4ZdsaCypBgBZCO/HCSWu7Tsr6eGcsJqVro8Anu1b1lBj8V3Dw4And+7NpwCyNUrDKlmpY8gupbGbOlRR8rdlebTGwlyRi42q2ILOemOyNcvuS3AMSQCf+w9Y1Z/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(6506007)(316002)(53546011)(9686003)(6512007)(26005)(54906003)(6916009)(44832011)(4744005)(4326008)(8676002)(66556008)(66476007)(86362001)(66946007)(41300700001)(8936002)(5660300002)(2906002)(6666004)(478600001)(6486002)(83380400001)(33716001)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hsT6/u2KhWz3s+XQQF6ucZ/x/Psbh8dB0yL5QgZSheLwh1CFjR4dgjY0LOsj?=
 =?us-ascii?Q?IcCVbDEyKfhtdN30FycyTBB0aCLqFnIUmpI3vJJ1kdtouCUfW95qR7At8ex+?=
 =?us-ascii?Q?HHAArbloksaib/RJ/RAudzFkU+jvB2v+g+aGrOLN6+ED6bfH1xAFBHdHmoGh?=
 =?us-ascii?Q?0JLIvVqGmh1uGsM/H+/bwyv40UnTblJzhpJ3zhS7buP9ayIRqhpQf2hknEzV?=
 =?us-ascii?Q?rTssSKHyJcDfiHyAVo7DBSPKzr2OYayeGHRSVVc6WyfFgKGGjerrZLYN8m0O?=
 =?us-ascii?Q?bIShsha2FZ+W7ij8EAN06jhpMtk3UqddGcPeKnlSh+cCOYhbhMhRdbZ8cJlg?=
 =?us-ascii?Q?uiUxgftoBtyk6TYn353azIMaaV4B+M47PmCz7khL0fVQdQvwdmCqku6gw5Rl?=
 =?us-ascii?Q?HlNlj5D+QtW8OaXeMXSqraAccaR9T80u2fHBa5NEi/BBf9vnpXRupuZCcjOR?=
 =?us-ascii?Q?383auBp2Ji8HjJJTffFzwhFgW3txUqeq+hVAGPgGKmxQk8jm89pwIzJH4/28?=
 =?us-ascii?Q?a4W0/amdzPeVUFbYtmJ+wK4y9ng2Y/OgBad+mL0ohEzdP3iaQrAQC+9Cqp4L?=
 =?us-ascii?Q?2rReTNVAC+mUbUKD/4kZt9s5NGvx9j2F5bUS+8ZAVQTsdTmcc0cCrqWghops?=
 =?us-ascii?Q?dGS78PK4AueyX8TRKTVLlQHAazu5JPbkk8VRzQIOO7FZ0wiQvpxh+XWif1V4?=
 =?us-ascii?Q?mOn/uyg8M0tgUs+dd6LdqiRwIpM1t42mpZ0y1pryWGWAYAMonQ0wbuHRg86a?=
 =?us-ascii?Q?5k9j/lwYeTgsMye6hVZuy/I4X0zCHmVH2TsDTAgQgVkUoLOx0Z649v/86N95?=
 =?us-ascii?Q?TjjJcgeEtYXXSNhOlB7FRbm9d4IlTbidv+iSSqVyBtb1W295D41BUn/RA46I?=
 =?us-ascii?Q?e9lC52CYQYoEu49prr9lJbv52wAyy48SzwyIU7PPL2bVOyAX7UOwQhphjFW0?=
 =?us-ascii?Q?/knHYQzkZBDYxo1Ck/c5zbkC7VonlYirsnJEtqcTpUUIhLvLS7efK7irup9j?=
 =?us-ascii?Q?WwHkjGEuJt3kDtGp4M56KH/Ti4TQHDL4qo6/btGiZUKm898FrIhqU8mZQpPk?=
 =?us-ascii?Q?zoAQ83ZPYWueePMnlNUdhgSloZYGT+mKFCcYScw4/mWGt+FbcvRWRg73ABmK?=
 =?us-ascii?Q?f8GT1lZsbbRvOus+xFEPDZWsZ2CA3fR4o1WRcIpOHk8yAh3+6iIT4EkehmDN?=
 =?us-ascii?Q?Rpo67MCbQQmRi0sdVqgsbW4+ZZiPbBDw5euoEX4FOhbrtB3vGmmoKnTBSWKL?=
 =?us-ascii?Q?v3KUtqe+lFQC+wD697csVSa1/z9JJEfvik2gsuLjTN9611I4aj8C3iuygzOR?=
 =?us-ascii?Q?6XPDjtCROmJy1+o3nDudFIqY6+URiL2sEfyciER/XYWlh6OZTcEq4KgJWRpM?=
 =?us-ascii?Q?zb7hVHp5nYMUFXOipD7M4j3cAObNpeX98lFsy6fjHW0ZZNBZdfTo7ugd7Hko?=
 =?us-ascii?Q?noU2NUu5f1oF+PaFOqjdLHlhI0X7l0hc86FU/7HttAU3R7rbXG5i/fLnVtsQ?=
 =?us-ascii?Q?i3Z4Yj1grzIvbqGkAmgYxTz+/75hlTrptz00g1CFRExoRzJCSj7HFdHs5u/O?=
 =?us-ascii?Q?+d2Gakhi8CLEq3YH4DxAYcZ+dvSXxvJIDq0cT1jdcSsP7BJmMGGFi3jIKAuz?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738a9419-40e5-4366-d6ff-08dab6015d32
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:50:20.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd402f+vAG7GKPMv7XH0p5gPC8laF2L/mUISRc4m9wDAgcAU787hEnkH1pwRF5yGbd3999S31SN2V8gienJu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240125
X-Proofpoint-GUID: Q7Hf_Eps9iAbFlU8Ga8wikAHWo-SZkPz
X-Proofpoint-ORIG-GUID: Q7Hf_Eps9iAbFlU8Ga8wikAHWo-SZkPz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 15:38, Peter Xu wrote:
> A trivial cleanup to move clearing of RestoreReserve into adding anon rmap
> of private hugetlb mappings.  It matches with the shared mappings where we
> only clear the bit when adding into page cache, rather than spreading it
> around the code paths.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 14 ++++----------
>  mm/rmap.c    |  2 +-
>  2 files changed, 5 insertions(+), 11 deletions(-)

Thanks Peter!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
