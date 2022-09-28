Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D65EDEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiI1OZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiI1OZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:25:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64D1BEA2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664375100; x=1695911100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YtCKF1UCbc1IfTGIcSsP2zf8lUouO7MSus6VkOaqd/4=;
  b=Fdu9gTqekmAgs62/nCDvNDGPn5JdHH/ZTzBaIFmXqmXmx2dgujJmxa7B
   jewTIOguNeUWUI7z7WzQyv3HK6P3aC4JWP5VEepQkXcfg56vEF8kAeBvV
   8Rz9hwkR+IV2/bJ/ZbNsqAFblvQnYsFvkSpP9G2UQWFCOcTJRWgN7WgQV
   3aWbZ+83TE00Vah+DXS7UnnVUAZUEVlomoq6DlCOGdztgZ9bpXoYXvjKQ
   r8nS6Hu1/1qhs3O5fu04wsd7++ApwpBNlBQ7DR5PQdZUcOL/KywYaCR6C
   JQKf2aeLgGCj66wy1blakrzlaYxs85QDHBMeQXqUBm+7yuTi0l4tJ6HZW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="284746690"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="284746690"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764305765"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764305765"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 07:24:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 07:24:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 07:24:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 07:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHFnnYUR+WP5Ib5TRpZLwJE7CgOumJXE+lIQr+7ICmejCqxl+UvhF9P2BtOamO3qFhLU8btUK3P/UCLpiyVWf7x87QNDGMgP96QtJBmIuhgL69dIsJY0XNBh9csm337RyC/MKzQnJ8/VqzL4y/fcf4sruRM+dj/hwytCtrrsV3/99W5HfTBmnLOeWPLFJRhxBYpbgQ1myQ1a+H7eeKC1YhTtsU2YIqt+TtwwlICsQkDajzHc+I+O5RVYXPJxKRPRP0ESr2wTuRSVYl5D59kAGbusQjwL3y5/Qa2nqc4lH4uC9l5JgNu7U07kz651MqS5plUbeUhhZzlKDrfW0HGlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZHJXLU+9fbO7FL60ORkTjitL217ia2dxu495/xLFBA=;
 b=ak7R8vp6n4Pi1Lsn4hUVm3RH/50KbDCm+gzYpPhBcypl2mtXlSi6+htSBPOuqMFUMq2LyqPPSTu8wiVpyHNncVHZVufIH9xjIlHQR9hEV1ufbFpFcq+cGHo3+aSU1shIREZmLJbYqUsPMgnZudi3zzx9D7DKmLCwvfik58v5QfjtPb8EZ0a45j/Gv1+THmYVlpzw8chFf9U1cLvpRPh2uXshJWnvUxH+GX3DPzSFNKy2OySs+mmazGIltjsV2oNwFbazaXR7rI/WcRe1CscsAZoxv9n+1fb+fuxMOSQt9+HaI501CPeN9F66SYmvV5VC0pRj9t5w1NeTat5mD9Mutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH0PR11MB5174.namprd11.prod.outlook.com (2603:10b6:510:3b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Wed, 28 Sep 2022 14:24:55 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::e6f0:5bc:111c:1068]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::e6f0:5bc:111c:1068%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 14:24:55 +0000
Message-ID: <21ffd91e-8089-0a57-bdb6-d73246079398@intel.com>
Date:   Wed, 28 Sep 2022 16:24:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "Jiada Wang" <jiada_wang@mentor.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        "Ramesh Babu" <ramesh.babu@intel.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        "Ramesh Babu B" <ramesh.babu.b@intel.com>,
        xiao jin <jin.xiao@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
 <2f5a510b-082a-60e2-5770-58be086b5fc8@intel.com>
 <20220927110022.GA3802@lxhi-065>
Content-Language: en-US
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220927110022.GA3802@lxhi-065>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH0PR11MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1224c206-ab30-42bb-4950-08daa15d370b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYJmnYujNW08aAUCiKIy1JbNfoxLT0fvAyvoPFpgkquiGzpHcaNLVRhq+IYdTzkKpHj8x5xsw+en/3S/PPWed3MSP1YTTRUMm7NMvOaw7qIbkKPlN3+2CKvb/9cRD+vC6nuO73Wv8/lhiH1hCbtyJ//P2m+F0FL1Y9YXbuXNwuCqQju68hDMMAmCYLVb+kHMxawwpQuEiNWz86u7erpp0lKdIEmYFbVGex/h4flArqFgyl2i3qHVHG7AAZ1T0ugMLxIJJYKHZh5tOzeYjqlVDw/TQRIPqOQlgU2qjDdlS+IEEXRdkjcyZbsew3IvE1gs9snLUc+8vsyGgZWrvq5oW8kguDCeqNN0D16BqtkrsUyRlYjj/NBFSOZGTvXXzy/5ggKwlPju39KxF6RgUgZhZ9BMtn7LAwLTdFDdu/CGGC42A100v0LC4SNC+DpHNGaPMVsqamQ9U3Ud2cssC99aF30y7OqSMD3XZrTjVHplO8OWTybhi8EUAZ+0C53Anmn32PzqAn8zdL65qJmR0mfs1ajK3PYA/9gGLbNbBQIXAOStHWfNGew6I5sydw+Oc8xUNOTSY5pn5zwiaemGV3yNSnO4/+I+CAe1KdJi/7V9TjiLLxfaTibxyrkZElaqRCsYfxpgAg8HdQdcZygMguG3boI7rOhKoSZzIw4lEuYeXVmxA3Jf/omZiqZehQBfi5HyoE1crfLlhOju8GU9emztUZcA+30CqhWU5YyjTGq+Nlm2nJq9fFsCap6Ew+2QQMyKQKSIaKlYTngOmxSDQd358JOpRxQ3Dg9CZeXbvgpC3Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(2616005)(83380400001)(186003)(36756003)(38100700002)(86362001)(82960400001)(8676002)(31696002)(4326008)(66476007)(6486002)(66946007)(66556008)(6916009)(54906003)(316002)(478600001)(44832011)(53546011)(7416002)(8936002)(6512007)(26005)(6506007)(41300700001)(6666004)(2906002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dvL2xUcW9SQ0RUYUZONFQrdmdJd3pQR2QxR1FvdmJpRTVkdkNEa01KMmx0?=
 =?utf-8?B?cTBkN0hKNkZMMkU4SjRiaXZnU3JvSDFLdE5JU3JkT2Z4L3ozbGxuVCtLYThN?=
 =?utf-8?B?ODFiVGNMQWFyTzI2Y1RGL25IM0Y3bGlTbjRHMnFvaWgxVmJ4Uml3VGtXWU5k?=
 =?utf-8?B?YTEwLzBWSjF3aWsrcnBBcXl6OERxa2twSElKZmtkV1EwV25rdlZCelYwRGtY?=
 =?utf-8?B?K3hNMHNRWDRGNkpkeUpvY2pkcWN2bWhFcXdnZk0vaDZGOWVDaXpYZGFsYXg1?=
 =?utf-8?B?UE1IUGhVbWRNdUVTbDhSb3puS2dKSVFIZjI3Nm9zeWxZY1VYZ2FZYUJuNzNm?=
 =?utf-8?B?OTFuckJkcElwVVp1dHBQQ0xzQmxiV3JpMXZYMERsM05NeDVYZGsyRUxXVFh1?=
 =?utf-8?B?ZjhKdUN2UUlQYkR4TlRFMkZOQVgyL21LMmxxd29obktjb0RBempORmxJK00r?=
 =?utf-8?B?VzlnbjhpVXBqc3k3RFB5dGJxclVKdm5PN0lTV3hwYndJY3RCVE95WndNRVdZ?=
 =?utf-8?B?QkZRUCtsbG1HcHNSN0xxWUNjckZvWXlVVWhmVCtyOUJOOUtzNHBkYjg0YWhG?=
 =?utf-8?B?SU92NUtGRkthaDhyK3ZxNVlkZmlLUWNQR3VIQ0t1cmYxUm9RazVNeVhRZUNQ?=
 =?utf-8?B?Q1BsL2lOK0lsQTlqdzI0TkpBZytmdFZUem9OTVVaa1BSeE9SWEovYUs2akRo?=
 =?utf-8?B?ekNrMTRNc2crK09oaGR6YUVOWkpIWWpua1p6UlBRTHpoUW5DODYwOUNDQjlz?=
 =?utf-8?B?YW9adyt2RDRoTVdORkttelQ5QmtvQXR1QzQ1d3hSTDJiRk9oWVJ2b3FpV3FI?=
 =?utf-8?B?SlQwb3ovK1hybEZuVnBOQTNXNE1mVm5iQUFTSmJRSHFiYXAvMEdPZ0dVd3lZ?=
 =?utf-8?B?YkY1YkVvMkJzT2FMNG1LMzVGYS9uOElCTk92citoL01BcmsrNU9kQmhRYjhQ?=
 =?utf-8?B?WHJrdmU1M0Fmby9SU2wvMHQxcjlwc1BmVXBzRHBqWnJtUWdkZ0pYc2tkWjNw?=
 =?utf-8?B?cTNldjhtTkU1ZTVsQlFCaXhId2hIQ0tIdWVaQ09OR1RMTnAyNFMvcmlZVk9z?=
 =?utf-8?B?M1NnakIrTk5Fclh3Qmo2NDl2dkFmcHlEeFNDMXJTbDVVYkFkZUVnNk5FcGlR?=
 =?utf-8?B?OXJpSkY5TXRUb3RsZVN6YjNkNktoNFhXNVcxcU1uejVxZkpYbitEZWRxdjYv?=
 =?utf-8?B?L01zem9MTWhLWVRaZDZ5bzN0K25RcTQwT1QxOHVCa3IzZ2ZtTW9QNXlsSyty?=
 =?utf-8?B?WjJZQk1EaUhMQWtUaUdTVjJkNnRsMWpST2F0c2NhYXROR29iUzZCbFdnam12?=
 =?utf-8?B?S3pWaWpuWW5uYSs2TktDbXdtZHppQVNlTXlUVjlWLy9SWmgrcHhIYTdiMzdv?=
 =?utf-8?B?TlhxUUorQThlSUVUZmw0ZzRUMFYvU3ZuaFMxU1JURE9ieDFrVWlwZUJUVmJN?=
 =?utf-8?B?SkVhMVovTW9BdHQ2dGYxbVRpMWg3TDU4bG05bzgvaW5jS2orSUdqMjdCYlpy?=
 =?utf-8?B?SzF3ek04WXpLMWo5WVRDYnJTVm5BV2ZzcVp1V2NZZmI0NDdvZTRxbVQ1d2U3?=
 =?utf-8?B?NTByNDFQNDdUMGNjWU02VXhvVU5Uc2JMQ1o2MTc0UzJZRkttd04xRC91YXdT?=
 =?utf-8?B?eVJwaEt2czFla1NDL2k3bUJtMktZKzkyMnZTWmJ0UGxJZG5TeW9XYjBSS2Mw?=
 =?utf-8?B?STVTMExlSWMrb1FDUlZob1NTNDN3ZkpONGVudWxkVy9zbmwrNHFNQU9sVXgy?=
 =?utf-8?B?bGd4VnVNdnNoWmdhYzJuWWl2cFFmQW1OTGJxSmt2RlRkOXNXZ0dUYXJJajV2?=
 =?utf-8?B?TjkzZjduc0s4dXdVVGJGTWt0Q0E1WkpRSTdEMVVPUVZYclA0R216TlVpRzgy?=
 =?utf-8?B?T2tvNTlwN3N1cUUyQ2kxVjZxa1ozTERQOGZRTHhHcnRmMER4QXFnbHowRDds?=
 =?utf-8?B?ZUswbUxkM2tmTE9ickhMc0VWU2tqYkNRSUtoOTRwRmJhVHBMZXh5TzV0VjdS?=
 =?utf-8?B?Zys1TFlZR0toSjFhZEJJcGNDaHk4VFJpeGtCWEhibEJKQlQ0eXozWkJldjBn?=
 =?utf-8?B?cm9vbzNyQ3FUUUlpRzd6TjNseG9Ka2hqMytlQXV3VHd6R3AzanhvNkJsS0o2?=
 =?utf-8?B?WkNuM2xVMDNsYkJzN2thbnRnaHc1WXg5VE1ZVndEOVphU0VUdmFNZHBDR3JM?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1224c206-ab30-42bb-4950-08daa15d370b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 14:24:55.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFvhlYr1Ids+otrD9LDF+sBjjAAj30NOsr1UsTTgxepriarsutsaOcEnNFw5p0AqW60YegETlgecnVDClttHwPB36jwenjDwC9mY/+hfqnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 1:00 PM, Eugeniu Rosca wrote:
> Hello Czarek,

...

>> I'd like to know more about the scenario you guys reproduced the problem in.
> 
> This patch was originally identified in the Intel Apollo Lake v4.1 KNLs.
> Given that the change itself is in the core sound subsystem, our internal
> assessment was that the patch might potentially be relevant/helpful
> on other HW platforms.
> 
> Our intention is to confirm or invalidate this assumption with the
> original developers of the patch, as well as with the audio maintainers
> and the members of the alsa-devel ML.
> 
>> Configuration details and kernel base would be good to know too. Since our
>> CI did not detect problem of such sort, if the problem actually exists, we
>> would like to append a test or two to cover it later on.
> 
> If there is no evidence that the patch is fixing a real-life issue
> occurring in the latest vanilla, I agree to drop the patch.
> 
> So far, I do not possess this evidence myself.


I've spent some time to locate the change. Found it and it seems 
obsolete. Some tags are missing in the revision of yours and the 
original date does not match either - it's Apr 2018 for the original. 
Won't be mentioning the tags as some engineers no longer bear @intel.com.

soc-pcm and skylake-driver valuable bits from those trees are already 
part of the upstream. Most of what is left was later proven obsolete or 
redundant by my or Pierre's engineers. There seems to be no patch 
missing except for few fixes from the recent SKL/KBL up-revs for our 
clients. Nothing APL specific.

Following kernels related to APL are maintained by the IPG team from 
software perspective:
	4.1.42, 4.1.49, 4.4, 4.9, 4.14, 4.19

Multiple OSes. And then there are flavors for kernels/OS both. It's 
quite likely kernel base of yours fits into one of these buckets or at 
least have had changes ported from one of them.

TLDR: I agree here with my colleagues - if you believe the change is 
necessary, a proof e.g.: in form of reproduction steps, is needed. 
Otherwise it's no-go. Happy to hop on a call should you need any 
additional information.


Regards,
Czarek
