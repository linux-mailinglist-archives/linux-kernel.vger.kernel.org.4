Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9C64DF70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLORNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiLORNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:13:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB4186;
        Thu, 15 Dec 2022 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124399; x=1702660399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4YvhqLOJDWAuSYIMkp9pK280F5H2HKNbRVaI1ZR9BaE=;
  b=mi7agT+903+QeaBqBWcjIs9UQiXlUTgxn/Smu/tCg+hvdevfK1fJ1RTr
   fP9H3jfebm1C4DnX6fXeqaAG2I5Lu8z8w4GtAUYiY0YJRdVQum/H+zkum
   iAHByypm9GcNf8XvO66rJ2Owf44POAEhlDYMBHi3V5lw0tgatH28zF30r
   iyoyvXDk/Mxw1/uvPDAN1CLnhS/UuJWe+TK5ymUov+U+wLycKkpamZBxN
   OSuYpKtfiEyiKHIGBNTpDK+4P8R8UgC932Klc72X/fcFcm83zbJB3m60N
   iWRKitLayLrejX0wxNuCEzA98cYOo+rNp4KmBnF+vwJdqgh7gIRcK483U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299083621"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299083621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="680157844"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="680157844"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2022 09:09:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:08:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:08:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:08:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgujMzQvFMyxxX4y/bT8WCDYNnL/c0mZUbnPLAumLdrqovCS8b4LDpbMuXktFVTdkHRzuGMMv6rrO1VeTHxlHzcqMMY4vhBwdOD/HFewU4o9ZRAgO2m/tJRe1+u8vchEWJNvWqHejwEM6O1ZpH1T9N2ZfqvPpBA9jIx4CGWgEWyALtWCEWOyFvd67D3GuAmtLUG3jMjB06AT5xRwCdkyx1iwfHL0soN5Zt4T1QKBt5Gt4xlvUY16Vp2GXos+Jm/Ljy+lF24q+gJxSRqcFfWSPg8g7+dukXvkq0Ookv4iddADJCgYHMCKxDJkKAmdFjn+839mr8I2daOuyGi8VnlknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEvOSK8kHe5ViccYxCasOmoZxq84hmkV33xJql2B9Ok=;
 b=OS8NrO7dlVN50CwfIosDADVA4ctnJaqmb2HtixoivqrI18ze45nTYMPfDrE4wYm+UEuuSQYfqEiP5pFny13YoSONewHtamWqF0K9MEnX8aKV+Z8dEOb3Agwe8MLI6NZh8G7YI9eEJIdAtwoWxDroo2Zjz0tvUxuL7AF5FXrxleY9sLVyAldFK4n1qYBS7j+r193SoNEIve2jrxGN6v6roF9fAAy1r/GXsGZ9CXogfsHnQKmPgjPyDB5wZmwGYyNoZ61fFMkCCHXHkP9OQAgvX5QqePwQwmW7GqBs8UAeUNdUjIPh137hhJJAaenyS3sqlkxcGmHpH/7n0Gc2o7FfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:08:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:08:52 +0000
Message-ID: <8b6b0e74-3af6-b5ba-8496-eb0614c9f148@intel.com>
Date:   Thu, 15 Dec 2022 09:08:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
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
 <166990896023.17806.9274990355490405865.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990896023.17806.9274990355490405865.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f1cd77-8383-4ac5-3ec5-08dadebf0a99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIHDJ+22UUwA2XACdsTlzIsKEUh+iYOki8/KFHHsjcNUhLzVuHSowgOi/Q1bSbWEMXwyAsD/HIBB5AL9xZzeNcWSg4VEo3SwafBOMxUk+0jM5BfhxBMtd/XgqFSm2TGW8ip59FtZnmE5pmSbaOU3DSzIhG2xkFIWJQmKqFQynWBlQRyYbMEakKohkoZQ7kfExK3W3VlwyKJUNyrcSO7bvx6UUBAqMvg5hpJXR6BhLOuZlBeV+OvcG053z9xmgUsOdinh9Cxgl+nXvUnahYj5aXzorKZ3vcWQNVbiAOr9/yAr6nxLRtsCYi+xWbAElN1mz031pryAIF71Sg8+E6tAaxPjJcgYEhRCljME4+nqUHakss2S7Gw2E3k9Q9CV8KzNT0K4o5JX9ZD4dffMgQ1Om3MQnZCcVRuKTKl/pzf16gJGvwVNsJank95NcILacgiZAfd4148Y7WS2T/0lG0UmyGV1Wz1XDsL789KONO3asVfE2jDJBihrOqFadMuuaaZN6hXzpb+g7o4gwdfnauLhx+vEyHaSb/9yKxx+AYKUHrnIyFBKv3b7h7RIernSmL8ZD2bqmUSwTcZb9e/KdlGYA+UAYT0hnyzz0emum3pNDlWlv549iTKO3hhX9EFx+c08RGK79r+qWyuNog2IrdT1mQDexZ+yngFqu83iAs3Qe1croghLdQakXOAzwxyHAdPXxEvMZEJEPMypjOb55EDubl/ZwuN2Pef0AQcgDGzwv0EWdlbT7AqK3ssbP7U7dhJKp2ign5yHbsS9TSX/zf0sZhEjyf6RKvpVmH9KS2qlQXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(478600001)(86362001)(31686004)(6666004)(31696002)(6486002)(38100700002)(966005)(6506007)(53546011)(6512007)(26005)(186003)(82960400001)(8936002)(41300700001)(7406005)(44832011)(83380400001)(316002)(36756003)(2906002)(7416002)(2616005)(8676002)(66476007)(4326008)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlGcGxVZjVBSlJ6TTNnUHIwOHYzTXNzTXdEaXlNTlhzRzM5S2tRbWVTUzl2?=
 =?utf-8?B?eGVVY2xSOVRwSks1MU04MGk1SjFnVmtTY0Y1Wk43WVFmb3lNOFdnZnVNdVZL?=
 =?utf-8?B?UTdIWEg2dVRLRG1ud1BJaXRvdVUvT3hnNVR0TXYxNGhiT1FWbHhULzM4d2k3?=
 =?utf-8?B?YTVVZXJHVVE0T0Fzd1owRFZzTC9JUXpKL3NHS0JvNEpNaHFja2FkdEsvUFNW?=
 =?utf-8?B?VHNGcm9kR0ZaVmJhRENWVUN4YXBuWVVXNjRtQ2VhMmxOUXVPbDZMOWdPT2hy?=
 =?utf-8?B?bWxaODF3d01HNjVLNWtkakRZNFhNUlhMaW5OZUVCbFljNE1UVGVBYzBpMUNP?=
 =?utf-8?B?TzMwNVNTU2gxd1VINXMwNWdwOU1BMS9ia3hmUUExV1FWdEliQlRRa3VYaEZJ?=
 =?utf-8?B?dzhNR1BTS2hiUUplbTdEMXFaaDl1Slp6KzhjTzRSc3RmU29YVk1ROTlFVCtj?=
 =?utf-8?B?a0U3Q2FWOXBUK1NOakVSSzhLK1h0bFdtT09mUVlQR1VjNlZocjJ1Sno3V1NL?=
 =?utf-8?B?MFQ0aFBjRDFMNHRWRXFEL014OTRFUU9RZ3M2eE1qS1JQSmUrdjA1M0o4N2h3?=
 =?utf-8?B?ZnNtcFp2R2ZEWVl3ZTk5c01KbThTUS9jZVBvRkJoU0ZLSzVjSXN1ZStSVGNF?=
 =?utf-8?B?MVdxTVFWMktjc2l4MkZpeExSY2FZa0JvNFZ3Wlo1R29YY2xNSnpzamZJcjhy?=
 =?utf-8?B?bS9YRFVqcFdLWkNwbDN1MlRpV2YvV1hEMmxBTkQ3NlAvekpZcVJNNHdpK25G?=
 =?utf-8?B?RHZkeStBak9vY3MvQk1DdEMrWFJ0VlR0R3JKdDJpclRGaW5RQ3pvSFNkWXdu?=
 =?utf-8?B?dkpvWFVGS0sxVHNKbEh6d1JSSVZrOUpYUWhvZU5rMXRONGwzSElyUVdiR1ly?=
 =?utf-8?B?NTFJUXlWUkxDd2E2ZGhGeXFFUUxTeEpva0taNkhDempuWkRBeUpUQ3dUZG1y?=
 =?utf-8?B?V3JHZlZDWS9LazRweGIzcWM2ZW10Z3VoSmhzWnpYZnExNUUvY3hHdXVZUW5l?=
 =?utf-8?B?VEtQL0pHaFd0cGxhS2xLeXMvRHRFSWJ4NjI4S0liMEhST2pHZDlIaHNjdHhN?=
 =?utf-8?B?dk03ODRZdm82RXFZV0FJc2l1b2hqelRXNGVTMW1QZXVRZ0dqaTdOcmZuR0Rp?=
 =?utf-8?B?dTlXZ3JJZVVGZGVlVzMzNVVHa2NweVFOa2hvb1hLcjVCUHg5N1ZrM2dhQ2RR?=
 =?utf-8?B?ZXBrMFNxclF6b2R4OTk1MG5oS3RvUmlhV1BmbERHUlRkVk5ZLzAwQXMrZEdB?=
 =?utf-8?B?RmRjaks1aWRubVdKemdvdlh5T1NZWU5UMHE3c0R4SEYrS01yUjUyRHUrWXI2?=
 =?utf-8?B?ZC9qVE82NW5mVXBBUE42TWZQdGJHNVlVRjFTSlNhVzNPc0ttN1NWT0FWMXRj?=
 =?utf-8?B?VW9PcGNtY0tuU2Y5bUdMWHR2TjBlK3JIeEk0c1JHdmtMbkhESHYwUUJpRUQ5?=
 =?utf-8?B?Nml6Q2Q2OUZVU2MvQjZRZE1LVkVubjF0NE9ubEtIRDhxcDJhelYvZFlwbERw?=
 =?utf-8?B?OWxscFNCOTlnVmZtMXkwRTFWZE9RbDBGLyttWGxBd0UrMDkwNnZVU2REWjE4?=
 =?utf-8?B?TnJmSy9kbjEwWCs3ZS9WRGlvc1BvWHQwWVJGa2lOT0p0Nyt1RGRFbjMwc2lU?=
 =?utf-8?B?WlNxYlUwZkY0enl3WllXdldmdHpVMGRGdEs4Vll4ZHZZdDY5cGFwZ1FBME42?=
 =?utf-8?B?WGxhODYvbnkyZmtXUW5sQ2xhYWFTZWVUVjQ4TXBwbkhCaDlJY200L1EycG54?=
 =?utf-8?B?QXdVSXNJbzUvRXNYUDBDNzM5b2NYV1dobTdBNTFIUk05MVd2ekh5b09GVXdV?=
 =?utf-8?B?eWVXYkZzWE92aEgxWDJyTEhaYnFtVkJPMFZZeitsbWRFcFhJcGEwR01adDRt?=
 =?utf-8?B?R29SYUxsSWFod2xpWjhLRmxDc2hRYjRNelVrK0lDNUpENkt4eVFnNEhCalor?=
 =?utf-8?B?akQ5K2ZZRzlCMEUrUmIvdGU0S0luVnJsNERaWkM5bkVQL3hiaWhKMjBHcmV4?=
 =?utf-8?B?UHZHQ2ZrQjcyOUJQMHR4YWNuSFI5eUdZL2JOL2tpTjdjQkNaclp3MVVxcEhy?=
 =?utf-8?B?WXcrMzBuT01iOVY4SnowK3lMZlVYcG10YVpTbVNQMExKZnpuazlZNGljYlpy?=
 =?utf-8?B?UXVvNVA4YitFeFJ2aDFzYVM3TnVWUjg2WE5GZWl4b1MyMTJSSTlsWkpxd0hv?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f1cd77-8383-4ac5-3ec5-08dadebf0a99
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:08:52.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miuZHNESK2DNB26ypMDhkuESRKTkIKRnWmHzcWH+Nhyb9BKK4xdFccc3oXjzKMTzP4CmmrMoo/1uA/JUvfWUktS7jkWurb+RworUEi4RRWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
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

On 12/1/2022 7:36 AM, Babu Moger wrote:
> Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
> enforcement policies can be applied to external slow memory connected
> to the host. QOS enforcement is accomplished by assigning a Class Of
> Service (COS) to a processor and specifying allocations or limits for
> that COS for each resource to be allocated.
> 
> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> 
> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers
> (ECX=0)
> 
> Bits    Field Name      Description
> 2       L3SBE           L3 external slow memory bandwidth enforcement
> 
> CXL.memory is the only supported "slow" memory device. With the support
> of SMBA feature, the hardware enables bandwidth allocation on the slow
> memory devices. If there are multiple slow memory devices in the system,
> then the throttling logic groups all the slow sources together and
> applies the limit on them as a whole.
> 
> The presence of the SMBA feature(with CXL.memory) is independent of
> whether slow memory device is actually present in the system. If there
> is no slow memory in the system, then setting a SMBA limit will have no
> impact on the performance of the system.
> 
> Presence of CXL memory can be identified by numactl command.
> 
> $numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> node 0 size: 63678 MB node 0 free: 59542 MB
> node 1 cpus:
> node 1 size: 16122 MB
> node 1 free: 15627 MB
> node distances:
> node   0   1
>    0:  10  50
>    1:  50  10
> 
> CPU list for CXL memory will be empty. The cpu-cxl node distance is
> greater than cpu-to-cpu distances. Node 1 has the CXL memory in this
> case. CXL memory can also be identified using ACPI SRAT table and
> memory maps.
> 
> Feature description is available in the specification, "AMD64
> Technology Platform Quality of Service Extensions, Revision: 1.03
> Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>

According to "Ordering of commit tags" in Documentation/process/maintainer-tip.rst
the "Link:" tags should be after "Signed-off-by:". Could you please re-order
these to ensure this series is ready for the next stage?

> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 11a0e06362e4..b6a45e56cd0c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -307,6 +307,7 @@
>  #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
>  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
> +#define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index f53944fb8f7f..d925753084fb 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> +	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
> 
> 

With the tag ordering addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette
