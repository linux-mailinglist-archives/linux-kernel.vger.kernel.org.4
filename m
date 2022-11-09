Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B119762333D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKITMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKITMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:12:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202B7272C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021132; x=1699557132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=39luiziHpo+Uyf/2g4WQjsYNl+NfI6/3wYxv7gbk6mo=;
  b=d1F07NxOgLYEETgmQlxVENfnUs9toeG/XU0l1P+YnbyObOVva89GLPsM
   cu/ml/U+TtlDZBNFz1Vz5KTRc1PF4jpdpuloJYhdB2kYP8bxfQtQT0jJk
   jkbpwfHP5RihlTl/QBGhx6nb3u4ngQZ9qhS0qPS/d24awgcDEE7xacXwc
   pqiAWXMPb097ZxITCPvOxiCJ5uveC/FTyfzp4amiCyrzvLIt1Q2/Re36d
   XxIrFNVJn9an+3CrL1+A7y2P/6uKWy6hi2lTcVfmXfbd5/Pd+w62eAPnC
   R4ZcpUggIQJPOIHtPL91n7hoFe2gm/ZQ39c4Z3YYBqlbxa+UTgnLnsfr0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="294449397"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="294449397"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="670067868"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="670067868"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2022 11:12:10 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 11:12:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 11:12:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 11:12:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnKcL3vKjQwBspW8nT3NevkAC+h0eV0iwkX5fSI0LYlBiJQsqrOikDYasaXLeLn4w8bfQHn5uRjcGq2btj2ItM77FS3V+ZI3M3Z7C7yyNfWqctTgLz3zC2Jq8JU0JJ8clp0x6Uqw1zmmyaZIequNEp1h8MXD6vjEadUwAJXveY25hOZxA1G2nRiVtnZv1WndvAxirh/nf+qsck1z1Z0TBw59xA9jKTAAmrQfFfG0A8BXMS2BS7GQtftQVeLQp2LDymN8VIk2EUWi1uOFpiu0gACitU5NGBBIooJDdUZTGjQTqtA1HfmwImKzFCB97uTHgWwNPYFQPp4kRbmi9v3biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqnBqcsO+KiKDsVfukQW0ThBslOC/6Zfc5Xp5Kd16yk=;
 b=muQcxBm5m4PWJGWLjBiQdmwl1EEQYq4WmgvT8b8tWfjB1y3h8QlpzHn5twZCVbWRhd52LdlOxZbbJD7SWMaCG4n0NxU0n4poP8LEfdJYRzLv59tLwrtKwaiBBkVQWDusmm9CpjP1qXYKPji6lckF2gdzKE97Tm80djhd9swXdX+9J7Ob7qykftAfwxki/dZ+u8Qs9wfRb+LWu1hPH+8l7WVR2996nR6FFhf7NZLqoCIzS8TDcpghy/w48fNdShjo/GrZXRsIDh3sqTozATLFeiuFN5GfFgGxmoeE+ZL8bGg/fusWUvhQymRtgWidoAOtddjG8JqaIxQMXTfpLUwc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 19:12:07 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 19:12:06 +0000
Message-ID: <eb1a0949-dbd0-482f-d19a-738cf8842b96@intel.com>
Date:   Wed, 9 Nov 2022 11:12:04 -0800
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
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <8325a442-92c1-4170-1862-3bc891a8d6af@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8325a442-92c1-4170-1862-3bc891a8d6af@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 6893c949-8a37-4282-a3a0-08dac2864afb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTTZd+cyvJ2nFW5Sd1oBz2J+zyqc0qJJJOiWq1DbGAtLLZdOjvqX2lNsb4p1cE+W+3dhZJ1QWdgm4jaXyqCdEmh5Dm2RspTA5L+14E+//Vy/w/MxO54yKPAiwkokLq1k21ok+wfp0RkSAxrnoI2ATh+cjWX/0j+SQ0tdY7eYn6x0SPwEdLx+bVvdV/mUoxwoPv/nn7UlcHwAOLDwYI6kZ4TYPVA7BmWJIAmr20/tlp1r6iAmjqy9gKoo1rysWALNtLoYOKx2SsDZ/r19AD25qBFfCUQu52yLR5KWs4ZDQ9auUHVdELqJ9fAsRCIZM2BPoD1Ij8bNfWfGHd7cK4m2FQbnxgt6El/RLUvbdEFK2eKc96xF+C5U0UPgAQif56BwMtdr798c2b/oZJ7alvro08lbmxJ+q//PmooINifeB8CqAUaetergAygy2bsR4PFpxPbrbe1mDNCBAn4bF0in7Y/pTgSm4NwxieVYSytlmYLMUi3xYIchAYWyK00vMpnHAJ60EjmOnDTwJmb1bX8g+uYysWZ36IrYBGe1skYbnhzOtXsoC6I7z81o1BpqYIq80jDUWr2IiNwu/4tXjwSEQKc2tz7q9soqTfv9/yY05LtpNo4ugOvCmwfxAjA2/IWNDLcdoYpmF1eymtIGVW3I+BjAmVgBXUAht/ZeqhupS2laVV6ynXTW4X9tTt1XWwW5lBW2RuR1nBSMekkwwA+s0n7QX4AzDUPrR5hlUMwz2p3I9cIcm1dYyhCd0UCiSonSGjosvgvGYxllWs+4ACafboNTqlJE0KRe+4GTvDbS2YSdpj7ctGqiZD7cDYy/68MQWnJ+2t2C6DY9VszqxTwoRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(66899015)(31686004)(66946007)(66476007)(66556008)(316002)(8676002)(4326008)(36756003)(82960400001)(38100700002)(41300700001)(31696002)(86362001)(966005)(6506007)(6512007)(53546011)(478600001)(186003)(26005)(6486002)(2616005)(8936002)(2906002)(54906003)(44832011)(83380400001)(110136005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVxaHhaQ0ZrSlloVUdqalRxS2hFaE5OUVZqTXkrL2R3dk1NRS9ldlF0YTZ3?=
 =?utf-8?B?UWpuNW9JNmFwMmN4OTB3RWFCOUlHQ2JCNnZoYkpzU1NNdnNmN1BXTlU2UHlq?=
 =?utf-8?B?SGgwVGtqZHFsanZad21adlpqdUwra1pUd09ZK285NkdYRXhQT2dIMmtEUlFI?=
 =?utf-8?B?WG1tTGJsQzVVRnUzYzhYRk9SVUswUVZISlA2MXhXWVUzTGJzL0lNS0JKVUI0?=
 =?utf-8?B?Qk1Oc0lKY1lJNGJWa3ZSWkFGTm9MYlhzNm9mTVhiSERDVWxHVEtFT1g0ZmRY?=
 =?utf-8?B?L3AvMXY0QUNNZ0cvSENBSEtpNTBtYnA0TnJRcmZhaDUza3ZWTWpCMkdCRHhs?=
 =?utf-8?B?dm1tS05oam9uSFVIV0o3YnZiRE5PTUxaVWFlRytEcWtWcUxVQW5NMXpsTjRU?=
 =?utf-8?B?SHp2Zk50RnVMMTBRbXJJNldKenhCUEFNelhhLzVyeHB3S1hZL1ZwS0w0dVFZ?=
 =?utf-8?B?ZzNFdHFqMExHNGRaOXZMSGJuR0xxR0hER3ltdGJicUtPTkc3UFMwTHFrclow?=
 =?utf-8?B?MFU5a1BVcTdWNEdsUDhZOXI3Vlk4SGFhdmczNEdzZ2FDdlhBdHBNb1NNdjhV?=
 =?utf-8?B?VVdNVXhjNHVpU1AvY0QrS3h2VGdiV055ZjVUai9LNmxKSTQ3UzlmQ21Ra2JY?=
 =?utf-8?B?V3Y3RjMraXBKdHhLc0Z4blppZFluckZ0eGVxZkMzNlllTEV0SmgvVmpnWDRr?=
 =?utf-8?B?Ni9YS3hWR2dZb1lTdVJWWGk4MHVETGtKTW5BMUYxTjkwWVMvV2UrWUl1K1RO?=
 =?utf-8?B?YzMwMVJQM1owUTVhSkdhaE1nUGJvejhRSit0YmpJVm5rZmZBUzFrNXdISHhI?=
 =?utf-8?B?S2pBaEE5WWFvUHBxZTZtellERmQ3eThGTlBqbDVUOW5KeEQzcFVUcjZoTzFD?=
 =?utf-8?B?Z1RQSnBBd1JoZVgyVElVMTRGT0cyR1lyMGZkN1M1MTkwaWhVbnh1Y2xZa2di?=
 =?utf-8?B?ZkdZYkhHYmJoSzhaOUVRUnozYzNtaDNoclZvdmkzYVVqOCtSZWEwREFEOFg0?=
 =?utf-8?B?OFBQRjdJRjh2SFBkaFlLVGNlbUpuTWltVForVzF2bzZhRVZlZitDblE3aTZY?=
 =?utf-8?B?RE41TDVxRk4rdWJwSlpkeTZXUmU3dlFsZ1o3ZHI4Y25TME9YaFYyL3UxK2dn?=
 =?utf-8?B?Vk05akRTc1hxS3ptTzlKU3ZSeHNpOU9MTGxEWGxSTzVmMkprZDQydFZRQ0RM?=
 =?utf-8?B?aG0vZXdJcXl3d3ZqZk5JWkpBR0J2V3dkYS8vSVVsYnkwT3pjNXlzSmNRY2N5?=
 =?utf-8?B?ZmV3RXk2d0U3NHc2dDBVVUVRaTBwdUdodzYwRkRVNUVQZ3RLUTVjQmJsM2dx?=
 =?utf-8?B?aERxZDFVanpsbmZpaG5nMi9IMkxCVVhGZnpUNzhhc1ZER2Yrd3VHM0I3bDB0?=
 =?utf-8?B?b1pBemNyWllMbTBYMjBHcUovQ3p4ek42UTRKNTZMdDd5aXovT0lRZVoxVmZV?=
 =?utf-8?B?NjIwamxZaEZya25MdDA3bzhibmtVbXc2MHZTY09FR1p1c3JnbTMreEZqbTFn?=
 =?utf-8?B?a1NmWFJMalBtSi9uWStnNGR1NGdqVlk3endXeVpWcmxTZ0c0WkxqSTI5bUtx?=
 =?utf-8?B?bXdNR3B0d0JDK3ZKdjM0WStLT2RkeFhOZDlwbzIvVHBiL1lOaVpFTFpobG1R?=
 =?utf-8?B?cDNzRVlSVjN0MHR1RXc3VXByYWQ1SkRONXFCbjFVTEszbHYyL05VTjZ4b3Bt?=
 =?utf-8?B?WjhvRnZpSi9OUkpaRXZ6MUdEMEVaZkNTaGtZaDlTVkhBRU5jazhjVmF6cVBP?=
 =?utf-8?B?SzFEMnMxektGVkR3bkFIQ2NXMEd0ZGhLRXZTd1dmUjY2YVVxcmdiWHlnTmgz?=
 =?utf-8?B?bzIrUVFrVzNpSkcwRlV4L2pVMjgxdllHRFExZDZQTVhpeEl5ZlAxSityeVBF?=
 =?utf-8?B?L0lZRUJKOFFZd2hzM3ZVaXFUTytWQVpFK1ZFOFFuWGJLaXN1Q2lqa0ZURUlx?=
 =?utf-8?B?QjVtd1N6eklDT3dxSG50QlR4UVErTVhwZTJVY2czSy9Ua3F5MHhaN1dlMXJ3?=
 =?utf-8?B?Q2I1L3VzYWN1L2JiUVRsZ3NVWjJna2hmSDlOeW5hay9kNVU1bTVQWnlIZnlB?=
 =?utf-8?B?Ny96Wkd6YS9BaHJYYjFnNGFmNXRFaWV4SGVTVkdDNkIxeGhpM05Ka2RpRGpU?=
 =?utf-8?B?aTJJS25oaDJBU2Q2cFptRE8yUlNzSGxKT0g0MmVxWmJGQVc5ZFYwblZueWpT?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6893c949-8a37-4282-a3a0-08dac2864afb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 19:12:06.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVVrh19JiUNLz6G/XIZpOi8Nb+3ZoEGSsL7SC+egx/Qjs9A2jffwVXssc38fqy/L5IzCU2BX3VZ96rOY88Mjt4Wp1s7nNArJEwefHG0Ueqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 11/9/2022 9:59 AM, James Morse wrote:
> Hi Reinette,
> 
> On 08/11/2022 21:28, Reinette Chatre wrote:
>> On 11/3/2022 10:06 AM, James Morse wrote:
>>> (I've not got to the last message in this part of the thread yes - I'm out of time this
>>> week, back Monday!)
>>>
>>> On 21/10/2022 21:09, Reinette Chatre wrote:
>>>> On 10/19/2022 6:57 AM, James Morse wrote:
>>>>> On 17/10/2022 11:15, Peter Newman wrote:
>>>>>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
>>
>> ...
>>
>>>>>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>>>>>> user who never creates child MON groups. In case the number of MON
>>>>>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>>>>>> PMGs, perhaps you would just try to allocate another PARTID and program
>>>>>> the same partitioning configuration before giving up.
>>>>>
>>>>> User-space can choose to do this.
>>>>> If the kernel tries to be clever and do this behind user-space's back, it needs to
>>>>> allocate two monitors for this secretly-two-control-groups, and always sum the counters
>>>>> before reporting them to user-space.
>>>
>>>> If I understand this scenario correctly, the kernel is already doing this.
>>>> As implemented in mon_event_count() the monitor data of a CTRL_MON group is
>>>> the sum of the parent CTRL_MON group and all its child MON groups.
>>>
>>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>>> then MPAM can export the counter files in the same way RDT does.
>>>
>>> While there are systems that have enough monitors, I don't think this is going to be the
>>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
> 
>> This sounds related to the way monitoring was done in earlier kernels. This was
>> long before I become involved with this work. Unfortunately I am not familiar with
>> all the history involved that ended in it being removed from the kernel.
> 
> Yup, I'm aware there is some history to this. It's not appropriate for the llc_occupancy
> counter as that reports state, instead of events.

Perf counts events while a process is running so memory bandwidth monitoring may
also be impacted by the caveats Peter mentioned for the upcoming AMD changes:

https://lore.kernel.org/lkml/CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com/
("This has the caveats that evictions while one task is running could have
resulted from a previous task on the current CPU, but will be counted
against the new task's software-RMID, ...")

...
>> The new counters will also not reflect the task's history.
> 
> Indeed. I anticipate user-space is sampling this file periodically, otherwise it can't
> calculate a MB/s from the raw byte-count. I don't think losing the history is problem.

Indeed. Cache occupancy may experience more corner cases depending on
the workloads. Your point that user space needs to know how/that counters
are impacted is important.

> 
> The state before the change being lost could be a problem, but this is a difference with
> the way MPAM works. I think its best to just expose this property to user-space, as I
> don't think its feasible to work around.
> 
> User-space would probably ignore the counter for a period of time after the move, as
> depending on where the regulation is happening, it may take a little while for the CLOSID
> change to take effect.

Agree.


>> Moving an arm64  monitor group may thus have a few surprises for user
>> space while sounding complex to support. Would adding all this additional
>> support be worth it if the guidance to user space is to instead create many
>> control groups in such a control-group-rich environment?
> 
> I'd prefer it didn't exist at all, but if there are reasons to support it on x86, I'd like
> the MPAM support to be as similar as possible. I'm willing to accept (advertised!) noise
> in the counters, but a whole missing syscall is a harder sell.

ok.

> 
> 
>>> Whether this old counters keep counting needs exposing to user-space so that it is aware.
>>
>> Could you please elaborate? Do old counters not always keep counting?
> 
> Its not new - but the expectation is the mv/rename support does this atomically without
> glitching/resetting the counters. Because of that new expectation, I think it needs
> exposing to user-space.
> 
> Something should be indicated to user-space so it knows it can move monitor groups around,
> otherwise its another 'try it and see'.

ok.
 
> 
>>> To solve Peter's use-case, we also need:
>>>  * to expose how many new groups can be created at each level.
>>>    This is because MPAM doesn't have a property like num_rmid.
> 
>> Unfortunately num_rmid is part of the user space interface. While MPAM
>> does not have "RMIDs" it seems that num_rmid can still be relevant
>> based on what it is described to represent in Documentation/x86/resctrl.rst:
>> "This is the upper bound for how many "CTRL_MON" + "MON" groups can
>> be created." 
> 
> I agree it can't be removed, and MPAM systems will need to put a value there.
> The problem is 'rmid' has a well known definition, even if the kernel documentation is
> nuanced.
> 
> This might be contentious, but ideally I'd 'deprecate' num_rmid, and split it into two
> properties that don't reference an architecture. (Obviously the files have to stay for at
> least the next 10 years!)

I think this may be difficult considering the various user space clients
already in use but doing so is reasonable. 

Reinette

