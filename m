Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBF621E87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKHV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKHV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:26:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7765D6A4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667942767; x=1699478767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJmuX7LGwibYt/ADMBZ+U1NGmhYH38KOk7orBV3PRFE=;
  b=FobcZURhy4UAQ2DZCKs1ZBfjRjhHegeDKURbbrQWrvPsgyzjYTkbrnJ1
   eflmZyWfbYXcbxGX1FIglCGWAH7zy0XG0UiOKbIoPZXoW69ZdZSFxO93m
   y0jta/hjsVW9Zo3c2QhUgL7oINGiqUfSYZ9hx68ZlXByt415oSAYDcQx3
   Fbx2FZbS/Uv0jm3cro3y0qn7P+PknB30VgYfinklvSOYHlurJ+V8gVP7R
   O9DZmIEVRgt76Rh5b1EI7v1y1v4GYKX3kfPtIn7ngGhTicdJ95yc3by+P
   pyn67eEZu+p0n8rRl6ccKFUq0e+ENPcQUmr77aMtzWYuJL0LC7U70Q7gz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311970879"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311970879"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 13:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614423716"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="614423716"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 13:26:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 13:26:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 13:26:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 13:26:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBmprdiCa6mN6clRYy+cN9CHWrejxgVY2JhtM7N3XEliagQc2CEwYKCSYyyNv0YBgYIw8fGsv06RGKR5yCJPXC5NE3KM915ECS8Bf1Im6ZfR52ig37tPvdgDbv2PsENFwa48htfL0KJzWM5cJUe2PDUMb6Tx0d0YNgLbydyx60htFn0XLmAz8M216bzVbpuS+4eIMA6ensKmoW1qJw0Ru1DiDcWX8oOS1vUcKBtaes06wAt+nV6Am2VL2OfahSjxr+adPAcDpN2qaFfe0GG2cWYATHmGdhoCjCjNO44uBWlrNjbpe2jVih9KvK42NPfB5sPKaM+MDMBCEhSG5EC0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKIz+cW0tFetL8uyI1CVUM7E+RpVIyHs6aQrO+jmhrs=;
 b=m8oHmUnoF5ARelSyU//ompH4ddpIGKN0PGNOaWKgisA2pFaKzut+aFL/UkU0oFlDqDfWhxbqjgODIHjspWpOW6lJEGIRt5H9iuw9yaaY+R8gI/F05KNz63JNMxXeYcvRjTRxH67qwqQbUlNj1gRH8+ymWXK0ST7ugc7Yc4+kDSolF4WkdURns2h/XeqYW47SRxkKZOSCk+M9qQr6kpTDOjIg1gKsANzrzmUQJV4XoltA6DVxhmanHk/+0WJXft9N+zN0IbbFyeQpvPuAbnmwttDCFjIGnE0v2n4qBBxhZ/wz8xqUCRAtu9thRcDjcoBkOewsy6iiOSv1p/RBNDYRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 21:25:58 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 21:25:58 +0000
Message-ID: <0ba99cc2-e261-bd2f-1a0e-b317a625c57a@intel.com>
Date:   Tue, 8 Nov 2022 13:25:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
 <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
 <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
 <a4def722-aa98-6bf9-6e77-65a9fd9bd8ca@arm.com>
 <CALPaoCgdk_Yaw_EQ1ca9-h5L+sHBEkm3TpT-o84TC4AxWDSsbg@mail.gmail.com>
 <0c6fdf46-284c-6ed1-db44-a1e93037afe3@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0c6fdf46-284c-6ed1-db44-a1e93037afe3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b2a364-5c2b-4d6b-ffc5-08dac1cfd39c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLNR3sGtToA470i+z+0QUp/Ru7/W8xFs74Te/fWNg+N9nrwtmaYZST5ufFNE4ibLXeu8Li79WSfi8eTnfG07f2QpmHDvnKFeb3szH84At112X3HOSAb3UCGpeTtfdaQpSu93F4+0ODGHEjE8Xsph86kFVQXpkF1cgO0H5YFTa7PJTl7IB1QOQEf0QKlWMw3odukYeXFYDkcPD0k24vRlLd2ZyZmK49eiVKAjzFWyDRC7XXfutXBe5OmnhdaeIGlcUTOj3TAkznTe0ZOL/xLnqyIoEd5aSQkBHj6TnMmD50v+dvxv8Hb6/cKVJBWzYHwIg+qg3aMdUiUN+VsS9Ivq+5VzVGbwGShipWdwfOsFUmeGjNoFPTVgK5qfKDLnfiFHv4s1O9z40ynjoxVKgxtFkQYtrV+kJeA9+hAJOvzoaxzUL0IfgGu0oLOkZrxEbrMQA0lV4F3TSnBrHZ/n1zQZsEkGtU7fs0nFlAZwFoSb0x5+85KrMcRMOBnmlRa1utN59VukCdrrSnkort7FQoKmzOkKi8mvBHO7imyOaFHItmdNvHb1ST7A0bKj/Ikr41WzNINZktOE4FsdDEc5elg1DWk2LeTcG9tgsCK/9eNnRr5uVR21rR77E/q4hQ5eW03FbTKxKSpcUO6ufDzUKSx4eglYHeEwf7fr/xnCCBn7fw/gQKRI6GS9NIUvrvg7en30UiB+C053xgU2UtLbG/2gt4y9A3x6ePA+MJLf75kxcSnh9WDU2Sz4B88m1ARNtvbHogJuLYm8FmbDNHudBIXOVjUzXbS02c/ahT+QEjvgADc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(36756003)(31686004)(2616005)(66946007)(8676002)(38100700002)(316002)(66476007)(110136005)(41300700001)(8936002)(4326008)(6486002)(478600001)(54906003)(44832011)(2906002)(53546011)(6512007)(186003)(6666004)(6506007)(5660300002)(26005)(82960400001)(66556008)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FOSDFsNENQVDd1MW9oaEJhenVDVktjdHU2SXZJdnhETndzY3FhWGhlbEdP?=
 =?utf-8?B?WnNscDFBWnFwN2kvbmRBK1A3Q2p2T0toenp0WnU0THZuU01vL3FkZENvV2Iw?=
 =?utf-8?B?TjV2c0NsdEE0SmlMczduREJMTWpnSVNDSEMrUTI5TjdZTjRpYTN4OVNMZ0pH?=
 =?utf-8?B?ajViL21ZdDBUTDQybE9iaWZRLzhwbWFsTktRL1RjRS90N002N25XNlA1Vkly?=
 =?utf-8?B?VzVweEhiRTNKeFM0K09rOG1JV3Y0ZHowa0sxcUJIaTRjT2xnSWsvcGJLRGp6?=
 =?utf-8?B?T1lIRDhKK3doRGlKQm1pN2x0RnBjVzFqUjVPbmFDL3NZM21QQVNNTUJkNVYw?=
 =?utf-8?B?Y3pTVHNHVWNQL3ZWaDlzY0lYWXA5TkNvU1RUaGRvUzFLK1Voai9iRm5WbjVW?=
 =?utf-8?B?eFB4b2tuc3czdWFsd3ZBbkFsMXNVWE1zWjRnY29PWURFYm1SUFFaWXUyS21y?=
 =?utf-8?B?TzhHNXJ6clN1ci8rVUpXalJycUJ0a01ReU45STlwZWZ4aUVrd3dkcm56SmhM?=
 =?utf-8?B?Qk1xT0dQSGo1T3Vzd3BmdncvVFoxMUYyY2J2N3BLZlY2L013TWxtbzliUVht?=
 =?utf-8?B?MGtiWnN3SUZ2MXdvK203L0xLR1YyTHdZUTVkQ3pjOXh5SkVMMCtnY25YM2ZB?=
 =?utf-8?B?QlFqazEvMzNCSFdQTHY0QjBiQ1NhemFyWllMQ1U0WUwyWHJrZ2REZEdtVFdu?=
 =?utf-8?B?cUc0WWw1RVFUV0I2SFpRdzVwWXpyZ1V3ZENRaFFuVE52ckJFTlF2NnY2UnZO?=
 =?utf-8?B?S0NIUUo1MEFrVTUya2V4ZS9sUzJNZi9jamllRkJBZUtaMnpBUHVTMXM0TnEx?=
 =?utf-8?B?dmhYYUcvdmZya290cFU5QjVjOWVCL2d1NEZ3NU9YRGpvQlM2L1VEb1AvREVm?=
 =?utf-8?B?N1NwSi8ra3NzOFFZdkt2aEFsQjc4blJVNGFjY0pYVVI1QysvM1dHLzFBbWtv?=
 =?utf-8?B?Ris3NEtaR3dkMFA2VW1NSDJMTmRXNUNNelFKRFZpR1FZLzFNUGgwZXBFNG9n?=
 =?utf-8?B?ZVRPY1pMOGhIeE1NTFpmSE8xaWFZdFhBZStDMjhPSjR4bkFCZ2x4THk5eXB1?=
 =?utf-8?B?L3ZOL1BaMnRtMDR2Z0g4RFlKYW04RHVQcGJTL3NRQ2JxZmJzVy8vKzJrUDFq?=
 =?utf-8?B?eEV4YXlXVERJQXRVeUZqdG93TjVzYklIYkZFL2pZRExXNURNMDUvZHV6WE5l?=
 =?utf-8?B?QSt2YURDcjI3TnUzSFNCVGFJRldsSjcrWWVzVDdTSU85TDZwK0NjWWtkRlJx?=
 =?utf-8?B?OWJSNmVaNSs0eHprRmhRN3Q2d0xJOFBqYVFYbnNnTGJZcEMrU09CbDVBeFMy?=
 =?utf-8?B?bFE3OVJxelFuWmdLVVBqRzBFRkJIZzVhb2E2MWIxWjZFbGYyeUdVNVRYRFdm?=
 =?utf-8?B?TzBoYzBSNjZMMHMxRlJsMndMclNVTzJzaGk3NVdhYjhkUjhjemVDKzhsanBs?=
 =?utf-8?B?cFEreWhlRkhiZ29CRVRrdWd6Tmgxbk9reUNYU1Z1T2NsN1NOU0xtbVE1QUJx?=
 =?utf-8?B?OWNZU2hmMGFFZnpMdjZOeGdiamVmd29zTVAwTjZRNXF0SnJrTEFuKzdTYWRo?=
 =?utf-8?B?VUZCVzlhNWxWRVcrOXorbDBMMmFvVlV3SjRoVktXTjlNcjZoV0dPZmlweHhs?=
 =?utf-8?B?SmJmbVk1c3hnVEdGNytRaFpWSDlYWTBWcENYWUNBTnpwV2Vud2pKdWNGNWU2?=
 =?utf-8?B?Mjl6R0FTcnlVNS9CMzl2eUdCTEp3RVN5RFJ3YnZLZ01WVUtRdXppTENHUURu?=
 =?utf-8?B?L1ovcDdlMXEzdFNpZ1dRWGY1Z3ZnclQrNUxOWjhLU2xpYjBVSWwzbFRHMmRI?=
 =?utf-8?B?eCt1UG8yU0lJMm5uVEIxQW85RmRxZ2h3MUdlV0hGeUpwSWsrVTBwd210WE5O?=
 =?utf-8?B?MmY3aWJMUjJraks1SHEzSjNiRUliLzhrZzRmK1NLdFZTNUViN0JMYm1zaUpt?=
 =?utf-8?B?UDJmeTN5eEFTQi9PTW0wWUpGNHdVN0tweVJoZzR5MzBCbVJ2R1N6c1RyTFkw?=
 =?utf-8?B?YUpGRUVudEpMeGk4amJEM2NhekpybTZiYzZpVUkwN09PTHBhQVNPbnExN2tY?=
 =?utf-8?B?Vm95Ui9QclFsRjBmU3lUYzJDdFJLOHJsRC9Ua3NPTWRURVVPUkdGZExISi9w?=
 =?utf-8?B?R0p0VWI4dTRsM3dyS3EvbjJMTlFNcWV5OWlQM0Z4M2tXbCtHSTNEakhBSXA0?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b2a364-5c2b-4d6b-ffc5-08dac1cfd39c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 21:25:58.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTPwWMmjyS87iVkH51jlLkz0nz2c/JOyH+Mbw6sAKCE+mpywmmtrv9l0TpflUoqEyPbgm57YhWhWDRr5FB/6HO6dKXMRX83oyKXRJWi3+OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 11/3/2022 10:06 AM, James Morse wrote:
> Hi Peter,
> 
> On 26/10/2022 10:36, Peter Newman wrote:
>> On Tue, Oct 25, 2022 at 5:56 PM James Morse <james.morse@arm.com> wrote:
>>> This would work when systems are built to look like RDT, but MPAM has other control types
>>> where this would have interesting behaviours.
>>>
>>> 'CPOR' is equivalent to CBM as they are both a bitmap of portions. MPAM also has 'CMAX'
>>> where a fraction of the cache is specified. If you create two control groups with
>>> different PARTIDs but the same configuration, their two 50%s of the cache could become
>>> 100%. CPOR can be used like this, CMAX can't.
> 
>> I thought we only allocated caches with CBMs and memory bandwidth with
>> percentages.
> 
> Those are the existing schema, yes.
> 
> 
>> I don't see how CMAX could be used when implementing resctrl's CAT
>> resources. Percentage
>> configurations are only used for MBA in resctrl today.
> 
> The problem is if you say "CLOSID/PARTID are random, its the configuration that matters",
> you've broken all the control types where the regulation is happening based on the PARTID
> and the configuration, not the configuration alone.
> 
> If you do this, you can't ever have schema that use those configuration schemes.
> There is hardware out there that supports these schemes.
> 
> 
>>> Even when the controls behave in the same way, a different PARTID with the same control
>>> values could be regulated differently, resulting in weirdness.
>>
>> Can you provide further examples?
> 
> CMAX, MBW_MIN and MBW_MAX: You can have 50%, and I can have 50%. Your secret clones which
> have different PARTID and a copy of your configuration also get 50%. As far as the
> hardware is concerned, we're trying to play with more than 100% of the resource.
> 
> I don't know what the memory controller people are building, but naively I think the MBW
> MIN/MAX stuff is a more natural fit that a bandwidth bitmap.
> 
> 
> You couldn't ever add new configuration schemes that are based on a fraction or percentage
> of the resource.

Thank you very much for catching this early and highlighting this. Yes,
MBA also falls into this category so using different PARTID/CLOSID in the
same control group is not an option.

Reinette


