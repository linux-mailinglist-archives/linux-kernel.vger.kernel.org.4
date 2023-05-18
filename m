Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4668C7083FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEROhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEROhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:37:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B56DE;
        Thu, 18 May 2023 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684420636; x=1715956636;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q4eaLeAzRS0On9BpCaCQ0yg1gdvx23phnR/kdAUXdqQ=;
  b=NpN4NBr/wUon2Pymm11Ilv6RHavNQXKkTE+NVakQrXbfktgD/q84NVj2
   lTkaCjlWrMMZqHrJurh+PtyXkQMPqb1305oidbjWaDSPFQReEFvGWYpIM
   H08JvTNRDhSuEnpnpdJYHWbz7yZdAb6ndRtSB/ezKn0h0b99UvEO9Lx7y
   ggmR9rpsagMjvnqelpWnafSyPaIKsslFhTVA45zciZsEcFDD8xDtl7JOU
   vQJctTMMxckK6vmi/WyJMZHxPmLP0QGSp8Hx61G0ahYRzDSMDALhOU5Ir
   CCOjhCHwBCDe2QjIpg9EjMd1Na4RPEIRzc2Wjir8VEvs94RRtly/tvIdw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352097444"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="352097444"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 07:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876450532"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="876450532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2023 07:36:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:36:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 07:36:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 07:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihKjYMZDa4A2Wxsj6PIHSJSaSMhNARgilkd3RATrglj8hWyKr5210DGSGRyF0CQCyA71zjlNkJblzrmbHVtF5YJj/H88kIK8w+LYyrm4rUtpthnJy94GbHf4Z/9DVip2DmUW+nzOxFuo1KA2fo+oA2M8cC1vEFbbbbYrwtqSmxhGaA+dwFy6+3hnDXkr9hB1JDwnQ23EYprHlTdhYt7jVUXOHys48Gie6RqP96ekxcXKGPBjyHuiMrpkCHRJ9MZ4jLxDO6tO85LXZ3ldRLlvMDA6SZld0o+79A1U/c8GrEWEgc+AGDFnbSqZR8e7ywSZL03hdX91396qCWcCQPHgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7aFjtwoOUXz8EeQfCv0hd9yVYESkWCcDJGP2MqwgyQ=;
 b=UsTXXsGG5sMfl4pCEENKqLnhwffp4PshZhdTChzC6sHTm1nO9tJGiWwhkpCk4FQ5ybigMzmijyTpFlNDGbIMCCEyamEb7GzrQeAYx+5l2moBDg4kjM32bR9ztQxHyANrtv/AJTVeZnw9Wws97pct/ctPoSbQr3mWsVDx1D5hCACz/qUlm49bt4Aj06T15UE3AOYrQpr7EOv1njumzDeE/zE9Hmwko1q/4J+6gdfcQw44N6J5gWnfGOFyigewDVM8eXrapSnibVghi585uP32HLpUAk/zA9DaHUtvsJjiqwpiIMdVTlwROYeuNtOw809zfu3A0OHyY6wA3Iizuj03Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:36:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:36:34 +0000
Date:   Thu, 18 May 2023 07:36:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools/testing/cxl: Document test configurations
Message-ID: <646637ed846ae_1111d3294e6@iweiny-mobl.notmuch>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
 <20230518105020.0000424a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230518105020.0000424a@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d13fd2-aab1-4f09-903b-08db57ad4782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6nVPHmO7/AmTSbCWfkT6y0cUp4cEao9CZ7RZRMaD+Yufnz2CVHPsYkZCXXTqVL4MUZ0m0wBfSiOEiBL8LvICVvL6DnhXD31DRfbvajx6Kei56obNhpDj75B485izO+9RMI6mI/OW/KL0H5TUtzk5k1f1s9wU8wci1x7ENLgHtetxm2XV4kA3+7J8FGMUgqp3roUGW6GY1sGPYZRIs76BNHxLCRUXzEfjazHCn3KCKKrLqfFnkaO5t9OeyyaKVLxd9Zo6JsS4PgZa8f/CyObwlE5p/FAXTb7RWiqQs2ts3iPSbY8kbKEXPKHhJQRZGyZGq3uPdUCG5IiTKT8celi9Zv2jU7kcFY2mGaslURhmktDSIwytH1gIP6PIQ3SX1Bs5HENL87Up0bjkINedZqyN07n0QDEIFkef1e996va+XD4aO7o9kFl+ofeRpwvs48iphqKAzwRG7SWUHpBJWAlC6Vthto+fMAOCfF0c/YPosi2vKc01m2Q+Jb2QTNS1KXUGrOJDkpx+Ocd1QOXGN9VjsyHc/7vuH6UZrCE33jU5JWAdC8yP22wqbb7nPyD7pFq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6506007)(6512007)(9686003)(186003)(2906002)(26005)(86362001)(83380400001)(38100700002)(41300700001)(82960400001)(6666004)(66476007)(4326008)(316002)(66556008)(66946007)(6486002)(110136005)(54906003)(5660300002)(478600001)(44832011)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mgf5+uJ7Y+2Q6lT2ICzUYGjzy/pgEZl5NC16Aq2FDKtBfqRpWNO+1h50kypt?=
 =?us-ascii?Q?DnFyezFIC/uDbOQ8p6FNjcFULA4BAfn1OyhUW/qU622zJLVpxUZYQyVOHCyj?=
 =?us-ascii?Q?RRmI4l8pgstIqf/JIapS5MWvqgSkOFqgD55wIsK0DUBVW+v5g9MkEtXzPmnF?=
 =?us-ascii?Q?664wC4iH8TZlWsmrfxQ8daBQ5xcYeHJOz07nqHBU1tDZTKByEteRFYsYoSMf?=
 =?us-ascii?Q?fxLoVqAMUn9OSliui+vO0e4R0HZnpibzpEKLYQ4hRG+vHZ1ut/LLfy8OK8Hf?=
 =?us-ascii?Q?hou1SH37VkjwPQpkB+OykK25fAhpv8nVyjz4YPGfcgYVDpRl+vGXx1fVDBTA?=
 =?us-ascii?Q?ZJcdwl7uKmHeaPIHJkkgYAvjaHUN/UK7WeA6q6wAGBzJ8QpwmwlX23eGu8PM?=
 =?us-ascii?Q?Sht+Z0SeARSMmiA8bW36RCFwTueMy+3HIUl1UMIEJJfLYvmXahVf4bKRsBuM?=
 =?us-ascii?Q?9r79M/mzBXYEtFg62lbWdv7kYyAxIqZJqIS7UjhA2LX5XyjQO7ZnSmP36Y5w?=
 =?us-ascii?Q?27Mz4Glbf+uhqEotEeU1NqDKokulXaTGci2NkHxQYU2MCL76xKM3jKySFMjz?=
 =?us-ascii?Q?50dJGxUl8te6pOFi1NlEqPZqYSSMiz05KeHTj9WDatcqh/11e54Qa0JDbduV?=
 =?us-ascii?Q?fIeZBBvOoZiri98vvgSHzH6mddKniRsx/WJS35FDMWG3pkqXWVtRKZuMuKOX?=
 =?us-ascii?Q?wPzyNnax8jnaxqdY1QgAtGhLwt3Yl66wpMNgPUQzkUD2ZywIyBvoDb0awwNC?=
 =?us-ascii?Q?SeWV9dLr4CwgdZb3wxrHuy5l6wH7lqCxu43D9UY0wUxYs02n7PKsQTPP+Us0?=
 =?us-ascii?Q?FawUXV0mHb7IOKqDv0Z4Cc0RhgSr0DWXN6KB8n29h2CHuPXG9whF72EAzzDA?=
 =?us-ascii?Q?HP0ejBP6oSmYEJYbwzjGh7yDMK8yzS0blsA9jImQc48Hpznl/F5tXXPApc1d?=
 =?us-ascii?Q?dtLK2ckxiBW6lUz8DsNs5A8UqAcn/vFXNirqr28RVh28xqWIIWDf8fu9WnbG?=
 =?us-ascii?Q?zrV0Tj8ccWYHPknPiQOUPxAqqpXVMkwA+i6XzJtzhrAQfigATO6/XO80B0xk?=
 =?us-ascii?Q?7g5O4EnhnvPCOGHbpGhK+yLQE3nVoldZbwr8eMtJTKu8kHb0yP4O3PMw0iE2?=
 =?us-ascii?Q?z+r+mbRzxYQ0X5zFpnnQetLK6DKHlL/gF8Lxs2kqsydVcR6RH/B79aMJg87F?=
 =?us-ascii?Q?bU6hCtI5iYerpSlaopOrtPrrm/6QUpJn/tc+PKuZu4d/iNDOiGgIfO/H/HSb?=
 =?us-ascii?Q?lNPnQyVXMY4ijTnEtfFSEIeTqb/OFhLDBU5zaYZJzfYYMR+Ms3SavnPfL4QW?=
 =?us-ascii?Q?5pDcs5HxE+WZhPqcnnO8VecPxB+TrHgwJ6nO1EibGpswXrzvvdimUCf+jzIR?=
 =?us-ascii?Q?UfY8rYU6T4PxC+isFzjkDb5eBiwK9VGtgdcPe9tW4CpnrF68Ygx0eV8VMWbT?=
 =?us-ascii?Q?p5UJEW5/aqyfDFv9quyS0SyHcxk5//yJtv7sOVNZ+jjV8P9wJbXzNGWGskfX?=
 =?us-ascii?Q?5yyPxeb+/hDCZCCnpgCUoZIWiOc8iX+3aztKq8XBLLtXurwA2wgZy3wWNNrZ?=
 =?us-ascii?Q?00UGbvl9g1W59dX8MGj1kB+/j+UJKRNl91WrAAUF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d13fd2-aab1-4f09-903b-08db57ad4782
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:36:34.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSwEBPb1gvqUKytKF10Ig+LsmrphkUxX0Gbs0gLL/eUCFHFLbANRNwlfIXigTy3snk2zCFvaJM9tPqVYw71L7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 17 May 2023 14:28:12 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > ---
> >  tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index bf00dc52fe96..bd38a5fb60ae 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -23,6 +23,31 @@ static int interleave_arithmetic;
> >  #define NR_CXL_PORT_DECODERS 8
> >  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> >  
> > +/*
> > + * Interleave testing
> 
> Doesn't include the cfmws, which will be tricky to draw, but maybe you could
> add something to indicate they interleave over the two HB sometimes?

I was mainly looking to document the devices below.  Because they are all
'platform_device' and they are assigned type in the code which made things
a bit harder for me to follow when I was going through it the other day.

> 
> > + *
> > + *             +---------------+                            +---------------+
> > + *             | host_bridge[0]|                            | host_bridge[1]|
> > + *             +-/---------\---+                            +--/---------\--+
> Text for host bridges is right aligned.

Ah true.  I used an online ascii editor for these.  :-D  So I did not pay
any attention when I copied pasted.

> > + *             /-           -\                               /-           -\
> > + *           /-               -\                           /-               -\
> > + *   +-------------+         +-------------+       +-------------+      +-------------+
> > + *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
> > + *   +------|------+         +------|------+       +------|------+      +------|------+
> and root ports are left aligned.
> I'd shrink both boxes so they are same as the switches below - or expand them to give
> a space on either side of the text.

Done.

> >  
> > +/*
> > + * 1) Preconfigured region support (Simulated BIOS configured region)
> > + * 2) 'Pass-through' decoder
> > + *
> > + *       +---------------+
> > + *       |  hb_single    |
> > + *       +------|--------+
> > + *              |
> > + *       +------|--------+
> > + *       | root_single   |
> > + *       +------|--------+
> > + *              |
> > + *   +----------|----------+
> > + *   |     swu_single      |
> > + *   +-----|-----------|---+
> > + *         |           |
> > + *   +-----|-----+  +--|--------+
> > + *   |swd_single |  | swd_single|
> > + *   +-----|-----+  +----|------+
> > + *         |             |
> > + *  +------|-----+  +----|-------+
> > + *  |mem_single  |  |mem_single  |
> > + *  +------------+  +------------+
> mem[0] etc?  Also swd_single[0] etc?
> 
> For consistency with above.
> 

Actually mem_single[0,1].  yea swd_single[0,1].

> >  
> > +/*
> > + *  +---------------+ +---------------+
> > + *  | host_bridge[0]| | host_bridge[1]|
> > + *  +---------------+ +---------------+
> > + *  +---------------+
> > + *  |  hb_single    | (host_bridge[2])
> > + *  +---------------+
> > + *  +-----+
> > + *  | rch | (host_bridge[3])
> > + *  +-----+
> > + */
> 
> Not sure what this diagram is illustrating...

Just showing how the acpi_devices array below ties in with the above
diagrams.  Mainly that their is not a 1:1 corelation between
cxl_host_bridge[] and host_bridge[].  That index 2 and 3 are other
platform devices as shown.

I could probably make that equivalency note in the diagrams above where
hb_single and rch are defined/documented.

Let me do that.
Ira
