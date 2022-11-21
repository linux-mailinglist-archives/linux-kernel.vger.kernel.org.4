Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF616631805
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKUA6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUA6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:58:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3120BC3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668992315; x=1700528315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=imQqJKmr983NmaMD9izKiZThIwN5bupi6NI7WpEXI08=;
  b=bJ14QI1TgVsuf9LR76objHDhbNnXbg+5g/qtVTukx6JantSKgHrtC3yW
   Hj5GftBpZHIeiHHf8zDmPZC4xJC4jhoEldpemlAtCdvi9FnynLUXaQgu0
   xDW3DWoPw2alIct+vIBMEO8H9bct5guNPsoBiqz0a3siB3L55HYy6NIGr
   9smbL0jOZewgqz0rwPUHAVmcmLbJxjjh3PUtpaSzpvGMR9kYjx0OOy3Qc
   q1lsYxzyRWRgf3rEE+bljiM7PIU+D1gXpEq5cQMxDb1cDveUyXrn2XIoB
   5GxgdJwIa86qar6I2Kc2ox8MXbQrY6Dxwz3hPAMEcYJVr0xx8rRr+p29e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="313476159"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="313476159"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 16:58:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="591597348"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="591597348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2022 16:58:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 16:58:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 16:58:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 16:58:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWtA8GEXLYTa3l5mmhQKul3d60+zlBLaFyOgm8dxUsMrbjLfnuXKCQrP6q751qT6m0Vt/lhFgJMEHnLTm6KOIz4goEW9EiSBbZjjfWCpRIHjWypzXKFjUMpi2ivPq+M3Hqa6a7KwStNAkUdC2BvGzm0IZiTBS2MeieiLSGPU7ooeMD5RdjcBDCJbPdGbxhumfoy6+DEcjIdJzhjkJyFuwUYZIPzvQKoutsQRAbF2fFW0qao1By0IwY4PIGtE0d/WWIrqGPsG8C5NoCEwaK08XN2+rhzN/U5vZBjZCov9F0LHnitylpPFKBP+VSfKIfqNgn9ynXhIKle6mpo5qA35QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BZTOedLyj0oMkwwerY6bOkSSdHhn6l7AG6Lua4C8fk=;
 b=cyixARV3GRJj0cYfsbjpKif+LB8VyeEGg5kKuhPo9/cp2pC4ZK8ytBdD0haNrwQZNKIg2XcQbyNmrlLLY2msgbFwAoG85NbMmhR/1HGJu73N8p7MQ2viyFnHfsSAz3aVYb7+smS1WrQR91jiXVJtXqidy2DAXyLLo5poKqRu/AHQoigg7vwzqfm8/gy/x071kOyYKASqqzjkx69OUE3bMpnDvkeagO52SZiKRj8R8UG56r1NJ/XZMBnQyHZ3zwAKoFgM5fcYQBNFaX5z5ntjQLANGqUFSLomUD6DEEhHtSAetcuXpeFtiUlmVrGGOXFSjsL/OFB53CQZr8oNfll9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 00:58:31 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 00:58:31 +0000
Date:   Mon, 21 Nov 2022 08:55:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y3rMc2VbgVLHN9db@feng-clx>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: a18c9cdc-eb39-4299-348b-08dacb5b8221
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOODE6RDQiGYxkTMMRsyKdvf+gWhR85J3KGw7IHIrC1v9mZBnNI4Jv4Atq0JFsjjSvUXYP8/0Lmu/74xygj4CX+iGW/eP4OiaSczPaX7VoVRyy9GMHjurZbJC/lpG7l1VTt9SFvEq1/U0ObzTlJZlhR+sGmY2bOqzalCs8S95TgMOBZktcodFpSUs4/LFcIQ2yVWVLNETb/eX08s9JxpTLKjk1jelNQW4ld9x5vUUZ1zsB8A15XZmqgvwrs8dlDhyIU/380F56c/M6Bq07uhlITSUfZa/AKFo8ZXxPbE36XBvlrpt1Xh9IILqRXdrmZ5nMRkjtc4A3S8ZFohgG9lOGcEJ/Rf/G14A3utekl0yMHYGwUre8EoUL3tjKmPb7O6Kdsz07IC+95PnnigOu3fd0Wju/Xey64N1KwVTHWSqWfvLJCE/EFRzjeOfUMKExXL7gFhqry5t4DH/ig/y2zwzyJuZhWYt/f7WGHA/Y3iyjVCRhlPpM6yR9RkIhRUtubteCuhnJmpmEh5wG91I0xDhnZtqhkfBvmjf+ca2ZIa4QQt1nCr1rvpxzVzvX8g4uWODq0Ai88mZ8ssruBCnxuD44+UoCTp5jqN+s21s4FOe5GeURlfg4iIrU3icW0VHV3xazB73UG4EWYAJcXLUwpt6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(6916009)(44832011)(5660300002)(7416002)(316002)(6506007)(41300700001)(186003)(8936002)(26005)(8676002)(6512007)(4326008)(9686003)(66946007)(54906003)(66476007)(66556008)(38100700002)(33716001)(82960400001)(83380400001)(2906002)(86362001)(6666004)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlYZTxr46BY+faK8IMWDCEkHMOyR16afQTYAtPk8EkzYdgxAvjqWY6/mz5Y9?=
 =?us-ascii?Q?frzq5AffcJOxD9y31n8bx/sWS9X5DagK/AsEO6WoLQxauvPy4IotCR9oHGV9?=
 =?us-ascii?Q?DWcHgmf/C3DXNYJNccK3Nw4rdls3eISp5iBW6dP51A9zi9heVvC6oVIhfMeA?=
 =?us-ascii?Q?cfUmyQEr2rHHXgYDT12EhKeX8MP+3u/Od/GoQSL+B6UK+XPsRaWZnDyZOyLf?=
 =?us-ascii?Q?fGXTG0UeXVcXPIkkfK+7UZXU4nCSpC3YeE7OXGYZ3+2b/fd+41eBi+o4hMvE?=
 =?us-ascii?Q?VF+DbbDZGnExqZHlww7pfKJ3IWtGKDlomZANswtc3WkyZcdwIo5XZw5Zg7Re?=
 =?us-ascii?Q?0CFJepdyQbbJfQ+rgchsfxZFRzvqjduqlyBR1KRlvwVA1WF++SdWbItAFnw8?=
 =?us-ascii?Q?hyyTPbxTVUma/Xfir119sj4y1ZYjkaK4InRbBVfzuRyJLPJjCx6zIZ5AUl3K?=
 =?us-ascii?Q?1Y75+pbmcWBvnT/VEMmYXdYkJGP3h/W7B4RdJR8M3QPwthiOPqdIP0FVbTLf?=
 =?us-ascii?Q?pcx4ZnTQuH4x4jRElorA22PE88BZwS0OqdsG6j9tqoEbi2jq+x4LydvsBp8K?=
 =?us-ascii?Q?ht/GGCpY/aXNyIfFdvBf1q0OUebD3A+ounb62HRFSaototnanXpSOe3uvzVM?=
 =?us-ascii?Q?jAsykDirht7qmiE8Cdlei3ROokkJcB1jrRMcZiEfcXa/916y3IJRYTc7aNYA?=
 =?us-ascii?Q?wu1tTe7onJBlmEMPU0pIkw7B3caPvUHosCHLdz9FRzKD7Q1lEHriQRMXaBK9?=
 =?us-ascii?Q?1/sLaMFR/4XQuiRk/8K4P31wZrdL7t45k9f9hJhjy+nwt8hMzHG6ISJwlGdN?=
 =?us-ascii?Q?3aLVhL0O+qEY9TLgxBMQVfD821CuQpOZHWez+6A8ufitueoiIGyaLD3o/T03?=
 =?us-ascii?Q?kQo2iOZXTkshlo3STCT81/VObAvpaCy8hdS+dB/dsjwmOt86x0s4zUwRgdio?=
 =?us-ascii?Q?3Mnk125P9yBoc6hqyp1X+IZ+3VFOVPpW7TVIKa/scOpxl1NVbNsQiSLfZtK6?=
 =?us-ascii?Q?FKg5h0fehO1NCzzeYu/D/IKqivwxrzhOh3ZxTCveuaUwL5E21RbQIXDAliJX?=
 =?us-ascii?Q?l5xa8GljOEMnKm2CRaGS+lc69u/vVYcRz+RTq8uZ+9dNJP+05GfLpuagIEO5?=
 =?us-ascii?Q?mhkS6XZ/VkLPU9rOqqJLAbhJTt7Nvtli6b+x5NL2LDohg3GIcdUgwC06dw0w?=
 =?us-ascii?Q?RPGIOA4l+RB3dHvPvZQ2FIlsaaBMFzFtJVZk/AV8iZKnvbcF8nhFfCkSsupI?=
 =?us-ascii?Q?4Uw4LkDV/TD3h1NuM/qzxQWMrgBdvW2z1VgfOV/v6q38x1+EWmlnmDyDx3YH?=
 =?us-ascii?Q?87zn0ViY8z8BhnLqGvAWiO/Nb8pdzER1nLR11g+uEtjJZRYCLe+qoy3hC+Dj?=
 =?us-ascii?Q?Ezs5M/b7oKpa5bufDi7FFPSyEOAAuY+xAi7Bfh3hECwRdoTVxnd78eWU1khO?=
 =?us-ascii?Q?yW23SvRbb5+Lej/fgL6cg/tZceMlicZoHSdvf1s/8yQa2MkRjDcXywRGFzJQ?=
 =?us-ascii?Q?seWFBOcaKeR0YikfELeLaq4v9nR8Gi+H0GClgnecW2RIGma0ud6yHnVaDDIw?=
 =?us-ascii?Q?ii5TMPMcjQ50yVW6VDeDLiZ5lXf+cUFBPnqjG/Hb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a18c9cdc-eb39-4299-348b-08dacb5b8221
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 00:58:31.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ASeyuyHhVr/ZNjOCisc9s3m+fLRa8peim4GXWL164LqTL2o5jOHtXYnh9+ObScDwtFl23t9qvXJcRbBPu0GmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:09:10PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 17, 2022 at 10:57:34PM +0100, Thomas Gleixner wrote:
> > Paul!
> > 
> > On Mon, Nov 14 2022 at 15:28, Paul E. McKenney wrote:
> > >  
> > > +		/* Check for bogus measurements. */
> > > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > +		if (wd_nsec < (wdi >> 2)) {
> > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > +			continue;
> > > +		}
> > > +		if (wd_nsec > (wdi << 2)) {
> > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > +			continue;
> > > +		}
> > 
> > This is really getting ridiculous.
> 
> I have absolutely no argument with this statement, and going back a
> long time.  ;-)
> 
> But the set of systems that caused me to send this turned out to have
> real divergence between HPET and TSC, and 40 milliseconds per second of
> divergence at that.  So not only do you hate this series, but it is also
> the case that this series doesn't help with the problem at hand.

The drift is about 4% which is quite big. It seems that this is
either problem of HPET/TSC's hardware/firmware, or the problem of
frequency calibration for HPET/TSC. TSC calibration is complex,
as it could be done from different methods depending on hardware
and firmware, could you share the kernel boot log related with
tsc/hpet and clocksource? 

Also if your platform has acpi PM_TIMER, you may try "nohpet"
to use PM_TIMER instead of HPET and check if there is also big
drift between TSC and PM_TIMER.

Thanks,
Feng


