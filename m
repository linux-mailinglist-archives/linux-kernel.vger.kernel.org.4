Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81D721AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFDWOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:14:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57DAC;
        Sun,  4 Jun 2023 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685916840; x=1717452840;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RWpFjWTjiUDlCt7DGSVqmQr2TWHIcrYUKXYBSfDQpMI=;
  b=IvMPZ7N4CSVA1J0lVQWhGg97bz0WWrBXY55pfhAVftuCieLj4tv9+iUs
   HaNOn0aIITDo4eZZoY7svNriygDgZLrq/yHDb+ihZQ0dkuHhcLzMJWhUv
   xO0HQJIRdYOeDmGthNV6mBPJNKy0MIPqHGnYqd9rir9rTrddurqIW52Jg
   bIGYrenrlNS33IYAejQflSqMRAENmk+tsMNk4SOJ46Vwj1BNKJBVjuDQV
   ZnvZr+rTOfCSdkWhtS6n6zZzEzA8cICtRd5XkmtVkvdZfirnDE9nyVpKg
   WB1ODywCcY2YJwq+SIJUzv4w6ND0ebAOgStxmF+Lmlsg3Nq8vDSrIQ/oW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335854606"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335854606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 15:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="711586224"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="711586224"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2023 15:13:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 15:13:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 15:13:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 15:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSf0iBgioMINR8tXojQE3f2lIKApwV9CT6Hgz3TsU/8kQmEQN40WjHrGy9Bm4XxKsuTp4SdpKQbWhA49cAAc0uWHFB5wvQpbZj2PeKAPnHsqXF4no1XNQcj0lqOZ5blmzqCoHya2CF5rkuwgizvz+yW+osED4kruqYqm62jZq7Mr2lwqT4pgsbioGuiYTPSutS9FQwRD/6qLjOd2z2hFrKW+hGoTry4vjxxHzLOUZyUb2Q9LqgGjoZ4JeFhrHzaWXTfdd32OoBXL+ea9LEYwZOTYYjJmae2+PaDQxVaQH3+ghsK9DPPzUwC9TJLuHobQcGiOAAxb1MkNNmJxLEy6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg5km/kFBRj0+8MzE8GeUnqwZWYJClA/nN3YBKGb2mA=;
 b=VYw4Sji7ajjwqxeElOLcV/ZJyd9YKUtrWSeP1TiV26L4gCgJFK7zgrQenlrlvwDnUiv7zADv5FU+7HIZAUGfN+BfXDbO0Flvt19v+lN4Md30Fc5Eu2ub0aoAEY/RGwPoz8jymfPEHs5O+rvojmMaT6y1VJ8LhHMmOJ09PkDbj97Td/MYZtzOg8MDXdTeLl36noT80SissDRN9AJriROJgbs1w1bbh/n9WQzINflMlslTTVO9MZzrpOWh+QIVHIHCDwokDPaXjr1uJz1FqyPcZiEPn+viqOYmkQulxvfUplJSFGTAxCjpDvkmivdy2oIGAO3XbeFTAs30zrbQC/oqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CO6PR11MB5651.namprd11.prod.outlook.com (2603:10b6:5:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sun, 4 Jun
 2023 22:13:56 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644%6]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 22:13:56 +0000
Message-ID: <5300deff-9967-d67b-91f4-6f47cf9f12ce@intel.com>
Date:   Sun, 4 Jun 2023 15:13:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 09/12] x86/cpu: Add a configuration and command line
 option for Key Locker
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <ebiggers@kernel.org>, <elliott@hpe.com>,
        <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>, <nhuck@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-doc@vger.kernel.org>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-10-chang.seok.bae@intel.com>
 <20230603163751.GBZHtsXwW5UUnsSbKX@fat_crate.local>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230603163751.GBZHtsXwW5UUnsSbKX@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CO6PR11MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 0762f9f6-b156-4927-a8bd-08db6548fd09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTiKNywK1GL7TGDd+5W6oJ9n8vWvxFtn24WKh/fXXGR9tzXRiZ3cbNCyRZxlB7pziR7QVIWbY/YnDYEzlAOcq+d9VYETM/WxJYg7eqnqx4neh6xajYOWIeNqZppmmJvbH3FdcjuXKvb2hsCZaTtYQJ/TCqGGlaYR1hQHEVbDQ3WB9FWkT6zkPwe5emPKUZAAxzaoc97KIy1nITlKaTWPvMTe4DKGmSNqrSk3u8Jz5xErqglRnxIDijaE4tfFLYwXlbhu40lcontDX9dnEYX7oOU77nnoykUr/IINR4lbhtDzO2tpJYIgTXBHgXU8t2S0lk8SgaF5u1fyQWh0u3Vdb2FcA87aomYGOXXeJaTeWudJbzL7mAmV8TaN25AHQhA9PNPlAGQ+VUTCqg/XO0uxOUjWliziWALdRV/SFS+4js0wIGvOMfAqj81n7wh83RsN0vRgRln71+zgDKAOppMnrQSxYrD1UgX2ub4iRoXoLG6Jas5xmjKYojdpexspqCPyp0GfOPDjXKMp5j41B9xfw3I03RLZeTDLCFFAX0FDCN4d2NU5EEfWT9hFrhAFOCFrE027EoGI5rSI6AVccLxIABM6KpvvNPppD4wWT+bGVOla8F++oK1Xm0h3A10f1RoNqS7QinQbieTpotyFYVlrIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(7416002)(26005)(6506007)(6512007)(31686004)(53546011)(83380400001)(2906002)(36756003)(186003)(2616005)(5660300002)(31696002)(86362001)(8676002)(8936002)(316002)(4744005)(41300700001)(6666004)(6916009)(38100700002)(66476007)(66946007)(66556008)(82960400001)(54906003)(4326008)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWx2UnlmbmpsZ0VSdHk5eWQ2OUMyYW5pQ0JnNStYSHdUSUtpcUhHRUo4Q1Mx?=
 =?utf-8?B?WXRTcXhmaW9jOUwyUEREdnlzRzhVcjl1Z0xaRU5BWCtqc0Rkc2Z4K05VQzJ1?=
 =?utf-8?B?bEY5RDV6S1AvN3dtSW1GVnNITWUxb2gzYzhSV2dNdW1BZyszR2lXbSs2OWhw?=
 =?utf-8?B?OWd5M2N5emljYzMxbDNIQUdwb3BZK0lWVzRYeVRFanNRYTZ0bFZDNVd4MTdE?=
 =?utf-8?B?T1poZVFnai9yTVBrWXBiR1RvWkdhUmFhZFRrNVBrcGRXU3pFTWJQU24weURZ?=
 =?utf-8?B?ODUyTjdQNEFkeXlRbXZWamtyTzErc2RHcFB6R0g3RHlYQmE4cjJKYlZYOHdM?=
 =?utf-8?B?WHlQUFo4ZklXQnFFeGZMek9pS0RNOStSVXB4SytLQjVhSUN0SGwraGdDOUZn?=
 =?utf-8?B?d01IMUhsVFlpdXA5Z20wTmZtNnZxVmJtRDY3VDYzR2xTTHJpbGRBYy92VlJ6?=
 =?utf-8?B?d2FZT0lDNXVjSHVpZWFxZmRpSlhCUHljZDVmVnhZY2xoUXhYMm1ULzBrZHFC?=
 =?utf-8?B?dlhPQkVnTUZCMmRQcldIMUhJYnBYT1J6VEk3bUhvenNSNDJVbGlsMnl0UWg2?=
 =?utf-8?B?dFdBSWNHVmdXUC9lOHVMZlh3Vm5pemVXeFlYenhXR2xHZjdhblNxQ3lxR2FI?=
 =?utf-8?B?c0FIZVZuLythYVpMNzlZdmVyK1pWTStacTZ0dEloZmw3S2ZlZnZxbEtEWlFF?=
 =?utf-8?B?eGxSY25OWTBiNDVkRjNOcFN3STlkTWtLTWlIYzhFT1VRUlRKL0VvNU8yNktN?=
 =?utf-8?B?Qmx2ejZObVZsVGo4djNrUXhVM2dSRDlZaU1FN0NLRzVVd3dWMEFEOUJiTlJZ?=
 =?utf-8?B?eXZScVB2V1dQOWpDczdNUFViNjRMSXViZmpmcDlmZ1J4NGtZM2FLRTl4eDlS?=
 =?utf-8?B?VHhaYml6R1pLUytxT0pNTWhQb3hUN1k1VTgxMDJaSDRxTld4UUQ2YnFVRGF5?=
 =?utf-8?B?Z05UaDRTekw4U1JoTFh6a2I0S2xUMlBLR1VuNWZHUFBHeXZ1Ui8xQVVGcW9N?=
 =?utf-8?B?K2IreWNEYytQTTBvakpPODFWMGVoQk9ieWNMR014SzZtK2hTY0xOemlkMHdW?=
 =?utf-8?B?NnEyR1BxWjBGTjdWNitSVG5ybk5DS3Y0NTdNTXJPblE5MjI2Z3AxbmtZWGxY?=
 =?utf-8?B?dStFUTNnMzZENGp5WmlkQkF5TTg0dDBLQU1uVEZUb1RCSTV1SG5QM21MUXU0?=
 =?utf-8?B?RU9pRUdNbkpHS1FaSDRSQ25GWE9hQzhFUFZTOTg4QS8xZTBqSXB5ZEkyVzV3?=
 =?utf-8?B?R2x2Zm5XUEN1NjIxcHFaQmltNHptRGhSUG4vTitpb29kNzRWckU0RlhLOXNq?=
 =?utf-8?B?Vm4vQkt5aTNYQnNHWFJISlJCbnZlbnY3UFhtOG1uKzZ1UG5vR2d5NHlHYzhm?=
 =?utf-8?B?R3RWYnJoZmxCZjlqRWVKNFcyWmFZU1lBMHlOemhkcG8ycDhQdjlYMk1EY050?=
 =?utf-8?B?dTI1dFhBbk9Vc1p6aHN3MzJ5dWRHODhPcHhMUGhMWm41eWNvdkxWbmZyOTVH?=
 =?utf-8?B?SzFlQW1XeWlqK1FVWVd4SWtRdlRNWmg4M0pFVEp2YkNaWitmWXVYUmxqcDRN?=
 =?utf-8?B?TE05cnJRM29RL2Z2MHVmZ1ByYk1xRTZ1VEh1YUYyTm4zWHpkbjBtbHBoWE4y?=
 =?utf-8?B?Z1MzaXdCaTNKNGdZbkxFNWFvdWFzRnBYOW45OHBvZlZUamppYkRtVE82MWJU?=
 =?utf-8?B?OWxWek4xQWZURWRhR3FqWVJ0TzREckRkYmZ6Q3hkQW9mQkFJb2dEeHpIS1FU?=
 =?utf-8?B?SHdOc09ISllJT1VvMXZXRjlxdk5OV1RwaVhqSE1TeS9qQnJOTlJwN0hyZFNC?=
 =?utf-8?B?NzYyTnlVMElYcjRMQkJqV2ltNVYyTm9NOUYvWTdaeGxOSklObTNLYjE2UlJS?=
 =?utf-8?B?UlZEWFg0bm5oTEx5eC84L3BwdVdqOEErVEJtRzFvWnlhblNVNTRsMS9WeEZM?=
 =?utf-8?B?dDBkOVZuMEo5VFA1ZExERndwZWdSbkNqejBTOEg3eDNaOUVBbUxHS1ExMDVl?=
 =?utf-8?B?N1FYamJnOVorVUVXS040MFRYNldMRDcwQzl3UTBWRmNyZURPNzNVSXlkZVd5?=
 =?utf-8?B?MEdRaVBNU2tzNllFR1BtZlZqZWI5RFoxdGdNbjJ3MkVENlNVQkw1S0dhNzFq?=
 =?utf-8?B?RldzT3d4MUo1V0MyM1dsRGE3alVTeFpPdnpaOXhzTkdiN0VBZG1vWW1WQVFW?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0762f9f6-b156-4927-a8bd-08db6548fd09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 22:13:56.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STmxYR3VzmkUXnGyIOSggcAIEHK51in5eVBWRfnneZ97uCvzVIivimCXZG5pqNYrkNsEGV83kv8TYeq7aAI2BRGrsYfIJAqWccsRdcJM3J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5651
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2023 9:37 AM, Borislav Petkov wrote:
> On Sat, Jun 03, 2023 at 08:22:24AM -0700, Chang S. Bae wrote:
>> +static __init int x86_nokeylocker_setup(char *arg)
>> +{
>> +	/* Expect an exact match without trailing characters. */
>> +	if (strlen(arg))
>> +		return 0;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
>> +		return 1;
>> +
>> +	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
>> +	pr_info("x86/keylocker: Disabled by kernel command line.\n");
>> +	return 1;
>> +}
>> +__setup("nokeylocker", x86_nokeylocker_setup);
> 
> Can we stop adding those just to remove them at some point later but
> simply do:
> 
> clearcpuid=keylocker
> 
> ?

Oh, I was not sure about this policy. Thanks, now I'm glad that I have 
confidence in removing this.

Chang
