Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A629613B07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJaQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJaQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:13:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F758FAE8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:13:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFAir6029810;
        Mon, 31 Oct 2022 16:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hHYFOl3CddOL87XPiA1tVUk18xJe1FDCLgniNWx7PCQ=;
 b=NveFqGoZu4T4ZLae6hELGD5E/yhlHzs06zJwKHpOg93cqn8tkn2Bw3LxIh9NRTpTmkRE
 7JfxrkD+e5/aBraDYm/uBZE0oJIO5PGIgl6cJp04gWY8xpI83eeHl/Qo3N4YilDo9qyq
 N3LF6i8dxXiRLG0+UxKoe4n1fypppXTD5C3dFX11931VmcGunml4dZAy35XvoGHPQnFo
 mbzEWiDJ4H+TER46919eXQ6avy1KadzqC7419nzX4MIXr9S0RsIrdDazaVCoqUCTzLKb
 LsK3O+l4+MsT411WUhu6vbyGQcQNXyJefk/3sTwv3dKkvZCU4aIxO4ivG03OnGzabqrG kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd459t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:13:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFAwIE011311;
        Mon, 31 Oct 2022 16:13:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3fs7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWk1wWbpBujU9M3UEn3Pgb1FKubGlamggA0L0Nc4eFzOzYB2MPJvXU5jEyGt/9zKGXAGIXOzpZ9A/Yceke+3uD91GFUst8SCri9mhvNYNns9V+A75HvYn+m6YJsofpiXD/KjLkTxlnSj99pCOQ8COOZnUFroryJfNWohHJWG60LbCmzgy1osfl+na1SIBO1nbVNBCYbbp2KBaTxP9CGdGocEh5IJYJjIM6tJO2cs0DvxosGTf+pKH286AoiFzq76IXZq91I458daIgTrs2u1HxDY5lJArZv+NuP0D3TGMub/3W4m3BFHGWSXfmCkCt2pVoaJmfYgNTomYT5hiIPXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHYFOl3CddOL87XPiA1tVUk18xJe1FDCLgniNWx7PCQ=;
 b=YTHtMv2nJUGaVuyHHpnORZ5Ku7pX3kjyyzo9HX+ylqiHWTuYIBwdnGUBIFogJCkOFsjATwF0Tvp6xSACzWHj83osCYW8xomIYMra9I2SF7iNtotOVxkVqKTn/Ycdg8kTqJEm9QI1p6nAq2pHx5xgG5TRd1qwIW1alEgSuxJtOSziYVnVQ0dJM6hsgxzuuvWzSazrRQh0KuSLRNhsT2eV2WkAIc60sNZy3/+UUNq0CCuF9O4vmkqqTuBa5zbcfyYpmTWyjTRBWTMHylO1q6cCVvRL3a6Bye2T1TrbBAdWNS7kx4fjBySNrck+G8zsn2uiQcULnntoaSRoc9H5hkPzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHYFOl3CddOL87XPiA1tVUk18xJe1FDCLgniNWx7PCQ=;
 b=DW7A0P5NuY3ojhpOqZ4Y/vEzVx9pOa8JvQs9vKLmsoyQAJwI5yMCY9Te6etuBFpD572LPXw5o1Jy6zDlNPPjZ4q43XxnDLNU3R7IMiusCJAZEeznkGVzq5SiKaxkrdVCXJMmD4cX/PsoP8UqX5ghv+427AOsn2kljIkRIX+NwS4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:13:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 16:13:26 +0000
Date:   Mon, 31 Oct 2022 09:13:20 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 2/9] mm/hugetlb_cgroup: convert
 hugetlb_cgroup_from_page() to folios
Message-ID: <Y1/0IOuAyu12/C9o@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0fe6a7-f9ff-4c58-9594-08dabb5ad73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krP6FGGyCCA3Zz2Nf6OdwlUIQuTXVUgBv18fo58OQhZ0UwSoWeNUC+00BuxN7j1XmLlpuxBtndyXnDThBM9udtrLThbLKzUVzoGFZpk3UJv5xiL1Xv5blWEIi/p8qoGO14S3oHuz1vby4JpJtro1KBKrqug/HPY1MNny8rL/C2uT1C38D0vjFZaFqZER46bVooXHC4KkjksVXre/OedgYHqewV3L3unLN1toyLAqqi6obcmbqxZZRVUkETRPEA/zIxtEL0p8shwhz/Usehv597S6pVIOto1H6kPnSYNAAwf3ql0uoyey59Ut7KxlfSfX8p6vA4dxOXsQHoPXMzKCqViSII36+KSjw54uH4jj+46UTlFmbJ+h+4X87VTQUqH129emChvDtR4hLtO/S4JSyUqJpKqZR2y3a8t4IHdJsTf/Qfvhtrm395e6OVkRllIyXr0SH4UlnXMczBoMg7pzAjSuIUdxFMPu7dhxhbZ67wtk11CizcATNdtEwO3K4erYpuGQF4ZKqGqhDqjk7oWzPQV8P/HgAyFZqrETAZThzOFELv2LAo35/xupry+FwPKUMzYA2Q7QZmFeKTi2cXYFLBD19VHQHrkpgfRc/zqUvtiIwrXK+hSdNR4USmoLohLAmAZ4OI7X1nwndGLvH6zA72q/HlJLFlxoExtgkHHHoA7f3pXSnjJyOUQbKTkQ/Bvtgigp/hWp0frcw5FoXVmUng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(6512007)(6506007)(26005)(6486002)(53546011)(6666004)(478600001)(9686003)(6636002)(316002)(38100700002)(86362001)(186003)(83380400001)(33716001)(66556008)(66476007)(41300700001)(5660300002)(8676002)(66946007)(2906002)(4326008)(6862004)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cumE7wxg+fV77fdN9X/4tQDcABEMAwsRbykXk73nqtZrfxfnt5EHaZFA/p6k?=
 =?us-ascii?Q?KtA3BWY7k1Qe/eiT1gF8mHVe+E1z39OR8Vpjh3eC1qPDn/Oaq/hhGHqTc1mk?=
 =?us-ascii?Q?udn7oH0SVn8icj8P3qc1dJxyedr2vt+twBfr0x1+M3SnygzgXWD3ueg5EON6?=
 =?us-ascii?Q?sY+hjI5S7qQQTFB3/Mg/z+zTL57HtzhVbqSdq6bHpLKJHt/Fo5W9/y4NtAPl?=
 =?us-ascii?Q?CvhPqocoxV9D3109dJErUvLCS3dpF23xcZml7TNGmlHqsXMYvYXLUVZUnQNY?=
 =?us-ascii?Q?gnBTQkP2KJzeFR0hC7CWHvn/dzLvXVMNXuNYdQLXkHKTYlX2La/TK2Xm5kO/?=
 =?us-ascii?Q?uwalloH5yQKVG75d7GVUufMxp8utUxxzVbYEvkXhMi29iy+No8JV6Z4myf/s?=
 =?us-ascii?Q?85MHO4nN72sj1lOfi1gBzt7s8DiryNjLdMIaY4o9+p5adNGh/vwOXOfpwM9e?=
 =?us-ascii?Q?wSI8020neAyEFZrGkr9Q/PQSn2o6StSZ9X7qAWxLsOFeNz9lK9DofWqHygsE?=
 =?us-ascii?Q?/YFO49yEBa4aZjaueybblznMFmmL/i7J03fLxzrIL8mF4u72hWQRKSJuqieQ?=
 =?us-ascii?Q?AIru2VXQJwH1UnuPWxnbiBUlcMPowBk/fxRQK90Ry9Z2bhxB/eD5XrfLMX3H?=
 =?us-ascii?Q?Vn5gcfM3YFobZFQ8OriVxByGEwLHtS2kdn9vk0hlrZO/Q3FaRX9C5wAusbOg?=
 =?us-ascii?Q?1vLbMNkOhTxcMKaF6mkeJgjhGDSKn50PdGn7HwXPFbLFcryLZrZank+dMSh3?=
 =?us-ascii?Q?Z4VexKHPjxaYjUnKgPAXn5pJVYLxItAJTer9lwD/I0WoAw/i5vN1vS2d8yl9?=
 =?us-ascii?Q?EXYDAIipIJahefhck/S3riHZO6jWFVwflsrZQgSZo6VJO5dBgVsYLZzv706/?=
 =?us-ascii?Q?d7Tf0SZMOD93cF53TXo9ITQS+7yhNlZMgDCB1ZXLfkJqT5edhHBy1/+JtzVx?=
 =?us-ascii?Q?aLh2EsmU7/CxlG8DL+PCGeT1SFeD+E4mDurjm8SA+3psGoMUuOFMPAazmTXz?=
 =?us-ascii?Q?vmuGXlr6TxUTMhPQGmresvFLiFCKVRDTwFfKRIcKJJxqxRvl6QTZHbW31jeY?=
 =?us-ascii?Q?EY0mjAOWH277izHi9yud+32GireCZZCzPGzAI2nOW0eX55+prmUMzfdbU7Zz?=
 =?us-ascii?Q?DMFTPzh12nhax7U1YGrfikR8qve4GsyIhE+9NsOqp4yKWa3SlpCBsUFQjxCD?=
 =?us-ascii?Q?1BTw293selDR6/s0XXzh/Bz8BC+vYuqx90C0DGu2//7E7NBtXZEGaE/mXT+G?=
 =?us-ascii?Q?vr3p/O3J44iQL+xtVKE6vImMW8+ENnf+9sTFQPqJO3+y7pE+BUv5w1VfBnBw?=
 =?us-ascii?Q?o1pMpKnhy1wXqYhfEJ3yE3IuP4LJR9tn/g8kaPC342EtevSw3I5B+x7fbYnc?=
 =?us-ascii?Q?qAchAogaB3PqG0SsyhxttnGGrIg2CsYAIgT00vnZ8JGypILm+TLgXpEl9f5N?=
 =?us-ascii?Q?xzW5qlC5vxSBMrRnDjOFwagC/quMoc6fHJFlu9qkxgpglfP/ifQWFUcGRS9g?=
 =?us-ascii?Q?Dap+yrqMjgedsp4ZO7qntm/GtVSVQ3TDdHF3a0RTi4dkYP0JnBFsdHSFxCST?=
 =?us-ascii?Q?Nei67cZCX1axglULsoyLVWZ65uZ1H6o3gNh8t+zA3KuTyS00G+8bJ21mOS/T?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0fe6a7-f9ff-4c58-9594-08dabb5ad73f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:13:26.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bytXoFefJmE80vuX4u3q50A5OJLEhZ6cAR/JdLZNlRmrcbe1QHHZJ0JIUcz0ffE5aCJeYd3eBKujjd+2/2rfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310102
X-Proofpoint-ORIG-GUID: QRM8VhK_8cdpz7WHhwQixroxLtkxl4JU
X-Proofpoint-GUID: QRM8VhK_8cdpz7WHhwQixroxLtkxl4JU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:12, Sidhartha Kumar wrote:
> Introduce folios in __remove_hugetlb_page() by converting
> hugetlb_cgroup_from_page() to use folios.
> 
> Also gets rid of unsed hugetlb_cgroup_from_page_resv() function.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h | 39 +++++++++++++++++-----------------
>  mm/hugetlb.c                   |  5 +++--
>  mm/hugetlb_cgroup.c            | 13 +++++++-----
>  3 files changed, 31 insertions(+), 26 deletions(-)

Changes look fine.  However ...

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4133ffbbeb50..bcb9bfce32ee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1434,9 +1434,10 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
>  							bool demote)
>  {
>  	int nid = page_to_nid(page);
> +	struct folio *folio = page_folio(page);
>  
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
> +	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>  
>  	lockdep_assert_held(&hugetlb_lock);
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

... there is also this a little further in the routine.  

	if (HPageFreed(page)) {

Should probably change this to?

	if (folio_test_hugetlb_freed(folio)) {

Or, is that part of a planned subsequent change?
-- 
Mike Kravetz
