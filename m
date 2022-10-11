Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7575FB44F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:12:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33CD56031
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665497524; x=1697033524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wHvZJzHjNi9hVlciw1kFmhJtPDm534jzttxtYYBvNk4=;
  b=UOtyS99gZ4Hko/T2bLfDwA1mPciLrOKBJ8nvBlVNepll9wsMDdg7wrpF
   kmwJbEym6PFAYdVHGqZKFXtafcph5wlTh5TiHfaGBxS5/J8q4RE214xKG
   EaIGrRSiSZs/tesLJxhVdKKMM3pZFFVB0jC2gt6yxu0AscjMTkw30L2Wp
   KkFvZPE8lFxUTm8WitryuQgpks5hRndk9zMkUrFkQXzbl3aTcNnmJUx7J
   UL41K2FcLfeuiD6Y2gNXvokWkQ+bMcbGEfSW3ttwNl8da/1ne8deLgXSc
   zq5I+09mx3nBPAZLplkF39VoaX6fjsXeN1R6NSCV401zyvs6mCbxM7m8Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="366504239"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="366504239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 07:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659546582"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="659546582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2022 07:12:03 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 07:12:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 07:12:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 07:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVeKfoOCfNkId1xCcdZM1UZbQCGYW7T5waliBU6Gw65IgbLtgGn67/R1r2uIBndde9/wfkpWCzEvt07aoHQ20WyUf0Vk62TJE/WWo41HwjGr7dohURhtis6BlLflF2eTJ+L3rSU5mYZBs2nAjCh7DnjermYvThQ4D5nFVBXtKszZjOyPPHiRpAZshqJBqiCMkpHO1BvQDxhLXZ+ZZkT37AUSEzz6I4ls0GJckALHEmcHvpga00D/TaJuxV9sMMS0nt0xZ8EKEkGvauC4l99adD1PZTqfBgRRxuJlHVYaASzn4AT4CohlO5NjBbzJh0FNzk6mKDTDP3Z6pfLWTta08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgcOVqVMJEDsByTbv+Yk8Ly8zBOJ3VKtjQV95H8qyUo=;
 b=RVAmd21Fhk5OHDo0NOWQuViLD1VgWR0n9Uk+V4TAM4ZSpqU1jGMe5lF8fmjYYn0kJ2eXJfkXXEnM8AS2pPo8PzxBazUh5gF5uZUHcxbhNbCUKBD0Sd0GdwEmUeaRK5xycxzsSiNhMzefwrUx0wvjkfVP2bptP5Vjh5Vd8Iy0rnXkWx+JSG2GMdMMfys1eMJMinxHfOi/5dp/Taw/6ra1KubL2tu3cVzrCFNodx0nyVS+zq+Rx6FI5QlBiuyc57gfIfXmO8zSbY6N71HShcRWH/IGU9Nyz22zq3kV6bNjhNfcbMonNlFzucncBfFbNTMcJexlquWN6yISQWJtsQN/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:12:00 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 14:12:00 +0000
Date:   Tue, 11 Oct 2022 22:11:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0V5n9yZ+gfp2lSh@feng-clx>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
 <Y0Ugs/udnBh0Hv3C@hirez.programming.kicks-ass.net>
 <aa5c745686127c5d1ff2496fcecc3ebf0839443c.camel@intel.com>
 <Y0V3Snlqvz2+1UUQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0V3Snlqvz2+1UUQ@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6d3c98-d6ac-4377-51e5-08daab92903d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+r/l59G2+HhqKcTDaMt17Qq6VQQnxCFC47dtvqwOc04Cfty0C8q7PDISNQ+/xNR7MVjjDVcU+o7R0rCKDC8bNbE5vQCbNafgPcoTFGa7hW5YxhPXLrRVl53sDpJckP1KigGrtyA/mUPfvsV5P6wB/q6aEUsqwpMJukYvxVLD9RhB2qyaC+QwSxUrDAlXBUNQbWqZcfBgsmaZvTDYCF02ja5h7BVecdiOD3KbHJvNvfMVU9BhxxZjoUMQUnRvLKKEkjrCHL9LCQAFvcGaU4HmL7g9/STgaf4lhiIoB09HWlNr2i5ijHHssVCPg24tC98+c9sfdtIjVIQI172rEU34cT0CpIRdS1fHBJkahGk/OnnplZE8hWThu87Y19dgpTLW36IY9Qc5EpaVWg0rtH5/ReWdK7YShJ13RoOiOVkosdQe6jcF8VrP6N9jV4aMA/gtsWst4oZ5tiNux2VyJzfzlB8aff8eG+LCMVV8lz4mhv4Fv8zMUbKXRC+t4yWSquWm0TJH/jWBexUExseQfb+jxBbe29aygzh3xosHpsNRghvsn1IVRxCBdQ0kdptptNlKNi1nwgRxQ+1QkdPLzmW1o4r6LnVwGxvdkPPH2GWjnMj6WPH/yfMBksM6LzYSjWm4UnQKdlKpxqvvYaS0oki3oAJOdKrStDDvkL8e4tlpsEwIAN9B6W9+iRT8OocVo0QoYKSG0uwnAMpZQK8xMwYo0v7UvMklIi4pF//T9jODUV/pAECFxwdOu9i79patx4QY+ndA/vMCpXRgyQLTwpIJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(478600001)(54906003)(6916009)(6486002)(316002)(5660300002)(66556008)(41300700001)(6506007)(66476007)(66946007)(8676002)(4326008)(8936002)(26005)(44832011)(4744005)(186003)(6666004)(2906002)(83380400001)(33716001)(9686003)(86362001)(6512007)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?57POeR2S5yhsNTSpG4d2hSOqoKDxRGaGEZHy4KxEW23VkAua63uLr4SEeJoC?=
 =?us-ascii?Q?npxjoWJjO2sDDL9xwgxi4x2rJnqvDkMf8A1FzO3Y16nO3i/XVl8m+/2ogbO/?=
 =?us-ascii?Q?ZgrgOMsmCXITLE/iTGLAJVHYMrlLZslLyeBG5yBne1daX6k1wTak0b7/GJ0V?=
 =?us-ascii?Q?ZpFoP0yFwFU4rmknTzq49DmG2iDVvTw2nPUsAylVD6pWP9MxmIWrG8E0R0mc?=
 =?us-ascii?Q?HXIdTKqv/i9iwv/LjROcbewCRsDQ4TKYFQlnpD/r4uLeqnvM+hsBwuuBze+u?=
 =?us-ascii?Q?JPaFOjBc+ywGjX8xOX2yoxFuc4FhL0muWYspNztrfZc5ax3/sK726wJZ8wMM?=
 =?us-ascii?Q?MKDmxfFoUHYSGqLNgVyFifYkMD/Nf7BwryYPoCiRbiE7IfBzoqU5p0gmnrKJ?=
 =?us-ascii?Q?imbFVEpdwFTcF3MoA+YdgmzEGp0vTE3/76XQviS5V8TkaIxgDxTs6EBioCM1?=
 =?us-ascii?Q?7ElaKaPMpdRYA932t70S/xauJSJ36CqJDNGjXYYcApqfIKQHGITCfY4gmWbP?=
 =?us-ascii?Q?3h/sS6PJSQ4CTJxEjd7q+b39X7KaQHsjalQvxCjFmYhmGHoY9M2NhqYjwhdm?=
 =?us-ascii?Q?6kzXCUbKkgk7Bj3NkeskJ83wfZZujxlcTcK3dm2wWWuL25c8SpB9I70QBNTH?=
 =?us-ascii?Q?ItWG+hDPLEHQw40Jdms9ZwnRGzI6XTNe6vJTUCnfoGSlgD+fBSvGh7clzzZw?=
 =?us-ascii?Q?BX5qyJLxldBmfennF9sCpR9F2ixWzusFWRCVqGrHTiKc2dVB4RkERkRXbalH?=
 =?us-ascii?Q?02QMw/dCKnJB7tsinbd/sdoTsX78WDgF2Rpkbbd4P8DlfN6EZCxMoyFg5jho?=
 =?us-ascii?Q?dhWLfHerHPzHHGSqKEAblnirguGk4kTEqxS3RaOuPcbyQ98ymV+NPtowCW/s?=
 =?us-ascii?Q?fPKdfEMnBUXpGv0gQxDR/c7WJv3+C1VcikkUQGXxVOZVcTmcVEvXDiajgTEa?=
 =?us-ascii?Q?9tJAQUjJxuwMWlbQTc5Jhbi87TJQ+iU0PNugl8+V9Ro12QZmplcjkBRIWRXk?=
 =?us-ascii?Q?mVdTNWhmivR05F7pO/svPeF9QC39eF26P52Hk5RjHACogS48vUsubiJGB9ww?=
 =?us-ascii?Q?JwGwWsVd6ILp1c5yJkWVW7Xo0BWxfiE0WeZHqZ+qkSS01+KqzeqlMylbgn5U?=
 =?us-ascii?Q?FTIbIG+bmwOlJNr+c56/NRYe6qq54/z7iBJVXlcOW8prs7EfeKnxlXsnsSk7?=
 =?us-ascii?Q?IYcl64Cuio4ktDoKTOhXJvmgUIYXBKYxaz0mNy9AXzWkYK9vaRSzUAFMcCfS?=
 =?us-ascii?Q?KLfB+MMTbAUeUSrv0RDcIvaK2TguhwFiVCQbT3oNISjSKMFf0gkhB8QAD484?=
 =?us-ascii?Q?SyRn4EWLSibxMqbKbRDHCuMooOwmsqe+7Gze8iVIygALVRcxXMfsaoM89FHg?=
 =?us-ascii?Q?kInJRv0Eg2qrfxEE+H5I+SN88lQa3+abFLUIoXsipMAoEsAPcIOMJUU833SX?=
 =?us-ascii?Q?GzHYSWdl0tn+B2moqzS6UJhrtGLSC26PIdwCuuBmzSeofIkdGyjW92lWQZqh?=
 =?us-ascii?Q?/3a4fmhqjrG7hVxUshJXEdgxjLVoghw/e1zRSh6Up7F6DjozaWvNNhkybX6I?=
 =?us-ascii?Q?rQ6afZM9vRM6QZMVZC/hdfxjl2Z/3YD8zF7TxNug?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6d3c98-d6ac-4377-51e5-08daab92903d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:12:00.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9V/1fCuQHpBD35yHyLtGrKE+DpgPC3dxwTtpg8GjPwOX142QirPvBaC3SgdprSWhMqsSlUQuMsplkUiXoJ48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:01:46PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 11, 2022 at 09:33:26PM +0800, Zhang Rui wrote:
> 
> > topology_max_packages() or variable logical_packages can tell the
> > maximum packages.
> > But this check_system_tsc_reliable() is done in early boot phase where
> > we have boot cpu only. And the cpu topology is not built up at this
> > stage.
> 
> Is there a problem with disabling the TSC watchdog later in boot --
> after SMP bringup for example?
 
Currently the watchdog is disabled inside tsc_init(), right before
'tsc-early' clocksrouce is registered, otherwise it starts to be
monitored by 'jiffies' as watchdog. And there has been many cases
that 'jiffies' watchdog misjudged tsc as 'unstable' in early boot
phase, including recent Yu Liao's report on a 4 socket Skylake
server.

Thanks,
Feng



