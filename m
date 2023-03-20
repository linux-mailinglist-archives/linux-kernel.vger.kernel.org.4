Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EDE6C1D52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjCTRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjCTRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:07:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719138E80;
        Mon, 20 Mar 2023 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679331719; x=1710867719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NwW/kWxGl4OINBVyWSsnXHd1iZiIl7hyTdieqP4E5F4=;
  b=eUOLeCa1dJeBY7BPO1f+5QC/HjTePMT67BfB3VRgPg5Y4df757F/wUn4
   PWfcDcucQ+QuKxIrRQpnTPqCzyoKWd69OFmpQlHPYioo90WK7oFGOPnmo
   5+H3hf50Va+DQo44BsDc1XZljwyCeTS6ES1fcRnPMQDdMFJNv96II8QWA
   vuwnpHvEy0QjNppr4uqecCR1SWvVE/kK6YZ/wml7qKfL1YDzpv1i9+Lpn
   cbaL+yUD4qZX28HUAFzN5fvmIXQFwNq6n5LxmJ+ttgjPKH72Mtk48u/An
   9qnO4yV15HTn+6Z0TtnRFS9aiFuvmqkGlbJzmaazDk5xM+5hCHxDmyFFt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366439679"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366439679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927029017"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="927029017"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2023 10:00:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:00:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 10:00:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 10:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTh5anhTYgGmB6XvyPbn29+byVUANgYF2kGJP5TA0uQ6LrE3+cdy3tab4riLyvj8uwbpiqOt+B1Y/8fOX3JCruxbbRcBlw25rz65tTgnTVmXgICMk5qMY4TXL3267K/tFaAeeW+AeZMNt73JGmlPxNGMIU9fM3jVHf4vVU+g5yokCqJMEqhVNhavgUqON2r9Md8EUvF8szFOVnEuV3HR68h939Fyag6SDR0pTGzHLYMGiKhZO4tcsvfACpLyeOMp/gyf04PgQbHcX43BJ6YUImZHkq2ivWNGIg5SbZd4U8sjG1qy4MdN2HLspTOiEhc9A4CuZINbmbhutyA1XzlDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1vaLwPpx9ivCbgYncPyfTl70D1dXhjEr8mI2XZhKvg=;
 b=Vza5org4k7Ov+tJvNO99PBCCZCPGJFE1yWHwVaFqzkX1DuhNuwfM8CJurJopprMj3xa3N8VIMbXPt0RKNPpmpbnZlm92Qx0DM6sl0GhW21zbahj/5Z/uZVur1dq8TvuZzOhunl8BbOzTlBzkhIAbKlnlD32N8RxUPAPjeJ/v0rWhZx3Fr5arKc3KE2qAMq3Ow6Vs9XM+YfHU602Lf7gnKu853RayV9wbQoOpAhltV31QHPE3XIWYuByed4UJHMZjPhy5pExe4w1WgjaJX5Wk5CaDuGTuRRbYYEfcZZ1M85O5luxznBe2IV212q+z5CBuqN1Jujgy7kIITkzqRtZbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:00:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.037; Mon, 20 Mar
 2023 17:00:19 +0000
Message-ID: <042eaf9e-df89-63c6-e174-fed6f39e27b2@intel.com>
Date:   Mon, 20 Mar 2023 10:00:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
 <f31e9db6-2ae7-83de-1b4b-4dd802a9da02@intel.com>
 <567d0e3d-4eab-5da3-7566-bcee5623c0e8@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <567d0e3d-4eab-5da3-7566-bcee5623c0e8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a3c255-1bca-47f2-4999-08db296495e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyW+5hnYv23afm1PnJpGAqeyFQBm00kaiwItr2buCq2R5rWKpNBHs6WCKjkYxXIivkgGub8BJio3IZduvfuRUbpYs21xOHsOIvUYT7b50482AfbsBVY341s7cwe7mzFarOoLS35Y3aHyN6n4/EI30kCafNjZAaPcHuZwytpF6m2Px+yopfFFxN7I091h2/Y6hTIZ9R9kFui5Mkh6YRLTBBWXmJwbalCbdjg1EkA6PsiL8jFyLMklV+vpZAkqlcpO1tcUdsQphmpfj+6/JZEnp7/P+z8oZiwj2S30lRUdAKZAiYDtLFsHaCPxukAbGqP3dmGOpcZQAQCNfhD4S5P1c5CEPHx9z+U5Xr2BGy1sWpYqMsec5rw7erGRPzDEuR1LjffuD0sjfUEDLLFVxA4MSgCt5HvYyejMf8I/cEPBkDXvWr2E5bbV23e9AIuLDaqLBfF5J1EP4MOnPvKExebQc2BiIaRdKJaAKasIVq3l8fsdG+rlyJbjlA8g18voUAysa2hmlcZQ5Tj29U5mYThqyG9khOtDuLLzjo/dJinVIUA1GNpn9p4kLLx+IqEDkqws9sQKWtJMVeuopT0QQ3qlBAzoqVVrbpZ5q2TgZZIHZKPtl6yNQk8Ys+epEJaGhJb35kJ/7QRPgw1VN/gtFCbX+2yBwwEg+GsivirdZNVSEAIikvZ25n0waFB9YlCghS4mJ4PLow9Tru+MKGZMQQdKj/YXYXbSBK0E4CEa5QPkDtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199018)(31696002)(86362001)(4326008)(36756003)(316002)(41300700001)(8936002)(44832011)(4744005)(8676002)(5660300002)(66556008)(66476007)(7406005)(7416002)(66946007)(478600001)(2906002)(38100700002)(82960400001)(6666004)(53546011)(6486002)(26005)(6506007)(6512007)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNrZjdSWFJNNnM1bDBaRVd5WW9aWXoyT3pGbHNFdjlJeDhzdjNXOHgweTA0?=
 =?utf-8?B?aDR6SE5xTXFSY3Q0ZGE0aHBpYUZkWld0K3JYVUI3OWJRTW1oTWFDRHhRQ0U5?=
 =?utf-8?B?dnNzdU1vN0VEOFlMOURIL1ArYzNPeUYrbXdham5kTE16azBXb3VtbVlsS0ZQ?=
 =?utf-8?B?NjNmTUtQR1FxVzg5Mm5VeUNXbTZJRlo3OHF4N3dVR240c2tXVVJjTTYxaitG?=
 =?utf-8?B?WFdDbnRYTVBIdFVuTXMwMkhsSGdWNnFkemp0NC90YllHbnhvQ2pobmJWaDdN?=
 =?utf-8?B?U0lPQU1pZXRWZXdPb1AvT0pzZ2FXYlBmYi9DcEx3ZUhCTi83S1ZZeURXZ2Fq?=
 =?utf-8?B?OFVaM2laRUt0MTBDNUpoVk1FZi9oUG1ZUUtTK0l6Z2p4MFd1Q0VXT1JkL2d5?=
 =?utf-8?B?UXkrNkI3Rkl3ZlYxOWdXdCtmaU1UUlQwbWRVNE1oZmdTMm5FRGorTGxSeXVj?=
 =?utf-8?B?TTJpbVB3ZTdBOEFybWpYMFlVV2VDMW9tZHlqRkR6R3lucVZlS3lvY0xFNWVV?=
 =?utf-8?B?WEpYakZsNktCT3MzQklMM3p1ZEw3QTFLQnN5dFBaSGtVMG0yMTd3L3U4NUV1?=
 =?utf-8?B?WXU3TzMyM1BRcmc5czN6NHkvZmYwRHkrRHNxUjhqWVlweHByQWhwZWxPSlk1?=
 =?utf-8?B?VnJkdC9zS0hLZEovSklqYm13cTFzWnYzVEFURFUzU3VxTktTL3ppWU9CQ2Uv?=
 =?utf-8?B?RnJacnF1VmZVcUZiRkpzR0ZQTzVMVFFpTDkwSjFaVUY4cnRDQ3JKdDIrKzdr?=
 =?utf-8?B?QWx2N1NRM28rNHlQQVBHUERwUkNTWXdoNlRzNkl1T2xyMlJPcVoxbTlubkU5?=
 =?utf-8?B?Q3pCZmd2Vlg5R0g3eHFyandGTHhrUjBFdjJMUWF6WTRMaGJxWW4rTEV2NEZC?=
 =?utf-8?B?QTI1Z2FsK0JwRXFaZmJ2bFdWNE1TSjFxRy8rSVdOQUJWSlVmRldDTGs2YjRC?=
 =?utf-8?B?RHNTRXUveHpwc1plRyt2Y0xvbGJLR2dFRTZiUWMrY0FBaVJhM0FYTzZtM1dh?=
 =?utf-8?B?U0lIc0gra2w4OTlHQkRTRzhlaVNrb1NqazBCQjMrL3dXVEZZR2YyZUh6eUox?=
 =?utf-8?B?bzg2YnNTanFPWWZIMzdvbG5QaGlrWHNHR25SWEx4NmNuWEZkaWdyRFVCWXpH?=
 =?utf-8?B?VUl1M21TTTdWYW1xT1hRUEtiTHJyV3BJU0RvSjc3YytUOVpvekJtZU9qUzkr?=
 =?utf-8?B?endrNVZMVkc1MGJOY2pyeVJYNlFoSDhwNWZ4eGpBSmxobzViRW1NYVZzRWE4?=
 =?utf-8?B?dlJlMzEzMmU1NmdYNHptYU9GTk5pclBtODFzcmZNZXRVdVJuRVo0T1ZqMUpx?=
 =?utf-8?B?aDVJRWhucjRPaHhLVWdTYmEwcVdqVDN0UjBkYk9ua2VqUGZUNmw0d3JhdWNL?=
 =?utf-8?B?SVRvc2wyN3EwN3NYUGFGZSt3TjB5VUJ5MGVBK2hvRVZGa2ZDbC95bGtPaWpI?=
 =?utf-8?B?bXlCcE03dlMybFowQUVHZ2t3MHBiTEh0dlhQSHRwTjhmZnM4dk8zYTZzcUt4?=
 =?utf-8?B?cTBlNVVSUE5WR0UrYTQ0MDdxMEQ1MXRhM0JpSkd0VDcrZ0NrUVNmS0hvb215?=
 =?utf-8?B?emxxc3RUb0VQZmhuaythQldTMFlkZ2sxMDJrUHJZRDhxU2lHN3NkNWEzaGU4?=
 =?utf-8?B?K0VLSkMyRDg3bFd5Wnd0aG1JTVEyc3NHd29aVkZZd3ZFdVJIcmhaUGpaT3lC?=
 =?utf-8?B?aDB4djlqMUxOdSthV2tFWGZudmF5RHJHYjJ1Wm1sYk5sOUhVR1BXOHZuanU5?=
 =?utf-8?B?b1RucnlMZm85WSs5U2IwRVk1MEhnSk1VNXU0QXEza2tySU14dUZjbitvOEJw?=
 =?utf-8?B?Q1NQY3p3SDZkc1FMZHlTZEFaOUtVQklGYnd0RG94bGFsLzZMTHJWcFFhZXdM?=
 =?utf-8?B?M1VkRnF4VXlIR2h3TllNY0dwRk9JWkcyUVZ3djh1ODNnMG50cEVDb3NyaU1F?=
 =?utf-8?B?ZXpsaUVRcEhWNnZhb3NwRWdWV0d0ZGZCYUY4T3FiNHhjeDVDMzJHUTZYN3o3?=
 =?utf-8?B?Q0hiRjVTY0MwRnF1NjYwdmpFMTQreEhqZGpQQ0VkNmo1bENWNWJVVmtHNkF0?=
 =?utf-8?B?L2dQSU5GK0FJM1V6VC8xMkhnM29pNE5xZCtocThObGZoaGYxR1ZlUmRSTGps?=
 =?utf-8?B?NnNZUEVRU2d1L0t3SDFwWlZLVzlZWFA3aW9vaG1hdWMxUWU5V3RYVG9WclpF?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a3c255-1bca-47f2-4999-08db296495e4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:00:19.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vsO3sxbypwJP8CQjHvZZwzS+c54OfI66APL42sIAHuoeCaN2f/T545rVs7wvLSdLH9JVQJrPfYHxsK8jY94FuhWv3EmJlNPbUYNj/pLVwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
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

Hi Babu,

On 3/20/2023 9:52 AM, Moger, Babu wrote:
> On 3/15/23 13:42, Reinette Chatre wrote:

...

>>
>>
>>>  When monitoring is enabled all MON groups will also contain:
>>>  
>>
>> Shouldn't the "rmid" (to be renamed) entry be in this section of the
>> documentation?
> 
> Not sure about this comment. Did you mean to move the rmid (to be renamed
> mon_hw_id) documentation here?


Yes. Note the header reads "When monitoring is enabled all MON groups
will also contain:". The new file is only relevant to monitoring groups, so
it seems appropriate that it falls under this section. 

Reinette
