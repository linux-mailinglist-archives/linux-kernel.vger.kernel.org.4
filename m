Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF43B6188BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKCT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiKCTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:25:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244ED20999;
        Thu,  3 Nov 2022 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667503543; x=1699039543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8mg/LLHKvlXWAwb//Hxf0fs4DaNorZ+m2RhG1QSTCaQ=;
  b=F7UwQe49T0xc4RPPKXv1HShgC5DPKuAzeLVPsPY2bck0YgCVYrmjf9Ht
   uR1rvK97uYdXeOw+a/lzb1ceD/GYV8F+uSdoP/jPgjcmXj+6oHqpqi176
   bnXD9NDJTzEkEvbh4nlu+MMbLBjxFHEo9crG37r4qa9PnaX7vRA4WqNvB
   YPHpLX2cu3IoMVfYaiiYDGYTyj7oJYx/mDsyiU/+XgJpjBTZa5p73m9gg
   +pjDQoe6s9rNmsTNRPzdABUKUaGqZBmQZRuE9NVmqZ2G1TMCp0+pVv7eu
   N3GojOTmDQYnqA422ct8T5U35C8cToNfKC2XNIAVEmmbzc16Slo6EUTf4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371888054"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="371888054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 12:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740321833"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="740321833"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 12:25:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 12:25:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 12:25:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 12:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxERbbLzpv8427n2bZAW7aLZ+LSrlXtWY2lcn9ScArmN0oNJoJJSnyE4X40HCWECNUG9o4RJ4tKlyjN4WIedsQrNZi3LHdD44yEqLC/N98lSdD509jg6o+8gIlOmSBaCzCOGblSASHEB6fWTf9JPtwNj/8XTJk/CKK37KPSYmbSCe6s1YIqym/JjOu/QP48LZAJd+Uv4357lBvOcJGLers1Pjyvu9YOJiqovvztoYcIyM+tnMGqLQ1QUSgney+0GCFPDPTb8/vppNz3ooP0iYzjV2bBGMjK5gco9eKLQjEtZsvkpxJbMq3+AlsuOKJD3RdWQ5aKv6AOqclZPUhk2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txHpWn+e7Hl9jLEltVM7vkBElg323QHI5+REP8FE8Q0=;
 b=g4b65YYC1EPIyx9f33u/XsnzM24s6wui6N8ZX4K77DBJnJirXOm1lPes0I9+M1mVicq6G48myR/UcNfoYbhM2TSnXBaEIVVT16dK+dZa66AmrRT7Fs87bOaF6sti+qgomTpzeYFabLeA4KKG4z4RJOnaMwu1yx8TOR4woyJD2n3mnvuLq99bSIwgXoUSJ5QM8b0FEzc0wZ8PNOyFQMf3Tx7vIC/xkoW/4fPrlTYiKaajGatbx8pukb4rW5t3BELdV2352hh9F5DJykVVbD0bE6eGULL6yJN8+yblSAsYc2fYk89cutCFCE1OuNndxeYRFeDyIRjGgLLiPUUoUpOcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 19:25:36 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5769.016; Thu, 3 Nov 2022
 19:25:35 +0000
Date:   Thu, 3 Nov 2022 12:25:32 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Message-ID: <Y2QVrEGkfvpT/2KB@a4bf019067fa.jf.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com>
 <Y2OnHuSHgIMGxcUH@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2OnHuSHgIMGxcUH@zn.tnic>
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: ec207bf0-e9c2-457a-30cb-08dabdd12eb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9J+82CSAfsF4wtshhK8kevI8f+H8TazXgLZeM7KAOS/ZAlAd1r7JYwUastDANplJs8YStHNICeNHJNkhh5ZPxsQ5Yrd2wWH5JRK3KWKWHBTG51vAM82qnmFY0oYTivq9YVNaZPaB4cSQaXpsXmE4e07se5hOF0VCqDV6evylePmpyuQPAAJS5XMYmRCKgphwkuw+bgJeBFESHVtM2xFGEfVyKZhK9FX1IfmvcpclKe0qBPJnedZ8g57c+dJtcp+MpsQm3QSPsrrbNpkXKNVy3gAuHzSLW0NDslCPEK0pHT4pJzOr2P93uPN7+oL6c/e1IShYybSyHsimkJPeM1oFlPnKF0k+XKaqcSzVk2R8vmzCBvr5L5GK4jGL71oYygR+1C2tniabf2/Qpy+XBof9uhXuDxzBaMwLikvwCTEA/Hu0PeDBnDIsqZyT8YMuWUG4OyqgdMRwBBdwBvQe+QLLN/2jwQdSudzTNz/TGvB2teNwt4MM0S8ZhKoeVda3w/OPWC4L5mploB13IicZHiBeEkaIk9KZkEf9LgyqwjNPNjNL2vwUmqvPALMx99z5bFB1k2SFOVZzJxiBD9fxejyIOsCbdEGLGTWpvaL4+DX7JDizHpUSXh37ES9SrfwcBG3e8jcD02yC8Bgiu/PZ4UJfBlhvFQLGRhc3M+iTEhgFZV6VZNRjEmFcQgcLaO9po3mdO+uIpASKPvJmrgJ0YvOI7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(7416002)(44832011)(5660300002)(2906002)(8936002)(66899015)(6486002)(478600001)(54906003)(6512007)(6916009)(86362001)(186003)(38100700002)(6666004)(316002)(26005)(82960400001)(41300700001)(66946007)(4326008)(6506007)(66476007)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IPQgG4UNjdxJUZEpdsk6C2qMn9ZoPyi7OIm/Rp70moKQpJ5n+fKUPpKjNCns?=
 =?us-ascii?Q?5h0n7/gYHmOy267eT9aiKtteNQA6S2UhPQp5YhcyG8295L8J7UjpjE/ZNfLB?=
 =?us-ascii?Q?Kk7UyUAlVagVK8jU7McAPUeADM/UwVXgJdDal/zb8rtn+MfWw/+bQgshKLM5?=
 =?us-ascii?Q?89+qIPwmiO7AY2cC4s0nV+IAYrHJrzByBS4TER/obXLD4qTMbQzSpsWyAa0t?=
 =?us-ascii?Q?jQlqjFqDhQMQZX+h6HfqeZrO2G95kQTupq6lamih1zlaH50JgTZ1apQD4NlR?=
 =?us-ascii?Q?2boFt8+wH6dkVbzn6/vNjKElkYRF2ZaVpMCMv/Si3s8RXW1Jmcss9gqy6We0?=
 =?us-ascii?Q?AnhoCWMUOCfpvoib31xxxdEyMiVJtraHGdT54x7HtDrboWH/6tTJ9xMIU6uG?=
 =?us-ascii?Q?+LCJEQSogGKSGMBCgqoocHKHLmmlByo0ad3Ubcy6BCQRrFWEzXjgixYR3AA7?=
 =?us-ascii?Q?4d/XsDdDb63Y7nuzzJqgsRb8/WCwu+5flIPEiwKqHOaWJRNKmMm/DjfkIiVf?=
 =?us-ascii?Q?2tJMiBovTa7zJkgq11PERRYsO/eVS2iPTHhsSkuD/kOPFq2d2DFJ3TseGmy7?=
 =?us-ascii?Q?JhDryc3ZoxT9g5RV1P2KEheram3AXccOrv2eIlzEHZ7qgTU0j7Gqi4b4EH+s?=
 =?us-ascii?Q?P5gWuHEY499KoXrwMhoYf49sETztRhzTLxW1yAtX4oIt4DcFi0hDJOHbgulE?=
 =?us-ascii?Q?qVsnqiAb7x1QWTtm8NoP62aZdiZ7JrgYyrklJcjjZhLODXYTMwFxGoOfu/RD?=
 =?us-ascii?Q?uf7n0QrgNXhAzbeoesEkSQYQG06Uaynacl4eWHyp1LH/5xRjLxzuQq05SCzb?=
 =?us-ascii?Q?RsVpBIgN5Xm90GMZ9RVrVNUZI6ac6yEASqs7LGD+eu/df+tZpzRhaIrzyx5+?=
 =?us-ascii?Q?JnKvxADLUXDRwxIdIXVWILVplYzdojAp2m8PkQmcjstJh1eFjyXsFbUcR3sl?=
 =?us-ascii?Q?oZ7ZDlQFaz23/Nk5a8tK8B3a04DK5B0ZTChzbgn4rOpdshZ0Cs/MrjS7ONnw?=
 =?us-ascii?Q?jzTCN5aS5vLEYVGMiDdKAxQ0JLLA8Hz9wtsqW4e1WHf++z5oK9GOXzLFgPvP?=
 =?us-ascii?Q?z+zQXC/47BzvNwFOmoPOGgt5dG9oVuLb/liUkw+VFV48DH3ZaLHUExxpaeWn?=
 =?us-ascii?Q?y9/Iqau2u0RIw+VPMertE+Z6r5nGh3h1gt6jCNbXl29zHtZwskVzSFRnJLb6?=
 =?us-ascii?Q?noaE6D7Z8YrrdASEuumXPg5LL2ALiaUnA79Ihkw3aRv8kfTk0UsHi1myrQDp?=
 =?us-ascii?Q?lxv4HAKGJ9Z0nCxL55YEmda0LMv7ElX9f8I+PsSyX8uWpjvDdEBJPCvp1t+Z?=
 =?us-ascii?Q?bkC9Cvy8HByolbmY0PZ3/CbcDqrt7A2i6o3qeCzfWXgTixe4Utf6ckX1cSKv?=
 =?us-ascii?Q?K7izF21LbvDiQkfnH/LxG7Q7Q2YR1bIq1EQFs0XwP6Cvux2VuT7YwSjkwW+O?=
 =?us-ascii?Q?rWbmCgoqNJTc3QLj6cmS/YzAK6aqu+qE0lRwsEizOJHQWQLKJoitquPVJfpC?=
 =?us-ascii?Q?5ezPojRZu9fX0tnZ+WY8YI+dR7NRtbOjXsVAVEbN7C5gnM9xajVN0kkogFb+?=
 =?us-ascii?Q?dvwlpJnDQnHHTPmR96GrMTgQPwQF8Ie8safIQn+gbYUsjKumE+Ak/J/yVlAq?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec207bf0-e9c2-457a-30cb-08dabdd12eb2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 19:25:35.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW8rMTPR4LdLQXoWuewF6NltF+j1rJkDTUHARFnyFpovCnQo0BGRi8933UqFg22hqqXXux0Vy8/7iad5n9hVlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:33:50PM +0100, Borislav Petkov wrote:
> On Fri, Oct 21, 2022 at 01:34:06PM -0700, Jithu Joseph wrote:
> > IFS test image carries the same microcode header as regular Intel
> > microcode blobs. Microcode blobs  use header version of 1,
> > whereas IFS test images will use header version of 2.
> > 
> > microcode_sanity_check() can be used by IFS driver to perform
> > sanity check of the IFS test images too.
> 
> So I'm very sceptical about such reuse.

The generic parts of the microcode is completely common between IFS and CPU
microcode. The parts that differ are in the meta-data. 

CPU microcode has stayed the same for over 15 years roughly. Changing
formats isn't something that's done lightly especially since there is cost
of enabling in all OS's. 

Both are in the same class of microcode, consumed by the CPU. Inside Intel
the format change is also pretty strict that they have several levels of
approval within the HW teams and also needs review and approval from SW
teams.

What probably is best is that we should document that the external formats
are shared in the header and probably in the shared routines. Changing
names as you suggested to be more generic is in the right track.

> Then the testing burden won't be an issue and there won't be any
> potential cross-breakages.

Even if its only a few hundred lines of code, it seems odd to simply
duplicate for the sake of fear of testing.
