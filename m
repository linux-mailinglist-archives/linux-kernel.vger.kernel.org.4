Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B210675A81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjATQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjATQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:52:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CEE3AA5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674233567; x=1705769567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iyVrpW7V/fKSiliasesOOFdyavkMsnNXaGThV6HvV94=;
  b=LbOeHQyLnTErSJHEiJLHs4G5q1X6HsXZUJwXJYoN7X8P6UqcIQSesaOQ
   UZteePwvBAK6KCchLOBrrv2wPEqh1rubMcGVDXroGfT6bpZyNLx9Irpmr
   CMR3bPiSlGp+3EiLfDZ9DyJ30KIUAJORZMm9CP9yMhR4dWPam0jSJoXot
   456n8Iy3X6mqMc3fEM9mJkb0V/e+OCwH1+tlgunkpm+6vf1NFAlprTTBf
   UQF4/4buBbWrqzfPplugOxvS3fEYXnVBzf/J9qOPZGGbvsgRThya8IoSV
   8gZf5IEl1yVLXSvCCt5HM8hOB6TP8ezIZ/N8RmdgodeCCOul0DNRyOr/s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="325661906"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="325661906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="729165414"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="729165414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 08:52:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 08:52:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 08:52:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 08:52:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHKqo3iPuuXzFKTvccOReVgdW+q+cwGLuEpTJ6azIWeT7pI6vCM/UxiInT5lN1KNH1GdOom0hySR2raabJ9ZLbRSl5I9zv2C7hzNpqiHNNvP0K+A9rQi1zQsVe5aoz4MxvPNiVCaCWXM4GjG85sENk4ndNjXCqiIGCM/VNuY5+eaNBEXrAh0AwMdqk8yKZEXEskKpj6bAa6/b+R6P+RjbdfXsay+43JoG31KN5YItTK3AyhlMjgO9mdf886JpMCZOs+m8W8MWcHZfO4rKxJ0guxBi3HvoKmAY9BEILqtm8deyaY9sFj0N64kDUr5bjO3XZPsPHcBNG7a2Tfq96R+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9vG1r2ZJ9Pr5lmQXAFqkGMmPD9S5DH2u19cnwq9+ZU=;
 b=YlON71/yy0A4EYQ09ozpS/578IMsKNUYRC+ocmJSYw+wtgL1RCGT5TltD+dV5b1FHaQl1xupzFl6/PNEsodRjd0KDzKVmjTUJoEdPHFgkarNjiZLOJV6JeE/F0WNz0rIIAK7rqeYywXd60AsZQP+4ZXJ4MoXnHAzEYiurJWCMzKoUCILSEmTEXoDPHkW8ORGer6SHvdeIKYKYkPqdybgVyaC9WZb1gsK33FjqG6PU9MQ3A1wU9Oyc8bo1OOCcanvtRd+Z0gU6OMMh+0YtaIZLqUyjPtcG540dCxT7IJHG42aFpTkq4LKgbDroeLrMsiMO+XxdTMWl+H9sihgdVtPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 16:52:25 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 16:52:25 +0000
Date:   Fri, 20 Jan 2023 08:52:22 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>, <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8rGxrED55ssgxnl@a4bf019067fa.jf.intel.com>
References: <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
 <IA1PR11MB6076660471E9C688E79A2B20FCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
 <Y8mFBbWmpGvZy9dB@a4bf019067fa.jf.intel.com>
 <Y8qDLYylWCkHveTw@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8qDLYylWCkHveTw@zn.tnic>
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f8eb59-81dd-4d3b-0f79-08dafb06b4fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HI+XsXVLKNiqzaRJieRFyBbXKgiaWJFlk5D8ZkBvROP/gtCQK+/YCE1oAakiAUXgX15FMKftJLdc2owrF92NsxV7wxefw7TRXkJ0QS9fNJoMdEemQa2T+7gopQ/D7QmE1XQLuYXM3K5O5gJulF/7cOiuNhSrp6VbI9hmqlAe1B7o3o8/meusqqq7OGkxDkOnyCqj0Btmo6sqCtF803hgrglbTtOY1YHFAe5RVSPHihthxtkOXd43DI38yMP06/PjtNETAkhNAF0gGaeKnbfuYrn+t5PkVWyUG6I/QfnpoUOBNfyD9BlF/ow+kaB+CluvHIych7F0xQa6SrXvj35Dyyhto1uAXeGXkKFMUxWJdUKXL2JHILd19KvwbOdgCaL+Lp2/k3imYPoornlJaVZNAmz+zhiHKTCUnRkYvaARbTV7MRTpIIKwuAbEgsKrSya+Po+86z+ZmWrtCITab+auIdY1/xU5usKhWyUKKi+EOrYZXiMMZzIYZNwYn7vyKD0/eFpJiYkajTgK4NY+uafKPkDMyvvVQ6HyaXN3XPxHdBIhmtUllY6ay2kkhTkm8C2yoAToQCTIiTsxoS+4LB3jsX723o4ncPHYSOOc4D3qhWRDqZSLfU0MYyLmFISqGm9MPT/KQpt7OkV4tJyY5FqoqVpxdbTUL7o0zWuAVO8Y1pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(82960400001)(66556008)(38100700002)(316002)(66946007)(66476007)(5660300002)(2906002)(44832011)(8936002)(4744005)(8676002)(186003)(41300700001)(26005)(83380400001)(6512007)(54906003)(6666004)(4326008)(478600001)(6486002)(107886003)(6916009)(966005)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQSql1IW21n1eXTwzTK+Nedc6/RsvYp8NTDPR21q6FoT9e7/tCdNRMolpnnv?=
 =?us-ascii?Q?EHsj5PdPrvLpLPgHLWvTA59UBEOGqa3NL7AUGtBPhcaPHm/pcxeKGk9qrWmA?=
 =?us-ascii?Q?NSd9hzLHjMYAqQ2w/ARAlfBsGUFCQdFST9e/0Q/fp/roVAtcppo/R4LgwOs3?=
 =?us-ascii?Q?kXaT8geAk7sWWbqbeaA8VyTpAHLPhnJKv4WauIcftSJVro01daNClGfPE1cI?=
 =?us-ascii?Q?Ojfb/Sj9oHNpQraE/WQpmVLx979KVNERQCkXiYBYp+fyKm9kN1JZsftWlPIa?=
 =?us-ascii?Q?A4/vVtETT0ekAmj+3vMQI0P7GfCgSammJI5Izx9uZw+KkPHHYiiAfrD8c8BH?=
 =?us-ascii?Q?VG9Mos9nfk51guRHKINiK70MeLWC/LdlnTRAlvJ6p6cZtJ4VvgJBDKrWBd3V?=
 =?us-ascii?Q?XY5EsDxbLBPF9dqAMeM+93sxCpYvau1JLKq8urW+agCXPJh9Db/7T/q3k2m6?=
 =?us-ascii?Q?+OTQ/tcjTNBf8/lp0JBaN96fm+xtSOlvXdCfBgu17EMSejwS5u961TL5z6zM?=
 =?us-ascii?Q?rFy7ZaRbC3NVRhnlfMV0VKumRWyG8A/JkkFIQzIYbIpZvQtxNzQWyJ08HfS4?=
 =?us-ascii?Q?pRnMtptQzhhMeuOLlW7OgmIDy2pWR5YszjnHAP5a3azSLvwC/F5AMk2/R3Id?=
 =?us-ascii?Q?lQ91uvcaYpSNhv1N5aePzgUnyfflCY4Hn5JURkoOlyAysQGZf4RrKC5NTwHM?=
 =?us-ascii?Q?K4LEp28cF/7ANCh6gq8I4nEhC4zW5SQNBV5shx1REVL5N9/Nr4kCDenfH23z?=
 =?us-ascii?Q?eVuFgCi8C+GM+tAYv/UzKt/VeN2WzQGUJSJ1xIfZpRTU8W9+x5NJcNgrwDEt?=
 =?us-ascii?Q?NIbRqnBLjvRe0B+pKBbAvmyiwEpZzyOh7QpmF+8giF9XLJx7X7oEeUyLMnp/?=
 =?us-ascii?Q?J0toMrAyGHNGInYF7vWiSxEw+QTey5wq6aGklPG7xXUrEvw80mWYAAKZUZ1q?=
 =?us-ascii?Q?na8z3CuVikEjnCix5W8Sru3i3XMlUOGWLnfAn8y3CPzO7WQ7+xaO5O+cZefw?=
 =?us-ascii?Q?E8By+j8uCmmQH6rI+h8lITioH2tHR5LRC3QhrMbU4mRlCAmAgIOUDgQM7yWk?=
 =?us-ascii?Q?A+h9pOHeM5Z5F5gboCUoljzpjhlZFCF4eu1Lq6BBufmdQY0nIcI6KXBszFeE?=
 =?us-ascii?Q?7PxLRG+I2N9b9rvHcesydCuwqFLShG+GUk+2+8lvw4Q45t9E5M2/9ckdKgNs?=
 =?us-ascii?Q?jBT3I4qHEk/R3Xi7xNcTJl6NEUMy7sK5znR/VoYH0VuU2j+qps6IH7Fxf6GK?=
 =?us-ascii?Q?E9nE0MnYUgGWc479hdN7MNZh6rMxG+p9OVUqbmMmLBBR28EgOKuPYNmEmDcx?=
 =?us-ascii?Q?4TT1Nreo1vl3hbyR9m4V47ATjOOQcxOnV9eAAUWpGdya6NhH2dWmEaAFW10C?=
 =?us-ascii?Q?JoGaqitdahjYy04NJYH6zfzfMh51LfSduqBOr79xN3zs6dL4Fm5hPTFmKwew?=
 =?us-ascii?Q?AuW4CBF0DIm7i0Saq4RS2IZg64D0aQA6l6nExJ3+Jx8PHKfmTqIsHzsAquAx?=
 =?us-ascii?Q?hgUjTWLg38DWnugzXoK+NtAf1h4Vr8vuFkKFmouKlf9VJ5IeSqpq+VWPbDqV?=
 =?us-ascii?Q?RDFYcC/5V0kXmseoJh5PTAm48enpaiAFjsPYyNRDycWdZr+jHjjL7tjLuCFq?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f8eb59-81dd-4d3b-0f79-08dafb06b4fb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:52:25.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfNPNhyIqUiM34zLak7KJTX4XWzZUk3SdjomtGCuka6o35cPdc+a6CTqQwLWT5p6GiEDDU27+h2vZk0YKr1UZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:03:57PM +0100, Borislav Petkov wrote:
> On Thu, Jan 19, 2023 at 09:59:33AM -0800, Ashok Raj wrote:
> > Would you recommend resubmitting a new set with the fixes for the interim
> > patch compile failures (for 32bit) and drop this last patch?
> 
> Sure.
> 
> > If you have any other comments would be great to hear now before I repost a
> > new series to capture everything that's need to be addressed.
> 
> No, no more comments.
> 
Great, light at the end of the tunnel!

I have posted v5. 

https://lore.kernel.org/lkml/20230120161923.118882-1-ashok.raj@intel.com/

