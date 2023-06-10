Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A672A967
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjFJGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 02:34:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAB93AB5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686378873; x=1717914873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0wign5TeJCayfs/0kMRWr9GybTBtqHBp7wvloxp450A=;
  b=kqt+4BuKgygDUfLCOb3UJGmzqRwcB6Qgo0JlmppXsnFvWfcgHgr9n9UF
   Yhc+YvQMoqVrmeNdSV0pYiVhLSuQ3cwa7oedxEQdLEoeUD0WiOGnp/QDi
   avqINOHIoyprbvAJ2n8hP6fL2pl1ukaAaMAIrIEYEzyc2Jzuzv76yRmvB
   MxAG9usEUL5xP/4+U4UAcYI36Mq2ZkkXrkSrgEU/R1hXqhjZnmBpKAkrT
   jVvEuOeW4rqrBPvn5KYE307yUuYgVAf8Ijvn51fBLsyFRo+Hs2krmPlQv
   KGgM4ntdXb8hzmMRIp5f8dzia0ysQiBEOAI9oGK91j/CIBZtH4gSk0iDa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342415156"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="342415156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 23:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800449962"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="800449962"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 23:34:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 23:34:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 23:34:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 23:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQj1tSZljHGlWAmhbMGZ9huhzAwA/i5jMTjkVwz9+VMojvx7gFdENOeYX6pfZIAN6Hnjufi/pXeSn5Cg451Wjtn5zDQnTjS1dddtAmTscx1j57TtBKtgBW8clnNejV46FaCN3z+tMhafjdowANWPh4HLLLEROviRFGDrK/MCqR3g+cwedp7v1viKrIFnlsu5u4w3lUGaRRyjORba+TGmJfFJB5wdXYIvAxd78d64ClYWpEJu1SidgmVwQaOMCBfViNMX2L+TaLKf8h2aoE3xRgLWVhxIh5X/5sOolibrGyDFA2WkYPCm1KIU55XW5S322rBZ4EHPLPdOTHy6PLFZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC4XEIwTgqpl/EN6OZO0Iq5OvynxFJeB9rTKhCzuvtg=;
 b=Pw0s6bt9FLa6gTMMqbRG4DFWxpFDqtKOHMpdSdmgyOgCcaeQpheTZVWRSyx57P1BfGu72R27ebEguwdvmVnwccdyCUZw+xUjAsnJQEpnSgl3l0bNjlxahUZs5JThOISu+lTDjDe/XTwvV2IG0xp0mnMDF+XPbZn9E5F/LRbE82Wyt+zK6fjCKJjNBNLogyPoqOfNmkQjN91Vlc3jftla3iGH4DzoOpeUOEy5/E2h1WZeShzVM//zG8rYXPJiTZM2NhUmrf3y4b2CWeJ28NnH13RSaz0tCrwagQEi3FE0nX3fLen1VG8S0hQ2aLArvly65HfPR5AXTG2E5pd69fyEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 06:34:26 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 06:34:25 +0000
Date:   Sat, 10 Jun 2023 14:34:04 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>,
        <efault@gmx.de>, <tglx@linutronix.de>
Subject: Re: [PATCH 11/15] sched/eevdf: Better handle mixed slice length
Message-ID: <ZIQZXMHvV3FKOquH@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.341527144@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230531124604.341527144@infradead.org>
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c32d65-d21d-4465-a430-08db697cbc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNXJ/yJ6+YRUdH3IPK3xesk9QM0iptX4f9X1hkKvIO7eOGnQgb4ZmPGHVzvVDypKK45SzsAVkScg6hpZz8wLM1I9iW3nloLgCF3xtUET/a8zADvvQjjX8cUVypn/4mU7TPktpLt673LpZ7MO88tw7SpzPOyCbKTEMom7TaijwsG3zhPQxHGuqc8xWfFryPscjjsIoHzomuKCd2cEcGIvx3Q3zGNpTKo5WhLQt6IbcTS49+2A27XyhAnlg2kbVCa0kIruxpXip85xQH9TG7Qew9dC64gomzqK8FC5B++xaigpFI7zB7ulCqt8JQ44uSIKy8KQy9sxTmfWGiu833VNhxia8XGX+nSgJlIgYC+lwoZOVEJWrYXp6eYX4Ecct/ctrbUJfJzSnsOmWQWYYAwZWUizVRGA5vCsN4BNjYCYaUvyrs7La4+YXx8QqKMU7YxwJWy7ZZq3WIWLSMr7LvpgczovjjwzHLKGbKh5ojOyayyWJz11QedeUw+toq364mIK64D49ysZyhDhsbS62e1mAspEiGMiR/gV8ERpw3L/ZQtq+zX996ks1fXP00eFKnxH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(86362001)(478600001)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(6666004)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(7416002)(82960400001)(38100700002)(53546011)(6512007)(6506007)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXODzL4H9vSjNTEff8A+kjh3vhAAPOpobW21m2yaXJgz/5FOPSWUIKGSiGBM?=
 =?us-ascii?Q?kmdrgnB+L3e2Nt07dibpyvG3lWg8ynKrG2uPGl0RmHEfEsukjKjcAz+wPxgH?=
 =?us-ascii?Q?UlZaITrY4C0DnXOtsgKvG/7N8ZjFIAiLuNpfyBjPu5tNmWqgEiMuYyWTAX9z?=
 =?us-ascii?Q?pSIEgOjsX3J54gY+QIcUmfUnuIreQTyTMrr39xlQsSogZVVe/56OpjnJ/3Vd?=
 =?us-ascii?Q?Pk+QODOwTjMTSe/CkuQRDT3VpdbLTLjmLRGpA6EOtUdFjuZE/JMLRlsQwAxf?=
 =?us-ascii?Q?o88/9ltzbcHSMMp7uj2xeb4FryId4WD0n5ZTEB3cRWZKxH5iBIaZP73TPcBe?=
 =?us-ascii?Q?pt5yS3L0/cMWDOI4ZbnmulbhUQf8dW4uYvhX7UNL/VjzERhhHTywXYWvu78V?=
 =?us-ascii?Q?b9Fcl01SxEORPirG9PkxDd+LegnG/ObhPAF5G0Xa8tq4j8btqCTaho9AsQBp?=
 =?us-ascii?Q?9O5YE71y2I8bi6Z7Lvg+MmCoMj/Rkx6zSvqvVDtmZKka/mYHR5s85VLWKvmR?=
 =?us-ascii?Q?gEewH60YGs4wLgQGSt+UnXa8ACmeOj5b0phCmCYgmaBe39TWowKWEC/KKHeN?=
 =?us-ascii?Q?LnutuOxyK6B6Vt/CAWe+zbIDYesL4sGRAF3xPTo+lHz3X1UUPMbgxeoR8ZLr?=
 =?us-ascii?Q?LNaibfykUvsfNhyfu1Qe/r+xSYfFw2kANXaQiLWkKqmSo4VA1AKnf+ReGFxM?=
 =?us-ascii?Q?OehZBrsS6xiG7QEke/ycMZVIH9gmR52uhCBz1uRc9zPmHtNgxuiribWgkcSK?=
 =?us-ascii?Q?wkHN0Ug8mxW3LKO0LklEWyTsSc21okbJp6JlC86Ch2hVFyrnWE2B/wj6sk8D?=
 =?us-ascii?Q?z9pGYiP+3VvSirT3pNrGX+PS4tDbJJ7E/Wof2JPFt2lStRRF7n9BGapAJZNG?=
 =?us-ascii?Q?fSf8/9sdBPFrYeK3W69Rax64kGDdp6nYZ+rwnNpPOM9akwxMw9nB3nZ3iG3e?=
 =?us-ascii?Q?rhigxj8AjdHLilAnbJzkem4YAUufHSsv/ReEEpW3LyFJsj1YBzxJ6/Uznw0R?=
 =?us-ascii?Q?wrHdh0PjivPkq/wrbXCBtbYqk/ujvQenC7zdEhs+k0dMkoTGG3TWR/5Avb93?=
 =?us-ascii?Q?Dz6D++aSR+ZWLCbXHPAhcIwCV2BBCe4Ch0qy9GSrfBb6QKquBxbp+bK41oDi?=
 =?us-ascii?Q?gEiPM8yqI8/+ArF4J2JnGN45DCmGmUBb7kKQXXE0TTcDT+/DKQz4lC/8AqsY?=
 =?us-ascii?Q?sxMHCllmDpVqqVAGjwMjJbTydU5h+jnQd2uAcrRQDuE5+1dCN/oSINiaZQRJ?=
 =?us-ascii?Q?ku8lta3AJrD2xVB0FFN9QlG6/HE4jy6T4ytyKxVX6/vYjuvzKtWHdlyHNB7B?=
 =?us-ascii?Q?g1wvCEM6Oezd0+gf8BLiwmAg2l3JPf02m7p2ZX4r9SP956bkNoZzNhRVHO0A?=
 =?us-ascii?Q?Be4JurMvbZLpoh2Hvh/o7Yr+SHMnuTZ66Aj6qE8/ca9EH1XgpllFz3d/5m/S?=
 =?us-ascii?Q?0L6G65Qt+zA+6DXt6qn1AaT6bh/MacwMNXjMy6xS/XMtjzMschI2VDGwecrz?=
 =?us-ascii?Q?/oEp3KcGPP7s8MCYuHqn7w/OUOAyUMZSlj51MmYvNxFvyVoxaCWUzii/Q7u3?=
 =?us-ascii?Q?jg0iyVEy7wFI7p4qa0+si2LUsnP8MQRA0E/c3xcW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c32d65-d21d-4465-a430-08db697cbc2b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 06:34:25.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loufvZrYIMYR8dxnRwGRU52zy6MJMBvPbisOi96ojJ0nzI6i0tErWhr0BQSEpW5gs7w3eozzeF5rLOc+tsVt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-31 at 13:58:50 +0200, Peter Zijlstra wrote:
> In the case where (due to latency-nice) there are different request
> sizes in the tree, the smaller requests tend to be dominated by the
> larger. Also note how the EEVDF lag limits are based on r_max.
> 
> Therefore; add a heuristic that for the mixed request size case, moves
> smaller requests to placement strategy #2 which ensures they're
> immidiately eligible and and due to their smaller (virtual) deadline
> will cause preemption.
> 
> NOTE: this relies on update_entity_lag() to impose lag limits above
> a single slice.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |   30 ++++++++++++++++++++++++++++++
>  kernel/sched/features.h |    1 +
>  kernel/sched/sched.h    |    1 +
>  3 files changed, 32 insertions(+)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -642,6 +642,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
>  	s64 key = entity_key(cfs_rq, se);
>  
>  	cfs_rq->avg_vruntime += key * weight;
> +	cfs_rq->avg_slice += se->slice * weight;
>  	cfs_rq->avg_load += weight;
>  }
>  
> @@ -652,6 +653,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
>  	s64 key = entity_key(cfs_rq, se);
>  
>  	cfs_rq->avg_vruntime -= key * weight;
> +	cfs_rq->avg_slice -= se->slice * weight;
>  	cfs_rq->avg_load -= weight;
>  }
>  
> @@ -4908,6 +4910,21 @@ static inline void update_misfit_status(
>  
>  #endif /* CONFIG_SMP */
>  
> +static inline bool
> +entity_has_slept(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +	u64 now;
> +
> +	if (!(flags & ENQUEUE_WAKEUP))
> +		return false;
> +
> +	if (flags & ENQUEUE_MIGRATED)
> +		return true;
> +
> +	now = rq_clock_task(rq_of(cfs_rq));
> +	return (s64)(se->exec_start - now) >= se->slice;
> +}
A minor question, should it be now - se->exec_start ?
(se->exec_start - now) is always negetive on local wakeup?

thanks,
Chenyu
