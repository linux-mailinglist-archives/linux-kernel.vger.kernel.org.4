Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40A721B65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjFEBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:12:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B89BC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685927519; x=1717463519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NBfh2E4os8fdIgkNpTtH1/MkiT55RgF6JMC9l2vQ3hA=;
  b=jy6K+pORrqe1r/mg7WJUsU/Hj1E/77Vwvm6riptb6Yr0U4EffiGuPUBv
   vDi5/UNFY/L8fVDOqm3+gbboTOj0CzK5xZ3Fppof0FXKiAhbp+svO/g+a
   Gmqjk3wOE7MPOa472jDqphg9RXPT1M4lnbelmuH9f0YdmMv16KrT9lens
   FBv8tNHM7Him8GBw5xfbmwQFZhH66OXkMKocDpOFQRuiATNkq3sxk84uy
   YcGZWGu1TgynkQsJA2p4e4OpEWLGVgjmAoU5Lo8Chf8Ben+C95SltWKx/
   +12/C+5BINJ45BSl74RdjzDEWnzNmrhB0rVz/AXLdtutxfF0MAsDOK7N0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353745632"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353745632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 18:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="741515515"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741515515"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2023 18:11:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 18:11:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 18:11:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 18:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg4e2h5adap0eZLqkUQ0DSWy+5aJQ1a4PuL0EEbwnXPi0c4IPgIN6g4Nz2m0aAcuU1lP4ZjV6M8+/2Dg6KpHG2pX1YT2SzgWtGqBbbaqXktz5kX4mn/E1oMKz/MglRZOwoY4w927l+GgaWMuwYPCexkAzmaQr+5Rp6ggcVV1EZQpKYKIe7zNKJqdUjpoSZwXYMWtDF1VDbYu2f6aJAIorl7zw1Ze88ZMwfLceZgylyiHO5fkxpat+GWcDu6H5TnfMI+fcgtE8M2oB2riNeC4rMeGNtSlubURgSknX3cwvBX0a0f32UykIqy3M/sZdbuNOHb9UPF0KOm/MrY/NKUPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wvKNV8lkiMjZUarJGnQBdzPVoPl4Ws/XiyPIc1Qxvw=;
 b=bCg5VKTmX9D81ZZZF+o/3NqSxJhlliRtgU3htXASJNZgqQec6aRkQW2Ma2VPaJWq1oipFDhpZuyrGjsAXbdaX2GwVEBKvn4hYjDdJtZOH9h/3s5XI44YNNzSTIMeCHFJF09PpKENSUWLdt9zgLVc0nKdU1TM3iGQhg7pLPHD8xGVaIX8dlXKKhMCToHBn1KOlIADYmFxvuPVumNYDfURhHq3NW1OqCf5sxXfcTEIyze9Fn53qy9WYxB5EqUEf9oPNo133PgcvQpiR+Y6kGIJizY+3bJYmAqYAzNInE9Qd12OFLU9i8F5j3CsH3zraHxzIsPstEUespb1oYsGqi0CTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 01:11:55 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 01:11:55 +0000
Date:   Mon, 5 Jun 2023 09:04:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <rui.zhang@intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZH00rXjK+H1BTBrQ@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <934e9008-36db-492b-b744-9d68183c6d32@paulmck-laptop>
 <73283eba-14b8-2da1-6109-c183586fe5b7@intel.com>
 <2c5a8c69-21d0-4b1a-ad1b-6072228e2b43@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2c5a8c69-21d0-4b1a-ad1b-6072228e2b43@paulmck-laptop>
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2a3330-1494-493f-714e-08db6561da02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig1pNw12q/mmwPRHKk8sII7QxiBlm74bQzEzWX1Ee4oOS/o2StoDqn3V58eHaFfgziJo5f2oaRY2GMDdFM1rTjqgI33f2R5IwQ6XjgpjMGkjcf5AQBmvLFv5pibegcbny4gagmbJpWcqMyywJmTo+I/+CavM3OMgfCduKf/gDRRBTeviVlCMcZADUpckKSF1sAM+PqR/4UZOq6agQnPa+k9Y+48S/gsysRzHS8XsdbMFx5uIPpNarfO+K48uSTbjgz4HLy5xFEKjYp2/bOvMQGUe6VXYr1NmCTDCUVgTJQJTKZB0MZ4TrCWNOoSly7V1bMNITKOrJr3iTOAaxbdM3N2/+SKu46ekLl5U8qSC2p97XPIZCznr7r2+9DCE1YlHmtz3mmETkc9Rk+BzfUlLdMS4CNvtecVgv9AtN7s1BCdmbfxOHDXBFZh3k9t8/ua7rPTahvUEx/3GnsSaKYjry5sW7HT1tPTmlf8G7qi5KkkpCx2OGphfvHIhT14ADWLyNb21C/uWLUepgnWF+jXhvT1rF4ZJqQk1TSZAuIMOwNtHc+1kZYWKWQ6FIxc/fJOjgYRauVxUUISNhIHvIu5FX4FOAv3+diSaDh+JElDu8hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(83380400001)(54906003)(82960400001)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(6666004)(6486002)(478600001)(186003)(2906002)(33716001)(8676002)(8936002)(41300700001)(316002)(5660300002)(86362001)(44832011)(53546011)(9686003)(26005)(6506007)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CYwydEYx9oQb3RqeEUODuPJZBXPMQa1gja/+j4W5OadMl+DpjJRmJi7PMxS?=
 =?us-ascii?Q?+GsjxNpB90QkMTGX3YGGZ2m1Q0PZT0Y4OZNtYR3th+Iv99YA1g/LLay4zIaP?=
 =?us-ascii?Q?pZ+E5hmTzBiNHPolphu1O+io7ggFlaV/Hub2apNJlRGvSij1hPM3pToOpLFi?=
 =?us-ascii?Q?gUeeNtNN04X18ug+bx5Y91d4cdcx7TuhY1tKY5c4+nPZv/Xw0vDNQlUBfSzj?=
 =?us-ascii?Q?8cp4wZ5Wp1WsCy6Km/d6xai/rZdCK0YLStBbLeXPQPBSP2pNyIy7EpxOcTTF?=
 =?us-ascii?Q?IZAvw2mp8EilaB1GmkqSEwkF25WpocYWcORNRei2CqnarLMHb38rD9SjuNad?=
 =?us-ascii?Q?vO6gaa7pNgljh2xuTZLnjQUxXxajj2uv9hcVUqMFFdAnlJh1fkVlj9eZc+Y5?=
 =?us-ascii?Q?YoSUaWtVaTc0lt03LDwz1iBt8SURVOnJBEEabe/HTcIAZ0laD9+f9z4MD0Tf?=
 =?us-ascii?Q?duHyVerIGqAeiNMdD402pqnb6rdwDforLhR2qQkJISc3ijXY7bEBut7K5F/I?=
 =?us-ascii?Q?5pJe7ktvYoBtYdetOPXlowiO2qxHTEgI/3cDC6fomWtR6K1qZnmdgTCBW8/F?=
 =?us-ascii?Q?Hxdo3xdTLVxx5h1sBHD47DSFMJf3/gtpzpiYMd/6vjrHsgbSQgVXmOOGY3M5?=
 =?us-ascii?Q?+40/KS38EuejS/8EOcD8I6tJ6qAzKPuKklkkZVbR88ljzOsT2GpN+cNeqRqs?=
 =?us-ascii?Q?OiOAnPzOJTMXztLPV1cqCjTRM+4/jmNUJKPf7DQ7dPeq4+BcpnRxkqpthLZk?=
 =?us-ascii?Q?jmRzQXXejr0TmEcQEJLhJcQS0I0TKhIuZOHfkm+MScIFOn/BiKUQm/CuQG1f?=
 =?us-ascii?Q?4dZr99oMRITeUX1Ay4yNd81BiDbzbid9iEfaSB+6TvH5S6qQXrBdybVo+4yd?=
 =?us-ascii?Q?WRk5Xphvl5GTRWa7dkk3Vfc+iMzd4cbff+4D/9LrLkSd3m+ekYEJKKA1agFr?=
 =?us-ascii?Q?VYyK8E4AQeOFhJxSlB/9zsycrd09jkAXnRrpnokSH+wxxnepNSvW0cu3Lck1?=
 =?us-ascii?Q?2W+eaJIMvPhwsE5zYazs15+47nbuAYtMcBMQl0pNJzXDWzLLTXP+HKOzfBiW?=
 =?us-ascii?Q?49aWw5wnJhZbrnjdjuHqsP+0GapyIg/lz73sAapIcL22Wtehgg/Dw3XOLCra?=
 =?us-ascii?Q?BmC9mkJK4BmDmQpiv0bauSZLJAw7rbhGkhwQFuYsk4q8+3E+GKjflfvP7Iy2?=
 =?us-ascii?Q?wWm+mwCzVYPZHkISzeggLni2oWbCP+h0xdTHbXqEG6RXfgsVu9pRHZdjQwpV?=
 =?us-ascii?Q?gdNbi37uRnC2S3bVlDHmPp8hsBbydO+5ISePImU9dr4XfLowFOUBDLQ8lD5l?=
 =?us-ascii?Q?ODLE7KFi5DuBjAfZRK6WdpHLuuw5W3owRjlgOL7c1osHzheg+AimYp15vAzy?=
 =?us-ascii?Q?G6CF7wkD0qTgOoxAeK9EZuUWMSej1G1J8wdpglcNNeYHPTmO4xwOgIJBAIvg?=
 =?us-ascii?Q?lSyEgJNFLIMCBO4y/c7cFJWkVK/6jHn6e9uNRtvrfCxv2nmSfgznnZN8MgB/?=
 =?us-ascii?Q?eKUSM5ZaM8fOtSEhX1z4YRYRx1NTnE6t4fxDyoE7CcIcjq7hbFscYiCgfail?=
 =?us-ascii?Q?H9xbA60IJKSVVlD4U7UHQcJhiCP1VYCJigcYpqhu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a3330-1494-493f-714e-08db6561da02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 01:11:54.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zqIhhCe9yL67pf6j3gXIKFpC6MO84XZe5Ym0zZ/VkRUx6DnKHrk/43cnkHmCRPjRUgdlJztrC9MaU7quSg7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
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

On Fri, Jun 02, 2023 at 12:08:10PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 02, 2023 at 11:36:54AM -0700, Dave Hansen wrote:
> > On 6/2/23 11:29, Paul E. McKenney wrote:
> > >>> One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
> > >>> and they will also do this recalibration.
> > >> It's also pointless for those SoCs which lack legacy hardware.
> > >>
> > >> So why do you force this on everyone?
> > > Just for the record, this patch could be helpful in allowing victims
> > > of TSC mis-synchronization to more easily provide a more complete bug
> > > report to the firmware people.  There is of course no point if there is
> > > already a fix available.
> > > 
> > > But it is not all that hard to work around not having this patch upstream.
> > > This can be hand-applied as needed, NTP drift rates can be pressed
> > > into service for those of us having atomic clocks near all our servers,
> > > or the firmware guys can be tasked with figuring it out.
> > > 
> > > So this patch would be nice to have, but we could live without it.
> > 
> > Is this the kind of thing we could relegate to a kernel unit test?  Like
> > make the recalibration logic _available_, but don't have it affect the
> > rest of the system.
> > 
> > I love patching my kernel as much as the next guy.  But, you know what I
> > *don't* love?  Explaining how to patch kernels to other people. ;)
> 
> One could argue that we already have the TSC equivalent of a kernel unit
> test with the tsc=recalibrate kernel boot parameter.
> 
> So, would it make sense to have something like tsc=recalibrate (already
> present) in the guise of something like hpet=recalibrate and/or
> pmtmr=recalibrate in order to allow people to opt into recalibrating
> whatever timer is marked unstable?
 
This kind of hint parsing should be in tsc.c, so some name like
'tsc_recal=hpet/pmtmr' ?  

As hpet and pmtimer are the only 2 choices and hpet is the default
one, if people want to use pmtimer, they can use combined parameter 
"tsc=recalibrate nohpet".

Also, thanks for sharing your thoughts form a victim's viewpoint
in the other mail! :)

Thanks,
Feng

> 							Thanx, Paul
