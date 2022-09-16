Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C85BB3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIPVKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIPVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:10:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4940BD7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:10:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GJY9R1010929;
        Fri, 16 Sep 2022 21:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PckLGN+L0U61eanK8s+w8vsapB9FntL/q4u2D7lxGgg=;
 b=kKw0GuwBAGCVOVcj1yvp7ekGWvgcBqXgGv0OFpyJM9Ek780aHfJC24JyFZFNShC1fg1m
 QOBBXerSwBbiB3r58U8n8uQs2JeCiU/CwHSzkfh+2Ag5IKiX3rik1X9kObXQRDL3cFPP
 Zutgte1TZucWLOzbOUYB1FIMkIfbh8FY09dYYJHAt8T4iT0GxOgNtOb6u0ZbMwbrKcPT
 ZDswtAjaug8PfnYgWOmcCruy4CE9aFnYt0oKsAEPwm+2guLwps5T/wFNWvsQMeTSzYzP
 xeAVmzwgXId75yS9tL1nWma3XVT7tgz6ABbmSSBXbiD6EsvtLuKuLbBmijxfocwcXPOx jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xcbkns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 21:10:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GJ64kl033779;
        Fri, 16 Sep 2022 21:10:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xgmkxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 21:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/8Wakd04i0O9VqN7tuzpgvz2WgDz0AgKCpCuaoT7mxqd2J+MrEuOX2XdSbI3NuB5+96tHBcWC1Sw3RO3WTFNd+3bBGMwQuLooQgstOoLLCHr5KdQnFnArtvhcaEJ/G1IFZtdl8XYUsur2PnSh/vJatzRySCGg2+i7/NsOIqhZMUR61oshwIUom/UtyOKWku4VCiLv8CrImuMKyIUoN1nMA0i1NZUwuT1PMXg8SItouPMcZedA4ptCHDcKLTocUPkq7JcyVO6GjB5qgZSlMMUZEFASOc8N1VIiHRamdYWM2YTkGPJCtN46mXYnpPDn3bXVmNXohuWJk00fO/DYeBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PckLGN+L0U61eanK8s+w8vsapB9FntL/q4u2D7lxGgg=;
 b=Puk1nT3Rc4c0vFNAgEmw43vxChgbsf9ECpR6v+fjd7ogqC8z2IPeHxPZFQhFVwvdhKEE7JJQdqMHQP1fX6fH0ti92RjR6zZW4yVaeF3ee/pbt92tkNyUpeYQegMjWluDcGNWcvPxa+qHH/ZsBRXmROfLJP21Bo45+2LD2eaEFVK6nsgrn/42Fvpyr+kdcOJ19SDGtqBPwgxMIy+IB80G0kgOfztFKfUNyUKnSRcmlaGhcCSLlYe4f3qbaJUmBO23KhgxKNsM9TtEYIczAEmFiV0iRwLvvGZzuGM6xz2ygPwZNF9h97utQ4n31+tXPRBloWL7rpiXOe6zENUZOJOFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PckLGN+L0U61eanK8s+w8vsapB9FntL/q4u2D7lxGgg=;
 b=H3DfR7e+Shhlcrlilvrtd6fvs7DX103/hlXlblAgn4mQtCnZIAX+QytXM40GsFi332BBHbIpi1+9Gd9GybnUMqcwpzw+bbt2OBFfzbQ7yihANIIxr+TRebaG2rVvTM+KsUe4nVZ00JJQvNydrBNU7GU/pwQvpAv4m51Q6/qmD4k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5369.namprd10.prod.outlook.com (2603:10b6:610:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 21:10:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 21:10:00 +0000
Date:   Fri, 16 Sep 2022 14:09:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/hugetlb: add is_resv_equal_free() func
Message-ID: <YyTmJUsKqAPVk6BH@monkey>
References: <20220916064127.1904-1-xhao@linux.alibaba.com>
 <20220916131249.68d59133cdb0366e0831592b@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916131249.68d59133cdb0366e0831592b@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801e01c-2ebf-414a-d200-08da9827d0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDt2Me/R0KumeqNP7AtOg90b4aJb+vgkICuJWfi9H7AoAMIKL+A74QksrTRBDrqLcVFT8nPLtn5RnrMUvd1wgSmBI6bfMC+2d/Bs3mpAbjRNYzhq204xB77TsgM0cxXuywg8GGTKmcSp/gTzCBvKzmIXBoMTG22JkXpf2rOhq8/WDCxc0WE3/aG10DCm8hSKrmvtQeMKbvcjvyOS+Ns8kyJsyaL6aQIL4vymprl4akpu8guaq+EwlBPwQ6ooqq3ZdPWtpZ+IFmDHYRuPmzibjai0/lRYOSN1D45wWi5eJiXU+MiC6UAamQ/fZ4zLdqSTR0Zg8fXkuy7RgjsO+snWPqEvjUAE0KUh7lxUnPyPjDsw4RSSEIUwLne6yHUpuZtEpTTOVdxPsxCe77PHAOig/HOBSX0S646jvWkjGEFu41xWz34e293vCWGpdGoDMhohssm0TNl02ImomNYuo9ubxC6XRnN+YM6lAG7rLlGFnghnVRF4jWq6HVmJCcwfl+22DF0nI2a+NFJ+WGW3dP1wM6FRineypm3aGIsBDvEfhqU+eNGCugAg37spjYXiYmZfapDEZhRsPDk3ugQbpykv4bZmh2N69WZrtEwaV8kxNGbBzyJ3U+z+8svZ+BxPaflRosibCirrihNwgAlIdVcip6faGrEImuovW877s2+tRZBSJTl4e9Ate6xND33DccY/UI/uPKkNHFNEP0uztFoN4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(5660300002)(6666004)(478600001)(6506007)(8676002)(9686003)(186003)(4326008)(66946007)(26005)(6512007)(53546011)(33716001)(86362001)(44832011)(2906002)(6916009)(66556008)(6486002)(41300700001)(38100700002)(316002)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6cEa77SfdMP4pu6kuqHPF4B9sndvlqU3SjUUqDebr8TfCtR6I6xLGmBJ1gz?=
 =?us-ascii?Q?YQk/p9D1QZUVCzvNbEiJ7urza/GzY1q/DohoufzhspO+WKHSU6xLgYQEm0LU?=
 =?us-ascii?Q?K7QR4a1Ja8QVKU3H4+fLoyxBRhfzU2qv8TDQ7QPuyPHXwR5vWZUVAOkD7gZP?=
 =?us-ascii?Q?QcihVMwbr8Ry92Nx+gmAXPFJR6jltvsgjFBH7m8LqUtybPKufzWahhV4yuDp?=
 =?us-ascii?Q?xtQnJV+sYsMvYxFehHDHLThjrfWAq2IH9QjkKiTViGyD1HEFoEwio/1wHcuv?=
 =?us-ascii?Q?LACv2Lw92kgDi+IRbjAzYZukQZie5j6t8lpK7sE9Wf0ETUakYwA/5nZn4Wo6?=
 =?us-ascii?Q?ncXH4dvJzKa2IPSNmofYjlbvR89qhakTgkv2Gzn9/MRN/HbBQHcFOPH4vCyy?=
 =?us-ascii?Q?N8Ky86K/GsVwcL6hQrPFuAzZpLwlLVhqrtWNOBN6RRwWRQIJBC9IUKIJzZ1L?=
 =?us-ascii?Q?bE+d1WXioB6kQ1f66itHlEC48fiGH+hGKypEqG2zLnUiebWO/t9qIjMHonPs?=
 =?us-ascii?Q?kKBZKGyhD+5o9nkaE0ppaKdxO5BNbdFX9EPHEqksaTuuRncn0ANcWWTxx3+Y?=
 =?us-ascii?Q?dYs0saMupYMQ2H6KXnx2SbUesoDWgq/ogiLJu9fb6F+fg7/xcyNrPd8JFcDK?=
 =?us-ascii?Q?XIAZVQuFhdns4fa2VoZjL0bQL0kl5wQstf/9+MkGIy7h85JNvcNyeBMsHzeQ?=
 =?us-ascii?Q?gO7yNOmNRgYgtH2glST2Z/7/lZpm1o8BQY/zA1rWbxvmmLY9XXMVM1AWOuCn?=
 =?us-ascii?Q?+EHeV8j/1yA18QwtZ8JwewJNOfbCFJ4sehoCEtdHqJ9ft6BkAyxdh7P6pFeI?=
 =?us-ascii?Q?O/0ot877VFd4WeG54hDVRopI7KU+EHqURrMc/DodBzS3zLdkEv46A6s601UW?=
 =?us-ascii?Q?XI7CHW0gx1q3qzdNw21YDlUEXEKfKTp98wJ7YNz0D1EcZL5wGh30a/LHeNi4?=
 =?us-ascii?Q?pWcvXLwg0NG64D7SJEx9Hw4NZKqMSyK5SCum88tc/caFr/Kzch4rAX0O05L0?=
 =?us-ascii?Q?kdJKK3TthhWvO+FEMk7/dwLHuuzQuZPG0HPaAcLEB5P7Co4cB1bKYiKUkk5Q?=
 =?us-ascii?Q?Pnr7AV/pi6KLCEuy0xkIQIheDSeqT8v0ybGLu1gvtx+z3xaEmJ2NHyIR/vi/?=
 =?us-ascii?Q?qPAVNgovJVIyqTSHiPqM7rdBuBYmF9njDPX6LF2AkWpeuaFOxFyU0sEu8Nv7?=
 =?us-ascii?Q?U4t8WtyIlGkGk9o4Qd2Rsz0hLR51fdFgz++ZnAgQqOyt7/6gx5cGykMAV2J7?=
 =?us-ascii?Q?6nq8COLgxPrKoAUDHMEV6X+Cm2ATai0MJ5ShqzLQGxP7PRbjVHQO587Atekk?=
 =?us-ascii?Q?Xk8APZVBqTwoZTvfDAF5b8jalOfBDLBmwtn2DdKAq+KD8ZYnakiuXwnsAErz?=
 =?us-ascii?Q?JvXx+aQZ+fh2zl0fWWCCTFscYZDE1sWrNfseCVVaNXtYaT7IU1Sb52MzmqmB?=
 =?us-ascii?Q?unxdPAWYYrWWGsw/lKNQyt4hzbgTNeVRrbXxPzMxNkzmz20BrYjmmKi4dUS7?=
 =?us-ascii?Q?iC68CbAgVS7T5PJLRA+ZTZyKQ/HUIU9KFgLNNCN6oRiTqzi/4IGWnBq7dYpE?=
 =?us-ascii?Q?VqNV/a1gTCVOVpfETud8RiWHc28z1l+1CKk3ezwmUS2Rvyzt+xML4/YOmFgo?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801e01c-2ebf-414a-d200-08da9827d0ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 21:10:00.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzYRgBIG+0uWOVHigSMII8rBJt2UhEh0ef+9xWnJrgSJyGzpwdtn/Z8UvEidrZuMYpTv2EC8KTtmPf5Cdj49yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_14,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=890 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160151
X-Proofpoint-ORIG-GUID: aEh9je0K3uQ40LgNe_42jLnfUVxvmgSB
X-Proofpoint-GUID: aEh9je0K3uQ40LgNe_42jLnfUVxvmgSB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16/22 13:12, Andrew Morton wrote:
> On Fri, 16 Sep 2022 14:41:27 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > In hugetlb.c file, there are several places to compare the values of
> > 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> > there add a new is_resv_equal_free() func to do these.
> > 
> > ...
> >
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
> >  	return NULL;
> >  }
> > 
> > +static inline bool is_resv_equal_free(struct hstate *h)
> 
> I'm not sure that's a well chosen name.  A better name would reflect
> the *meaning* of free_huge_pages being equal to resv_huge_pages.  Maybe
> something like reserves_exhausted()?

How about calling it free_non_reserved_huge_pages() and returning the actual
value (h->free_huge_pages - h->resv_huge_pages)?

Perhaps available_huge_pages()?

It could then be used in at least one other place
- if (h->free_huge_pages - h->resv_huge_pages > 0)

> This would all be clearer if we'd bothered to document the fields of
> struct hstate :(

Agree, and discussed elsewhwere some may even be able to be eliminated.  I can
add that to my todo list.
-- 
Mike Kravetz

> 
> 
> > +{
> > +	return (h->free_huge_pages - h->resv_huge_pages == 0) ? true : false;
> 
> 	return h->free_huge_pages == h->resv_huge_pages;
> 
> > +}
> 
