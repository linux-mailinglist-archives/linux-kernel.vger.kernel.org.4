Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C623062333C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiKITL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKITL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:11:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE722251B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021085; x=1699557085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nDBK5t8PWah56zCY4czroNFb7yR6oQXHZA5Zv7r+Qp8=;
  b=lL+gdqIMq+MMs300bODsaA1Cn5/aTeiN5GGIgxEEbCSsN6JNqjWMcVqr
   Znpsv+yEcG3glKvKf0glJR1qtW7qW5SBQuvpnptgRr93/s+AazjeMKUSI
   vDAoMAbvcm9pFIy4D8ISIU9e7srfWHttmrM1bRQkBY5ZZeUeTfyUcivru
   3MHrcfR5UWUVUyYNLKGkBheZUGM+0L6P/DumBA8+tNoIBAv0kggyTWx+I
   0pUdnQdXEspz/cE6FWvhY2dwt7aPV+fbrx7ncIb7qve4KwPnd3PRoaiwF
   aEp0xCWe26WQhEc/VuuxLkJci5p7RtJtX6r+np2xFF2kMs25Xyk0/oYY4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337815875"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="337815875"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="614805265"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="614805265"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 09 Nov 2022 11:11:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 11:11:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 11:11:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 11:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdLB02RSsqRN394OhweovhUbS/lfDnOUcQ9HkUJwl4zT9ms6c1DdEwDhRDwGym/1Rhw5uwoAmaxg2Qce/2vz1B7xPmX6cCSSh81Rxdg5ukoEYNyrVC3JGzE01Usv9zFePnALnSLCaOvXIyy6YjJRPB9HKde7Vib/SRQ5hLW0qjjxL+X9TBnK8usa2Lcmae5Ki/jvtpiUMGi9aWa55LWYRxZKcoajHYrDPDk7Elf2oFg6/XV/swoDNhu1OdVLNGtrIK15RG6qTeGIdjdJ8HdR7crZEoGSRzdIXbTVPwjQ+V5B0qcyE5wcU7ls31YZIaubrCtbuKe3dlTxAuJlCT4u1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM8JMMIf0+qfeWOwQIbpNTD6XPl6qC1R4v5+WC1+yQU=;
 b=gGcBTXIkfPzc3NhefqNB/BoSuA/85y4fioPfLV1yVrQ2j7wbetU+cxZqGqU2xSiwZzln5CybAOyLjoKzNbWBl7MlE/Lbgh37EaSLCp+uI6CcRT28oA/2wco/4rc+m4O84SWFXA/YS19AeT1CBPoBf4ab0gPA4d4InNtlZeEwJq0NiFyrrhYmUFZCSSYrZX6+gwjjJWJ/8UmHi6Ug73LMpYE2kXaJBKjoc+lvwSpAT9sYX9/1qTd2A8vEXADGjU6K1a8GO1xXKoJNhHeIN12I6/PlEKrAIiW7vNruI6qLAkWaqcHH47N68QqXUxr5w9dg7lP5hSB9PEs29K8fOP7Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 19:11:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 19:11:19 +0000
Message-ID: <bd52ec90-52e4-32c5-132a-5d82304650a4@intel.com>
Date:   Wed, 9 Nov 2022 11:11:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        "Gaurang Upasani" <gupasani@google.com>
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
 <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8fe990-8b15-4216-cc1e-08dac2862e83
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5OvahnXoybJrWRdgqG5cIee2juVCzajoxLy4RPlVK/EXFkjMnTYfFcxONIztdzbyzxG7wWa1cWtu0JbMy7SwkADB7K5h6ERUaFCEJyQjUtH3ioozBhh9Uk3NpuMRlz33V7WYyTirRQERKK7IAn2In1i/Ors8adczhodJzc+vFnmJU5wFZ438UT7+cblBn8jrETsbKZsWr99AyrL6QPIfPYyB5h2h61qrKOUlL/HYR43oMg7YJm9J9AV54KvGw5Dl0ZSMR3FHwJE5egcQbA6j/Pzo7lBCqSRs7es8IPFowKivBvIqjBhjv12fbBUWjKBUhDt9510Y6GksFAtq1ZwQd4dOAyuaJXlZdJ00fPojibrCCUan+4oJwi6PXxGaTzU+mZ8Ror20AvvlbEz6QCGQA5j6P0CiBYGESI+gM9Ma8jeXndP60BM/ezMiDWxp5BY7hd1VLB7iFHkXj2H4OgilTowbfku3ia/jnIMi0dlT0q7EO9sHzJf6ZLe4zwZP1NlbanKePwKqzRXR+hpsU9PfvFzmfVgOamOfWmoWfscN7bTrOZsEiMiAaV72zDrGcrNVzHjcwvShVO5F62Z5Wp1Gv+fufMoCvH89DotlxgiRMhi+0BnHWK6UKmgKGIgAMGTE97rW7L8ng/eXlGMMDLuDq7rq/RThkSPLMnquJAEEhmlb3B3MkUsdiHHRCVckwW8mtfxrgt/vchlk8nCugt9m3UEFG+JMpT7OspEJKvi/s0ytWYygw01xjIwYgieIQooiUsq/s9yBSjNXWVCUfhewX/PFSdyF0mluJlytyvMINNHfo/ObJviYToV9qZVteLxBt1gZwcJUyPC67tCpLiiZl5Y/07XEf/2XrAEDSqaF0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(6486002)(966005)(478600001)(6666004)(31686004)(54906003)(6916009)(316002)(66946007)(82960400001)(53546011)(6506007)(38100700002)(26005)(66476007)(41300700001)(86362001)(8676002)(6512007)(4326008)(31696002)(8936002)(36756003)(2616005)(66556008)(186003)(44832011)(5660300002)(83380400001)(2906002)(45980500001)(43620500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhiSHYzdUI1c3hrWEl3TDdHbWpxTG1nZ1FneWZBVUlyWk5WeXRJODlFbHJF?=
 =?utf-8?B?RWFjUVM4MzFZdW1vcGYzTCszRkhYNUpRUmRLTUllM09tRkZjNk1xYlM1MjF0?=
 =?utf-8?B?eEN4NXFKRG9mR0kwK1NEVTh1WUEwLzYzOTdZYmhiWVRqNFdSeWpueUN1ZGIy?=
 =?utf-8?B?WGUxTzZ6M3g5S3FrR3poVnVnUFZ5RnpQZGZIZUVVdXFkUzRWK0xWSEQ5NVBU?=
 =?utf-8?B?Z1FsYlBBZGtrUHZtQ2pGNjRaUmtidlROL1FIZHYzSkFWL0xtU1Rib3pmRUFO?=
 =?utf-8?B?cUtFRDNDYnpnTUhsZlJYMFFYbUJXT2ROdVR2WDVPTlZVelVJMjVUWVZPUXJP?=
 =?utf-8?B?dUFaekdiMGk3TGd2S3FzOE8zYzI0QlZTVnVIUmVFTVdGVXFIQ3FpNGRaZDBL?=
 =?utf-8?B?cERDMklKRVF0UnhQb0gyUklmNkNGd3grOG5VbnhPVmdDazR1RlRrcEliWk5N?=
 =?utf-8?B?ajJ4ZTlhRlVDYVZhVmVsbmRSVGRsQXdxd0xuS0FMVnV2WnQyRHlSWDEzM3c5?=
 =?utf-8?B?YWVJMEI4N21Yd2VHSHp1N0tUdlk3YW5PRU9KN2NuS1R0ZU5sZGg4UnRqbkNC?=
 =?utf-8?B?M1ovWk9OVElwRmRyRHRPTTRPUHIyeEVQbnM5OTRCRXJ4NXpmN0JkVmxzM1o4?=
 =?utf-8?B?YkU0Q212eSsrenpubnVkQmU0UFhHOFc0SjArK1owZFJIVmlRZC83RU4wdy9Z?=
 =?utf-8?B?SytWUEs2SnFnRW9nOVZhSkc2UFE4ZlBQYWo0R01oZGN3ck42d1grcTNaOWdF?=
 =?utf-8?B?ZFRobm82bVloRlQ3ZEtxVE5BcVJvWEo4aDZWQytENjN3Yk1RcEZXTUEzVXRJ?=
 =?utf-8?B?NjRQZDRkM2MyTkpwaG8xOHAwdHFOdFY5YmUzUXkvQklZWExUOGJpY2R1clFC?=
 =?utf-8?B?Ykwxc3d1alJEeW1Zd244NG9PR3h0YmxXZHVjV1lsc3AwQUFvVE5UYXhKZ1dp?=
 =?utf-8?B?T1M5SjZuQlJwbS9rYzZXMEUvRjA3WUFQMzd3NnZWalk2UXpZb1BOZEx4NlBJ?=
 =?utf-8?B?b0U2dTB6ZjVMVlMwdTIzQXFObW5XcHVmYVQ5Rmw0cmZZTmVUY2cxMlhOQ0pV?=
 =?utf-8?B?N2RpQm9YdWNOOHJjd0o2bjh3Y1BTWWJBOXRTLytWcW93TmRyOFJwNDdGdk5M?=
 =?utf-8?B?czdMMWliQTIyUHFHNVJJVERZUlcyYXB4dHJaRVVZTHRwMU8rQjJGbXhXN2dr?=
 =?utf-8?B?TDB2bVpnY0t0OExKN25pL1hyZmlLR1dPencyTDBGSEs5TVV5V1RYdVY5OTJ0?=
 =?utf-8?B?ZEFGRDdOK3hBWmFNd2dOOERBMjA3MjNwM1Zjb2ZmM1gyMnpsMUlnTUZhbFFv?=
 =?utf-8?B?MnVrdHR1WVNPNzBQTEFBY1F1MDN4enlLb1pxdThOSk51eFhLWGZUVkpPV3ZR?=
 =?utf-8?B?aWdwQjFIRWRYMndtNnphWkRLUjM3WENsUkRmZW1TT0swOEpFU1p0b3JPT2Rh?=
 =?utf-8?B?RXFlaFRVdDFkcHBiRVRtb2NSRFVCSjByeFlBWDlzOCtPYkJjMm02d25FQXhx?=
 =?utf-8?B?ZVY2TStlcnF1bEx0ZERlZXlzN1cvcUtGQ1RnLzNHQVU5UXg0c1Q2NmN6OTFS?=
 =?utf-8?B?SzVyUUJYS3ZORnFadWVqekQ5M3lTZlRGUU9PMHBaOVdhMEc4bjE4T3V3Um5R?=
 =?utf-8?B?b3U1YXZsMG9uTWo0VU9pZXkxNStvSmNpZzY0L1hzTEQ0M0ljWVlsOTVvcVV3?=
 =?utf-8?B?VnFxUDF3REZKVHNFYU9WMmR1L2FyNGpFUzdXZ05vMTFWbTZqLzVIU3BheFhU?=
 =?utf-8?B?ZFZLdjVvREFiak9XSXFRUjZZMWdCTkhxUVlGTHRObUtPOFlZSzlDS2RhUWZE?=
 =?utf-8?B?M09YTG9VMURyVkh5UnpEUjRnNFdpWlFSRlJoVHVtZTlicW9taFBIRW15eXRU?=
 =?utf-8?B?QXZFNjNZQXY2eU5UdHVKczFhN2F6OXdrSVkxU3lHSzdMeDZHbVVybDVIeDEy?=
 =?utf-8?B?Qm1DR0RhQmJtNEZCNEFRWkhEcjFPRWpkYm5EbDRSbUNqYmpqeFNwMUEzSDJK?=
 =?utf-8?B?Tnp2VDA0ZGo3clk5RkpTYmNyMFk1NEt5WHNWQkcwbXpTc1NVV2F6SlVBTDZE?=
 =?utf-8?B?RDU0MzlwQzdTdDZnR1pEY29wZ2tsKzJKcE1XdWp5QU9HNEh2ZE1TWFV6TEEz?=
 =?utf-8?B?U3F5cXZVemprRkhVa3VoMHZTelZ2cnVGd3kxNWpDc2svenY0ZTVFSjlSeGox?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8fe990-8b15-4216-cc1e-08dac2862e83
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 19:11:19.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVMpG4kJjlrVsF9ewRr2mxK8OdlTgCIbHNsrZupeNp5lcrDhhZpSx3pYVw1PMnZb6/WE8WIjDPwMPbnYdCfaLz4g53ciywEXEJ1nhWDgF5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/9/2022 1:50 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, Nov 8, 2022 at 10:28 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 11/3/2022 10:06 AM, James Morse wrote:
>>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>>> then MPAM can export the counter files in the same way RDT does.
>>>
>>> While there are systems that have enough monitors, I don't think this is going to be the
>>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
>>
>> This sounds related to the way monitoring was done in earlier kernels. This was
>> long before I become involved with this work. Unfortunately I am not familiar with
>> all the history involved that ended in it being removed from the kernel. Looks like
>> this was around v4.6, here is a sample commit that may help point to what was done:
> 
> Sort of related, this is a problem we have to work around on AMD
> implementations that I will be sharing a patch for soon.
> 
> Note the second paragraph at the top of page 13:
> 
> https://developer.amd.com/wp-content/resources/56375_1.00.pdf
> 
> AMD QoS often provides less counters than RMIDs, but the architecture
> promises there will be at least as many counters in a QoS domain as
> CPUs. Using this we can permanently pin RMIDs to CPUs and read the
> counters on every task switch to implement MBM RMIDs in software.
> 
> This has the caveats that evictions while one task is running could have
> resulted from a previous task on the current CPU, but will be counted
> against the new task's software-RMID, and that CMT doesn't work.
> 
> I will propose making this available as a mount option for cloud container
> use cases which need to monitor a large number of tasks on B/W counter-poor
> systems, and of course don't need CMT.

Thank you for the notice.

> 
>> [...]
>>
>>> I think the solution to all this is:
>>>  * Add rename support to move a monitor group between two control groups.
>>>  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
>>> unaffected.
>>>  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
>>> continue to count.
>>
>> This looks like the solution to me also.
>>
>> The details of the arm64 support is not clear to me though. The destination
>> group may not have enough PMG to host the new group so failures need to be
>> handled. As you mention also, the old counters will continue to count.
>> I assume that you mean the hardware will still have a record of the occupancy
>> and that needs some time to dissipate? I assume this would fall under the
>> limbo handling so in some scenarios (for example the just moved monitor
>> group used the last PMG) it may take some time for the source control
>> group to allow a new monitor group? The new counters will also not
>> reflect the task's history.
>>
>> Moving an arm64  monitor group may thus have a few surprises for user
>> space while sounding complex to support. Would adding all this additional
>> support be worth it if the guidance to user space is to instead create many
>> control groups in such a control-group-rich environment?
>>
>>> Whether this old counters keep counting needs exposing to user-space so that it is aware.
>>
>> Could you please elaborate? Do old counters not always keep counting?
> 
> Based on this, is it even worth it to allocate PMGs given that the
> systems James has seen so far only have a single PMG bit? All this will
> get us is the ability to create a single child mon_group in each control
> group. This seems too limiting for the feature to be useful.

I'll mostly defer to James here. From my side I do not see motivation to
not support environments in which only one monitor group can be created.
My concern was the additional complexity involved to support
"mv" of monitor groups in such a constrained environment but I understand
from James (re. https://lore.kernel.org/lkml/8325a442-92c1-4170-1862-3bc891a8d6af@arm.com/)
that it is worth it.

Reinette
