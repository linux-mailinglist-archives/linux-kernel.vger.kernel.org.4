Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026306B8405
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCMVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:35:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D288DAB;
        Mon, 13 Mar 2023 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678743297; x=1710279297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QzjhgoKE+iNeSbLAD9w3iK8ahuBW9ImODbNMekkVIak=;
  b=GG5mKGI1GdtoTNUXUFJspSnn+DZHVofve7ukvSxUfSLzZBjpgqHwG2WE
   L5DPjObSBV6TUmv2M1/nthpzRCzHYPOwMaXHkPzWNUg40QUXH0uaHJbV8
   Lt+YT1g33SxMNDUMkpJTB1ZtUjvama6V1VzC74HIStbqM979E8NUB6h4B
   XEz9fsDTGv/0lbiRMiXDYCGp2FT3klt2xLsrCLtg6OWlRqu3WIYiJmMnm
   zIMb7UhXLR8FOMCi4UlsjOYpxgpri7hRdOEZlWyYq9VzEXeoBcrV/wguT
   iUUgXqn49jEoXzCv+n5h+qIdvBuGue+byMuMKWb9NwjAEn5RIlZpAg54N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316907870"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316907870"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 14:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852928010"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="852928010"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2023 14:34:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 14:34:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 14:34:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 14:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC/zjSkg/AB01gKJNedlHcZ/+WTg1N2Je5oFPNl2JP44dTln7fe2uULEWiTnxtO5JMVkyWmpM8smiVdh1yOzE9+ycYNJj6hSIAUNUDUcg66A1eRVA2hxc7WDgGN0L+Da9nlNTBDGXRrqSLjdHAWU4HXZpnfCLaCZfVAQMwO4p7yBRxTdVos5sTi2FDzCT9/qCFyy3MZ8XiyKAW8DP67mEtgR90kwxEqKFhGSNxZeWcnHKkfrtppD5gNT21Fx9//gsR9w/Jrthb5pLm3beIBRioUnFFAKyhD455PsdZGgEotr9QdmEBI2vifZPtZrReCgJ784rg+IYNeP/rMgltzPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81jCAR83ARdFeKnbgQlSBUy4w7DPd4h4AK6o1+v904I=;
 b=iEPnvWa1POqydECAhmOseHxZ0m6L49yM7ivuLVEdUUxAm3nNPM8ISwFGtR9ZLNQCI4P67noI7j2tSl+wbbuwO+q7pcuA40adwArmZRKq4X8UutznVu6Bk8XywY1s5UXCd/HUsi0rBR3uHDHHXQHH2jX2DyhFEKgiQqQtXEZDuiboKDaaDCKFF/yVJCWneKUJR+5x8RNEsQzbBT/AAnS9+KYYVRQgO8AZg+mn6uDa8a+Rbz9anngXUAxtxgQLAGMsGSxEolqQh9ttSvw2oZWQxJLViBqg3XAF219vSw49LhMggK0E8sOIoyqw6g8bfcfoH3d+Gq6cyVRcbMVQUyFHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Mon, 13 Mar
 2023 21:34:51 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 21:34:51 +0000
Message-ID: <2ae25756-7403-ad5f-548a-50e633040bf9@intel.com>
Date:   Mon, 13 Mar 2023 14:34:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/8] platform/x86/intel/ifs: Reorganize driver data
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-2-jithu.joseph@intel.com>
 <a6ae936e-effd-3794-e6fb-11b33a4d6eb1@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <a6ae936e-effd-3794-e6fb-11b33a4d6eb1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SJ0PR11MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 602bdd33-bf8d-45f3-df98-08db240ac717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjGoZRwZdB+IZXNGGPzmBX3c0JglRyS7smzBUfu77RZzEpAorzCptxULgpvbn9I1dLmZb36tpwtVQLugMgl9+n+MkXDF8kRlWjDBhKDNZHv+xkPEbL3nKEvAqSM7E2tK5C1OzWEaugSctfwMKCn8ml6Dwyw3y9MgAR/MbZhcs0nRqDuy1AHZEEtZkC60WOtRstoglLC1l9aCgWBFlc4xMrLdV2oRXWYps8z7atkImdbS+4OXJogBKK+qeTZ4a/S1PU2itwSVs6VUHBIneOyuzaXFcCWgyXAKNhNL+UMnxajE/YmyyuM9tJN+Q0A53unrdMyVr01yh9RI57pxrSIVXjT1TFIGihM9axG6wAQ642i3qIO9f04/nWu/f97Dfp+2phAofCU8te6v56b/tEy/1uKv2pTSojoRUS+cudS0no0GpTMSv7DzjxBhukZbdfUhKSv0pWPtzvlevk6ycSF+V6WrJTH9XMHH2d1Uocx/0HUAOGRQvYWy4Z1WfkKA8w5v32nSb5aIz05CZ7W6OJvCH+jXHUrNUUgEyRDJzaEb903j5SphQYV3oE2g+dGhEq9p7wjrlmtWWBfL5KcOgD4NYLBoTE0L7IsyF3Cqj17xAjUjlxeB/0P93dZSKpY2m7RakWy04PvRefUzetyf9VDiIErPK7TyUwt/InTIqOVStbsB+oD1O017xv+zuDUSRJfeBJAxMDXjXn8X0vs4qwarknk1C1deaR5x/jxNX3eKA3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(36756003)(86362001)(31696002)(41300700001)(26005)(6512007)(6506007)(186003)(53546011)(5660300002)(7416002)(4326008)(2616005)(8936002)(316002)(478600001)(8676002)(66556008)(66476007)(66946007)(6486002)(82960400001)(6666004)(38100700002)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE8vYUxaakhBQjZkK3JMVXhEbmd1N1lJaHVIYnZKUlVtV2Fhb25HK2RGVHZn?=
 =?utf-8?B?bHNKdDNHK24xU01nRE0rek5xV29Pc0ZQbTdzZ2ZDenVWRnB6M0F5R2dicEF5?=
 =?utf-8?B?SW5tQ3NzU2txZ04vTkd4QTFQQll1VFk0ZDlqYWt5d2o2K2t1SFFzeXVIa2lC?=
 =?utf-8?B?UUlDQ2ZoUUpwc1pIQTE0V3JwNXoyUnZDUytyVWIvK21UV0lVZURsc2tsaGN3?=
 =?utf-8?B?TWlLdmphQk56SlBxc1FmaTcwdUtRVHlwZWg4V1VGNzE3N0l1a0xDTitKcXJo?=
 =?utf-8?B?blE3N3dIZVFUSXpnWWxFZ2dySlhVcm5nSzdrWUhwMGl0WDJjSHJKN1pMNWRt?=
 =?utf-8?B?d1VVYzQ1cy9POUJ5aUVlSzBxNk1sbVhweGw5R3FBd01lemZYK0QzcWwzcEZi?=
 =?utf-8?B?VUZFdU8wY29HRWIxdEIrZ1hEQzk3NG8zVFkwM0FWaUNtLytkR2krdW0ycnlT?=
 =?utf-8?B?eFVscklwVlVSdjRDbHB5aC8xc1gyR0ZLSDNTN2FNTXNPaXExQlN1NGF4ME9O?=
 =?utf-8?B?V1ppQUpVSUpmajN4WW11L0xnUkdFNndSdzlQakMyY2ZJLy9ydFdMcUtTUUVm?=
 =?utf-8?B?Qm5NMktIZGRkd0tleDN0dm0ycUFhMGU0RGk2cngydlN1b2FiMGt0UkZocVp2?=
 =?utf-8?B?K1oyVjJSb2RXOFNhUHRVR2tiQmY5QWgwaFFnZUpTSERwZFBSUThoN2hLT2pJ?=
 =?utf-8?B?c3NITzdPOEVxZ0pOditNazZjMEppbUo0ZGJDVFYxZEh1dy9KVzVBMkhFejVQ?=
 =?utf-8?B?dTJEOXduRDhPNTB1NmV3NDY2dVQwKysrdlZVRU5ncHFnMENtbU8xdzFLTEZR?=
 =?utf-8?B?ZjZpWmVXRWdqN1dOaXY1U1FjQXdVZG5xbkx5dld2UldxbHR2T2JaOVJnRXB2?=
 =?utf-8?B?QkExYW5ITktBb3dqWXNDTHd6UExPc3JmWU5TWXc1VzhYYmN1UUVVamZ5eEw5?=
 =?utf-8?B?YnEvOEZlK0tyODRwRDVYTjNxa0FjWFk5NFZIeVVEbnlaemtFbnBLemxWUVZQ?=
 =?utf-8?B?V0UrMVlQM0JCYldaNkFFcXN5NEZvbTNTdG9zLzhYYkZhOXNhY0tTWlo1S1Fq?=
 =?utf-8?B?eGRqMWcvRldKdFhJaWlYdlgzL2J0bDU2QmdxT1hCUVVwVjJ4dG1RTjdENnZt?=
 =?utf-8?B?YjlURDBpYUZFaVF3QTRRVkQrSEdJQ1hSWU5QbGVNcUgvVkpycFY5MFZRdzlE?=
 =?utf-8?B?WlB2blNvbENVbzVGTG0xWThUdkwvYWRUeFBWSVVsNHVDL25oNnN2RXppcDlp?=
 =?utf-8?B?OHBibWpGYU5mYnFhY3E1d1VjRmlWNkZOa1AwWGowMEpMWmpHZGNZV0xtc2Vu?=
 =?utf-8?B?ZXRJWVRRTlpTbkZyRmhwcnZtdmxBeCt5Y3IrSWlIRkl4c0dHZENGcU9aK3lO?=
 =?utf-8?B?cCtBSFgxaitua3ZtQ3VXVEg1eDAwRTU0d1lCY0Flc0Rkb3NudTlVajd6SllT?=
 =?utf-8?B?bzdMZnlpcUxxcGxzM0hvZW5GWE1KbG9VMUFlQmhrcFdHeGtOOW5hVkF1N3Na?=
 =?utf-8?B?d3VDRmtjNUFCeWhzT05TMkgvRm9iNUU3WkNvbUZHTTVyZzVPY01ncmVYK3ds?=
 =?utf-8?B?L3BsWmRXLzRNVWZScnJGY2g3dGxNTk1UOGRXYXZxaHlmOGhEUmNjRXg1c3li?=
 =?utf-8?B?R0Z5QW1kdkN0TFk5RnE0b3BRbnMwc1RtbmllUzU3SHN4THRtNWx1SjJscUlW?=
 =?utf-8?B?MlM3cVRLdjgvUEhTV2R3OUVoeHlpcVlZUUozc283cFdSNnpkV0c5Q3ZMNzlO?=
 =?utf-8?B?ZDFjN041NGZ5eWZpT0tvdjZsRmRzTXdYU3ZzVmxkZkt5VVJNc1JNL0FIaGds?=
 =?utf-8?B?aXRnU1RvUXpYSlhrN0FQV21CMStNT01lbjJ1eXRsektLN0NvaERJaHFOQTFI?=
 =?utf-8?B?blE0U3o3bnhFRC9BcUxEZG1FLzBQVHV0K2gyTWlNclZPbHNTUkVLSm92d1hu?=
 =?utf-8?B?cmJheEhHdHM0ODhqeXk5bWNqOE5PTmt2VUJMUFJXcDR6TGhVZXowbVpZeFNU?=
 =?utf-8?B?Q01yak9uM0RPMW9EYkNkeEhkZStWcUhGenkrT1Q2SzF3b3lzU2xlRlp1TnFw?=
 =?utf-8?B?RDZlR29aMkhOYXd6RFozd0tFMlFnUVNnaDVlZ0NWRUdIQ29KR1ZqYVFwS3Ey?=
 =?utf-8?B?SDBGb1ZMVjRyTkpiL3J3ZTM3ck03U1NpeDZ2NWVvOEEwUjdaemNCcFJyKzdp?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 602bdd33-bf8d-45f3-df98-08db240ac717
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 21:34:51.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc3wlQmDZz1LoK9Jp2esffrw7/GlVvg6mXSOaFaTLRy61wOhAwDwwmmCRDTcKZpvpzlJ1/2l58Wswyr3k1GwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2023 7:46 AM, Hans de Goede wrote:
> Hi Jithu,
> 
> On 3/1/23 02:59, Jithu Joseph wrote:

>>  
>> +struct ifs_const_data {
>> +	int	integrity_cap_bit;
>> +	int	test_num;
>> +};
>> +
> 
> This is a description of the specific capabilties / bits of
> the IFS on e.g. Saphire Rapids, so please name this appropriately
> for example:
> 
> struct ifs_hw_caps  {
> 	int	integrity_cap_bit;
> 	int	test_num;
> };

This can be renamed to ifs_test_caps as it holds test specific fields.

...

> 
> You got this exactly the wrong way around, there should be a single
> 
> static const struct ifs_hw_caps saphire_rapids_caps = {
> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> 	.test_num = 0,
> };
> 
> And then struct ifs_device { } should have a "const struct ifs_hw_caps *hw_caps"
> which gets initialized to point to &saphire_rapids_caps. So that your const
> data is actually const.
> 
> Where as since the r/w data's lifetime is couple to the misc-device lifetime
> there is no need to dynamically allocate it just keep that embedded, so that
> together you get:

Noted 

> 
> struct ifs_device {
> 	const struct ifs_hw_caps *hw_caps;
> 	struct ifs_data data;
> 	struct miscdevice misc;
> };
> 

The initialization portion, taking into account your suggestion above, translates to:

static const struct ifs_test_caps scan_test = {
	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
	.test_num = IFS_TYPE_SAF,
};

static const struct ifs_test_caps array_test = {
	.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
	.test_num = IFS_TYPE_ARRAY_BIST,
};

static struct ifs_device ifs_devices[] = {
	[IFS_TYPE_SAF] = {
		.test_caps = &scan_test,
		.misc = {
			.name = "intel_ifs_0",
			.minor = MISC_DYNAMIC_MINOR,
			.groups = plat_ifs_groups,
		},
	},
	[IFS_TYPE_ARRAY_BIST] = {
		.test_caps = &array_test,
		.misc = {
			.name = "intel_ifs_1",
			.minor = MISC_DYNAMIC_MINOR,
			.groups = plat_ifs_array_groups,
		},
	},
};

Jithu
