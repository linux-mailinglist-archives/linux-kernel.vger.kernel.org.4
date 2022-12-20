Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3629265172B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLTA1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLTA1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:27:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0081140;
        Mon, 19 Dec 2022 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671496038; x=1703032038;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZlutFOiw2IEGpP6zriYVBCcvEVQeNjJWbpgWwxKtFRA=;
  b=Nz9EzyCPHdOrVOfMdBU8L3/k/Xxn1H5G28DqVtJxWQRjbyXh35eSPIXj
   3uxBny5qE1oQmFgNe6okf3GD/jrYguUYw/69wGa/Su+ptAc4epoVh2JRZ
   Is2jTuQfqceF9o2HVPlcdY62Ut517pEjdmWF5wnEtBdT9DYI54amvYq2N
   SOOpfehOY2OZoktuovRwiRS66jRVXrf4XomuI1kafZCXj9VriIwsyp2/n
   loiP/XhQuNsILmyJPP57m/o2yIwAY8l+53isYzK7l518RRQIZqTVhTS2r
   /sl7v21HMAKLXkMeIbrIOKvt0hk06vEPBz1isbDH/qKJbhAxcokI/biKi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="318183034"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="318183034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 16:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="681436254"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="681436254"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 16:27:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 19 Dec 2022 16:27:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 19 Dec 2022 16:27:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 19 Dec 2022 16:27:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3SktfeWBGS7cKEXJ9x1A+bAs06zo3n2eOBGsTTzsMdXLJQPlxqyvmskI14OeOeF2RrlOOk4wyy9cpJJ4pyAMJb1Ng0nboTzQ/J6G26BC6ZqEFYfP1Y/zAcuuV6NsLtf4iQhUHYgau09wzMXCr1HwXokXOFqoJxU+V7QTwOlYeF3rxlCUT6PT18ie9QWdv14nDE17ecc6XFEpFuzC2eOE2gsR8Xz+EpNtcQ1tjvBIqyGqz4q6TimCxS6y9nG0UHdqY1RqVdg4YSPIwvAExN8k3JbIR0vS1/3DgO2e/gKiUxvlL8A+lfLeswRCGmiGdQCF3Whb3NfUIK/vlWRJYUA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6trDkszlHlY9vjya0y9CrzTUuhypWWn47N942qWqdM=;
 b=D3Qe4BM9P797hQThWf/+b2rfFCw0nBa/+K9HJavQai5xc02cTIiVT0X2slER/Ovwl9TSDQ99jHAxkERVnkM80k3kUS5lVau6LI3QEVqUz++idiMYW/eayR5S4CNoU8rDYqYUBx8Kod2/jEyRcgFYUW4Vh4fiOHax69FYaja+RWDfUmUda14gwiJ3EhS8Kc8lTyW1q3IMv/wvH+9WzdhNU/lP//fVLw9qzZsNuZrFnSkyFlht5Iy26Fzq+EXi/7/Kx/beeNQp/2TBzA0FS3ILH+RjIiLW9M5AsPyl8v7Yk95cJ4JC3byywqJSvTLxNOhuSh6gMqNvuXnDMjihPC/zyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA0PR11MB7332.namprd11.prod.outlook.com
 (2603:10b6:208:434::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 00:27:13 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 00:27:13 +0000
Date:   Mon, 19 Dec 2022 16:27:10 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <63a1015e6ec4a_1bf22944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA0PR11MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e36756-d492-46af-228c-08dae220f0ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDI9peSqCT4I0glwr+8x5IlQ38e+wRvtRNVwuze2PyDEvpZ3QMtR8ThY0eVhnOvKG1t3OufcfaXIHQbLKoqEARp1neEiiX5e5auicPK4X0XFbaZ/RcU6aoqitfKiGY0oSZ8mFr5yNwCFZLfEfKuu762VeNd0pblAFcOV9WehjuflDedn54teAlwOINmots0ASxgLMqJDj8UGTSH8870cROXvtTdJfE45xifDLtadplp0EHmBI+ulsN4jQeV7mtBaTBemMIjy2UU04dMZI6xFKvnJu6ZLrP77fWX5qnTyhZFG5g4MV+tylyKkRdxJef0YA/rqiohdkli7QHSCb/QUgN7omLJLe+ytmPCbDvMrUtZwh+ZBIgc6KJfl/lUe5UYFrihEDoBPaPg1sha8CfhVcyEnvKoYxYrqqOshK4gCYTo+r79FBDa8yYbhKXN3SLxxGJDMvtj2aEBMzN+sEy7dgHuABFdYTZJ1NqJf0tdcTi7Cxv4sVc1dJqVoEdv6J1B2hLyjHmsyh5VD3Z6OKNLA0n30LEb1rHI+1XOycYAcu9fCA+RUYomllFQJun2eRP2KZNjExw7SHUBcz2i9Q1JD6FHo5CX6eGHFundnwvjManbBNBnb36uk1HKB0ybJGTsMkeuD7RjMe83i9COzpT8MY1L1RtNqamwDpAKa/gfAdko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(8676002)(4326008)(5660300002)(110136005)(66946007)(66556008)(2906002)(66476007)(966005)(6486002)(478600001)(6512007)(9686003)(6506007)(186003)(26005)(41300700001)(86362001)(83380400001)(82960400001)(8936002)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yR4t+tkH5sdjZDFD9vrVEj8v4oII7hwFTf0ksOJ7AGUesW7pwXMts8wQ8FJ8?=
 =?us-ascii?Q?YtJGr/RR3FcFXTJOFH5xCBj8EDWRxWdgP4rs6bgjSfYXJVdRDDvPWdUvLmbb?=
 =?us-ascii?Q?0eMhv1PG5zfLelrdZjQqHO9d3fCcGzaJZcYvcyP1gf0z15SirSdkq2mP3a4p?=
 =?us-ascii?Q?mbn+ibWX2+Mv+XRcWS/RUeR2VB6OkjRdptQ4g7G/NV8Xa9TXLKgLhXgSK5xe?=
 =?us-ascii?Q?6N2QeYuh0UfNw+N0Xz26Z+XH14bDsfgXR0ReoxHVLBvrBG0zGATRyqzMjLPn?=
 =?us-ascii?Q?QsLTmhHpZJ7aBhWP7qtOAi8kk4UAaQtIi50cIgxuBJ7EfwXeB7nOcZalBcyG?=
 =?us-ascii?Q?e1W4Vhke6e3i+MfOTVuaVSpxchnLvguR1nHLFUz5DreMeEeA65kv/M2k/Vkc?=
 =?us-ascii?Q?XIQhkc15fYgn3CXCPKvM5664Af0/Ms9LznVZEWqmU0OPEi+Tc2TUR43kGJql?=
 =?us-ascii?Q?IgM+XMtbVjToQVP22o2+vUE14NKsPHXASy++YPbOswlkpzPwfdZhxrq71fb6?=
 =?us-ascii?Q?efLeuUYE7gWApAwm26gXU1f1x8FJr9l4jHFwzABxlIyMFjlJmtvChybdE7Oh?=
 =?us-ascii?Q?iuI3Z35uVEPtFevW3VGfdEGBj9ySkS5F3nylGAyY2g1eLrCW3FxDmsTw5Rwr?=
 =?us-ascii?Q?aPB9RfdP8KIWJW7fUWRSXUoG1jnPUDjnpPyh1PBpnp4Xnla8AeSuMWpjR3d/?=
 =?us-ascii?Q?gZgKYuyiSbGD/n+AfZrXhKEzx1VdjYo/8hasg6yBvyX620qonXxPTER3pm2W?=
 =?us-ascii?Q?lbxVejVuh7cbCy6nAzcX24m86ARnt1vC6+RidGSq16XVw24B9UvqBQ+ATaKL?=
 =?us-ascii?Q?jfEozUAEE8awLIQNk0TLyHkbB1m66FG/dFvlM4ldD2gl5f/fKMIpg71pXqCq?=
 =?us-ascii?Q?Urj50p9zc87d8rmPxbs3ZyjfetFZ4QcDCFv402m6PvdoOTMa85AkJaqZoPq+?=
 =?us-ascii?Q?J9BFANJK3AzqHiy3evm5LLLxFTGy3OH7KCX2kMngGZ5F47cwWvenH9y3LV62?=
 =?us-ascii?Q?L79yCg61m5VetWQAuDcVkzuU99Mfd/QJHyCiUbnEw96dK0BsfjiGaXTWVByI?=
 =?us-ascii?Q?fJ+5616ylQTYqc4kng91ZinPFN0LCBgfiZosyr6me6bKZWHEEjNLhjmdabjI?=
 =?us-ascii?Q?gKkE+v5nN5kZtzS0Y5sDimq73Ro3SH5WL/7hTi/c32csrMcnUsdGKyPfp2QY?=
 =?us-ascii?Q?2eXDjNQIXu31BxZD6O/cd11Pxghfp7SYNVdad+MDkBIs6BKnM5Q8/mqgU9iC?=
 =?us-ascii?Q?as4pg5ZNf4UOzsmRiQm3rwywxTPENcOw88TfIuXnhtts1uzG7J1j3IuuQjJ5?=
 =?us-ascii?Q?Y9E7AnPdhneJYDR8q06Pf3XjEVC4OzqBf4TbkyNVZMmz+rzMawXu3NRKOCi+?=
 =?us-ascii?Q?Cq15M2tAWk6glzxu1LXe24HpTiayeJKqT7dqN+CmEDt87qpil2flRvMZCJCr?=
 =?us-ascii?Q?a86zN3Udr3DwsjtT1H4w0k5Y6YPy7L12RQVegu1C5QGlES00Qo5Xrho4zlpo?=
 =?us-ascii?Q?LXjV35eIA86gf8+nSCYSbRlTq7ixbRdpEBAlTpSeLzpkMKPVbG6+fwTdzIFI?=
 =?us-ascii?Q?fXFUf++O3KTB5Sx1xi4FdBck/O+VH4fqVzu2GHAIvyybt2huGOmKEOVfGraw?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e36756-d492-46af-228c-08dae220f0ae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 00:27:13.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WcHYOdm7Jc6s9gqa9na7R8NkHoahBP16m1o/3FdhjERS8g4gDvgL5wkcp+W9L0pdyfT0QbqqScpJcDjif16bFZ6OULTImWwPtjZak0eBLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> On Fri, Dec 16, 2022 at 08:55:19PM -0800, Dan Williams wrote:
> > In other words the suggestion that the current
> > organization ultimately leads to bit rot has not been substantiated in
> > practice.
> 
> On top of this patch I just added a custom debug patch to my tree which
> enables CXL_BUS and CXL_TEST by default when this is currently allowed
> and it got quite a bit of kernel build warnings. Although some of these
> are specific to my change, some of them do not seem to be related to
> that and likely could benefit from fixing:
> 
> https://gist.github.com/mcgrof/73dce72939590c6edc9413b0384ae4c2
> 
> And so although you may not see some build warnings so far, it does not
> negate my suggestion that having cxl_test as a proper upstream driver strategy
> gets you more build testing / coverage.

If autobuild coverage of test components is the main concern then
cxl_test can copy what nfit_test is doing with CONFIG_NVDIMM_TEST_BUILD.
No need for disruptive redesign of how this facility is integrated.

> > The proposed direction to move tests out of the ndctl.git repo into the
> > kernel solves the wrong problem.
> 
> That's not in any way what I suggested and is not the point to my patch.
> 
> The proposed patch does not suggest to ditch ndctl unit tests but to
> *enable* also sefltests to make use of cxl_test using the selftests
> framework, which is very different. It is not saying "abandon" ndctl
> unit tests, but rather, "also enable linux kernel selftests for CXL with
> cxl_test".

I think centralizing test scripts is a virtue, and right now the
momentum is with those located ndctl.git. This is why I jumped to the
conclusion that the long term direction would be to pick one location
for maintainer regression tests.

> But more importantly, it looks for the value of proper kernel
> integration and making use of kconfig for the actual dependencies
> and requirements. This is of high value.
> 
> In addition to this, one possible area I see of value with this change is the
> ability to also use the wrap feature later, even without cxl_test to enable
> error injection. What would this look like? You simply replace one built in
> routine as you do with another which has sprinkled in should_fail() calls,
> which otherwise would be an eyesore upstream. This shold also then not
> depend the rest of cxl_test stuff, but can make use of building
> alternative wrap routines which could be replacement for upstream ones.
> 
> Another benefit of this strategy is you can also test cxl_test *without*
> the need for for requiring modules, which some folks prefer for testing.
> At LSFMM this came up for instance and one of the biggest grudges with
> testing some frameworks was the dependency on modules.

I do think this is the void that QEMU CXL testing would attempt to fill.
