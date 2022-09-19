Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6A5BD627
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiISVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiISVIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:08:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E634D25D;
        Mon, 19 Sep 2022 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663621662; x=1695157662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WCE/sD3fHU7oe8rTDbE7dS1YwCAgizipwyW7I8tWF9E=;
  b=iXdn6xeTEZ+alfUICnyG4EXlG25drufuD70ZZiG1sSE7OoJi6N0JjyBS
   AQc3AWAAJpRoY/FWKHnDVwnv23GxqO/9cLAWSF9TAEQW3A739f5qD6mco
   nua617Hh4FtgnCXqovt1zAe1aLYVsfPOWzM4Ljf4teXnZKc2Slsse1cyI
   yzvs8C4Hs7I4O1ABx32PL+saFCSqgmoZNdiKxsGgRYG4XezkmTTsa/FT6
   jIzL4eY7IJNoXrqZnbNuYEIO4n7ZNBAEqGAdXmEy/lcbl2i8WGKC97rhC
   ND/NN64jAlQsNF3usPYX8VLSU5nElTArCwzZcUD4clFq1buk/zu6IIgN2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279904826"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="279904826"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 14:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="687138500"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2022 14:07:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 14:07:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 14:07:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 14:07:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 14:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY5kAXnfCpNZ8PVxbZ7omyW4BoHe+iGM1cHmpSqYs+r3D8B0Li42xumA+Tv6tqdDOOPhZr3Z2CSV0+kq0SBojNILXJLP/knmMB6NFkafSH+/DRUilrfNlhXzajSZXzFhJrDckVFGr70mnqcvxEdqv2dPt5+YAhjJoL528Q8Twm58plZyHNltgQe15MMpou8DaTFsoVGQTZmsCGqY3PSHnqrtieyQB5qa+3V0cbxcG4eNbpaxox2vFivU2Lp9lz869i1MpE7s90WnVvWHuyCx/trjBmQmbKIqf9xSaLNSIEC7iIWnEdi1F+0xZ5RkTHywBrppKqXx5ZFifnTD/pZ76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRraq2ArGAwDGYn2U7kjafrfebPzb0nXAvPOy1dZWKs=;
 b=ITVVGfy2l3Q/Eaxzh7Z/iEEQRNTZXWS9GGThhM8XxaFZPObJtTnrQxNMnxIt+Tx2E+d6owPatnoLwMZ9pTPVJ1c8vzXYpzSn6hCG8sji5/ed47FdDjGYayBcnd0/ZxCbLMdau/h0G4ckkU6zZQW0aGjb06nIRKf9Tv8RWI8m4ux4aYEny1UUIpDrhL6CvSnO8HhCTg4fJXP291eCKr6SZfv6HqfqoTWqXaWFTZuZpUvB5dCXk/jMMymwFjAWhBVqF7EezV/0BnRvafhMDui9JJPJDzE3PKIqP3l2VMkjzI1qzr3mVo8zSRpRuBh0NasRbDqu/einNyU4c1hkjLBySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 21:07:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5632.021; Mon, 19 Sep
 2022 21:07:19 +0000
Message-ID: <ab2f780c-72aa-2415-7167-e23c27f9a194@intel.com>
Date:   Mon, 19 Sep 2022 14:07:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
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
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
 <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
 <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
 <bd424e21-c24d-fcf1-96e8-38c9f7546d19@intel.com>
 <9dd5a111-63ea-8c4b-5515-d24d1d9c73f0@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9dd5a111-63ea-8c4b-5515-d24d1d9c73f0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 01263f74-b3b8-40b0-e3e5-08da9a82f030
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqTu24kKThOTx9gHSz62xhaGDH3lFAhAQrnCbu4J/8nUlAncQDCdedYhvYxVoauo8x6rn89E9rWFHEHLlawvAijtKJgxBH3tJXK62CDeQMqZUdKrbdFwBp26SzTW0/jnR0zJZNVV8IvaFMaph/nek0RJHYi8abVOcg+VjZ7tEgFgKFj55Ju3fT0uJ0VvIswgIaIEZ2xnrsS9qhBK6mV9El53SKNkccBsakO79890Zrv6Cr1MZLI5L62Lnkbi4xmAiZ+9khHBHabh5FfQ0nRIYwsktPIcC+dzl+1TKGRsc8CGMLQgYo/D2chnJ5OMDXUJAuendJernbz05quI8r9OHKGQNM0hfGkpnOdGDRVhz16twHt2cne8Zb7WyfoIZliawu/Q2pFhfWoCkkHu7zDNChWjHp5iWGJrhbURKlRLAyzM81HGcdkKVp8gANwl84pklmsBAbQnwtlqs6GfS4iu1vSKKmeth+eANZjLBTxguTUCQcfuQaV+omMGlq4+E2VCA71AQsEBS5clqGrICPomilasKMIPV7AO8hw7AbndgTGXB7z84n1LmxJcFhVK+10lXKlFP/9foU4ORlu/n2DQSYCFuIcO7/HXcqnSEzHjvfEAtAisRRluTkpWOLjrd5X1zmvDjD5HhEk/O952p31T/glZ84Y3U/bGC+9ZrtoKXDARj86IkKBBftq9hnofYI9NKFIJRvEZfup9JdA61gfQbPN30tPiu1L3LNeK6AmiDs5xhxxyz+6iMt5qe0eUKbz1j1+yhFEZsEn9spNOqjrk3M12VdMh1DuJNMtZfpVRy6Vm0wTy8DQSEwr15EI9p2opgqUhe6B9YSXA6mH5NjN5lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(2906002)(31686004)(36756003)(44832011)(316002)(83380400001)(82960400001)(38100700002)(4326008)(8676002)(7416002)(66556008)(5660300002)(66476007)(66946007)(8936002)(31696002)(86362001)(186003)(478600001)(2616005)(26005)(6512007)(6666004)(6506007)(966005)(6486002)(53546011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk50UVU2bUhuYSt5KzZ4OWNTTUVZVzJyc2ptRm5ZTkRtU1JGYVJVQkNNZGg0?=
 =?utf-8?B?Qk1MQVMrdVYzcHhwQmlkejZ0aHpSYjZlam9XOVI3UnlVcjN3bG00clp6RVRl?=
 =?utf-8?B?VDlIUG04dVZrMnJjbVM0UTJrSEtFbW5WZWJISnMzT1J6aTA4bVA3UWw0ck96?=
 =?utf-8?B?bnBSMklWZEttLzlPS09XckdydHNQbXpGK0RYRzV5dmJPYU4vN3I1ZW9KNzVR?=
 =?utf-8?B?RHd3TmxUNnVUM0hyRWFRc29QR294bGNJMmNoOUl3VjNUZGJmUXE0WC84SWRh?=
 =?utf-8?B?QTBUUXpIWHVia1dhRmI0RTFlOHpGS1hkcHpwSmw2UG50cUp4UVNGemlpWm5r?=
 =?utf-8?B?U0c0MFpFY2ZOd2NhbGJtNEtQcUtNQ3pqZHBIUHRRNTBhLzl1NnFlbGlaSXh4?=
 =?utf-8?B?Um1BRVhKR29JUjA2Q0MyaEFIcUNTUGcwOHJOMmhMUVlWY29wQk4zaytHYlhi?=
 =?utf-8?B?cGR6WHFnYkU4cjRqV3lKNVZ6cVI4SUVzMDA1S1huSkRUM1hnL2ZPWUpIS240?=
 =?utf-8?B?NXJlQWJ0UUpsNjJZY1Evc3MzMVNWL3hURVF4S1AxTzFNSWs5U2NRWVE1Znls?=
 =?utf-8?B?Vzg3dzR3Sk1URmladithaEh1clVCdlVyTitKMytoSFVhVVE5bVl0cmFxcTBz?=
 =?utf-8?B?MlZ2d1k0K3ZoZHJlMVVFNjQwV2xESDZCNTQybUUxVVE3citlYlc4c3BFalA4?=
 =?utf-8?B?aUZFZ1VLOVovbkJlSlQ1N2NqbkxnMkk1UFg0TDF4ZmYxZHhRK2ZKL2RlRVhT?=
 =?utf-8?B?eUNWRnZ1cGVZN3Y2bzFoTDI2V1lkM1RBaFhybmJBelZ5N1VURWlyL0hoNDZT?=
 =?utf-8?B?VndEMUd2NEw5b0QzYnhYTHdNSURUVUc2Z2EvbjRiV25tMlZwQmFvN2gwSldY?=
 =?utf-8?B?V0xnWnVKS28zUFowMVNhbXJ1WjFCT2haRGVEMVdHYmRuelBOekN0ZklSWFdk?=
 =?utf-8?B?SUhDK1cvRHZVd3BkK1FHN3NMaHQ5ZXR2QzRuZWNGcVVObWlMcmV6ZVNqZUhU?=
 =?utf-8?B?S2pUdU9oM2RvSW1pa3B5SkpXcDFIMm5YU1M5ekc1dFBSNGNtLzJGVTdYYmx3?=
 =?utf-8?B?MElDV3pLc3pvZXF5Ri8wUjRvd0VIYllrMXhvMnYwUzFnblFXYVE5dHFiWmxC?=
 =?utf-8?B?U2RNUUVETnExMWtSUlZkNEp5TDd2a3pJR2NZcmdFc0VkNlFhcXFYSTdtcFk4?=
 =?utf-8?B?RFlvUlZRVjMvLzI2WTJxNFlGV1VlVDJRVDEzUzhmOVJYQUdZZlJIdDNGZHU4?=
 =?utf-8?B?eWNZUXJNMkkzM0RYRWd0aks4UFQ2WGxtamU2ZlJWcHhzV0RuU3k3YkV0VFVX?=
 =?utf-8?B?RndpckEybmdHR3A1cG1EQ21jK2QwTWxJb0dXd3AvOEhtNEE3SVMzWnBwdmMz?=
 =?utf-8?B?TjdDUHhXZzZDZVdUNEROQU9BK05OWE4rUkxhRkJ5MXd2Y3FjK3UxenNIeDlH?=
 =?utf-8?B?TmFJZ3VHNFZOaUJ6a09SS0ZvSG90UWhxNHkzTldmMVE1OU9KbkhSa3RRcHlM?=
 =?utf-8?B?QThaSjVXVzhhcGhGNUZwMno5RVNuV2hqSHROSlVWY2g5YkJMakZCcWdRU1Bl?=
 =?utf-8?B?ekF5aHRKbERGd0hkMmR5OXhvaC9uUTMrRERDMEpoZGN5MW81b1BtbGdmOGVT?=
 =?utf-8?B?cnJKQk0xU1RobXJPMlhvaDh2TDZwWjJmRU9PdzZiUHVUS1lxU0pXQjdLVHRS?=
 =?utf-8?B?VzJTRFd5MFZNNGh0M1dXbjFEZGtDUjJJZWNrWUJ2RVcwZUMzZ3hzeVBaMjg3?=
 =?utf-8?B?YzZ0dkdZbzU0MHhlcVEvNTJmREljOXEyMmJZQ1ZOWXJvQm1RQ2hTVkpQZ2Fa?=
 =?utf-8?B?OVBYRnREVEg2RE5maXhTV3V6QmZsb0I4NXZpRDVUdHhaN3JWOEFXc3BrUk44?=
 =?utf-8?B?WmNYZjIyc2Q0NjdvcE5nQllUT01UVDg5S0QvcldPeXBRS2wrM3kyVlJyemlV?=
 =?utf-8?B?SWIrMEVicnZucVhrSmluVVAvU2NheU1PMzFQaTI3cDlyY0RERHd3a0tGajUz?=
 =?utf-8?B?dXpMeFhaNElpVS9oTEpkM3YvNlFRcGtiRnZ6QVZCVGp5RVZ3VVNINENsd3Ry?=
 =?utf-8?B?bEYzQmNuSGxIV3pjQ3FPclFOZ1BMYWlnVk04QmdOU1lFSlM0c3E2azduS29L?=
 =?utf-8?B?NmpFY3dYOWtCNit6aWJFTmp2OFl3SFMvc0t1d2Vndlo1eHUwUkFJcW9YSTRN?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01263f74-b3b8-40b0-e3e5-08da9a82f030
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 21:07:19.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4lCBwrkcRXQzrgEsGCRiTQXCUxX8LM9cyUN2SToBZ7PNkqy/Y+ooN5jEIEZ/fG9YrK+9E6Abt69EgBx6jcbQpMZqw42xp31dkRKa7bzKP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/19/2022 1:26 PM, Moger, Babu wrote:
> On 9/19/22 11:42, Reinette Chatre wrote:
>> On 9/19/2022 8:46 AM, Moger, Babu wrote:
>>> On 9/16/22 10:58, Reinette Chatre wrote:
>>>> On 9/7/2022 11:01 AM, Babu Moger wrote:
>>>>> Add two new sysfs files to read/write the event configuration if
>>>>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
>>>>> supported. The file mbm_local_config is for the configuration
>>>>> of the event mbm_local_bytes and the file mbm_total_config is
>>>>> for the configuration of mbm_total_bytes.
>>>>>
>>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
>>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>>>>
>>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
>>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>>>>
>>>> This patch makes the mbm*config files per monitor group. Looking
>>>> ahead at later patches how the configuration is set it is not clear
>>>> to me that this is the right place for these configuration files.
>>>>
>>>> Looking ahead to patch 10 there is neither rmid nor closid within
>>>> the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes
>>>> the bits indicating what access types needs to be counted. Also
>>>> in patch 10 I understand that the scope of this register is per L3 cache
>>>> domain.
>>> Yes. Scope of  MSR_IA32_EVT_CFG_BASE per L3 domain.
>>>> Considering this, why is the sysfs file associated with each
>>>> monitor group?
>>> Please see the response below.
>>>> For example, consider the following scenario:
>>>> # cd /sys/fs/resctrl
>>>> # mkdir g2
>>>> # mkdir mon_groups/m1
>>>> # mkdir mon_groups/m2
>>>> # find . | grep mbm_local_config
>>>> ./mon_data/mon_L3_00/mbm_local_config
>>>> ./mon_data/mon_L3_01/mbm_local_config
>>>> ./g2/mon_data/mon_L3_00/mbm_local_config
>>>> ./g2/mon_data/mon_L3_01/mbm_local_config
>>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>>>> ./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
>>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>>>> ./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config
>>>>
>>>>
>>>> From what I understand, the following sysfs files are
>>>> associated with cache domain #0 and thus writing to any of these
>>>> files would change the same configuration:
>>>> ./mon_data/mon_L3_00/mbm_local_config
>>>> ./g2/mon_data/mon_L3_00/mbm_local_config
>>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>>>>
>>>> Could you please correct me where I am wrong?
>>> For example, we have CPUs 0-7 in domain 0. We have two counters which are
>>> configurable.
>>>
>>> Lets consider same example as your mentioned about.
>>>
>>> g2 is a control group.
>>>
>>> m1 and m2 are monitor group.
>>>
>>> We can have control group g2 with CPUs 0-7 to limit the L3 bandwidth (or
>>> memory bandwidth with required schemata setting).
>>>
>>> We can have mon group m1 with cpus 0-3 to monitor mbm_local_bytes.
>>>
>>> We can have mon group m2 with cpus  4-7 to monitor mbm_total_bytes.
>>>
>>> Each group is independently, monitoring two separate thing. Without having
>> Right, because monitoring, the actual counting of the events, is per monitor
>> group. When a monitor group is created a new RMID is created and when the
>> counter is read it is per-RMID. 
>>
>> The event configuration is independent from the RMID using the counter.
>>
>>> sysfs file (mbm_local_config and mbm_total_config) in each monitor group,
>>> we wont be able to configure the above configuration.
>> I do not understand this reasoning. From what I understand the
>> event configuration is independent from the monitoring group. Thus, changing
>> an event configuration for one monitoring group would impact all
>> monitoring groups using that event counter. This implementation associates
>> an event configuration with each monitoring group and by doing so it
>> implies that it is unique to the monitoring group, but that is not
>> how it works.
> 
> The event configuration is designed per L3 domain. The mon_data is also
> per domain (like mon_L3_00.. mon_L3_01 etc). So, added the event
> configuration file inside each domain. We have all the information inside
> the domain. Thought, that is right place. I am open for suggestions.

It is not clear to me if you are also seeing all the duplication that
accompanies this implementation. As you can see in the example I provided in
https://lore.kernel.org/lkml/13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com/,
if I understand the implementation correctly, there will be several
configuration files scattered through resctrl that all configure the same
value. I asked you to correct me where I am wrong but you did not correct me.
Instead you keep repeating that placing the files in the duplicate locations
is convenient. I can see how this is convenient for you but please do consider
that having these duplicate configuration files scattered through resctrl
makes for a very confusing user interface and unexpected behavior. Users
would expect that a configuration associated with a monitor group impacts
that monitor group only - not all monitor groups associated with that
domain.

User API is hard so this does need careful thought. Perhaps the architects
can chime in here.

One option could be:
# cd /sys/fs/resctrl/info/L3_MON
# cat mbm_total_config
0=7f;1=7f
# cat mbm_local_config
0=15;1=15

It would be clear when changing mem_total_config or mbm_local_config that
it would impact all monitoring groups within all resource groups. What do
you think?

Reinette
