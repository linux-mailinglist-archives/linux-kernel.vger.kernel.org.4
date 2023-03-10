Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31C6B513F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCJT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCJT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:59:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6E123CDB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678478378; x=1710014378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tN3BEofk/6WIfOpEJM6qxYDTZoQQIBhaLiC022nJ5N4=;
  b=LQ401i06LumDzOVWp8gZ/DPVUK6DhvQ4IOP3qtXJBFc2DR2AHecLZRnA
   WLT0TqR+ukhjIsM8dg4QY6YpZHAPmhvYhB1ay7ThhHsV1BZhwcW7oLTtU
   8NfrNSGyeRtep7ZLIAURAginy7uiZPou3nOnk1jbrSL/xiG0ZClwh+5dq
   TprIV2AY2nX4uIStHTizrkk7Dvxd6DgOanNee6oOIfJohZ/1sXjCtMzWF
   Dbr8iO+XfGxjqY7gD7QxfAsLxFygepUnlDa4tyL8JWB/PbMaGogBnUWYF
   CIabE1GC/M4qjh9aScWRCIs9rvin5hkdpo9D/FGkCEX77dW902iRsENzg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339181567"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="339181567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="821195669"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="821195669"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2023 11:59:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 11:59:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 11:59:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 11:59:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9YYd0k+6jFQ6+GkNQGAql8I/XorhkT9I+SACJZpLt7eZQmv6Q5vHDk7nQK/Xup4JZPbDN3W3d5S2gBR0tV5exUe1Wx7woLT/BqlFSJa8ls9YsCk+kF+edv2ynVnyIhHno6huyAge8cZ3HIjPc5OFb/TbloeGG2K2BZ3Pb6F7kW/NAGca3vQn91WRJHYLttvTG9iv2HrftgSmyMb3gp/3puHcQo8Q4P4swoxlul1va3/M+dnnyojC+n4Os2R78Ohja/aK6KaOsYYHn7M7/7MjdDIM7aZit54Pb2ucSvrZk64gTZIytYM0e08SEuOM78Dsrx3UMGmQv5CwoGMRkkCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG23UG8cStU2duUAd+0Sy2qB9aLgqfcdlO+AaykJxiw=;
 b=FndXXaafNN1klDQP4Wp0m1KhK0eQBHW995R79fWs0AfgJgl9ef9NqvljrBAn+38kZ92/64b2cg9lImVImh0Bt/Efe3NybA3426Vtia5pn1U2RMUjG7GiUKTX2cEXDswAwLIwlVGKLr8LobgEi+82zBeh3x9s+tyOi/YjOIpIPoqYdNY1+scuT7VIQz6Qp7uITajBZs+zuwEL+i+QAZKQ8+Ev6QDQMFc8ezYbVzP86lP/HCUmsIcrlrdxFSGyz+EhOVOWWaipOEo3Brddt8HoHCIlJOfxuk6zFCiThAogzU6N2cmQVQkxnvD1lYeBheuo14peIWWkv2llRfBkEiOSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Fri, 10 Mar
 2023 19:59:33 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 19:59:33 +0000
Message-ID: <a578d211-ab94-d449-3ba9-7e8788ace484@intel.com>
Date:   Fri, 10 Mar 2023 11:59:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-7-james.morse@arm.com>
 <50324934-20ee-51e5-67a9-f1cd823230d1@intel.com>
 <39a3aad1-b340-2a6a-925f-b3a7614eb92a@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39a3aad1-b340-2a6a-925f-b3a7614eb92a@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd39aaf-607e-4063-17f3-08db21a1f7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eX2qC0f3pYZS4R06Mu3ZQ0Xv54IwmIlZnwDpXh+Kr264Zet4iw7a/oW3YOhqbznC0XBGjACqrZhKQA434CHXDyVp0k6PdQxdWoR8fwzPkTx2dqTGyv8LF45V/U+NMYArb8FoLx4jeIPxWj6WdwVb+DmjBpAWhFr54bR546EMJsuziR4wfXbRILO4acL9TvGOnET6F+CgjlEIs6++DOqlGraM9L3jl1Rrm45n/FeodtEqNkTyraEpptAgRgghtn5oF2OSxRvX9RU8wXWyA/TQbBgpuymkrLbktfDuD11QetP8Zn8QccYJXYWhQe1QqYUydZ0XrwsOVTUo9asaYV0AQiEBIAqR+002m8PuvdIncOQvtXD45AMNr6Y2f4HZ3bCC79yKqpIfxMuak6h5jNGbPAV3MoRxzcY/Z29jdx8KyI2OlExreHkE0fBS4QZ5pG29a2iMaIQxZgd++/nA6tV7Bef4GC1xyDg+Ol7P1WBbWPLexDkFZBulxVYUf5ml7lqF2j9Oy6mXCIeDwj4h7nuZs6570jjz0F3wZ6jp2VnyJ7V14a7v2mE+4pczT2J6C0pewsqQ2A+orlnFQFcszyG86PwM7K9E6QATBdxNbxmfUbvOoLtBCHS3HixdCCpRwuqGu8LgPVertgY5CEWhyKBbUcQHHHnfbvGV0atOwutPcO1snVguWqYPG3zAyziY/Ocwc9w7E8ndzAVp9u6Szi2PP4//D9VIyviSeJyhCnZ7gls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199018)(31686004)(53546011)(6506007)(2616005)(6512007)(54906003)(186003)(86362001)(31696002)(36756003)(8936002)(6486002)(26005)(82960400001)(83380400001)(478600001)(7416002)(2906002)(41300700001)(5660300002)(38100700002)(44832011)(316002)(66946007)(4326008)(66476007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNOVjdtQzhsWC96QUU4L0hqQkpKQ05aczNLZ05BR3pGaGE5aFZUbG5YZXBJ?=
 =?utf-8?B?VERlbkt5VDFsQ3pQTlRrU0NNWEJVVWQrM3RzRzNwbWdERjlhZWRXMDBRK0pG?=
 =?utf-8?B?bHdjNC96WUpkalhJN1ZnVW9EcGJVTENLTzQ2NSsvSXI2ZVNRQmd3NVJnNGta?=
 =?utf-8?B?VkRBSU43U0Vrd0k2SmlNTWR3QlpoUDU1Mm1HZXJhK2VrdnJiRjdydWwxTmRP?=
 =?utf-8?B?bHRnZlBScmp1eGp1UXIxVVpPY3NPZ1drWEdRajU3S3llai9tL1NpT1lMeEd1?=
 =?utf-8?B?Sk9uYkNMSFFNZGpEUnV2bUYveUVMNDV4c3hKQjBrN2FqMXdzS0FNY2RQV212?=
 =?utf-8?B?ZzR0U1pRbVpZM0FqWGVaSHFFMW1WT01DNndLaldtU29XNUZ1eGp0b3cybHNx?=
 =?utf-8?B?MUNzd1BOVTNiQ3AvdU44dmVWcTVZeHVNTS80R1g1ZFZ4ZGVLWXFKSmlMUWh5?=
 =?utf-8?B?QzA5OSt4ZG5YQ0F2c0UyZUxpamxSckZOTlRwZmFKS0hvSGlSL21TYnZMUlZK?=
 =?utf-8?B?Uk4xalJrejA4RVZpeSs5Nm5Qblk4b2ptTFQ5eVBJbG1YMlZnVllJNDNNdE1t?=
 =?utf-8?B?MDMwV3lYZXJtS2RoTnNZM0R5WnJJSG8zNGo5K0hIVUNLNGRmV2lDYjQ4cGox?=
 =?utf-8?B?RmFLT0hGVVNGTzFoKy9FU1F0ZGZjd3d4T3FjWjJoV0V2MTk4YUlvK2gxNktZ?=
 =?utf-8?B?U3lOSTJHWEFtYnVJL2pCdXZablV2VldBYXVkeUx3c3ArbTB4UmVVSkFwYnVP?=
 =?utf-8?B?aEFFN3MrMXdsK1Q2ZXk5Y1RsdWpYZnozMzlFYWN0ZVY4S0RHNWlkR3B0RzFQ?=
 =?utf-8?B?bWc5cnBLR0oyVnFqSFQ0a01tbE5vOExSQ3VaSFpIVlNFS3ZYNjhNUFZnTzhy?=
 =?utf-8?B?V1VaYzlXVk9abUkxdU9LeWEwUUZUUUFFcURVM3p5U09YSTI5ZjFWcEhGNWNS?=
 =?utf-8?B?RUYxSCtwR05xRXZITjNmQklWL3hlK3Q1NlNYcm9SckxKVFc2L2FRZGR0VEpi?=
 =?utf-8?B?TlJsSHBHL3NjdHl6c3FHZy9Nc2hsTU5aUFZJNTJCWjluaVp5L2JrajRKK2k4?=
 =?utf-8?B?Z1RkMGxvMjZsRXNUeFlwVnpNdVFSc3o0bk1KeFFFUFRQakd6NDc0ZEdDUkZh?=
 =?utf-8?B?REJpU2lCSzJ6MnlSZ0c4Yk5VRWQxa0wrOWQzRUQ5RzNITlZEYnpIOXpuVnZz?=
 =?utf-8?B?OUZ0TlZaOW5tcDVmVmtVNmdUNUM2Q2RnSnd1UXVQY1lGMmxmTjJMRzhGcStx?=
 =?utf-8?B?enVBRnJlRnYyM2VBY0tqc3JHS0lwbXYzRFExU1liRmYwRDR2dFNRQkt1NXp5?=
 =?utf-8?B?UFVtc2JxeFZLT3o0c2pJYldpUUx3bXJWajJHeFBzeFJqUGwxbkVnLzlRak14?=
 =?utf-8?B?TEU2alJSdWNNVzFSeVBxeVJ4QzBUM2J5RVBWeGRMSSsrNW1nUUFEZDFDL1dr?=
 =?utf-8?B?UWZtNks2Uzl5MFdLcTZDbFdyUHRyVW8yZEE2cVB5ajRqNDRzWCtHMjU5c0ow?=
 =?utf-8?B?RTVpV3VLcWQzc2JsSmdTbWcweVVhMlVIcXZTMzIyL0NQdTZIVGo0a2xaMVdm?=
 =?utf-8?B?MFUwMmd3ZFZoaHQ4OWRYUXdISjRsTVYzWGl3MDVmb2JINmxmaG5HMUlCRURi?=
 =?utf-8?B?WUs0emhHT0Q3RDVNczhWWGRzdC9aTTA0QW0wcWMvM2RMaXNlZm9oSDk5dVlk?=
 =?utf-8?B?Tml3RDlaSFNsTVRwY3lHeElSRDY1cEhBcmluOVVZMk1tRGZHSFpHOEJZSWUv?=
 =?utf-8?B?Ny8yaTZNUTNSNE9vVm92dFVnVWcwWENCRkI1dlNhSlBpUXhBU3FFWWxzY2pL?=
 =?utf-8?B?TFVRbWRmZVVnSERGOWlLdDFvNjJiVnVKZWFOc29SRmw4WWV6OFhxOVYrMkt6?=
 =?utf-8?B?clU4eEFkZUZXejlrYnV1RWtPRTZKcjFPdFpSMDhIK1FRV0x2N0tpQzJPZjNK?=
 =?utf-8?B?SWlvcE9NMHNCUXlYUnkrZEdSQjdaWlRrMWJhOFNOYXRudmt0dGpzakt1Z3Fi?=
 =?utf-8?B?MFlBK1I5MzhkQlphNW9WTGJIZU1ySzY3WmU0QjdKVEYxT2NwbGdMWWFRREt6?=
 =?utf-8?B?RmZLeDJxK2IrOTZ4NFNObk90ZXBmYlJjQTBnRGw1NCtORDFqS1NsZGV3NDBz?=
 =?utf-8?B?Tnk4S0lMYkZ3Nmxqa2V1aHp4V1ZuNUU5MEcyK0N6NnBGZFh4dGlHdWlrWWdl?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd39aaf-607e-4063-17f3-08db21a1f7b6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:59:33.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSwzbwsSJ/4sHwBCwBstRNIUig+U6/ymh4+ST5ssZL2mKW2nHPdU2vbq6GZF8vLHtmafVXPuiOJBe15/rSkMGcai1qZUnbIQj95eZajFtKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/3/2023 10:36 AM, James Morse wrote:
> Hi Reinette,
> 
> On 02/02/2023 23:46, Reinette Chatre wrote:
>> On 1/13/2023 9:54 AM, James Morse wrote:

...

>>> +bool resctrl_closid_is_dirty(u32 closid)
>>> +{
>>> +	struct rmid_entry *entry;
>>> +	int i;
>>> +
>>> +	lockdep_assert_held(&rdtgroup_mutex);
>>> +
>>> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>>> +		return false;
> 
>> Why is a config option chosen? Is this not something that can be set in the
>> architecture specific code using a global in the form matching existing related
>> items like "arch_has..." or "arch_needs..."?
> 
> It doesn't vary by platform, so making it a runtime variable would mean x86 has to carry
> this extra code around, even though it will never use it. Done like this, the compiler can
> dead-code eliminate the below checks and embed the constant return value in all the callers.

This is fair. I missed any other mention of this option in this series so I
assume this will be a config that will be "select"ed automatically without
users needing to think about whether it is needed?

>>> +
>>> +	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
>>> +		entry = &rmid_ptrs[i];
>>> +		if (entry->closid != closid)
>>> +			continue;
>>> +
>>> +		if (entry->busy)
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>
>> If I understand this correctly resctrl_closid_is_dirty() will return true if
>> _any_ RMID/PMG associated with a CLOSID is in use. That is, a CLOSID may be
>> able to support 100s of PMG but if only one of them is busy then the CLOSID
>> will be considered unusable ("dirty"). It sounds to me that there could be scenarios
>> when CLOSID could be considered unavailable while there are indeed sufficient
>> resources?
> 
> You are right this could happen. I guess the better approach would be to prefer the
> cleanest CLOSID that has a clean PMG=0. User-space may not be able to allocate all the
> monitor groups immediately, but that would be preferable to failing the control group
> creation.
> 
> But as this code doesn't get built until the MPAM driver is merged, I'd like to keep it to
> an absolute minimum. This would be more than is needed for MPAM to have close to resctrl
> feature-parity, so I'd prefer to do this as an improvement once the MPAM driver is upstream.
> 
> (also in this category is better use of MPAM's monitors and labelling traffic from the iommu)
> 
> 
>> The function comment states "Determine if clean RMID can be allocate for this
>> CLOSID." - if I understand correctly it behaves more like "Determine if all
>> RMID associated with CLOSID are available".
> 
> Yes, I'll fix that.

I understand your reasoning for the solution chosen. Would you be ok to expand on
the function comment more to document the intentions that you summarize above (eg. "This
is the absolute minimum solution that will be/should be/could be improved ...")?

Reinette

