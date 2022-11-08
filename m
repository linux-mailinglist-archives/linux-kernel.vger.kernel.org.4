Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB186622038
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKHXS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHXSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:18:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD534220E7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667949532; x=1699485532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oqg4XlFLXjGQw+g5gjawuYMV2AkH4J4Vqd3n3+j+aE8=;
  b=h7ALGaVMtZXEzAWYfh3Noea1Mw+CaqUgSPFVecZ74ofRFO8Tsz9OcQEr
   K0gn3FtxNo7J+Lm34Kp+KkDBOVkUurWYAFHElUgbUxhprqEOdsYTXhETf
   vG5Gnk5rdR4x99nGlyDk4cGL7SJzcb47gH+Y5u7Pld9H2ER30Jw7Kz4Yh
   LrqdSIWhO8/bRGFAaE0auVi8wVyvKTjmPiLGmMLZPs6AQW/c7hi9dTcDF
   FVpjvWeGW4OGXXViCI7dSXpCJmvfNW9BEXaWn7Oip2XvcmTyxoG8QrfNi
   fyy3fi2gk2n0RWyYntngEEiQQzMqsgVphRBEA27oA7vfaeRy3vRRc5+dR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294205240"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="294205240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:18:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761667835"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="761667835"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2022 15:18:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:18:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 15:18:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 15:18:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjhZKzjUAmWGvtlmedPRxR5S6K8WlWrjIygtH4v9YjETTcutHprhzIK06V424/cUQJ4x8QMl0P6Tbyz31dSoyyubCCV7B2n33fpOEfBvfufWZiDYzaWRzSLK8aT20c9c2Uap0wJJrolMFPhIjE6hTIWjPYcUXx3w3eMQROfHNfcVDZI8NA5sALeVOAj76EN53L3rqDLXwOqQMspp56+7M8/BpA8Fta5RnHmqxSiAqTtwD0+Zl7nDIHbbk+qYyxwXy6iQfrpgrClOHT4UhOIm18wbIL75u/kG5Yn4Xm3o+PSHckJXt8NW4rb/vmzowiKFlJsWqaDlj9jwt+x4/8tWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMx5NbJuWCsLDuk5EMfaeGbmq445VDgGhdYKlzqVImw=;
 b=DzMXSWErBDOWsK+hJ8jeP3HSowj+Q00ER/8mNIMwAFLaofAr1RBHL8EjCbcGp718BRNcYxTh+LoM0nLD7l/9Pzo5PGd2jFlLs13m1aneQ6yUCbn9JIYPBFIoI7YdByXVcqAGFx1lpPyZMyhrjBUKDsRFQBUWjgmi0kvLzVZBmrinIOc8Ln98fYZ+9ZEYzXVSFFC/l0tXZ749Y/KyRYjbLFBjHWxZT60OVBz51IsreaZOfjojba3wN9OoAyU/b6vD7klnOXb6WSq9qNkLZ7k/IKwlXo0fmTDxzXWcgq6FPxD4dcfdXM78R/wz7ZAJsomAqDlTUn7xyh7PrmG+rzFz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 23:18:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 23:18:49 +0000
Message-ID: <ae4d280c-99e1-88ce-db2d-3ff7a845433d@intel.com>
Date:   Tue, 8 Nov 2022 15:18:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <SJ1PR11MB6083CEB7E30E44F31EC3CA6EFC3F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083CEB7E30E44F31EC3CA6EFC3F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW5PR11MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 180e3b72-b846-45b7-23c1-08dac1df975f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WB4hn+NcbcZtrrlsfhYmPUfKxa/DTj5HQllWkNIVNZ5SB7fZ4ZAawG0EUtuyaETvOkmZjfuLiC4wAK75KY+tTAY8gNoIfsrpM6Sl0ijRVeIWNvAJYmUfvnPLpNra1/LoSv2h4JVfI/Jg37BijFn77PdQSDdeTC5XQ9UC60GnuS15l4CHDuGQjyLIcqh4dgQJfGUk24WBbLLUD44NQjalaL7V/RTNVLhleY7kIcJjWnHdMksbeG3QuFt9yZHbUgYQVJHoMQc1cqF4B0Z6gkqIyfjO0C4zTvjIxCn8D2LHI77bl5rBycTR1oRfpdJyj/5sNWbF5+EQjo61WBv+B4ExkABWC49NPJXx9RfYGNpIkAkBr3kZn4/IGMZV/J003qKLlqukLKAUACsPUXmwFUGwjWEHCcraAd64GqU0oQu+zUqkzzNujVZY46jw+byVjTDrTSjBprC8xe/XV/+77mfjLdCty7OtNVNtCCmNzHKRSi0U17QPGLxPWRoBEaPbl1gxIWwGyUM0a2IdfSyN0HOTW1EGVeieE5IWTBYswhmcKbx+3sKq1gVMSog3xByA1qfRxOveI/wZP8JiXiLU0L2uqfI4rwV6hspWbdUtfnnMHk1KGga49MFqufWtXj3O2nyUv8SBshVduy9cN8om6fgFYoYrEGWkZxLI9rHdVYevgphdj45IS23rh32P4w9jNjoB9yHUM+b9CU6t80AIrYp32TJaS3CwLG2LArDeM3afzIQNWl0xRJwI6jf6H87OzzDGxLToPKcX/pttjfs4ga0EaPYT00mndX5sTuUum4naM5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(36756003)(31686004)(8936002)(8676002)(4326008)(66476007)(66556008)(66946007)(110136005)(316002)(54906003)(41300700001)(31696002)(82960400001)(38100700002)(5660300002)(6486002)(186003)(478600001)(6666004)(83380400001)(26005)(6506007)(44832011)(53546011)(6512007)(86362001)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURjeU43bzZpWnZEK3VuRWV1a2hqRUhNVGVyK1c3bURSbW9oTU81VFY4OTJD?=
 =?utf-8?B?VzBxWGxwOGVMWTZlY1JNT0w0MFlTUUhFWmlUY3AybDNyamd2dnVaVXIzNmkw?=
 =?utf-8?B?WS9RdDVPQmlPWXJFOVFObU4vL09ZY2VXNE5jUUN6USt6QmhqN0o1WnpWTldN?=
 =?utf-8?B?THJ1SGpTMkpGQjRkYmNlUS9SaHFhVGJ5ZXd6cWl4NzVqekIxZ1JxY3BXdXNT?=
 =?utf-8?B?YlpIbVdjYkdlakF3dVd2bmQ0cUNUcEpxRmY3Z29GWDlxQkJGN2pOY1F5L2tH?=
 =?utf-8?B?VUpsWkxRb25Ga0s5OGx5VnRzaDVIeDU2ZjRtWWpaQ3FoWmJ5VkhDK2ZWUWtX?=
 =?utf-8?B?anFQRlNjTEJFbHFhaEZFU20xdFhkSTl1NEZ2M1ViV21tVTZFY1VRcDJJTitC?=
 =?utf-8?B?QVJ2VXYzR1o2MDIvejgzRElHSU9saFl0SUpSYjZWZFBDblBlTmhjaHpscFRS?=
 =?utf-8?B?RGlCbWtzRFBBWi8rZmpld3pJU25xbTFiWXcrTGVkU09Mc1IvS1oxTmVQbnNa?=
 =?utf-8?B?aDJXenhQSitmN2NRdG9VUUNWV05nZndvZkVWUThuaFE1dHFqRmVadW9VMU1U?=
 =?utf-8?B?cWNJT0lPdExqR09uZWdmaURkY0o4TmZEOHV0UUpZd08wTTQ1VExoMkRBeWxH?=
 =?utf-8?B?Q2t1YzZGUVIrd1dURWQxbWFQS2dQNEt0TzhsWERqcklvQWNTVnUyb1pPWUFo?=
 =?utf-8?B?WDZpWm5PSXpXQVF1bkwraFRqWkxXZ3p2MnVlWVQzTkZzMGhWWTIxMk9SZGJr?=
 =?utf-8?B?RU4vWCsyNC9TdjIrRzVDblBTZW5uK2hHK0ZYeWJXWjVPQkxMMVFCUWtTZUli?=
 =?utf-8?B?UHEvaWtLRUE1d2NuQ2lDS0hpZXJGRlVSMzhXT0VvVkNjZk1YQWxjYmZ5SVZp?=
 =?utf-8?B?SjJPdy9idzhxaUFSZnp0T044RlluM2FuNDVocnZzZkhVajFRa0tVNmVQN1pM?=
 =?utf-8?B?UnJ5VWl3V0dPUDZjZ2YyNk1VcHNETEJaYjg2UHQ5TjN0MUE0L0Rla3JaY2cx?=
 =?utf-8?B?Ui9KMk5EdUdhZUduRFByWDc2c2kwUHF6ZWd3VHVHaTh4ZzdqKzFqZVFNaW4v?=
 =?utf-8?B?eG5hYmF3RVUxK0YybFlnaUVzaGp6bzhjRFBnY050R3hzQ3JkbytFY0xWOFlX?=
 =?utf-8?B?VkZvbDZNODBNN2l1TnlPZHBJR0J6ZXZ1d2dHbHB3NmE0S2hXNEp4V0x3VkJj?=
 =?utf-8?B?R3NYRHIwMnFmNGxVSFJ1Mm5iZGVPTEhNU1dhc2xtd0dFaFprd1ZkenNPUWo3?=
 =?utf-8?B?WWk4eXNONGZGSFVxSUR2VlE5QW9ENmYweWZMYmVFRHR2dnNHU2U1YlpGUnE0?=
 =?utf-8?B?c25ncDU1K0dzcDBzRVZtbkVjUEZiV3VyUE5NNmtYa2ZRd3NVUmt0bnNENXQ3?=
 =?utf-8?B?eWFmak5nNWExWU4zYWRRZU5tdEZxcllwSjh6cW05WW9jcC9kcGUvUXk4c1ly?=
 =?utf-8?B?WjhRTmdFaUpGcFhjSnovR2V1WGIzaFF3WWxHVjN5WmNyMGZZZ2lJSitDWldL?=
 =?utf-8?B?Q3g5OHFYMFFSc2xhSWNDUURsSHBoWEF4VjRtTzFiVUF2d21IV2hHNTZSWUsz?=
 =?utf-8?B?U0dOL3RpNkNab24yQ0dMVVpBdHd0RWFldkhCYkM3QnoxMnNLUmo2dmhaa0NX?=
 =?utf-8?B?S1BBdkpZcTV2eDVScWVKb3dGTVVHOW55WnFFeGRxOGhvaXpsWHVUcmEvY3VG?=
 =?utf-8?B?NnVOMjVYdnlkZzlWS1ZFem1xSElGVmRaZUtxbllkcU5vUHJHVGtrb1RodXJI?=
 =?utf-8?B?eS8wWm44SlgrMGU3ZGFwamlCSzNpby9xUUlxanM5MUFtOG80OGJ1YVorbC9C?=
 =?utf-8?B?SkpDenVyYm83YjZRVmkrejJWQkdQNHJYRzN3WW5kZnRpYlMzdW5uamZlYysw?=
 =?utf-8?B?RzJ6eEpwTC9IUEJiLzFGN0pIWTh6dGFuYWVWRzd0MjYyK2VlcU94UTllM29o?=
 =?utf-8?B?MnR0ZE9lT3JSVFZjbWxEbU56TkJVU04wb1V6aUdDTFFjRUZscU9xWHlVRUxt?=
 =?utf-8?B?ejdjK3l6cXg0SXFZMFo4YU1PbFhBTlR2U2lyNUZYR1pnWTc2L0c5cWhZQVVu?=
 =?utf-8?B?YkNwdUNYTHlPeDJEbnA2WjY1czhpVlp4MW0vbk5uUmF2RUQ1R0h0WGkyR29W?=
 =?utf-8?B?cnZsb09EV3orY25RWDNKaWluRUdKL3NsenR1TFlRcHMrZk45MjhuV2ZsVWpj?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e3b72-b846-45b7-23c1-08dac1df975f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 23:18:48.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkrWCbzxnZk7OSfPlSErHrsClzurfMznoJc++7+U38onGy+F7p8GN7oGQfhAWa5sJG0trVCosQAfTCjwOyuXEqHQRAUs63OeMdTqVXhFlpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2022 1:56 PM, Luck, Tony wrote:
>> Looking at some history there even seems to have been some work surrounding
>> "rotating" of RMIDs that seem related to what you mention above:
>>
>> commit bff671dba7981195a644a5dc210d65de8ae2d251
>> Author: Matt Fleming <matt.fleming@intel.com>
>> Date:   Fri Jan 23 18:45:47 2015 +0000
>>
>>     perf/x86/intel: Perform rotation on Intel CQM RMIDs
>>
>>     There are many use cases where people will want to monitor more tasks
>>     than there exist RMIDs in the hardware, meaning that we have to perform
>>     some kind of multiplexing.
> 
> That would work for monitoring memory bandwidth. But not for LLC occupancy
> as there's no way to set an occupancy counter to the value of what the new set of
> processes are using. So you'd have to live with nonsense values for a potentially
> long time until natural LLC evictions and re-fills sorted things out.  Either that or
> flush the entire LLC when reassigning an RMID so you can count up from zero
> as the cache is re-filled.

Tony helped me to find some more history here. Please see the commit message
of the patch below for some information on why the perf support was removed.
This is not all specific to monitoring of cache occupancy.

commit c39a0e2c8850f08249383f2425dbd8dbe4baad69
Author: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Date:   Tue Jul 25 14:14:20 2017 -0700

    x86/perf/cqm: Wipe out perf based cqm

Reinette

