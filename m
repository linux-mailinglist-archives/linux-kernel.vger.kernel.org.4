Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9A74C454
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGINZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGINZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:25:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80425186
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688909142; x=1720445142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AJ9gry/0Xj0acKdlfJP91I21nd8GASQHd2MndJI5rYo=;
  b=HjGfrcVca7Na0lYIHo/JMoLi5VN0ppv3L/W05y82oLqNfVMpBim71kCn
   X0AID0/3iaSMDgeaB+jjo9ogWfpf3OHjkxYvl+fRs84YsVoOElxQ5STYP
   2bCF7ktWrLjWmBMseG2b9Y+q5WB1RP3kYEJxH10brZ7NUvSeVQ++gAeEC
   UE76u7mcKqJzqyMRDOoq6f8R9RyAh32JjnT+NcYDCVDVvCXAgjrLl2esb
   PaE6uW+ulSEFOr3gSD4FFm1w34ZxWKfvNBB1nYDmZa2hvhgwt6vDH33ZG
   kKz19L+Q7LzrkxH/SOPKQPZ+B04tQmtw+x18smQI333MoPECO204h2IMV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427854812"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="427854812"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 06:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="790510166"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="790510166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2023 06:25:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 06:25:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 9 Jul 2023 06:25:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 9 Jul 2023 06:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbcySNo/8v/9kPIoaWeaO46qcR7/ycCpbEXQSBNIg+GsI8NWTQGTghCQVYvrbO2tN19Vej0891iCW+Rf8rPOepk/wp7EEa3RNUxK6n09W3z1UMQjm5D3ZfXnvb7/GKuvewtBl9kqJLNiovadVuYXmo4oeRYk7k9mykt2gbDflDrHSM/jczQJ0OlWPC+Pq6oWkTlKGhVBZxVagq4po/v596eKRxCzJdIbaLSTUZmrwFb/S77YAvKgDA7iHYsabVBQZtSRZcq/ivJFRTI9mmmYiwGG3YB+k3QIi9oWmXDYdYmln1763P8QqMqkx0llHVNUzTXKrVfGlNeUfyQ1ilgk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ9gry/0Xj0acKdlfJP91I21nd8GASQHd2MndJI5rYo=;
 b=KEGiPg+bEbolbRYJe9hORwNEQvkdRMLZaN8DQzQZ8HVJ4gRe83kGwUBE2woi9/bH1xx+1bs4SIl+Q4I6QJweQVC9Je1S4RmW2WcJGSlEVkr440sX7yWtQcXcOy+jFlA5+MJGpdo2/kgSa2+8dkP8XjqfLJ7bqn9cTkiT7cyGMomSevh6mne+8NrpJiuBn/HiNJvYYWwbu/xgYlCembDPDNhp++gn7omKPO6BrQnKtnvZIer0SQofqEZdxpPayoFZj5xtfufIyxDYB1l05UTMkzvdMMDfDgBJ8M77HCXj7Fc3XiyH42a/rD+e4T+k4qGzs0XDSlBli7Yh/3a/De/wVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Sun, 9 Jul
 2023 13:25:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 13:25:39 +0000
Message-ID: <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
Date:   Sun, 9 Jul 2023 21:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yuzhao@google.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZKjfwYWh/n/LbTZv@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acf4708-b55a-48e9-e9ac-08db807ffca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAtF8H1OMi8FJiQFfK0r6zQYtFxG3KA9O3BZPVUvM9fQTltUEEJnT8sNZlW2cC2VjjSe833c/yM/Q/Vo7FMkp0n+PBku0hwFCv65cBugN3vuC9/dVyhGXsItV9UNAZvb7J9H+3zYEKC+TLFDGq2dFO/TGY9jEdEgsWUz8TsMzpASU8Dzx4LfmRpR1LcyhExdRM/1ae71W/3kMIC5ZdEfnrD42eJwIb3VAJNdBwLKaaShO3qJtdA2P7dLAQk/twRRzGhWUQej+n+PbMxzwq7o7YcQLtu/00AIqvxH2yqP1LU01WJbDpMFYYE+UTPuE/BY/gyPZAnHJRb2tSkjO19HxPSuBw0tsNDF3ExBPr7zMgg2ujmJVXwrB70W4c9TtahUC0/8X5BXNZ904V45m+3Nuz4sVYJ8aZcliDZqK6heL14NFNWDaT3IyNNCYH5rnbQpCNCXaEcAEzXB01ZWJCh6qg1YatWhQ7NrLkdblJVsZDtMRgprbv/cXfc+vsOj45RTaqyFiw+75nWpdttgKRQIoOeeIvv1o1vmWRa86Ffa9XF3uIxbB5gnJRWBg/Bx2Clc7Pw2wekMdvAelzB2c7qEzGBnZoZjc/hHx7W0zRvAvjaGDt+JG2bky4XwbuTTpthfZSXGS6Jq/okp/ECon0GdOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(186003)(26005)(6506007)(53546011)(2616005)(6512007)(83380400001)(41300700001)(4744005)(4326008)(6916009)(5660300002)(2906002)(66556008)(316002)(8676002)(8936002)(66476007)(66946007)(478600001)(6486002)(6666004)(36756003)(82960400001)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjEySTY3OHh3c3RXQ0VGWEQ0Ly9kdW1ydkNIZnROTEU2NDdkUmszQ0FkOGlx?=
 =?utf-8?B?OHNLWFB6UXFCLzYwaVlSRG44eDhEdEkrSzA4aFV1UmZ2dnZ4RzJkWkthREFw?=
 =?utf-8?B?TEhWWU52dnRIbHl2NGdIcGJDTUpUU1ZGV0lBRXF2V1RLbzZFcmcrUXJiN1dj?=
 =?utf-8?B?TnBjeWh3VzN0Tll5L1FCTTJyUHhQSklPSUpyOGpCVy9FemtqaVNqRUJuTXNO?=
 =?utf-8?B?QW5FdE9mRzZITTFIcUN1a3VrUjBEUnVUem5FeGpFNU5pZFJNZGNzNFB3a3Fz?=
 =?utf-8?B?eXhOdUhZeHViNng0QWRBNG4xVlFEL281Ri91TFhlWXluZ3dhNFNJWDY4U2Qw?=
 =?utf-8?B?OWsvY2FPY29UdVBIMnhETEF5RENLbTcwU0JFNlVxb3BUK0MvMWVPcXJ0SGYv?=
 =?utf-8?B?VTVyYTNDZXY0Njl2UDVqWWJENXpJRUU4K0Q2TVZpcDBUTmdoa1dDOURWb0xK?=
 =?utf-8?B?UG5mRmdMNTlvSzY3K0JsbzREZVFmNHVpZnZuYlpBVTFaU3FPUGFaNmlMZERX?=
 =?utf-8?B?enZJcmM0aVJXSUZ1OGVGRUxzWTNtVHR5OWJnUG1RUVpyV29lekhyV3FENnkw?=
 =?utf-8?B?N21Na1dGYkEzb1h5bnBTYVB6eGhnZ1kyaWJkVjM5WXpwSU0xMXVTSDlmTDFT?=
 =?utf-8?B?MVEyZmdWdjQ4RXk3dnBqQzQ4WjljUGMwbEZGLzgrQmsrOEswZHAybmR2azls?=
 =?utf-8?B?Z0Rtak41Z1g3UHRTK3RxUUJHSE95c2pNbHpmU1ptS0piV3Z0b2lmQ2tIekdB?=
 =?utf-8?B?MFdJZk0wWUlyLzluVlQ1WWVkYTZnY1A0TlUvZkZTWFJjb3BtOFlVQ1hHQjlN?=
 =?utf-8?B?WjhhbVU5YytxTXBEeHp0UldjNW0zN085bGRKdEFESjI1RWJPR01lQmM2WkZ3?=
 =?utf-8?B?TisvTmIrUEVvNnBpMVRnVWFScnRnc1lJM1F3SUhNODRoaVE5cjNCY1BiQ1cv?=
 =?utf-8?B?eWhrTWd4SFczWW9yNE1KSE4yeTQ2TWRudGFOWDUyVWE4Z2tKMVhuN1hiUmZO?=
 =?utf-8?B?MkVpR2hrb1h2RHBwWHU1SW02ajE3ejU4blczZ0p4V0pqMy9ISWNIbDY1U0Q1?=
 =?utf-8?B?YkR3UzhscUVtZ1VBaElOMWxaQ0FqS3lHVTZ3ZTk5MDcvaTgvbzVVSk5FWmtK?=
 =?utf-8?B?TzNCUWlPS3k4cHNncXc2b0RuQ21yMFIwdDRPaG5GMk1HTmx3RHFOQ1FZQXR5?=
 =?utf-8?B?ODUyOWRpK0hFaDU4SnRJMmVpdVRDOStNQjJpYnBoK3dWRmhYcnJZV3hVcnFR?=
 =?utf-8?B?SkVLZU14cGZtcjhjY3o1OHBieXdMbHNWbkVUNmJWcHRqQTZlRUJRNFhmRDVj?=
 =?utf-8?B?ODB2MWJabTc2R3BJZGNBRnlwcVpTVWZwTnBqNkZMQzFvMEV0aUdYN0FmbkFH?=
 =?utf-8?B?NGsxR3R3MTQvOEQ0QnEvVS9JNklFZFlsd2dVY2hNM3pMZlhKUC9DMDFueU9x?=
 =?utf-8?B?RzdQL1Rvcm1Qc3ZEdWJqQzhzZDlJL0N2WTlOcGQwK0xkT0p4WkdaazRPbWRq?=
 =?utf-8?B?Smt5Mkg4M0M0Z0Npb1ZJeFYrd0VlSlVTNzM4YzhodnN4M2RnTDF0N1NLaElU?=
 =?utf-8?B?eGFPUE8vTmxmOHdlNm5uL1BEb0NLZWU1dVdXSTNGTXV6OGlHekdWZjJ0NEY1?=
 =?utf-8?B?Z1d1SUI3MzB6UnVBeE45dFNoeEdyeWUvQ21FdklqemcvMVJoUkh6U2pnUVRR?=
 =?utf-8?B?MXVFRCtaQkNvR3poblkrWC9wM21yN0IvVHM3Vk1OZ1pVbUdNTzJZYUFiMC9i?=
 =?utf-8?B?aFRpKzIyVDFjMytsZTM1NlBkYldDaUJJYlFzZjRBSCtrOWQ2NlFjb0ZuK0hq?=
 =?utf-8?B?dU14V3BNVVIyNExTdC9oY09PK0FvbWVkMVlibDdmcEtsblRDK1lFWlA5aEhz?=
 =?utf-8?B?d1FnVFBRY2RhTUE5WU5YZ3BTcDRZTjNrMncrZWRobWFLQTI1Q0RYU2IralMz?=
 =?utf-8?B?R0Z3cWVxSE9RaU4xd0tSWitqWlJtcXhpWXR6UGNOUnlpK3kwT1VCUS9QbTF0?=
 =?utf-8?B?ZnhuZEpaQVV4bFBjYzN1bVF4ZDZYUUdnUEJGL1RTc3VTRkdmT2I1alpNTk1D?=
 =?utf-8?B?VHVIZU1sUVRsbWRQamZhbUtNZS9Ga0hEVVhJNXIvZTd2Nzh1ejRsbWRQQ0Iy?=
 =?utf-8?B?Nk05aWd6V2xJTXpqWC9xUkt0ZHh6M21iVUszak1Gb0RmUTVMMCtzQzZPWmw0?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acf4708-b55a-48e9-e9ac-08db807ffca3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 13:25:39.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY4xt5EtL4URhKxgYuWex8niib8XUWXhDMoKshBNWm71Al0QlP4E5eYSYko7ES2U9AwuZU1cVF6PDwgPUUrx3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
> I would be tempted to allocate memory & copy to the new mlocked VMA.
> The old folio will go on the deferred_list and be split later, or its
> valid parts will be written to swap and then it can be freed.
If the large folio splitting failure is because of GUP pages, can we
do copy here?

Let's say, if the GUP page is target of DMA operation and DMA operation
is ongoing. We allocated a new page and copy GUP page content to the
new page, the data in the new page can be corrupted.


Regards
Yin, Fengwei
