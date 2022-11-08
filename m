Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B02621E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKHV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKHV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:28:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542DE3B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667942918; x=1699478918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XCTvvRYCOIe/BIu9RLS9OT1NrcFqRqpii03Li+PW/g0=;
  b=XY6JQCLBu3rs0GlykxiegnXSeB4428piX2xqw324UXIQeFIT5vaDhh75
   Y3nUAJ1X5nIyXhxA/1SUfRlZcDADZTF5d4Fd0qZviDHuw/vlKWncpeHCM
   jMhwNq/VNHenbLMvjCzVQfwW3ilM9dpvH3Mdsc4g/RlpnCYKfYrV0QWTg
   V8LrIU8G3d6lzQjK8Xv7SXGPa4CYZNAZ81JrfgnXR0SS8zxYoTWR710X/
   OKH6DiGd5Gs6Kt/5AlzDFiSoVyeIZedxXcu6swhvpzq/eBrKDZKaeVhOT
   R+0pNW7LC9sq3w+pcn9bCv75Ae9SESB6DthZBvOq8r/IM0lsdQKWZRnyZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298331570"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298331570"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 13:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614424560"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="614424560"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 13:28:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 13:28:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 13:28:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 13:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoNtCXk8K1GCUSKIhvX13QxuhbRjR48N85jt6OgoSVxuCK7G32S74ok8N7kDkPV51uM2VxLj2KDB2dBI8DhwSAPfmvrXwZwJmC6NQCnyAA6qlPsRL7M/Hm/APHNc+pZrCsZ4saNZt/m+AW9cUe+y6pt0lUiYGsmVrc+orjQdXXkw+K6hBBKWsE0ByYV1AazUrfzQAVQJQUX0qluXukSErRFDppZ4ihXFZajld5YqvzxTtRhZITccA+vmSgKPlBNA9MguyZq4XjBsSIjlMxvlsCFVgj8PyUvUPgSNW2ZN5/QsFF+HTcrAutV8h9U8h4Gnkpj3sSyrG5UlYg0cvu/L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kE9OyU2SJo8FsyhqWbCr1WIXtQ9/9TOaHCG/FAfHFhs=;
 b=W+OdpA8bcFryVbmY81P8rGytdqrnmm5AZfYRJPieQV4dX2Eqk4fwPwElgd1OhRwviTa4xOe8w+HeBooG4dv6QkLD7PlSMb2ZVmZJ4U7+nP1AXCMMimQN/evAhzRflGdN1cS+KvXM1nqXKnfBoQlI/gU4uiLQ/8+4Z/7MXhQjytY30jw6+VHGFr4EyiWQOg58KxO+g7C+i0LlwOo2Yt73OuvvS5f4UxYAYabDmbApi5cXvskqMdIxqeFs0sfoSN9hvoxNHMnu05ttyLsDtPinaOP+TwEDcEU/2zGiHQmon3GRY7QIXBjJkv9j9csjCnccGh/My15NK6l/C94Om8Nq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 21:28:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 21:28:34 +0000
Message-ID: <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
Date:   Tue, 8 Nov 2022 13:28:31 -0800
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f00883-16a9-4ca6-79c4-08dac1d030ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xVDQcgvk0os6yx1j7HuzseKYlm6HW70ILDF02MTVROYypg/bb105+To36tuNrxcMl6t1kQ+4gYxKtNMnW0rZBsZCx+Fy2oplc5hOGUuj57QF8omSeAF2g+SZYNI5RGNcmH4tpypGPxqWQELbHjcS34CNQD9f0a4yDxPw3yicXfzBw2I478QQ0oM5b8RAOCNaqfqND5HFZNRlJEBWxeN+CIRV8gXCriPqeQ1tYXpJiEDVitlLkwEmMuA3phn8u31ivMpxY6nAaVa+b4Ffv+5sEaPSD5zgPNwAoe5wMofggXno4+pFdK+92XNDpKgHt3jobz25LHziVL6X4JK91bNqSck4Vd76dKA3VRnkRBiUQTvwBv0+1QmKC53FMwyd52dcJPERAkmck2Bp7ODOjqHCDiem+i8fQXKjdcXOeUv8I1z6zJGnGOzE46tTJ1TFX1cBrzciaH1GoSA4hgkEljJLWbYKHO86sTbkMVgm36QRS+MBo3yOmEaJCvl9o8bJlPsL7PoOzLLqWOddPHoLj48aCE9L5EeJOjfMuG66rM1EmocFRA3aiu+UPKXFDBfpHgKta8CZ0+mQ5BTfz8qd3m6r3koDibqKxABofOJpeWYxDxtHTcb7wGQk3SVIWF7Lna0k/IlhE7eRJ4MW7LdmjG5RAs1gKHNFyNLNYwD/aatDCgqYtrXAtkjiwbkanjq1XZWtsHpHIJ7WTl9JdKCfF7Mk3NK+DZN1yE5C5Fmpp3CVAKBOkX/+jiOJHcfntFpBEu8kB0yOs+Z8+qCpaafooIsAUT5WtYC54DyDxug+RzplXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(38100700002)(6506007)(83380400001)(186003)(2616005)(54906003)(6512007)(53546011)(5660300002)(82960400001)(2906002)(26005)(44832011)(4326008)(41300700001)(8936002)(478600001)(66946007)(6486002)(6666004)(8676002)(110136005)(316002)(31686004)(66556008)(66476007)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWltY3pzc05MRDBpaHZUeU83aVJHeHlMTmZCUG5VZVh3ZFhXSjNZVmFjbDVQ?=
 =?utf-8?B?MGcwdk9heHhQSFhadEY3VGIzQlVINkM4WXM3QUx0Uk5kT054K2xpbmtzNG9m?=
 =?utf-8?B?a29FS2pVV1BDZmZFcDFTWXA5TGNjd3ZIZTR5V2o1RUROdmx6a0Q4YzJuU21s?=
 =?utf-8?B?UUluTk1xUVlGY1ZrRy8vcFhXeld5ODkraEI2TzVIYW5nUlBMb244aXhqU2dJ?=
 =?utf-8?B?akhTSndLdmg5L2JGUkpTdFo1djNNSmRySXFTaHpzbWxSV1JSWFhWNnJWayty?=
 =?utf-8?B?OTFQeWtIU3Y4REZWVVpqeGNrdElVc2lqd3ZyeFFQUFhRU2lpN2hFVzVQVWo3?=
 =?utf-8?B?UmNBZXJ5c1MyV1B2QW52QysybGJyTnhPaHEzdzVQbEtWQmZudURYZEh6U01s?=
 =?utf-8?B?YUFIQjQ1anJmWUJkL2hJbUtGTVRMT3hKRTR6YjFLUEp2NU1uSStUYnEwWHlv?=
 =?utf-8?B?bnp6QmF6cFgvbDJ1LzFHZ2RaZmN6Mk9xV0VDaXFYWU8zWFdqVk9IcHV0OUw1?=
 =?utf-8?B?bDBjWUxWWTkzeFpuRnZId2F1bW1UTkF2dEJQb29hS3VFckZGYkg3d2YxYjRY?=
 =?utf-8?B?YzU5bXBxeStnaDhMdU1jajJtT2g5b25KM3dJemJxK1R1L01RajNaM29QWml4?=
 =?utf-8?B?VHJYdGNmSUxCUGQ0T1RpYlhtMGpSbHFuUEJjT1B4eEZoRDJOOUMxeVJjWDBB?=
 =?utf-8?B?UnhKNnV0OFVQVk1XUWtDTXJCV0ZzSEV3Z2c0c0g2b1lmR3hXYVJZM0FETUZj?=
 =?utf-8?B?cGpnT3h1b2hWVXNLQkF4UGtxQ2I1QTFxQUpzUkczUXdMNzFrS24vRHh5NmZB?=
 =?utf-8?B?Rzd5cjg5UVJPWU4wMC9RNmZTMC84TXpHQWhJNGdEWTVVR0liRTNtVlNXTFZL?=
 =?utf-8?B?SkxEVEgzWllsaU9zYzdqMnI1UWRlZXV5bDFSdFVvTWQvdWVnQjFWSFVDNHlD?=
 =?utf-8?B?NXlMSGhFTk54bGFxY0ZMbUd1aklucUxxYm1iRk1heUVWcUZkajU3b0hMOEkw?=
 =?utf-8?B?Mi9SRUE5WVMrU0V5Y3hsL2lmTWttZDYyTUN6UDBsZ2tEd0Y5VFl5YlhCRnRD?=
 =?utf-8?B?SHJBS0FDNDE4dGE4RzBybHBWbnNTa1lZdWdwNnpuaFc2QkVWaXRybFVyeVhz?=
 =?utf-8?B?Mm02anorc2JBMmhxMjVQdzNGSFFLVmhIK2pNTDlVMjc2UytkQjltNDBrWkNm?=
 =?utf-8?B?VnlzeE8wangvT1EyOHJ6TWoyUEFJUFJ5UXVkVEkreEU3WEJsMjh2b2pEMWJo?=
 =?utf-8?B?M2xSVW4wNW9BbWVyK2VoaHcydE5INGNiUUg4YWt4dWdHZCt4anE0REFrRGlB?=
 =?utf-8?B?OXZBVDh3RkIyWUVwWWROcTU0SEZNZE5TRnJUT2k3cFJsYjlHM1dFU1NhMEdj?=
 =?utf-8?B?aU9WdEtKcUxnb2hqRjdFc3RiYXJhQkxBTHNKQ3Y3SjAyelhmOUZHVHhJQ2RO?=
 =?utf-8?B?T29oOFdXUkhkOVN2MFYwWW9IUWp4SVdkdUgzQTVUQlBWK3FkUTZUY2FZZzcx?=
 =?utf-8?B?WDBzMDU2SDFMY2ZYY1pGdFVVYU8wZGRZUmhhQUZkTHJTUVVjb29MRi90dkNm?=
 =?utf-8?B?MEJTem9tK0pmZ3ZTT1RVOUx5TFM3ZU5RMmhVYnJXaXZwNkJHTW9rbUkwc0lk?=
 =?utf-8?B?U25SOUFvNnZ3R1B2dEw0Rm5ZNlJFU3JGQjRPWHhIY05maW9oYVZsaHNsbkJK?=
 =?utf-8?B?c0U5cmNPOERlZFcySmJVd3R1dzBBR05LNTNoc1FlOGVyL2hKOHJuRWZxYk1W?=
 =?utf-8?B?K25lQjNCMkJHMW8xd1Zzdll1T2lJSXp5VnBEWGk3aGtMbUdoQ1F0cVlLUVNF?=
 =?utf-8?B?NmlJRm5nckMrdHJZTC9NWWtURGFNZ0N0MnJMY2s4cDJtc2dZMkFvTm0vZ2lv?=
 =?utf-8?B?OEdwTVZDTTYvOS94M04zM2tqZ1c2SkU3ekVEZlpCcFZlM3hFL2REMGowQ2U1?=
 =?utf-8?B?dlhBMmNOR2RodTdoTHlHRWdKSW1VR0N6ck9peXB3QjJRVnhMMEo4REVGRnZ0?=
 =?utf-8?B?N3htaVJ2cUxqR1pSVFNNazBMdUR2b3ZDYlBlTXhZOEJYcG90aWFYZHptbnFM?=
 =?utf-8?B?bzZTV0l5RHh2K3UwTWVrbW5EcVVQODdXVE5DZXRDWSthUFdQYW9JY1NybjBx?=
 =?utf-8?B?cE55NjI3d2tqdkpzenpmQ3UzWTkrVWhocHV6dTBXR2VNS3pUTVNZeVV4MUpm?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f00883-16a9-4ca6-79c4-08dac1d030ba
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 21:28:34.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud4ufZ5ZeLdUGwUM/asKVmKSgEZMbRR8jByW2OErk4ZQnKsWLF/TwrD2uNAV7FlJBaTt8nDEC92A0kPJ4AlXWD+lxD3Ujnw4N9I+xRkQYU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
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
> Hi Reinette,
> 
> (I've not got to the last message in this part of the thread yes - I'm out of time this
> week, back Monday!)
> 
> On 21/10/2022 21:09, Reinette Chatre wrote:
>> On 10/19/2022 6:57 AM, James Morse wrote:
>>> On 17/10/2022 11:15, Peter Newman wrote:
>>>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:

...

>>>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>>>> user who never creates child MON groups. In case the number of MON
>>>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>>>> PMGs, perhaps you would just try to allocate another PARTID and program
>>>> the same partitioning configuration before giving up.
>>>
>>> User-space can choose to do this.
>>> If the kernel tries to be clever and do this behind user-space's back, it needs to
>>> allocate two monitors for this secretly-two-control-groups, and always sum the counters
>>> before reporting them to user-space.
> 
>> If I understand this scenario correctly, the kernel is already doing this.
>> As implemented in mon_event_count() the monitor data of a CTRL_MON group is
>> the sum of the parent CTRL_MON group and all its child MON groups.
> 
> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
> then MPAM can export the counter files in the same way RDT does.
> 
> While there are systems that have enough monitors, I don't think this is going to be the
> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)

This sounds related to the way monitoring was done in earlier kernels. This was
long before I become involved with this work. Unfortunately I am not familiar with
all the history involved that ended in it being removed from the kernel. Looks like
this was around v4.6, here is a sample commit that may help point to what was done:

commit 33c3cc7acfd95968d74247f1a4e1b0727a07ed43
Author: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Date:   Thu Mar 10 15:32:09 2016 -0800

    perf/x86/mbm: Add Intel Memory B/W Monitoring enumeration and init


Looking at some history there even seems to have been some work surrounding
"rotating" of RMIDs that seem related to what you mention above:

commit bff671dba7981195a644a5dc210d65de8ae2d251
Author: Matt Fleming <matt.fleming@intel.com>
Date:   Fri Jan 23 18:45:47 2015 +0000

    perf/x86/intel: Perform rotation on Intel CQM RMIDs

    There are many use cases where people will want to monitor more tasks
    than there exist RMIDs in the hardware, meaning that we have to perform
    some kind of multiplexing.
...


> 
> The problem is moving a group of tasks around N groups requires N monitors to be
> allocated, and stay allocated until those groups pass through limbo. The perf stuff can't
> allocate more monitors once its started.
> 
> Even without perf, the only thing that limits the list of other counters that have to be
> read is the number of PARTID*PMG. It doesn't look like a very sensible design.
> 
> 
>>> If monitors are a contended resource, then you may be unable to monitor the
>>> secretly-two-control-groups group once the kernel has done this.
>>
>> I am not viewing this as "secretly-two-control-groups" - there would still be
>> only one parent CTRL_MON group that dictates all the allocations. MON groups already
>> have a CLOSID (PARTID) property but at this time it is always identical to the parent
>> CTRL_MON group. The difference introduced is that some of the child MON groups
>> may have a different CLOSID (PARTID) from the parent.
>>
>>>
>>> I don't think the kernel should try to be too clever here.
> 
>> That is a fair concern but it may be worth exploring as it seems to address
>> a few ABI concerns and user space seems to be eyeing using a future "num_closid"
>> info as a check of "RDT/PQoS" vs "MPAM".
> 
> I think the solution to all this is:
>  * Add rename support to move a monitor group between two control groups.
>  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
> unaffected.
>  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
> continue to count.

This looks like the solution to me also.

The details of the arm64 support is not clear to me though. The destination
group may not have enough PMG to host the new group so failures need to be
handled. As you mention also, the old counters will continue to count.
I assume that you mean the hardware will still have a record of the occupancy
and that needs some time to dissipate? I assume this would fall under the
limbo handling so in some scenarios (for example the just moved monitor
group used the last PMG) it may take some time for the source control
group to allow a new monitor group? The new counters will also not
reflect the task's history.

Moving an arm64  monitor group may thus have a few surprises for user
space while sounding complex to support. Would adding all this additional
support be worth it if the guidance to user space is to instead create many
control groups in such a control-group-rich environment?
 
> Whether this old counters keep counting needs exposing to user-space so that it is aware.

Could you please elaborate? Do old counters not always keep counting?

> To solve Peter's use-case, we also need:
>  * to expose how many new groups can be created at each level.
>    This is because MPAM doesn't have a property like num_rmid.

Unfortunately num_rmid is part of the user space interface. While MPAM
does not have "RMIDs" it seems that num_rmid can still be relevant
based on what it is described to represent in Documentation/x86/resctrl.rst:
"This is the upper bound for how many "CTRL_MON" + "MON" groups can
be created." 

> Combined, these should solve the cases Peter describes. User-space can determine if the
> platform is control-group-rich or monitor-group-rich, and build the corresponding
> structure to make best use of the resources.

Sounds good to me.

Reinette

