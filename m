Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D85FA8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJJXfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJJXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:35:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23462AA1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665444944; x=1696980944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lyQOUbImT9rldTcMiYSSLGexLSJgQFwoGFUapuuONO0=;
  b=Zhaz3ZXzqoUrTR0NOuyr7JyhdbctHNjWc1To7feXYM4IQFUqvGEVvNgj
   biraLKDo7aB5ylYnimYuOIU1/heXWGDb0qBFJmabj9f8cQmvxNNM8T7dm
   mM1+z3AaAiCgP3Ydwfi7glQWOdJtr0h959wTt4tRnBQxvnkHHNlXEwG0C
   VelmmHWUwKPc4NN9wCfTCeZWNoQ/UMLmg7RVUVa0MnjJMfLWqv4a02ZvW
   UbQXXyAUI+ZQCRwbQlWc0ylfdlJfgOMYiErJZaW6AaL9g9LSDgd3JCPrF
   QQ9njAisDjgiQ/sxLDXQpr4kmLsr750pnKFvwrKEkpA84jLfduMr+L1fr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366351802"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366351802"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 16:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577231497"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="577231497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2022 16:35:43 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:35:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 16:35:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 16:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj0w16nEuRuECoZVCQGwYK9ymugXUxUhBIT1+d4EptLDbJZWYtf1pCfS+uPO8SZvSdMOaJjflMNfG8OZj4S6+t5Psl6fYiV+e5szepL6f3HmaYVaUxKMgtyVsvIJLprShCjszM9tfUBKG6uWzQFHkTd/ZwePJuO1PtCP8oJ6zH48LsJkZi2d9qNArrnuTiSHiFBg/EdC/2kmOLzpxSsbdwVRwANMTYV1itW44Jh2KH1yoW81o2xLi18YioTVAkJWtXPVSdDdTpFZljGyKZJj6pB72c4iKRkhm+32t2iqBJT4clbTaj1oKxXdj/TKO3/iUlCPP+Jqmy1x8r/R7KlPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubu2uwcR+kCuIIO9twpz5n8aAfJSItTwY3QBCqBv2tU=;
 b=dEn3+BZ9J1JukiNAJAzpNLXpyrN17rK4FNwNByNHBqLFjz72jyE+cEISUrJcFIPapQ64/c4JPARCvZ2V4iMSch2a4pLyzC1N9aFl+gIkchdPtyazvFNKiyiQCVBi/49daFIKG5bZ+s/YmurDphcF2gPaYzR1jIdBV+71YWS7howB4wIkVAKRFmB0dJDQ1MJjtMY/fYKYa2V+T5sHLy5jqeJ5yvvmnzR9KDSTulSmQNULrCtYqpPrUnyi9veoPxn1Brul8K2Y18euP6h/Stt5sojumLkMRTezid/au49bX/xkGWKTHSIkK7w9UznhLJP+cnP1y3ExTSD0PS+hPx/riA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.38; Mon, 10 Oct 2022 23:35:39 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::7d5f:681d:2ff5:a7a7]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::7d5f:681d:2ff5:a7a7%10]) with mapi id 15.20.5676.036; Mon, 10 Oct
 2022 23:35:39 +0000
Message-ID: <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
Date:   Mon, 10 Oct 2022 16:35:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Peter Newman <peternewman@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6451372f-cc28-4eb7-1221-08daab182385
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PixuoqIc4SKKkKLYpZMq9cuTOcB80V8ijrbFqgWthKF70GtrBf7FsDaPrwVBC1pvQOs3fuz7xmvqgupPIOXHeaWQNDOErDEzk5c+mthPdglMjTPtUIcCSWlJMcb0DLLLPXWAEQZlMaDEK6hWuVFJy/Py9Aea4KZTlYD0RtcdNizGpTErbvXdqIEoQyrekf5M1krncBm4I3964KJpu7PKHHc6M3OBpPfNv/dEjBYRIt8p9tS52AlLlTYHkBMJnPx4cuGIqj53kT3qnc9BFXRtcLbnwoY4dH79XSNoYhrBSvZx8GC+ekeucUHtPDaVaZPovW948oiLUESPPJlM9POikzbSM2tlHtsoYZRMhSmiNC6Vo3hc8N2P2Q/JOVSk2R3j91tBnfy5Dqo+vTj1EAP/eu9lHc5XK9MCG+qSeyb9w6jjCmUm5IhCay4aJVNZNJL0wPeOc9SNjoXYMQT6AR5bMfhcc7q9DZdbDdAg0tJs+vp6JlX7b+gCdJ9xI/n9JJq9yJCfaMzZ0p1Ycp9B/jefiXC2WP0wuk60GqjfkiJDEQk1BlWHxm3qRSRyduUKigvKvjviWZHedLnxpu2G68tlyYnjfYA+RJzab36cPr3VTvn8WHKZJIb8loBIbTss8gLeNGIjQivcf89PEIElIHbxtaaTM73HMCSfEgBBNoG/EDbSbtc3bmhTe4OWKh49cIIbbHFRh5CThOSLiY3BfoY7BQ4Cfsc4NxY0DOUDHDKb99NcZR2mHkIJcXz1IRgTuvk7D0mS6Un6zKRA7NsekGXUp/NjPg2mNNlvd3OzMoVFsHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199015)(66476007)(38100700002)(82960400001)(186003)(2616005)(6512007)(44832011)(5660300002)(41300700001)(2906002)(8936002)(6636002)(54906003)(6506007)(6486002)(26005)(6666004)(478600001)(316002)(66556008)(31696002)(66946007)(83380400001)(53546011)(8676002)(110136005)(4326008)(36756003)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVrR25DbzVxaXZrT0dMYWFReTNSd3JQaGZCN09BaTZWRnY5U0dSNmh6R2tR?=
 =?utf-8?B?VS9RSEJiU3FBS1JacU5NUEhkZFd4dGNVQmFIckVFRVNIRlc0VEZMaHRPQ3pa?=
 =?utf-8?B?WmNlYVBpa1VnVWNCbmxQeWJ4Y3gzYWRFSGovQmpUUTdzOUk3UHNQK0hjeW5U?=
 =?utf-8?B?YWlPVkFEMytRaFFhWk5UM2w5U0NEK2NmT1ovbTNFendIbkFQay84cGhEbmpT?=
 =?utf-8?B?M0NreFZMYkUyZjRXZGpGZ2JYdnNXWDNsWEdmcmEycXVSZ2F4S0FHZElWQkxL?=
 =?utf-8?B?bS9TUkVLSm1jS0o2Qm5nNzhPVW91citlbGJYT2lRYXd6ZENJZVl1R0pMMFRj?=
 =?utf-8?B?aU02RURoMGthNVdpOUdCem01VXdYNU94ckxOTkNwbDh3S2VZMmRIMzQ1MWlN?=
 =?utf-8?B?Q3diR0hHU1JUVE02eHBqVlhZTzFMK2p4ZDNKb1U0MG41bTRVaUlNWS9TN2xP?=
 =?utf-8?B?UXVXbVVtakttTUhnSWhpU3dMME1LMElNQkk0aVNtSEI1RUVROHdudnJHTDBC?=
 =?utf-8?B?eXl0ZGpxSnhEWHNjL01qN0RpSGhkZ0JLeS9pTFd3Sk13d1RWZFlQRGhvTlAx?=
 =?utf-8?B?ODBJdVJ6ZGEwN0xTZEFsSFBuTTIxU0RTcHRhcU1tRFk0VDgwZlhXRDc5MTBn?=
 =?utf-8?B?WDgwLzJsNThEaTM1c2xZc2p6b1htWkZsZnF6UFZ3WVlFZy9ybXJ3bGltN0Yy?=
 =?utf-8?B?QlJQb3gzTGJQaWtHUElvTHJ2dHZsOWo5UWlnb0Uzd2xrTXNSd20xMnZaWnZP?=
 =?utf-8?B?VzlJdEw4TXhROWxFUDVIUEQxekQ3blBFR2ppUm1wdE93YW54WU1jL24zUTJ1?=
 =?utf-8?B?OHJGcm5reC93VHFPMURTYXZNVkNSeTZLTE5MdFBDK1RrTkkvOHJhem1GUnRh?=
 =?utf-8?B?OTdkSWpJOXlGaHFRdlhYd2FRSk04MnpLYkJqS0VmRDNvNnFHb3lEZzB4Yk1I?=
 =?utf-8?B?SHcybS9HUXpIelFEcVE0aklMbTJrbndOVW9ua21XeG9IeWNVdjNrUmZkUVA1?=
 =?utf-8?B?UUdxWnlrSnRuOHh1eXZCQ3NRbWxDRnR2T2JOeDYzRm1sL1BHc0Y1bkhuUElm?=
 =?utf-8?B?NXJkS0phOGtTaGFoeGtJTzl0Q01CSFpyT2IwdGNNM1JRNzBQZFVSZ20xNEtq?=
 =?utf-8?B?RmRjMjZzeW1hMzBtbEVNUFJJMStxbHFib04reUtRUUZVajdqNTRic1BDVmFF?=
 =?utf-8?B?Vm8rWnRVdTJocmdnU3F1WnRJK25COEY2YVM0RGNoOGpnYm5WU3grQjlxNVpz?=
 =?utf-8?B?aTBFc1pMUzR2dXR4ZGoxNzAzWkJRRml0OFFOZFRkeStxSEFWVkwzcjZCSzRN?=
 =?utf-8?B?MzhDNlB1YXVDdmtyQ2ROcWZxOTdXQWJoZUhLV0g2QWxOa21UbnlpcDBUZEVv?=
 =?utf-8?B?aXNSUWZMdTRwMHhiN3k3RkhRVEl3dWdCTjR5anV3cCt3a2FFdXFPV3hXMEpq?=
 =?utf-8?B?YlBrUXVMbThNekJ0NVZIN1BkbytMRUQvazBMTDF5eWQ2U1JTc1BuazFicndG?=
 =?utf-8?B?c0dKWEtYS0t4WkZkU1pzR1dkMVoySkZ3ZFNQb3MvN1lNT09RaHJsUjZ0Ykxj?=
 =?utf-8?B?RjIydHNsZTNxblFDRlFmMmo1L3pYaXowdEZObzJsWjFibER3S1pFeHlqaGFU?=
 =?utf-8?B?bjRYUXBLWlFjRGhZOS9FcDJQL1ZlUWVtUWwzb3Myejh6aHQvVWRBZ3RFblBa?=
 =?utf-8?B?d0FlelQzU2FXNFdvUW9ZVHdMZ2cvb2huVWFvRlRZZUVXaTJFSHlaVkEwSDIz?=
 =?utf-8?B?ZDg0d0ozYjVKMjkyeXE5amlWSkVHUkJEcXlSSEIwZ1dRQWo3cWw1TGExeU1L?=
 =?utf-8?B?M2RRaU5UdWtzdEZzQW1nZWQvVUQrQi9vb0tYbFl6NVhmSUlQeEllVmZXTEcy?=
 =?utf-8?B?eGliRGZxdkFLM0Z6Y3N1RHU0NzRoeEw4WUhxOTEzUVUrY1hpRVJEZmtuTVJD?=
 =?utf-8?B?Q1cybmlQNHI1M0Z6ZW9idTV5L3pIZ2F6SGYrQWxDTnFvZW5QK0NEQkRkaGx6?=
 =?utf-8?B?WWhkTVgwUy9RblRSODh1RERxSVBQWjlRVUd6a3ZhYnNYRzVtY3VoUGxlNzEw?=
 =?utf-8?B?NFJtcXhHYkZ1M09HSDkrOWU5WGVRdDl6Tm50L1VwQ0JKaXRZMkppNTZoaDJN?=
 =?utf-8?B?UmozT0dxLzl5YktaYlFXRUdBUzVjN3hwUFNkVGpWUWVrSVlwMmhqR0w2aGFV?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451372f-cc28-4eb7-1221-08daab182385
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 23:35:39.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vQ77RfRLkYjLvGqvJgRQ+cpZqHz+BAHFUc69J3/YINEiJLt60EXBEhmqeMc8LD6t3doth2SkdhDUPazdeJ+5kbfEuQ8UWSsut8GWpfu2Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2022 10:28 AM, Tony Luck wrote:
> On Fri, Oct 07, 2022 at 08:44:53AM -0700, Yu, Fenghua wrote:
>> Hi, Peter,
>>
>>> On 10/7/2022 3:39 AM, Peter Newman wrote:
> 
>>>> The CLOSID management rules would roughly be:
>>>>
>>>>  1. If an update would cause a CTRL_MON group's config to match that of
>>>>     an existing group, the CTRL_MON group's CLOSID should change to that
>>>>     of the existing group, where the definition of "match" is: all
>>>>     control values match in all domains for all resources, as well as
>>>>     the cpu masks matching.
> 
> So the micro steps are:
> 
> # mkdir newgroup
> 	# New groups are created with maximum resources. So this might
> 	# match the root/default group (if the root schemata had not
> 	# been edited) ... so you could re-use CLOSID=0 for this, or
> 	# perhaps allocate a new CLOSID
> # edit newgroup/schemata
> 	# if this update makes this schemata match some other group,
> 	# then update the CLOSID for this group to be same as the other
> 	# group.
>>>>
>>>>  2. If an update to a CTRL_MON group sharing a CLOSID with another group
>>>>     causes that group to no longer match any others, a new CLOSID must
>>>>     be allocated.
> 	# So you have reference counts for CLOSIDs for how many groups
> 	# share it. In above example the change to the schemata and
> 	# alloction of a new CLOSID would decrement the reference count
> 	# and free the old CLOSID if it goes to zero
>>>>
>>>>  3. An update to a CTRL_MON group using a non-shared CLOSID which
>>>>     continues to not match any others follows the current resctrl
>>>>     behavior.
> 	# An update to a CTRL_MON group that has a CLOSID reference
> 	# count > 1 would try to allocate a new CLOSID if the new
> 	# schemata doesn't match any other group. If all CLOSIDs are
> 	# already in use, the write(2) to the schemata file must fail
> 	# ... maybe -ENOSPC is the right error code?
> 
> Note that if the root/default CTRL_MON had been editted you might not be
> able to create a new group (even though you intend to make to match some
> existing group and share a CLOSID). Perhaps we could change existing
> semantics so that new groups copy the root group schemata instead of
> being maximally permissibe with all resources?
>>>>
>>>> Before I prepare any patches for review, I'm interested in any
>>>> comments or suggestions on the use case and solution.
>>>>
>>>> Are there simpler strategies for reassigning a running container's
>>>> tasks to a different CTRL_MON group that we should be considering first?
> 
> Do tasks in a container share a "process group"? If they do, then a
> simpler option would be some syntax to assign a group to a resctrl group
> (perhaps as a negative task-id? or with a "G" prefix??).
> 
> Or is there some other simple way to enumerate all the tasks in a
> container with some syntax that is convenient for both the user and the
> kernel? If there is, then add code to allow something like:
> 	# echo C{containername} > tasks
> and have the resctrl code move all tasks en masse.
> 
> Yet another option would be syntax to apply the move recursively to all
> descendents of the given task id.
> 
> 	# echo R{process-id} > tasks
> 
> I don't know how complex it would for the kernel to implement this. Or
> whether it would meet Google's needs.
> 

How about moving monitor groups from one control group to another?

Based on the initial description I got the impression that there is 
already a monitor group for every container. (Please correct me if I am
wrong). If this is the case then it may be possible to create an interface
that could move an entire monitor group to another control group. This would
keep the benefit of usage counts remaining intact, tasks get a new closid, but
keep their rmid. There would be no need for the user to specify process-ids.

Reinette
