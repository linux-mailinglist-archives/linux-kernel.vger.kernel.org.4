Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC462C649
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiKPRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiKPRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:22:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86433D50;
        Wed, 16 Nov 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668619323; x=1700155323;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Dfhxed2vx/52a65MErqgx/pwHP55AedIXjCWqyVgP74=;
  b=oHVEU5rE07Yw23xF2KX+oeHO5nmXCTF7HcVmKctbGJB/RMWC+zRLnTq8
   PSV2gUPDgIZdr0RNNmJJJhk+X1+/GUMbJPn8OqS1eca+3leY5NHMNaPQj
   wWaXd5bdlNqxMbooPCDMY1m/ATF/xxmDNbYUamk0pyfQNyOnVG1f34kGk
   vE7caM2mOKa0XSZ2MXdIqhVlmHcVmzcqa2JOk/OG3WNmqZ1lFfjuHLD8i
   KAKgVUqmduwYTY5ZFw0Iuwh/Cc/XQbisbgpXeBc0NXZBt9GJPOfZSHl4x
   rGwlse/1iurwgVuEf13vUJcU8Wdh00xlbquQWhS/A//j3Gavmt4r3o0Nc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339425897"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="339425897"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708247548"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="708247548"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 09:21:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 09:21:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 09:21:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 09:21:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYbrkEN73O8J8MFEiDgtsudDjjNqcWzZAv6OWE7KTReG4AOx4jmQSsNgGd1vMUYfNgGFBygb8Gwne3C1+8YL55uw26CLnivTLNQReYBwIIHPFbAqghx1iOl16RTZs9uqMdnJ49kO4+91RcLQwFmSB147s4K7iT5haFR4JXicQaFfD7nanWRHPN5+s1p6VSrjbm24i3FBowaWV16XUUtinoPcxBgbzJqWHI8HtUIUkPSdGxF80LDgtGzeKmEx0vMMAaP7lyBsl3doesc5S9dqhIetpuddInAJVDmRWluOScOJe/viWD0be9C1DvUgMyvzLqAf8UayebcKiy3Zi7v3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St12KE/BXTBBs0ZoJGlCtied2HMwMzatuRteLeYMIDY=;
 b=oCs1YhQQjckbkI7LBvV1ftptpy3gXH5Ij0Op2MFb3oH1lzHMEaqzIN8QxucMlAqJEaxXmaOwqUC7b0AN9V6Le9RS/vfZZBYhm9dXdrUFT3v/TdAAZWJmbEHfWKMpSKCNpjPNOTjjMqDKIz/kwZixQp6w6yArnGV481fddVYXElm0lH+3lt1hk9VJYqY4CFf3br4i2BF617tQFUdC/xnHjiQ/aaAWi97eXBbYLdx658TnS/W6OPj6fCdrIjqMl25QNYK3jHmIqQbFc6D13ClySKnrR7l02n6epaTP0pPO34A2F8+R3zCMxcFtKd/8j17f0UJ5K/yg2jwk62kpiFJKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5415.namprd11.prod.outlook.com (2603:10b6:208:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 17:21:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 17:21:54 +0000
Date:   Wed, 16 Nov 2022 09:21:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-sgx@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y3UcLudVzuS55Bp5@iweiny-mobl>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
 <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
 <87cz9nqff2.ffs@tglx>
 <CAPj211shRbJQcnhEpjs461nEMQw2x53f+2G46CXWJg6_Rc-x-g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj211shRbJQcnhEpjs461nEMQw2x53f+2G46CXWJg6_Rc-x-g@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e86581-609d-4db2-67fa-08dac7f70eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cFst40KIqFL4oYb3aZve8jSHz3JhU8jTtQUvpIxC9gSlfqHyUHpb+FhkERPBy25KaOviZuD0qEG8jbPihMNdwjqnn5KCmyPnKObs/KNqUq+9wN18R0e6yYQOBgAK2g2/WIEh0Z8/1FDkwkK2TO+081ExmRZBLncHsKdtBki01woZTX9mrSVQ67jlV9xGxpxIXesJzegVw/jZUyAQvf/tOtpmL//9drAylt6mbQWy6S/bpgMttP5IyDcQS09vT7e1MDJTVJg+eytiUG3RL96D/XE7uKtUaHNK7Mf7PNChYyw1YzBXbmCYJY54dQlpIKgIHmWvZs/QfDJ6XWV0glxY+OXmi+jJBVdz2T3MMHP2JVb9W/+gJX4fNoq1jUiWnart576fiW5hf0GJDqeYoFy0R3cpPXu5eKq5gp8BcuCmMs7h6hgc4dL0SWbzOtR94C2O+NJJbzdocqjsJ0dzcmSprSv+1Y6KnXB0229DZ+7L60wFwcRRSN7paSpDcGVYdkH6W83rT8mPJJ08eG4taIbJ6gyMUmJgE1GfEsg8wVrWw45mzjsp4aQfc3TyPHj71LQ+CqP+H/Z9bZ7ksg5hMEgcxeJSIjDh9GJzxT+B9DPsZTGoPUUWtkEwkKKjaqzo1g/PD3JTQs+YbGcKgMyyJ9fTEwZFunm8keuWl7j4Ls0qSMow/hWTjlBmEYcnEoVVa1oME0yhqCb4/lD0/HupjcdTih1yDM/ICtezpGPCqUeRxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(82960400001)(38100700002)(83380400001)(33716001)(478600001)(86362001)(5660300002)(2906002)(6512007)(9686003)(44832011)(26005)(8676002)(186003)(8936002)(6486002)(6506007)(966005)(7416002)(6916009)(54906003)(41300700001)(316002)(4326008)(6666004)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XtF0P/F7S6I+NK32Mh44PU0lGvX05KBEIz+sbz33/pto519uTjJ+NnYZW6?=
 =?iso-8859-1?Q?U7diCfD3k5psaAcgMv+3MjsdgP31jkVB9eD0tGNEdlr9bhaPC8IyqW6Ojx?=
 =?iso-8859-1?Q?cGLGrVrIPzPZeL4UoL6YT6unYcbtdOW3VRi5qgJSVOJO92xk4pExOax32u?=
 =?iso-8859-1?Q?fvLVmC+eXr+siJl+l0Qe0vPBNFoHcgV2v7xeVfdsUanAOyyyMIOTe/ntz6?=
 =?iso-8859-1?Q?MQMB3iTtZtKSXlom7T1Xjiv/JLKp5ETWt7u/6UB2f7p7oeQO9B6ZjJ97O/?=
 =?iso-8859-1?Q?l8bnw1ExMIwemHVtvg8CZldwW6W4FI5oyHBIEY9eW8gKhNVOUQF2Jsquls?=
 =?iso-8859-1?Q?Il2SnGfj5MZ6VrsiBoGxok+bjrOOM7kEtLGyKZxU2yf8bxTjcaH4iRQcZ7?=
 =?iso-8859-1?Q?etNOW4eOAVTzLbWDklCPI0D2yty4VgkFGbGF4HRElUP+cr82dX86CnLL6r?=
 =?iso-8859-1?Q?Cgq9IqoOpmQckHFOqpfeQIYCBjGRTvLGbFGl3hPlAuBBdE68YuqRajWoyw?=
 =?iso-8859-1?Q?QpkzCivnv1tWsBvnY6hZcr4Unz2N5usW/HkStMuLMrQg28zap53pT5om/f?=
 =?iso-8859-1?Q?rg1EskT968z4Dhp3UfcLKXy2jdZEl9pSg/u1uRQ96+fCEH0ZiRpusaDeJF?=
 =?iso-8859-1?Q?hITikXJ8k7MoyvDKoU1V4nkZL4vmTOAmuhRn/Gbrf4f4CzlsBN5T+jaXzh?=
 =?iso-8859-1?Q?XxMGgn2SsXbf5TbaPEL4JMSUeink+21tyL6vWRCTJwPctv5NpEKcXt0VcJ?=
 =?iso-8859-1?Q?4tWeljcs1K7zgiCZw+5C0JyxS+pjdal8P/XFs04IY5m/UpcEpaVRZNZSjP?=
 =?iso-8859-1?Q?Sl0TcT/0k73MQ5WGyi+ZIfeNOQknnlpkgtXlHHWE49yUtPY+zRSvyHBMlm?=
 =?iso-8859-1?Q?4QwS37N38f2kJiTyeMiNHf+8V+XivjSe7BbMfCBCLkXs5nXgClRTZqMs3N?=
 =?iso-8859-1?Q?oE4j58tPRT9pj4HGugR05k/viJNF0GAsYd9FOspP9EI5mz+AJjDIkx6Pzx?=
 =?iso-8859-1?Q?IoP0OmA+AaJ8GVf3ht4h6kPvtsSXfJ8ZOn/vlDlh5APTmA1FKZMdgc9NOG?=
 =?iso-8859-1?Q?g35awhggCx4NnoDp3oOsJ48DxaVY+KNE7/vkm10YoCeoiNmHhavnMzhHx6?=
 =?iso-8859-1?Q?MdFgLmBog2PWOxXmyfRZLfTPBWI39nIintJjEVALnFHihOGaKB6MHFf8s6?=
 =?iso-8859-1?Q?xKlOF/99W2qQsSl0VPtbvdTBGJgnzee2PWKgPG1XIedETb0XjPSjSIf31I?=
 =?iso-8859-1?Q?RpDW9fgadMQ7bVgQ/jfcCbLl12VFlBzGQEaqO+MRlFvnwZJiUVX7U89E9q?=
 =?iso-8859-1?Q?6JHZoVhBgasao1KXcMbdHC5+jEVtIpEnyB6AQczJELQ6Hn7UlRnQB0GEr9?=
 =?iso-8859-1?Q?1QDwfdHcfPAIrmV5BO4tL5spVqOff5RQhi35Kw4sYtNs1hSwL8qvLtPEqe?=
 =?iso-8859-1?Q?/ZLZHj2SNqLBkhRlL8jzMFIQZmREmSCYfdprHmTtpOVxL0vKzzUwv6pIYm?=
 =?iso-8859-1?Q?5NI3i0q/rYviCwL1QJw2DnBSuvXbSNNZhVtfyCYWNxJJwGVjFukB9Mzi36?=
 =?iso-8859-1?Q?NN4CopPZRX+ZkVg/8qnm2rQGcAqUka6NAb7UEXGmGFFmVtdrzWvSraVTom?=
 =?iso-8859-1?Q?LO8MS1nxD+vDfWj3p3FAoAPCsGmXGty94w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e86581-609d-4db2-67fa-08dac7f70eae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:21:54.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miAhbUu5f1BJb1OUBhOoGvkYsoVCiRjpbyIZIsAyS25uPB6W1/K9kPDfdznSMRfqSv4/HbyfUwZfi7cpPdrDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:01:56PM +0100, Fabio M. De Francesco wrote:
> On mercoledì 16 novembre 2022 12:58:41 CET Thomas Gleixner wrote:
> > On Wed, Nov 16 2022 at 11:16, Fabio M. De Francesco wrote:
> > > On martedì 15 novembre 2022 17:16:26 CET Kristen Carlson Accardi wrote:
> > >> The use of kmap_atomic() in the SGX code was not an explicit design
> > >> choice to disable page faults or preemption, and there is no compelling
> > >> design reason to using kmap_atomic() vs. kmap_local_page().
> > >
> > > This is at the core of the reasons why you are converting, that is to
> avoid
> > > the potential overhead (in 32 bit architectures) of switching in atomic
> > > context where it is not required.
> >
> > No. The point is that kmap_atomic() is an historical artifact of 32bit
> > HIGHMEM support.
> 
> I just saw that the last part of my email is missing. In fact it's enough
> clear that what I was saying was still incomplete and that no signature was
> visible.
> 
> I meant that, before we had kmap_local_page(), the choice was between kmap()
> and kmap_atomic().
> 
> Despite I suppose that nobody should rely on those kmap_atomic() side effects.
> I have been observing that a large part of the users of the Highmem API used
> to call kmap_atomic() for its implicit pagefault_disable() and
> preempt_disable() side effects

Fabio I think you missed the point here.  Just because we have found _some_
places where the side effect was required does not mean that "a large part of
the users..." do.

While I value your review of these conversions I think Kristen did her home
work here.  She checked with Jarkko (the original author of the code) and
verified that the side effects are not necessary here.  That is all that needs
to be mentioned in the commit message.

> and so switching in atomic context only between
> mappings and unmappings. Others used to call the atomic variant of kmap() just
> because they wanted to default to it, instead of calling kmap().
> 
> Since 2019 we have kmap_local_page() and kmap() / kmap_atomic() have been
> recently deprecated but we can't know why the author of a piece of code
> decided to use kmap_atomic()...
> 
> 1) Are we already in atomic context when kmap_atomic() is invoked?
> 2) Do we call kmap_atomic() instead of kmap() only to switch from non atomic
> to atomic context between the mapping the unmapping (although I stress that we
> shouldn't ever rely on these side effects)?
> 
> I think that who converts should tell whether or not we must explicitly, for
> example, disable page faults and/or preemption along with converting to
> kmap_local_page().
> 
> This is why I think that Kristen did well with the inspection of what happens
> in those sections in between.
> 
> I expressed this concept in a bad way and furthermore the lines below that
> sentence disappeared, making the whole much more confusing.
> 
> I think that later I'm saying a large part of what you are detailing because I
> had to learn all these things for reworking highmem.rst and the kdocs of the
> relevant highmem-related files.
> 
> The new documentation is upstream since months and you've been Cd'ed. If
> anything is wrong please help me to correct what I wrote or do it yourself if
> you prefer that other way.
> 
> > The back then chosen implementation was to disable preemption and
> > pagefaults and use a temporary per CPU mapping. Disabling preemption was
> > required to protect the temporary mapping against a context switch.
> >
> > Disabling pagefaults was an implicit side effect of disabling
> > preemption. The separation of preempt_disable() and pagefault_disable()
> > happened way later.
> >
> > On 64bit and on 32bit systems with CONFIG_HIGHMEM=n this is not required
> > at all because the pages are already in the direct map.
> 
> Unfortunately, this is one of the things that were missing at the end of my
> previous email. I'm aware that with HIGHMEM=n all these kmap_local_page() are
> plain page_address(). I wrote this too in my email (and in the documentation)
> but it disappeared when I sent my message.
> 
> > That means support for 32bit highmem forces code to accomodate with the
> > preemption disabled section, where in the most cases this is absolutely
> > not required.
> 
> This is the core: Kristen knows that the code between mapping / unmapping does
> not need preemption and page faults disabling. Therefore kmap_local_page()
> will work with no need to run in atomic. We all agree to the necessity to
> convert but sometimes we are not sure about how to convert.

But we are sure about this conversion.

> Otherwise a script
> would be enough to convert to kmap_local_page(). :-)
> 
> > That results often in suboptimal and horrible code:
> >
> > again:
> >     kmap_atomic();
> >     remaining = copy_to_user_inatomic();
> >     kunmap_atomic();
> >     if (remaining) {
> >       if (try_to_handle_fault())
> >             goto again;
> >         ret = -EFAULT;
> >     }
> >
> > instead of:
> >
> >     kmap_local();
> >     ret = copy_to_user();
> >     kunmap_local();
> >
> > It obsiously does not allow to sleep or take sleeping locks in the
> > kmap_atomic() section which puts further restrictions on code just to
> > accomodate 32bit highmem.
> 
> I understand and agree. I'm sorry for the missing parts and for expressing
> with not so good English proficiency.
> 
> > So a few years ago we implemented kmap_local() and related interfaces to
> > replace kmap_atomic() completely, but we could not do a scripted
> > wholesale conversion because there are a few code pathes which rely on
> > the implicit preemption disable and of course something like the above
> > monstrosity needs manual conversion.
> >
> > kmap_local() puts a penalty exclusively on 32bit highmem systems. The
> > temporary mapping is still strict per CPU, which is guaranteed by an
> > implicit migrate_disable(), and it is context switched in case of
> > [un]voluntary scheduling.
> >
> > On plain 32bit and 64bit systems kmap_local() is pretty much a NOP. All
> > it does is to return the page address. It does not disable migration in
> > that case either. kunmap_local() is a complete NOP.
> 
> > The goal is to eliminate _all_ use cases of kmap_atomic*() and replace
> > them with kmap_local*(). This is a prerequisite for system protection
> > keys and other things.
> 
> Ira confirmed that system protection keys aren't affected.

I'm not sure what you mean here.  This work started because of system
protection keys.  But since they have yet to have a good use case they are not
yet upstream.  Therefore some _specific_ conversions have used page_address()
directly because those drivers know _exactly_ where and how the pages were
mapped.  That is a very specific use case which is different from what Thomas
is talking about.  General code which gets a page may still need to have
additional operations performed prior to using a kernel map.

> I'm not sure about
> what you are referring to when talking about "other things".

There are a number of other ideas where memory may not be in the direct map.

> 
> > Thanks,
> >
> >         tglx
> 
> Can you please say if you noticed other further misleading or plainly wrong
> sentences in my message? Ira and I are coordinating this conversions efforts
> (from kmap() and kmap_atomic() to kmap_local_page), so I'm much interested to
> know whether or not I'm wrong with regard to fundamental details.

I think the issue is you are trying to get way too much detail for patches
which don't require it.  If you review a patch like this and you find
kmap_atomic() was being used for the side effects note that and NAK the patch.
If you feel there is some evidence but you are unsure a quick email asking is
fine.  But if there is no evidence the patch is fine lets tag it with a review
and move on.

In this case people are getting frustrated with the 'bikesheding'[1].  We are
never going to complete all these conversions if we spend this much time on the
easy ones.

Ira

[1] https://en.wiktionary.org/wiki/bikeshedding

> 
> Thanks for helping and clarify,
> 
> Fabio
