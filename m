Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61046114BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJ1OhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1Ogj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:36:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA51EEF06;
        Fri, 28 Oct 2022 07:36:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNmjg030079;
        Fri, 28 Oct 2022 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sV4SylSlTHUJteS44g39u1YD0HZNa+BU2VAvkRMGvTg=;
 b=cHSO5wEcXZy653nNhll+srR6cmNWEk0oOzJypzYflZvYnyY6N4Ja+J/Hddv3MU9Z4fj/
 WB2DV9zPDpcnPwxU4nPqCZvSVCDOJn8tupWaULqyVjVqOVjhyhb1xxhFH2Z7B8EASb1D
 opj3yN9y6/DwNXp1Yoi+5Z9tytt7gnsl4scZGc/KeZg5MBncc0g/8lCX6sm1Qs5i7gV4
 gtSCr+2EEaSESmIeM+UfXCRLW+6l8na6NBLJbZU6VQtG79YeKqE3l/IknY8nEeOo406X
 Nk2/kZQdm1pIWDJj3vtX9+EdDLVDTFbd3cLNuEqy1iBTB7Is/y02/WRCojZdBBfDiuu7 dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv5a63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:35:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBIlUT017605;
        Fri, 28 Oct 2022 14:35:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghmmxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8YF6fDGx6uKOm3fxoV5xUl3QNA5+UCSEpuu2WNzFxNb5TRKsKp8fVEOiH1yIxcmT8P0Bb9NrVMoKHZWalD+Ozl9AtnmrYy2NKl3rubg3EZGlMl6kfqW4cKA3MDI3abD2BRyFR45kPdl6Kds0rsE8l7N6wqnaVpD4aOamRe8ofQ9FROuJgaATudTDDl3SZmJIy1UqUwNdhPym/aA0g6OoHZE4HKfR999rspePDoIMRDvE2hodFwS6cWFReoskl36qJozOnYaotzROY0uZ1ARJaUjdh46SnZUfs+yAtw62HXJHZa2GIkokXQvTT7yz1Tl9qCt9zyhHbd+ddi3S+7KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV4SylSlTHUJteS44g39u1YD0HZNa+BU2VAvkRMGvTg=;
 b=Cu+a3HrnteFtJtalYCoMWSKQ10DnW0xJOPIleauqLCyF0TooJowVKNiYTyvU9gwodG8HKLC7/GsAWFi6z+yQM9tgheb6xKEvXd3VlGYh4mKU0k/jhydmS5nICTe/kRo0UiRhgCYBCzUcv+6J+EHHmsww4sYuU/vS1qcpgHfw3pz66RSp2eHWTsSR9RSnSAzMs/wVOdoC2/ep11Gajj0fEK2CUxfOLNPTGRvKfBE8PBc7bFxPEs/DmpS+PsN0awicFqyXrL/T3HcOp7Mo0YdeCB09LYWJv/33sGL2yu4+lXuh1JxpdvVfPSaTrKErcTKjIpvGiNAHDdhyxUm7aBAvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV4SylSlTHUJteS44g39u1YD0HZNa+BU2VAvkRMGvTg=;
 b=YQx5FolUWO2G04h6H5mUe1TA4PZSgLTdwczjAOtT82GLMVZpEUl2769UmjmIoP5KNclxHWZPKhiBMknyQ6ugy+KTDCsUtgArmPfJOb4UhGz4fFqG8VkWZpQCV75RVLegixWcrpIrnpTFCqOSrV9lwwCCxHTdgWGmrbmiK0Su2I8=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:35:49 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 14:35:49 +0000
Date:   Fri, 28 Oct 2022 10:35:46 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] padata: make padata_free_shell() to respect pd's
 ->refcnt
Message-ID: <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-3-nstange@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083708.27138-3-nstange@suse.de>
X-ClientProxiedBy: MN2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:208:a8::33) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7de3f9-4456-49f9-e622-08dab8f1b50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RLh4KStLg7lwR5bkYRyEEEmx7WwMlPckLZ3BUtDkcWShs07YqdgWSb0bb1Bj0x0EAUSIQpbS9hRnJ3AbWqLeIJi4al41gZBgk7X28u8C+/Rmw8iAnzHc0OaSPp+nlj6kk4eFLvb2hlGQxxvHi8+z/OzjH8PxR7y5DD6oxxLbiADR7CiJBpRnWyXKNxfYzbIbi7XSqY1bjQSKIciYWShQ4AtpyDSQoVM6lnhkNq+0qUQDTsh5bXhxFARicP9WfLSqylHCsffBucig9FIR3mbK8ea9vWzRgjjAX5+yXAP0ESkG97MampnS2o7MXvpQNOTJlHFZTFxx4Xxn/87VEnTd8sPB4stTHIMYbYTMLXqV56LD+Or7H7vfMYX9AA6GdefNbO2FLJUZ/DwD8pVQve07vpTO8Du1pwtcGrBG+FM+QTiR+H91KbkT5aqmMu/vEi73+DPrhpnuXCruaHzqOH+BmtPSDntofNv09z7N9AkwsLS8tJsDEvkBIzqyMxoSsZ80hObt/c/LmMJACnUpcyLdonPZ6UdagV2CB8iam4UTCjgBCpt5s02i0mMsKVAVVD0WUKS8bkrRM9WVfNCp4cxxhmQYIJ+viPz81/aCIlzypbyqsWgsqufORbaZ35LxMLk/+QfEx+nvMW0lzi0oSEnSQLgpP6DdKthVGll08TZEMTus4f7SO/AAjU4uNmUUoNXWamwWiJoWwvr+2yh4yffig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(54906003)(6486002)(6916009)(4326008)(41300700001)(8676002)(5660300002)(478600001)(2906002)(8936002)(66556008)(316002)(26005)(66476007)(66946007)(83380400001)(38100700002)(6506007)(186003)(6666004)(9686003)(6512007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3m6DnMDq8cuV6sBcrxDKB6wDGh2dgqcEl33H8nqeFmTthb3tVCr87bmuTs6z?=
 =?us-ascii?Q?/+hefw4XBEUOs8t9keR2xNbhJxH40F70eaCJVlNPpuzg2dmlRe5w6LlG5EFc?=
 =?us-ascii?Q?wqsqrlBbyIPlBjL3qtVPn0HE+TzQW48TmvU+nVjwazOA9cdoutfgErbe7WhB?=
 =?us-ascii?Q?bRIJvMdPYxHV+pRvIMG+g8LrOAYQyneqAdFKZshPCyakKb0WXMoF5wh5xIUF?=
 =?us-ascii?Q?OFiLMZKf6VKv3J4X4Cbwzp2SVOST6mAsP2FAOJWCfIiUhEs+hW8gU+LaqTuN?=
 =?us-ascii?Q?njl5cyPxFoV1qLnp3dj70QceniRsR71faGde06KD7agwDqIv+yq6LpdVOCLU?=
 =?us-ascii?Q?Bq1d6/U9RbEz6hXO3mcFE9Dz/QQZJ0cywX83ivrXX2I6ClJbnIcT5ALcsUWy?=
 =?us-ascii?Q?7F9ZEKVz5azsUcFyuDNf/Oym2lSSs4R2Olm23NVXGePXyJtR6513WbKJQuRv?=
 =?us-ascii?Q?QxfpodSeIyP/g1lKUn76EsWBvcP+yAwWf/71kbiegQLbt3O9EBxM6tyxNM9z?=
 =?us-ascii?Q?bkYbtWZGflg5mytYUwG1OIKTbxyfe/UlQzo04D480N2c3yi+Fr+NXEVddKrh?=
 =?us-ascii?Q?z1L7sy3y2cy5VFyqHV78hwrAb6b+wSSQTlOG5esk3SStTC+9eeY5Heux1K20?=
 =?us-ascii?Q?ey7/vK9YDRqPBz9nCx/rZUL7Q8QR9/whgJOvzsGYFZDtu1MuHFv19cqYKsMo?=
 =?us-ascii?Q?bvEf9i9BZUDHolv+WMidhRp7k5fyuBSku9OG2IVyfTvqQWY488aoKMDp0cK6?=
 =?us-ascii?Q?sp4tVqYrgSpW+tL784eTFaeZntnwedmKOlChSdJuWb0gjsasBN9uaTDzTO9o?=
 =?us-ascii?Q?589kkLoN6Ya3VqMbAnIiLtlq7oFQ3KEYwPntWuQbwGPQd9jnLamCMrZR9O6k?=
 =?us-ascii?Q?VFTP//TfwcgRh9Ngooz1bZC8AysQSEkSXomqjvxY2YLIRVzJQ8LIldgF8bFg?=
 =?us-ascii?Q?7ltq25u1rGsBdHaBEw9v2DfqqyfP5CZZCZS3kccjh/3N+Zq5xqcjSKZyXPUo?=
 =?us-ascii?Q?6JwvhDiamzaO+2l0kREvtjj/rTNy797c/R5zRBdqy/xWdVfVfiIIvc/f3ncQ?=
 =?us-ascii?Q?MnF1HgjjnGiPh5PIsicQF3yj006MbgqhJDCy8aXIxLh/JycGoGwVZXTV7drW?=
 =?us-ascii?Q?IXQ6NK0xJxnWcnY9kbzGGs+mq41Jq0nPbrF7zPDhGXKvEKBl436J/bF8TPC2?=
 =?us-ascii?Q?/qKx/0bgCB6gh+PkzgioOlZmZsiZxvMGRYgiI7iAu9CVcXafNuAJhtIe9V2+?=
 =?us-ascii?Q?Ro++rdx2QvFPLqlvgf4yyMbbEtC8tMJEc/9VwxEaKUjjDyn742WgbWprFxu5?=
 =?us-ascii?Q?Mi45hn7oM9sY9GqiMMTl8IGsPNftdlqEG/bLFW8hD/A+AJn4qRVEIbCR4WMw?=
 =?us-ascii?Q?7fm2HsBaHte8yg/fJ7XqoAW1f8V7r5fLxVXhrZT/sGjTVfO2J3+egVpeq3cb?=
 =?us-ascii?Q?hXUzi3zKkFcbbdD9sBKGeX4MrF6UGo0JLL8q+sFrDDOK1dBij57Y11pN/5dD?=
 =?us-ascii?Q?vHduoMke648E5msI/Hi7Nav7gl8Weoiw5/Wu6IaYKccp9KHVnxcAB4TFDRcp?=
 =?us-ascii?Q?ViR3p5AEolibtHFH+ExO49bBASn7e7UxA4sLmoAw8Vavb7sHat8XrneHMxVm?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7de3f9-4456-49f9-e622-08dab8f1b50a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:35:49.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07RMXlcfV4FRO4a3mdpXjfUGlM99qw+H1pifYOjzu66gPeMhRYASOkbI5Ms2k9jGdLsssMUFHTImGAHueVmdZGVy8m/kzUkGEUE134MSZlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280090
X-Proofpoint-ORIG-GUID: Mhy_HQIf1HD9LcOUOVFVwFXPcIUfgpUc
X-Proofpoint-GUID: Mhy_HQIf1HD9LcOUOVFVwFXPcIUfgpUc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:37:05AM +0200, Nicolai Stange wrote:
> On a PREEMPT kernel, the following has been observed while running
> pcrypt_aead01 from LTP:
> 
>   [ ] general protection fault: 0000 [#1] PREEMPT_RT SMP PTI
>   <...>
>   [ ] Workqueue: pdecrypt_parallel padata_parallel_worker
>   [ ] RIP: 0010:padata_reorder+0x19/0x120
>   <...>
>   [ ] Call Trace:
>   [ ]  padata_parallel_worker+0xa3/0xf0
>   [ ]  process_one_work+0x1db/0x4a0
>   [ ]  worker_thread+0x2d/0x3c0
>   [ ]  ? process_one_work+0x4a0/0x4a0
>   [ ]  kthread+0x159/0x180
>   [ ]  ? kthread_park+0xb0/0xb0
>   [ ]  ret_from_fork+0x35/0x40
> 
> The pcrypt_aead01 testcase basically runs a NEWALG/DELALG sequence for some
> fixed pcrypt instance in a loop, back to back.
> 
> The problem is that once the last ->serial() in padata_serial_worker() is
> getting invoked, the pcrypt requests from the selftests would signal
> completion, and pcrypt_aead01 can move on and subsequently issue a DELALG.
> Upon pcrypt instance deregistration, the associated padata_shell would get
> destroyed, which in turn would unconditionally free the associated
> parallel_data instance.
> 
> If padata_serial_worker() now resumes operation after e.g. having
> previously been preempted upon the return from the last of those ->serial()
> callbacks, its subsequent accesses to pd for managing the ->refcnt will
> all be UAFs. In particular, if the memory backing pd has meanwhile been
> reused for some new parallel_data allocation, e.g in the course of
> processing another subsequent NEWALG request, the padata_serial_worker()
> might find the initial ->refcnt of one and free pd from under that NEWALG
> or the associated selftests respectively, leading to "secondary" UAFs such
> as in the Oops above.
> 
> Note that as it currently stands, a padata_shell owns a reference on its
> associated parallel_data already. So fix the UAF in padata_serial_worker()
> by making padata_free_shell() to not unconditionally free the shell's
> associated parallel_data, but to properly drop that reference via
> padata_put_pd() instead.
> 
> Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")

It looks like this issue goes back to the first padata commit.  For
instance, pd->refcnt goes to zero after the last _priv is serialized,
padata_free is called in another task, and a particularly sluggish
padata_reorder call touches pd after.

So wouldn't it be

Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")

?

Otherwise,

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  kernel/padata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 3bd1e23f089b..0bf8c80dad5a 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1112,7 +1112,7 @@ void padata_free_shell(struct padata_shell *ps)
>  
>  	mutex_lock(&ps->pinst->lock);
>  	list_del(&ps->list);
> -	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> +	padata_put_pd(rcu_dereference_protected(ps->pd, 1));
>  	mutex_unlock(&ps->pinst->lock);
>  
>  	kfree(ps);
> -- 
> 2.37.3
> 
