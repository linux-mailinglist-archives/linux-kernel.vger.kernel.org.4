Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661BE645C76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLGOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLGOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:25:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1F205C7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670423120; x=1701959120;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CN/A8hbqe0jgbIkolzVe+1r79N4vH9rqOnHageUIatQ=;
  b=jH4xLic5Ru2xHS0Vqa7G68XHAeahfioOWOoJUjzf4Z5y6MpSIZQ8pf2q
   V27mZ2wvf3ttgOo7xZ+/Mexf4A5imh9B2lt/fVtg6wRPsOmb23VrWrkSq
   mEI88k57DmjM7NFl1Wj8BC2DBXmEQMssXiKpScj+ZWetaOCp79s7xajkt
   jPGygvz1LFKtpZ8nSV8ssYKeYM3pLBV+sP/C7xpnWITthflXS35dmutHl
   KJpK64r4A6FMm/C5sx4ZsfwVYwXQxBIJV+TG+BMncxd9PWK4YQgT5q2gj
   2iT7foY4YJXg5xjJZLuiC/+9cWiDkcR6w0/V0+ApmuIro5XwydB+z1+tv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343934093"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343934093"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="771115666"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="771115666"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2022 06:25:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 06:25:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 06:25:18 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 06:25:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj5IO8lVLsJARb7hLYCs4n6gDRObOY/mmwQXb0djry88zuAcMHbbutnTa6GtjzOJIp1/ELTYXcD1nw/YYLa6LYoE7rV+0zerQWFFZkCKFfVlh+0siUSA2kuDvCs2ICjMshB7wUs1eT82TwVYtS66rPU2MHj7/xoeH1LT4XBSyUCYo1s5v0bnXyHm37gpcc9Jt21URpdTDupAooE9hRrk1E58TarTvhqKxKVpdsO0+Hqa9dIQh6u2RkAfYEmufnhAgsdz9mROFMopEOjIwbp3PVyXUuqT6OPTiBR4ohoKohazqCzB5/t6SuMvGcp63W9eXwCpLtxnVpqeyQg622EbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjOaGbVNBshjY2VRe9Oqyhwh3ZA26evBSLNG8R5LmEU=;
 b=jvfPGNNbHnD9S5D2QcXpN3K2PsO5ONr2xcLSvxPmpQ+0S2rwIf/4otQuW1HblNFM6Kqvxcnaqz7u4C4OOj0LwHPRSHDHqJVp9QkubR1pr5uwrU++7ptCsqSHGyA/gUTETocxfmeYz0aOfQQra1w4izwuZRiufiSuPz257TqAT1suTtjopDcwnHSgTFWbwbeft+QTamfPiWpsIm29j3qvPxHa4fFHP5x9jxGFZFn4NVtpqx4PT8Dcl6atKvLCg1m+wFQLQMhEKJBfki3/KxurbVraW2FnbtmNVB6vXtCp8jI9zYeyOcaYJYoEHpA6RgJiDk8g2rTGCx7PcY/ukF587w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:232::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 14:25:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5880.013; Wed, 7 Dec 2022
 14:25:16 +0000
Date:   Wed, 7 Dec 2022 22:24:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Josh Don <joshdon@google.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Message-ID: <Y5CiN010QAwklahh@chenyu5-mobl1>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
 <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
 <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9744ef01-f0a1-4a3f-48dd-08dad85edc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHXcD8LSCq/zLg6BtbeKu/J48dCHfXlq8NU0ymJBjzDtIRf2cpnGv88bZJ3HRqohuHHy9zNBRK09UjmpcnHt7paigbpr4omCi4UpVNBwMYmFwlmM0UazJxoLWdmPxvMcRPHdFQx/3hWaCtBNlUrQc48axBQ1w0Ct/jc9FMQW5q51IMit0ne7Ib7gZM9A70cJhoSohwpXp0GpcW0rx5LSPBCQUBBf9kdY1ltULtPPA9WP10t8SN/UA8G3ifsH+qQvnJtchncEARiqs1itqnz/RK7yypzMFIXrvZuJZ3N/AArY1qAUcsYS850wJEDQOJxtNhksXQmsnqrb6VDJDxYegzKxmFgcR04BB8tg2uuTyBjf3LK0VgUXEsJMS815Mmx9cLdyXmEZDHNQIVRlF5+TvT3CzWJ+bgj4OanAXR+awjQMJ98RJy9xM5iMf3bHJ9g/9fPknY8XHAOt31RJ6CslZi8vt7/anxrrISo9ic66Rx2lGo1TOurFnTaKx87EOkTA6uxI/ip0MgZDKLoTqYTjvEUE/DOwIDuneHgszLN4KVRahUkrKMLtE0b2SkqmnZhbdtS6fMIiMh73+xG3FsZMFa/DEbK3PFG5ZcRgpiCfKlcse+FGnpU67TRqDXwxPVnq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(33716001)(478600001)(86362001)(6666004)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(316002)(82960400001)(2906002)(8676002)(38100700002)(6916009)(7416002)(41300700001)(54906003)(4744005)(4326008)(6512007)(8936002)(26005)(186003)(83380400001)(5660300002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fr23VSym3WXkyWtk7I8ZhKLFwvLrOttGz0XEYwhn/SpZFQV7PcEh0CQTz9A9?=
 =?us-ascii?Q?ckX8/IcyrK34yB0tIf5wDqZenpF/nyj7Wv3syOR6qmWUlXWESHktFa36QEK6?=
 =?us-ascii?Q?jfpgdfSAyD0hap1JBbd3mHj7wUM3C++hnM7ftp7INJQpMotXjgCAM4+WqP/D?=
 =?us-ascii?Q?uf23eOC88Ub28oR7uVQeLd+UnQXFRXbq/CredakbnQp0nVroYWCC3hjO0yJx?=
 =?us-ascii?Q?XwDWv7d02YXTpQnmGqVD+tWtuw3TRwEHbVxadngALNVoWsDj/ktZ8eYTb7nY?=
 =?us-ascii?Q?WyS85vqSs7W0OnXlV1kt7/XCbGWBWV+OfdnhFOZ/JI5WV2J4lnR0kZMIeA1y?=
 =?us-ascii?Q?7w8HDrDWkGnghS0UcVAw1e+81AyW+z9wJ8NpfGolxoAp21CK04MmcqJCZCLG?=
 =?us-ascii?Q?gvJWGmZRtT0HFfCVd6FqELRMBuw21z2cBtb16pfN5xEshn6eawNF1xDiAXCt?=
 =?us-ascii?Q?nBj0NFwvQPEj71yxSZwr+FEanB5slOy5/c8tH8FtnnCJa67HeTpQpLr6eKX4?=
 =?us-ascii?Q?vSpqOpiRH8PmYUlRnI251aH4XJCdJhvSLOUmk79ad0Xst4hzNnE1zqOCZGFJ?=
 =?us-ascii?Q?cEzOBp5tiNIKGTR5Av1T3i1osI9B5LRJA54L5Ek/6wZGBpADIM7kF2c1dKZA?=
 =?us-ascii?Q?YairzY4zmdXAIOEFx47UIN0jM5qTlKLOuiJ7qsjq0veXcce2AMZxDLWq6GUQ?=
 =?us-ascii?Q?gXOg4D5J0g+M/Kv1nTEKgCqxsnikS/dtfHO9410bdhz+Mq10uq1SMUiMhnHl?=
 =?us-ascii?Q?Hci3+15nKq3ay/EzEtxuQCkMKrvMfkl0znVJWRC4uK21uLH8WZrFnE5G7wbg?=
 =?us-ascii?Q?W8RYxNKx1xJ/FS++HH1xevVvQiw/hEPFz0pC8SU/8EPk7sjFT7KcQs7B4htg?=
 =?us-ascii?Q?YKCn+zRGISUzUOdc+Nu4YKr+5H9vON4bPeIChEeEY7E9uzCvFZWW1mBUjJex?=
 =?us-ascii?Q?mARbVZjUqpUnhijtvd1E3L0PlRGVh18d277sGVRDWy9wmbVl5fJm01SXsymG?=
 =?us-ascii?Q?C0Q7gwp3z4GXX1UIsTW5cY3STJqUshxklHAWVGJqNk/EPslT0oIYCCzK3uZ3?=
 =?us-ascii?Q?PEqXXoSnam7J5uhMEiGCpAnF1VeiCd0o9WkXNpM3BKZie1a4lZHZTwNV2WUe?=
 =?us-ascii?Q?fOww4m6ksaYoZpSNvERm4OfR5EDNZ/1y6oBAWVmPcNyXAV23UM4YX8b2ArGR?=
 =?us-ascii?Q?+FOccimApMyJFDjEgSTFxQW00yi0mlBpCAiHVyQN9u8+GFFM363q8BlEmNQn?=
 =?us-ascii?Q?azSjsd0ojFmi16YhE8zveOb/ZeThWg5vD+JX9fD7M2WVcbRzS1uPMgmaOFjB?=
 =?us-ascii?Q?gHF206IbxyXD92hsIvT5rycrGSaBJfr6Z53cuWYHDHBVegZtYPpGwXL5qzf2?=
 =?us-ascii?Q?n7Ycn6RmvUeDLVja/rbjG737ggyRtlzJkXJ7Q9sSvSSy9t3ED8ym+Q8G5PV5?=
 =?us-ascii?Q?kWg8bYNXNI0o1MkNheJKDRiHoCQIh7LuT6z3Fzxra7qUbIXWJwvIa7CsfG0e?=
 =?us-ascii?Q?L9tNHPS/nve/YW7ZjUGZ1wo7H2TCfo2cdWAMcczjzSeg6fuYzCkKZaYqIGsv?=
 =?us-ascii?Q?a7sYfYoYpmMTB1Plom+KlP4vRzohMfnYWHmGTYDX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9744ef01-f0a1-4a3f-48dd-08dad85edc7e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 14:25:16.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRTV3BdXIHlWQDTDN+P1Kxf198P6MFpYHHOQIvSSxZ9MwvQsxZzhIAXvmHBtDcm7+Wd96NZCR/j3wM+W4+2mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
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

Hi Josh,
On 2022-12-06 at 18:23:47 -0800, Josh Don wrote:
> > We don't want to add more dedicated knobs. So using
> > sysctl_sched_min_granularity as you are doing in this patch looks ok
> 
> If not a knob, then maybe at least a smaller hardcoded value? Several
> milliseconds seems like too long for this optimization; the
> opportunity cost of not doing the idle search likely doesn't make
> sense if the waker is going to be active for several additional
> milliseconds. I would have guessed something on the order of 100us.
> 
> Chen, what is the run duration of tasks in your ping pong example?
OK, I'll measure the duration of all the tests and summarize the data later.

thanks,
Chenyu
