Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0233B64E0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:27:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84A49B6F;
        Thu, 15 Dec 2022 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671128827; x=1702664827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZziSYZlIs1djsDeyqO8wfqih26P8V/tIc2dUpp5EW5o=;
  b=JPrIpYW8ds4CdYncUF9nDTZPZn8RLxQyp0bSdYdO9JeAyb2zu+yX5Fh/
   iOc0mcEfisYQyMM2LbYQ6Z3hPu5ZbxT9RrnWUpg2YLeRoyGZaCX6vz98a
   No7A7YT7gKsEHrCI5vn2gkhzNWxWWh9w816gLkKfaizQywKyd5bGwykIQ
   1pFGmM1B7Tt3MbdAr3b3Xu1VSNtfhyRK0VMMM8Gc+rj2ijWp2wfHAc5x0
   fpfHyUbKSrYjxE/PFYhvn246uclt7VIc+KebgB6g8DY+GyhitwH2u+atE
   7ykIYYDtLt3MCbGO5aqjxlQZCXM7UMxByGoEFMX/tAPUbSJGd3Z9+c4XK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320648809"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320648809"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718102756"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718102756"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 10:25:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:25:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 10:25:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 10:24:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGxVMnVOn0fh5qzWOzhojgvj7OC9GoySYYf8xBkPaUPBgTnvQpPrGn5Cy+PRjPdyIj8AEiAGF642uXPlqthYQuibHbrtlIpT+4DpgCNbLomk82mvedNp1gvfMJ5MNVHw9G2iI6HHi8OCzjc/Waxu55AYKzFXN3grQ9oXSMaE6AOCWNQrJuuTdKjSJgMY0zd/L3f7qiDIzsUP/l5ShRrHvmbDzQ+auuBbZt5iutGxP+bdSUUuNC67o0tN7wImMmlukCWJIb3XT78ir/JGu0Is9vM9GBSuF4tLk0GlLmKwKfISkaYl4ryL4wOePn+OXpAG3EnG9zfQru5Bq9bfj1KM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot93zp5ITifI5+v3mqn6fJTTRzv8b9FlNtI7Q9CehPM=;
 b=fo9Ini4a70m45EGqDOc/gk/gOkA7ThGlalvVlAxxX7aXrC3AjYRg4YdjGmNCR53aN/Sr7Qe9OW4kbI4q22ormOb6pb3eP+nMGo5ymYpJyFeZjYK4acYpR8aaDdn4l3ngRBmfZrMgCHmJ/M7qfQVzTsPo2XoFuKcHmUsQ/rVE3PmZWNRb5xDFowb9Prf8dgvd7lrK+Vk+R6WnikkqgUCJI3wVoF/aCnEQUF6UBxQ693XsaQWLKDnYTszwBs/0xJAX0RmJNT9FzZ225fEk0800sw4z5/CiADAzEkP/pMw0ikvnyaet0EBefCcpJnSsWXIp9jESOblP4P+I32z7x2CyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 18:24:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:24:48 +0000
Message-ID: <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
Date:   Thu, 15 Dec 2022 10:24:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: cf727a76-0fd2-4901-05a5-08dadec9a643
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhYj/I3iOLWwporz+idi7+L6g6opIj2LPuwYAguvTzj0jA2Ovyp6QiIwFwOy7USQDMrrOeHS/80VBcJbhnc+FDb9rpwbglB84jAyO/96u10EjsTi7WXLq/G9nD6UIcIg930Rx2dmYRIrN2oQyB+zrLjJJ7FSREyDoL+4HhIBRcLpASRHORc2FLdDWhhGxbt2nrx1KZ9jta5Y7WeMuVwf5T2H4zf8JdPyndcxjCO/Wgf1PBmCo0EWRkf09NUe0NkcryV/EHhctYC5XN9JiaITRP8oG+4m5cjLizaaiXFPdZaoUc72B1KYAjkE/y+RHnEjDnKpleurn5AkFSUv1E37PIjvWirpbp23EMR6iV7w6Pyv8yXiWfxcvu09n6Gd9JGMmArBiCafknD8Yzky5r/PITE9QhqdqyX2DH26YQ402Vc9lp5/WElOc6aoIr9dXPmK5c25P24ohalXvSKgjcFbAaXNpnBSox5RCxMGKlHr4Lln3a9JakAYVYAmJLB0OPDDvA+SoknLecL9SIrAoVB7gppqehCwJUW542HFX1Jenorz5EoF+TQWK6nP8TVKrn/VV3IbvfG+e4LTAB1W9MzqcF+bAfqui8qLP6wHTu9o22LkIInOeCWKIjj6KzXXWYDQFE1afUmFupVIYd5yvXDpfzgybWfgoEwswEsDzgVW1SscON/kz5a3gkyMzXJim3mkNddyZpryIfSSYs2qcmPaxsDUvDy3FEkOK9fDUfeH+fzGjbAy4YfIVjrwuyO09kA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(83380400001)(44832011)(86362001)(31696002)(8936002)(82960400001)(7406005)(5660300002)(38100700002)(7416002)(66476007)(66946007)(4326008)(2906002)(66556008)(8676002)(41300700001)(26005)(6512007)(6506007)(186003)(6666004)(53546011)(2616005)(316002)(6486002)(966005)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZGTTZGVng5UzBJc0hIU2RaQjF3RHBIMWYwL1VqbW9Vb21YM0hLbkNlY296?=
 =?utf-8?B?YTlzWVVHNGJ6WlZQcDJ0dE9ydjdDSFRJRUhVdHVlSkdCZmZsZHN2bzNEYnNW?=
 =?utf-8?B?dDlFQklEOGVJSCtuYnYzdDUwQnlTYnpQdnI1a25xUVpPTXltaGtIQm84NDRk?=
 =?utf-8?B?bXR1WG1YL1pKK2hBV3ByMDlpUEgvaURDOFo3QXhRZ3RaMzkxK09GY2FZdzd2?=
 =?utf-8?B?UmJqM2haY1hhWTBPUVVzU283aEtiU0s4VUdFS09hZ0hzaXBWS3EvTU95YVhB?=
 =?utf-8?B?VUNMOEsvUkhTbVR6YXNINHhQbUNWQ0V6OVhnbTRibjk2NStBL1ZERkZ0TktD?=
 =?utf-8?B?N0JTTHV6cC9XMVdHZ1drRnIvVkVsZHVKdEI1UllINjdvZkJZMXNCMlc1WHdl?=
 =?utf-8?B?NlkvWnczWHdDYmJtTC80ckpMT2pTQWFzWDVMVEc5VE9jSyt6WW94M3hHN1RM?=
 =?utf-8?B?dDNKaG1mclBaY1B1OHNWSTlpamxUSkdwaFVYd0Fvb3V5S2pOcGVhWXBPZXh2?=
 =?utf-8?B?QlVxWDJTeE53Sk9rait3cHhXOUJJLzFNb3RheStBeVZwZW9rUDdOTlNibG1O?=
 =?utf-8?B?eHJaempJVmt6VHFMb1ZEbVZLQWV5M25uWmZzQmRBeEZuRFhYRHVGWHZ5cUxl?=
 =?utf-8?B?VjBRank4WEJXQkJZaklETldkM1FVUXZxclQwSkc3TnpZaVIyKzRJUzZFN1Ja?=
 =?utf-8?B?YWdEV2hadG5WczcxRTNiYm9mRkhiZHBEVTg1WWwrUFBhcHBmL2cxdUpMWGlz?=
 =?utf-8?B?c1FnWDBVRUJXQ0VtQ1dDM1g2YXVUdlllZ2NTTUxNOHJOUzI5YW5GcmZtNVhr?=
 =?utf-8?B?ZjdkMk9pREJjRjFKclMweHk0UERQMm9nbit0eThsSGdCQkhsaUE4R0tZZFJS?=
 =?utf-8?B?UEdXTG5UaVM2SWRSZjRyNjlqZWk5SkY1c3JCYVVodjluSytscEoxcGgyd2Uv?=
 =?utf-8?B?SHhweHY5K0E3Ny8zQktrMjdlRzB0SXJOY1NWOHI3SW5wTlVkcy9LSVVTcEtG?=
 =?utf-8?B?WWJ2NEtFVC9TMHdwN2ZSR0YxREprbDg2S2VUYXFxQTc2VmtPcFlmN1hXVytS?=
 =?utf-8?B?VVBlSGZkbkdnY09qT0UyUXBDVVQ0UktWMElrNWJBSXNXVHlRSU1WemRWaHhR?=
 =?utf-8?B?em5yWjBObDBobyswSmovc3diWlVhakc2dlExUzhmOHdUQVZDM3BxSmxrS2xo?=
 =?utf-8?B?T094STVPY1FNbHpXaEFMWThzUVRXRlJZVDNWUm0wVGpLWE11WjR1OFlyd2dl?=
 =?utf-8?B?bWF3bVJuTTJBa0FwWVZ4RFlGMDRTdGg2ZjVOcWprVENQQ01tc054ek8zNnd0?=
 =?utf-8?B?RjUrUHZEdVFhZHhhZG9FSjJzdzVPanFGY2dGQ3NYR3F1VlFiclJJMmpnNTFk?=
 =?utf-8?B?S2VzNUdEMkNBUWNWQ2lkOVMvRFNPME5TUmZ4Z0ZZV0pqMzdzRXVzRWQ5WDdX?=
 =?utf-8?B?dDY5VWpaZ2E4YTBHMGp2cHp3eTdTbXRwTmhHWXExOWtwdmgzUGpobFFpSVBz?=
 =?utf-8?B?VVhOdnBxQ0EzV0hpM3NDcUE4RzgyVGl5Y3pud1hCbzhoSzBZWWdDYUR1R1F5?=
 =?utf-8?B?ZkdzOHFnTXB1MjRDdHVCS3A0UFFIZldMeTc0UGVUU3JHUm82S2ZGU1lJQ1l2?=
 =?utf-8?B?SFZERVNJd2UrM1NQaVlHcnNRNXZIL3hxK3BYYmtkR0F3MUZiTUg2VGptVFFX?=
 =?utf-8?B?dklHa0JLbWhUaWV2RWoxQXhXOWhWR1kwMm00a09TNFIyU2VzTWNEVkFudzBm?=
 =?utf-8?B?eDJRUmsrK01IY2wwNTFBZnl5aHh0bVhVYi9yZGtTYk56djgrNzMxblRPU3lV?=
 =?utf-8?B?NzZGNklmNDJRNG1yK2xvaHVSS04xSDBjYURlNnZ5WnRydGFrQWRmOWdQR1Nq?=
 =?utf-8?B?M0VEdlQrLzJ4TDVqdG5jSnRscGJoYzNHSEtMSzduNUZNVDB2bjZReEVHTG1O?=
 =?utf-8?B?a2FvNDN4clgxTEdvWGUxa0trd1BjTW1EYmc1MVZnOVZEcDZWRkZpT0g0N2JG?=
 =?utf-8?B?SW5rU1hNYXZUdFk4dkgvbG5nZklTRDk3ZXdZYzIxQVNYcEFybkttc2MxVkFo?=
 =?utf-8?B?WG1CQk1jMnpybTkwUjBZSnA3dFdzWWFIcVF6eHlhUlgzb1BZMFVRTG55UmJB?=
 =?utf-8?B?OWdsQUVlUm9KRFMwRy9pUUpWbHo5MHR3Tlc5MTRNVlBHVjlLTjV2alA5VGcx?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf727a76-0fd2-4901-05a5-08dadec9a643
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:24:48.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR9xkxdQLAphNHfE/f5CWv+KUD/Zt/ErhFMxNhJBA+0Qa7vNHMBLOmMswvRxYXEuVUXngIW72HGdps4kGZAwllme888OrQhmU6oACjBvu0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/1/2022 7:37 AM, Babu Moger wrote:
> The current event configuration for mbm_total_bytes can be changed by
> the user by writing to the file
> /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.

Please drop "current" from above

> 
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.

please drop "will" 

> 
> Following are the types of events supported:
> 
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> For example:
> To change the mbm_total_bytes to count only reads on domain 0, the bits
> 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
> command.
> 	$echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> To change the mbm_total_bytes to count all the slow memory reads on
> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
> Run the command.
> 	$echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c  |   13 +++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  127 ++++++++++++++++++++++++++++++++
>  include/linux/resctrl.h                |   10 +++
>  3 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7c8a3a745041..b265856835de 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -176,6 +176,19 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  }
>  
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +
> +	if (is_mbm_total_enabled())
> +		memset(hw_dom->arch_mbm_total, 0,
> +		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
> +
> +	if (is_mbm_local_enabled())
> +		memset(hw_dom->arch_mbm_local, 0,
> +		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
> +}
> +

We learned a lot more about this area after Peter's discovery:
https://lore.kernel.org/lkml/20221207112924.3602960-1-peternewman@google.com/

Since this is a new generic function it should be clear in which scenarios it is valid.
Could you please add a function comment that warns future developers about consequences
if a new usage is considered? Something like:

/*
 * Assumes that hardware counters are also reset and thus that there is no need
 * to record initial non-zero counts.
 */

>  static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  {
>  	u64 shift = 64 - width, chunks;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 580f3cce19e2..8a22a652a6e8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1517,6 +1517,130 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void mon_event_config_write(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 index;
> +

index does not need to be u32 ... mon_event_config_index_get() returns "unsigned int"
and wrmsr expects "unsigned int", it can also just be "unsigned int".


> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		return;
> +	}
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +}
> +
> +static int mbm_config_write_domain(struct rdt_resource *r,
> +				   struct rdt_domain *d, u32 evtid, u32 val)
> +{
> +	struct mon_config_info mon_info = {0};
> +	int ret = 0;
> +
> +	/* mon_config cannot be more than the supported set of events */
> +	if (val > MAX_EVT_CONFIG_BITS) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Read the current config value first. If both are the same then
> +	 * no need to write it again.
> +	 */
> +	mon_info.evtid = evtid;
> +	mondata_config_read(d, &mon_info);
> +	if (mon_info.mon_config == val)
> +		goto out;
> +
> +	mon_info.mon_config = val;
> +
> +	/*
> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the
> +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> +	 * are scoped at the domain level. Writing any of these MSRs
> +	 * on one CPU is supposed to be observed by all CPUs in the
> +	 * domain. However, the hardware team recommends to update
> +	 * these MSRs on all the CPUs in the domain.
> +	 */
> +	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write, &mon_info, 1);
> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared by the hardware. The
> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> +	 * every RMID on the next read to any event for every RMID.
> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> +	 * cleared while it is tracked by the hardware. Clear the
> +	 * mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	resctrl_arch_reset_rmid_all(r, d);

If I understand correctly the expectation is that when user space read counters
(via mon_data files) right after the configuration was changed then this read
will return "Unavailable" and then the next read will return data.

If this is the case then I think a snippet about this user experience would be
helpful to add to the documentation.

Have you considered doing a preemptive read on the RMIDs that are in use to avoid
users encountering "Unavailable"? I assume doing so on a busy system could potentially
involve hundreds of register reads/writes.

> +
> +out:
> +	return ret;
> +}
> +
> +static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
> +{
> +	char *dom_str = NULL, *id_str;
> +	unsigned long dom_id, val;
> +	struct rdt_domain *d;
> +	int ret = 0;
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +	id_str = strsep(&dom_str, "=");
> +
> +	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> +		rdt_last_cmd_puts("Non-numeric event configuration value\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (d->id == dom_id) {
> +			ret = mbm_config_write_domain(r, d, evtid, val);
> +			if (ret)
> +				return -EINVAL;
> +			goto next;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1617,9 +1741,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_total_bytes_config",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= mbm_total_bytes_config_show,
> +		.write		= mbm_total_bytes_config_write,
>  	},
>  	{
>  		.name		= "mbm_local_bytes_config",
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0cee154abc9f..e4dc65892446 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -250,6 +250,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  			     u32 rmid, enum resctrl_event_id eventid);
>  
> +/**
> + * resctrl_arch_reset_rmid_all() - Reset any private state associated with
> + * 				   all the rmids.

It could be more explicit:
"Reset all private state associated with all rmids and eventids."

> + * @r:		The domain's resource.
> + * @d:		The rmid's domain.

This copy&paste needs some changes to match this new utility.
How about:
@r: The resctrl resource.
@d: The domain for which all architectural counter state will be cleared.

I think it can be improved more but the above could be a start (please do
not copy verbatim but ensure style is correct.)

Keep in mind that this utility does not clear the non-architectural
counter state. This does not apply to AMD since that state is used by
the software controller, but it needs to be kept in mind if another
usage for this utility arises.

> + *
> + * This can be called from any CPU.
> + */
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  
> 
> 

The above hunk fails the "no spaces before tabs" checkpatch check.

Reinette
