Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33E8624E57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKJXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:16:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708311451;
        Thu, 10 Nov 2022 15:16:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AANBgMo017244;
        Thu, 10 Nov 2022 23:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=y9klvD24jek4lt8LSZ4g6XT0aPP2qOxEMe4CQ5Gj+Vc=;
 b=skdVJLb+rZD3HpnP23BDIhyC5tOL4Bfbf1StODJ5KGo3R9SVhc7ZaaDGWWzN6xS7xvKb
 yxLyosQ3fgXAS1HvAjWk/OwYTIUb5UiVvnR0dhB/OQM8sra6HnXuqc09bfgJQID9TAbx
 u1JubanRRTQBBRLyJCmESu9o9Yh8rKJa6/W11h/j5iP3YxKWSF4kxqfvdcVwik6BpEYe
 xSmzRlyXYOyUnBUkz1ZhbofJEc4aReqNbcI5L2sL+MsPBZO+97VmRqAsrsNOlwxMklsA
 oTZFnBOSrDAgfKZZOAQB7RPkJKCKAF9Hu3rOPlnoc2H2o0a4u4O7Y1kJCohXP+u5hVEJ eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksark80j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 23:16:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAMVfTq014989;
        Thu, 10 Nov 2022 23:16:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctfvpah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 23:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh43GeJMr+xXjxgf5tJAU4AQUbpPELmQDp7zj6bi6E9dWGvy79hCBlqcfBKEn0tnlUR+O0sthc8aUov8AWic8ZEU1G3XdIdPDcSU4hIRAlfO4++LRmmwu0TYNruHjwoxRB72qu9N3UQZwe0crMoozy+5JzS8dDqrLbfH/OGya9zhz0RhFn3DUT3di/ZPU+RyAX2YFAufLAPdPiUkoFZJt55cVAC786QA9G5KXRwpoIQLczCY/ckQQft9YIhBQi2P/VccZzinCKepOHni0xslu1oodjyILVnLqLIGpkhB7MukmAxaFSW8zX7bsyKj4SDFgCrPdgf4z7hPVVc3u4CXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9klvD24jek4lt8LSZ4g6XT0aPP2qOxEMe4CQ5Gj+Vc=;
 b=gtRQUD6UpIvOHdzkurFs9mMS33lIS8qRjCvrPY4Cuu0h8dBrwFN02D2GXJSPzNPqqe64Xdmie3QQ3Ba8Dzx5OGJ1uw6ZdH8T7CNXvuqzahX3I3bQb9qUPqd/CxFGyrk4WXAU97DjMJbJXmb77LpJCsHppOwAfaC8/tI0Ug40ekXbmIpJKLRXsF27QjkcgZMP5fFI3rXyoQTc7qQl4YKjHfEIsNOVuBitxA9E+OS9dmBbszDDXjlVjKDxexg3BeiBttjuZvDuADVRhse09qfa/u66uMprwmq5AuxBVQO9W+d5ZXWkzcHuKuXCqJOk+OfVmrw4eLVt6aKgvY7CaV0K7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9klvD24jek4lt8LSZ4g6XT0aPP2qOxEMe4CQ5Gj+Vc=;
 b=Tau6T5l8dMDeDocswB6sP9MC/W8p7lBCwerX23pDNGpc0RNV9TOkViE2IHzj+eNLGtzQQhGXxKppiX+YKgn9FbyNce0b4YCRSvJWBOiiKBBir5ZXxZv0w7fPPMCEaVQJS9g8uGpsSyQ+J+TQOggp5Pl5fiq6D4qUFZabQ7Y1Mr0=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 23:16:30 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 23:16:30 +0000
Date:   Thu, 10 Nov 2022 18:16:26 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] padata: grab parallel_data refcnt for reorder
Message-ID: <20221110231626.btbivtbbnxwq6tc5@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-4-nstange@suse.de>
 <20221028160401.cccypv4euxikusiq@parnassus.localdomain>
 <87cz9wb7qk.fsf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz9wb7qk.fsf@suse.de>
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: c329b73e-84d1-43f4-4b2d-08dac371995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuf6BG3xaN2cha4n7DwBDtSPOExHPq+Is6ssksDwkl9XwtVb9HLWPEpxWZ8bCppGMT8abNfDbIZZ9HS4zLzAfMfOjbxCsSa3a+2rWXdJjWnzmpHxwnnbXreA12OVm4wQ/ruAqjon0okaiGDSFjoJmaeT27ehCPTzr+XAUrTAFcMpDfTnnW58B5NE8QsjqQyyTGY4AH7/W/YIbtJiWUkNH+kITJ5KYYlXEqVumV2B2ZFJ5k70fQyDjfC1dzBgWOFb4GxGjwFsC8W+zbPk8BQ0aEYM0YfOpmXbKGKIxcrcmyPIBQDDv/vf7K+eQs9O++qFum5aILlpi/3au/uBCnysFIIgrEmT2w8Htk30k+c4HU8qalqZZx+EHe0oD/auPFPhDhMgUAymaZIy+VRioWYx/103wM6pct7eVhmeyh9snWS8aGrdn/Cu5u+McsPrnLlBZIxtV5HSjY2/06YD+ZESpkCqmGFdlO+Fv4yAzWF1KkGOetxDsxoiqCIZ5K1HJYIPd4qT8Cl+2IEAmxM3HM4ZPUNwSq2EpbWwkCi8mO627m7D/g4/CoU8tCh5xGLhSzqced4MeIx2+a1hXggV0iuv6lCGED5qlNW1rJIENnQ5pdbxMh8U3pyJHF384lXB2hSNXfUNRmaKx7dkVb4z5gF2d7tcG89ZJ2w1dkmk9Imxkrc++Qh+n4zaZDX74S9xhbXpCpQOYSMzfzi0y5BN5MMwSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(316002)(66899015)(38100700002)(6506007)(66476007)(6486002)(6916009)(5660300002)(6666004)(8936002)(4326008)(54906003)(41300700001)(6512007)(478600001)(86362001)(8676002)(66556008)(2906002)(1076003)(186003)(66946007)(26005)(83380400001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSd1CMuhBIw2slExkVJRcF7qpFb+kqG5IwJAzHEs/q8Vsm4Gvf5ElNLUhvno?=
 =?us-ascii?Q?5QHvIQ2j0bdJJUQj63eS5iaGYbrakc/85V+9qs4lw6aaWTzPG6phAaQbzNXS?=
 =?us-ascii?Q?Uuq44jWgvvBoIxjYsiRFAFlp1dBwZUUbT8xFWvddvUjeeCO3j1qUCDve7THa?=
 =?us-ascii?Q?oSgeeiMvNgzXdtGCAVc6FntJ0M2H+yw+BBk29KRhM7iyBJIy5x1dCi2LQwOb?=
 =?us-ascii?Q?IhavWMFbydK34zPE7n2HnRQ6BDlSjIKNW4gCmRAFCE2a87tRA59gj8swwIVF?=
 =?us-ascii?Q?OFdSCTlaQfjLpcQnbweA2XUB/UiYJGXY0O3z/+iT1NLl+S8IkkHV4CjC5Nn0?=
 =?us-ascii?Q?/VOlhnb1X4Saos8B4Kh6/7ItPLMdBnfGKz1YZzWta2/Od9gSJkmHl9gDttXo?=
 =?us-ascii?Q?NfBAjy/BPFa1x+ihuv7fXQbjDM448z8ys5XKDfmyYhxfH/cA4EElK5Egm1OU?=
 =?us-ascii?Q?OFEcHqfE+b4xIyP06gc6qJfo5VZCX1GgaFUDe7FSfPUwlyC9RtIIaiIX+gXt?=
 =?us-ascii?Q?3cgksSYIHQDsi2r4cv1j4xe7WYj1W3ssjnTZadq/jVCxvwDX9AgZ4ad9OYUw?=
 =?us-ascii?Q?NrGGcMHw1ax0sCiI1pSxMikGos6AxNEINBz0rYPAjxp0tENfdqfDNr6btRAD?=
 =?us-ascii?Q?iQel+ypTWdEDcHo9whM5DXhHEce67WjtHaU8w1raafclAtnfnra4oCOxqGoJ?=
 =?us-ascii?Q?vQuN+eqxHNMG6shelQNxq96lDtfvoA3h1itFLbjnsOxhpeYOMRuTfKtwOsSq?=
 =?us-ascii?Q?uS1TFpAMlRidytGxdnp2d0ge1JSE0fz9MNRbLxd5X+ZpXFiBXAKM1YXKzN1j?=
 =?us-ascii?Q?wTw+EpvJRHug+8R4KCGmu65a+m10/FyXVsizOxtlrP7T+7DfWUhBnbH2EKfB?=
 =?us-ascii?Q?/U6YTRVnIbz7a+yjy5JWntXZEDf4qLtQSHG1GEmK0clMc6MhfLqaEh7mLOpU?=
 =?us-ascii?Q?Y0jTnLGuraiQMlQhL5GMMhpLjTlFhm7sHju2ZbhP4Ktp64ejiLyRd/r8R45o?=
 =?us-ascii?Q?ReXKus8im7mgK9My1TqMCXUMYrCItSEcRlGGSshn0ainEK7MgHzXDMR7pOMF?=
 =?us-ascii?Q?yxa9LgF9cuEvDKX3ZMkH8hb0KXFjgde9sVg22qCP3PT7QGXCgQ2tplZD48Sh?=
 =?us-ascii?Q?TLxA5hpRxFlPeJ8OcMUcjf5Bu1m+Qtjf86AEq4wUbltBGlqAiqqRcJuAMyCF?=
 =?us-ascii?Q?LPnrpyTrCGqBdbIqeEfc7CVpgDLt9oVK/rNkEiDUSNVHgtPkUOPN8ZM/gwlE?=
 =?us-ascii?Q?ewp0S7LlKkDMsFT4BRxIOsO4AXYSCyc9LAoSGLdAKNtWGrq/HJM7F5EGq1sC?=
 =?us-ascii?Q?Vz8IK70Id9m0B491XULXhDCuZh/+KG5NpB18fGKDUl0RWhmvr1Fo6hMxc528?=
 =?us-ascii?Q?jTMI28aAYmYv6xdajO1K89YUi9IawF0jW3Nh690huH8EXwL7C0fgtydTOc6t?=
 =?us-ascii?Q?eHEGKuBjw8gVAVxQRKu77hNv22YROPhHYDgfDgrdkjZPRFHzLmFH63iSVzqQ?=
 =?us-ascii?Q?r1ueLuyBJk+ugSrFL9R5mBMIZMSM/Sw6sMO/Q8TKwnttOEaANuBEAlkDf0PD?=
 =?us-ascii?Q?8wtPOOEmrJW3KtxU5YSVJNDkLG3YwQxMB2E+up0Sbxcy5Kna5rVnme7N3VrJ?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c329b73e-84d1-43f4-4b2d-08dac371995d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 23:16:30.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwq6RN+ZXb1WPWvniRGjT+FFc6jJrZ/ESmfy5KAoIa+UeTkRKqn6WyTpb9vTH6/Yj4wBxi9xpfIF6pdvBByjStgXQCT30gryL6cQ3Cucru8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100163
X-Proofpoint-GUID: AMwGiZoAvGDHsHjvzqgHJu32zVcJNICR
X-Proofpoint-ORIG-GUID: AMwGiZoAvGDHsHjvzqgHJu32zVcJNICR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:03:15PM +0100, Nicolai Stange wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Wed, Oct 19, 2022 at 10:37:06AM +0200, Nicolai Stange wrote:
> >> On entry of padata_do_serial(), the in-flight padata_priv owns a reference
> >> to the associated parallel_data instance.
> >> 
> >> However, as soon as the padata_priv got enqueued on the reorder list, it
> >> can be completed from a different context, causing the reference to get
> >> released in the course.
> >> 
> >> This would potentially cause UAFs from the subsequent padata_reorder()
> >> operations invoked from the enqueueing padata_do_serial() or from the
> >> reorder work.
> >> 
> 
> <snip>
> 
> >> ---
> >>  kernel/padata.c | 26 +++++++++++++++++++++-----
> >>  1 file changed, 21 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/kernel/padata.c b/kernel/padata.c
> >> index 0bf8c80dad5a..b79226727ef7 100644
> >> --- a/kernel/padata.c
> >> +++ b/kernel/padata.c
> >> @@ -275,7 +275,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
> >>  	return padata;
> >>  }
> >>  
> >> -static void padata_reorder(struct parallel_data *pd)
> >> +static bool padata_reorder(struct parallel_data *pd)
> >>  {
> >>  	struct padata_instance *pinst = pd->ps->pinst;
> >>  	int cb_cpu;
> >> @@ -294,7 +294,7 @@ static void padata_reorder(struct parallel_data *pd)
> >>  	 * care for all the objects enqueued during the holdtime of the lock.
> >>  	 */
> >>  	if (!spin_trylock_bh(&pd->lock))
> >> -		return;
> >> +		return false;
> >>  
> >>  	while (1) {
> >>  		padata = padata_find_next(pd, true);
> >> @@ -331,17 +331,23 @@ static void padata_reorder(struct parallel_data *pd)
> >>  
> >>  	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
> >>  	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
> >> -		queue_work(pinst->serial_wq, &pd->reorder_work);
> >> +		return queue_work(pinst->serial_wq, &pd->reorder_work);
> >> +
> >> +	return false;
> >>  }
> >>  
> >>  static void invoke_padata_reorder(struct work_struct *work)
> >>  {
> >>  	struct parallel_data *pd;
> >> +	bool keep_refcnt;
> >>  
> >>  	local_bh_disable();
> >>  	pd = container_of(work, struct parallel_data, reorder_work);
> >> -	padata_reorder(pd);
> >> +	keep_refcnt = padata_reorder(pd);
> >>  	local_bh_enable();
> >> +
> >> +	if (!keep_refcnt)
> >> +		padata_put_pd(pd);
> >>  }
> >>  
> >>  static void padata_serial_worker(struct work_struct *serial_work)
> >> @@ -392,6 +398,15 @@ void padata_do_serial(struct padata_priv *padata)
> >>  	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
> >>  	struct padata_priv *cur;
> >>  
> >> +	/*
> >> +	 * The in-flight padata owns a reference on pd. However, as
> >> +	 * soon as it's been enqueued on the reorder list, another
> >> +	 * task can dequeue and complete it, thereby dropping the
> >> +	 * reference. Grab another reference here, it will eventually
> >> +	 * be released from a reorder work, if any, or below.
> >> +	 */
> >> +	padata_get_pd(pd);
> >> +
> >>  	spin_lock(&reorder->lock);
> >>  	/* Sort in ascending order of sequence number. */
> >>  	list_for_each_entry_reverse(cur, &reorder->list, list)
> >> @@ -407,7 +422,8 @@ void padata_do_serial(struct padata_priv *padata)
> >>  	 */
> >>  	smp_mb();
> >>  
> >> -	padata_reorder(pd);
> >> +	if (!padata_reorder(pd))
> >> +		padata_put_pd(pd);
> >
> > do_serial is supposed to be called with BHs disabled and will be in
> > every case after a fix for a separate issue that I plan to send this
> > cycle.  Given that it (will soon...) always happen under RCU protection,
> > part of this issue could be addressed like this, which puts the expense
> > of dealing with this rare problem in the slow path:
> >
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index 0bf8c80dad5a..cd6740ae6629 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -1110,6 +1110,12 @@ void padata_free_shell(struct padata_shell *ps)
> >  	if (!ps)
> >  		return;
> >  
> > +	/*
> > +	 * Wait for all _do_serial calls to finish to avoid touching freed pd's
> > +	 * and ps's.
> > +	 */
> > +	synchronize_rcu();
> > +
> >  	mutex_lock(&ps->pinst->lock);
> >  	list_del(&ps->list);
> >  	padata_put_pd(rcu_dereference_protected(ps->pd, 1));
> >
> > pcrypt calls padata_free_shell() when all outstanding transforms (and
> > thus requests, I think) have been freed/completed, so no new task can
> > come into padata_reorder.  synchronize_rcu() then flushes out any
> > remaining _reorder calls.
> >
> > This doesn't deal with pending reorder_work items, but we can fix it
> > later in the series.
> >
> > What do you think?
> 
> Yes, I think that would work. Will you handle it alongside that fix for
> a separate issue you mentioned above? Or shall I once this fix has
> landed?

Please go ahead and do it yourself.  I'll send mine soon, I think it
should be ok for them to go in in the same cycle.
