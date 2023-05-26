Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FF7120E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbjEZH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbjEZH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:27:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A034114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685086024; x=1716622024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mefbBu3n2P0AZrnPRxRrOic5anAAzP2yUb7SuTvmd9I=;
  b=mOH8VnaUMp4sv+lvFJoAAKOG5gZq7S+4PMh8u1E0mZBOQEZ9UIt+WU9I
   7zAZQ21va0FraQFVbYSXW5tWMVE+HEZpQcONYCaGcprV6bxLmSuuDPB2z
   WuBBzOpBVayIGE3oM8j+qloGPp3/FPs6PgdpNvJriK539hs/to6qwWovZ
   I+2uGuiKjiuEU4ioFQuhmh0p7iWq1ve3P+0MMaXdV+faJdMR46xNXuDDD
   V/mNQ4ZksqFPdDoExR7M5QfGioPpO1T/ULqG1G3D+bt9iYCaa7XQPWf6H
   W/Cv/ELFq46l0IOSpjDV+9L6BMTd55f9xaG2ZNNOjsB51IIteRZSioczA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352982713"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="352982713"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 00:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951785190"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="951785190"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 26 May 2023 00:27:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 00:27:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 00:27:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 00:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy9BT6emVaQYUP/9ZKefvWZURjEd06HunDwuaHbOWGtzpMZdTW2REDcVzE18yKHMKp1J1g3OxmgkUMpKbNyzOjXk6t1ClUcTVgBlRyqH8y28zpEd5hYVfXVZzjtCnNHdu1WrH1i0eX7CNGV5FPIhyOH0x6CrJcmQc4SoLy1tRiyI8fy5B8EZRBuOOO1D6jQnYrduuJeFEM/WECLnzrIxy+k7944KTSKv6HpQ4o8RNKxUTmZa/RwgZltp4yMMNRAh/ds3bexw4jTrkPKqNP4OWgGT+Q/+xezWVfV+sKNDlLgfZDXvbDpZZHx5yYBYkwcYOWMndwqo6Z+K868hWilv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1grlwYyJbOlppQWR6yW1aGlwHxNv+RJVgx/T0XlLG6g=;
 b=UfGM4bAnIcEeqFzAVoJlcucwsFHXZQ8sgi/vLSwP4X+colDf2sfPVWd+F69nzfWEhysKDYZmM+HnWni0To3RwU3+3q45xMv5dU/Hn4efk8VhB1yyJ3JvzaXpB5DJxc9Df3+s0NrxsWcf0iJ/x4xiYBmcGfLwfn9oRUeGQv5TMmasy3Pkt50is47cUkVJkQFkt/oqeqIbZimVCxCmj4RTH80fhlhP0YTOZbNr25i5Y44exwm1C1rK1vT2XTnqwgW7+cEy3ywfBPkFD9LX+GJR60FbBPucZFWmj+PjJU0WXDTi4GofOq9qaH6oPCLLw1FjYk7TZWxXU7Lvw2wfWjUYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 07:27:01 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 07:27:01 +0000
Date:   Fri, 26 May 2023 15:23:47 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [paulmck-rcu:rcu/next 19/19] kernel/rcu/rcuscale.c:340:20:
 error: use of undeclared identifier 'get_rcu_tasks_trace_gp_kthread'; did
 you mean 'show_rcu_tasks_trace_gp_kthread'?
Message-ID: <ZHBeg7SyMQnWJ5Gd@yujie-X299>
References: <202305190259.Rm6JC6Nz-lkp@intel.com>
 <e51237d6-5b10-424d-a0d3-afe8ee24f530@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e51237d6-5b10-424d-a0d3-afe8ee24f530@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e3ed69-296c-4646-6150-08db5dba9861
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pPCif+Fbv2py/gKnZJ9IZsaVNTgGIBcOia4I4h5KKJcCJT9/OghG9fmHgv3M48p2IC0Kgn2zbKo9emTPTuWh/WvKG6Yir2i+L6MN53m3Zfxikfwukdi/mIBMmBXCMsb3YC80UeEo5YaO8ZRYSmE3sNNYvL0LteRDymqAX9DoHV5e3stP7owoaRLM4ml/CsKVVIXLHRa8bmDukq42MWLD7b+6V3coslfAj3IEjLeCzUK+x39zC0CuKbxvHzsKj1bs3gXol7JrXidprS7H485qdfiQLb+yLxReMXqvQRHCvPdhQ50xxZARg9b8ae97sQV5pEOPQnrs1ZPDVe/fs12a5+Xhhb67FDB4uUoLeEw3z0uSD6Gq3sXOlt7BMZkLP46DIjAv8DqHi5Sz9mZejBQg+Ws5GA4vFMSZK5/lPdOnsEA2kgXz1WA/mAQUjPb0Hc7sjS6puF9soM79GWAbQ6J0NpLSpdp+NG28+smynG4PfQnqMsKHwrxdAtFkqtRKv5KTAd2W7Ozh1pRlhgDk8dj+zRBKRlNLwg79/Toc3TkcM8/jg0+RYw/3go3/besOqUwBQLjf7fT9+aKd0n/PqewzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(4326008)(66946007)(66556008)(66476007)(316002)(6916009)(6666004)(478600001)(6486002)(966005)(41300700001)(5660300002)(186003)(26005)(8676002)(8936002)(44832011)(9686003)(6512007)(6506007)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRsRuWN2kVDYqRlC70AosDt+tQg+h7MRuChU7AzCmWsH3swmNEYUG7YLnY36?=
 =?us-ascii?Q?pl0MKuD3VDSE5X9dFNZwhzd85i1v2s7dPGoryTdPH5Lvec+r3QK/WFSP+0Ss?=
 =?us-ascii?Q?r5a2EZ7+aNrX8EQfslrKp8P2k2IgQ8lR+KBCC6218V1vJk+fUECpyQk9u39Z?=
 =?us-ascii?Q?5yfjg7R/7jYXEWdYF9W/OrwbMVV3wgjNDiucPPeC/i5F7Je6lPZTEt0L/HwS?=
 =?us-ascii?Q?84EMJcJefJmpLw8vACDBoV9kG9GOWZeV0cn7daC+0kgpJVTS784bpFyOJ2vx?=
 =?us-ascii?Q?oWpvSkXNVgcwkF7yVyRwJ0oChpBExjUqsknAglpLkjkbFVFynIM1axHj7ixe?=
 =?us-ascii?Q?Mnj2tsoEfZ5oyOfhEVcqmfl35yt3g4yKH0XUH4hvwxfDHFq80y7UGBGG9NKk?=
 =?us-ascii?Q?nmUx8VFXiG4lATjfDGin5WttVtBXqKm9JrSMB384VE80zwlp5ZKy98Hi8XEk?=
 =?us-ascii?Q?TLBfo+I21/dKBfdvBwmuTruIEHwor3m396UDE1hwgd7cvBYxagvmbEegs8Il?=
 =?us-ascii?Q?buwM33lcyxBCYs4N6Ot3BRB/mN5wjXlMx62aoS96P24Lh7uBsBNBXR67vlAB?=
 =?us-ascii?Q?0W92fwc1cu0CFToRyuvGi3tFgVmpasUp11fPvfJ00+Iq+dDMtqWebEnfQRf7?=
 =?us-ascii?Q?StlLCScwrNPdoHXts7h4/wrZ+oxJ1LGygBZ305jVBlx9gkhhmd3Tl6JXPHrN?=
 =?us-ascii?Q?OqKMjADXDgLZWGqM7G1+kGoLEg06oBdMqQfp1kdVtyWyFEXalqxC7MhYp8wD?=
 =?us-ascii?Q?5iepht+Cosia0paJoEr7VS833bqPRDPXONT1P3YH8N+IKBAXKw16nULZ5VtE?=
 =?us-ascii?Q?LWGBZ/+OQHtj6itmdgyBiON3eVp+2LvupJwAbYUgUH5rPPa4eeuONw9N9iQz?=
 =?us-ascii?Q?IGnW3v1GR8C/mlQAG/TpmGMaRxlcx6UVHLMAWk1lWdmWnFMHkNnKh9uvK9wC?=
 =?us-ascii?Q?H8jWynQrzxZnamTX8NX+92mxjQ0wflrn8dyya+1aAo66q1wtTGcl7HHmpdKv?=
 =?us-ascii?Q?59zU1pHTVZPkWYTtlXFu8IQzQiYcXARJd3YOpzQyq5u0+6lwvOYyWlbDTDII?=
 =?us-ascii?Q?naxLdVlqbeWVHrqynWaeQKTkUVOBbf4NFGuF3sf3ERJp8/nAu1OrP0N7oQTg?=
 =?us-ascii?Q?SI3nvjPoduEmZkdY8YydMfwdH5y8+Pha4D+sugq9BgYpEaPD7SqXncRgIa8P?=
 =?us-ascii?Q?gEPMQgYkx1vX4ASwgPx53HWRnwmvosCsk2WvQSTzdOVC62yhUdO9/gbTlmDe?=
 =?us-ascii?Q?/NZZmFhrSS86Wq8Sje/e1ccwvaIiOuGWe9jFuRV4etndAFbvW5mFrlcvnjcc?=
 =?us-ascii?Q?nyP805/5mj0t1NeLM3g1KcDgzls9D7MPLhIhsPBB+6xBaskNer1IQRwvWPzk?=
 =?us-ascii?Q?idvGwk1WLXDCRBTsPjxKDPrGml3qvwsoUkhkHi+RfcElbvTI2aI8iJ6cRNvp?=
 =?us-ascii?Q?gjdezTpWnzri3LuOMPW6/SByx5Grn2+RqrydxBo1UbmvR5JSHojTFaRCEO00?=
 =?us-ascii?Q?6ldnSlE7Ofmjv5YwcLIaYlIQBcx/qYtBd4LU1QfNPv99tc+pdzaLMkX1OWBO?=
 =?us-ascii?Q?epbEBt7ni9TBEhiOArVyD9unrBCuFjtso7wiiN4H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e3ed69-296c-4646-6150-08db5dba9861
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 07:27:00.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdT+V+hn0zLgzLGghSPU/q2jpBsPqomeYAV5BODpe4iYx2cbD8nvqTrV6UkZs/JESikAQnVhaL36f5u2mV818Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7272
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

Hi Paul,

On Thu, May 18, 2023 at 07:11:33PM -0700, Paul E. McKenney wrote:
> On Fri, May 19, 2023 at 02:30:11AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> > head:   9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7
> > commit: 9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7 [19/19] rcuscale: Measure grace-period kthread CPU time
> > config: x86_64-randconfig-a001
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7
> >         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >         git fetch --no-tags paulmck-rcu rcu/next
> >         git checkout 9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/rcu/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305190259.Rm6JC6Nz-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> kernel/rcu/rcuscale.c:340:20: error: use of undeclared identifier 'get_rcu_tasks_trace_gp_kthread'; did you mean 'show_rcu_tasks_trace_gp_kthread'?
> >            .rso_gp_kthread = get_rcu_tasks_trace_gp_kthread,
> >                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                              show_rcu_tasks_trace_gp_kthread
> >    kernel/rcu/rcu.h:642:20: note: 'show_rcu_tasks_trace_gp_kthread' declared here
> >    static inline void show_rcu_tasks_trace_gp_kthread(void) {}
> >                       ^
> > >> kernel/rcu/rcuscale.c:340:20: error: incompatible function pointer types initializing 'struct task_struct *(*)(void)' with an expression of type 'void (void)' [-Werror,-Wincompatible-function-pointer-types]
> >            .rso_gp_kthread = get_rcu_tasks_trace_gp_kthread,
> >                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    2 errors generated.
> 
> Apologies for the hassle!  Does the diff below help at your end?

Sorry for the late reply. We noticed that rcu/next branch was respined
and the diff below has been applied. We tested the new head commit
60901dadfadc ("rcuscale: Measure grace-period kthread CPU time")
and the build error is gone. Thanks.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> 						Thaxn, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> index 3a5a322939b6..eda493200663 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -87,9 +87,7 @@ static inline void rcu_read_unlock_trace(void)
>  void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
>  void synchronize_rcu_tasks_trace(void);
>  void rcu_barrier_tasks_trace(void);
> -# ifdef CONFIG_RCU_SCALE_TEST
>  struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
> -# endif
>  #else
>  /*
>   * The BPF JIT forms these addresses even when it doesn't call these
> 
