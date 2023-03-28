Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A76CC027
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC1NHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjC1NHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:07:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B91B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680008838; x=1711544838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8dLdBGuKMJ8ba7louAJGLzMIiwMmIehSe0nVH52woaI=;
  b=JcokUpgZA9fVnzUTUTGmXn/qImr6FdCxMtnXPoclqRXEbVVlaj45dU74
   xan0VBIvJh+iAfzMkfHPQiXaso6Pdm34nWu9slBWS1aTUr3LK1TAuRU2f
   syZLlgSeh1SDu9rr5lGROPDid51h72D8558bakQZb439zkXlSE+cBwQ/b
   pIVUXeTiMXtjq35iYHEvIxdLbYPEdrcekDq+e+ArHJyhBhzuxV19S0hhz
   /Skowh7u5lyci7hgULVgijXSIpcULHG42ac/KZu9xWmox52iSJ5cz7mv/
   XvvQDLsB1lS9GRd5h9g8wJETxlEErNYGoRWwLZHfD/CGZjGN8aESuHNUd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405494137"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405494137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773143603"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773143603"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2023 06:07:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 06:07:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 06:07:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 06:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3iie1ZP3qB0tvNfqHjZYBs6+ZM1QJUqFjYuoAsrG6AsUXoQaKQkzFNCYWDSB3PyscTTY7n/6m5cdKCN2asx8svratxudalvoeYS7nACzogslAlksXnVoSMiA0V3VSmVpxot/BwW46MyOQfrL8X5vu2kKtIeQKuooTtvno0TeVgeQu1RA3YGJD3CuFLB/E+LCfuatA3WmCwMahbe4Na46HI808HR+wiosr2hCfU6UeZxjJAiZYNfzodQP3E5EPjpOvBIghLPY0hYzFQsE1SHRVSP8x3aTaSFMbIt3LMIl07VIKMVMDuWtUdN9Z6rhul8ZYDrKZqrgJ67u5ET/Yqk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP7ydYa1VPfajuvFlA2mY43XxvNggmusN+c8Y/AnHnk=;
 b=cp8dhMUP+VUU5tBLHu+RFH2kHJXdrErNe1OrD6K6e6zcH9tCaRxqSqIlDcqX7BbXDlGfLyiioXFE1P8GAwCqmRMYtkZzMtScLlbgZaGTMuiN3x9Uaeee1sAsfQjbWNeth0VVElGlKgOlSJoeFZVbb6QdHNq6FjvP9lRSZrgfAhqq9WMsScIxnOAKWk8YLoZRFCoOSJu9HXMeJgPopZHPSteupm1Vg2IAFyR8Pg4I05MKyMlrGk0vltbVVdnnGfs0gzpHQsM1wVCWx7F9FLHhz4x9hrn6m6bC1nhDf5jTCT0zHNYy8uLb8oGGZvvMl4b/33T6kJJNfoxo0pJnJqPfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 13:07:12 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 13:07:11 +0000
Date:   Tue, 28 Mar 2023 21:07:02 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230328130702.GB6130@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
 <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
 <20230328065809.GB4899@ziqianlu-desk2>
 <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 757cccd5-2b72-44a4-b3c0-08db2f8d5782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyYh62zCno/FQAZTrEsK3tVJ39AL4l+g/CHjXEsbrIICx9SLKn7ieKMKsEIUw+Yg2S9Ryao45e6O1+R0d/+m1qaNWkND5JdLzwdhjLbnlwNPp+Hia7DgBvcbQfNkRtHU29ZMffiJyWKltpPPusEWpdWCP+hkrbcAJy1jnegTLYJ0cZz2zgRVvEeJWIrsU8yIGNo1Tq3FU1Yppaw8LWn2ud24v0aAtFfBG1lxOKUM3M/odDAF+9XYcU1XVsDWuXzUiB1bjZbJ2Js/lKivScx839GChfgEf/oI0xVL7hGByNJuNWfL9WA8Y7hQASkAvuDOXs7g3adTXHNy7bNXTJgSNSQzzRcjjeK+oi2qTo6ii+nNIWBB+2fB1Kt3z6okMJbTnWxgpfqDH0JxCypW0GhBl12WREV2xz2z502EiqxO+ZtPOC7qh8Sm2oRvb0vKQVAkwR4rLZbOtj6EUkt3iIp84unKKEuRzRkgY1DPMhaS3PhDhofpH3TwnpDo6EpPgtPe2fCcXSmzHJlsZptFhqgoGBw4R42ZmlQgugkVC7xqdTXFPfU8GfbXSEBV+pNLMySolFyUrY0Zzw4RKqNRNG9gwVUxUyBykoddEM5GEa1Yyd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(33656002)(316002)(44832011)(66946007)(6512007)(26005)(4326008)(2906002)(6506007)(83380400001)(9686003)(1076003)(478600001)(186003)(8936002)(5660300002)(53546011)(6666004)(82960400001)(966005)(38100700002)(33716001)(6486002)(66476007)(8676002)(86362001)(41300700001)(6916009)(66556008)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oS6dJcSdzJgyfYJPAsFCh0mcZgbiOXJMLLatfv/kKCxBINJ5MK1M8Uj4k0Av?=
 =?us-ascii?Q?86obxY0KNHagn02FwxLKgx+R+iyQyjgUvo3ZnedyvST9mdUQsiWo4H6gzWtU?=
 =?us-ascii?Q?A8yuS+hTSzg6nXMqFUUkWbW9gHGCELjugWRBYztnWghHKgqsd4KKKXVmDjn0?=
 =?us-ascii?Q?VdfBmr82w06HxX9P4L0lZywQRT9+vB+79VV9Z8shDtzFAaF0YTQ9utQObHts?=
 =?us-ascii?Q?lGtjUhAw4p3BnFt1FSZ2AGPCRh6whEVcExLL60BBNHL1ADvrzc6l81Ia/mb3?=
 =?us-ascii?Q?LJxCKeCqmRjZ0IAF17Mh+MtZERLLErdvuAPQZZ4hIw//PK69APZwAPCWwprF?=
 =?us-ascii?Q?AjAgdf6Kpwg4sd2iHl0uGL53pCBo7eiqrYJXS2/hZWu/t9Ft572auEPga0/m?=
 =?us-ascii?Q?E6YoC0XlSN8ewA6kETnfktkjy0fPJAuH/Ktb6CHTqL7KVS+HMyStkseiSVgU?=
 =?us-ascii?Q?2aEO+whQ2XjfFaPDIdvvkxf6Se5e9scTr41PJYWQMyGZptvqUYMFzpqOxHvm?=
 =?us-ascii?Q?0D/rxzp1ss3oSoEqAQDc7+1HTfgm1XlMrVixgqA5FUjVTQpBYEZF3qkGCCSi?=
 =?us-ascii?Q?RT158rLuoxXY9SLM6rY73OqporBedz+g722AMO+gLdWpzV6eVGVnWJK7/n9R?=
 =?us-ascii?Q?ybT9BI9ooEyxea/Jw5rprV0bmdW2uJUKBgaBMLhKIWsGbaJYIVvHLB1B40p5?=
 =?us-ascii?Q?CLxfeLY3I1Jpm+EoFXeFfltdwBhyzRYSF/0L1qlN2m5POVQPSBVNfhNWZH/1?=
 =?us-ascii?Q?MLj7yZ0beE90QgBqvPV0he2MKWIUqrhuCSC+7OvsI9w1gA/UqjHadsO8gegA?=
 =?us-ascii?Q?Sr3ddYgDpFy7GUDbHvnAu0hCYSlxJgBaq8HOGHHIQiFb6J8cMwtAB1goP0Ir?=
 =?us-ascii?Q?UdGdJOSzQLo1v4HZJ9yezcquRKyDFfUAiIli7siSqtwQFD4M58KXOJcNaxjq?=
 =?us-ascii?Q?Ulwoe2L8Tx2UDRM9J09x+Dm3ZhFIJ/a324Rk83eSMq1rB3R6AB6OiHdlqGAz?=
 =?us-ascii?Q?TISf8dsNsy3QzWRXutZTrieaNo8xexVF50iAmiMA2CWlFbwUjvF6cLeezbpV?=
 =?us-ascii?Q?ALozaY9vCfJYt+gjI9sRCU+dlzHl5uWqN7EmNmFvpNhdBVgzwYOjy+8F/xgl?=
 =?us-ascii?Q?VQI+x/NoZapkSwxNQpKfSBIlaTX7xaRemvdhAV8g9vzhfhcBle2ecmHDMra1?=
 =?us-ascii?Q?HoH0x2inTqGCL25M1rkT8oYtiBKvv0UZoW92gSTN45gh0Nkhu6KYGF6L1Q+t?=
 =?us-ascii?Q?dC9z1VLLA3e7+QVcHDTLyzvWbYGIt850cawJN5f8q61vjO/LSKrGbsb1eJS8?=
 =?us-ascii?Q?bFNjfg8JZHnAG4+LW9OSm/18yOFJtc3/O4iK4p1WZihtEEJxrrhudPqABOgR?=
 =?us-ascii?Q?uegzZ3V6RL7Tstb+gynTBO/WXtP1040FUar5E81MVbaqOlX2Ja9JUXKfA4df?=
 =?us-ascii?Q?Hmhx5qaXblNFd9AfwIEXkaUAEot92YTPvl2r4hXU/NgLfFLNjMyWJy9hwcK1?=
 =?us-ascii?Q?poRr2pN1y72Zf/gKrGVAqt73eDlr3JOou//ZsvpspMI6SCVfQa/gH1yUNHE0?=
 =?us-ascii?Q?ieqkvpQPTgdhO6sILiK+6AOCmfRMKk9mSf9uCcX6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 757cccd5-2b72-44a4-b3c0-08db2f8d5782
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:07:11.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muGb1PB4cO2Vtpeo3ZSW5AX3AJTGKPjcQhMR0ATjRYykEeFcFOnwnDkuypkUdhGVBLGLK+K77b+lmNjS698aIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:39:41AM -0400, Mathieu Desnoyers wrote:
> On 2023-03-28 02:58, Aaron Lu wrote:
> > On Mon, Mar 27, 2023 at 03:57:43PM -0400, Mathieu Desnoyers wrote:
> > > I've just resuscitated my per-runqueue concurrency ID cache patch from an older
> > > patchset, and posted it as RFC. So far it passed one round of rseq selftests. Can
> > > you test it in your environment to see if I'm on the right track ?
> > > 
> > > https://lore.kernel.org/lkml/20230327195318.137094-1-mathieu.desnoyers@efficios.com/
> > 
> > There are improvements with this patch.
> > 
> > When running the client side sysbench with nr_thread=56, the lock contention
> > is gone%; with nr_thread=224(=nr_cpu of this machine), the lock contention
> > dropped from 75% to 27%.
> 
> This is a good start!

Yes it is.

> 
> Can you compare this with Peter's approach to modify init/Kconfig, make
> SCHED_MM_CID a bool, and set it =n in the kernel config ?

I did it yesterday and IIRC, when SCHED_MM_CID is disabled then lock
contention is also gone for nr_thread=224.

> 
> I just want to see what baseline we should compare against.

Baseline is, when there is no cid_lock, there is (almost) no lock
contention for this workload :-)

> 
> Another test we would want to try here: there is an arbitrary choice for the
> runqueue cache array size in my own patch:
> 
> kernel/sched/sched.h:
> # define RQ_CID_CACHE_SIZE    8
> 
> Can you try changing this value for 16 or 32 instead and see if it helps?

Yes sure.

Can't promise I can do this tonight but should be able to finish them
tomorrow.

Thanks,
Aaron
