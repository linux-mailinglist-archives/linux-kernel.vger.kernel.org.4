Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F45F32B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJCPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJCPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:37:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C232F032;
        Mon,  3 Oct 2022 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664811429; x=1696347429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EuEMmuQHsPeW+hBnfxp5nf68T5Aq6+rvI0w3+wb+h3w=;
  b=e2Db7lNm493okBl+bZA5rQj/Lyw180c69HxsmZ4OUOQQvIEGMoPd6nxK
   wDK9w7lGuobyoRLmSbQt1pe7r+GkEK4oU6E9ONQpDOpFK+u4AdMYCA34Z
   I9FHg/OqfsYUtquCGAP7a/OzW6uxvyYFq5g9DMuoH6I3LSYrSjJkiE6Ka
   N1GMMNQvEJbIQUPLXh7IrSA8FMWNwtHPMNgLtecx/J1tsl9nw+PYcY9TA
   Ir+guHKQVthsE1dTd+ClS15hyXcy3eyL0s4wteePqhDdhza6kCF3rAmrG
   +VTHOZinV48uRw4fuV84oNXUK+deZDRL1gc2B4WXBtqKI95rQ/ubPX8e5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301388011"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="301388011"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 08:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712640729"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="712640729"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2022 08:37:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:37:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 08:37:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 08:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c983cptC1cTr4jX8DqjD5Il0gl77TaLSiR5J+WFpmeL7gQeF/WStosnXKAXYEWMfWIm+3tzkm1Yx3HSodddb/57307Ogy3pZ8iOx5WLPYRmq9DEjVULqlHLJbQNf1Ec6lfL9ZhD1VyVax2eyhCQf3l9tzU23max+4L9e0B5ZTsJANugsM/0zWXBfyftK4eeUD1PIFwHADV51LrCD4tcM101LSuW4xz6Rn/CtfvVngECs3kPUmPSmsM3KUEtF6nNsxVT77RYZdHtU5b3Iz252qzxCd4G7K1O7apNLyyxpGhohRzX6KAoN1EF+hhrWuGdKOPEBO+aM8DIsc0ICDkY0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHH4mCOaXj6pmwKYJPaYzYXXTLh9EFpOjldoI2Lmv4Y=;
 b=DbWUwmZSDFhghE3hwbY+IYA3bdWPuUqbHdoLsr39fiDTQEWTpZ5C2Pe0SsZChp64+Qtt6ETtNdmSo0T8og968ITCecqah/v9gPLj6TAg7n4uulHv+AmlDc6AeDO5cWoLTGCRnafsl6T7vcfDzYUkBQ+klJQqkauhdJvRLE6HPoDU52hhkJgpMnreN6Gm+u/L4mbAhE4xH7UxBZ3Ft1SASnfeCrYPZ3gMWoO9P37SWCvvTvqoTJJs5eIy2z1HNJSCiqCoYddEjcGLDHceSkm9cheqxUC59fpGEoK/w56nmq1f4FzrZZ+MfDfzrHWS8uNL0IUqR2Kg+82xg/EWU5fbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 15:36:44 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 15:36:43 +0000
Message-ID: <39c3bf58-052d-fbab-3bbd-029f5507ff23@intel.com>
Date:   Mon, 3 Oct 2022 08:36:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
 <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BL1PR11MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a58952-a94b-4be9-2641-08daa5551289
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDp9hU53xD3rFhlELuFdNNKJQFGvybCUYSbpifb/EV1MTgauqkJduXz12XQNLx1Egq3l/FJ4T6P7pw94GCGR/8Fq0z7OM2F059cOsPY1bJt5+Bilgw3I2VYdP5iN08X7f3ALSEdNkP2HJ0HRT3lOu6Bhcg1aN2PAEdWgmiv7GSTg/ezcrUY7xgF1lC9t2EUuovEOR/LsGtA8FNA89aN/t54IbobInb2p+O5jvI0vJMvsIChruziBbYvMQvWr0bBTr6/V0XHQzLs4A/I4wWXpx5psiJVQ8imDPBWp4ujK2YKgPu7LlZ5ORAF2R1DK8v48kRnun6A93eH/dINOXgkcBxY85eiZeMLKO0LMqpaWgpmyg/hDS+vHr3Y2siWtzgp2Ddi4FCFkGSTAEnPs1roM0M04Z0nyYKtbTMguJHgNNwL53t8o0tJsP1QbayyETtaqrdRzCZ++sB+VagJovrTvbz9jKGA3QwXf4qjBK5YIj8qoTbEmPijlXtidtstZT2Hugncqr5XUsc1qAXKuvPfwuIODq34TCeh5AaEDVSTY/ti8JpqqNoyaFJtZoNgZyQiqY4xFS6OkpoxamgEOUmG5BRswfEwTICrVboFXgLtN7oSVbsl3a+j8Xfj6+mf8+FmNIU6jdVcXbiapnFaStfG16NNbZqfkkLqAHdELWXu2FeDVq93zac0mwh/hZCjsd676mGRYbp66HTNlffaWuFD9F1/4qpDzdfkLZJjO/3XWzelKac7txh+9SR38bLYmp8b4iEXIwEPLpYnapET8j5b2PdQCj089nn1Eyz3mtV6Rb9zB0dVH7beUhACvUbshXhHX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(31686004)(8676002)(36756003)(66946007)(66476007)(66556008)(82960400001)(83380400001)(2616005)(186003)(478600001)(6666004)(6512007)(38100700002)(26005)(53546011)(6506007)(966005)(316002)(6486002)(4326008)(44832011)(8936002)(41300700001)(5660300002)(7416002)(15650500001)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTlGVVFPYkh1cFhHMEpSZjlSaDE1ZzJZcUZkOGdCRkVOcDJHa2kzRUw2ODJv?=
 =?utf-8?B?TkVRT09jeVdOTXBpdDk4MVM0ajIyK0J5UDF0MTlzUzFFT2JoYVhmSC9IalFP?=
 =?utf-8?B?TllzNmZJSzhyQUdYL3hXOXpkMFJlQVZJVmUyL2JGeTUrdVVVcEIzRXdyTUhO?=
 =?utf-8?B?N1MxSW0zc0VaSHcxZWhjNU44bXp1KzBuYy9hYVlkR0Nzb1EzV0dXdG8zbGoz?=
 =?utf-8?B?NzV3M2N6STh0ZWFwQ0dBNjRRWVd5ejlWc2c0VkY3NXBLWkw4QUtUUkFxdHNG?=
 =?utf-8?B?UTdXbjl4dkd1Q1orYUxKWkJmTVVqS05keHNEQ3FicWhyOUxQQi9WYnJiMDN0?=
 =?utf-8?B?cDJUcDE4VUV3d01rOFJiWGRUK3pKd0lYRXBzVEUvTjVsa3JmTzM2RDloK1hN?=
 =?utf-8?B?WTUwbTkyYkdCMVF2OEJXZ0l1cjBvSWhWcXZjSzJndlpnQVBRVkNLUUNRSi95?=
 =?utf-8?B?QVUxT0t1RG9ZQUNKNnpWeUR3eUhFMCtKcHVOdkVjRmlGWjJpSDNOb2xsWWow?=
 =?utf-8?B?R0dkMWJuQVRsZmZQNUljTUhVZ3FLSlFBWW5zWkJRNHRXWUdLcnE3Zk1LNU1X?=
 =?utf-8?B?cVk0VUpFbTRRMVR4UHNtQVcxa3M2aFZQNld5cy9BSjV0NGdJR1ZZdDEvWm41?=
 =?utf-8?B?SU15WGlsVE82MW8xMzJhYWxqN1BwUllhenpLZ3pzcXZ1d0hTQWNRaEpNZmdN?=
 =?utf-8?B?bno4c2N6cExiT2pXUWZENmV6N1ZkSEtiNktIcENZRXJPVXd2a1hGMjUrdVYz?=
 =?utf-8?B?cGtST25PRUhmV0Nxc0h5RlRFeVNNVXd0TDhhNGtEWll2SlZzQmw5RnR6allv?=
 =?utf-8?B?b2dCTFA3MHMyY0wrOGI2YndobytEUVExZk9kN1djMk5Hc1MzQ25qTno3TDhG?=
 =?utf-8?B?T21sd0VHYlJXcXhYeU1ETHYwWFEvcm1PVWJNSWJMbStvOFJmZktGY0tQbDA5?=
 =?utf-8?B?Q1hBY1ZUQ3FlTEpESEhXM05CalZSTEVRR3daZGE5Ykg5THdLcGhiWGNpWmt0?=
 =?utf-8?B?WHRtMHRUbzM1SFNjNm1MWVdRNE1hbXdRUW9zUWxzSy94ejF4TThiQmpKWG9H?=
 =?utf-8?B?ZXlBZVR5OVlkbGs1eDZXajRTK0hSWnFmWXZBckxIbXVLODUrL0Y1SUhMZ3N3?=
 =?utf-8?B?b1FQa3JWZXNhTnBzNFM1Vks1Y084aWo0WjJlUVd3aEsvUE44YlNuSTZQQXE5?=
 =?utf-8?B?a0ZucDFaYWtDRUJpMVZEOGpoaDJNT1J1VHJQQ3J6RmFOQXBFNmtRcHFTTzlS?=
 =?utf-8?B?Rkd2bHdUNndCdUtGT3dnSGI1MFF0Y0U1b3cyMzd0ajUrQitSUDJRSW9aVFNu?=
 =?utf-8?B?eHhOZVhFUU1XTW0zSDR5aXBSS1RxSW9YUnBpMTFlZWtZbHBlMzlXc2gwSnBw?=
 =?utf-8?B?SmZUeDN5bm40eHhDM0JlOGdteFBZTXdjV3JLMm5QRmxuVmpkaWczN201V1JJ?=
 =?utf-8?B?NUEydmtiWGl2clFnVUNEZkplUzRTLzlEbGxrUnFOSVBvL2ZMOGpVbTg3TjR3?=
 =?utf-8?B?THJvOWhXa1hTaDg5TTV0SU1yK1N6czZtY0x0cnlVODNHcjVUcUFhNW5IQzli?=
 =?utf-8?B?RUYzc3ZzQm5RQkg2T2w1MFJzSTlOOUIxa0VpU1JxemV0ekJncVhGZWdhbUJH?=
 =?utf-8?B?ZzN0V0JZMVVSNTBGVXpvUkNuZmUza0g2VVkzRnJxaEpaUWtvd2ZVME9QMEsv?=
 =?utf-8?B?YjFybkVzeUJPWkR1L1AzVWxZVVZpZTVNL2duTER2T2pQWUlpR2FYRjVqdkdG?=
 =?utf-8?B?bmdpblAxNStEYTBDbEZ4YWprOUxYVkpQZEU5amloVnpXaitvNGo2bUt1cWJJ?=
 =?utf-8?B?b21VUWwwMmFaMDkyNDlUZXpwRjRPWGNGT0drQW5UdEVyNVE2R2JKSVQyU0VR?=
 =?utf-8?B?czZkNDZIMUplTjlGY2R4bExLeXNic3VHc3IxeGpBQ1VDeGlSeGZrQWY1amlH?=
 =?utf-8?B?eHByZWdsUW9iVW8wTHkzbGFiOHhIc251WmhERDczSU5OU3N0U0laMDloQms0?=
 =?utf-8?B?cUNKaCtBWmpqdDBoQXhGZHozK2swTEs3eFRYc3kzdm5lY0tiakMvaUx2UE5p?=
 =?utf-8?B?TDFPL1Q5NUpmNi9jVU1VMWFXNGpSckR6bjRZVWhTdDVIOHhyeGF4c3I0WDRM?=
 =?utf-8?B?OWJoSVRCNS9Pa2dDUk5qMEFFcWR4aTdiaUhRdFhoSjk5cWZGcE5ZZXdXT0RU?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a58952-a94b-4be9-2641-08daa5551289
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:36:43.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd68hGWpvgOnpI6H2jNjGBbLLHc1tpikre4bhle8YQfEF6js5JBFCt2B047BNSTwZ9hRcQzL8PoQ7wk63URVgFYZ2O4vhXpj/9/GDZlB/QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/3/2022 7:28 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/29/22 17:10, Reinette Chatre wrote:
>> Hi Babu,
>>
>> In subject: resctrl_ui.rst -> resctrl.rst
>>
>> On 9/27/2022 1:27 PM, Babu Moger wrote:
>>> Update the documentation for the new features:
>>> 1. Slow Memory Bandwidth allocation (SMBA).
>>>    With this feature, the QOS  enforcement policies can be applied
>>>    to the external slow memory connected to the host. QOS enforcement
>>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>>    and specifying allocations or limits for that COS for each resource
>>>    to be allocated.
>>>
>>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>>    are set to count all the total and local reads/writes respectively.
>>>    With the introduction of slow memory, the two counters are not
>>>    enough to count all the different types are memory events. With the
>> types are memory events -> types of memory events?
> Ok Sure
>>
>>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>>    and mbm_local_bytes to count the specific type of events.
>>>
>>> Also add configuration instructions with examples.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>> ...
>>
>>> +
>>> +"mbm_total_config", "mbm_local_config":
>>> +        These files contain the current event configuration for the events
>>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>>> +        The event configuration settings are domain specific. Changing the
>>> +        configuration on one CPU in a domain would affect the whole domain.
>> This contradicts the implementation done in this series where the
>> configuration is changed on every CPU in the domain.
> 
> How about this?
> 
> The event configuration settings are domain specific and will affect all the CPUs in the domain.

There remains a disconnect between this and the implementation that writes the
configuration to every CPU.

You could make this change to the documentation but then the
implementation needs more than "Update MSR_IA32_EVT_CFG_BASE MSR on all
the CPUs in cpu_mask" - that comment needs to highlight that the
implementation does not follow the architecture and scope rules nor how
configuration changes are made in the rest of the driver and why. Previously [1]
you indicated that this is based on guidance from hardware team so perhaps you
could document it as a hardware quirk related to this feature? At the minimum
it should acknowledge the disconnect.

Reinette

[1] https://lore.kernel.org/lkml/3511f4f6-d043-9a22-7779-af2c2983b6a2@amd.com/
