Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42085F01DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiI3Aiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3Ait (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:38:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67A202895
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664498328; x=1696034328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jo4BHkppmIgRf62VERTUs5Uuu46rnDhwOZtMtqtvzj4=;
  b=bqWZ6LPJuje7v6O3RDkdL14MeUJ568r6hC0GrKfhi/Ge+fO8FzegTEBU
   2BkcSkukp4oX8SApoLFJ4NkLfz1RrbPvG6aIg0u6wo63iIJO8P94iQCbd
   1PmhSrvdwyW0lGaj+ev+8jOIxioSsRmBvhMloVY2UyCkGwFQGyhuxpVBh
   EfsVgmr50AWpnufbqOR3N3NKT1P+v7RbgQ7DhuiCY8t0rQiL3zSF9on6I
   x9esOV5AKToD1pGOPzPcBGGZYDY1QAO/rbN+dSVy4zA5JMnSpXjMQEWVs
   M1iqxSbCFGmeL+aDE8P2TzTGyDHwkEK1W0KjTob/Ye8suTY2nClWBtzxH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302979427"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="302979427"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="797776592"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="797776592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2022 17:38:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:38:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 17:38:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 17:38:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWUbBjOmaXkk0p09qeAD2BZjhB0RZ8oE0sbnNoUis4uwSbzh+TxqDWgNazo8CD5UAaK08upm9kiACYG948AfPL/72GaEMgEmFEr5QkPQyCTqPVMQFr0Tcvwq80lCPhOEfjjry1BNzHTWDTKw52PaT7mqLjOrCMbowR1RlENZgxjb3aL2F6o9CAHWXYqZhPVO6+9LktTH//ZJ4ncoUBulhzk2wCCsKA+aw/IUCC6QPzn1qcn+CYVvi477BrNwNUyi8XPedY2F+EHWdmlN+EkpDzAV7GpAZ1mAPw06Rw3zPJOi8SCCvFdcrsubSpgu8WDruENCKIzAzkASAYTjMDm5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ekj0b4Ww9JrYvC/zFW75xY/LONgWF2lXZWSB2lM/v4=;
 b=fzk8KJXjMHgKet4Gj4b9B/1ozjwtvtlKzIyoWZxATatF0kfItPmAu0xHZuwwBzoMBP+sZq56fFTZIBG4BoQrPdANN/IBtTm5ndG9FGr9wGaEm1JaxMVCeO4l3vzq4iRipbMLWNdzUzmT+fva+EYCbSdw5Lx6lYp3/5m1N7H8b84bZd0vyn1iEOI3ofPh1DNoRxJ2/sEQCangw3cfGpuPdWuIl1uX2zJgiNHTfL2xunJLzpxvoR+LvF3RqrNdl0f4UN7g47ujg4geZNXPEPMy3yNnx8kWfXsrcpk+3LaGUelcZ7/tZCRYt+gWMYKRUlN6AiKYJgX2cXtinoJPX8om4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 00:38:43 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%6]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 00:38:43 +0000
Date:   Fri, 30 Sep 2022 08:38:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yu Liao <liaoyu15@huawei.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, <wangxiongfeng2@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <YzY6e0UwDAyU1GrX@feng-clx>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
 <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 8533615a-b603-4fde-fe43-08daa27c2051
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1C9cD02cYJjM1Hr9NwFfPKUMQdGsAuAN7DjZ+Suurql08j9UmsX7iA8unGP6qXToLjyDP7+7A5zsfMXYqnbQ7+udR669j4xWqqGyuBJ75umKQH8S0i9+o3A/Mal/Mpaht36GBEfzEQF3ohxwChuL2nqTmUbWKCWXDhHmz71bpTi4G1CukeMTEE5U6DGai0oYsw5Wq+oNB+tw/3OQdh/hR/bWd9Jnxu7ikeMEVuIxyzDlKWRe1LOkxyVwPcpl9Lt3yMVDPchYpAyzTk91OwHmV7R0bVVUUiOy/Ja3E8wizWgy17pqyAyxOyooI5//MxzroFji4SHmJTAs/6aOqXIKOp0+787VxomRrPrrlSWzKF+U3xAzDJppzradFuOZBmhAILed8vgghMRKMSLhEr/Zew7H0aZlybeAhTg0v8S7OBzPEYuxJl7cCjSUMc2GpLmRTCXw979czO/GjChGJr58FXCutVIi47QRjShbQLv719CszoZ2rXbBbrSaPFT5Kzf6KngAZv47Zk+qBrjrNRXKdKP1kAGFGf+2OXeN+XACf9q8LT20GNdcRm7DX/Rg2Y1a2I3RVpYrZf0N5oau/6SCIR3Z2A3eGVA+Rdr/y30PaTR96h+E6vwqi8hOMYFmKyphIdBcJmP5ZpdI/jJb/kZULNf9QewnvQTVd7HAB9LBeo09bxYJYqqbgLSCQp8rbyZL+Mi9Et8Ktl+ECTHGQq/7bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(82960400001)(86362001)(38100700002)(316002)(83380400001)(6512007)(186003)(6506007)(7416002)(44832011)(2906002)(8936002)(33716001)(53546011)(26005)(478600001)(9686003)(4001150100001)(6666004)(6486002)(6916009)(66476007)(54906003)(4326008)(8676002)(66946007)(66556008)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4vGZTmu9V2JSSuTWUAZb8AUfQDB6Rm7ccXU8lS4XZ1aiefUN1tez91eXZHvV?=
 =?us-ascii?Q?OVHgHEc1YqDqodefRhj0f8oJtlXmLLnEN8AzBg+GPSgcJyKpmKbEzuaq2sx+?=
 =?us-ascii?Q?mn5BZxWY2D47CMUaJN/VcsReTR+GX2c7ItTMiARqcx20danE0J2KgeuDc+Yi?=
 =?us-ascii?Q?vwu3cB9fG+C4ozqUHEEJlGrqHajMBRYF80FwZgqYmZf8jWfdTmM4HAgFevcX?=
 =?us-ascii?Q?P8nHodhOp2sMJOQ5JcmGMBlInH4Jpehq8aUqXT9K3gqSY+qYm6zxSEwfdhKA?=
 =?us-ascii?Q?ml6SmHTsDnp4MQJJymg7+vFVBoUQqecazWHWR4tZNbYc1EaCeL+htZDRnB4I?=
 =?us-ascii?Q?wbYicf0SuQFIaIU9LaSrUPB1u8AZmhlzCbszI5aUjk2FSoS6J2ZXI7UNVToN?=
 =?us-ascii?Q?wl6FP66i841PkEsB4BUruJV8I4taZvrh0lrDm+8zPL0O/cSTDu5ukbO5mqne?=
 =?us-ascii?Q?Qf1JHEPlXXBucy+GPmzwiu93WvNND/SRl7FMxVPDMTCQExuo+Rojj1igituT?=
 =?us-ascii?Q?VVnTUu28qZ+1jOT0TA8Yga/Qk0i+U/vw9fXZr2V/7GfyDTBh8wKQLsc0sV0p?=
 =?us-ascii?Q?UpWK70I4acFb/O2k61iJP5DTeFzVuG1Xqt4RCP6GZWok9v2Y9frE6AH26jn3?=
 =?us-ascii?Q?dHRaLSjJDtsv0cS5VrjWoGkiJwvHc3j+T42J67Az5m/QNx964339W8UcbSUx?=
 =?us-ascii?Q?peOCBdb1Vx7g6CqYI7/bBeXNh8ZfScbeTjrIR58Ad2EGLP5ve7r62ml23wA8?=
 =?us-ascii?Q?gzN5pn4wVO/9FKZvURqpXL8bmosNrH/C744mi1PXWyRjawGyOqFSH3L+4kol?=
 =?us-ascii?Q?SQ5vhc+MmeAmJSefClc5OpehHrYBbOhI1JiWrqucHuWaT9yt2Bwn8qk1j8mS?=
 =?us-ascii?Q?aHmm0jC9WdtYlB/3e8kAqbmUW9EeYO1gBK7VTW6cx40uYzPVBjmd4oH6YJo5?=
 =?us-ascii?Q?v57pfGOiMS1gvBDOF5XurvRiW9TPDtjVqMW3N1yXdwcNgWhI/TZV0aOQonHv?=
 =?us-ascii?Q?svtRMxlqHB5u72t3VYxgfmrAs+JEfCwX85yBd9pjxOy9JuA368360eKvLorq?=
 =?us-ascii?Q?yQbvVx7YJd52Ltupp1tqegSMJFu2FK7IuXW57ivcYafvDP4DiqMwTgaPfLHo?=
 =?us-ascii?Q?WPJ04NIlVimAEv/LHuVtub2lYPeVF/ygcWhzkkqs7/NE/+OE9QZhjp2uF5R8?=
 =?us-ascii?Q?hvSjekNL8x1uobyRJPjoCQQa4m1JJcphkFQiIWtfKbmkRZJ+ZnCUgbTl9skV?=
 =?us-ascii?Q?vBa1PCDfKHAfQY/6SHFuuR/ds5vh2F9j+ErotGOO+oaEdjgbAbI2AjZNM2Qc?=
 =?us-ascii?Q?0REvtkv4trEN8mv+tuiJg3k2P7jhkRlyv52QD04M0hDYMPxqU1ifGSSZk6Pq?=
 =?us-ascii?Q?9fJBgy8+1hwv1rYR6wR9VtBnxnbOTtEhKAJIdgBXgUjvBoCdf9KWmx/lIXzk?=
 =?us-ascii?Q?h2vTvgu3X4WYlFDIeRPRStfRLcGudVzNcZm9lc19HTUwz/+6OxBNtLoBUPHa?=
 =?us-ascii?Q?ojK8UgSJwIsGSqzgQ5bOvT9KntgrW9ERnEW3bNMZkVhneLJAsc9jhhGDWDX7?=
 =?us-ascii?Q?sraNSZgawhGC4Kia+kc6gB7poJvvQImTDENSoHkD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533615a-b603-4fde-fe43-08daa27c2051
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 00:38:42.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EMrZvZ5ldFhhn4ynvx7/xH3kqGGANdvfvUTz71Cx/DadEVgzcPy+fNTLJudQnuBEk00qA2AZKbh1DUcrHo6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:52:28PM +0800, Yu Liao wrote:
> On 2020/12/2 15:28, Zhang Rui wrote:
> > On Mon, 2020-11-30 at 20:21 +0100, Thomas Gleixner wrote:
> >> Feng,
> >>
> >> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
> >>> On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
> >>>> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> >>>> Yes, that can happen. But OTOH, we should start to think about
> >>>> the
> >>>> requirements for using the TSC watchdog.
> > 
> > My original proposal is to disable jiffies and refined-jiffies as the
> > clocksource watchdog, because they are not reliable and it's better to
> > use clocksource that has a hardware counter as watchdog, like the patch
> > below, which I didn't sent out for upstream.
> > 
> >>From cf9ce0ecab8851a3745edcad92e072022af3dbd9 Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Fri, 19 Jun 2020 22:03:23 +0800
> > Subject: [RFC PATCH] time/clocksource: do not use refined-jiffies as watchdog
> > 
> > On IA platforms, if HPET is disabled, either via x86 early-quirks, or
> > via kernel commandline, refined-jiffies will be used as clocksource
> > watchdog in early boot phase, before acpi_pm timer registered.
> > 
> > This is not a problem if jiffies are accurate.
> > But in some cases, for example, when serial console is enabled, it may
> > take several milliseconds to write to the console, with irq disabled,
> > frequently. Thus many ticks may become longer than it should be.
> > 
> > Using refined-jiffies as watchdog in this case breaks the system because
> > a) duration calculated by refined-jiffies watchdog is always consistent
> >    with the watchdog timeout issued using add_timer(), say, around 500ms.
> > b) duration calculated by the running clocksource, usually TSC on IA
> >    platforms, reflects the real time cost, which may be much larger.
> > This results in the running clocksource being disabled erroneously.
> > 
> > This is reproduced on ICL because HPET is disabled in x86 early-quirks,
> > and also reproduced on a KBL and a WHL platform when HPET is disabled
> > via command line.
> > 
> > BTW, commit fd329f276eca
> > ("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping") is
> > another example that refined-jiffies causes the same problem when ticks
> > become slow for some other reason.
> 
> Hi, Zhang Rui, we have met the same problem as you mentioned above. I have
> tested the following modification. It can solve the problem. Do you have plan
> to push it to upstream ?

Hi Liao Yu,

Could you provoide more details? Like, what ARCH is the platform (x86
or others), client or sever, if sever, how many sockets (2S/4S/8S)?

The error kernel log will also be helpful.

Thanks,
Feng

> Thanks,
> Liao Yu
> 
> > 
> > IMO, the right solution is to only use hardware clocksource as watchdog.
> > Then even if ticks are slow, both the running clocksource and the watchdog
> > returns real time cost, and they still match.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  kernel/time/clocksource.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 02441ead3c3b..e7e703858fa6 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -364,6 +364,10 @@ static void clocksource_select_watchdog(bool fallback)
> >  		watchdog = NULL;
> >  
> >  	list_for_each_entry(cs, &clocksource_list, list) {
> > +		/* Do not use refined-jiffies as clocksource watchdog */
> > +		if (cs->rating <= 2)
> > +			continue;
> > +
> >  		/* cs is a clocksource to be watched. */
> >  		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY)
> >  			continue;
> 
