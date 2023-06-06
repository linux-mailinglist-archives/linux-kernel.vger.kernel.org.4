Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5072450D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjFFN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjFFN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:59:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B8C8F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686059962; x=1717595962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9ZnrgzjG+rfdd5Pf7S8nIt//diN9fV8+QH6X2pLgFSI=;
  b=ZG9GRDTqIl/eIAgD2efesEWh6ZcpxfwsjtrMxdOwRL02UBz4uwb/JbjE
   K4oAaNWxlqctZ+U3aMYdqglxEndK+0dihW40ErMvSPz7OU6qAmnDqU1DU
   ibf7Hcr/zIfqnDxOD783yUD8+RDGcg+KMdoYevTVpYtYA0ywQM9ARsJbW
   eRX8NhOcSHElEiwK+jD6sBrF59ayEcczw50LcFH/6n5JTwBHkUjw8MNhY
   +D4o5OciUKK4DRkLWyguxS3NPlhjQ7N7QJWJwmC++wia5uCDHXjsxIzKw
   orG03hOWkJovXY4m+1dsLDJbaWRfoU118SS1UMucuKY7EQi9ik70Oow0L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="354172123"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="354172123"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778999868"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="778999868"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2023 06:59:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 06:59:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 06:59:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 06:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1TiIKExjsJcJOMHoygcMqWR5KYppdL5xowoDUXGR9KiFdeemHzs8uFfsLl/YIlDvS1ClbsEX/hfc40Vr5uMiJeNLN//yuJd8xbOn2pJ/60gd7mbVsw51eG0EFAr6JvcVbH47dsUMKvghc9oN/V0mpkLiv7wx9N6nNGSmD9ozTlJL3SHwXgcWiZmLHHDOH/5J4cEcpuASesl9FhyaYpyNxHEdQVvcz6JAiypFin4ri4Q/N8HQBHEJ5gkkaEnDn5ZNGv8yi1jVYqF20srVxfKDWfgsh91S50RWX/3IXtHg/PtlpcMYPe7MSgqPuPfp40aXWq4iDQnhs0JXdTeKw7rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APY01NSDSDHT/FXoVhMoJsbcobXB19xZlMUPGB9f8XY=;
 b=NPe/LyF3CV+G3d3NUsRVxRB8bkQu95dKM8MoJrNCFJpWKbwD3QqHDrxDb5OP0BBKltkmZBZiwgWzS1ZMZqadftH/4UcAdMLKECRG7+GmJ6pKp/rf88/gVsyEWeSDRcezul54ifziD7ze7ZLm6JlJmJTaGouPH5dcXV+YzGY2AWjX8XhycbB8UMU5AND5dcIaucGm85WlJqfm/jv6cG21RgV9jiz2Acdh2/lDEW02eoV/6DRLR22ybCK5izwrVLWh6htSpuXH4g9Xxo3KBgcGPLQ4WU8vk2cGTSqEt/L2Coheojz4vTDhYJpmlDtX4tuvN1vLu62wACj50ksu9aAY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 13:59:19 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 13:59:19 +0000
Date:   Tue, 6 Jun 2023 21:52:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chris Bainbridge <chris.bainbridge@gmail.com>
CC:     <paulmck@kernel.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <ZH86C4A4qpeAz/n4@feng-clx>
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
 <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 242a5631-5823-44ce-6a42-08db66963962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1w8BT6xeZ8FikjBrgUxvrqZnJgCimY71jiMvD6tlh8CV67m29gpOj4CsdZlZwx/ONrbc/3rk+rtCjfeMWXNxrsz16fFNdYt1XnijPfEPKie3r/NbKT1gUX+1VZ+kaw4epVPPte43IcakOlR0eUmoFtwnJXl3e1R3n44+bkMfZYDc3dhjP1CiB07r3cKWi0U5YgqMFA4RG6QYDbQ/RyTfoURQAMIZ2tkyDv9oNwdFCH3RIAOOUEzwauEMC8kyUTD+Ay8HRrLhEvWGHy0XC1gxFKM6i58k1yq87E+uvjDD0vM6q7/NxYjZrX1i2v3NPL78wM8xcy2Gp5lIjphKnfFX/w1J/XIm5XTr+iMxGofcefoo/w19nGK7BQLV2wkHD2oQ5E3POvNF6dXkySQGUcWIJakmQTQP5jkUYBsJuSi84wRpNUP7bBpoPXObTjYQjkDOXdzZ6ZyDhJ+NO7Z63ys63fsgyp05ShUcv72fDIm63+CHg82eCXs6xdypXz+FuMqTLeW/4BQiQdRZ9n+dfO1yo0e65b6UCq272qPBLHJKzhCJYIGMSozOhVQa7OK5+Hy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(2906002)(4744005)(33716001)(86362001)(44832011)(5660300002)(6486002)(83380400001)(6666004)(186003)(9686003)(6506007)(26005)(6512007)(478600001)(45080400002)(82960400001)(66946007)(4326008)(66556008)(38100700002)(66476007)(6916009)(316002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0SahdzUIAYcISBmP5xkYDRMNlDTTexk3XbRh4uQS9xvQBZAgFdU/DHsvqCwx?=
 =?us-ascii?Q?9QWBLB+2jo1oQTBsG7ukEX+d7Wxu9Bmt93hAmNKhSg9Ho/XD5jyerO1Za+VY?=
 =?us-ascii?Q?lSZ690YUe3t7zsZO48Apcd6wv7mcp4G8aC631TABHf/o1Au+8NkxzHq9HAzn?=
 =?us-ascii?Q?M+KNNr9zHvS1P5fXZGdxpppy8RfK8qUPv7ZB5bpxiPGkJv7bdetapSN0ygEI?=
 =?us-ascii?Q?Ej6nRs6q9TgeBygyEignVWIm/tJyAcE9uWN26OBWVL19jV9NK85aTwDFmey3?=
 =?us-ascii?Q?ATJjAuW5fo2Kq8ZyEHfsGqfi50FT8LE4xXXlvCx801hdHznp/gtEDkl4iVe6?=
 =?us-ascii?Q?QlUjTTN/B5jDeai85lY5r0Rv/VHFcK3/zvDoj+8KRz0/LxdfAeqZfE0+c8zZ?=
 =?us-ascii?Q?gEX/Oln2m53jTjdoXE9bLtG/XmeYO969gpOJ3B+tD0KN0SSaoeb3sbt0h7vH?=
 =?us-ascii?Q?V/8AtM8cDFKitIw2lVv9GonG1e1iGhIRrwZfK467Kk6ZqvWZ5G6gnMXRgaDA?=
 =?us-ascii?Q?rFzGCV1vny0kyZBuIAapcNcPYdNiyvg8ZenpxBP98359IgThUGveDpAQcxP8?=
 =?us-ascii?Q?jIQzuvqI/EqgFTlpbq51Ch4UN0C4gClpHc1wmI+6jl6FcSUROmOcV6aavXgZ?=
 =?us-ascii?Q?g9HenyPp41iSML+XrA7Lxss+tXxgxbSshS6oJzzKNBD9cjwIguIWiulm34+K?=
 =?us-ascii?Q?pn3BzKo9tEFvHspW8PEyb8IO0CWFa984xLRRQ84hXMaKTvMbfx2twYVbldN/?=
 =?us-ascii?Q?xyNXS4U4Oce/n78B8DUytHgOQAfrxuJi4H9GcFP8+WKXT6+dtNRpEndehU95?=
 =?us-ascii?Q?212DHby9lkSp+rdB4cdDMjvXO5L07waTTK1NH81ki4S8EtNPGMWVME9q0jx/?=
 =?us-ascii?Q?fegG1fCV8h/1keQ47Gk1uDLaqEr22AOStAohmenA+b2y1E/LdyPIzSd/VSxf?=
 =?us-ascii?Q?2Kbo2MHD7C1RfuUUW1YKFJCzKOnvSCLXnb2pok0hXnf2lWbxJYXECbpdRULo?=
 =?us-ascii?Q?L2P889P/1rgQD0zyZCAiH4QhavUuU5VhIc4+T/JVG5ozCji/YrP/l3ROcKnT?=
 =?us-ascii?Q?36iBJcCZChyVO7b0LNWXMt4JA1ghJLqYEbecfNQWkdU8R+2ZGnJdza7waFyd?=
 =?us-ascii?Q?4tUAcWH+F02k1XK/SiShh5YcrrbkqVU4s/IhJ7/vJZpibiHhBnO8ZeC9XUYp?=
 =?us-ascii?Q?91qLd37kHadvA3vBFuU2cHRdMQbnqxMjrqWimdDqqVYdeYthVEFxRPDY9JoL?=
 =?us-ascii?Q?+5OxQMwowFgymVDThkMT3A+A1q/up9iPTNPsaZy36PZNf5uE5I9oSOy49KDC?=
 =?us-ascii?Q?k5roz7gux1NZTLQm6ujGuQaMoPDQ9EFeuJwRsKw1IhNAfA+jUL0H+Avh51I+?=
 =?us-ascii?Q?mrOezsEkbLz79qbs8IfuJvT46Lo6iXfmBV7y2MX4N0f9nf3jDm7px26yzU/a?=
 =?us-ascii?Q?7ehH2szLZRPAqdh4TlWMSLbyqzmYDtV8ZsG8gD1g60lOkHHMHuK/NWRXqRQF?=
 =?us-ascii?Q?sbuAeXGU5SfUQwvVqiNxnnAWWjdAeIemAl/ItkC81XpcXFqMRhpOg5lOdCuQ?=
 =?us-ascii?Q?KjsEMglONTVrNoz/6LsmxzKqscb8BVUWKA9Ggyyf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 242a5631-5823-44ce-6a42-08db66963962
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 13:59:19.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yryCPsw2GkUTcg7aBlMQkZwIwqqwzdyZqXNelv1WpuYH16s1Sc2hzFZ0Evae0N9TBOYBXiRcbZSHwwT2fE9d6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:09:08PM +0100, Chris Bainbridge wrote:
> On Tue, 6 Jun 2023 at 13:50, Feng Tang <feng.tang@intel.com> wrote:
> >
> > And I'm have no idea if there is a real hardware/firmware issue
> > or just a false alarm.
> 
> Is a negative reported skew valid? I don't know, I had assumed so, so
> the problem was the conversion from -878159 ns to 18446744073708 ms.

I think it's valid. The related code is from kernel/time/clocksource.c: 

	"
	cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
	wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
	pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
		cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
	"

The negative value just means the watchdog is running faster than
TSC in the 512 ms checking interval. The 18446744073708 ms is just
a conversion from s64 value in ns (-878159) to a u64 ns, then a
u64 ms. 

Thanks,
Feng
