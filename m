Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1F613012
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJaF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:59:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E685FB7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667195988; x=1698731988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ywx+7htbCa/Gs+NLRkLDsPJhjmm2dfP96YTNLkJSXIA=;
  b=J964VqmVPXIyPeVok2sBhZD+KVslOjLufhG0bJi/phLWlOPEgZmtUScW
   JcxUcwo9YJshjQa3Fsf1q1IZx9mUVHvZ1NPQ5EeZRJkyppf/kLzRauNvH
   IodiQAXDk8HPPMnHMun+qnrqVaBwsCyIDRLA4OR3cpLtzi9x2lD/CPUiA
   YmB/9UIOZMOjOQfeAxqnG+N+Gyflir7R1oifAg5zbYLM7eiIlF0zTleeG
   /ZnGFjMInR1TCE34UEsGV5lNW/hQKPgi8bpAHKRa1Z4/svb5/03krwi2U
   v321dI6Xi9RWWVPYrtm7RF40Ev+XB8GObIDllbEX3kY/J7XEahgjK1Xvc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373032903"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373032903"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 22:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="635931927"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="635931927"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2022 22:59:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 30 Oct 2022 22:59:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 30 Oct 2022 22:59:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 30 Oct 2022 22:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuUD0BQGmU4dLu37N+pRQCOv2UAEDO96zg4d64ZtO/Tjh1SRJ7l7FuLMNNIslFBQ6c2Cyc4c2vVXmKtuRl/rUpBs0CJEU1LE25N1MlJfDiCmEKMpjj918w/FeXTrpTqHC9F0B/Kqm6ZSuk9rOiH+TBlHWIj3kKJdm6BxQmQgj5G4vzATU3yJrnAgigJydOFYgmdd0KdAKeOaGP3P7ytxgH93UCICYxssdeyrlUyux02aegeRHFFmQr2gs5RDf6iRqgWhpHY4MSedfhADOKWZH6CIfTFzcZZ9f5Lv+bz/F6KbBbHvjB7AGOuDNpAEvFdbAG6ID7rxhDWz92zl85dHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzUZyBOFZ7y/v1UM+qCNxkP1OeHUDw+882o9dL9AEc8=;
 b=VFO6N4v2G5YkKWXaYWapYOC3RBs9u3707CXv9uLLPMjJHMqRXZ6e84Ewrnq0yQaDKrdMpc/5KfKgjdlh4Y7RzWLyqqoJ1wCviSlKjaa047xG5LlOlmkGJkE6Y29HioSdjp+FlxZ1KG4lgspAk7TD5OSoX24vTMgsBzupPKBSabSRXO+fMvWDwA62owmLxHBpoYOpVUI+h2UZRYUiDxiAFYVPM0znQzpW6VczWwldZH83gZAKYNqKj/FQH+hUSbSO7zktFQdBQxRunCrpN9JLEoM4GJvKX0sFBNH1yOOkainiqMTWrgBLMeAPbxAO739PoyytlbVOVfQae7ftwat6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 05:59:44 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Mon, 31 Oct 2022
 05:59:44 +0000
Date:   Mon, 31 Oct 2022 13:59:38 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <clm@meta.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <longman@redhat.com>
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <Y19kStu4zBFyvKPK@feng-clx>
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
 <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM6PR11MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a1079a-9146-42fe-dba9-08dabb051bb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeSMJ7ly3cuR/quVPW5tU5CdAHzKTnvlOhXJ7klfEFdK7kdoX71UUDkYdDxxfck4sgb55gijDtzDXUvjf0hpIK2ZjfEWGZqiR/6q2LSTAAak0QHTZ25NypHVAlH2IdpWB1Gp8OEAwHBH3WVk5gMmQTkKbL0eWfw3tC5Ab3aB2Wa4vTs3abLhyYPNJSciG1OvDZUCo27rm8XX3rM6zaV418vkaFqSNlxS1LWsEapfh0uyJD14phXW83tFv4UiMD17wvrASz9bpb+9Tiz6jngUjybIvKYyNBVFou5uBbGVJUFpnPmhJUx0Rw8A4Th8a/YYPN3LatT+fChBdmx5AFgve2QvEHSCQukuRBqb4Z3VvWLZujr3B+PXHG10FvpD8CFKGrvW+N30ZrnyBvl0NimMR177Y8+DWAXVbsCN2SAE4lvcvAdbYmLN5gNptfYZ/krhpiJDabPzyLJASuIopxod70thepCWZoK54T2c1l+clwvyWX0WeyU2rfevSPQ6f2Z289W8SOaA+TFYJjrJN65EPejAcH0KM5DriJm26S4CQkGtSSBkYZW02BPjuLfrUxR+nHbv2eTFRNTeNXm0a1rxZUh41WLuxco2aZYbuXdDYdKAEk238Tqk56280z978U8n+qDqMjVGYUxdrsgu+loqB0lADbnMoLb6unF39lIB/pG0s2Bx69hG0Svq8x6BuIXCJUIXlnlPNfiClel/p3ypkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(83380400001)(33716001)(6666004)(6486002)(2906002)(44832011)(86362001)(82960400001)(38100700002)(9686003)(6512007)(26005)(186003)(66476007)(316002)(66556008)(8676002)(66946007)(478600001)(4326008)(41300700001)(8936002)(6916009)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IQelcvpkxvw67u7yn0s/8EVX/XSWdya1jsMU8oLj3zNHjVWTKRr+eAXNgck?=
 =?us-ascii?Q?n4W3q5qRugp0ZOYbOJ6JvWMKa18XBWVxOCuNU9HtuFpBgWGC3gMGlBIwhG8F?=
 =?us-ascii?Q?FojMocSZoIDBJzBKMJyjROYfXwBjHOr+N34GapxcYkKQXFc8R9L5n1DJpGJA?=
 =?us-ascii?Q?8LaXdZR9BmIYgfmqpqwlof9z5iqJNmpMODPNSiM8wkKz+ACB+djUEShje3J+?=
 =?us-ascii?Q?koFMRLj3/RzPk/wu10ozNUZ+ci1K//5DcSyBSeL43xJ/DPajPkaZZmXdfqoO?=
 =?us-ascii?Q?7rcOhWA00KYBsjxjzvEM9v5hS3SvKEY/auYmeIfO3nqKK962fLpEIq2pb22a?=
 =?us-ascii?Q?IE8xtEjubEFVyMcVb9ZiCXH+NYWboYsvLGQvCweNTIIaaO27NUWXFKnGlqMs?=
 =?us-ascii?Q?MhAft+VKn+GE9kMA4Sv2Xt0PmudHwcC9bbMIJzvlmYF6nhq2+9KaEljiKKcF?=
 =?us-ascii?Q?Gh/RVLlq3qLLww+yW65D4o2bkdSYhstWFItJ2CkymUha15scV00Vb3DLziuL?=
 =?us-ascii?Q?ehwzxjodXknTufZa6UWR8OaYMN33Kue/yWmAFzm8yOFstcxBQWVMJjJHPxNy?=
 =?us-ascii?Q?UNOV6vL2T5QjHZgD7St7QizrA5Sla7AAuiIyuUemIkMJ4roplREsCWl3vDb4?=
 =?us-ascii?Q?tRIAQQMq17ULIBxIYrAOLtojp6IULtqxEAgt2OQC8QSqo9vElwzzRmx8tkfK?=
 =?us-ascii?Q?6w/jxIa5r2NfeuAmj900eBlBegz5tATd6gZF7bi8Xu/WY+EjkrUKX1jM49u5?=
 =?us-ascii?Q?M8REBE/++I2ZWQZXuzyaSPpyrgWz3BFUJ/n3Pa+NlnvZOMXpjjqFxB/ZCPLP?=
 =?us-ascii?Q?yeoInyKBrZ7Ko8RFb63TfsD/vUfXfLtgAoYx4YYfTUyeN1mEuCNOAC4LwS1Q?=
 =?us-ascii?Q?eJSdIYatg/UsrtkR2tDSJUn9wou7P2gebQfD5L+l1lrYKt/eoRn4x8NPCSLx?=
 =?us-ascii?Q?B3n6KxbhS9n0u1I+0wpCDcflvjm8fKrFiWy5tFTJNR9wALdEKO1YrPMHHale?=
 =?us-ascii?Q?dVTKOrMbsLkY8suBeS3O2f+VyMkNltynta5EgoSk4VklpOodHUw4IZ2prC7Q?=
 =?us-ascii?Q?7YwFZF6uyYVZ0CybrlTkSDoWHbkv9CkD3Vbqe61icWXOFcI0YhpITSMSiQ46?=
 =?us-ascii?Q?5QIM6Yjxm3cpalNm6605GUtpW9ZMfiI2uyPr1IR7I6sa5pW+FC5TNx2e69eA?=
 =?us-ascii?Q?Nym1VVW/lyO0afKbYMFk4sb59MzrXvRK3ziaK1NgLXTDmlYd8YzDLqSBVJ88?=
 =?us-ascii?Q?fz/8u+GF5xAeG59BzaBNZjl9HDDmE2Al+Y0R9gQ20xzxH66MVzoNl2TAIX/o?=
 =?us-ascii?Q?5vplCDWRAq51uHWaRLXG/YtDcgrofzvS4mwKErtaY81p+d/kbW3n8AM4s7aS?=
 =?us-ascii?Q?l8mPJrdRUUSjuTVgBkvGuoU2/YKbDWZT7Y/89vh/EQykg53youfQKse4200O?=
 =?us-ascii?Q?+TI3k88Pla4ml/w+JaheRN6DrPPr2hmgownFb7sO/mgwsqrvoPwGjUdu9GOz?=
 =?us-ascii?Q?EyM/JjyPc3JmkEYC9l+/ZKdX+nfHdHm23J16+c9pi4z0tR20PR5mtjB9wPun?=
 =?us-ascii?Q?2twGtHm6eXbek7vgMP7O9+MJI6SfpntI6y0n+KZx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a1079a-9146-42fe-dba9-08dabb051bb1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 05:59:44.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KewikJf4z5KZcSx0QuxyQg9Tk/NdDGcCT09EzK/95sH0DpaKNV/h0dvPT1ZAD0jCz786+20mcmi7+xphEZx6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:52:45AM -0700, Paul E. McKenney wrote:
[...]
> > > Left to myself, I would use a capped power-of-two backoff that was reset
> > > any time that the interval was within bounds.  Maybe a cap of 10 minutes?
> > 
> > Yep, that's more informative. Thanks!
> 
> And here is the resulting patch.  Thoughts?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit adc0512cf34fe7f0d73966d59644b826ee526742
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Oct 28 10:38:58 2022 -0700
> 
>     clocksource: Exponential backoff for load-induced bogus watchdog reads
>     
>     The clocksource watchdog will reject measurements that are excessively
>     delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
>     watchdog interval.  On an extremely busy system, this can result in a
>     console message being printed every two seconds.  This is excessively
>     noisy for a non-error condition.
>     
>     Therefore, apply exponential backoff to these messages.  This exponential
>     backoff is capped at 1024 times the watchdog interval, which comes to
>     not quite one message per ten minutes.
>     
>     Please note that the bogus watchdog reads that occur when the watchdog
>     interval is less than 0.125 seconds are still printed unconditionally
>     because these likely correspond to a serious error condition in the
>     timer code or hardware.
>     
>     Reported-by: Waiman Long <longman@redhat.com>
>     Reported-by: Feng Tang <feng.tang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: John Stultz <jstultz@google.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Stephen Boyd <sboyd@kernel.org>
>     Cc: Feng Tang <feng.tang@intel.com>
>     Cc: Waiman Long <longman@redhat.com>
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b173271..daac05aedf56a 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -125,6 +125,10 @@ struct clocksource {
>  	struct list_head	wd_list;
>  	u64			cs_last;
>  	u64			wd_last;
> +	u64			wd_last_bogus;
> +	int			wd_bogus_shift;
> +	unsigned long		wd_bogus_count;
> +	unsigned long		wd_bogus_count_last;
>  #endif
>  	struct module		*owner;
>  };
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 3f5317faf891f..6537ffa02e445 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			continue;
>  		}
>  		if (wd_nsec > (wdi << 2)) {

Just recalled one thing, that it may be better to check 'cs_nsec' 
instead of 'wd_nsec', as some watchdog may have small wrap-around
value. IIRC, HPET's counter is 32 bits long and wraps at about
300 seconds, and PMTIMER's counter is 24 bits which wraps at about
3 ~ 4 seconds. So when a long stall of the watchdog timer happens,
the watchdog's value could 'overflow' many times.

And usually the 'current' closcksource has longer wrap time than
the watchdog.


> -			/* This can happen on busy systems, which can delay the watchdog. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			bool needwarn = false;
> +			u64 wd_lb;
> +
> +			cs->wd_bogus_count++;
> +			if (!cs->wd_bogus_shift) {
> +				needwarn = true;
> +			} else {
> +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> +					needwarn = true;

I'm not sure if we need to check the last_bogus counter, or just
the current interval 'cs_nsec' is what we care, and some code
like this ?

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index daac05aedf56..3910dbb9b960 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -125,7 +125,6 @@ struct clocksource {
 	struct list_head	wd_list;
 	u64			cs_last;
 	u64			wd_last;
-	u64			wd_last_bogus;
 	int			wd_bogus_shift;
 	unsigned long		wd_bogus_count;
 	unsigned long		wd_bogus_count_last;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 6537ffa02e44..8e6d498b1492 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -442,28 +442,18 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check for bogus measurements. */
 		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
-		if (wd_nsec < (wdi >> 2)) {
+		if (cs_nsec < (wdi >> 2)) {
 			/* This usually indicates broken timer code or hardware. */
-			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+			pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), cs->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
-		if (wd_nsec > (wdi << 2)) {
-			bool needwarn = false;
-			u64 wd_lb;
-
+		if (cs_nsec > (wdi << 2)) {
 			cs->wd_bogus_count++;
-			if (!cs->wd_bogus_shift) {
-				needwarn = true;
-			} else {
-				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
-				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
-				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
-					needwarn = true;
-			}
-			if (needwarn) {
+			if (!cs->wd_bogus_shift ||
+			    (1 << cs->wd_bogus_shift) * wdi <= cs_nsec) {
 				/* This can happen on busy systems, which can delay the watchdog. */
-				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
-				cs->wd_last_bogus = wdnow;
+				pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), cs->name, cs_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
+
 				if (cs->wd_bogus_shift < 10)
 					cs->wd_bogus_shift++;
 				cs->wd_bogus_count_last = cs->wd_bogus_count;

Thanks,
Feng


> +			}
> +			if (needwarn) {
> +				/* This can happen on busy systems, which can delay the watchdog. */
> +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> +				cs->wd_last_bogus = wdnow;
> +				if (cs->wd_bogus_shift < 10)
> +					cs->wd_bogus_shift++;
> +				cs->wd_bogus_count_last = cs->wd_bogus_count;
> +			}
>  			continue;
>  		}
>  
