Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96336116D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJ1QGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJ1QFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F66171E;
        Fri, 28 Oct 2022 09:04:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEnJPb030897;
        Fri, 28 Oct 2022 16:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=KtCjfjqxNzs/1GooijZHFWRg+utlU586RLPJM6ZZOIc=;
 b=la7RlO0W1Zr8DP2SK+4KUflCzvDVhNo2NYciX1gB7Eg9e+33qWkldjt84T3cY/hsOrgJ
 RSkTAmdAW1zAJqn3t0lHaBccZ2uOUvECAJdEiWlH7PrE8YbWh0F25DSK8NZXsX8exDC6
 E5iAhUdEeeWZLx++C2xRx1vTQne5x3cN1cG64RqUGQfW6A1FdOHUS3O6zTilfNEJfLZs
 EELO5AfjdKZnyoV6ockEb+SuEPPGf+Vw1QpfuLgtQNEziTUC1uagngqCFShqb2aA5zp6
 iU8wJMW0tJi9KHvE9hp3scg9ZoKGI3FZaXNp9jQvr1ULaU85CNzYQgDZADJvO3YpmH2F uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays5k2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:04:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDiZoq011595;
        Fri, 28 Oct 2022 16:04:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags7q9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsT/SC0YaqWLRYLoUjB53q0yXMgwpbpCHoPIFzC8K/9foBrCmdImLcjbd++az9KozfhERcpOesijESDgV9frwe+QRiG3X9edl2Sdnf/52cPYA4lRJFZ/n02nHV/cUPEB9gu+4nS8iw274Ngq5gijEJ2eP29A7/d/uyFp3BVaG55KLL2ap6BOMONAAlvYfGVMyg30kgLNJMFzAZMAEwVIatbrDkUi/1W/wssMUDa+bzxuyiX17ZJlfy2c2uTWkhouGhydIyBLBl1saMerkWcYqMt7o8gUDbSaDWVaV9+gSyk+VuPH2wT5ZczMIEA9xfczxYyLKjDETdmFlrp3JroSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtCjfjqxNzs/1GooijZHFWRg+utlU586RLPJM6ZZOIc=;
 b=D2gNc7+NCTU2Go9aaSws+td/LaWFSHT6P22k6hb0PV8H3T8vo66PGdlQBzJmv/XaE7sF+HndUBe+4EfzOn5zohFSOVS7UAgA3zrnS9TNbnW/H5oXHLkplAEDMBNu5TnWh4quyXloTBXMbYGFBcwlnLzlXSReffnneIiZv0NFAAbihaSWNozZL+byQjunCzy2rVyhdy0e/d5spsAVEGp6qeoZFfRNC7Y64GjcwvG+HY4g3pVdimAnXbK4w/Mj1xklzAiwl7YSlzXB06V8qP0jOgd293AOtfLDqZx82xvMzhDuGbEpp9R9Xgv3m0qgOg5VgRWLrRIix7vmYIU6Uv23mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtCjfjqxNzs/1GooijZHFWRg+utlU586RLPJM6ZZOIc=;
 b=HTfL0AbmzXxvnuWHi7nSF8A6Xb0lerLNpgtadRhxnWZiIpk5WtomLz0UbcM6cP68Ybe9JaQerporW52VBDTH+OhZPB8jUJEQKfyH+B9SYH9l8oisNuErvCYY5ByCuvEn0xHHsL4w4MY4hqfNmDMmwPnWlnGzjMYTuJcb4ee6pX8=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:04:05 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 16:04:05 +0000
Date:   Fri, 28 Oct 2022 12:04:01 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] padata: grab parallel_data refcnt for reorder
Message-ID: <20221028160401.cccypv4euxikusiq@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-4-nstange@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083708.27138-4-nstange@suse.de>
X-ClientProxiedBy: BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18)
 To SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7f9ab2-2a97-4bf1-91ff-08dab8fe09a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlnffYBJw8yzHh5eHdt+pu1lekcCoN+iub29WTdXrg0oNbgRwne83sxuBKh+ffZVJbTSvguxApp97e2lYlY2zEatjsEUn+tVA0ASdOjTGw2kqIDmbeBlarToVl+k0YAI2MMAPTbktYRFePTJBA6g7cjoGPxHAOl/ZTBDtgeHuHCS2UkumQgNBE4DLWnA6vTouP5uAqywYZ1436JHsPPUzQnUJumFK8rDvGz1iGDHVqnkk2u90vkGnZTr/WQGIQU8FbUYrLffnpn1oTeXsQiT6YrKSmnOe9NfaH168BQFXeZVFdWqJYyvkAF5xUZxHieWJaTfkNc9a1kLLC7fEkspgp2HgS5ovw+o61MI76M2w4foigGrnqPI2vUjNoJDqwd73GmDpRomTKKGt9ZQ0Xm9roSNQhPJDk2LyKn0uXn07ibgBTWlaxvdhX3x8OIVRBBtIb4873aXquX59oq5BU/pCktXqBKfhj75wkGESErht63ob2VXRr9Qza4glOXmpzjOwVDOeJuuijU0L/M+YsHTWD6hbQzo3CPjNE38EcQpk++zwYy68u4LGrnG3Xj4gNPyka5LFpSRbi2arWocWA+Uof2a/iqY0aVYZho4QP1oZIHRrVlBN0zgUbOb1jQ7tp9sPSXQDzuFaz4Be2wl7XNynUXkypop68reZFR/9VA2EvEGrYpkc2Dgup/m+pB42QV+KY8GhmQ2BgbsKP2ROs0bOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(38100700002)(6486002)(316002)(83380400001)(6666004)(5660300002)(6916009)(54906003)(6512007)(9686003)(26005)(41300700001)(66946007)(66556008)(66476007)(8936002)(86362001)(6506007)(4326008)(8676002)(2906002)(66899015)(186003)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e73W3ArENt8LCCunAAArWqzytDVz0VPwmrKfpctM8/2+7PUH2GojnPuDoBf4?=
 =?us-ascii?Q?MDLqKoLZiIqIWyYae/4+2R1mC0KVSDtLF73gRf8Ji0SeX97KQVNHu2/SMAD7?=
 =?us-ascii?Q?stHOfPswof0o22Tv2dUPQFN7tYaKgLKw5fDYvrRR0bT8U3CrFbwyaJmCI32O?=
 =?us-ascii?Q?iuHYNlDjil7T7nQD40QcW8rBtBjgrvWkQEz3bzm7Cs3H4TR4JlGN0vJZ0KOy?=
 =?us-ascii?Q?zBAqPM/1tituMrEZoXTNE4WWwxOWXdk/FBFJA6xJk3jUpcX2B2Hi+4Dmo/0H?=
 =?us-ascii?Q?3LljQ/m9Smmp8kcaDc1In4NRk8JjMTAWQFWfvc60F9TiomXIaJcEcht1VoOp?=
 =?us-ascii?Q?nPNMAf/2wbu3hAW0ZsjqZPn/E8Phwp0qJcaz+gH+J6b38/rjLj8K5+ZK3awn?=
 =?us-ascii?Q?15ZMpB8BYb9jeRrdiwNeyxcSnLKmrB1Kp5AV8fZ1/RVdggjW1VfWaAfgGYyl?=
 =?us-ascii?Q?AuEtVtkN9CTdphblSZI1IzI8w2xA4ajeCpH3z0aMAg74ZuGBcuZxwKm1qtJ9?=
 =?us-ascii?Q?DklkmAP8YRzayDK4ubRQc4rUPwobE1L5bFMQJOFo4M0pqwVK+Q8VrDpCESTZ?=
 =?us-ascii?Q?HftK1CejvjLowLVVKOLPCzJeRRy7977hrTgAPuGyhgPwUfOEq0UQuPTCIJsQ?=
 =?us-ascii?Q?Ha3q4p0AVQx1w+H2qsnsZ79hSJBlt/j/MgTuQ6T2MZwX52/Q3FTvXcw41Jda?=
 =?us-ascii?Q?Fit/qVhPdk8VWJg+4a4OT/Ig0RI3u9K0gF6CCaPT6jXIrjThP0Fpd3cTTOMy?=
 =?us-ascii?Q?H/HMU8Y5nuV4mH2ncwe5JKBpVRN3mJgiKUUTla0TFihJJG0pHijvszzPzEUQ?=
 =?us-ascii?Q?VJmq7IUAoFoEDgkHKTUCBGW27ONSPO+7+EHzO5+a5PPzidqVPxkek86ZWK0r?=
 =?us-ascii?Q?dPFLRTZRc7+8w9eU/zyMaOGrhZesoFmFioQ7UL1hRzcW8gMeRBG0cbQ+/sHE?=
 =?us-ascii?Q?K+VADzN3P4deREttS4krKQ4nPr/DsrWYHaHxw6wAMyohi9TcDUCUl+d9BigF?=
 =?us-ascii?Q?I9qnyUasfM8EStI/Cg76mWKGpGR1sBtjJa9Wk5IOG9moEsB+J5zEi9CZe1Mj?=
 =?us-ascii?Q?vKdu7MfC8vkIFy5FyRJB8WJN54NmCfqtIevNdNyMR/Gp/5oZKUcUGtez6a5h?=
 =?us-ascii?Q?MW9GUkVlu//oPWQzq30ML8WghNUZZir40xSJ1zMbBQt8URaicj1QabSxXFfj?=
 =?us-ascii?Q?678NetZWY1Ze5kc8SB0WczNv8dXLl/daUOjAfezN6ud/mprR/qi6Mn69PHuR?=
 =?us-ascii?Q?hdiEuZ+bFu2RXhgxq1mJ0Qdgksd9EZbRWUirt+xVPKW70SF+KS1GuKE5SbTI?=
 =?us-ascii?Q?Oklw+SSLuO9e0lMlzwPPjsf4iRPjznxafwgWsceJPDwF/375iFN5ERvNhhNN?=
 =?us-ascii?Q?wHXkx55DeycO3shJIRlRwxrmHt0RW8Kzf8bxH7C9emAQ3OKsmvReuMqDhTZf?=
 =?us-ascii?Q?ctCBtSTrbZAZfugjFKa7gEfxfXaQTMAQ/fcpBjT96MtIQnRCKydCTycdKXE4?=
 =?us-ascii?Q?tZhOd5Gg+7UAUnNnqC1GvnvhXTJvbG6RjSKZs42EvJzyV3x7bc6PUuKNKqxL?=
 =?us-ascii?Q?1f/ZrXVKvsPDdLWDOzRhsSRsoqnmI1Eb5uC6GZVGgroo6sXPqC4w2xizILIL?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7f9ab2-2a97-4bf1-91ff-08dab8fe09a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:04:05.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaUJ6NUi+QFmZq8+GKwnBN9rcvR0VZvbPw4+n+Doolvyp1IvhOZBlxLJKTk8ihiZTZ0bLPeXvTc2OE6uS1XniwxuWa+5MDvAM3Q0F5oAXKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280101
X-Proofpoint-ORIG-GUID: t-2vi2I4abawqWpuR0_SuBhlgFNolXUs
X-Proofpoint-GUID: t-2vi2I4abawqWpuR0_SuBhlgFNolXUs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:37:06AM +0200, Nicolai Stange wrote:
> On entry of padata_do_serial(), the in-flight padata_priv owns a reference
> to the associated parallel_data instance.
> 
> However, as soon as the padata_priv got enqueued on the reorder list, it
> can be completed from a different context, causing the reference to get
> released in the course.
> 
> This would potentially cause UAFs from the subsequent padata_reorder()
> operations invoked from the enqueueing padata_do_serial() or from the
> reorder work.
> 
> Note that this is a purely theroretical concern, the problem has never been
> actually observed -- it would require multiple pcrypt request submissions
> racing against each other, ultimately a pcrypt instance destruction
> (DELALG) short after request completions as well as unfortunate timing.
> 
> However, for the sake of correctness, it is still worth fixing.
> 
> Make padata_do_serial() grab a reference count on the parallel_data for
> the subsequent reorder operation(s). As long as the padata_priv has not
> been enqueued, this is safe, because as mentioned above, in-flight
> pdata_privs own a reference already.
> 
> Note that padata_reorder() might schedule another padata_reorder() work
> and thus, care must be taken to not prematurely release that "reorder
> refcount" from padata_do_serial() again in case that has happened.
> Make padata_reorder() return a bool for indicating whether or not a
> reorder work has been scheduled. Let padata_do_serial() drop its refcount
> only if this is not the case. Accordingly, make the reorder work handler,
> invoke_padata_reorder(), drop it then as appropriate.
> 
> A remark on the commit chosen for the Fixes tag reference below: before
> commit bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock by using per-instance
> padata queues"), the padata_parallel lifetime had been tied to the
> padata_instance. The padata_free() resp. padata_stop() issued a
> synchronize_rcu() before padata_free_pd() from the instance destruction
> path, rendering UAFs from the padata_do_serial()=>padata_reorder()
> invocations with BHs disabled impossible AFAICS. With that, the
> padata_reorder() work remains to be considered. Before
> commit b128a3040935 ("padata: allocate workqueue internally"), the
> workqueue got destroyed (from pcrypt), hence drained, before the padata
> instance destruction, but this change moved that to after the
> padata_free_pd() invocation from __padata_free(). So, while the Fixes
> reference from below is most likely technically correct, I would still like
> to reiterate that this problem is probably hard to trigger in practice,
> even more so before commit bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock
> by using per-instance padata queues").
> 
> Fixes: b128a3040935 ("padata: allocate workqueue internally")
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  kernel/padata.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 0bf8c80dad5a..b79226727ef7 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -275,7 +275,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
>  	return padata;
>  }
>  
> -static void padata_reorder(struct parallel_data *pd)
> +static bool padata_reorder(struct parallel_data *pd)
>  {
>  	struct padata_instance *pinst = pd->ps->pinst;
>  	int cb_cpu;
> @@ -294,7 +294,7 @@ static void padata_reorder(struct parallel_data *pd)
>  	 * care for all the objects enqueued during the holdtime of the lock.
>  	 */
>  	if (!spin_trylock_bh(&pd->lock))
> -		return;
> +		return false;
>  
>  	while (1) {
>  		padata = padata_find_next(pd, true);
> @@ -331,17 +331,23 @@ static void padata_reorder(struct parallel_data *pd)
>  
>  	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
>  	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
> -		queue_work(pinst->serial_wq, &pd->reorder_work);
> +		return queue_work(pinst->serial_wq, &pd->reorder_work);
> +
> +	return false;
>  }
>  
>  static void invoke_padata_reorder(struct work_struct *work)
>  {
>  	struct parallel_data *pd;
> +	bool keep_refcnt;
>  
>  	local_bh_disable();
>  	pd = container_of(work, struct parallel_data, reorder_work);
> -	padata_reorder(pd);
> +	keep_refcnt = padata_reorder(pd);
>  	local_bh_enable();
> +
> +	if (!keep_refcnt)
> +		padata_put_pd(pd);
>  }
>  
>  static void padata_serial_worker(struct work_struct *serial_work)
> @@ -392,6 +398,15 @@ void padata_do_serial(struct padata_priv *padata)
>  	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
>  	struct padata_priv *cur;
>  
> +	/*
> +	 * The in-flight padata owns a reference on pd. However, as
> +	 * soon as it's been enqueued on the reorder list, another
> +	 * task can dequeue and complete it, thereby dropping the
> +	 * reference. Grab another reference here, it will eventually
> +	 * be released from a reorder work, if any, or below.
> +	 */
> +	padata_get_pd(pd);
> +
>  	spin_lock(&reorder->lock);
>  	/* Sort in ascending order of sequence number. */
>  	list_for_each_entry_reverse(cur, &reorder->list, list)
> @@ -407,7 +422,8 @@ void padata_do_serial(struct padata_priv *padata)
>  	 */
>  	smp_mb();
>  
> -	padata_reorder(pd);
> +	if (!padata_reorder(pd))
> +		padata_put_pd(pd);

do_serial is supposed to be called with BHs disabled and will be in
every case after a fix for a separate issue that I plan to send this
cycle.  Given that it (will soon...) always happen under RCU protection,
part of this issue could be addressed like this, which puts the expense
of dealing with this rare problem in the slow path:

diff --git a/kernel/padata.c b/kernel/padata.c
index 0bf8c80dad5a..cd6740ae6629 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1110,6 +1110,12 @@ void padata_free_shell(struct padata_shell *ps)
 	if (!ps)
 		return;
 
+	/*
+	 * Wait for all _do_serial calls to finish to avoid touching freed pd's
+	 * and ps's.
+	 */
+	synchronize_rcu();
+
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
 	padata_put_pd(rcu_dereference_protected(ps->pd, 1));

pcrypt calls padata_free_shell() when all outstanding transforms (and
thus requests, I think) have been freed/completed, so no new task can
come into padata_reorder.  synchronize_rcu() then flushes out any
remaining _reorder calls.

This doesn't deal with pending reorder_work items, but we can fix it
later in the series.

What do you think?
