Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEFB70DF79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjEWOiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEWOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:38:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098411A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684852693; x=1716388693;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2fdWqPodx4Imwzs3GU7L/qyMRnAj12JHrtzbYCcIOVM=;
  b=RtyJ/1LvzmqUKiNtctOj25brlNRYvf7vE7Ozh06mzE0FbgJ8xolxQxWS
   Dm/roo7ve6/2qkG7J88UaZvLhZK1vzMZAEpfP19J7z6su1XGjjuksV8Fl
   KgXGB2r3JQ8d+aZgkuZ0t3yDWyiCHI+RXN3+rf/YAc+IAfthiBVdG7LNv
   bQdtobVKCoWAryVpW9LRwrhLI0lwsxL78hckhdQH4N08fzdfayfGQJOtq
   oxM/zqzTi+nZxjIzpcXVSzDSR2VKKVueeKj+L+4W3pi2XQSRQ+lH1hmDD
   10JdZ3aJQ+Esc7yGhDK6a/FcxML4s3/IvQqSdy+n4PMDgzydXB9xa/bE5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="418960588"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="418960588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698081266"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="698081266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2023 07:38:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:38:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 07:38:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 07:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lONJUYf4NLaOdqyQQEdmEkc9cZiopxPG3i31TkBEUizqRUMtng+GupAcLRvjSsSYYPJ1BPv/4+KEmWf/cHq0EQDAcj+qnT95fcotGrLKhBh8s0dUKwP944Y6/i5acR1QsOZ4EvSRV8E8xhFB++WZAAri7ttqdo71D+YB6D4MZz8jBNjX07UVxG2Y7sO6mYDBb/kxvFWFBtgVTLTZ3Z/XspOm2mGO/PTjaiOk9cT7DZd8L3Of97DTovydGfi1lm99GUPxhbJMcmPcNf7OqYp1NAvOab8688YHtY+4CiASUajBJJiWdzHA2vOdk499r7fXaaQObrTGQ9ZE+/RlMKjzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJMqJ5C7p2qgInjU32NUlk9LU8SL8FHYW2fAJgiIFi0=;
 b=nTbfhBZdPfcIaNUM9g+wcZKUkzH7sWaF39ErrGcQSfKO9XfyjW3Xzv1eb8XCrxRbOEImDE5DU5fiMCqypolabWcj0eBe+p4TbcDdOzWDsXsKtI0YsmDwctlNAUFguq8LdvUvoegJgNYm+GRPtrCkjzoVX2HInsr6RSTlhp5puAVc6Pb6cxVef+G10G5pgcDYZfJJ8xOv3eQwLeVdD5PMWR9zn0+3acaB/W3U3+pShmGJocmLUoiNAueztkrKBFa7/cGHb63V91u/G2C7enX7DR/+D2wN26tbri3baJjzgYXc4MJJZgIOGM4Fot7nVwGhprmm7FR5yfUk1P8ZHCiD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:38:00 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 14:37:59 +0000
Date:   Tue, 23 May 2023 22:31:07 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, <paulmck@kernel.org>,
        <rui.zhang@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZGzOK9xkeQTnleWB@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <ZGssENXFKmOk/zL7@feng-clx>
 <87zg5wwppa.ffs@tglx>
 <ZGtnUQJy+1Nrazhy@feng-clx>
 <87pm6swi7z.ffs@tglx>
 <ZGuIL6tyzzZP3kyR@feng-clx>
 <20230522161158.GA3330346@hirez.programming.kicks-ass.net>
 <ZGwUXzGcMgbcZVnf@feng-clx>
 <20230523081115.GG4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230523081115.GG4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: f394c701-7f1a-416c-3afe-08db5b9b4e04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GFl1831Q8ptHklmmnIYWIFy4fTUsUdSXR5KVxdgoZ8dkCuI7maJ7WxE116rsQAXPtAsadgUQ10U+OPFZ4jnb+mm0Gie56xeFRnQb4mEdK2BY2Qkue33/570XduIABfZcTQ4iCYmht2eZt7L48CyafrJ8JPiDNoTS8Yp4EH7hEQKjO1Qc/u7sdzw8UycnlD6tE6p6cXSIOzU4X75TVomVoTLAoDXWNXU5Dp4hxWQqkUqINu7CS+NJN4cO8iYWWLCIfkkxn+pYY1IrYAIK2/X4nIgmR/xAUbNFfOKW7NPbXLbv1OIj5+rbsA/hz1XjngT9NwRGUJCXr5IaCk4YzB45YoPqbXmh0fsqE6c/W/url8GT8vSXhU9RHiL3GdAEwGP2My9k3CCH+ETHZ8ScymH8IC/yBvTjLeQs0UPNsyr7KWj/LkAd0mPvbp6tf4ldWo3KLYoiSCpfnSu7vKjP8q+viOmVFcgVlhQ+vbssd4Uutax9tmdegdH0IExv4m6yg5n5Ns7FEOlKuqZlgXKDjVmvYhPMApv6tI0RM4t5aA+ko5/HhRow9+bTfjBjWzYmJm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(9686003)(6512007)(8676002)(8936002)(83380400001)(38100700002)(82960400001)(33716001)(86362001)(6506007)(2906002)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(6666004)(4326008)(6486002)(5660300002)(54906003)(26005)(44832011)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VyWj+APSfOUv9QICyXbKH/3sMfNf5vNEhdpx69hKl0WZHzUVdErCl1HUUinX?=
 =?us-ascii?Q?cF++N41AeiEPqsojHh/hiUxlWK2PDKxi39d8FPYtcY12ZI7nxIuV5rVCfxoP?=
 =?us-ascii?Q?KDwKEzA8c906evMCQno8hnnTvBotNHIyv5n85nShC+4+8U1PWTQTU/dNUJs9?=
 =?us-ascii?Q?O/vPqLGQ7WaM3yL/9AgpqkeekKMPubQo7ALSQownmauYLO79kkFS+j+j4gcB?=
 =?us-ascii?Q?SJqNuoeyM1zNF9yUjVTxXrJq+EsFLeKImMKcHU/xIKdcszuq7jFaWH6aHAaO?=
 =?us-ascii?Q?4I53EKvq635vbze9fND7yG+k65SgsPa+k0g7EjujVNt9/kg39ctzLpwJ1zyN?=
 =?us-ascii?Q?DL+LfnqXMJHj6DCWxpBCO/kAAF6GKlYaizgrfcLj8IjT4GiFZj6vjToe9wn9?=
 =?us-ascii?Q?9OmWQA5rpwdHVgHPoQJC6IU7fRQGw7O0WF1AR6YfqurWBhsjsVYJh9kz2ZkY?=
 =?us-ascii?Q?QuDNEsK3Tn2NNhHIvLguOXZCin7JYIJMKiUaoEe81PWlJz80Qqo4TriH10lZ?=
 =?us-ascii?Q?jV2b0CtTEbHh9x2ESd1iGJVCDXUt1b9x0CLSbq4aQJIzGNGdjeTkYuZqvrbE?=
 =?us-ascii?Q?SY5mHi4VfucZ8JnZOb8cNer0lw0GR+rmYunSguw15fmTEQg8gpwpqB1sqnu+?=
 =?us-ascii?Q?70sE78THwUY5IdUYh7rjwTfC+WXGWVsWYSbMdHYQwzzNDI6tkI7c3zLpBsB0?=
 =?us-ascii?Q?qHldxDJT0OgAuYmk+Uaj+Io7kWAg+9HWZNp9NxCLQGmoY72sx6QCONqkSADQ?=
 =?us-ascii?Q?aXTVDe/sWXkLLhGH+NKmLbo6ITOq5iHwGa9Jtf99K0q66Y9k/yzyBmUSb+uK?=
 =?us-ascii?Q?Ke67tcwEdY4jWk1MayUP5QPhl79q15OrhBlp7r6X+SvuOMYKo8v8C2CZPOmn?=
 =?us-ascii?Q?PU9nSb8av4/4050FS14QBD2cOXS6FTtetIgJ6xFCQZ99crmMe8EP5Cl08W9Y?=
 =?us-ascii?Q?bG9toJBq0qVv9P7K8Iw6LU1zt68UB5mX/p1+pbDHyQvMEeh2gbvx6KPbc5lL?=
 =?us-ascii?Q?vANL4pzZgdES/Kz40A62NOzqDWrH8+IcjSI9XJdpRmdC2x8XB0XseFctQouR?=
 =?us-ascii?Q?9NT+9pgD/32EcUMAcB0g4e3Hp0rU3iU9vFGOuHpoXnKw0TGmxKfcZp06CRoA?=
 =?us-ascii?Q?12WRZrYJs3bNdNKpyBpZrDMMja+kkdh5gls6lnSptrIqjS1y+76YRk336VEP?=
 =?us-ascii?Q?JS3yYLSPhjXKOR+V1C7XI2QLDSp8MWE22hVTwRCiOF/xtkKpwEmsZYqgIhCH?=
 =?us-ascii?Q?Z+J6qUWHAiI4tAnd00Vi4RmIxqCNNHeQdEBfdA7pq8uSXd9v7MhREgtNiwuG?=
 =?us-ascii?Q?wLWOc9V39/CH8JDv/1lIJapd91Vv9FdyIiOJ254Se/XZ2HLTp3H435L1Y4d4?=
 =?us-ascii?Q?DXezVP1NfVqpBXHmCSiA9CdA4x1e5pp93emyX8wRjodTnnf/lxHtSV72150i?=
 =?us-ascii?Q?TL8uUuzlnVWfCytWgTLsWo5ov6KATwhex+oMt2y6h7R8Nb4lyPbmf+ZD591Z?=
 =?us-ascii?Q?hUQylRT5AFiI53kC5TY3yibiacVgqOFHiOW9SA8pEZnEUEVoSJdIgqWh+OC6?=
 =?us-ascii?Q?1xXycBPBdj8e/ddQFvLMegZl3q7MaA0HOBuXS3hh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f394c701-7f1a-416c-3afe-08db5b9b4e04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:37:59.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGuQ7OqOOOYRdtmNInOazeCPs6ynAhcRZUc4UIbnLO3SNgmkQn9bir2JtooMriPZGXcqRWNg9qQ2MtlrC50RpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
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

On Tue, May 23, 2023 at 10:11:15AM +0200, Peter Zijlstra wrote:
> On Tue, May 23, 2023 at 09:18:23AM +0800, Feng Tang wrote:
> > On Mon, May 22, 2023 at 06:11:58PM +0200, Peter Zijlstra wrote:
> > > On Mon, May 22, 2023 at 11:20:15PM +0800, Feng Tang wrote:
> > > 
> > > > And I don't understand the commit log: "On Intel GOLDMONT Atom SoC
> > > > TSC is the only reliable clocksource. We mark TSC reliable to avoid
> > > > watchdog on it."
> > > > 
> > > > Clearly the Denventon I found today has both HPET and ACPI_PM timer:
> > > > 
> > > >   [root@dnv0 ~]# grep .  /sys/devices/system/clocksource/clocksource0/*
> > > >   /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc hpet acpi_pm
> > > >   /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
> > > >   
> > > > The lscpu info is:
> > > >   
> > > >   Architecture:                    x86_64
> > > >   CPU op-mode(s):                  32-bit, 64-bit
> > > >   Address sizes:                   39 bits physical, 48 bits virtual
> > > >   Byte Order:                      Little Endian
> > > >   CPU(s):                          12
> > > >   On-line CPU(s) list:             0-11
> > > >   Vendor ID:                       GenuineIntel
> > > >   BIOS Vendor ID:                  Intel(R) Corporation
> > > >   Model name:                      Intel(R) Atom(TM) CPU C3850 @ 2.10GHz
> > > >   BIOS Model name:                 Intel(R) Atom(TM) CPU C3850 @ 2.10GHz  CPU @ 2.1GHz
> > > >   BIOS CPU family:                 43
> > > >   CPU family:                      6
> > > >   Model:                           95
> > > >   Thread(s) per core:              1
> > > >   Core(s) per socket:              12
> > > >   Socket(s):                       1
> > > >   Stepping:                        1
> > > > 
> > > > Maybe this cpu model (0x5F) has been used by some type of platforms
> > > > which has met the false alarm watchdog issue.
> > > 
> > > It has them; but they are not *reliable*.
> >  
> > Yes, that's possible. I tried to CC the author Bin in case he can
> > provide more background or information for his statement, but his
> > email address is unreachable now.
> 
> IIRC HPET stops in C10 or something stupid like that, I forgot what the
> problem with ACPI_PM is.

Yes, that HPET issue is a common one for several generations of
client platforms like Baytrail, Coffee Lake etc. 

