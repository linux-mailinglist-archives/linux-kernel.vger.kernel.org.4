Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03669857C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBOUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBOUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:23:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8674203;
        Wed, 15 Feb 2023 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676492583; x=1708028583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E502p1OLiZT97qOR/roIQYfmcpVUMhtYaeVAuWTcXec=;
  b=LZkEssnZ4SRcLmY81st6037nfRDXJYvn6JGxYuNT4i7PXyW99vSckziF
   HYXoR88LAZcsoL9u7tVGBtOmYj397aAkIKd6L8F748hvkUFUttki7kWAH
   4HEpDLWAAKDERF9vg22eRLu9vHMW3U0XEk15eyOepfrOJEqXiRwvjKBKB
   rCInhqSi+WLt6eyNa6A2hrZltT+hvdsVLCvTOnRTP1JjWi42to3zdAgCJ
   xROqwJdG3oO/bLHlIROK7tDfApGkpI0gJXQlPAb/DXYKDarpmc27Iwdnm
   yP9f+MCqFZJpDjht1tMAYrCSJdlTGpz0YrRi9m/oTn59nRLC+SrnZYzum
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="332852921"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="332852921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 12:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="700157659"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="700157659"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2023 12:22:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 12:22:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 12:22:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 12:22:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKjD4RzSBWIvAiZkG4KH8Ij9h1RF+TTStkHlt7Wlw44g8yCPMngQkvLDIzc72SkJwjOPbShzsXtUtPwBQbtIL3IdLqoET6WKFSzZhLObJ8mDbvt+kdw322F0Xy+DctzlFYGBtDS7wTHTux5Qz09EV/Q9VnTRnFnCmwrBft/8tRvZDSgFHT5Gmgj5Xo00iSBMiP8R++VHa9l9x/YOUZhRQQqOXHlu6yLlk0YkpA8wZsUaV8TNWlsdIprygG40qIEKKJlhNt40T+IpymM/qA7LP4VAldIpTkmuO8g9lVkUH0QaQissRXUh8SUKsYqEPzG8voPxx/sIfkc80E7CPybB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNdobDUFimfNaMX4vpcDxr7oYQIToZ4o8icM+sK3RzM=;
 b=Kgt1DouxGAl2Nys5Dugr2bGO7di9Jl4rkgNX28wgIDfQ+2lRa/zuE7B/6gVUKDKK6FiUkGrhWc2DAadRPCD1f8yHX4H92lahDCb+lf+TvfQvvbLSJD9V7WA2iX3FiZLMxAX+T2KKu8oq1ad0IQFbYzXqAhMeLhKakfE728bVJSqpewtQAos7qcwlnf9gnRwTqTbWO5JgDH1q89ULvGXvE0A2pdfCKeBhNMgBcTaYP1dVY00mF6jTrrYeFfNkDqhc96DAq5F2oCKbElhBHCg7StsYfms5kT0ZXIjrDjrK02Mzwry+dOZa/x+ZIVGGTi+NMGlzgzH3/0kndQ4tpZGRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 20:22:46 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 20:22:46 +0000
Message-ID: <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
Date:   Wed, 15 Feb 2023 12:22:43 -0800
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
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: b020ad31-7f40-4011-5ca0-08db0f926670
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xenWhkgLmACEzQIgpFf4XjLZ17dFEp1kmYijJRVI7mde4g/JEx3hnSpih8+WHWtYR/5bwq3NNhKRgBYc3kozrzJwfKOAPfAsjVioUPpPTRYg2QnephShaetz90EUotGHpcKaAzqzDhirHga4Le715qj7cRz1qQoFCRdpMWF/e6EYJsnpVse7QkmdKwdOXH9Tr2GMu89Vv5Ejpbaz2LFPGVyePkRDeBgNrLS6ySQx/rwOrLiecMWe0j9EZB8yf8y55zSUoQPVrF0iFZwlM6k79XU+9vmdNmZ/doKZDenUsXCphybHn0N2CO9aZWuRlGlP/sIe2jX5lzRvX8xZ2ca7xfG59sC/1H9zTx3WdEawjlZxg9d5q6FXmH3cPXvayoob/i293sgccjhFPceR1+Ewtykasw2j06QVs3vrnVf0Ya3kufMiWcRDMf2TTIqp4ocQGrFE2+6YL0XvKY2rH52NRxEMoS3Q7a0IiwKnX9jgyUIl7KTm/AdCuvm90XW+GAxxRAbw+34MT3kbwWmmtMQ15MhZxoVjy+RsWZ91Hx33Si9xwxrMltMTNledM4m0fSVnl2iPV/V2lskFJxHS87LNIn936z4586YCmeODQ63fluL7bS/LK8LLHy86zxAhLTMPWR1wkIA/qT7Qy8ok8tF9g2WYMC81sidMSZAX+50kEinXVgbQm5SEXUNWhhG0fjuJuB+gbQHSUDXAwAEhqg3BclW5+Ol2JAMBh4J+ytqE9C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(5660300002)(7416002)(8936002)(66476007)(66556008)(41300700001)(4326008)(8676002)(66946007)(2906002)(316002)(31686004)(6666004)(6486002)(36756003)(478600001)(6512007)(6506007)(53546011)(26005)(186003)(2616005)(82960400001)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElERGhiS2lyWkQrK1FYaE1yRUkvMzlPbEo0UmhzNTZFNXlVTHlCeU1INTlm?=
 =?utf-8?B?VGZNT2tJWmJoZTZDSnVpcWpWalFKTHlPcW84K0lvdDNmMDJWR1hPWno0VHNT?=
 =?utf-8?B?eWdnakMxRENSR29lWjhZZ1B1dVYveUVBYUNEa1hRT3Q1Y3J0RHRJdnB3VGtm?=
 =?utf-8?B?NzJmL0p2R002S0hXQ0VqVmt1dzBVRVlTazBDTFArZGN0WksxKzlqMytScnRR?=
 =?utf-8?B?S0pYUkQ3QmZjQ3NpUHdUVkNTcUtZUmdMYytlNGs2ZnRKaWExU3JDMy9aWkxN?=
 =?utf-8?B?Nm9OQTROWFZtQUpucmExbTU2NEgzeHE4QUVuWnJML2hPaVo1R0haMWd1SEJK?=
 =?utf-8?B?K0g1NisvQndQSmV2RUt0Q3dPLzZ1dDZ3emFuMGFRSXcrR1lqbDJ6UDNZcHlk?=
 =?utf-8?B?U09aMElHdC83ZHpqek1xWG5WRnZua1VsVDc1L1ZGK3ZRMnN5c0hhOFd2bWlw?=
 =?utf-8?B?Y0h0c0s0MDlmbDJvc2FzcDRENDlxdGRIM1l4N1dOZk1mQnZ5YUsxRmxSYXVi?=
 =?utf-8?B?M3FtRkNKS3lKYXBmVW10VFA5bkpRRFl1S3RjZDdzWThsUjEya0RlWVRkb0Js?=
 =?utf-8?B?T2FUREhwV0pMcEY5R2tYeE4zek9TbHh2QXlDVkhRT1JBVUFLWmhieU9CeHRP?=
 =?utf-8?B?VGpBRmhuNi9kZnhvS095c1grYlRmbFZ3cHZJWU9ZVjNpS3V0L1VILzR0djZ2?=
 =?utf-8?B?Y3hPQWJNaEYvaktSYTdIemdRb1pQNlJsMXFaN0QyWnk1MG5GK2ZibUNYWWtw?=
 =?utf-8?B?SkNnODdtTGxJRm1XY0t2MkVuZFJ3cjIvd1hkbHJieWdBUGd1SWY0cThNTWdj?=
 =?utf-8?B?N2Nma2pWWHRsVXRTZlU0R2RnN0lSTmY2OG92cVhRREg1Q2d6bkNtU013NllG?=
 =?utf-8?B?WTJsRVlRWnpJMmRTOTBRQktCWEhaSE90aWo4VXRiOVFFMXhTVUFMRy9rc2NG?=
 =?utf-8?B?Qk9pNldsc21Ba0xPS0hVRXYrSldxMnpHcTlrelJUNndXSFNlb0JEVkFNcG5X?=
 =?utf-8?B?OVlEMlFDNi9aNmlyN0wwZTBVeGtkQ3pRN2Z6VXVRWkxCKzA4VS9MOHJacUIz?=
 =?utf-8?B?NnY3TzJ1MEJwYjlXOXFrTWhGM0lLa1hOdnF4cWlOZ2ZoTFpJNThHYzEwYXJa?=
 =?utf-8?B?WmRNd3ZjN3ZWbE94c2R3QXdBL0ZFMUxPNHZ0S0RJYkNrTGRqQzMxV3QrNGp2?=
 =?utf-8?B?cTBVTnl4NjN0Zk45ZStxSEI4NkFqRVU1V0RydFNsUnFRTExpMFdyYWtSNXhF?=
 =?utf-8?B?SEloWitkaVg1Z012MVpmUDRhQTNadDY3c0NOaDNkaXVGWlgwUzJjSjZxODJq?=
 =?utf-8?B?VlRGL0hrbjZlZGlBdFFud040T0ZpVFN2ckVsUW9BZlRmQmJtdFVTM01HM2Ni?=
 =?utf-8?B?ak4yeEVySHhrV24rajBlRVFCbE1lS3Q5YlJZaXBNaWNDMnNlOFgyRU9Rd0dZ?=
 =?utf-8?B?OWorLzB1Y01pTW5xZXRGZkNUeDFxOWZ0SE1XK0U5Sm9rSkFmMXRTV2lpYWJh?=
 =?utf-8?B?aWRXY2pKcjEzTUFvS1VHcUJ1MkwvL1VNaG93RzFlTGw0KzB2V1IxamRaM1lJ?=
 =?utf-8?B?UzNEbGo2K2htWE00SDJXV29EMDV1Mkx4Q29xNlFkSmUwRHhud3JuWVlIaUk0?=
 =?utf-8?B?bWF6QjhjNFlGZTFDb29nSUcyWmxsS3J5Wjl6RDNpbEg1RGpJYjNsWEhQdWF5?=
 =?utf-8?B?TlFnUWdMdnNBQkJEckNZc0V2d1VJUXIvY1N2NXdHWmtQOVFXZUNDTlpYWkJn?=
 =?utf-8?B?anlmOWFxbUcxRHpKeTVmYVA3eGpURk1EaWVqL3JSYU9Hajd6OTQwL2hwZ2hy?=
 =?utf-8?B?WEhaaURZTGdhLzFjNnlEaEFlNm4xZ0R3WUV6OU5wN2pVZk4zSmx4aVlTSitZ?=
 =?utf-8?B?K1QrclJVMFUrQng0bzN5aEs5MkJVRGxYS2JzQ2dWY2NNdnZzaWdjcURSdzhH?=
 =?utf-8?B?UHVSd0xEcytXdk9zMTJRL1FMUDJYNkF2akN3c2pRdWhNR2RRMmRJSExmS0k1?=
 =?utf-8?B?SkpVb3M4Uk5vWHV0bGVnOHpmOXNtd28vZWI1SUw1Y1lleFFsTXU3NldBdHJ1?=
 =?utf-8?B?TmU4NEtqQi80RW40UDBFWUg1ZDhZdit5K0kycVY3dDgrUjljWGxLT1l4cmxy?=
 =?utf-8?B?amYxaGR5eTJCQUNrbkNiZk5xa2JzcG40bHlRV3A1T2JzNGt1Rm85YVo1T1Fa?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b020ad31-7f40-4011-5ca0-08db0f926670
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 20:22:46.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GDU2I9F14/frZ6WS0yt1xUFAz5nbEjvHwKvIS8Y6iYjaRERyx1wXiq9/WQ7NVVqbfJCykJwYZtjqpdb2Mec+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
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



On 2/15/2023 9:11 AM, Dave Hansen wrote:
> On 2/15/23 08:58, Dave Hansen wrote:
>> On 2/14/23 15:44, Jithu Joseph wrote:
>> I'd probably do something like the attached patch.  It gets rid of
>> 'data' and uses sane types for the bitfield.  It does away with separate
>> variables and munging into/out of the msr[] array and just passes a
>> single command struct to the work function.  It doesn't have any
>> uninitialized structure/bitfield fields.
> 
> Real patch attached now.

I did try out Dave's suggested patch. With few additional type castings, I could get it to work.
We can go with this. I will incorporate this while posting v3. 

(Will await a few day for additional comments before posting v3)

Jithu

For context, the functions under discussion incorporating Dave's changes would look as below:
static int do_array_test(void *data)
{
	struct ifs_array *command = data;
	int cpu = smp_processor_id();

	int first;

	/*
	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
	 */
	first = cpumask_first(cpu_smt_mask(cpu));

	if (cpu == first) {
		wrmsrl(MSR_ARRAY_BIST, *((u64 *)command));
		/* Pass back the result of the test */
		rdmsrl(MSR_ARRAY_BIST, *((u64 *)command));
	}

	/* Tests complete faster if the sibling is spinning here */
	wait_for_sibling_cpu(&array_cpus_out, NSEC_PER_SEC);

	return 0;
}

static void ifs_array_test_core(int cpu, struct device *dev)
{
	struct ifs_array command = {};
	bool timed_out = false;
	struct ifs_data *ifsd;
	unsigned long timeout;

	ifsd = ifs_get_data(dev);

	command.array_bitmask = ~0U;
	timeout = jiffies + HZ / 2;

	do {
		struct ifs_array before = command;

		if (time_after(jiffies, timeout)) {
			timed_out = true;
			break;
		}
		atomic_set(&array_cpus_out, 0);
		stop_core_cpuslocked(cpu, do_array_test, &command);

		trace_ifs_array(cpu, *((u64 *)&before), *((u64 *)&command));
		if (command.ctrl_result)
			break;
	} while (command.array_bitmask);

	ifsd->scan_details = *((u64 *)&command);

	if (command.ctrl_result)
		ifsd->status = SCAN_TEST_FAIL;
	else if (timed_out || command.array_bitmask)
		ifsd->status = SCAN_NOT_TESTED;
	else
		ifsd->status = SCAN_TEST_PASS;
}

