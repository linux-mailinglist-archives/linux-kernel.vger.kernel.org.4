Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739369872C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBOVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:13:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9EBD;
        Wed, 15 Feb 2023 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676495631; x=1708031631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4G15IwhMdHirw8l6FQlDvsbifgZsPqwpL0kkE5Hp+E=;
  b=WFCX6dpYzP5eKafa+Nblqf2NBULIPj5z1ce07E9ktBCIlNHYrp3fVn7W
   o8zSYcee+pRkOmGDHpAZDXhOPW15OhT4M5nYtNmDaFrhfoKxY9HBg5une
   y79qWEP9acn3RQ2oTIB7cPrXG7du5gMkPalGznzr0e4vS5miaOp/SDBFI
   iQwsOg7fjurGYF5LKr6JPYj98HEDivNpWDVLtCYhqkbrm6zYjLHXC0w49
   rT65OIpFoOqBgyNlF6RCQfk7Oo/lXlidf640ZSPwks5tp0K+Lcn+qWkxg
   T1dOX9bxBav77Fy0YFBYtEht33IZr9Q38ToeAcmbPvE7MqYVloaJhqtlg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="319593828"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="319593828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="669851669"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="669851669"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2023 13:13:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 13:13:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 13:13:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 13:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrYCIOKJcCrPUC3M7hkCQe/HBWf+m9KB3vf8m5f9XuJxXsO3Itqq4/p7K19wlqxe2KC3035h+BzVMApTFUU24D/L50JpZcuKwVaUomSWDlHEX1xAboLA+lwFlRZu9yhXQLGGH7V2dx2on8f+yhmMlGGjiC016Np8FONF0/XghMPBdZV7ZjgkVm8TsOtK92AoN8T9Pyr9dbYoWPsYr0ovy5aj6I2GkebqNn0L9qmYzaUR6MjNIi7MHArTUw2xgDE337MyTUaZ1oHngK9ppCwFBVW/OC42TGk1HI3THV1zlxKFlcBG7Q3WesVWzbEFPSrKVFfdYKykbinZ3Cb8hPO42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cypbA/GxfIm+TLUODnFDYOC+TXzya99qfVEiIZgTL80=;
 b=BsOxq56r69R/5JXaZVUvVWRZdRF0egCtcuNlY5T1tsAIY2MWn8stzcSas+IOeR+vRQeI53U/ezyjP4pY3Soxdyb+Sjz3Uddd7mKLvgn4WMP6WWgbUOPLI3c0MV49EJyalFAhM0Sq3TsLx6LRXbWHyoVWAj62E2oo7SwX4Bpenm2V8cqybHThvlsgvd2kkbO7kSC/YICNln4I6s8K+KDJLfgr41mcSmBmoi3ZZTdoGqN2Gy6uuQKe0FlDv0xQhKgNdqMKn92zgpqKlQsEPNoAFylWH5smEE9jQu3lhbt8YfQBtkiw2PN++Q5phVWD4OC1PvqkLV748yUfBJgVSCKbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 15 Feb
 2023 21:13:44 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 21:13:43 +0000
Message-ID: <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
Date:   Wed, 15 Feb 2023 13:13:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4948a9-f757-4e0a-195d-08db0f998443
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fG7aiOfdP/iuhmkQTSUViAViVaS8E/D+McE9Nlln+NjJuZHC558dquY7q8nNZfEl6hdb1K77AOGZ8Po9+lp6IpWcfeBcEqIybd7Eq75dAHsH+ZG8FQQ9A5qAuw0suOgrRRy1E5PE+S9wXNigTdxvUYT6BmDCbbjJEUIa4E4DMk6ZxvQdlKbMMIs1DHJczqhL4rIS6eFQ+nykutJxpKWrPnYiSzk5NmNAZXQ+buGkQNJE+9VXT2uPdyLGF2mpX4Igsvv7jI1XM+pIg+hBYCFSHyj9y+i4Lfe7YAwp8k4fQGgxwIm2QDMYqPxzYCZ2D91juSLiI75rsZTgnGS8axqt//QLm6Z+9YFKWsPO53QG93twF3E/2qnO55kyXWZjG0WqEyuwW90ggyaUDrVTrKcDHNqOO6foDzkBDSyGpNASNcA1GoHVBKIEbLxg3v/4m691CmNUBzw5z38rh18blJ8NyMU60y8HOk/IIeSWQNGc3AnYputb02X/hyFoANY61q6vulM+2yDOttoNWc9BQ5gox8aeXLQ7rm1YV0RZEBnPp3K1H3WDU2uf5A3sHfFdOIMYmXTkd+ARe5l5kntDNcdusW5USPS66upPiQNDqhNLeINUWh5yPICz7ybnDdv0O6dhtCW6aSn29OvAq+sOEbPC0AoQB9SGKVPlC58cC6Z8uyutQiJuSLtOHSMjfKbEkkJgy+dqINEQeTQnJE5qXf0U1S05BwuQzcg5JXD1I8PJbuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(86362001)(82960400001)(38100700002)(31686004)(2906002)(4744005)(186003)(6486002)(6506007)(2616005)(83380400001)(53546011)(31696002)(36756003)(41300700001)(26005)(6512007)(66556008)(4326008)(66946007)(316002)(478600001)(8676002)(66476007)(7416002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdwM1hMZmpnTkNHV3FHdWtKTHp6cUtvYVBJYUlhWTY4WU40L0pEcE5qTlFC?=
 =?utf-8?B?d1JlNmtxOVhEdzdxYVBiSVIvU1Y1RElwTkZROVI1Z082eEtORkRQR0E2bTVB?=
 =?utf-8?B?K1VrU1JRUlY4TU1VdFFvZ1VXYitaY1hySnlnTGw5TFJVM0JkWG90aFgvdEJw?=
 =?utf-8?B?NHlXYzNzMERROTVBaEFOZ01RaURxU2NHOHhCaGMxdEZVYktadklRbnU0OHZ1?=
 =?utf-8?B?b3N2cmNLQisvNWtsRnU1NkxINlR0M09PUVVCOUQ5U1JXdDB6TE5hc0FiVmEy?=
 =?utf-8?B?TkZUMDIxTlNpZ1JvdFQxYU1POGZxc1lBQlV0UEdpak8ySGsrSXNRUm56SXFo?=
 =?utf-8?B?L1NJeHdVL29DMXNuM1h0QTQ0TDYxblV2Sm9ZMVdRS0lMd1R2eXp5T1EvK3l4?=
 =?utf-8?B?SU1MT3YybzVLbXpMb2NFSkpTalV2WDNRLzJ0WnVaZVRjNmFnTVNMTUZ4V0Mr?=
 =?utf-8?B?azJ0OHZNdkR4cGN1YzZXNjBjYnRkUUliWkcxM3l0RWVLVVh5N0dEVkZ2NFhR?=
 =?utf-8?B?Um5yMS9iZ2VueDhUNVB1dHZIZkNudHFNVnBuM0QyRkNyWVM3RUg1VGEyZGsr?=
 =?utf-8?B?OVNBNjV2ZjVtOEtqc3dTbVQvSTFiYnR3TTRpbG5SL1B4ejRXTVlKK3dtSnV1?=
 =?utf-8?B?YW5uUUgrY1Q3TG42amJiUncxQjBRazE5TDRVMmlOWkpzVk9TYmpqampURU1m?=
 =?utf-8?B?MWhmeldmU3BRMHhnd3RaVGJqSGhkOHhtSk1OdU5TS2xCRzk3cHE0QVNmNUxC?=
 =?utf-8?B?cUQxd1dWbk1tajBoa1ExMFhmWXhkMVVWNjVHWk9tWUVCN0RXWDFoYWh4UTFI?=
 =?utf-8?B?Q3FqZHV5VFFENk1sbXduTzNUSjFkNHVSd0lLLytMRGFnQjlTT05XNG1yeldH?=
 =?utf-8?B?d3JucWdrZ1BlbGJIT0FQTU5laURiZ3J6NXRLd292UnByRTFyQ1NJOFhETEtu?=
 =?utf-8?B?UXRiZHljcC81R1ZVQkZxN2UrUTlXdHlwaU5Rb0d4clQ3ajlZcUNpcXNWZnZm?=
 =?utf-8?B?K1NiSStTNndVZURibnl2WDdjYUsxS20yajcrL2VaQ3lUNitncE81K2phSWMr?=
 =?utf-8?B?c0JGTmY5cVpNQXJhS2U0aHFoOHNrODdVdGRrVU5DaG5renZlU3FoNnZ4THJh?=
 =?utf-8?B?M0poSlBNdmpXZkFZbk9WN092SWh1a2tFbUZad0QyTUxxbGk2S3RzWHl2WjRR?=
 =?utf-8?B?L3gyekMxRDk3MGVJZWlvRjJ1aGpWN3pRdS9NSE1zYmpWelZzQXhiUnQ0cnIy?=
 =?utf-8?B?MGxOWVF3K3JmekdVL2FTSy9xalFGL1htazlGN2gyVkdnQlRJaEJIUVBINFBv?=
 =?utf-8?B?MWNPMjBIUFU5S3N1d2FPRi9TMGNVd2pTVnpSUVh4T1JjS0RVTUlJMkFheXpW?=
 =?utf-8?B?L0RXcDRlWS9GNEhVcG1rejgxbjZWQkNacG5BWm1aeGhPVlgwVWFDRmpMWm9W?=
 =?utf-8?B?OVc0dnVoMVRVdFRjRktnK0lOa3kwYWd5VkxUOUsvQzlySytqYzBpcCswa3Zk?=
 =?utf-8?B?dkducWUyM1htb1JlMklMQjVVc3B4cjJsbWxWOUNkOXdneFhpRHA3YzVmenVu?=
 =?utf-8?B?RHI1NkpqU2lHWUxhc25MMUY3K2JhZWdzZFhMSUtaSmJUcVV0OGYveFFxbW04?=
 =?utf-8?B?UlRvTTd1RmdLRmlzQm4vUXQ0cXFvWGVlZ3VFWE9VV2FPU2VidzNIV3NRL1ZO?=
 =?utf-8?B?eWhtMnpzMUpOei9JYVErekI5Mm5BaHhmMlNkemtESU9MNVRlWi9KVUNsUVFv?=
 =?utf-8?B?Q0dHN0REN1kzQ281L2dLMmVpQ3d5NjkydTdYZzNVOElmdlJLT256UzJpWTBO?=
 =?utf-8?B?ekI4K3NCV0FsQXpvWWpHbG9WcjJiY3E2TzJXei9QeXQ3cnFZTHFnbWJkbTlJ?=
 =?utf-8?B?UHl0L0FZcG5KMVZFUWVXWlF6d3hxZnpiQzhPVXR5eFRLak5UV2VUcGxYeVpp?=
 =?utf-8?B?V1pKd0o0VHJ1MEpKTUxWRlJ0N0RtRzB5VEVHMXRtWGc1cXVVdnVlVjAyQkNy?=
 =?utf-8?B?QldOalJ2bG51VkpLbk9McEFQbEVVRHordFBrbi9uMXJ5VGNESkhqVnZRSFlJ?=
 =?utf-8?B?eGNpQVBXd1MvOFdGcTZ1NWM5eklqNXFZWDJoaGQwRU5YNld2VnAza3pvRkox?=
 =?utf-8?B?eDV6VUlIQWQ5ZEpZTFJKdWZHS1JIVk84SHNEYnl6QUlnMFhVcUZkd2VxaVNG?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4948a9-f757-4e0a-195d-08db0f998443
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 21:13:42.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8xcjCScl/nA9Qq0GbFKnLRpcSS5As4LHgSdCbI6AccFY6TzElKeN5dO+IFD+6vT4DC+KBpvqy6TAPdDbHeeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 12:26 PM, Dave Hansen wrote:
> On 2/15/23 12:22, Joseph, Jithu wrote:
>> 		trace_ifs_array(cpu, *((u64 *)&before), *((u64 *)&command));
> 
> Uhh, you control the types in the tracepoint.  Just make them compatible
> so you don't need casts.

will change it to:
trace_ifs_array(cpu, before.array_bitmask, before.array_bank,  *((u64 *)&command));

i.e will pass compatible types for array_list and array_bank. And for the last argument, we need to dump the whole 64 bits within "command"
into trace output . Since the suggested change replaced the union with a struct, it is simplest to cast it to u64 needed by traceoutput.
So I would prefer to keep the cast for the last argument alone.

sample trace output ... 

<snip>
  bash-4562    [001] .....   761.563749: ifs_array: cpu: 10, array_list: 00007fe0, array_bank: 0101, status: 0000000200007fe0
  bash-4562    [001] .....   761.563772: ifs_array: cpu: 10, array_list: 00007fe0, array_bank: 0002, status: 0000010200007fe0
</snip>





