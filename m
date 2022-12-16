Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9843864F420
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLPW3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLPW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:29:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A560351
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671229778; x=1702765778;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MROnQ0WHmyqY65bYDUAGRtI7aeoBn0QXVSJE0OV8P1g=;
  b=B8jBcloQuWpvsaNZSzCp0jvUSP2gWk99AiVBIe7OWxTNfL4dftj2+lGl
   OxQL1BS1Ped2KO+1J+vXKS1RSiPjywKeJnHqH7e4oY6aHMxnYe3ebaXp7
   lQJQiyp5wJLD6fwINWrndLnQXoyYvEbICRjYgLTzbIWO+HPLOvNYwnT2o
   j77C8S6cJomoza0336ZgvQnXCJrp6/Ezkkh6hdWCP07j6Z1tHYSzyIaD6
   MtyylLO8FibnWzoIZyMQmNolV118NdbWF7vUWAdO6rboXOG+ZL0+lCvIb
   d8CLUWb5Jik4ICGPLjmAWY+UNe9R87783j0z6VcMWA0R3EGwQ0tvngN1Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="383409808"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="383409808"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 14:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="627697097"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="627697097"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2022 14:29:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 14:29:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 14:29:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 14:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiYKV3L+/ySgj1bSmVFHrEMWDULaOvWpFX0St1x8QzDHPzs2cl0UOzD4owZBKVfDSYJ+Mp4Dig0rrbzHXc/w+ubbe2nAnY7NsEG6sTwfTv1us2spkM/2EcozMYDszRFqTWY6K9x1XoXN5sbttoZwtXenC9spmXC60u2m1n6o2M4+AVi97Dgot+zqBsRZgLdq2xnafR34Pb8mq7LnDmybw76CkAim2FYnVj7evIg2petyWP6LY7ItWh4rRy/8Uu9j2dAZCQ6o3LJjAjEwmeRSzu2uNxtagYIH6U7S+X5aPfYqYPAUhuGANFPYKDW6k/0JtL8aQa6Ujkok5IbN4BKF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPahoihNGoTNOVA0LTRFi4jZF3Q7DefayYVtbyn9nCY=;
 b=ewQRE8TbY06b0vmt7LNprfH+zbnNh4mhJo3VSEhju3+npStJ5wCqBle5wA+mElj3f7UzX91xrRpaII3bGOI2RqPOPG0cchU3yGK6tSB2x841R5Z/yF6fNr+Nc95EYyKp3fgaAhcOHBtWvQx3N2WCxQUcv4XBhOmjuitPfHBQFJZPpiSj6kJAh8hu62ZP1sFp3RyGpelvZ9wQIqma9UdTnGrfsak66Pao50EnL+oqPeFj5LQUphcB1osN3Vz2pco6abmyjltoQTazycPAjl1jKvK4k0eO3pjMyikqhRUS61eV7QiKxq9SCzL36MWidlciNlrnJNqqX1vzTznMNlf4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 16 Dec
 2022 22:29:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 22:29:34 +0000
Message-ID: <dd1031c7-6134-5dfe-6113-3f0325f31663@intel.com>
Date:   Fri, 16 Dec 2022 14:29:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20221207112924.3602960-1-peternewman@google.com>
 <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
 <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
 <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com>
 <CALPaoChbJNYBXvOwftSxApo_ca6BLC7Ej21cDAaKdj9LOJumxw@mail.gmail.com>
 <6f0f4c45-039b-ffaf-b30a-d9e2aae0cc74@intel.com>
 <CALPaoCjAUOO=2wECEQF+weKsto5LNi1-8nVi_QTLs7B+fvRb5A@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjAUOO=2wECEQF+weKsto5LNi1-8nVi_QTLs7B+fvRb5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1422a664-4148-441a-158c-08dadfb50205
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BID05knn9gga6LDWOsXyuh2nEX6vdm22k1Fufe3wm4hRi+8W4bfZmolzabxKbBePJQmP4mMiJrPXz+HU0wA+K4a9BrKUFlAckKJumjoDtj+qd40XKE5isgoqhxoaVFdvKpuNHEiUzzZFIGeYNBl0xOFhvAz8SlPFoz8A/r5FhTDXo3Xo1ShIEsy7WkUeej1qg6Pg4VHpXoqAivVW69ieRPE3QsDtf9uNXXzdhn7M8A5JugDtd/mOOlEu2QwWjeB921l3L8gwolQSwaf7Tgn4aJJ/9ou3YMSfAzfRVHtbt0bkk6T+/6Rc4qWA9kSQGHUQDDDL5j18gt3Z0dliMTxSUNvAXe572SXL4/VfF4cVHMPu/FzwGtnQw5PXSIT8uPrUlbINotfp4XP4wQ98Xred0otUDHVPVvAkUJxHyrD6QAdT1HOEzn02EmW6zKWT0GAsMDK5L0q2UWY+aqNrATC6uBMO8aPKzTgbQZPah+Exnvgw89WYz9sDmRXML0CwaYEBeg7DRLZWO0WktXJKvJRO3NTqFuP2YaIJu+c08pjSAmjEnIi3ytBJVd4cN4fJjCXMOlhNhdJhV1L8k6hYEU1nhA63Jak5s8BwOXym20peS/DBTW2MjGMbtYF+n04us9aAPFJtjc8i3gHWmjdqsXPUMy6VfkSiAuZ+zUCnqGHg5EoepbWtsvufQiaNx3gv4/n8J07Eu6exAcUrgDphsV6iW+HHEc1EElPSztyqOh9U7ZDM6GtIZ4FQvnLrkAI75VH6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(966005)(41300700001)(6486002)(478600001)(38100700002)(31686004)(53546011)(6506007)(26005)(31696002)(86362001)(7416002)(4326008)(186003)(6666004)(6512007)(36756003)(82960400001)(66476007)(8676002)(8936002)(2616005)(54906003)(6916009)(44832011)(316002)(5660300002)(66946007)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNjMWVTN08vVkw2Smp4OE5CYm9uTmcyK1Njd3VpSlNIb2trUnkvT2tReTFE?=
 =?utf-8?B?QXFqYXcvY2dVb25NV1dRcll2Ry9vR3pudEF0c0phajdLZ1NGODRvZVY3MUdX?=
 =?utf-8?B?cURla2tFb0RkREppMlZVZWxuOHdjM1hMUEhZMnhvd0ZjdlBSSlJkOWdDVkZN?=
 =?utf-8?B?Y2N6MnEvdzJTRWlaTVcwMXl0bERCd1BxVmFUQ3pramUzOFNIakVuTGxpTDJO?=
 =?utf-8?B?aGxxUHJTcHNPUFBkdXBOd0YxdnpMd0FsRmJVa1B5ZnhrVERvc1NqS3IxOHJ4?=
 =?utf-8?B?V0NkbE1wQStEWm4zS09VYjVHWFNJMzFBTHJ6NWRMVlBNdUxLQ3BIMzgxRTdo?=
 =?utf-8?B?ViswN3ZIZzFQT2xQRkZrZjBrVVlGZEZoUlFIWi9kU1NoNzZacnBQUm5GTDMy?=
 =?utf-8?B?WHVtSzY2OE95RHJUb1lhRktlMzEzcUNjS245d1NMNDllMUJ4WTNxZEV2ODlm?=
 =?utf-8?B?LzlpbUU3SnJPWkhXb1ZwbHkrSjN3aEVXYlpVS1FWUWFmVDU5Sk1BUVhQUkF4?=
 =?utf-8?B?T3ZDSUM3OVV5d0pZSHV3RWxycWdldkVzS0tyaFhuZFZaUld1YWFoUmlWVnVN?=
 =?utf-8?B?TzdKTE9jeDhLQmR0NFZmcXJOdEZVV0VLTGNaWVYrcmUzK29wWHZvdGNUMXZR?=
 =?utf-8?B?VFZYV1d3MTRTL3k5OFZWdkoralg4Nitxb1ZUQ05QMGFkei9MRnZ5dmIvTnpY?=
 =?utf-8?B?eG11dCtJV203REtBRld2dEFtRDFhZDFkM090Q3NDcTNCRlBqRW1TMjBpOGhz?=
 =?utf-8?B?YjBtQkxtM0Naa2pPNEVnS3hPdFlOaGwvY1dtbm1FUEgraXNRb1ZBSThZeGhP?=
 =?utf-8?B?ajd0U25GNWNSUTlhdUhucjBSbDJzOE1ncEtBcU5iMFBGUUFMd1JoL3FLR1Vh?=
 =?utf-8?B?VDhFZEVEYllJTExpdHJXbzdacDlFRjBRNVRqZzVSRFhlYXZpSXdYa1NGcERa?=
 =?utf-8?B?Qk9JYU5BNnB1SW9mMHhwOXV3QjFyK1JVTjNYTitSTFhJME56WFNmNVpVejRG?=
 =?utf-8?B?MjBGUVJxNmh0Szk1M3RsdmRpNFhwSVRpZksyZndscUR1d3Jma2NKK1RxWFF4?=
 =?utf-8?B?WTV4eXFkcjB0cVdYRyt4YjJrSEg2SFZWeGpneThLTnhxejRIM1JDNmwrS0pN?=
 =?utf-8?B?Z0ZDRlZVRnpUQStRVy9sS0ttTk5WcVl1YU9QRm9rQzFMWFNNaHovZnQwdFV5?=
 =?utf-8?B?WDQvcENxRXYzczFzYWtoZXF3Z3VmSlpZV2hadXkra0hWL3lKN3pnU1p5TlA2?=
 =?utf-8?B?TXBybm8wT1NYdzV6ZG85QUZRVDkxK1ZCV3FFYmFQMEVLTlhMTWsxY3FQUTRw?=
 =?utf-8?B?UmVYYjRnTm5BeXovMlVkcDdpVFEvQkUvKzhDRDM5SWpIR0tBRVF2OUUwUWpY?=
 =?utf-8?B?UG0waU5mbk5ORFBLREtxbXZYS2pEUm1yUFgwYXJKblBvZG02UnlidnN5Y2gz?=
 =?utf-8?B?NFZnS2gzbnFMaWNCS0tQUUMrQTBGUXh0b2k5dWFKQVgrVTlJWkppTzBvQ2hP?=
 =?utf-8?B?Wm80ajFrTWFDb0NITFZZSldMMnhxWStpTG1BOVI1V3hiL3NBM1NNNGNPRnBM?=
 =?utf-8?B?c21LeWUxTFdmL1Y0c3VYRFdqTWRIWXlGVjVGVFp0VlpvYlRVUm1hcEhCczlQ?=
 =?utf-8?B?Nmh3SEdTYUJGWjdGWFE5dTlMbVhyNFpyU2RxSitWU09jZjJ3aW9Hb3hFYm5t?=
 =?utf-8?B?TlRWVWlrZUJvRTFyM1JtcGZLTnBORlp4NTVaQWE2VFo1WmowUVFsUnhhUUtx?=
 =?utf-8?B?RmZVdkYyWDJpT29mUmdUcUxOb3pmbUhKTlNqYXM1UzFDRVRSN1BoSGNJcEQx?=
 =?utf-8?B?aVVORFRLTEtsNnZnNTN4U0oyTmFhdjRUNldKQTZENGd5Z3VJTEFLYm1qUHYx?=
 =?utf-8?B?dnBNeXI4d1JZcW80N1VIcFVMaTg5cHowb2lBRExLRDh3ald0eXUrK1A4WjZH?=
 =?utf-8?B?TjdJcmNZK3dubDRRY2k3dU5Jblc3MmxlbjgrOWZYWnJuUTF0RjZuR0UwSEhK?=
 =?utf-8?B?S0Z6WEtyRDRtNFUwdm0zR2RMU0lyTFdtQVBrcFFnQXk2U1BlRngzOFJ6Zmpw?=
 =?utf-8?B?L213OThKcGRXRTFkZEp3RGhWYlpzOGVXcGJ3Q2F5STdPZjRVbW9qSUFsWjIw?=
 =?utf-8?B?ZzNQWnIvbFNHbzllOWFLRXBDZC85eTZRWENUUC9YWDRpa3JxRG9SRExramlH?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1422a664-4148-441a-158c-08dadfb50205
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 22:29:34.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSQKWUGgCuAtJyH18VMIr351Udn0BDf5b0eyu3E2ni2XRt93MNwY3bZsHEYm4CipNXRhgMdZ4n++srgDt6to5QRQ25ypbMdwsSCvhRlEJmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
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

Hi Peter,

On 12/16/2022 5:54 AM, Peter Newman wrote:
> On Wed, Dec 14, 2022 at 8:17 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 12/14/2022 6:21 AM, Peter Newman wrote:
>>> mbm_state is arch-independent, so I think putting it here would require
>>> the MPAM version to copy this and for get_mbm_state() to be exported.
>>
>> You are correct, it is arch independent ... so every arch is expected to
>> have it.
>> I peeked at your series and that looks good also - having cleanup done in
>> a central place helps to avoid future mistakes.
>>
>>>> am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>> if (am) {
>>>> memset(am, 0, sizeof(*am));
>>>> /* Record any initial, non-zero count value. */
>>>> ret = __rmid_read(rmid, eventid, &val);
>>>> if (!ret)
>>>> am->prev_msr = val;
>>>> }
>>>>
>>>> }
>>>>
>>>> Having this would be helpful as reference to Babu's usage.
>>>
>>> His usage looks a little different.
>>>
>>> According to the comment in Babu's patch:
>>>
>>> https://lore.kernel.org/lkml/166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu/
>>>
>>> + /*
>>> + * When an Event Configuration is changed, the bandwidth counters
>>> + * for all RMIDs and Events will be cleared by the hardware. The
>>> + * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>> + * every RMID on the next read to any event for every RMID.
>>> + * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>> + * cleared while it is tracked by the hardware. Clear the
>>> + * mbm_local and mbm_total counts for all the RMIDs.
>>> + */
>>> + resctrl_arch_reset_rmid_all(r, d);
>>>
>>> If all the hardware counters are zeroed as the comment suggests, then
>>> leaving am->prev_msr zero seems correct. __rmid_read() would likely
>>> return an error anyways. The bug I was addressing was one of reusing
>>> an RMID which had not been reset.
>>
>> You are correct, but there are two things to keep in mind though:
>> * the change from which you copied the above snippet introduces a new
>>   _generic_ utility far away from this call site. It is thus reasonable to
>>   assume that this utility should work for all use cases, not just the one
>>   for which it is created. Since there are no other use cases at this time,
>>   this may be ok, but I think at minimum the utility will benefit from
>>   a snippet indicating the caveats of its use as a heads up to any future users.
>> * the utility does not clear struct mbm_state contents. Again, this is ok
>>   for this usage since AMD does not support the software controller but
>>   as far as a generic utility goes the usage should be clear to avoid
>>   traps for future changes.
> 
> To this end, would it help if I pulled the rr->first case into a
> separate function like this:
> 
> -               resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> -               m = get_mbm_state(rr->d, rmid, rr->evtid);
> -               if (m)
> -                       memset(m, 0, sizeof(struct mbm_state));
> +               resctrl_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> 
> I'm open to suggestions on the name.

This email thread started to talk about two generic utilities, the one relevant
to this fix (resctrl_arch_reset_rmid()) and the one being created by Babu 
(resctrl_arch_reset_rmid_all()). Focusing on the one related to this fix I do
think the way in which the utility is used in V2 makes it clear how cleanup
should be done. I could have been more explicit but that is what I meant earlier
when saying that the way that the cleanup is done in a central place looks good.
Any future scenario would have a good reference to follow and if needed a new
utility can be created at that time. 

Reinette

