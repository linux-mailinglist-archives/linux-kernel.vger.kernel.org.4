Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE85BB097
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIPPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIPPzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:55:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E415821;
        Fri, 16 Sep 2022 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343699; x=1694879699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N4F8OTlPDlg1ILM6xaPQk6FC+WgZuVOOvkrI4BipAP0=;
  b=WSUPs4fGVPMVnyIzXDkRhkeTb+nDG9y/ieIpMSqD6sBMXDbcA7lP4WeZ
   AaGY5+LkLuiaJ7yLs1ISkMMhrvnXVeizQt2FNGh9gC5M9OFqHuZlgyb26
   SRLZ1qgb/t2NJ7DGbIbrRLSQeVx8kf7lBgFT1xSA7XO+La9yu9oYlPNDk
   1TDbG7JKVM0iTZTt3lPvwz4jhdyp3Zx/IAmzg5ri9wov21vJOrvO5Gb1U
   28zblU24AwMoADLc4IfVed9ky4nZt2RSaL4MwRLafQSdugPNocXUqbhPm
   vV6Subu6leYIudp0kBycT4HGqI/UvhV276N6tWaSeFilgdL+vKY6oD5Cd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325294815"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325294815"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743381232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 08:54:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:54:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:54:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYJsF6w8MvZIg/jjFvBNV4SA2TL41bH9T/n+qiZdI/AYNhdHEXga1QdlVf5MT/WMyxsTyBFLoUfcZ/DpYFSr3zLxA/GlaV0NNZQMUlDunHbbjyddEHlgA83WnEHgpy2BlkkASZKkrwEKXhGV2BQ/IcEKZP6SS3g95uOifAYZ5E9Z4Uta4SlU6tdfoO7CVb44NTtr3W6SSCa8cznQP2pMVRCMdSJOxaQTXNFDta6trlQYPmDMa9zyB2sjAvMyFY10I6NWVK5+5zWzy3lx5uTJ3KliZxUkx8QvQl1pf79D+6N4JtkOQ98DXHnxH3H1u28/5ENcvaMbHK0vrcrPpy8T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4qL4XoNCbAnO5S8P/kFUBAYdR4VCELJcwa+RQuDTH8=;
 b=XrfU5cN2AsKT4HY+5CzIhd7AqLUgF2FS2x7ykOVJJjIVl0oV46hv1ZFes/zyyUXwdjlqem4tbXsd5+/Z4QnAoNMEcwWyu9Ffz7zvtDBUHHSwZ0EGIDhoxwlhzG7p0aQuMbW5r94rooD1EECrQaRywx0hoo/VWGpT2wZ4t/q1o+AVYrQmNWl1ABQLyQ79O7FHyDKlUeqUyeHlpifU6mqc7ilSGH1vdJiS6si+7qvNbf0RA3rhLygQhAOS8otxnzwAy6bYmLD3yXzTPlkK9KO8PNbAaqbnjOU9wK7n/+3Q242jqX4gazI2mHOskay/VsvaDWoQamo28dJhnl+lom6z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:54:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:54:49 +0000
Message-ID: <d57cd2fb-05b9-2c8a-1eb2-7310b80a5136@intel.com>
Date:   Fri, 16 Sep 2022 08:54:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 04/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257362752.1043018.4708265660824485482.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257362752.1043018.4708265660824485482.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: d07d4267-d4e9-43a5-8f16-08da97fbc8c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ooCgI87mOSm7jTblmJJWDil95Jzp/8qTWUw90kNKuL3f7Mp0wAMe0BN9HRVnCwb/F2YynJnFsWkd+xjvi4uXZvWIEKoIXD6AxI2fr8Vit9Gfa9xUPeTJiQPNEXoLamMJCiJAqKmAUqWXo2A7QWJhEQOmSa1VvLNLAo3jAxtQgPrGuu+KHBVD0G9eJBqP5GUrDY1dDbRrjLBfCraxM1HJ1jSrWADNT8paiEdQFHG52tJ99iigtN8n3EYwrNT85OMLYFw2NRPd2o8NHwbH/uEUnL1K86ojI3QQn6k9o26bm14PU1oU/zlnueVa/iSEFYf7cBgCUCfLtsor3v5Y/vPCoN0oTGLIaQF3lDtYIOrlvsRqbbqfh7Xa9lmYcfnvRkxoHyhE+T1Zh2fxXfKSJZ63yjKtNDrDNG02Xu74g0A8ivOxngncBZQUsmBosB4wFDI6gZZdPC4Q2uljcBo1MEIQNwBOhioU5/f6EVgajosm0WpS4kgVXQSyZV96Qj2Srv+Iyvyf5ca6FxcQBHt1qN/OGgCyKPqPF4GT+Y1rFi6UNWb5YwwDHZWG27uSuB5A1VKg6RJYiI2L0dfiepJvSd1fTyuvConu2CX3weIHg8eHhKq7uV09dy9RibZ/Dlmy9AxLzI5LkgatCfD6R4fNCes/7ZGgUgrJGVK4oB0x29hHhyzl52zr3rSgWqsfc7DMMGf6fB5DgSI5Ik21Y58sTcvQ8QKn+VauQbZ7+GS73Bx/Kaab4QF7BCY5h1OEXJzUnnsALddmc8Ofly8oJkg4UbFQQvsc+zpW+FnYYLZjDifzsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(558084003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(6666004)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3N3aFBjZ3BkWERMeXJJblBYWVptK3N2R1FEc0xzT1ROM2FQeFBLNER6cDNU?=
 =?utf-8?B?Q3JjVm1wbGJzNzJFazljZ0pkUGxzN1dlZDdEa1dONjFjaWhOZlNVbVdsMzNh?=
 =?utf-8?B?QnRxMTZNbWIwSTNMM2xZZCtWUFZDbTN2Yml1a1p5ekhxdHJOeGU1a2F1QURa?=
 =?utf-8?B?V1M1d2dvTCtjZW1UZlk4QTMwZG1kdnpnMGZXNG9vSVA3Wm5QVWJsbVkvODcz?=
 =?utf-8?B?M0J6eEJKWXpzNHNGNDR0NGoxMkNQSmdQZ1lDcEd4MkxrclNCcUZzVnRmTzVj?=
 =?utf-8?B?bW5WQW1lZFRTZ2hxaXd6cjdBNGQ5NXNTaUw1ZGdUQm9KWUF4YnBhbC9sdHFD?=
 =?utf-8?B?S1N2VSt0STFvaGVsU3o2REtWSUVlaUtOZHlOYjUxd05jZHNyUmg4SVZIUUUy?=
 =?utf-8?B?amFWbmNiai91Z1lkWXhyMGExOE1ReHRFTG1XT3FESzVUS2hLZkdqVWdjZWxZ?=
 =?utf-8?B?cmhOdEJhSHJLTlhPSFE2am9OMk5sT2JqYkZVMjNnN29vcWFjOFZQZ1ZDUTdQ?=
 =?utf-8?B?N3UyMlNmc21NMitMSmo3dkxmV2p0djdRT3R3dDlldi9FMXlqcFF0dEtBT2pE?=
 =?utf-8?B?VDQveU0rbXFiWFJuZ3grVmNJZ1dacDA5UjYzcjFtVUFBcis5b1pHL29iV1RZ?=
 =?utf-8?B?N3BNdVUrVUZEUkZPajd3clhQZldJZmFSTVhCRGN6UGRoa3VDR2tjTVN2ZSt0?=
 =?utf-8?B?TXJGUjR1NnlzSG5wQy8zZWQzZVlqdDVYY3dNQ2cvUUdsVjh0R1JBZ2oxUVAx?=
 =?utf-8?B?Mlgvc1NoUTl3bCsxWmpZMGNhSzFRK0d5SnZUTkZJZWdUMmt2bkM3eCttaFgz?=
 =?utf-8?B?L2s0dlk5Y29PTXdWMzF3TnRuT3VNeWZHdnN4SWtYUElaNlJBQk5JYkFMMjNW?=
 =?utf-8?B?WXBjdzdaOWNCMy9lcjhrUnRaSVhucGZzcW45dnIzdFFsd000NGRDS2NHR2ll?=
 =?utf-8?B?T2dyOHNSdkx4eC9xaW5ZYkllSC9RWk15Z3czQU1aVklzenpNUTV5WnU5RC9D?=
 =?utf-8?B?ZDlhK0pxL3pZd1VjWDR2SzM4bGRjZ2ZGVTRLaVVLWTdiSjMyRTl6aDFlTjJG?=
 =?utf-8?B?UDFqcFVhS282emRHblJScFhhUDV0WGhIN3VWQXlGY1Jlek40ZEVQenU2THVo?=
 =?utf-8?B?dGovZmNxT3hpaU9MdGhGT2w2Z1puSVVJS3h6OVhWc0laWHplZVZOREo3M3BX?=
 =?utf-8?B?cjZtU0FrbE12aFVhS3BETG5CWDJmVjlkMDgxbm5XcmNYL0RKOU1jeW80Vm9h?=
 =?utf-8?B?UkxNRUU3TVpJUzBUUnpWdjVGT1RsSEllZklTOFdVRmF1clNCT1U4SVBUTHFv?=
 =?utf-8?B?NHJoZEVKdXFMdVphaXRGMFJNS1FHa2ZiUHByNk9DWXBMcWRkbWRvZ0ozaWlW?=
 =?utf-8?B?czF3eUVPR0ZXRUVRRWlUb2psTVU0OVhXZUtuUmhIWU9MTlpNblNwRHJGMG9O?=
 =?utf-8?B?cUhQWENGaGNOYmhxVTdIY1psTjByRHVlYzZkVnlVSXN6MlUyWDNIdC9EbUwy?=
 =?utf-8?B?M3BCbFdUUk8rekdrMWtEL2NFeGtmb3ZUVU42SUVsMVRCUHdXT0VQNm55VFdm?=
 =?utf-8?B?MWMrR0JLR2tTUEV4WnFZeGJ6T0ZxODlIS1VYTmxjYUtMd3NzeVVpMkJMK3FR?=
 =?utf-8?B?NVRaU2owbTdCVGltZ2cycHlCL2U2OTZKRFlIbmlnT2VDRWd6UVlYY2g1SmJv?=
 =?utf-8?B?QnBSY2tXb2dLaFdlWXM5UEptVUhBSVNEaDZoR0Z0Zk9rUzFENEszNGRVVDNH?=
 =?utf-8?B?VXN2N2ZsWDByR2pVUzBuL2s4TEkxdmtPRGx3czFkbVBBWEV3blQzcWx1WW1R?=
 =?utf-8?B?aWtUazBJMFAvNm9WR25QTGRQSGFabThKQkJxWUExRHNWN3JGYVJwekFPdXFL?=
 =?utf-8?B?dE5XYzgySGRFRnVPRXMzZGRlRTNiR3dETC9IazRZQ0ZLVk5qREw2d3dhKyta?=
 =?utf-8?B?dHdCdzYzajBCUHhoanBzRS9XUDNSZ2lSNEtiVXNuNFBvYkhqUkxWR3VxVHh1?=
 =?utf-8?B?cW5mbGpHem9DdEFsRnNvSEo2T0NDbFA4WEQyVFhzS3B5WHE2MjdoOFVLTGd6?=
 =?utf-8?B?Y0NJaHJHWnRrcTFGN0JvREl6alNBQ2RLbzBoeitOaHkvVm9ET2RuMC8veFRu?=
 =?utf-8?B?UnlMSkVPK2RES2paSFQvaTEwQ0NrUHM4M0ZnSU1wa3NMc1E1TGdNeTNsQTRO?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d07d4267-d4e9-43a5-8f16-08da97fbc8c3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:54:48.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70q5ijiEirEyPjyWaGSLgNPWE9OjqfUj5F6HVgOxMwW8BhoFS1QBjWJkaby6zZfAIsqUQVwJk7HP8HL933NRTGqa7RjwAnDrwIivRx8zXN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:00 AM, Babu Moger wrote:
> Adds a new resource type RDT_RESOURCE_SMBA to handle the QoS

(nitpick) Adds -> Add

> enforcement policies on the external slow memory.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Apart from nitpick this looks good.

Reinette
