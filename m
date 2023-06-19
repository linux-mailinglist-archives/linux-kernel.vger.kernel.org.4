Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E187353F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFSKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjFSKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:50:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA819A8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687171773; x=1718707773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GGTm2/x03dPGgFX/emkfjdYJyop680PeVtP89DHyS2A=;
  b=nZvrrNkn8drgF9Q80Og2eXSXm28et2p6Ztpr6QTQuW7LnwwWkN6iP6Pm
   A2cj86UxXFtw+8shrKBz6RzkYhWr6yfBitmoqiWnYk4+fmqvhv7VqSKHW
   2bqkT+I7WCJKjzPdWY64YrxOVD9rqnZlaX2cNJ+x/vc2gzTWYVUgkRv/E
   7c+Yt94yVA2TFwOmjJiDw+fLEe03I7u/Wr2LDWc3E2j8HSwZzGUdrYZCe
   RT3qVcGadi5irJn4zUa+BVuk4hkLwGtQtMaz0QFEbZO5wDcStJZA27pdz
   o92MKX7Am1mhNq9nTE9mjLBKBHAAfeHcDmzNfiADTps449gG83/WkZMqs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="388640541"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="388640541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="826556743"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="826556743"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2023 03:49:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 03:49:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 03:49:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 03:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRqomv2hkSW3hhzuyFmCZX4+1n4c+1fZCrxlSjtncO9ElO6ks9Eq2Br8aAV02a04J5OwJH+zWNr3AoREm7vcIaDU/lAYqNzav5oEcTpKHdnlFlnhI4ZAagdkrPmOZiYCq6puDpQMdqGec7x7n+Hx4LmkbImS2ZziNrmO4mqeRwUjGwFE+fXRMwuNNOhoHYDvk6hEzJmx9d7W90J0Oh7co1f9rEoI265akV2IYFnhp6XzgYyZKuKa+wgrCOi0vHRIz/SdzQe3oWWSsvChdFSA3iRgcm3ZvB2EWKd5K6rJjhlo1Wps7uPFT2yR6pZvZS0VIDCWImpcoG81xk/463eoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoZQsx+XVYslYdSR6vDyuT+5RZrJKa9wAGI72kAmFJ0=;
 b=lyGAjaQ/OrbgcVbv0KO5kaE5k7/PkaDCVdUCMtp42cDozZtgkEZCO4Av7jSmxaFO+iad7jWTBLx6lroyBGcTpb3JwuAExxTshJG8GyP3Zy0qzMv25sg4yL3pQJa1B+5ioPZxOCmhGyzI2e+NpdkBZB91qSgLRBbMPQRkg+dWWRoUye2irH/kuJa1/yPZIs6ylN2ET2+tRVBkqc9kWWTYBRrVHpPqMoKoQ9m7/Q52/FKgYeexMZyF8/WqVvThChl/GlTKhn60rTLMv0kBqvqVdjndgGZiK9eNEdL8CGBrwjwD3uTvhYqKFYSkqLY+2gXG4Lxj/RbGxK2Yed2qkZ1fLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 10:49:30 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 10:49:29 +0000
Date:   Mon, 19 Jun 2023 18:42:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZJAw/ipOybjHNfeh@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
 <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY8PR11MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 162e1b80-ea1b-4332-e5c0-08db70b2db88
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGhk9J8V2ACDQuerAvsn6VY6Oi2XlvrEj3l/N0wV7wnaiKMLSkx9VRakbXxLyk+eivMc3YvtJHKrr1zPn7krI1iK9eAo5k7x1R40zYwr6Yiqo/gWpYCgVAjxnJxuZuDrU4cBeX/GkY2KHThWqOT1Fxc/QX6HOCK2KZC9nPNmOyfqBAYR4GDwPn66LfElq8tY7J533WqJ7VK6tnWCc+qrjuPmBuBqjxUWP0N2VxFTmC2mos3qUqOnF1XcTLtqLMyqpAl3JknBFCKozBNeob+8Fn+Eo0MwoTm2ojWTbw6pLZ/0WqKCMR9LNwx75QPFTHt5HUL8xS043Oad/zy4yr7cutBEC478XRM2DMaWzMPT7s3nLim5utdsVqIl0XuIrrZhM+5blyOScFrRXuU0uF1gWVSvJJetvNMhgwrwlw+A9oDrr4/GfhH6r2/GbWvzv6XeppwB00ICEEl5SVt6ejjf9WPcjG3I8sGuQinj88A1VpRBSyd6PJKtrvY1Ho3wAvgEux8EYRHQr2JhYL6kqs0hE+rnyrzx37fFZS+2uVgfjjw9SlbjXs+J8FCJj2IwiAXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(5660300002)(33716001)(7416002)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(38100700002)(41300700001)(86362001)(2906002)(6486002)(6666004)(186003)(9686003)(6506007)(6512007)(26005)(82960400001)(83380400001)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SrfVljtmNi5xw1UKXn03wfGi/YP932sCFBJf9Ba3Ue0mblhRX2HeWTnZheq?=
 =?us-ascii?Q?aXQ2dxc9otf2xouPIqsT/PgiufHqk9cieI0KR8xvD3OoETqu6Zb2ubpQBX74?=
 =?us-ascii?Q?sKadD927zx106qIyu3IzqfXAs5Y78JSFv1mjgBeBEDXB5EiVv+KhEhyHLxJC?=
 =?us-ascii?Q?PgaD4PmaCdwGlFJ2b08Krz8ABNrChqb0FEPixXS8eRkPoGGGSjgthWH3d/bt?=
 =?us-ascii?Q?lfgcU+O6DqfIUZ60bM3yVymoNhcRKhE4FhHX3J9cFgQsfMESZTmV7Ob3S++b?=
 =?us-ascii?Q?AGfmfMIr9E6t3jYVZ0tNTYuE+QeLBQmu8lImsRae1v6ZEow3Gu6AIISlG/OZ?=
 =?us-ascii?Q?Dudz2ngj7MUcMIu2ZwDLWcFQqViPnWfKTjadrtqwZ+rFwsxqfGlSUXtdweOl?=
 =?us-ascii?Q?sbGoWEe6TN5SmZ2V3goXxG9ChVFgXryLBpEoag2lyirH1E0fC+R54YMBWKrl?=
 =?us-ascii?Q?lQDZZxMQJVLyTMqBlzmeLqXfkQceOniIIgx+v2K0Gnx7BJ6WT8QsGjeIHquX?=
 =?us-ascii?Q?KryFoDfFBQuwXoO8Wby0TL9M4yufQBJMPonaKHVZQ5asEpD1eYnAe3A1IwgE?=
 =?us-ascii?Q?Mtvprc0WOXK6jysyx+Kb03h/uvNIzeGOlnobvlSUgWx2AM75OI20YvZCu9Qx?=
 =?us-ascii?Q?aITQrKUP6VGZN0esqPY1yJcjHl5JWLIPxWaydRIMUISH5wOzJGNIcrBeKScl?=
 =?us-ascii?Q?H9pmoCXQe1ohmJRUmhHE8Iej38kbn8lD8kwSzYf0UmWSP3qKSTpPzfIFSeZ9?=
 =?us-ascii?Q?H6jTTpEclZi0VtwR5KCXZUoCdnQ37N/KOFtDOL44iRIY/AUKtoeDNtcfvGJm?=
 =?us-ascii?Q?VXGTu39PGsvFgvrBj4CRUg+TpHNjJeqtShHETIzupZBwBzNVPeWa8FDxdoCD?=
 =?us-ascii?Q?0ho1GkFU7x0Dk606Egtd/rw90Y0YJT49kpKBmYWoCHc/dgsKBj8j2bEHvnx9?=
 =?us-ascii?Q?byI+H2Zk4mtslBuy78F2WpbJMkorjMg8mPlwfhLiUWjILzegCbcAJDIxEAGr?=
 =?us-ascii?Q?9nIGDIgUiGTvPNU9xyhYzNURUSDf+doCtZj1ZICbjXImTg+w/LFiREnUBcGK?=
 =?us-ascii?Q?ihKoqMiOoz6aWyTB5huKZWwKC324xEygqE6H+5eRxRFl1K+Y6e8wCqNA3cL2?=
 =?us-ascii?Q?7VMsBTE8W/Qz6OnFG9pnwmqgx5GqIfPWWdDroO0fcGd+2oSDL1SICnoqc7/T?=
 =?us-ascii?Q?/2NnzMok3rC1UIYU91n33J8b/yCUjCSv90+kXXiaSH4V3TIg5O89Yzc0Yljw?=
 =?us-ascii?Q?7J8HgFSkMD4jq6FPij3n8a5JgQhZ7qgh/RvkyATOUqnQIbHOpp77z70W7cIa?=
 =?us-ascii?Q?bTZfZyJA0fE861X5j5aClQTbQ60lE7yB99jjvuanl67JnFjjmECrAWBANIE4?=
 =?us-ascii?Q?A5n2GaU2t3dOP1h7MDSzeA353ETzi16rodz2wvdxOLzzRjRVtnmETuX7vkJD?=
 =?us-ascii?Q?8ZBpkxNrNWT1Y9qjo78rDBGaueAoRCh5frzIO3HfLElgRkhqfOubs1o+OE7T?=
 =?us-ascii?Q?3GWEcPD7EfMAnbOiy8qX03jQBAq+mKu4ZUGRUPt/vhf1YFnDwj+qexGsVrPl?=
 =?us-ascii?Q?k9UnYUa2rV7SFnRAeZzYLlXXhmpBYWOXRH7RKwTi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 162e1b80-ea1b-4332-e5c0-08db70b2db88
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:49:29.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k3qVTRH9ycwS1LokgaMvHuVjhTawFGrqFP3FwEEd9NbvRhaaz9jvDQDBWyFpKygs5LSC73ekBYs8+mOV4NQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:02:31AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 06:53:21AM +0000, Zhang, Rui wrote:
> > On Thu, 2023-06-15 at 11:20 +0200, Peter Zijlstra wrote:
> 
> > > So I have at least two machines where I boot with 'possible_cpus=#'
> > > because the BIOS MADT is reporting a stupid number of CPUs that
> > > aren't
> > > actually there.
> > 
> > Does the MADT report those CPUs as disabled but online capable?
> > can you send me a copy of the acpidmp?
> 
> Sent privately, it's a bit big.
> 
> > I had a patch to parse MADT and count the number of physical packages
> > by decoding all the valid APICIDs in MADT.
> > I'm wondering if the patch still works on this machine.
> 
> I can certainly give it a spin; it has IPMI serial-over-ethernet that
> works. Brilliant dev machine.
> 
> > > So I think I'm lucky and side-stepped this nonsense, but if someone
> > > were
> > > to use nr_cpus= for this same purpose, they get screwed over and get
> > > the
> > > watchdog. Sad day for them I suppose.
> > 
> > what if using package_count_from_MADT?
> 
> So I'm thinking that if you cap possible_mask the actual logical
> packages is the right number.
> 
> Suppose you have a machine with 8 sockets, but limit possible_mask to
> only 1 socket. Then TSC will actually be stable, it doesn't matter you
> have 7 idle sockets that are not synchronized.
> 
> Then again, perhaps if you limit it to 2 sockets you're still in
> trouble, I'm not entirely sure how the TSC sync stuff comes apart on
> these large systems.

I had the similar thought. For this case, the defensive way is to keep
the watchdog for 'nr_cpus=' and 'possible_cpus=' setup, and if the
specific setup has no TSC sync issue, people can add one more parameter
'tsc=reliable' to skip the watchdog, while aggressive way is to ignore
the 2 cmdline parameters as the above case is really rare.

Again, as you mentioned, I can't find a perfect solution to cover all
kinds of setup and broken firmware. But at least 'logical_packages' is
much better than 'nr_online_nodes' :)

Thanks,
Feng
