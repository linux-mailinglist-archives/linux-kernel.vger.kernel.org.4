Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52E729EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbjFIPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFIPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:37:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C430E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325051; x=1717861051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AW7MLEpEBbS9/NtZg2wka1wNypKuPNvqm2smLe4qUAg=;
  b=RKhC+aTVUZ9F9F0Cdts22BroRyEKVGCqiSP5JNS/KxIYK60zX0OkKOk6
   Kycm02Vp7/ui5FpKzBfYDUh35/yU7ESx5Vy+e6Fd8hJtqKV0j9sRrOQ2B
   LvhPs3IdGIt3o712WzNKIE0UyxwRW3gNt1hhPuu7kdt6n98BFxCYOvLPx
   B10MgQNBiJt2ggE1o33oyaS41/V/B49l6I9CeC7M7eLLTpUwEagy7psOs
   lv6m8P3+jS6Y/WZOq798rAzu5LwTRgpYRsHm0Z0I/glBhqDRVWNp/khE4
   lzppvbz+biW8QSYGWV+VwmleEmvmaE6HTwG522ui+myX3cJAmL1V3lOJU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337259405"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337259405"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="957192149"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="957192149"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2023 08:37:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 08:37:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 08:37:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 08:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECVW/PjD/+D52/Qf4aLt4tB1Nhx1DnmTz3hhLBvnuWasj3AqPR0oiMR9pGd/r6KA3RMYdo6gnjgStKgu8XEfu66t6bzEooln9o/iU0OJbej6r1c3UiTymzp++qN4XpSJlILoCzsxWRkhwLe9FLPx+kpNAoK6Iv0Iv9kF+I92sCnxw4RhoV4TAhf3yX3Acm074SBP1RsaRcpNzV6f0GxUDJ3/QmSxGAnfo/BmRAAOJVbMG/g0WlID9c7QyvXxuSeFxMmARZE78PP8wfOyYzrJMjFgfxSBvOvlPe0ZoiY6/1lKj7vnFuyjF1EnPVAYa8NuhF9sqFkoA7iwM3YvBdotZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUJ+TsP4aCtttJH+BMAh1LvyjR6BuBH4FfRg9EWCo0I=;
 b=aL/zi7RR48RhoY6Cv0iDgSiCu2mMolUTO+jRHszleDiQQUXN+Vpiw/u2oo/8mab5X6vRPjK9+WgAy9zcUzHJa36DpAeunKazGFlORgEwvCPer60FZ2PHptFdBr1HhDqeR9u+34fxDJ/DuFYkXKzuDSa3KOz2f7lLE1qlnEByFMnsU1pBRFmGXN2mzbdnsbD6l2obVEvsANzLnesxUf/vPMCo7PtE1ImwcI4R/yQRQYJTyLh7FSEkQzyHe3VDstNUPyocagp8kaoBuE5wOB7hflD1lgFaLOHrD0Xgi4kZoEZeddG26I6WYtRxoaoTvRMV21YYl2NW+eOjx/+MxkVo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 15:37:28 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 15:37:28 +0000
Date:   Fri, 9 Jun 2023 08:37:21 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <ZINHMRR28jre+Bw/@a4bf019067fa.jf.intel.com>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <ZIE1G9UBAT36kPhJ@a4bf019067fa.jf.intel.com>
 <20230609122828.GBZIMa7OtCIpSkYGxV@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230609122828.GBZIMa7OtCIpSkYGxV@fat_crate.local>
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a924dd7-af75-4923-94bc-08db68ff6e35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYAoSE9Pq+dAYDgKVFW/KczhfAGkP93S5Cmd5RjMD80ZqXuvQ3+jpbs/TAKD2VvdeqUJc04h2zxw7Z6TqGvCd3oUFD8PA+wSSqDCOaVjeqWh8iAIYyD3+ri9XIoEI8gBp/YRQjnHj/LUD6u1trcygQutRQOW6sK4pQ/rEsh3XH7GIgY9EhOHVYbqJz+W/hwELiIztRDz9OEkwMl3yt/f6Mco0Q1GXVrL3s/4aHg224HxyWYsgEqG2rTZDaUTUZ4xpJ5SJF76is0Aw9Bd8zhapIxiNEEaFuVorEhdyRJYb+Qn7ooROQtecwc+5WBvfe45CiT28eB+opOvrQ2SadIc/JLnaQZMUgefA/nFXk++bp0bHCl2feT4G+wSzMtod2LuvKCuuBeq+uor9khoQaK+QEaj8TYJHCulbaTh8nsFKT/HDhRHc41m9WMWlmo0F+cxu+b0BVEpu5kgogropkEPnNkr9yOOR4DvxjmvgIfavZb7SphQfUssbBghypIELFH+nkEI12So1QAT66sj2Wf9XwpRWduEy5jRLOotiaLJFs1kNw+L36ykg1/bivNmf8eC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(83380400001)(6666004)(6486002)(54906003)(44832011)(2906002)(8676002)(8936002)(82960400001)(478600001)(6916009)(41300700001)(316002)(5660300002)(38100700002)(4326008)(86362001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TggZH15zUdj2hftBE1dwTwsr8qOsJ+7mOoUZMhtJtEVf+cBJCjcqa1mHip9H?=
 =?us-ascii?Q?yXToDxE3bno+8b2FytYFn3khHfppEB15AQ958Rnx4UIuLvkbxMPhe7BdPNBy?=
 =?us-ascii?Q?6SOBPLBZZY3qjcpSclKRiiuJzumaBZz6aZ8GbRQ+SPOMEzfdvS6BxNBUX33s?=
 =?us-ascii?Q?zG4V5KpAdTLmdVK4rlkT8K4bhbd1Nmr0HU9/miM5tuIW3JqjhZOvZBJYlUPb?=
 =?us-ascii?Q?H7TCMSWbnBhhtgnnbsP+E8Q9zKeaEcQvMmuU00VOCjy7tVWWnISgw+EZqAiX?=
 =?us-ascii?Q?xViT1RjMnuaq8AMyFQjCE1tMv4VQoL8xEhJAEGiTzRxea6F0XIYL1eP92a0s?=
 =?us-ascii?Q?thkIcmwb4cwtd7EywxmqtohrdoqLkmYGHlwvE5KGEGKbg791FZzSNtkh7gjv?=
 =?us-ascii?Q?mTXCdIE2YQri5UDpN/dv+L8FgyXokpU9NeL4j0HhNneoEptTZb8SZ6ji/F0u?=
 =?us-ascii?Q?81iP9gxD2s3xO+gAXugs5J7CqnKcwbO7vXV3HAIIIIQkJ0yvHppQJABmlY/c?=
 =?us-ascii?Q?1uTaRrpiYAGBcFCka3c0b+96sBbU8Lii5DyZIm9xyahChuAX1weiiFmvyo7y?=
 =?us-ascii?Q?2Kcoi/1u70/YvvXkq/lWUjwucjktN59qkWbSihDem+JPTYaLWTvJUj7M6Euj?=
 =?us-ascii?Q?OK5p46AGtG2B7iA5ngE01SGm4gsgKfSSsa6Q6ELzjxLjy6Us7EHj1gAhmNxK?=
 =?us-ascii?Q?eznnhe4FJXEpsniS4FjatCMzY0/ESaHDT9yZt2P4qdIhPvhB50S5664UK6Fs?=
 =?us-ascii?Q?NPIHDPiRMWl/5XiJNhMAgc57+89WUuyb/KSx6nnIm8CmqFO4AK+iGzSPL3dv?=
 =?us-ascii?Q?ERy2BdLlSTzU+jSUmOS2Ix5Asw9GuhNUbB7Xripdqj5NXDbprTagewT3uc1Y?=
 =?us-ascii?Q?CBV47RyzStibEz+W6ym+/UGIzhe6VLXHx2J1U38xFK5f6Ni+RgQw5xadvt41?=
 =?us-ascii?Q?GFEAm+Gbd/kQMFx1lH+qF45ky5oLJXWWfp2iGdzmeyniUOVJIdToWzMQoqsH?=
 =?us-ascii?Q?aUj3/Y4vnKsBEqLZ43DCZU5j6vneo9Okr2wrUVApey+tefGqTHNcXsVrgPG7?=
 =?us-ascii?Q?OPMSWrGgW9k7xJYAAQKrYWHkzdoOntYc5RCD8u6s4isK6b2Lsb5QPw8gUrRk?=
 =?us-ascii?Q?yJRlvsgmMJXtmtT5V9sINYzVVwg+CupjG43EdqqCwQ+XkKdZFpLZDr/4vbVJ?=
 =?us-ascii?Q?Lf7mJrpC8dahTyLTbK+eqOUfl8DssIjiEa9n830CNJJ5egtTzEOZSymvb+MK?=
 =?us-ascii?Q?UDyw6edrZAN+pEZxTpxlDZ6OSI5jyN8AQV2zKqg6iLMK3xgVJwS4gmXVSOE9?=
 =?us-ascii?Q?FUC4tT8yTMNhlzKv0iTCYxXNPtJXS3zxRUz2EftF9UVbh9fLfu87gglGhll6?=
 =?us-ascii?Q?BK3u6eisV6Tqeiuos6rwkzBn9iXYnTaiiwmMT+quegaG9rGKLz+AJdgv7GGL?=
 =?us-ascii?Q?z7iI3166g/dshHD7wswekoGj4UL81YXm6v016PUbDaQh8Fo3u4o0nBQsmeho?=
 =?us-ascii?Q?fVGyTFMjm7fQci9qkyO4I7AFAhVdPhoISGLHBW1GntoE8TdEMtRMS7CMbTH+?=
 =?us-ascii?Q?pyUizhPRGDYenm1PbKb9eeFGiUwOWf8kjcZa92BJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a924dd7-af75-4923-94bc-08db68ff6e35
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:37:27.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Umj9V2EySX+OzHiq4SfrOMyV2fpul0/XDqJv5wm9AOR8GrMtkZbjveju8vEmisUKbOG4xYcJUDVumcotF+2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:28:28PM +0200, Borislav Petkov wrote:
> On Wed, Jun 07, 2023 at 06:55:39PM -0700, Ashok Raj wrote:
> > When end user changes the behavior, isn't it against the design
> > specification? And if so, should that result in kernel being tainted
> > after a reload?
> 
> That's a chicken bit and should not be used usually. I'm adding it just
> in case.

How about a debugfs opt-out instead? Say something like 

/sys/kernel/debug/microcode/debug_control?

Since the code doesn't use this in the early loading, it appears we can
drop the cmdline entirely?

> 
> > Is this reload on all threads required by all models, or only certain
> > models? I was wondering if the forced reload could be limited to only
> > affected CPUs instead of doing it on all unconditionally.
> 
> Unconditionally.

Thanks, this simplifies.

Since this is quite different from what the "typical" HT behavior w.r.t ,
microcode, maybe good to document this behavior in microcode.rst.

If the user switches the expected flow, should the code "taint" if its opted out?

> 
> > Shouldn't the "control" be under LATE_LOADING? Since this only controls
> > late-loading behavior?
> 
> No, that's a bitfield and is going to be used for other flags, if
> needed and which are not necessarily late-loading related.

My .000002c. Maybe add such sysfs control only when we really need one,
but should not include debug use.
