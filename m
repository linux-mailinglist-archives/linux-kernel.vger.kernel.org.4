Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA873DFDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFZMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFZMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:53:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5EA0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687784033; x=1719320033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O2VgtdnjOxFH/tyDiby201qQyhpchosN+AmAWVaqExM=;
  b=Bje9zUKkn3bAWIhQ3EnN1sDb6NRDKupwlCdCIF1sMU+hcdsyb8vlyTNz
   GhaMzaOyDjKTkoMAljhAalWp4V2+E8O6HVftg5PJj7J3fCkkjAzDUloKf
   oxWlOjCXveXYr3enIy5mNQsWX77e0Ew929eAm4GnsnkR9hjXV7xBXVAUs
   WouGdkYXU+LTeEBFOefg8PR10SSW54aakhuyKc6zzdG5iPXc+EsHQ0Lf/
   PNoJC4KwrSmT4aBMZzosemC0kjpnxJnzZMVNkmk+k9cl6nuhF8KcXqU1j
   ZNdzkVkyNa5Gs94jF4RtBl1rD1juLmxuOfP1rrk7tV7SMCfL+iBjC+fr8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346009729"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="346009729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 05:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840264909"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="840264909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 05:53:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 05:53:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 05:53:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 05:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCgMgwebm5LEFH99tHQ6jkxd6bguNI4IwfRXC1JLGMziZkQyGqYTIhoEBAnQRvjn7XXpJOmrhY/YLnGvfxDVXPzeWztp9PLwaUF/32AmDNh6Uy770seQvQrE89WQBB2SYOoBGrAZ4VdQhafEYDGmdhOhL33Bog1Y1ootNc1uC2MQxSy26vmRUXYG/tHN6bZOZeeu0Tc+++Eqk+QvG7729E89kDQY+NYFrIQaBJeIrgT1m388yD00YQ94KECN/Dnm5kGn/SQ9ZZHISUoCopOaCIyyoKSrcVmhQjxm3TMtqB5mACMpwRl+tDnbhKqqwSNF7lTz4deDc/8xtnVXTHq4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=273W6zvk3AxCm/AZRBxikJip4aLhRaW+prx8BseCxPk=;
 b=OFqomPi2WDlDNjuMZ4PSWab5+Ra5Mm983YEMXUX3C7mrKdQ0b3Kw5j6/vM3EPhsy2jW5CiiAl8Vh1q32/J1re+oDJZI5rpX7oxw5qAVzk4JuJKdyStD6DJofHljT24xqJJuC5+f2MiXykPwaALrMcX7nAhnSiIpoDOmFWdRqMmhpMdr1BvmjHgiizgH3SMxEmwwQsHotAsr67g4zg6mVq/tdpTSKkztxrGwOegigXG/Q8ECScoJceSO5SlPfd7iTRoxpW6WmU4hm46kHiXEbTmrjTjM3SMfHjsEf0HvCKH/VxLYKrJ4FJ/JP0oUvWC7xKV3Os7yZtFl/SHFp21fv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:53:48 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:53:47 +0000
Date:   Mon, 26 Jun 2023 20:53:35 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
        <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230626125335.GA508448@ziqianlu-dell>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3647131b-269f-48a3-a95e-08db764461df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1+sPBzqyUVuORSx367Uywwfm0naLdFgqQJ7ZBMPzHS1si7CIUItcT7yeVVUl400TdGQIbwmr5IOkjtctkNCOf4g0PE0Q3MPMXmA4jGbZPRK8lg8oMz8PQCewVkOSIcWsedkvg9vX39WdkL4V/UAbxNUymxBdGkcY4uuGfl/TjHfn3MjHb/yXKqZzu1Hq2rfFMQFqZxsM/P3ZXMZCOswYv48fOLN0yNfMmC0xr93NLCnwI3Nhg+ps3csRzwCYujOe5OfL0AjZ+aBgKZzkR3eOkrsaz7vWEhp64mCSYFuZTJa/s/2NewE1sR7AIT+8vztmxHUbnhVW8C9FFPqzKS+cK2GBv7joUAhGjlgKJkeBdL9KKlabCOB5txxs9YfPPLk7SXzJR+Q+rYmEbmt7XGiPjOGdWq6KCn+eNUYb6pMgU2agnyDupwiZexz4pkxVylDwKMYv12MElleNY2sSkK1qOeZV0wTVAjEN0PEppGYlHGAbE4R8XIUJOuTGzmCsMm0bqNK08XYNUMq9BeGTrNGMJU4yQwBgWx9XoDCZEJYK5AULwjtSiIUEtToIuvgOQ4W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(6666004)(6486002)(54906003)(26005)(6512007)(1076003)(6506007)(9686003)(186003)(2906002)(478600001)(5660300002)(6862004)(33716001)(44832011)(33656002)(38100700002)(82960400001)(66946007)(4326008)(316002)(6636002)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jK6zmTLoxYttoniBJdjnnPqcfMq6/s0tv/lsBzaO5ZTcwfhj6ihw43X5YDVL?=
 =?us-ascii?Q?r5Wtha40ZiHbs7rYt1X0vCneLvpwLMlcMfeexH0HU/MzSzdgQjzdN4gWrWSv?=
 =?us-ascii?Q?hzTVpxifpSbZ6Lx5vjJGNIvrBvT3p5UcFJu3veuI72PsD6wK+eNn40T2GEut?=
 =?us-ascii?Q?uBf6tYLKqI0yeBnJoqQTDJOqOFMG5XPLj9N+Iuo8Y/xOG9clSx8f5ziKcY3w?=
 =?us-ascii?Q?UaRwABOz+1VkkNXw+qMuD2AyXAvAy2iEqoH87CKBbikvyJSI/XbOONwtV7/+?=
 =?us-ascii?Q?6stTOxlLj6FV3sqeDHGmZXkW28ZAnoHfGY11jb9k0xB+oOiQldT+rzrqEgT2?=
 =?us-ascii?Q?2sVYe/AofIxGywYEUdADYdRJUI8JXW1pFSoJFVQNRKQPcikKnVhTkl0U4XfT?=
 =?us-ascii?Q?EVN1PdKVZbcobItdoooUxAlVpMWuktMV9mXstdlB+cTaknbruXzRFJDfVp7T?=
 =?us-ascii?Q?Lgy/A4AZEkjkpBKKEF85NgyxobFwv0Z3M7Ah0k8frLDqkRznK536RZka6+5n?=
 =?us-ascii?Q?BZU7PkMflsXQkM4GXja4eKgY2iHQlYoG3+H+b1Ti9d7yna9WT4lRolFecxCG?=
 =?us-ascii?Q?hKOE9thApUdIThIfZAHlXpIWrRuqea6EAtMuI8F9ut7aigATFIImjQ2DK82Y?=
 =?us-ascii?Q?tur1FWt6rhhA4Zxys8fAXFUdaH9iqi9OLNFLgO/1hcoHgbQROenMRVAcy7DD?=
 =?us-ascii?Q?8OncIVSvAqkzvkBDYLvehyX04KZ1gEymfutbzw9g35RdRitIZ6RgmOyXKn44?=
 =?us-ascii?Q?/06d4qRnvcux1uXi8kgXUXsnHYYR8xcvLebjJFeUfIQxYrNmQSgSc36/WpDG?=
 =?us-ascii?Q?DzodGLmMvQIIWUr6DRN/KMIOUHGeHuOQyhNh7PoZHP4kh/zlbNu1YIa9uvnO?=
 =?us-ascii?Q?umKL/UkcmKnj72qBTrY/YiyeoUOaWCCVBp0tPfv+ivh8gco9O9hyYo+mBgTa?=
 =?us-ascii?Q?+62vqygLPQZxZSG4VwTc8WXPuzsDQZ87AOAbHoYiLejfHTYZPcfxCj3oas6q?=
 =?us-ascii?Q?uV0FBUiOiTXqmJzp2/lFu+k6QptrBdfDxSfUGk2jxRdQXv+gpItROwAcRcox?=
 =?us-ascii?Q?L7PfwWtiKfeCKKmU4aLVVZMYKN3plZWTFNZNeGJgQatYVuHSCYpV8F+MZpVi?=
 =?us-ascii?Q?ebKmNEsyEaTHBnCHfOSMwC+L4tSI0HkEkBk/1qmd4Ec5oWTmLpw9VqxtGaNj?=
 =?us-ascii?Q?Xk1LMpD24aa8aFb0zmi5B/4Bedy+55Y3/zw4b8/J1x8Exrfq2jPzg28z+LEL?=
 =?us-ascii?Q?ZNcOFA1zM8OBL/SXlwUpnseshfZNVbY3DYXLxqDDiCSHQWUVLdfMWHx3/4yl?=
 =?us-ascii?Q?lOifRjabRI0vef5+RAS7ozCY8DXSGT/jhBwK+pgqaA6pE8RviCok1Glh07Jd?=
 =?us-ascii?Q?HK1EBl6RuX/kH5gO7s9fPeVePMmq7H9M6oI0j1yZJn0Kul4ithg/ENORxAi9?=
 =?us-ascii?Q?CIn6aHANIjAUJe0Zow9kjbnfoliKMk2fiY2/fx6AXcRUxMKnGIV66u1w43EP?=
 =?us-ascii?Q?dMa21+BkPBrO7Jx8CMJNkhbHqe2msFR2bmlLAvjWtOd1uVlzfv8Ipv94CvtU?=
 =?us-ascii?Q?/xMXT3zy48bAPQF0VSYRpDRuAo2dqCAMj1EId6UE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647131b-269f-48a3-a95e-08db764461df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:53:47.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdk9ZxmnR9IESbRiB6iR4FP9dGPxhZD6GbcwJmfv+erQ7qHrHquQiN2nw24WzKuFyY4UMwSxCXTjHYLoph7zMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:52:17PM +0800, Chen Yu wrote:
> Besides the cache line alignment, if the task is not a rt one,
> why do we have to touch that, I wonder if the following change can avoid that:
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..067f1310bad2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>  #endif
>  
>  #ifdef CONFIG_RT_GROUP_SCHED
> -	p->rt.rt_rq  = tg->rt_rq[cpu];
> -	p->rt.parent = tg->rt_se[cpu];
> +	if (p->sched_class = &rt_sched_class) {
                           ==  :-)

> +		p->rt.rt_rq  = tg->rt_rq[cpu];
> +		p->rt.parent = tg->rt_se[cpu];
> +	}
>  #endif
>  }

If a task starts life as a SCHED_NORMAL one and then after some time
it's changed to a RT one, then during its next ttwu(), if it didn't
migrate, then set_task_rq() will not be called and p->rt.rt_rq will
keep as NULL which will cause problem when this task gets enqueued as
a rt one.

The follow diff seems to cure this issue:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c7db597e8175..8c57148e668c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7801,6 +7801,20 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 	__setscheduler_uclamp(p, attr);
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * Make sure when this task becomes a rt one,
+	 * its rt fields have valid value.
+	 */
+	if (rt_prio(newprio)) {
+		struct task_group *tg = task_group(p);
+		int cpu = cpu_of(rq);
+
+		p->rt.rt_rq = tg->rt_rq[cpu];
+		p->rt.parent = tg->rt_se[cpu];
+	}
+#endif
+
 	if (queued) {
 		/*
 		 * We enqueue to tail when the priority of a task is

But I'm not sure if it's worth the trouble.

Thanks,
Aaron
