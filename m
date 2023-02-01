Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE7685D53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBACZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:25:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E51351B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675218310; x=1706754310;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FEv1AlvbuB5q39GEhuE7RZmxe+aOjs6U9rvpf7vNmDQ=;
  b=a/N7I4chn+vGdFO33/rHOKAa6L12Yx92dEUkmZLqePIJFW1y7+jo9f/0
   Mwy043iFb9oSTIAovnevIZxwVW9idJrQ3Hf+8uc9dkONR/sQb7MLTbPNg
   GQvJQDR/6K2aDYkAvb91sOVPV/vym5kvm/Ws9bbFLvrWFrRVWqNmMMlW3
   FsHttjIte/k8v2MpZH6EeKeHDny0VHnJvVmngTLElyHzEJBAeRtCcrnx8
   iuwNCHIoIjkKEnjbOj6NAW3Tz/UxDQmKkWCuIO4wE+xhWLtasFwky1S4l
   MQLGk2+vLX3bSkgUdKcbiPVhx6BmJUc5P0QI/AXySi0qB7p0nCNnIzA3l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325718747"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325718747"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="753445626"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="753445626"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2023 18:25:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 18:25:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 18:25:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 18:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmQip8NC2KRO6ZFg46OdHf2HCE4KnINeX2/JSrPO6iaDMrrMFotneE9Tjovbfmi04I6JqzqONrghVBjQ2+OYoMf9Q9IKNN8y9R3gzHei9Lpi7AC47PDng5sy2Ribs5AmtlBKLn/VXd/jphPGMVuJOyuKhT6iJ/wNcjPkOYTmJJGNF4AHIM0QaJ6x5reDTlZ+21C0ElAt0LMAtEf8IfC2OErmOUFsWldvTvFHupkKBtvRbWPMLbI7x1iNGosI7GsSbziQPgEViBvyn04LzaopAT5KIFWdegFQss/mDcaPHyIzg8LpJaCCgqgiRlyIWe8SbiAy+LAu3GWzHKmgRES8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ahBM2SyfowRJc8cYaJxiloJ/Iehdc3lLAI/rakfZlU=;
 b=nfCOcgHM6k2gavyAwJUJ/Ma2YQ516on1NtCva9dV6H6die9FHr6PjQhL0i+XLRxQSPM/GeBnBEWfjKcKmZi7ZOQv5cdjS0U6cdMsFiF3C0PhbGXA1JmiBe0NZnnrRNdycQ8dR35/Om818wotxXE5hg3XTFKDS3cEykoRqMwgBC1qfg1uLAfjRDqeuz61vZWIB8NC+LJhrQIUuXXOyS51Ifx91kG4kPjdILXWtIsnJhVEz7iAQksK/R9F79UiUXIs/AcIu1mvTEgTP9mW53G0CFPaNRZQh7LXM0MhA4pH3Vr+MILfXboUrNhf+L2uxac+zNKy0GexLsE9bmO7C6IyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 02:25:06 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%5]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:25:06 +0000
Message-ID: <ed41ccf1-8f2d-6d4a-7692-7a3465aca73a@intel.com>
Date:   Tue, 31 Jan 2023 18:25:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Chen, Yian" <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
 <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
 <9e0a8b20-cb76-b06d-67fb-f8942df5a2f7@intel.com>
 <f8352c29-6b9f-2711-ddf4-223a6806f42f@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <f8352c29-6b9f-2711-ddf4-223a6806f42f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 96137740-e416-42e0-38f7-08db03fb8827
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMg3qogyokFfHJks3ZeyOFomqLJpHNTA3aouY9wpv9Yo4oI5li170QGyq3Wo6CViHH6NkBeRFTgCeBkggsrJ2S7BzrCkOBovEr6WSXWPiccDrTjFE2b8Z1tpbOQb6wmYBPwOUzAn5SamFD7Ih30Z93ZnZOxgaKY5KQapYQisMsbNecPuT5wY56Y8vUqiCcWHZNSptVmtSRTLkyT1so5xvUkYaDfEHLX96svZ/SHDhSPe2R/LkiGk8RoH2u4RUAA5zqn+WLiy0pBtkQFJ2JyGkh1u0OZXlvdtCgoCk91y6tMNalUFUcUy66NYPZrAWk9iCjOXtg13/BAPxqnuVfMlES83JNu3oz6LYTnoabvo3zxgtfe8mARF023iscM8BX+4nntmEcBIIUbYkm8Er6lww9O/x9wttL+UzLY5GuC7vJm9PTo+WqqnvSWVrGF36wTWsdLtnopYC3nMXrBiY6nMwnfWuVIgKZ9kiML/ACFxFyDLfp0KF09d9ZT2H2k6N0cAzOxn+TMHbktbQ/PciFqCszZatMEG71wJ5rqM1PWa2mXye7EnDC/oAmtCjG5Y3mx6ka11o4BTuh6MA6h1ZzbdATGU6BupGzy3tia/deJWDVu8oJbbDFXGs9rUcvg87gJ4DM7kmzftiirXA4cojPhP8mIR+kStw2N2yOgInrIEMNYX88e+zCGGF7ENgvF8+0HI21dGZzTE6svMaCod/OJBORULOsJDpzbJxi/dGsxJdAgzxwv+ekMkJipAOhyqKAWq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(31686004)(2616005)(316002)(110136005)(6636002)(36756003)(83380400001)(44832011)(2906002)(38100700002)(82960400001)(66556008)(6506007)(6486002)(8676002)(66946007)(53546011)(26005)(6512007)(186003)(478600001)(66476007)(86362001)(41300700001)(921005)(8936002)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01qSEQ2QTNTb3lFNEdrS3BaSDZqOWJsVXlFN1pOdGdWUE4ydTk1Y1hkZVpT?=
 =?utf-8?B?N0NyYVJkNlBZdXRITGpOTjN3Slc5QmU1dzRxWitLWDN3ZGkrRFR4RmFKUWxw?=
 =?utf-8?B?dzI4QkNqeVEzWUo5Q1hqRmNaa0RDMFBuQzI1cWkvYjVucHk4WXBxRXE2eEhl?=
 =?utf-8?B?dlRFVHhMT0Y2RW8rNmRjb1FNZjBwa2h2L2k2UGJOK29hZkF2dGJPZ244NHQy?=
 =?utf-8?B?aWVpckF1ZlFwa3JEWjZNZElWaElNbzljM1lGcFgyS2kvbk9POFJxcHR1TkxK?=
 =?utf-8?B?VTNoaUUvTCtEOWgwT1Fmc2dITjE4RFlzSUt1UjdjdENUbERWQitZeGE3RHlk?=
 =?utf-8?B?aExZVitaTXd5U1RuSmJhWXcrL2JtY1YxVmltRkpLMk5CT0tkUjZQS0ozMy9D?=
 =?utf-8?B?VDBEbDlYZm05S1lCdjNMY3A1eVh6VmpsZVRhZTlLZlB0RmRidGEySFB3TWtS?=
 =?utf-8?B?alM4K2Zpam1oZUVYYWhKLzhPMU50aU1KZ0UwNTMrWVZSOXRiU3ErQkxXVGtV?=
 =?utf-8?B?c3hVQnowSkJYRlRyUlhNMG5KQXhRdDcwQUcydm8vc0dUdzNYVHUrekZkc3V6?=
 =?utf-8?B?RHVzYTZsVHlsd0RSL3o3Z3BCQ1JySHFVNTlRNE9OTE8xYkNhMlBySEE4Z1BR?=
 =?utf-8?B?c1daZmtDa3NxQWwyZ2Z2MXc5N2hMNDVmZVZlemp4dDJDV0NPdkt0ZS9hTURi?=
 =?utf-8?B?ZDJLeERGNGJpdUxFbVo0KzZNZnhmNm9lczhMM2xPRUljcmZYdUtZaFJ0UjBU?=
 =?utf-8?B?WkE3QTZKUW5PcEgzdSsvaWc0ZXhrcEVjSTB0djJuampFZkZYaTF6SU9KRmNZ?=
 =?utf-8?B?UW9JV3ZHRHRROU94VmNGb25SNTB6aHZSNFEyNzh6WnF5aDhYenJFRFlxSVpT?=
 =?utf-8?B?L252RDBJbGlFNlNiNnlKd2pYNy9pVTVqL0RNT0NTeDFMUDVSR1ZCTC9kUDVn?=
 =?utf-8?B?TlVZMTlvUERsZEpEeHVia09XcnlXNC9QTGtESVRWcU9yVXNzSVRUM0VDaG93?=
 =?utf-8?B?Rm5HcWpmNXZXZlgwdmxpZE9abm00alh2WWtVdDM4cWsrd25Xc2J0U0JWUGw2?=
 =?utf-8?B?L1RuSC9vVDFmK2srTks1dm9GM0RYeEpyRk5DV1lEbEx3UnVlVnRldys4ZUNw?=
 =?utf-8?B?eDV1V2wraVVzZ2JpWjFTcVp1ZzNEK1RyWTJxOTdFbDRBa1AydGxEeGlKN2Rn?=
 =?utf-8?B?azhZOExwd2FsMTJWMzZ6aE40SktiNEtzN0gyaEhsbUdJVUhPWFlBNDIwZjNI?=
 =?utf-8?B?NEVwcHNoR3pMczF2dHVwSGtwOEF1ZXhFdGxzcHI5V3dtdzQ4Nktscm53WExj?=
 =?utf-8?B?ckRyWjNhNW1YbkRHMjZwQ2VLbDlJdzZhOUlqOXBGc0s0NEhQYiswTmhvVjJI?=
 =?utf-8?B?YnhSK0F1YmM0b0xRaENRamhUYVZyb2piVElHZzA1L0pMUU90bjhOdTZJMThG?=
 =?utf-8?B?ekU4LzNHcWRCSUhBUGRqWVJhMml5cVVhSlJzc2UzQnZlek0rT2lVL1BNOGFm?=
 =?utf-8?B?T2Ntc3NzODdoYjYwNGpKcHZqa3I4aWFhNHpzL0doK1VSeVRhcmUwaUFURC9S?=
 =?utf-8?B?YVY1V3BqeEVLcVo4K3NlcWVrSlNQM1N3bGpQb3I5bncvcWl3MjZ3TXI2disz?=
 =?utf-8?B?MTYzWTRXT2JXZFBoRDgrbzNMMDlrL1paWU1wekR2ZExxWWYxSGZUQzRScEMr?=
 =?utf-8?B?NzFLT2w3YW9SRmhReEVjSGw5dm5jUno3Y0FlbFAxQ0dVUXc4d1MxcTM1KzVQ?=
 =?utf-8?B?bFFCQkRWNjlQMnpYOEIwTCtFQTVpVHYwTThOT3VSQTVZRVpkUzA0WTF5S3o3?=
 =?utf-8?B?WjRXN2cyWE9mcGRUd2xSdkVqS3QzeHlLVlp1QytoUjZNcWRTL1F1SmFMVDBX?=
 =?utf-8?B?YzVHMDEzY2RVcFFyd1VsWHc0ZkxEanlabGtNQzE0TWZpUXVtWllXYy9CaUsx?=
 =?utf-8?B?Q1FVTTRLK1puL3BlQjJNVXJFUmU2UHQzSzljMmZZKzUxM2xjUjNHZHhUeXJZ?=
 =?utf-8?B?cEljWG5uSURMWHZvOXR1eHVrSnZRM2lVcU9aRHNEN3RCekJtZ0NNbmdITVZt?=
 =?utf-8?B?Q1pGTWZSb0dlMXhlcFNlc2FXeVdwRFRWT3dpWi9RRXZQNGhLa3loOEhVODl6?=
 =?utf-8?B?cU1ZY3o0MTlvU0JrclV2UXFKRXhHdDlmMUlRRjd1UEl6UnhHSm04dnIyOWhr?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96137740-e416-42e0-38f7-08db03fb8827
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:25:06.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeX81wUz7CRlajReR4JuuJvSZdw2kno9SM3i9EPOpRtkeC8PccQu1SrisSPVpyXpTw4SGWuFl2w/H/E0h49HQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2023 10:48 AM, Dave Hansen wrote:
> Also, Andy Cooper made a very good point: when the kernel enables
> paging, it's running with a low address so that the instruction pointer
> stays valid as paging becomes enabled.
> 
> But, if LASS were enabled and enforced at that point, you'd get a LASS
> fault and go kablooey.  Can you see what simics does in that case, and
> also make sure we're clearing CR4.LASS when enabling paging?  That would
> obviate the need to do it later in C code too.

CR4 and CR0 are always restored to a known state during kexec. So,
running with LASS enabled should not happen during early boot.

machine_kexec()
-> relocate_kernel()
   -> identity_mapped()

> 	/*
> 	 * Set cr0 to a known state:
> 	 *  - Paging enabled
> 	 *  - Alignment check disabled
> 	 *  - Write protect disabled
> 	 *  - No task switch
> 	 *  - Don't do FP software emulation.
> 	 *  - Protected mode enabled
> 	 */
> 	movq	%cr0, %rax
> 	andq	$~(X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %rax
> 	orl	$(X86_CR0_PG | X86_CR0_PE), %eax
> 	movq	%rax, %cr0
> 
> 	/*
> 	 * Set cr4 to a known state:
> 	 *  - physical address extension enabled
> 	 *  - 5-level paging, if it was enabled before
> 	 */
> 	movl	$X86_CR4_PAE, %eax
> 	testq	$X86_CR4_LA57, %r13
> 	jz	1f
> 	orl	$X86_CR4_LA57, %eax
> 1:
> 	movq	%rax, %cr4
> 
> 	jmp 1f
> 1:

Dave, does this address your concern or were you looking for something
else? Is there some path other than kexec that should also be audited
for this scenario?


