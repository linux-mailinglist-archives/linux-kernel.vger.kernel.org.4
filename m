Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB105666CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjALIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbjALInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:43:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FCBD4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673512863; x=1705048863;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rDfHyvMpKcGjj1qUq+mBzw5eDxcvJDQoDRZei7RNKXI=;
  b=VjNwkoTbHrVTiE9zUetJOqiOPYBomyFdXpSlSXZgHDjcT4GKtAh9xuP9
   JTXHEx44M2RSZHxBT/23Da7GQgJWKLDb4P0sBy3wIAJRZ5lK7AYrOkxR9
   BDbh//52ukj2GI1Ua8jBakyPB0j/1bLCM7NyDuR08NbMMysUc3nLmboDJ
   Fv4Xi4IPIFm/mzf/cfZIT/AnfRfU/4IFVxiJhGJG+N6gt93twdBav9VS9
   p1XzlKyZu8OOelT877cmz9RE4JtOYsxNidPJy/gv6cPB/zclVr87gpG+1
   fgd/tMnpcHsnqX7ZnSV0FK0fYzc1GcEM7IZkhCAtqvGAgojY1IbXD1Ps7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350874196"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350874196"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986453397"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="986453397"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2023 00:40:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 00:40:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 00:40:56 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 00:40:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys/Lls/txR/RAIumwpsmrLmc9qLdLIgnmTcHPpAhSeXu5QTrWOx8oyI/eRUXiGZ8FYnZx4OZF8IkFmUPjKP05YKQhDCDOri3Fhr7oAdrFzCsOdu/t50zk9Vb4xwM0fQuJCpiyS80wl4MwiXvCAZ7bIVWm/Sk8XLr6Fypp/bYkVNMf1anfyR+jMDsiOU0C+dEImgD4VBmTQrftOazLBX+x28+MnI7Pummz/7rEK5/BK8eXuDvV7FF98TtU1d+s3O+SKOkwxQ50aD3Q/m0oqV4sxt2sV4b9mjXzML+AzgecB2ylZTwo1DHUK2Mk8k9g5WLrXsQ+1L58kBH30YdapV8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3LByAiYpgQYkri/SWwJ/uFSaPuubhEcnyNREt9cRuo=;
 b=SSRgNYcwUFEbAM72dxPq/crTqcyDqVKE0AW2tV1B1c9TLLnmod846yiTRA4jvQ9VrgZPlHq2bxB+1USyGq+qIqzGveDVdsECNGoNyF28h/74+NEB6Wd85aWWLn1/KBNjcnsKz88XH4jRnarj8/rm2uG3NMh6n3WQIrBkcWMVI1a2v611plqdgV+hD8bqSrEQZhDVBemEI7JK4J46x7EBvpJBoQFRJ22aQSsQEp1y5ujIc30TMq+IadvcvsRYwcO2vDH6rPhjaKTYx4YqCnAl0XYhJ0me2iQImE/WbrROo5TA26mpn6HM91Ra7Q89YP91cwoYxYkm+vCbjmjaagMYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 08:40:53 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 08:40:53 +0000
Date:   Thu, 12 Jan 2023 16:40:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>,
        <tiozhang@didiglobal.com>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y7/HhF2OQQc70Dfv@chenyu5-mobl1>
References: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
 <Y60WrwuM43HcNVC7@chenyu5-mobl1>
 <CAEQmJ=gcCx1hMf7HicE5OFeUstipdtr=3JkF1JxLuP-CrG++Pw@mail.gmail.com>
 <Y7fvOz9jZPndTDqp@chenyu5-mobl1>
 <CAEQmJ=gZJL6K1yUPq0hHy5D7Rc6g=5Ri72V_kE=xfqR6gJedWg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEQmJ=gZJL6K1yUPq0hHy5D7Rc6g=5Ri72V_kE=xfqR6gJedWg@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 936a51ac-62e5-45b4-8065-08daf478b6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtfNXqVVLglvhZvf3F/Gn7E6e+UOM4tJiVoh6eTKsR9c0gTjFMN+McazYTGIc3uJcG+P1iorOrSWEyZAyKIjQEAhPB/KfFZ0OPQHrxmbjASb8ORbll1bi0NTy5WcUmcoB7OX8G5USLgzW8oY0LzwQGsOKfZlfsWM9/Khuhnoy2w72TIyoCSlKJFFf6Jqq2wJL2d/AN3Vo3z7U695vz6LliJRCthPSVIEsd9xDsOj/b9BMNVd9phn5uXBuh7LbNmumgQlMPin8L3hTsrPyJfQtrlvDtd2pNV3M+fxp8EAJtIg7GgfhqDHOsFE8N4gLLQhIqF0IO5Gt59k0d0mPOn0EpZgpCbv0xwmUbcbwA+hdLJ6urVohclNrl+7LrepzZuB7UMuOqSIdU+NOtS+xU+yfGTn4GPycDVoMFb3YvpRw6HUGWRhnZRIlMgIYIoAqio3wccZTuR4IBQAyK+p0Ub97M//B3MjJ1h1v7lopmgaef9A8Zbhaqjo3HWizSr1IafSFtbp37tUuF80Si2B+iwGOZmwkyFbkc99GscZSUNy3hk045gWoZGGV7GghObluVP5jNKNmP4K665YtBp3fYNNQSE5xyCCZ+TQH2KXktezG4n1YQWUFJl4FQMm3trRD+oH+u8WDIreHIVIxFurKQGGFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(9686003)(6512007)(186003)(478600001)(26005)(53546011)(66556008)(66946007)(66476007)(316002)(6666004)(6506007)(8676002)(6916009)(4326008)(6486002)(38100700002)(8936002)(7416002)(5660300002)(41300700001)(83380400001)(4744005)(86362001)(82960400001)(2906002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CD6hwVJY9nRUpsotkcXneKBLv+rgOljkRY9VHm7aqQSKO/19y0NJ24AZIfMM?=
 =?us-ascii?Q?jVMrs7IhHHCJLrxUuHmf/+qiCzqrtnrdDHJeyfXSHFK+8mmcyXZwKlMNzKAz?=
 =?us-ascii?Q?2KM94/vKKtXgwZnOlERhjhuEKU6p0cYZp+EFIaHGyyPKNTuUyYFiUsymzjpL?=
 =?us-ascii?Q?65DUidQbyjn/xLFmxh9X3NOsE5ftXFFv9N6wFAvBXu0nirgs/s5abYo7Tn4p?=
 =?us-ascii?Q?TwJleYqniR7/Aydw7lpaUQ50lG+AYqXGdSOzVGJ64zaRDYjtsXk83wOhWLNg?=
 =?us-ascii?Q?kPTKvWRX5MVfq841MTM7oIyGefgceCzV5rhGKY8i4BP5wMpGVSEOOK8qQiik?=
 =?us-ascii?Q?HtN7SUvHR/o1eO6Q92K+f1m5NJg2Xwg+je9SeR97tv+uRfyJUT/3ux/Dlnnp?=
 =?us-ascii?Q?FYi0t9YEW/VmqGsaLurBI/voSQscDfRlIq4uj3l9h8e+YrGG/61BXitJdUR7?=
 =?us-ascii?Q?jhdiYYwHvq2TdmlIAnffh7vsqjg2bhAyhoYo4WEyAFQfkYNlo9ImAvYfuY7S?=
 =?us-ascii?Q?1Pqffyl0p2bnWdGlGba+mCBXjG4LM8qaZXBfvqLZxAXoRe7YVkPFbnw7vj2H?=
 =?us-ascii?Q?3Ln0ddRS5AvMSm5kpw6G7C2kVZEgAgpnH+Yb3gTojEv3ir+FvfbveO7dQF/e?=
 =?us-ascii?Q?RLLNIqMIPJh/uW50iuNA4mwIOuQPb3moiVkrKWQs7sK/mzRLzfr7Zo0Fs5bN?=
 =?us-ascii?Q?/PUoL61QwOVBvbq4SXE6awL2CGqIFCMA5eEgetIlyFM3vV78oD3f9+VyUPMB?=
 =?us-ascii?Q?ItUfCfNgMOFVaVtTQ++ZYZuYPBqyCVviMFELlFBC183CM+Vvw3HxQlho7ieO?=
 =?us-ascii?Q?podSqJMgXP5NxCcamb6cRGWrcKaULvprbKtfNzxmgkF2SkYLGoi8K7kz9+I3?=
 =?us-ascii?Q?W0wJH64MuruKSjFYJDHxJxYfXHIlI3D9LSEXqi7hi6+fm0YvaFPcRIozj1hQ?=
 =?us-ascii?Q?OLQOjZ6bl63IbD3jJnaqPjnXwjO+qzMSW++EjciN3MdSMAMafKVHRHF+/Eg0?=
 =?us-ascii?Q?kdYM8hObtF2loU7CfhM3iubnsR2WHlrEhznNK10pztfXdxfw+kDObJnq35S2?=
 =?us-ascii?Q?awUHy3vPIMYvTW3GFGUJsm8PTZgl2tKihu2cM2MS88d0Ltxktyxyhi2CaNf8?=
 =?us-ascii?Q?ttAnztcH5ClJB8j2rB3lRWx45EacBVYGzQPF+UcIUyP2uELJEu24UhVkooBI?=
 =?us-ascii?Q?ZMqfoX/gP5PNj5rs5oKVK2k5dmMhxXWT23iZ6dYNenLolU6rfUy9CKfygXCL?=
 =?us-ascii?Q?eNMpQOU3Qshjr2gTLuNYU3Ymr3LnPJ165J9k0F8HzRymLD0uoqQzSnkSwCeP?=
 =?us-ascii?Q?IjjN5qauqqcoOMdQR/p4b4w4aL0y3Gunl6dNc+MEDxod8aj1cUXA5pCKggNc?=
 =?us-ascii?Q?o9Aw5EURZLmJsiJdqP2UchPGVGqAFcG7l9Zg702IzudIlddlBrFRt6uvK4mW?=
 =?us-ascii?Q?2jvDsRQkqCbGgihDnimKm1nEyJtX1MpJghsePmsMGklo9AVIneu44IfvoNpA?=
 =?us-ascii?Q?5A9STt0DiOlVzPtdlcwxpxbU2YjuybRNrzRjcy+IV6xafJvtmLTCqC/PybFb?=
 =?us-ascii?Q?g1GDfuIg70UsGuiIgQLsOadW8Ww+pDHBw1mMQA85?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 936a51ac-62e5-45b4-8065-08daf478b6bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 08:40:52.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to6Qo3WUQiYj4DMSADRrEct5/DtPPT0ZeE0ni8vCg0Fs9bEE0F3fC5bOyWUo9slO0pTGN99C6fGFyJwAozh5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 2023-01-10 at 17:35:34 +0800, Yuanhan Zhang wrote:
> Hi Petr and Chen,
> Thanks for your emails! Petr's suggestions sure make a lot of sense.
> Please review the following implementation, it would print a new line like:
>  " parent:kthreadd        ppid:2 "
>  after the origin line.
> 
> ---
> 
>  kernel/sched/core.c | 15 ++++++++-------
> 
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> 
> index cb2aa2b54c7a..86ee90404ddb 100644
> 
> --- a/kernel/sched/core.c
> 
> +++ b/kernel/sched/core.c
> 
> @@ -8853,7 +8853,7 @@ SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t,
> pid,
> 
>  void sched_show_task(struct task_struct *p)
> 
>  {
> 
>   unsigned long free = 0;
> 
> - int ppid;
> 
> + struct task_struct *parent;
> 
Above line could be moved inside: if (pid_alive(p)).
And the format of this patch seems to be broken, please resend after fixing the issues
reported by scripts/checkpatch.pl

thanks,
Chenyu
