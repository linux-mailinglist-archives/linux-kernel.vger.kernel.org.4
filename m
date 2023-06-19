Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA5735D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjFSRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFSRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:51:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F4B7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687197106; x=1718733106;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SciP7ZyTp7+VfNXVMFapX2naV/EqR3/0Ot+8GyrTl6w=;
  b=SSAuCLeCFSRUCuOC7JvlfhpYoD3l3riJHd1DjLy8Tux4DiZlkqFKzQe5
   TZL03SuOes01EpUkiK61zhv1NBvJSIgFBC4snkUEK3qnYzHWYzaN8yQQG
   KKsFq6TDFohgGVpEWqt2nKuFK9nEAcTSdq0t1PFaYiwTIawMEKk0yfLWI
   hljFoa0rDVyLHWWvVpAbbA69zDNYoAVCCyS6p5DBPIUwaVlcnImFxi4ke
   3rWG1+CS/a+ceO8n+MKAvzCrHzZGXwsRvH9vCWlaIUW8FKfekuG37sYky
   AKtSvD0r4b39GXV60JW5eXD+Tpl/nCCSjbXuAZZ6bwaL/MFIBZJt6tt/S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423347744"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="423347744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 10:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="664041852"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="664041852"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2023 10:51:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 10:51:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 10:51:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 10:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnIUfJSjX+Mrqhz07HwWt060QQDX3bxOlcPLLAmT4jAW/HJ3zAyUCnwGUEnq5RcogKEZdO5Ifq8ZmAb/0eEDgh5Or4ugPmNnWgW9+QzEnesCu4IytFiwTNYLE2AfJqhAb3KkbmCcWgv23+ithQlkluccHlJAhYgn/8ws0+gNinD/i3r+Uu6hi9dkEPT8A5Y9UNjNpRW2FPlFWRBSoQItmorV3yK/dsos73XzWyEAApMsz5AcHlk0u2cv/tu9iIILItYqPw/ooSxouJzD717xGyjWnM/5oTZCnrsaCN7fNq1NKP1uW5QqeRCAEZizSn54Wt5cTVxes11YTfEofHSQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHzb6OFCv+OtwwRIkLHZVRSnbzSkLZRTVe1yme2eh7s=;
 b=LcHR6OujT06FHzjTwcuUp+VVlTfYxTZ0QD5tjwOB0yQDNlo5cBdtrhLgeft7LyizQ/5c0E+ijr65aHS4kirCZEftVLUsAWs9Ys5r3vUfSjSfuKOeB84QTotcR/JGKSYT0B3178LI/0lSDoDk+xs1tZ3moxo3sIB7/EUh4/to0Lu0wzYxts9T1dm4pjfPvUE6YPCLOgIvr6VYRAMU+kPTF8bT3hFZ88fYtkgg9Otz/KQ6xxNpIqvSljFaiR9f8+LsNWW2rxtOHbJRqXhG59aBAqnYALq0/1mOlV/3EPn4sP4tCQw1JIB2EsVSYSJECVVeiPNev+3wTFSUMnu9HELWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Mon, 19 Jun
 2023 17:51:43 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 17:51:43 +0000
Date:   Mon, 19 Jun 2023 10:51:39 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZJCVq/cBCDFBcpwa@a4bf019067fa.jf.intel.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
 <87mt0z7si2.ffs@tglx>
 <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
 <87h6r770bv.ffs@tglx>
 <ZIzM13q+zI7d1eZs@araj-dh-work>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIzM13q+zI7d1eZs@araj-dh-work>
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e36d017-86ce-4024-3cf6-08db70edd788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/SIVko7ud8DFt4mvoTyvK4zGgxldx7GSMbrWFnCUX9qUruN9FhYGVDzLAT5mFZzfGghJ4YWq75PIGfB5HD7sZcA+aIrMdfnNO0tW/keshX04hrjIHrsV+l9aqUW4pMm0S59zbEODGrEEUkAKQ9xNCiyoapkgv/JeUaydVqMtlsZoyy12cnUXKvIVkX3ItqJDQaRGw0WQ+zmXrXG2od+FiPzlU5/UO2F1TR5U4/d1ygNI3ZhqvjORz0wuG0G5vwH3nHUJOkZVv66LZKyIOGyrUYnjS1WE8gT2YYul65O9W+4KdT880BZSjXqlEdAKDzOf2DAp/iReC/v24FauqlXIXI8SS3PgYwpSXxJzvaMzksTR1ivyqE7qvmC4X0H0R5C7Q8LWvOCsgCkutfPRwpAKEvhLWVnOxuI8XyCDLgOiW/lfiPmmdGkSSTV6HUlvDnZwTyh/IYm/JjtGOdt2hOq0msoouYqsskd0zOsUyusW8pCHCgQ0MF98jAOVmLzwHgK6THFhpLFPb+BRYoLS3DMZY99S50XSBsQCXRCo/yjKYcdcP0igj4GuqKSdjqjvTX0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(6512007)(186003)(6506007)(4326008)(66476007)(2906002)(6916009)(66946007)(66556008)(26005)(86362001)(82960400001)(6486002)(5660300002)(41300700001)(8936002)(8676002)(316002)(44832011)(38100700002)(54906003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjmRhT62YxvfmzrmggrzHvqv4Nuxrb8xnhe5B4tr8+is+tFdmsP4goHlBd4n?=
 =?us-ascii?Q?GgZK3KWBoAA1w6IheSI7ikzsbgp2CWoGW87ZKJvmnXD7p8UhS4wGJHzZ/CxT?=
 =?us-ascii?Q?J/5/LjZNQ9VB8FiOlbLv8lsT5WVgNXYXyRzc9+WE/j7+kpn0MH7OLAXIiicG?=
 =?us-ascii?Q?nK/RIG+ifhTyMElfoh1vtDWJ4KGxgL+J7Ye9NUnjlNqbFd2WMRfWhxIlx5Cq?=
 =?us-ascii?Q?wt9wLVRL8mD1LREUjGZ4PNknXf+6VnqLZBySo8Y6yjqyPon5WuRxGjEaWES2?=
 =?us-ascii?Q?oY3EKQUiSNeH7ZTGD6RxhEtOE9ScHi81oioXUz/WRg7GI62PosL5N3Q1HDXn?=
 =?us-ascii?Q?umkQejvf68PBmbQIlalPCsWEXbdPmnZ979u4iuSoFb/bK3eVL0rtU+cu8GIs?=
 =?us-ascii?Q?RWUupd3KsU4DjiXpGRjU5FhsldTjNVgP+8sYF+F6bgEorJdu4SPGhEkldost?=
 =?us-ascii?Q?7ZQpTDwoNX4jYapRjyrDOqz2oWzVGhzOGJSFSVB0CKUpdIYXVW2sn5p5yRYD?=
 =?us-ascii?Q?EtKBtDOFhPsfkKivZKzR+SPiL1HWsOaYVgWpnAqH+elQkPtez1aNvka9mRtT?=
 =?us-ascii?Q?CUT26bzkNzrUci7JOogSuUmvoZIRSr44KDK4uL5RdU686cB3PeuDRuPRkPlZ?=
 =?us-ascii?Q?f+50oBANzqi80rXUs7Kn/taTBUHufs/lGbybRVUxErWkLDnh9eHezxjoFhoy?=
 =?us-ascii?Q?js4YtHmO8+HnaVhzB48mRUQWUXgRCl1QDE4DSKMwwyptZpni0oneYccwXEGE?=
 =?us-ascii?Q?hIQdT1qzCDpuimpwwt0XSohepWdc9RGMIZUPKUUUa8eqqbd4d72Z2ffnqS2k?=
 =?us-ascii?Q?jxofOtar0HbVISY41reIhPFpssN/UNwrDL/PmzmT9sL0UnJ1shoH8FJlZ54W?=
 =?us-ascii?Q?9o2qPZsg/gHU1kmmZBUI0/kVgWphNBz4UoNdTbbHw8ymZib5AKO2Ac5SvSrV?=
 =?us-ascii?Q?g7HH8nPsMsKsWwwSINYEbsmXWMCSBzG0W9z/ael4tfwsgO9R+mQQqRG6yaox?=
 =?us-ascii?Q?Co5+KZ4bNXb+0bD+KDYKhSBVSfFUHylRzDo8pcVSGieDxXYeRoDrqv2MGcEb?=
 =?us-ascii?Q?kUjC/OHoZmhiMKRWxbR9+PcLkEnRKWIFr2sC21zOq5DNu2kNTQgjzcodkWch?=
 =?us-ascii?Q?bocSThxSmFXd04iKLKzutuYZLb+mQrEY9LR+1wsIacd8Zebe+uQoSerwLU0o?=
 =?us-ascii?Q?t5HmY1hkwtmYVfKaSTwAOAb4w6JeVlVIOwT4I0ouH1yeJb9gBg6ap502bTMS?=
 =?us-ascii?Q?NA8wYvBtJ4DYSLmm5TyQ86RrV/mp4mCYRg3Cwy9Jqzo5Cn/AU2iEzw27fvdW?=
 =?us-ascii?Q?tIWo3k6M3JTGIqX8ryV5EbG5UgEd1YzTp+enoLnKp0ONOXDEOeOkjLyAeaej?=
 =?us-ascii?Q?3g0d8awrpcQCohBUVK9SI9GPuqYhEY5T8+ed4ZnPdvPGSw+qi39qAX5em8O1?=
 =?us-ascii?Q?5evx9exKm/efINd3kUGw2ZjhM4VSL2ZpqPqnrm5wNAEIWu4XleW6jqdJjTok?=
 =?us-ascii?Q?+U18PTdddSevAjC+mEkQhw5yeI6y4DU3G6nwuQRu4HPWcqFJYXXoz1rPxap/?=
 =?us-ascii?Q?gw5qVGdWdC/L6t+JQzH1vq1w3y6RpZh8pzrq0k7b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36d017-86ce-4024-3cf6-08db70edd788
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:51:43.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EuTTRk4XtWjG3LRjulZxLMrwFunxFtebSJ+V9/gr88tgsXqQbcGp2DBGIzISt425tZ87kb18O+WAoXj3KCrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
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

On Fri, Jun 16, 2023 at 01:57:59PM -0700, Ashok Raj wrote:
> On Fri, Jun 16, 2023 at 08:01:56PM +0200, Thomas Gleixner wrote:
> > On Fri, Jun 16 2023 at 07:13, Ashok Raj wrote:
> > > On Fri, Jun 16, 2023 at 09:53:25AM +0200, Thomas Gleixner wrote:
> > >> > can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??
> > >> 
> > >> That would not set APIC_DM_NMI in delivery mode and the IPI would be
> > >> sent with APIC_DM_FIXED.
> > >
> > > That's correct. 
> > >
> > > Maybe if we use apic->send_IPI_mask(cpumask_of(cpu), NMI_VECTOR)
> > >
> > > apic->send_IPI_mask(cpumask_of(cpu),NMI_VECTOR)
> > >    __x2apic_send_IPI_mask() 
> > >       __x2apic_send_IPI_dest()
> > > 	  unsigned long cfg = __prepare_ICR(0, vector, dest);
> > > 	  native_x2apic_icr_write(cfg, apicid);
> > >
> > > __prepare_ICR() seems to have the magic for APIC_DM_NMI?
> > 
> > Bah. I clearly neither can read nor can remember any of the internals of
> > that code:
> > 
> > apic->send_IPI()
> >   x2apic_send_IPI()
> >     __x2apic_send_IPI_dest()
> > 
> > It also works for all other APIC incarnations. 
> 
> Works!
> 

Forgot to add 

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

