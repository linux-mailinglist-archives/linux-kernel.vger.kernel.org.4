Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4786FB64D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjEHSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjEHSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:18:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8515E65A8;
        Mon,  8 May 2023 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683569911; x=1715105911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EeRDqxfqpisycVl580a4HAwXp4evDQJyfhN3CGxss7Q=;
  b=PAFv8farJux3PR0MGOUUAf+zw2wX9Gnx7CMH+nEEKgDXk0jPNbCaDWux
   3mvsuB5pFBz076CdZ804BS7+jjDZ0rdiHuuskaPdtA688YJY2WfWsn6al
   ZbBSZi1Uu7Bz2mykI+Cy7rrW5zkJwWhTkhQB8uPLLH0WhcJP/OIxn8qAk
   BTalk9p5k1VwSRlV6iJ04KMZszwvv5d0WXxO3IFlHJ3YBs2UTl9IkjzMn
   JhZmIURk2ptgXmjGemDWLYCt6pzffkXsLNAoRp7nTSVL5Hgk16uczQTBq
   29xHaofVCXKVp12FBRnyoiExjDt70+AJpO7KgC2+bkAEyLT0tQ6inTEX7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352780964"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352780964"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 11:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="1028498203"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="1028498203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2023 11:18:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:18:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 11:18:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 11:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7knWY4dylXxTivVwfdXgdeUSWjtJKe8mkKHLF8JU7NTadR+ed+d+pM5MoerKzEKhfEBOt60f1je1xMrkajuXPrEbgO6A7YIYUsoVdjofzYkgRPvw6B+pGGfBwxtLxZUovLgqDYs6EgY2MGCiuAOX6ZPhPR7vg+CLe3UAAZNY6wNgEK6Ap7Rv+4c/NMsUYCTkardy6FZ99zTs8TgYaGZBr8j9UIhealtKU35+CMU++UywvADlN6htlhXkkEvgZqKF+Ie/wgAi7YaCxgkE2BHbsyjozN53YXc8+9z2+NlPY4o6XdAwmstnjYcG0tOvo4Lac1eayHL2gbIdxQ1tOjMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT7D95xkjSMMYbwC75/hu9sLJkkAIZpMm5FwBSgLflk=;
 b=N7Qx2v7jnJcVtnvzlVPcxueJT3/GToVKadnYcp0xiNaqlwN9926lxq1bMNlG7MJr4+zEq1rCSXqnDDNvOMQFP5OdwOyM2PQzSsITc3Ym018zklJYUcBzRTn2/Kl/5RqCY+Y9nZ1qFOIOnGk5oNGeAo78dTAMh8nNf1iliJ5LijntNaiday/7C51kEuL9XGFa1dsFGyfE6y08WpBBwWmypJSuXTooBEiAmzS5N8onSRdsxmebx+Q5d0AfjKMKSST/urbslQHf2/IERocLFUlOntoWFmFAS9yPrH7SgR1tgFs0P0GtYK1wGMKTe3HoN4U8OLV01zVGPBkQkMx6xOpiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 18:18:27 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 18:18:26 +0000
Message-ID: <1b2eb485-2320-b33b-a0ac-53f7cb170adc@intel.com>
Date:   Mon, 8 May 2023 11:18:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <bp@suse.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com> <ZFWLoOZZTnBrid+7@gmail.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZFWLoOZZTnBrid+7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 88713e1c-1050-46e9-dd72-08db4ff09e19
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoiPR4/WDpcnuJYZiLiPrgHYRBgP38US1SbQm2Vg9HcWHEq/+FQZKjYzVon1M3MoCH93J0er3sQ8Sf/G31NK/3SANMFW5ocOS1jx8iZ8vOVuw8oKkwH6Di42CMldElPVtkElRy28rs7K2pZ9CCI1jAJkE+pfM2o9V67udHk/5digroEjspurejV1U+wPxHDy6xOisOzXQxV/lFMmrz2QocEK2Rw+pcV3vomJKy42Es8KGaoC7WEX1UaVvjam0bdG+2iJo/SksdhJbzyinIWnllMv8CbdOnjNJjeRSgqlprdVedrGD3GSW+U3HBotIILJ5M+3KAqrW46nnuhIS5LGUsfobGil8wfHAk5TP9WCL9cobjQS6+leCv7P3w8JJSZqVtzPSKhEuYRPhdkdhJ4/43G01DGkQm6sjS25Scs3Ap2tMh+yCcp4uNRm4in21z7imXqW1QR/mQahmZsti618+aM/3sFmJwLkYiXa3JBz6H2dF074ip79IiAKP3pRvEXYuC3V72ig1ole9S+UXpmFe7cJDMfTUzUCGOdOql1n2VcAhUFlIqfgj7d3vAvCHYPu3vKnMptD6Fcmzj6tPPISicW3qzYwztoW5obmoNKkJgJJZl360nNUHf1dVkTX4Edqwg4Z3RVPBwhEW/G5MgI1OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(31686004)(36756003)(38100700002)(2906002)(4744005)(7416002)(316002)(8676002)(8936002)(5660300002)(86362001)(31696002)(66556008)(66946007)(6916009)(82960400001)(41300700001)(66476007)(83380400001)(186003)(26005)(6506007)(53546011)(6512007)(478600001)(2616005)(6486002)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FkVmI1cTZyYlR1MUNnWVowSmhlNDRxZ2xGeHlHOWVFZ0k3a0FrdXNnRita?=
 =?utf-8?B?aEtRUWhhaDY4Mmw4Rk5SelJqWDkxOU5VQy80YnlQRnZSSVZoNkM5aFFyTkRN?=
 =?utf-8?B?UlpJR295aytlVlQzcFBiK3NhS0EwSmVXN3VId0w5UllmN1RkaXhWZnlOandI?=
 =?utf-8?B?eHFuR2NHSVhTdGVLUldYeFlxNEl5cG1JVWNMcFM4Vm9GV285dE9DMVJObzVY?=
 =?utf-8?B?R3hCbnp2TFlyV1k4WUN0NENPZVg4TFV0RXlMWXBRMnVzQUt2WmRqcUZ6NEJx?=
 =?utf-8?B?WUNHejRmSldvMDNtdEd6YUpnUTVqNmQ4K2RTOUtFQkdjajZEM1RUb1hVRGRv?=
 =?utf-8?B?c21sYkpoNjRDdEU4amIvMmNIeVEzTzJVQ1NkbTUrcnpwMVVPcW0wWldmK1NU?=
 =?utf-8?B?MzQ3Ykg0ZmNJVVQ2dVhaM3l3UGp4dzEzaFdoMU91NWxKaHRWTnBiRlRON2pW?=
 =?utf-8?B?ZXQyNThRQlhpTDZ3d3VwRnJKcEc5WEcyakdsSERuT0FjRU1BWVpreVJnZkRE?=
 =?utf-8?B?eVhOYit3RzJGdG1XdVlzYUpVVVcvQlhGVjlGck9CWEU4V3hCd0ZEeDQwK2Y0?=
 =?utf-8?B?VVg4SjdzTm9NT1B5WUdUc3krd3FLVjc0U2dQaExNZmthTnFjRHJCMG1Ealhj?=
 =?utf-8?B?Z281dHp5ZFc1RUF6bG9JRDdRTjcwWkcwYWkyRStsaHRMYU9DK05RamxhdHZu?=
 =?utf-8?B?MUcrZ2VtUGVIT0xCc0JzWUJVdE5Hb3ZKTzA5WlY0RkdtbGJTc3B1emdDVGMy?=
 =?utf-8?B?NmlpT3k3STR0NDY3VS9JN25WVkh5eFJiYnFKKzQwTjZvd1R6RUl0MXdoQmNx?=
 =?utf-8?B?dVljRTNqbXBJZVJBNDA3eEtEejBocklsZU1ZcDRkUGVGQW91R2ZrOEtxaTMw?=
 =?utf-8?B?TXBOdUs0T2Vwblhid3M2MDE1aWt5OUZkMURXOGNES2oyTGFxZGFlcCtKM28x?=
 =?utf-8?B?NW1WVzhCUXh1QjQzcDJRMEJtWUtIRjFCaFdvOG1EazZrekZGeVVOeTV6UXlW?=
 =?utf-8?B?blpVZzB4d1RCWVpPcHBRVGVkU1hCWVJwUmR1MlpxK0xPejEzZDQwMVh3RDJ4?=
 =?utf-8?B?czVNRzI0Zjd6R09ubHJKR1dBRkd0dmNBdzFSMitPMTFvRm1nY0xVUmtNZ05R?=
 =?utf-8?B?cldsV1BpNmZTRnJQS0I3Ym8rOWtSNGVXNkZpUGVhSDZkVVVDcjhiOG50OHhF?=
 =?utf-8?B?WG81SWdiZ2hPVHN6dStXc0ZNUU0zTW9TMEhRNzVvTEJ6ZUY3V0xuVUtEc2Zr?=
 =?utf-8?B?UDEyZk1xVFNtMCtYSlpKcTlodXVWenViUVJhaXd0eW1ZRUdmMGNYcnpGZXFV?=
 =?utf-8?B?VjhKNkpNaXRSMXdtYjhCSE53SGpxNkNWWHFna0JibkdSQzBjWHV6MWJYbjJV?=
 =?utf-8?B?VXI1SVMvcld5dEYvR242SUJHald3UFlmM1l3REQ3eEFxMGQ5dGhtVnRlclA5?=
 =?utf-8?B?YWJUbUdReVVQYTFnbG9JQ1BaSzlObXJ2MTVRbkE3alkrM2MxWFY0M09RZFRQ?=
 =?utf-8?B?d3FWQ1BxcjNwTDZZMVVybUNrNlF3NXE3aUNvMzlQR3RYR3VSWHZjYzRaT0R3?=
 =?utf-8?B?YjAzVjJxa3c3K3h3eEZ1YXlyUHFzY3ZLaXJUUnh3VjIzNnk4aUNrdXd1N2tm?=
 =?utf-8?B?b1JTaGwxbmlpODFkaGIzTm9JWVRzNHdkSmtNeDdJQW9sYjdYL0xyenZJMFhQ?=
 =?utf-8?B?QUFzWWxJVmpGM0xHNnhzK1dma1VCOVJCQkozcXU0RG9rcXIzSHFKb2xGZ01v?=
 =?utf-8?B?bGhPQ0hLbG5BUWJMVE5peFZiV3Q5TGNtQUlCMlFXejZLMTFPajU5NXd3Q0Fh?=
 =?utf-8?B?ODYzVEZqU05ZYnJsNldnVHlsYkl4MFI0K0R2bzNHRmcrZEErWitDWlBUU2dY?=
 =?utf-8?B?Z3lMV3kwRFJPbjVHMHhxV25EdGRTS1Z3M1RiM0tpa2I5ZjlwcXJFVDhnUFhM?=
 =?utf-8?B?NzkwSzE2Y3VPdmdhU2ZsazhDYjBKNHdxUUV5VGxCdlVYYkltQkVGR3FVL2h6?=
 =?utf-8?B?UmZUZGRnUFdqZkRKaERWZjJUelJ0Y1RhUHBtMXVjakNhaE1wYy9WWlR6dHZj?=
 =?utf-8?B?bVJFcENhQVZ1TGJUQ1ZMOHNhNWFzeEZ2WlhHSk5IVzhNdVlrcThlMnhXaWFE?=
 =?utf-8?B?YXhuME1MWW9DejZNYXBkU2doaDRxVG1IRFZOTWNZcHIvdHJ6TmtMZkYrbTVh?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88713e1c-1050-46e9-dd72-08db4ff09e19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 18:18:26.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPijgCBilUVic8bheFdezpuHbRvMSEH2tR6iEjtKYgdNic3f38MKzTIvCZ3xiN5sUpOnwDek+KHrs7B0pD1Q/aic2LedvmC+QNzzDPiCgkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2023 4:05 PM, Eric Biggers wrote:
> On Mon, Apr 10, 2023 at 03:59:31PM -0700, Chang S. Bae wrote:
>>   
>> +#ifdef CONFIG_X86_KEYLOCKER
>> +void setup_keylocker(struct cpuinfo_x86 *c);
>> +void destroy_keylocker_data(void);
>> +#else
>> +#define setup_keylocker(c) do { } while (0)
>> +#define destroy_keylocker_data() do { } while (0)
>> +#endif
> 
> Shouldn't the !CONFIG_X86_KEYLOCKER stubs be static inline functions instead of
> macros, so that type checking works?

I think either way works here. This macro is just for nothing.

Thanks,
Chang

