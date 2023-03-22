Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EC6C4211
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCVFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCVFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:20:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887F5A938
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679462426; x=1710998426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wswgFbHGIWn7lH5NjLQsnmZCxc7tTdeBEC6NhXIuvc4=;
  b=d293izOd0ijER9eOHDNdbqY2SVa3g3SfkAGvidjAJ35XBeOZI+khZr5w
   q8xOX3uqOjLh80fEmCABMpElT5qYbN12xpov5IBh/JDG4aZXWPMAk/kAz
   m89vEXh9n75DrWn+hS7dtkfEEaSoX3pp4IhJcy3GKbX6blVoMkszbIqlh
   3Djm4BBvCKoHJSUxy1KADzSe1PZ8kM11O7Oh5fh46F/pn2AqtyfixRexb
   wYOzMn2BNrzRhXn6IdZ6BwC2IgMHX3BXZCqzcLh9pwvpgNl9HAt72zvJM
   nzZhuYQ7Ry1ITTfmqZ9O/Ooi0kfwVFbOD+qeDuciS8TJibb9KGC0KEjR6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401697985"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="401697985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746168820"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746168820"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 22:20:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 22:20:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 22:20:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 22:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMX8n5/JW/KUKVNgWba5TmpkDkvDlqKpRkl3sVFhuk40TaFE+BlzqhsgHnRfBqXAtvNK1rD+bGa2MMwa9yqczgmzF0w3R54KDsBA/AxuCs+gcu6G2Edmoron8YsVh/V77G0facRzaOc5KYCCBdjnZ+NBekBXKI/0ImkBFHexM50+0c6K0aaqYcCsyBggiV9ZkRf+YjWDoaydhpA0Xww3i8C6RKmo+jQhK3x4gq4UvOmCS5MozRPvogtYQC4Dj/eF/XM3X5Eva5rRpl9oDFfQOucABKd7U8Iu+n97Wd8xQbZQ/Gont9S9Hv9MIP5r1/1evADHnsf/5yu28YuZ/rs2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K+BRnQcs4mDGzBTN2Y7NIMUsx2Sh0lPEwWHBk8FGXI=;
 b=Cf4T0vloSTknPrtWyFONDdHTQl9dBRpVvJNEccmuQmSpBcckOrYf1YendjaD0K8M3/uIVcXU4rVgzPPww9Q2j+1KgDrw52K4EHW/u+NR1qgU4K7cu0DIScqss3Ib9qC5gyOLeM6xwMeMvhtUAl5hCrktdGZFYF+ijU80N0KgCMhaP8jU6HBIqwGlu07NO1Kj7NDWqLD7pJp4gBmqdQev+yPAqDi7J6otJCPjePVw8dBTavB56QHmL9KO5J+UrC5zrLW+FVEXnZtx10o1SMFfm+hAJMNuG/7WK+0uxMgFUFM8VrDxetFZGQRdwGsexWIYXq3I6pkM6CSdejQ9x6hmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6698.namprd11.prod.outlook.com (2603:10b6:510:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:22 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:21 +0000
Date:   Wed, 22 Mar 2023 13:14:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: A couple of TSC questions
Message-ID: <ZBqOyLByOgvdAve3@feng-clx>
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5657aaa6-9ecc-49f4-de3f-08db2a952224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0zNO5fp8/oE59qyll4z/hFogrtwi8M2pA1m4byosu+opgMabebrXtsj0aWlyQJJG9YWT+M1RI/093zia4f/PdwznC01tp0dPo01NTCtT9vC12LSEP6kHRvuxJd6eZVX/mB5TbOfwEDi6vzffXl7XfunmqodsftCxa2RkrZmBoxrev8ym39j6HcerNnzWvNyLxE0K/dVxLH4vM7obuTMGJGKwnJxd8AI3mTCPBjpEkwy08erZQpajkBm3atNWC7JelvPkfooSfu2fthH8qFiGAT03uBvhYMRydviFt3ARWG3RaHrM9lMGT39fN+cCOB9zWLd05GdawqEVLJcRGbzW4Kdkr/K92kzGzJXOwEJnZEhU7IGMld9jloRUVB+c0BTibzZ5SJ+iu4Q/ETDfOT6CdP+cJ3I35/jiDV4KzNhGr+yD0iL3LWgGHizFxR+d6UBJx+5pcbs2pxdzrYxF9EUgibHbConCpx+k6RXlZKVkcpVS46nuJnsp5J1PO2/tQNbU47sCR6/zbIYZmwuldvNJxIDP9bHi3PJyzUvYiMiDtvsMXY3KXMUNq2jbtOWuhHv5zk9PYXNP74KBDIBswTNTK4XXZcFuiz2owbs7ZKGZUuI+Wdzfiy83i2i8dmkdb0T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(66476007)(66556008)(41300700001)(38100700002)(8676002)(4326008)(66946007)(82960400001)(2906002)(44832011)(8936002)(26005)(6512007)(6506007)(6486002)(6666004)(966005)(186003)(9686003)(33716001)(83380400001)(5660300002)(86362001)(316002)(478600001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6urGkkNna19KAj0DkUNBwWXTcrstCEUtmHkNJslnsqhmQqMy9ftSjgKrehG?=
 =?us-ascii?Q?SpktpkzxR9dB9OMQUledRml//XvcpiJP5PLEOgP2kpyQFoQ+liPd+dW/96lX?=
 =?us-ascii?Q?JTnymI57AlK1TRZq1w38+1uIuaaeX0TaDMl+W/xereJkeF10jaQqYp/Tc6tA?=
 =?us-ascii?Q?JTM3HWQu9RiYJyD4WftUDbhEL43h1fgCX6f/P5+0qw7kBi5cVHNcn+fjwdSF?=
 =?us-ascii?Q?FKHrfMtyWRFn7328yKKTwWn/AVgFjAqUG8+uvgFXG1/T4JS0LnOlqKwNkJmg?=
 =?us-ascii?Q?X6BRjUYlohI+vE3K9cUeEuPSHzZ492i/r3JYPieO+N/CWUFdljli/EkyeGyw?=
 =?us-ascii?Q?N44EMMT90tUoY8v8+lZ4uscUQhumtAJdH6Fh24tuPk/FuYy667xViFlmHj1V?=
 =?us-ascii?Q?dfL7v1x6bHbexsyIhncAKilrL3YvgKDYUlD9Vp+1JWZBzHIUQrpk0KbXKvvD?=
 =?us-ascii?Q?qV1rRfe0+ErhGfAOZeHJkovnPjoqepx7n7nvoWsmpArLeEz2YPwDZ6weE0N8?=
 =?us-ascii?Q?BiDz2ejpxideUBcZusgiogNSpsaP6lkMi3yKDuNICRVBsooBR/8IC0dNrWVg?=
 =?us-ascii?Q?IEBweuyatPwh5QIMKVozSsSuprWAOpieV4CKvncK9RlSsaHhueMLaSuPj8p7?=
 =?us-ascii?Q?gaJ71ZXGzDLNM/kOFd3oZ9K0a4vSDxeywVt53x5EM/1eohRqBivbbx4BG/BB?=
 =?us-ascii?Q?nbDw/XTIK/EUZGTObvUQrM5rv/hiWUwox/KP/I54KUTjHlsMWErIn0k4bzqr?=
 =?us-ascii?Q?WXPZAjp0D6/Q2x1whMIc764aNOErf9j6UUHgk09Exd5sQvu64mO3CxeMgIwy?=
 =?us-ascii?Q?QpVq6sZoN8U9GgNrZcHnyf2c5jZON0KPVxZnd69yDVZS1j+gFLhMpTEffMtH?=
 =?us-ascii?Q?8Uz5+fJE7Lw16rzFFTXH1eHE3jOFyfJB2MKWXEuPy1OyUnixebXFFUxzeVtC?=
 =?us-ascii?Q?RbPDLMyMnnKw7hIAg9ka/GutYvMQZrsQAON9ZFmCPLSjSMx+3CUT708R/gb1?=
 =?us-ascii?Q?C9OIEOUX0ItsjjN1dQdRPgbxIxYDnIxxaJ2pa5lbMXgSiRt8oANiMgJNlmzC?=
 =?us-ascii?Q?vVgKiMmwY9JG2GG8H1pkYVWJZ7FN+u31TrBjWVoMtt0MCy0wt+et3+rOxCQL?=
 =?us-ascii?Q?udvDQ0S8VQj+ic0m3+sWRax5N6qXOMFPjGiIAfwqzJU92LhEqioT/QZe2PUy?=
 =?us-ascii?Q?gQYfGljHI4kEsujyaPsV1w+oxAiTQib4TtCmueeiyL+YrCuaWkFOfhKZgqMa?=
 =?us-ascii?Q?IwXtU9rkDwRNGOO8Y0dr4NvZ92+2v8kv4s46J28PL0ae3ZJlUB01kCyiv4/k?=
 =?us-ascii?Q?foVG+iBAj1hH45PiVXYMBLM224HYnCYMbxNAs49BoOdzlHCZsGXIICFiT804?=
 =?us-ascii?Q?Xn1U3enZASz3+LJBa0wOBuyY1xh6ne1rBJWq/ztKnfyLdV6rq/6I9IteTXTE?=
 =?us-ascii?Q?umQ52yQdmTNk+gY2dfBG7Tp1RFOZCKUjjEBeXLKRxePlEw7z9PcqOo6kkSuQ?=
 =?us-ascii?Q?V5oGmvWNLqWOjj/C8zyFvKdQOhjfJE2lf27+vsTQ4nYTBh6aIDIzaFSAxOwf?=
 =?us-ascii?Q?gC3jvIvvHubohu884lFWtcJlTvIGRJUWxlWv6ieu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5657aaa6-9ecc-49f4-de3f-08db2a952224
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:21.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FedxohbaYUHwXfZBSFvYjlpO1Hu+ryHBjAE/rm+ApMVXFi/K46OZUY8K2kC5icfb7Vll7Gp8ATLKJ5YjBStmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul

On Tue, Mar 21, 2023 at 04:23:28PM -0700, Paul E. McKenney wrote:
> Hello, Feng!
> 
> I hope that things are going well for you and yours!

Thanks!

> First, given that the kernel can now kick out HPET instea of TSC in
> response to clock skew, does it make sense to permit recalibration of
> the still used TSC against the marked-unstable HPET?

Yes, it makes sense to me. I don't know the detail of the case, if
the TSC frequency comes from CPUID info, a recalibration against a
third party HW timer like ACPI_PM should help here. 

A further thought is if there are really quite some case that the
CPUID-provided TSC frequency info is not accurate, then we may need
to enable the recalibration by default, and give a warning message
when detecting any mismatch. 

> Second, we are very occasionally running into console messages like this:
> 
> Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> 
> This comes from check_tsc_sync_source() and indicates that one CPU's
> TSC read produced a later time than a later read from some other CPU.
> I am beginning to suspect that these can be caused by unscheduled delays
> in the TSC synchronization code, but figured I should ask you if you have
> ever seen these.  And of course, if so, what the usual causes might be.

I haven't seen this error myself or got similar reports. Usually it
should be easy to detect once happened, as falling back to HPET
will trigger obvious performance degradation.

Could you give more detail about when and how it happens, and the
HW info like how many sockets the platform has. 

CC Thomas, Waiman, as they discussed simliar case here:
https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f

Thanks,
Feng

> Thoughts?
> 
> 							Thanx, Paul
