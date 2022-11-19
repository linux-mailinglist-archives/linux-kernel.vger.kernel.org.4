Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42C630ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiKSCwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiKSCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:51:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769C23BF9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668825942; x=1700361942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=so3lE1iToy3Z53L85dNPPGThOWqtgu0ANAVImbYMyP4=;
  b=bEVN5f9GUo79zhAjBhupoBncwTXTcpzmdosnfFPlRh9ESP9AgCFIYhxj
   tJWUK4TjZopE8cY7XC2ioIF9UAx+zpRXvJAOo1ZEO+/BlmXNs6PCsLgqR
   fc8x07OK2ju3mrWyZ4UpT7h8CSpSt+rx2nrgBYhAoEbASvYmK9+k9Flbt
   1rs4IyjMe+3cxPGpGuqAMZGWmOPCtebCsUVSRaF/5OtT+zZE1MH5NmfyM
   QjgiuKHvRUtkzEokIVKn0Cr0cRiYGTXGr/jSMZgNpOaWawKYqZ+45UZci
   Fk7jmrnz+njYheNAYs5T2l3Klj/j3EKJUpmQfntSBD06uw0NnevsmuyTd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310915661"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="log'?scan'208";a="310915661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="673411824"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="log'?scan'208";a="673411824"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2022 18:45:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:45:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 18:45:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 18:45:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU2g16pHoPr6Y8VBtMFJG+WPNlU7GX5WwRhPWSiNiT2NWQhIz9sgmzmno0TLSRIY1V5kr/z3MjJhnsx+xZt9/WBUfOW7VtHy+fjwneNBGH+K2lsGxTKIoIj24ge6eRbJEn1LdgZWeTe4w3X2pGAVIlyxlMOlLSYdxqWLYGDtb/oDt1d22HafwCB+cDPKGtreOW4BjllQz5ehkkyhXCmLbspS4S3E/QMKlaULMJkl8+OCDIYSQZpl8uFb4apxLexqPmuAl7oIqVTjFYWuDaOyrJF0R8Ml6cukKVM9bPZNIicM/wG9tMChYeQBX/q0lbYsyLO8UvPkfoFTpwWB64G6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHqo5Cbem4N7zUavFMbgC2Xr0TUdrBd7/J7NuRLexnU=;
 b=j6P3YBjwQxKtRSSy3RXHG6QxNByUuvKUXYhbFef2ozHIU5ffAANcNFhwh41uSIjmmPuKKaOiVduvxVYxUFJxf0ICOk4qvlFQecXlpJrs2zf+eZddSaJb0CLWfPWFtAKPgvkaSX6YBu0YdNmU6hcbgh9TnvSNVQo/CPCkmRMo5+1b5iE1fwQ3Tr4aAjE85YyLOtfmDl+s/U7TzZp/Pk2T3KlmX7KY+r4p3m9Hycnwgg1SJE1GubEhXQT1/+BGTzeKVYWiDCDRRAZJ6LwssVyAr7VBvADSgssSixEuHU2LxRVWhfRfTu8Xb+BDcJQlRCuNvWcvTrLYgcpZfFZNX0PaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 02:45:39 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%5]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 02:45:38 +0000
Date:   Sat, 19 Nov 2022 10:45:54 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <peter.zijlstra@intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
Content-Type: multipart/mixed; boundary="i4yh2gfoPQlxTzKs"
Content-Disposition: inline
In-Reply-To: <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3451c0-6f5a-4c5f-527d-08dac9d8237b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq+QUTKcB/Ro2DQWJ8aGh4dzTWFfnsHAmL18VUzdehC2qs/XuBtsyRoy86CzdFtchKrau4vM5bHOI4YMXbud87nZytNB0SO71Y5T8bMM84ebjN7AURfAPpgwQWv0PC/wI7s+tgVipgLI9vtrCQFIBadWpBraI4zNeVfvLN2dupd34JWurPZIQKwaQGjTSTnvSa4H9OYvZbBIx6D9XBdrOV2HLfirGXfXqZfn9Sd9mB7iLB43ujFojD3MWI60BSCTxnYVUfcBeuR5ipCnRgUSRo+/flPDlrsXp39Mk8PthqLYzLkby6s1JE2jtu/nG+wjFPL3Aco8mB6JfOJKCeg4yZDeKd1DVMSOR702/K0hOExCGlcGraxjwoOOdpiVqhv/ne2UeC3I+HGTIqiD1+YjCOYFA9TSIiQWLtOW25kwWBYovWolGudbDWTr003td4mC+HXQAAEsPjHYT9PJ3BPYbE08HPSs1gETr8u/K9rRl34vMMLMUVhIDutbGXnMo4spVbPY40IcutaoeV36ST10Q0dvxpHopEOz7n3/4Qv7g1KZUZSQ/S+n8+i+z0nqRQp+FwQtR4L2oHP8AoywX/nKzlLqOl3wd903sWgTA5BadLEMDXor8U4YYByPIXEcE8pGAYQC01yMypfH5wHTjjZl9WoVXco19vSofsGKj/Q/ADCPxvTtBJ+E++5uveQyTVuMnLAony14JEh/n+1IvDpDotplnkFLHAlC+bPyREIujEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(6666004)(235185007)(5660300002)(44832011)(478600001)(6916009)(316002)(6486002)(966005)(66476007)(41300700001)(4326008)(66556008)(66946007)(8676002)(8936002)(186003)(83380400001)(4001150100001)(21480400003)(2906002)(6512007)(26005)(6506007)(53546011)(44144004)(54906003)(38100700002)(86362001)(82960400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOqTS9e/l+fU5xS8h+ebS0RhcNLVA7X6AY1c4JAIBmsyxQUdX8fp8ob1xbrf?=
 =?us-ascii?Q?yacuRF64VLTXKrHtUDaRG8hmz1E3axLp6hLC54+DSEhT877v3ZE35deKWu1r?=
 =?us-ascii?Q?jvF0d9OqxkCVx1WA/PtAEgXvApdGdbBvfm/jg6kHBAdRLoMcsV0T6lqxulf2?=
 =?us-ascii?Q?cx9yrOgoUK66FDWzJOgdmDsdx/WWgAAX2YkPJbLjnxV+GEY9+P3NpzwP0nUo?=
 =?us-ascii?Q?cbkwSGPWoyM45kSGhh6OLr5SE28qbxLw2UzVxb5E59gxrvqtrLYNbIOh7UIQ?=
 =?us-ascii?Q?QBb+o15s+NCClniZ3zrC5k8UuFAj83a8uNw3/KhRcDqq2mzMHxvtT2bMGVIn?=
 =?us-ascii?Q?TUhL+KSbcWSazfTPxJ+ACwr/TBpRU4bFIfzzQwE7CD/nB0W/tur0yi0uQnNS?=
 =?us-ascii?Q?QO1//W0zA4KS33p0PQ/ZUajaithvorOVUcnGFs8g1nvh/oBgaUhXLy/xHjo0?=
 =?us-ascii?Q?snhPHInx4HfEJoVkHTLGe6EhLqnP5mmq1wndWHfy+Cw2ZgrAnRNRPFppvJA6?=
 =?us-ascii?Q?HfqIv0nR47mS2W10LVbz708KYYov/SsYormy78XmjDmyv7LdJWyk7selbNAL?=
 =?us-ascii?Q?KQDw7mGMhA/pQ3xiju+0N7AfuIwpma82XGATn/KM1AM/fe8h5euxfHznnjdt?=
 =?us-ascii?Q?0wyC/DyvzNWvZ8CyojX3JAQs0T+ncm1UrprIIKkCQ3jFxef7GKfO0xQv3z72?=
 =?us-ascii?Q?0otIWcGpL6NhmL4P4ryWqCC+gzkYv7o87zzzBMOBmvXSaiyUL6JwLflWWeRt?=
 =?us-ascii?Q?LtT9Ec61My+zIf62qd5GuoHMv6EzycNEIqi4TQNZZG3k9vTzxtH1mIDETvwu?=
 =?us-ascii?Q?FcqGjh4F5QOOs3bo3VJc2NAvfGxc0VRw/Gw600vt+lI4bn3BUJnmf/BhI+x1?=
 =?us-ascii?Q?LcWVfahTIfu4CF/5B9iWz29KfRe99go+uAJ0rj+9yUvnEVHJUi3bIXAAQLvv?=
 =?us-ascii?Q?4TAvwCUGPpIGETXXET07+QnHc4FZSbbXM3JZXDbg/ndAFNStMpQsIO37Q8wa?=
 =?us-ascii?Q?IrPoOFCgAS5y033hcfz9ZHnWQolFVebc30RFQaPf8qVhsdkQLQ9p/mGUM65U?=
 =?us-ascii?Q?qfcZo7r/wyAiFZkPutqVIooulDp+MbofJ67Q5kAujecWwHmEKkHoJoMtclm5?=
 =?us-ascii?Q?Yz2OwuqweRYptCaLx58+A0t19jDCbCTkGdAszfPHn7rv3C3LPd0WjL+LCjHu?=
 =?us-ascii?Q?d+WJ3vYfwyAjFceTPXQXWMS7Vcn9pRAaMvsmuskNi1aplf5RGHxGUl+do/JL?=
 =?us-ascii?Q?VIllHnBeIQY20QEhTgkP+7a4M6KezRAJCy4UvEVNCNGTVvLkjP/wyIVjNJSn?=
 =?us-ascii?Q?hXey8EON41vjwq+lSGO+NFFnRM4mQjsvxAxd69V3c4jDDlZJ7ZhjIbHVxST5?=
 =?us-ascii?Q?QBX/tY12wCiFNhPQ+kjHPqMkahJ6x4af0JPCsNfrXos8b3M5NnYvHOvMby5u?=
 =?us-ascii?Q?8B03BjgkHOoZfMLaaKMEGtXyZNf+VHhlSAXmesuNYP59UdYEd1FteMIl1WYl?=
 =?us-ascii?Q?8jh5AHTfaCWtt0Im6JEmdq2kZxD0JnLg9VC/MpkF56Nroy0P7w2jrgo1ujTl?=
 =?us-ascii?Q?W/VK2QYLRJ/7ylYkVgq3KbW4HtNZkmYY+4B9GJkZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3451c0-6f5a-4c5f-527d-08dac9d8237b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 02:45:38.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNf4WscuzUZ70R39CsmICEHPiYyEMqwafU+2YebBvT5DR5xCDTNas8GP5vNHk/QSaC4njpc9WxVsgTBt+n0P9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--i4yh2gfoPQlxTzKs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Peter,

On 2022-11-17 at 19:11:37 +0100, Peter Zijlstra wrote:
> On Wed, Nov 16, 2022 at 11:39:53AM +0800, Pengfei Xu wrote:
> > int main(void)
> > {
> >   syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> >   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
> >   syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> >   setup_sysctl();
> > 
> >   *(uint32_t*)0x20000200 = 0;
> >   *(uint32_t*)0x20000204 = 0x80;
> >   *(uint8_t*)0x20000208 = 0;
> >   *(uint8_t*)0x20000209 = 0;
> >   *(uint8_t*)0x2000020a = 0;
> >   *(uint8_t*)0x2000020b = 0;
> >   *(uint32_t*)0x2000020c = 0;
> >   *(uint64_t*)0x20000210 = 8;
> >   *(uint64_t*)0x20000218 = 0;
> >   *(uint64_t*)0x20000220 = 0;
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 0, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 1, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 2, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 3, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 4, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 5, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 6, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 7, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 8, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 9, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 10, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 11, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 12, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 13, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 14, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 15, 2);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 17, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 18, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 19, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 20, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 21, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 22, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 23, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 24, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 25, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 26, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 27, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 28, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 29, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 30, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 31, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 32, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 33, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 34, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 35, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 36, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 37, 1);
> >   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 38, 26);
> >   *(uint32_t*)0x20000230 = 0;
> >   *(uint32_t*)0x20000234 = 0;
> >   *(uint64_t*)0x20000238 = 0;
> >   *(uint64_t*)0x20000240 = 0;
> >   *(uint64_t*)0x20000248 = 0;
> >   *(uint64_t*)0x20000250 = 0;
> >   *(uint32_t*)0x20000258 = 0;
> >   *(uint32_t*)0x2000025c = 0;
> >   *(uint64_t*)0x20000260 = 0;
> >   *(uint32_t*)0x20000268 = 0;
> >   *(uint16_t*)0x2000026c = 0;
> >   *(uint16_t*)0x2000026e = 0;
> >   *(uint32_t*)0x20000270 = 0;
> >   *(uint32_t*)0x20000274 = 0;
> >   *(uint64_t*)0x20000278 = 0xd62;
> >   syscall(__NR_perf_event_open, 0x20000200ul, 0, 0ul, -1, 3ul);
> >   return 0;
> > }
> 
> Putting that next to 'pahole --hex -C perf_event_attr' seems to suggest
> this is HW_CPU_CYCLES with a sampling on and exclude_kernel and sigtrap
> set.
> 
> Now, for hardware events like this, you'd expect the PMU OS filter to
> respect exclude_kernel (specifically not set ARCH_PERFMON_EVENTSEL_OS in
> the relevant MSR), except there's a bunch of erratas and skid related
> 'funnies' that mean a user event can trigger across the kernel boundary.
> 
> Does the below patch help -- it should filter out those sort of things.
> 
> (still also including that previous patch)
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ec3717003d5..cc86bf25f0c3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9273,6 +9273,21 @@ int perf_event_account_interrupt(struct perf_event *event)
>  	return __perf_event_account_interrupt(event, 1);
>  }
>  
> +static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> +{
> +	/*
> +	 * Due to interrupt latency (AKA "skid"), we may enter the
> +	 * kernel before taking an overflow, even if the PMU is only
> +	 * counting user events.
> +	 * To avoid leaking information to userspace, we must always
> +	 * reject kernel samples when exclude_kernel is set.
> +	 */
> +	if (event->attr.exclude_kernel && !user_mode(regs))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9305,15 +9320,28 @@ static int __perf_event_overflow(struct perf_event *event,
>  		perf_event_disable_inatomic(event);
>  	}
>  
> -	if (event->attr.sigtrap) {
> -		/*
> -		 * Should not be able to return to user space without processing
> -		 * pending_sigtrap (kernel events can overflow multiple times).
> -		 */
> -		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
> +	if (event->attr.sigtrap && sample_is_allowed(event, regs)) {
> +		unsigned int pending_id = 1;
> +
> +		if (regs)
> +			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
>  		if (!event->pending_sigtrap) {
> -			event->pending_sigtrap = 1;
> +			event->pending_sigtrap = pending_id;
>  			local_inc(&event->ctx->nr_pending);
> +		} else if (event->attr.exclude_kernel) {
> +			/*
> +			 * Should not be able to return to user space without
> +			 * consuming pending_sigtrap; with exceptions:
> +			 *
> +			 *  1. Where !exclude_kernel, events can overflow again
> +			 *     in the kernel without returning to user space.
> +			 *
> +			 *  2. Events that can overflow again before the IRQ-
> +			 *     work without user space progress (e.g. hrtimer).
> +			 *     To approximate progress (with false negatives),
> +			 *     check 32-bit hash of the current IP.
> +			 */
> +			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
>  		}
>  		event->pending_addr = data->addr;
>  		irq_work_queue(&event->pending_irq);

Thanks a lot for your patch!
You added below part based on previous patch in below link:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/urgent&id=bb88f9695460bec25aa30ba9072595025cf6c8af

"
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 884871427a94..cc86bf25f0c3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9273,6 +9273,21 @@ int perf_event_account_interrupt(struct perf_event *event)
        return __perf_event_account_interrupt(event, 1);
 }
 
+static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
+{
+       /*
+        * Due to interrupt latency (AKA "skid"), we may enter the
+        * kernel before taking an overflow, even if the PMU is only
+        * counting user events.
+        * To avoid leaking information to userspace, we must always
+        * reject kernel samples when exclude_kernel is set.
+        */
+       if (event->attr.exclude_kernel && !user_mode(regs))
+               return false;
+
+       return true;
+}
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9305,7 +9320,7 @@ static int __perf_event_overflow(struct perf_event *event,
                perf_event_disable_inatomic(event);
        }
 
-       if (event->attr.sigtrap) {
+       if (event->attr.sigtrap && sample_is_allowed(event, regs)) {
                unsigned int pending_id = 1;
 
                if (regs)
"

After your patch, I could not reproduce this issue in "15465 times ./repro"
Attached is the dmesg of guest, and this issue could not be reproduced.

The result shows that your additional patch fixed this issue!
If possible, could you add Reported-and-tested-by tag from me.

Thanks!
BR.

--i4yh2gfoPQlxTzKs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="61rc5_perf2_fixed_dmesg.log"

[    0.000000] Linux version 6.1.0-rc5-kvmperf2+ (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10), GNU ld version 2.36.1-2.el8) #11 SMP PREEM2
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002] kvm-clock: using sched offset of 279607063 cycles
[    0.000557] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002280] tsc: Detected 3110.400 MHz processor
[    0.010167] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.010185] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.010203] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.010825] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.018581] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.019259] Using GB pages for direct mapping
[    0.020740] ACPI: Early table checksum verification disabled
[    0.021364] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.022010] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.022925] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.023841] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.024755] ACPI: FACS 0x000000007FFE0000 000040
[    0.025267] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.026157] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.027050] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.027941] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.028673] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.029409] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.030141] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.030869] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.031597] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.033216] No NUMA configuration found
[    0.033532] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.034144] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.037836] Zone ranges:
[    0.038046]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.038551]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.039057]   Normal   empty
[    0.039296]   Device   empty
[    0.039533] Movable zone start for each node
[    0.039880] Early memory node ranges
[    0.040172]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.040681]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.041205] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.041930] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.041947] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.046011] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.046760] ACPI: PM-Timer IO Port: 0x608
[    0.047617] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.048128] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.048730] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.049267] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.049812] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.050358] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.050911] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.051477] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.051997] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.052423] TSC deadline timer available
[    0.052739] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.053168] kvm-guest: KVM setup pv remote TLB flush
[    0.053572] kvm-guest: setup PV sched yield
[    0.053948] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.054601] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.055252] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.055903] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.056563] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.057107] Booting paravirtualized kernel on KVM
[    0.057490] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.058357] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.059219] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u1048576
[    0.059822] pcpu-alloc: s217088 r8192 d28672 u1048576 alloc=1*2097152
[    0.059838] pcpu-alloc: [0] 0 1 
[    0.059982] kvm-guest: PV spinlocks enabled
[    0.060335] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.060939] Fallback order for Node 0: 0 
[    0.061288] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.061842] Policy zone: DMA32
[    0.062094] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.063590] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.064288] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.065023] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.068639] Memory: 1999736K/2096632K available (30736K kernel code, 4081K rwdata, 7528K rodata, 3624K init, 10528K bss, 96640K reserved, 0K cma-reserved)
[    0.070711] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.071233] kmemleak: Kernel memory leak detector disabled
[    0.071685] ftrace: allocating 66320 entries in 260 pages
[    0.091493] ftrace: allocated 260 pages with 2 groups
[    0.093241] Dynamic Preempt: voluntary
[    0.093620] rcu: Preemptible hierarchical RCU implementation.
[    0.094072] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.094606]  Trampoline variant of Tasks RCU enabled.
[    0.095001]  Rude variant of Tasks RCU enabled.
[    0.095356]  Tracing variant of Tasks RCU enabled.
[    0.095732] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.096324] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.122751] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.123538] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.131541] Console: colour VGA+ 80x25
[    0.131891] printk: console [ttyS0] enabled
[    0.132588] printk: bootconsole [earlyser0] disabled
[    0.133458] ACPI: Core revision 20220331
[    0.134014] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.134901] APIC: Switch to symmetric I/O mode setup
[    0.135545] x2apic enabled
[    0.135983] Switched APIC routing to physical x2apic.
[    0.136426] kvm-guest: setup PV IPIs
[    0.137633] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.138184] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    0.139117] Calibrating delay loop (skipped) preset value.. 6220.80 BogoMIPS (lpj=12441600)
[    0.139838] pid_max: default: 32768 minimum: 301
[    0.140406] LSM: Security Framework initializing
[    0.140817] Yama: becoming mindful.
[    0.141363] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.142010] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.143709] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.144448] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.144924] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.145467] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.146186] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.147116] Spectre V2 : Mitigation: Enhanced IBRS
[    0.147498] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.148157] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.148756] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.149439] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.244676] Freeing SMP alternatives memory: 56K
[    0.245197] smpboot: CPU0: Genuine Intel(R) CPU 0000 @ 2.20GHz (family: 0x6, model: 0x8d, stepping: 0x0)
[    0.246138] cblist_init_generic: Setting adjustable number of callback queues.
[    0.246717] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.247110] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.247110] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.247110] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.247110] ... version:                2
[    0.247113] ... bit width:              48
[    0.247452] ... generic registers:      8
[    0.247760] ... value mask:             0000ffffffffffff
[    0.248157] ... max period:             00007fffffffffff
[    0.248558] ... fixed-purpose events:   3
[    0.248876] ... event mask:             00000007000000ff
[    0.249478] rcu: Hierarchical SRCU implementation.
[    0.249856] rcu:     Max phase no-delay instances is 1000.
[    0.252226] smp: Bringing up secondary CPUs ...
[    0.252746] x86: Booting SMP configuration:
[    0.253081] .... node  #0, CPUs:      #1
[    0.253476] smp: Brought up 1 node, 2 CPUs
[    0.253476] smpboot: Max logical packages: 1
[    0.253476] smpboot: Total of 2 processors activated (12441.60 BogoMIPS)
[    0.255452] devtmpfs: initialized
[    0.255492] x86/mm: Memory block size: 128MB
[    0.256916] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.256916] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.259210] pinctrl core: initialized pinctrl subsystem

[    0.259962] *************************************************************
[    0.260491] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.261018] **                                                         **
[    0.261550] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.262078] **                                                         **
[    0.262594] ** This means that this kernel is built to expose internal **
[    0.263115] ** IOMMU data structures, which may compromise security on **
[    0.263631] ** your system.                                            **
[    0.264145] **                                                         **
[    0.264661] ** If you see this message and you are not debugging the   **
[    0.265177] ** kernel, report this immediately to your vendor!         **
[    0.265696] **                                                         **
[    0.266209] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.266723] *************************************************************
[    0.267154] PM: RTC time: 02:26:27, date: 2022-11-19
[    0.269659] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.270502] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.271058] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.271117] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.271744] audit: initializing netlink subsys (disabled)
[    0.272194] audit: type=2000 audit(1668824788.308:1): state=initialized audit_enabled=0 res=1
[    0.272194] thermal_sys: Registered thermal governor 'fair_share'
[    0.272194] thermal_sys: Registered thermal governor 'bang_bang'
[    0.272287] thermal_sys: Registered thermal governor 'step_wise'
[    0.272743] thermal_sys: Registered thermal governor 'user_space'
[    0.273221] cpuidle: using governor ladder
[    0.275116] cpuidle: using governor menu
[    0.275681] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.276372] PCI: Using configuration type 1 for base access
[    0.284778] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.486478] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.487017] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.487128] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.487680] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.488961] ACPI: Added _OSI(Module Device)
[    0.489298] ACPI: Added _OSI(Processor Device)
[    0.489656] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.490034] ACPI: Added _OSI(Processor Aggregator Device)
[    0.494459] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.497234] ACPI: Interpreter enabled
[    0.497601] ACPI: PM: (supports S0 S3 S4 S5)
[    0.497940] ACPI: Using IOAPIC for interrupt routing
[    0.498346] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.499047] PCI: Using E820 reservations for host bridge windows
[    0.499592] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.510561] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.511048] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.511117] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.511941] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.514268] acpiphp: Slot [3] registered
[    0.514642] acpiphp: Slot [4] registered
[    0.515004] acpiphp: Slot [5] registered
[    0.515162] acpiphp: Slot [6] registered
[    0.515523] acpiphp: Slot [7] registered
[    0.515909] acpiphp: Slot [8] registered
[    0.516261] acpiphp: Slot [9] registered
[    0.516623] acpiphp: Slot [10] registered
[    0.516990] acpiphp: Slot [11] registered
[    0.517375] acpiphp: Slot [12] registered
[    0.517735] acpiphp: Slot [13] registered
[    0.518097] acpiphp: Slot [14] registered
[    0.518461] acpiphp: Slot [15] registered
[    0.518845] acpiphp: Slot [16] registered
[    0.519161] acpiphp: Slot [17] registered
[    0.519520] acpiphp: Slot [18] registered
[    0.519888] acpiphp: Slot [19] registered
[    0.520250] acpiphp: Slot [20] registered
[    0.520636] acpiphp: Slot [21] registered
[    0.520995] acpiphp: Slot [22] registered
[    0.521362] acpiphp: Slot [23] registered
[    0.521721] acpiphp: Slot [24] registered
[    0.522091] acpiphp: Slot [25] registered
[    0.522455] acpiphp: Slot [26] registered
[    0.522819] acpiphp: Slot [27] registered
[    0.523161] acpiphp: Slot [28] registered
[    0.523529] acpiphp: Slot [29] registered
[    0.523896] acpiphp: Slot [30] registered
[    0.524257] acpiphp: Slot [31] registered
[    0.524591] PCI host bridge to bus 0000:00
[    0.524915] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.525449] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.525980] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.526562] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.527114] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.527716] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.528244] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.530833] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.531627] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.533535] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.534593] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.535115] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.535616] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.536153] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.536834] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.537577] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.538142] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.538880] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.539772] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.541350] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.544155] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.545006] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.547615] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.548592] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.549503] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.551986] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.562066] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.562822] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.563397] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.564156] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.564767] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.565908] iommu: Default domain type: Translated 
[    0.566296] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.567236] SCSI subsystem initialized
[    0.567590] libata version 3.00 loaded.
[    0.567659] ACPI: bus type USB registered
[    0.568008] usbcore: registered new interface driver usbfs
[    0.568468] usbcore: registered new interface driver hub
[    0.568898] usbcore: registered new device driver usb
[    0.569355] pps_core: LinuxPPS API ver. 1 registered
[    0.569746] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.570444] PTP clock support registered
[    0.570811] EDAC MC: Ver: 3.0.0
[    0.571180] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.571691] NetLabel: Initializing
[    0.571958] NetLabel:  domain hash size = 128
[    0.572293] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.572751] NetLabel:  unlabeled traffic allowed by default
[    0.573255] PCI: Using ACPI for IRQ routing
[    0.573581] PCI: pci_cache_line_size set to 64 bytes
[    0.573648] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.573655] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    0.573717] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.574178] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.574629] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.575114] vgaarb: loaded
[    0.575600] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.575992] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    3.014538] clocksource: Switched to clocksource kvm-clock
[    3.096333] VFS: Disk quotas dquot_6.6.0
[    3.096691] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.097328] pnp: PnP ACPI init
[    3.097826] pnp 00:02: [dma 2]
[    3.098847] pnp: PnP ACPI: found 6 devices
[    3.107226] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.108171] NET: Registered PF_INET protocol family
[    3.108621] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.110441] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    3.111096] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.111690] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.112373] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    3.113041] TCP: Hash tables configured (established 16384 bind 16384)
[    3.113557] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.114073] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.114699] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.115509] RPC: Registered named UNIX socket transport module.
[    3.115963] RPC: Registered udp transport module.
[    3.116314] RPC: Registered tcp transport module.
[    3.116664] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.117155] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.117620] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.118081] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.118615] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    3.119141] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    3.119823] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    3.120262] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.120797] PCI: CLS 0 bytes, default 64
[    3.121307] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    3.123838] Initialise system trusted keyrings
[    3.124225] Key type blacklist registered
[    3.124639] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    3.129853] zbud: loaded
[    3.130989] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.132182] NFS: Registering the id_resolver key type
[    3.132571] Key type id_resolver registered
[    3.132884] Key type id_legacy registered
[    3.133233] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.133730] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    3.134367] fuse: init (API version 7.37)
[    3.134847] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    3.136370] 9p: Installing v9fs 9p2000 file system support
[    3.144047] Key type asymmetric registered
[    3.144353] Asymmetric key parser 'x509' registered
[    3.145242] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    3.145713] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    3.146349] io scheduler mq-deadline registered
[    3.146758] io scheduler bfq registered
[    3.147625] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.148272] IPMI message handler: version 39.2
[    3.148624] ipmi device interface
[    3.149795] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.150455] ACPI: button: Power Button [PWRF]
[    3.151373] ERST DBG: ERST support is disabled.
[    3.152050] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.152622] serial 00:04: GPIO lookup for consumer rs485-term
[    3.152631] serial 00:04: using ACPI for GPIO lookup
[    3.152640] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    3.152650] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    3.152658] serial 00:04: using lookup tables for GPIO lookup
[    3.152665] serial 00:04: No GPIO consumer rs485-term found
[    3.152858] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.158094] Linux agpgart interface v0.103
[    3.158718] ACPI: bus type drm_connector registered
[    3.166223] brd: module loaded
[    3.170395] loop: module loaded
[    3.171779] ata_piix 0000:00:01.1: version 2.13
[    3.172762] scsi host0: ata_piix
[    3.173293] scsi host1: ata_piix
[    3.173633] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    3.174164] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    3.175032] mdio_bus fixed-0: GPIO lookup for consumer reset
[    3.175041] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    3.175048] mdio_bus fixed-0: No GPIO consumer reset found
[    3.175263] tun: Universal TUN/TAP device driver, 1.6
[    3.175746] e100: Intel(R) PRO/100 Network Driver
[    3.176113] e100: Copyright(c) 1999-2006 Intel Corporation
[    3.176563] e1000: Intel(R) PRO/1000 Network Driver
[    3.176945] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.254397] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    3.331267] ata1: found unknown device (class 0)
[    3.332026] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    3.332483] ata1.00: 16777216 sectors, multi 16: LBA48 
[    3.333416] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    3.334475] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    3.335201] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB/8.00 GiB)
[    3.335912] ata2: found unknown device (class 0)
[    3.336439] sd 0:0:0:0: [sda] Write Protect is off
[    3.336832] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.337048] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    3.337665] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.338708] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.339893] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    3.356291] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.363566] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    3.577899] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    3.578441] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.579024] e1000e: Intel(R) PRO/1000 Network Driver
[    3.579416] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.579901] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.580319] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.580799] PPP generic driver version 2.4.2
[    3.581534] VFIO - User Level meta-driver version: 0.3
[    3.582277] usbcore: registered new interface driver uas
[    3.582729] usbcore: registered new interface driver usb-storage
[    3.583286] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.584401] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.584773] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.585525] mousedev: PS/2 mouse device common for all mice
[    3.586373] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    3.587566] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    3.588250] rtc_cmos 00:05: RTC can wake from S4
[    3.588851] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    3.590101] rtc_cmos 00:05: registered as rtc0
[    3.590497] rtc_cmos 00:05: setting system clock to 2022-11-19T02:26:30 UTC (1668824790)
[    3.591127] rtc_cmos 00:05: GPIO lookup for consumer wp
[    3.591135] rtc_cmos 00:05: using ACPI for GPIO lookup
[    3.591144] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    3.591153] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    3.591161] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    3.591170] rtc_cmos 00:05: No GPIO consumer wp found
[    3.591212] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    3.591823] i2c_dev: i2c /dev entries driver
[    3.592170] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    3.593123] device-mapper: uevent: version 1.0.3
[    3.593647] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    3.594299] intel_pstate: CPU model not supported
[    3.594713] sdhci: Secure Digital Host Controller Interface driver
[    3.595191] sdhci: Copyright(c) Pierre Ossman
[    3.595566] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.596075] ledtrig-cpu: registered to indicate activity on CPUs
[    3.596692] drop_monitor: Initializing network drop monitor service
[    3.597550] NET: Registered PF_INET6 protocol family
[    3.598814] Segment Routing with IPv6
[    3.599136] In-situ OAM (IOAM) with IPv6
[    3.599456] NET: Registered PF_PACKET protocol family
[    3.600072] 9pnet: Installing 9P2000 support
[    3.600445] Key type dns_resolver registered
[    3.601313] IPI shorthand broadcast: enabled
[    3.601684] sched_clock: Marking stable (3594123408, 6975066)->(3611851714, -10753240)
[    3.602553] registered taskstats version 1
[    3.602934] Loading compiled-in X.509 certificates
[    3.603605] zswap: loaded using pool lzo/zbud
[    3.604198] Key type .fscrypt registered
[    3.604505] Key type fscrypt-provisioning registered
[    3.605420] Key type encrypted registered
[    3.605741] ima: No TPM chip found, activating TPM-bypass!
[    3.606174] ima: Allocated hash algorithm: sha1
[    3.606544] ima: No architecture policies found
[    3.606908] evm: Initialising EVM extended attributes:
[    3.607312] evm: security.selinux
[    3.607565] evm: security.SMACK64
[    3.607816] evm: security.SMACK64EXEC
[    3.608091] evm: security.SMACK64TRANSMUTE
[    3.608397] evm: security.SMACK64MMAP
[    3.608674] evm: security.apparmor
[    3.608930] evm: security.ima
[    3.609155] evm: security.capability
[    3.609424] evm: HMAC attrs: 0x1
[    3.612061] PM:   Magic number: 14:43:410
[    3.612420] misc ecryptfs: hash matches
[    3.612906] RAS: Correctable Errors collector initialized.
[    3.613568] md: Waiting for all devices to be available before autodetect
[    3.613914] md: If you don't use raid, use raid=noautodetect
[    3.614202] md: Autodetecting RAID arrays.
[    3.614419] md: autorun ...
[    3.614563] md: ... autorun DONE.
[    3.617228] EXT4-fs (sda): INFO: recovery required on readonly filesystem
[    3.617575] EXT4-fs (sda): write access will be enabled during recovery
[    3.684509] EXT4-fs (sda): recovery complete
[    3.687225] EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
[    3.687691] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    3.688508] devtmpfs: mounted
[    3.695274] Freeing unused decrypted memory: 2036K
[    3.696908] Freeing unused kernel image (initmem) memory: 3624K
[    3.697221] Write protecting the kernel read-only data: 40960k
[    3.699397] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    3.700153] Freeing unused kernel image (rodata/data gap) memory: 664K
[    3.787885] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.788229] Run /sbin/init as init process
[    3.788441]   with arguments:
[    3.788446]     /sbin/init
[    3.788451]   with environment:
[    3.788455]     HOME=/
[    3.788459]     TERM=linux
[    3.849357] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[    3.864393] systemd[1]: systemd 239 (239-49.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +G)
[    3.865560] systemd[1]: Detected virtualization kvm.
[    3.865813] systemd[1]: Detected architecture x86-64.
[    3.914513] systemd[1]: Set hostname to <test>.
[    4.927125] random: crng init done
[    4.997017] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.998309] systemd[1]: Created slice system-getty.slice.
[    4.999075] systemd[1]: Listening on udev Kernel Socket.
[    4.999835] systemd[1]: Listening on multipathd control socket.
[    5.000657] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.001531] systemd[1]: Listening on RPCbind Server Activation Socket.
[    5.208485] EXT4-fs (sda): re-mounted. Quota mode: none.
[    6.359141] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    6.359859] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    6.512475] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    6.513285] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[  101.283412] perf: interrupt took too long (2519 > 2500), lowering kernel.perf_event_max_sample_rate to 79250
[  102.033003] perf: interrupt took too long (3178 > 3148), lowering kernel.perf_event_max_sample_rate to 62750
[  102.469469] perf: interrupt took too long (3995 > 3972), lowering kernel.perf_event_max_sample_rate to 50000
[  103.228741] perf: interrupt took too long (5005 > 4993), lowering kernel.perf_event_max_sample_rate to 39750
[  104.327778] perf: interrupt took too long (6279 > 6256), lowering kernel.perf_event_max_sample_rate to 31750
[  105.996693] perf: interrupt took too long (7853 > 7848), lowering kernel.perf_event_max_sample_rate to 25250
[  110.097300] perf: interrupt took too long (9817 > 9816), lowering kernel.perf_event_max_sample_rate to 20250

--i4yh2gfoPQlxTzKs--
