Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBB5FBE82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJKXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKXsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:48:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37A459B3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665532119; x=1697068119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fsHqkghahNNiWKnIqQXvpRwvI8+YkOVsHsKeXrAGxcc=;
  b=b87mp0BpoS4CPBK4P1/7+bPIb0OAjqzQuey6DOvoQZtwBGoRPdN1TU6f
   bUZd414GCSoCyAG6NX1apsWlm1gc8Yz1zCZCzmvP838VoL5j/tFwszf8V
   AtU+NFmrpezuaWBoTXmNv8mclKHUsXf48Mm+EfHM6CyH0zMdvJdE7tTZH
   Ea2ZaXIis04Cw8X2hoGBRXTS+hRbWborb8fAhdXlPiv0NUaQSGkwmmBRy
   +9OU9cjSZU2zh0meKyfpLbbTZtdtIZRqyItqKxy240YkRyWPw1diGeFa8
   ZJp/2BWWk0X19NfPEhfg4YBvAAmrJrHuby9BaKyyw9gzC1i3sJVWEZfQe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="304640901"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="304640901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 16:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="626562250"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="626562250"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2022 16:48:39 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 16:48:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 16:48:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 16:48:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzwu+57bgPR6CmQSPg4iBaafDRtXJOXG670rbbmHiQj3Z9g6X851Vy+ky2O+9d/cflypE9qsxqZAFyUkSFliUVtVZ7sfhVyejrhSvB7piyLi2BHp4k2mgcmBZSffSDV5hfYnrNuRJkYCGFKZ4gsmxHmOWoYWP9EM5oEQGWBzBYrTD5N1NAZl27z6SRjAU6pqOXWvPxwX5lW+wAXxrbl704QtNciYoZA072+YHQ2Kkd/pCPxg5rInxRYAIT5B1S/sRDxbtFXotTsFdA3vq1uRqhcwX9uF0s4VuJwEpCdeVE5FSOpLIr3U2o3P+2UkDlaHh7urEADSj1JyERbvg+odSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmnSBhLhDsAF5DzZGYErarmQsV/GgZDLtZAcDFff4Fs=;
 b=idvx+IgJe5xHNCCGEp2p1hNQj4FfRIL1zQ8gMm3JGdwooR392N0e0YdlSe3dbaKwpnjsEApFS6gdIsRRUErd2TCEtW29nOJgdt0Hurun5EX0G6RS5ymD3b+w5dNF+gydS3Uz/H6n1Owrhm4yFCnxX0olWJbJxdBElLr0KCQZL+B1bHHHUpHuqiHhSU+YRVFPZMiIa2O+JcjZJ5cP7eCZEWQlMy0944RQcObENKmc61Iod4o5mHI8lbCxXxEkh7g/frPCxeLz54ZE7QEf0yejNbrOKdjh0vU1gvGy2QyYRwUHk/kF1+Uv+E8fQe3FgwpOjnQsXFm+40/DEeuQoyH9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 23:48:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5709.019; Tue, 11 Oct
 2022 23:48:36 +0000
Message-ID: <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
Date:   Tue, 11 Oct 2022 16:48:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.2
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <jamie@nuviainc.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6201b6d1-378a-4456-b0fa-08daabe31d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbJ2m0gP2mrHsFY7+et03u+Y5OpDDZnfJkqve9A7DQ13h0xo2ziMLAnqYra5ruh2c3laoQIRt9vAiZ9KdlBhOCV7J01fAEhi2OJu9nf9ox62boe6FPM2tauGbC4treC3HAMWI957EvvvSqKXUMVmLeucvmY1lSDWDFJC4j4w0/LsbaFkvuXdy0vLEHQ27f4d/ZFIVPju2/q5KPPRIDcIkZgSmQR6oaUSgwz130dL7Pogtfte5aXfbp0oK6dliMnEGQhOMNJxoRzVGpYlM28UEAqhekk+pAhqXpzbB4C6t0vHykzLwWfwz0gX3tJvZMM+5AbGP9UtA1jzCPMz4/XXiOftJ3iisMjOfKJchla6K+5w/K9k0VvSUpjj6jn2F9geqBIE33yAQDs5u43ZA3tfRRz/ZkmtoVLp8/suOrlktZsL8jMH5w90Q+m1pC+JJSpqxk9qtSPHQM/L4pHVtJDifbKiWU/rPat3IL9lB/5aIRFlntW0r1Pt1CAhRW1nGl6o58ePj73ZwsFmFoVhfnxrt5YLnZKXyzQ2rDQpiz5KP7cYoXcgZRu4WMhCj6vqVKUAHKWrq4a5FudWUmFPPa+eB7IdaWZLIQXJNV+ObG5ihU5c4sdm+Xj/B0rknyWWSwznK9b/kWj14bkQimR06UEe/sO9u9qyTXX5cVCj6GtWUT1qNh0RelN4idVo/s/wPw1whOHTHChhyQ3lxKY46KDtpASKma4L5OrlNAyqb+ELRlIOGyvOrNvMIwMuEq6ijDTtnmTIYjE9R5BRXBlvwcO1AVNc3e5EmekeK/egsxTsmGlDRGWwFmVdRWD/RbHnKbRWz5e9YLWEJ26DGjFLkmVQ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(31686004)(36756003)(31696002)(86362001)(5660300002)(7416002)(38100700002)(82960400001)(186003)(2616005)(83380400001)(8676002)(53546011)(316002)(6506007)(478600001)(6512007)(6666004)(6486002)(26005)(966005)(2906002)(6636002)(66946007)(66556008)(66476007)(8936002)(44832011)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdBdFprbTJPL3BXVTZrOHkrYlBldWNmRmp6c0JhMXM1L28wT2xOM3dUYmRs?=
 =?utf-8?B?Ykh1aFNmK1pHa244RkJINU5JQ05URm5XQlhhaXdFZFJRRlIxUTZhUEovQ1Jm?=
 =?utf-8?B?ZXgvWlB4QUcwSkg2ZzBUQis4emV6emhNVlJHSmM1WnZadVFaQjJVLzRDU1VN?=
 =?utf-8?B?Z2VZT0NnQTBHTDQ0QVhiRXdVZGdxVmV6bVpSRlRNb3d3ak9Ib3gwd2NrMzBm?=
 =?utf-8?B?VHArZ3ZFV2FjV3YrS0dVV3UwaHhTN0V0YUZVaUVFeDh5cHhCSVNBa2lQTEVO?=
 =?utf-8?B?VmFrcWpHcG1iQndBZTRkdmlWR2NDT2s1SWZYaWRTL1Ewd1ZKMXU1dmZxUzNP?=
 =?utf-8?B?KzJ2WmRPenpiRTJKVFZSbjZrN2NWdDNwUUJZQkZndFI5Z0t2RFVvWEwrbTho?=
 =?utf-8?B?aDZidXFEbExpQU9BNGtPVE95VWtCZ1NWWmlVemVOTENpaXpzR3JMcVQ1QS80?=
 =?utf-8?B?ZUoxOCtBVTdUSVA4VDFyU29XRWRVbE4ySEZYNnQ2MGtPYjNENGRKMXdrZU03?=
 =?utf-8?B?Uzc2aU43U1NXZ25sR09qTmtVQmNBeStoN2ZlcjZqaWkvaUoxZnBrUkx3enlk?=
 =?utf-8?B?dnRpZXZ5Qk1rNFlSQW8wN29XbGVSdWxqcG1sSUQxMmIyZGRKaDNuRlprR0F3?=
 =?utf-8?B?TnBjY1Z2TXJMOUNBSm9VZnRKVTNKZ0I0L2kvd3RjMW43NEFPYXViVW1FVERC?=
 =?utf-8?B?TkNENndWbUJwdDFRazB3T3ViYS8wVzM3ZXQrVk9aU1ZUeTJScXhoek54VnQ2?=
 =?utf-8?B?bVd5cmI5WFJCWHlnUjRtajdyL0NodWVOMzhUdnowOXJLUEZVQjhrNXlTZmdH?=
 =?utf-8?B?V3ZDcGZnMm92TjlWME45YkdHQ1pvSXBvRkVnWGwzZzlBNmpwRVUwSjJXbElU?=
 =?utf-8?B?cGx4TUFvUVl1SzFmTnhtaWdBUStFUGdCVFdqVGxzamJlVDcyK2xNbzVxT1RH?=
 =?utf-8?B?ZERaaEdSNjhVaVRQNzZucTV6cU1pVnVTZHZBNmd2citjdnE1M1NWM3pJS2pH?=
 =?utf-8?B?ZzhmZ3JCUVlHSXVjR1ZDbHNTeTUxZ2VrN0creWVmbFhpWWJXTmdxZXdrQTYv?=
 =?utf-8?B?cU1aWG1weDNaTUNWa091OE5Ga0hxcGI0SFdpNUp4cjhlOUtjaDRXTXBTK3Nt?=
 =?utf-8?B?cis1Q2Jhb2UvdlhUaDFYaysxRGduc0lyN1BYS0o5VWFjWGtndFd5bktGdGpk?=
 =?utf-8?B?ZTBpMFNtTkxIQmJXS1dwSlg0OUZ0WHU0dFphd0JrQU5EQjZvZmx2emZXOUlu?=
 =?utf-8?B?Mm5tK2NEdk1vWmVQVVNCRStsTDF0RmU5bXVtQkJIVjFqanllL3NyS1RxWldE?=
 =?utf-8?B?VjdxL0wxd0ZGTjB6SllWNVdseW1iOFFibFZxSENqdlRPU0F5QkszbnZkc0FT?=
 =?utf-8?B?eDdqaUtiTUpHaXZHZnRMalpjaHJjOGtyd1VDSDBLUEphaG0zMmN6QmVrU29L?=
 =?utf-8?B?cHhXZlNQc1A3dms4ekRpTjVQZ0RJMmNmSlZKTk5rUEhwQ0dYNGMrelBSb2VB?=
 =?utf-8?B?Ri9aSmxCcnpuY0FNQUdRb28wSlJBMWtTVGU4R1pEdU5vZjVFcVc3VHZ0MC93?=
 =?utf-8?B?QmcwRTRKYk5mZEdzcTJBRlBBRGpueDdTUEh2TmcwQVVFMmdXMElmL3RHa0t5?=
 =?utf-8?B?UjNyS21pZVA0Ri9ab2h0Vm9qcUl6N241dk1vcmx1WjBkMks2aDBpbDBnS0Uv?=
 =?utf-8?B?TTJMaER0bi9UQ0hEMnhpQnFsRzJrenNHK3N5YlJWUW5pc1Nvb2ZIdS9JSXNr?=
 =?utf-8?B?RlhHQkYyaWc2blJzYUxvWW5xSG9yZXhxZUd3NmxlUDNVeHJ3eTYxS3IwdXl1?=
 =?utf-8?B?QmMvQ0VOTXU5SHJaN3JGSnRpSTRYUXluRkFLTlBPWTUvVyttZHNxRlFRdVVW?=
 =?utf-8?B?M2tYYTVKMEc4Y3hMdE5WVHdqWHVvWmptQTBzTFFKZTEyL3RWd1pRRGxDbFRn?=
 =?utf-8?B?WGdjMWp0WVlZanZQWWNxV1VWc0orcGN0U3crU3RFVmdOTHEvd1k1aUdFeWJ4?=
 =?utf-8?B?dFRlMytWUng1amlWVHlCUWQ0KzFwdXZGVmY1M3EyMzNuTXlZbCtIR3BoRmxZ?=
 =?utf-8?B?UUFMQzhZcDUvb1E4SEpWR2U3TVpoakE1UUlLNk43S1FFUzlnTjk5VVVTL1Nv?=
 =?utf-8?B?VnVKUEsxYkJFa0dSZXNQS3pxOWc5MzdNbDIyMThvRmtJdGlsTXlNWkhvOVIv?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6201b6d1-378a-4456-b0fa-08daabe31d37
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 23:48:36.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRq8Y7a539lKZOsrckNE9mF5AS22epbz+bV+9NFxt76gg3tEov4v5pmvReVFY+YBl/Yczs8Qy0kJ2DUGyf/87j4ggd/wnIAT/KKF4EH42Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thank you very much for working on getting this fixed.

On 10/9/2022 1:36 AM, Shawn Wang wrote:
> As a temporary storage, array staged_config in struct rdt_domain is not

staged_config -> staged_config[]

> cleared after it has been used. The stale value in staged_config could
staged_config -> staged_config[]
(please make the above change in rest of changelog, doing so makes it
easier to read)

> cause a MSR access error.

a MSR -> an MSR

> 
> If resctrl is mounted with CDP enabled and then remounted with CDP
> disabled, the value of staged_config in domainX via mkdir changes as
> follows:
> 
> CDP enabled:
> mkdir <resource control group>
>     domainX.staged_config[CDP_NONE].have_new_ctrl = false
>     domainX.staged_config[CDP_NONE].new_ctrl = 0
>     domainX.staged_config[CDP_CODE].have_new_ctrl = true
>     domainX.staged_config[CDP_CODE].new_ctrl = <default mask>
>     domainX.staged_config[CDP_DATA].have_new_ctrl = true
>     domainX.staged_config[CDP_CODE].new_ctrl = <default mask>

Apologies, you copied a copy&paste error from me ... the last one
should be CDP_DATA.

> 
> unmount/remount resctrl (CDP disabled):
> mkdir <resource control group>
>     domainX.staged_config[CDP_NONE].have_new_ctrl = true
>     domainX.staged_config[CDP_NONE].new_ctrl = <default mask>
>     domainX.staged_config[CDP_CODE].have_new_ctrl = true      /* stale */
>     domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */
>     domainX.staged_config[CDP_DATA].have_new_ctrl = true      /* stale */
>     domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */

(same typo here)

> 
> When creating a new resource control group, hardware will be configured by
> resctrl_arch_update_domains():
> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
> 
> Since resctrl_arch_update_domains() iterates and updates all
> resctrl_conf_type whose have_new_ctrl is true, it will continue to update
> the stale CDP_CODE and CDP_DATA configurations when CDP is disabled.
> 
> Based on the above analysis, an error can be reproduced on a system with
> 16 usable CLOSIDs for a 15-way L3 Cache (MBA should be disabled if the
> number of CLOSIDs for MB is less than 16.) :
>     mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>     mkdir /sys/fs/resctrl/p{1..7}
>     umount /sys/fs/resctrl/
>     mount -t resctrl resctrl /sys/fs/resctrl
>     mkdir /sys/fs/resctrl/p{1..8}
> 
> dmesg will generate the following error:

I think it would be helpful to connect this reproducer to the 
explanation of what happens. Maybe just something like:

"Upon creating directory "p8", to which CLOSID 8 is automatically
 assigned, the following error is generated:"

Please consider what is the most useful information found in the backtrace
and only include that. Interesting enough, there is a very related example
of what information is useful in Documentation/process/submitting-patches.rst
(section "Backtraces in commit messages"). 

>     [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>     0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>     [ 6180.951983] Call Trace:
>     [ 6180.954516]  <IRQ>
>     [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>     [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>     [ 6180.966485]  sysvec_call_function+0x89/0xc0
>     [ 6180.970760]  </IRQ>
>     [ 6180.972947]  <TASK>
>     [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
>     [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
>     [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
>     ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
>     f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
>     [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
>     [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
>     [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
>     [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
>     [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
>     [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
>     [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
>     [ 6181.049678]  cpuidle_enter+0x24/0x40
>     [ 6181.053370]  do_idle+0x1dd/0x260
>     [ 6181.056713]  cpu_startup_entry+0x14/0x20
>     [ 6181.060753]  rest_init+0xbb/0xc0
>     [ 6181.064097]  arch_call_rest_init+0x5/0xa
>     [ 6181.068137]  start_kernel+0x668/0x691
>     [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
>     [ 6181.077086]  </TASK>
> 
> As Reinette Chatre explained:
> https://lore.kernel.org/all/2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com/
> "
>  The value of interest here is the register it tries to write to ... 0xca0.
>  On a system with 16 CLOSIDs the range of registers available to set the
>  CBM would be 0xc90 to 0xc9f that corresponds to CLOSID 0 to CLOSID 15.
>  The error is an attempt to write to an unsupported register - there
>  appears to have been an attempt to configure non-existent CLOSID 16.
> 
>  Above becomes an issue when the resource group being created is for a
>  CLOSID # that is more than half of the CLOSIDs supported. In the
>  reproducer the issue was encountered when creating resource group for
>  CLOSID 8 on a system that supports 16 CLOSIDs.
> 
>  In this case get_config_index() called from resctrl_arch_update_domains()
>  will return 16 and 17 when processing this resource group and that
>  translated to an invalid register - 0xca0 in this scenario.
> "
> 

I am not sure if adding this full quote is necessary to explain the issue.
Maybe you could just summarize it and move it to before the "Based on the
above analysis ..."

> Fix this issue by clearing the staged configs when the configuration is
> completed.
> 
> Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> ---
> Changes since v1:
> - Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
> - Update the commit message suggested by Reiniette Chatre.
> - Add stable tag suggested by James Morse.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1dafbdc5ac31..2c719da5544f 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  				msr_param.high = max(msr_param.high, idx + 1);
>  			}
>  		}
> +		/* Clear the stale staged config */
> +		memset(d->staged_config, 0, sizeof(d->staged_config));
>  	}
>  
>  	if (cpumask_empty(cpu_mask))

Please also ensure that the temporary storage is cleared if there is an
early exist because of failure. Please do not duplicate the memset() code
but instead move it to a common exit location.

Thank you

Reinette
