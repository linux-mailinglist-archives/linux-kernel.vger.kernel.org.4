Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8C6BDA50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCPUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:42:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23006E4DB2;
        Thu, 16 Mar 2023 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678999321; x=1710535321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wtp1pvxICu/2PFYQ1fsS2v+ulLPQk0I6SoO0dPUBtcY=;
  b=m5hs8D1o6KSl8Nv/Bljdgv5Tcs8LbrCaleedqGoYLL758werMfHSHoi/
   LWoH3SUF2oa9ZB/A+ioDsPk9XaKP37JQxRe7FRYAS/q6V4I+LcbOOhuay
   HzZUOOzaK5Z8I0L0N4Hl+yPMVwuTFR1NG7zPMPhMGXUJB81jTK6kiYmk4
   s0w8AxhGB8c6dRkrFpYuJYiHTDSjVuqmkG7f+633vQ4aqwxAgYAR5PIYz
   b00KQvxAFYoXhSHtuvve9F2FPUXVm/bO7u/AHdSH5kCtPeEjnklc6LhNJ
   xA8Qz1zlGaucMuv6y2aOrEotoOzhgjR9r0vY+gs/wT+tonWn/HFjEETRA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321963737"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321963737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 13:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712495679"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712495679"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 13:42:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 13:41:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 13:41:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 13:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmVhD14meB9BrpA9ywpaLmK5bnWtfoOXU3PpEDNoeDQ3ys780jYZxwFL+5stNvh3E9dQlEDQLYmOiFMh6k3X59rJACQNWYDtfhpTNyWcEYaFex5GEmu9Rh/o0MuvaSR+SxnNAcUNEz6XOo0kRO+L3wYykxsjzORm+kqkqc5ty+A+Czy7vBi1Gv2ioHCLuy8hf2EZTWq1DzWIi+IqJQxhhBhRlbyik6V+AUT7JjsctBTZlfuTVKi9JXRgWPjyjSOk788dUXFhE1o0jkW92U8GJ2T9XEvYzF1OQhMEHtpQfxE8fC4bZi2l4sf1AofzlITEmN4f7FwYJx2UMbflzkBLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRZnziYdn85XccYwSCjRmiJgif/8CQn1Amz1dxhB37Y=;
 b=JdiQbBg7lYauylfJGiTGic59fBC4/N/gkj6+7bjCVUqmzzmyII2Orc4bSexB2Jo1BjrshY6AK+qtS+I/VkvjUxa9p9zMLCT1pS/IqQ3pTnO1B3fVMNIdBGewGZ/4AN2cDiAUFndvBFM8q848gAEOAfRi51oUEETSMrZOn1adE5ScnFGJHzAFzeIE+6zLPnlqTY9xDO620gVLi6eksQJ9JegnFjfHuJfq2elgKZy/gVJWcfWGk0ra3pD/AKVdN3581wKGKqug41wko76eGRcYP6XxwFJkrgh28oXt1jOvQz+2fjHHgNEW25kUPWW/1sL/ekNif/RljA+SNnegzPQ/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 20:41:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 20:41:54 +0000
Message-ID: <4af7feb7-7663-7bab-33a4-7ffce092f55d@intel.com>
Date:   Thu, 16 Mar 2023 13:41:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
 <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
 <edcb0810-df39-669b-ebf2-5988a71525e9@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <edcb0810-df39-669b-ebf2-5988a71525e9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 919ea05e-0c43-4869-b407-08db265ee090
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3R2E+Hgo85oyCqiA7ac9pf70g0oJYa883/pVBpRoUDuAmIk400aaI8stZWIobsE6YMwbGL+pggAZUtL/eA62zYkwlJTdkPNncUjg5D1VXDrY263hcHf5AMhV6nZY/fuOAP62Nu3CWDQYB0F8vqsO4C2pFi3v6dMMBPKqv2koeRjYmE8KrxElBPDeuDIyBLO2Kf0g7YYNZauuTgIDIH5RWa22Z8odnBP9i3Ghku7woGi8jEKNzOPlQiLmKfA1GwizTKsJJ1bNIQHmJzGkpVU1IBURDkqxyVpBsjCGnR3bCH7QBBaAM6U5RiSOT3KGwkX0ba9KJo01lkrDF8f1sZ6BQqWNG3B6eT3G1/KnjX4NqP4zpdtaWSGkDl46hnaLQaMC2hXpBJzASvqSnkc9p8hJr1jc3+x4HLOiCs4oG826ehDXwrm5037JV0Fz/hKmJ/M1aa1Dfu/3/rOtPHegY6XstHPMqehh/CWPRGF10DYDR35xyuUj80uvV5De7CJCVKZOpWYXAIL4LdNxzsJb//aW8d9r5pLkmVLh7g/aUSfy4qGgH427xwL8w0Ey6rueN51tj/ILy+13HT3/jt6jWt2rC2hVTWuz67MIZjhATDle1yirA96PkBiUBhqwXO9HVsaW6nL2sATcttXUzm9YinMXCksfIqfSo7KD0GnGQThSSZDSZ2OulNcgnCQ+Pi0vQS5O7Fv1NDwug8WSpr4jGXEtgGEUxuPhZEXjKhn41EvqxhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(6512007)(6506007)(31686004)(41300700001)(6666004)(26005)(53546011)(38100700002)(82960400001)(36756003)(8936002)(186003)(316002)(86362001)(4326008)(31696002)(66946007)(8676002)(66476007)(66556008)(44832011)(2906002)(6486002)(5660300002)(2616005)(7406005)(478600001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZwWFBHRVlublpZZ09HL2JzRk8zWlJNS1JpUUxqbWVLMnZaandOL2FncVgw?=
 =?utf-8?B?SlJvT1hDV0F6NTJ2ZVlISGlXaXZZWGJvOFBGSk1LSTMrMWFOdFhObDR6MkJa?=
 =?utf-8?B?WVZVUnk1NG1tZUpVaG1MUjR1TlZTeE5rWWxJLzhVcGpGREpVUHpEV0IyblFk?=
 =?utf-8?B?cGRCa2s2OStjQ0ZOajFmQk1JZGpoSGFBWTFMYjB2QmRWaitURW1XMFJDaFRR?=
 =?utf-8?B?Yjc3VGFUS2locVV3ZkZSc1N3djdWdTZuRW4wWFNNKzVYQUt1TkVrb3VCNUl5?=
 =?utf-8?B?NzBDc056NFQ5KzloVHk2NVZ6MDFGVlc0SldjZi9mQW1mQVRYbXR1b3laYlJ6?=
 =?utf-8?B?Qk1SOURseWtxQmVOaUZBR2Y1MituSlB3eGozcHNJOGMvYWFoeUM1UmtEajhn?=
 =?utf-8?B?UWRiM1haMmlZRnVCbEVjVzZEbDNZeWlrYzdGSjZBQmNhTVo1bmVyWHpuSXQy?=
 =?utf-8?B?K2ZneWRuVUpnbXJXQ1F0YzhmNUpUOHVzT3R2VXBsMzB6UTlZZG43Uzl2RE9u?=
 =?utf-8?B?TFUzd1BrY3NTTDA4M0RmWTB2T1R4aVdLVTJtMDZNa1A3akgyWTc4SlFUZFds?=
 =?utf-8?B?N2k5L012dG01T016YkpyemFPdFluQ3J0bXR1MUpEWDZaZzU0WmFkcmI2cmRD?=
 =?utf-8?B?UEhra3prMGFtNEluOWw0SlJTVWZpU3BET0Zqd2dsMEFQTHdxUldDSldWTlRE?=
 =?utf-8?B?TE9rZU5ndjhZeVpUOVg4SVg4L3Q3aWdqeFlVZEhBaklSNTZEVnZ6UkVMZHJK?=
 =?utf-8?B?Tkw3Qjc0Tmp6bFZwdTZDWStHOFVER0M2Z29PK1ZtVmY3TFlOZmZYdGRjVTE0?=
 =?utf-8?B?bUxRMDlpQWFuMDkwK3FnRjlxREp6aVVXQ3RFT2pQRSt3a1NmbTR5S0c5T0xW?=
 =?utf-8?B?bi9NOWxhZHY4UG1OcjczQ2puZmdMb1BScEhIRngyUEF6dEdSbXBUbzdNTk5U?=
 =?utf-8?B?WWlKQ0g0UTU4bUtNN0NaR3BZNnkzeEFWN3NaNjd3MTFYaGRUaUh4WlRVUjh5?=
 =?utf-8?B?TlRVNlkzT0RBQlp2OE1GMlBvclhpQjlkVkJkdkVsd3l1UlI0dm8xeDYxMnA1?=
 =?utf-8?B?Sk1QMHorL3FvRGFRclI4N05IQUw2TU1obHBTNDNOSXB6aFoxR2NvcGRvSFlO?=
 =?utf-8?B?S2ZNam0zNnNJVDAzWmJjZGVGMzBseDhSNEZxRzY5ZkRHN0xPODQvYTlFZk5R?=
 =?utf-8?B?dUozTlp2eVdWYm92VHZ3MEJFZkNMaEhabVpzQlFoQm5Qb1N4T0trVUNITjFT?=
 =?utf-8?B?aXdHUnhsczhkTjhwMktCRU1DVk5nWSt3aWQ0dk9yYUV1TlVFWlZoTlo4SGMw?=
 =?utf-8?B?YWZjYlNIUW9WcVIrajREbUpQQjNlbVNBdWt4ZUFGMXNUVjZ1QlBNVWtGR29t?=
 =?utf-8?B?N25HcVJMVmNvdGpQMkd3ejZHR0VNcGFtQWZCT1duRzRxbVBjallTMWdlRWI2?=
 =?utf-8?B?aGdwK2YrUEtIZWtrT0d0ZHd6OERrL0RxQUtZNkQ2SzByS0hnMHdReUs3TXFj?=
 =?utf-8?B?MzQ3YUY0alpYKzJxMUVhWGFhNTlOTGNjZ2lvODJtUnZ6TEJIZlNxcFgwbWtw?=
 =?utf-8?B?dUVWWDhOR3ZsWXQyRGR1NWV0Sk5kUWNZaWFOMUpkVlVndlJ3eVdUclFMRnBF?=
 =?utf-8?B?MG5TRTBDNkdscER6cEEzZDhDU0V5SWthM2dEZ0tMeXFQdGFtbHVMRFhZbzBL?=
 =?utf-8?B?aWk4WkV4ZVdUUVluTXdQYUtxTlRqeC8zR3VvcEFWZkNsV0RyVzJtR1d4NXZ4?=
 =?utf-8?B?cXJxc3F3MTl0dGFta2k2dVpsenU0d2ZEVkttZkpRK3RlVExmZzVxNDd6TUZH?=
 =?utf-8?B?SkZ5cDk0OUlVbVoxTUtEd0FIMFg0M3ExUFJnZHV5QzVqSHU4cFpHS1A4YjBQ?=
 =?utf-8?B?RnBtdUU0MDd4dHd6c2E2QUFjZGdLVzJwRi9uc3pJaVh3TnpvR1kxSEhGNFR3?=
 =?utf-8?B?bkdBWkpwdXU4b0gzdFY4by8vbFR5VHdZR0dlc08rdWxGTVVvMHg4S1djdG1s?=
 =?utf-8?B?ZjEybXI3OGdKLzd1QjNpcWpQRk9EeVJ4SGdCYVkzMGUvRmdFMWQ3aXFsaFRS?=
 =?utf-8?B?WFVlN0V4NU5ZbVppaXphRG9xTVlJUjFBcmsrVHhNTWE4dVpoZE94T2hIYStS?=
 =?utf-8?B?TmRCa2IwSGE4MlhINWhkQ0hxRGpNditQQmlDc2N4TWF2N2RyMy9JRUhsUnJj?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 919ea05e-0c43-4869-b407-08db265ee090
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 20:41:54.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxbzuKAq3rMFwAMb4WB3WLeUhr25xpVdtDThUKt/2Nd4sBywkpWEL2AFDrKjlEWK2psSl+n/73futnmTs/+R6lnc95OPaURi81EnYc7+OUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/16/2023 1:31 PM, Moger, Babu wrote:
> On 3/15/23 13:33, Reinette Chatre wrote:
>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 15ea5b550fe9..3c86506e54c1 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>>  {
>>>  	struct rdtgroup *prdtgrp, *rdtgrp;
>>>  	struct kernfs_node *kn;
>>> -	uint files = 0;
>>> +	uint fflags = 0;
>>
>> Hoe does changing the variable name from "files" to "fflags" simplify
>> the code?
> 
> I should have said readability of the code. Its actually fflags we are
> passing to rdtgroup_add_files. While changing flags below, I changed the
> variable name to fflags.

You are correct in that it is the actual fflags parameter but what it
reflects is which files will be created. I do not find that using "files"
makes the code unreadable. 

Reinette
