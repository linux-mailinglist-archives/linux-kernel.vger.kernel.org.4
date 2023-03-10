Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E66B5145
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCJUAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCJUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:00:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB1124EB2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678478410; x=1710014410;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFDpbCdDNI0vx/vv8UdkoIeBKEyrsPEMyLEUJSZbh9o=;
  b=RoTUF9xCdXk1jIqYZ57hqZYiWdOv1ydRHn1rUAlejqBgamKbsMHmT0SK
   D75fPztYQI4JXK6D7ulW24u0J8Qtr4v39wit6L7QtlJrHGEnAsFSG4/NZ
   nWRi9vm9OntwkRP2br6oR5DfLRZtfKyrnMPc+1j9PFyyGaUAgRg2LxNP5
   fPZx8rIr8zXa1XltA3k4oetDDu88lUgOm19A4h2H9hHiC1QPMeSbrImkI
   VyNjGQ1wR7Hl0tFC0LXqKPRCYsyJcmYik+jEohXeyIPOj0Sa5weBxQnj5
   FJvgvVSMlXjBAuY1pS1++GHvBJz+uLeDt+Mtno2HbVCjTXDeHD0USCpS1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320669749"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320669749"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="677942823"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="677942823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 12:00:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:00:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 12:00:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 12:00:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVYEcZ+S8EySeG/LsCByG1gbTl00eY4vDjCOR3HeE8IWj2AQefStGWDBcWxuWJqVeGTYHORvDaQ6rEdw5zSYvF2IH9R7xSyXypvvmsieUZLHGZ7YU4MDShzn5jEsKbL3RFDsLBhZCoJhtWot0CwuVKXtOCfvvZU9o0YAmQx4nIj8y0WswKiT0l91iiASyEqvPxy//Q0GiltdS4xLVNHBAUKwmV4dwfE1jgOFYwO78R2kstVZPWyI+aQkpatw9rlL4QSW46bB4qE1xXO7RYZ2Nw5u7++R0juBgkB9fLVSIb/UHndxadlT6QHeZbvjhsRyrftQz7JjSIhrbQ5gYawVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgs9lIs78gbU7Mqdz5enDm9kL/EuKTPoQCPBAytpFrk=;
 b=baRoIDsvB8+X5prZZ1TLGJYoEzmIj21hE5p8+GCeNnNXw10Ku40/qWUeRJOk+azXU5F7hLDi/sHo7ECGyxu3LTolPV/RVvzqrLIH1ju8guSlzx3wyLi0yIfiYB6j+vQNDCviUdF1FIaE/yFtIET3rxex0r+O1kCW6w1YD1V8NhLqqDbiuU6423blIMZbdKKC8zvnqxgX5I2cQimjEw9zqjZiX4APakXhZhHqEJSBM2aP9+ji0LUyvC0sYTySwD2MXa4jEQfCfAS5/ua4TDNw3ODYDlmRdiAc24Qo8Rag3CKmEl6k6GSjIkKLJkYtAXatBS/yY2o0AMKeriVwDuaytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Fri, 10 Mar
 2023 20:00:05 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 20:00:05 +0000
Message-ID: <af4937a1-62b5-f27f-fd83-5f69f37e8241@intel.com>
Date:   Fri, 10 Mar 2023 12:00:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
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
 <20230113175459.14825-8-james.morse@arm.com>
 <678c5d45-eb91-c000-76d6-7ed9341e52c3@intel.com>
 <4002faaa-d93a-0d9b-0234-05bfae3d7b93@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4002faaa-d93a-0d9b-0234-05bfae3d7b93@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf92856-5b6f-444d-f1d6-08db21a20add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dREh41RPdh9MhFj6qTTCxNOjh4Te/17V4XniDIY5NuMdUCayb9u0IvclncluoAwNCv81Mx6ml+FkD63aSwWm56Zib7YCIXNoy6R80l99W+HKDoKTmXC2fadAcyyVPWQs2TItq1Ii1cmiV52x0v5toRnPa4axmiXm7R0+nVwMXBzd5fxvN66XCpsFOsliK4ohDvMjGJwL194Rrr7jT9zZZiq2Vwdb+CTbCasHMp/kW2vs5addKbYaAiL9I3tmBp7v2x5UHpzYNZUPw1K8HopWn0qcA4a6MOZlbfoCak6w1QJObD/1Hzyfq23fXywikeWB5wZ1oT98oHOg4LDIsn5GHy0oaD+LeO1LWvik4Y0A4kiXO7S7X1I+0PQbOuRxGsCiblGooOSHgvk6RVFgmw16SEDUos8fF3pNLR7Vb1Nm2Xani97z5Iu8FNyhkITUnKD8A7JsA6XAtxqrHFmRaR6UGbQplbpTKTdrZoWPsvKS/I6nUPycc2E5ucbV8IN99pHPVpM7AvmLeP0V3q8Tm2m1508a6835hultqFJEUj55Luy37vCNnKFFf8i4nq7sWGyA+hHuTPU/ArqTTXHE2hDEONN/Zng6rDjuv4+oq2oXykwwrvcyH+xkXccFYkn626sRxDqPzqdh+qGEfKrWLnEf6f8Wuwjx9le3vzATxTF3JxKv1YpCuPPHErWHX+XvQ4RXBtTM46/J1awWtohLMxy5a9lUrfXC7jRPBqi2/eBLn9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199018)(31686004)(53546011)(6506007)(2616005)(6512007)(54906003)(186003)(86362001)(31696002)(36756003)(8936002)(6486002)(26005)(82960400001)(6666004)(478600001)(7416002)(2906002)(41300700001)(5660300002)(38100700002)(44832011)(316002)(66946007)(4326008)(66476007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3pFZzN3OC9oT3Bwa0NqTGJ1QVR0eGdoR1JpQitHT1h1VURjeUgyL0RpR2hE?=
 =?utf-8?B?WVdPWGVMR3d4KzY4Y0dFNjVOeDJOeTlIVjRhWkhKWW92ZmhzWXoySUg4a1dL?=
 =?utf-8?B?cW1SM2t5SjVlNklkK25PNjlDZ1ZoTEdtZjZmQXR2MmVuUmxQOWh1b0VFOVMw?=
 =?utf-8?B?STQvSDFVaVVnWFZWdklGRlNIK0RCOFNHNTA1MWpCRDZLcVdqU0VmTGlvRlNs?=
 =?utf-8?B?dEtkQVFJdkEzdWJZd0dzdGFNOUxwN1hQS2JtN0FXUVJsd2xnNTY2TUtpL3U0?=
 =?utf-8?B?TmZYNVZ5SVJPdWc1VlFOUC9PZjJoYkh0SktjbTg5S2FRZTN6TFVuQVNtZkhP?=
 =?utf-8?B?b2l3cDl2VjNwQkY5Z3hFOTJmL3haYmJpdzU4UHZVMzRqamZiWlFRdjR1VHMx?=
 =?utf-8?B?YjF5Q1g2WjdvMVB5ODNldmFycDFGNzg0ajRIQlhhWVZWdGszbSszY2NYUlBP?=
 =?utf-8?B?YUt6SjlCcjRaUXY1dHFhLzYvc3FKS05VaTdFbWR2Qnc5TUkzZEF1eUtlYmxB?=
 =?utf-8?B?UjZZcU9ZakdzWDFTMHZvVWsvSkY3enp6MEZNYjNkeTFjNDM2cTRFYWFCaFZm?=
 =?utf-8?B?anFWTW9USDYxYmZrVmlTUU9LMHZrT3BsVWtDazhaUVBpbmJGbzZZWWpsVS80?=
 =?utf-8?B?VlF6NmlicGJHcE9XVVpDQUdWZm5tNnQzWlkreVh5dkV1VmdQbmNoR1B3ZVlq?=
 =?utf-8?B?ZVQvazhCSjB1TEd0NDRhTWsvVGlFbWtuY25YclQrTmJGVTB6K1lhWnFyTmtw?=
 =?utf-8?B?Qk5UM3dzSnBPY09XZXlNZlhBSEVjN29TZDVKSHhIMFJXYnF0Wko5VWluMXVz?=
 =?utf-8?B?ckVNbXBETjZ4RzZweXpDelVQQ252RFkwR1E1Tmp1Z1F0dGFhSGpXVEJnQW0w?=
 =?utf-8?B?MVRHWHRjM2g5TzJPUDAwQkRtNXoyd0I4c2ZmSVlicnZQekdmZDl1YUs2WG9V?=
 =?utf-8?B?YlJVb3dCTWhjVTJ2elk2bGc4Ym45Qkt3d1NnOHExWUxpb0hMRG9oR2c4OTk0?=
 =?utf-8?B?dS9FV3k5anhVbTFtQUljeWkxcGhMY0tlS1JTREhCQWU1RjdtNkQ5KzNhYnZS?=
 =?utf-8?B?d3dicSsyZlBteEZBcnBEMVNJVzRrdldsWXZlMm9qUVNEWFd3S2dhMWJuOEo3?=
 =?utf-8?B?S0RLVVpzMFgrK2xYVWRpcmlyVTlEczZIclRHb1dxTWlLY2lZN2FrSmFNL29x?=
 =?utf-8?B?RDFEeXFRdGorRmdiWEV3M3c2aTFDaGRobUJJZ3pRSUdrLzFXcWFCVGlWU01o?=
 =?utf-8?B?SzRnTmI5NjdQM3NUak9tR0tjQkRhTlBUR0MyV0xVUndVaHJkTGhybHBXVm9T?=
 =?utf-8?B?bmliSHpyZXVZTzgzOHR5Y0tuOXFDdmk1cVloUHVRTUx2blh1UkVMT3h6MUxu?=
 =?utf-8?B?bkJqcGM4ODFxQTlzM2dMOXRRaXgxUW9RbXVvdHVodU82ZGk4MGJ2aXBib0Ro?=
 =?utf-8?B?QzVZWjlKMDVTa3dVbnhSakR4eU5pd1pSS2dTenp3ZFRXQ3JQVXh5aWZmOGt2?=
 =?utf-8?B?bU1OakMxUmlyQ3o5ZGpSc1ZVQlhIZHgvOXBxSkxRdDRYTHJWUStUWFFXZWly?=
 =?utf-8?B?WkFtOU1IajFHQmVmSnFXRzBhL09UVzVhM1NkTDA0MVBvT3hadk9KS1piWngz?=
 =?utf-8?B?UnZMV2hjdDc5QUZsYTZOZ3E3MFpKNlhZSENTbktoNU9VbzZSSVp4b1BxeE53?=
 =?utf-8?B?eXRlUWt4c0dseFhKcGI2Q05aN0F1T21VcjZ5bmV2MGp2Q2R4eDFsTC9ZeFVI?=
 =?utf-8?B?SGlZelVoOUV4TzdiRVhIZkJuZ2k5TmRQK01HT21IQXVQcGpzd1ViWmpzSm5u?=
 =?utf-8?B?b1VUcWdTTkpXQnUrclhqcFk4ZjBySitySC9tRWtNNjU2Ukk5KzJndUFKV05v?=
 =?utf-8?B?a1hyNnNtbGhXZnJpSXR1eUQxR21zNWdHQzhtckk1akpXMzlxRVFiNWZBSVM3?=
 =?utf-8?B?SC9QNTE5TlVhalBHa3Z6Nk1pcUg0OWxkOExUVE1xSEVVUTkxTm9sYktPK0Iv?=
 =?utf-8?B?TFFMZ0xzdjV2a3kvWWhjMGM3RjFzV29lc0xaM3I1QmMwQWhJTGF6dk5jaWtP?=
 =?utf-8?B?SHJSTEI3UVdySkp4TngwSTRxaTJTTzVlNDRYMHZ4Y3M3MDlvdkNRODk4NW9Z?=
 =?utf-8?B?aHRKcGVXVjB0eVdNbit2TXRIcHdrMm5mOTJZMGJkYzZBa1c1eCtGUVMwYWU1?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf92856-5b6f-444d-f1d6-08db21a20add
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 20:00:05.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n2Tc7h2P+XIJ3bamZA9a1uiebGSo3Grl3N8x61HbYJJfiaNBovSDiDoNa05/TyK4pMPpepJ8bYABDXv2uO8irdsJ8od4UhuWYecbBVOwhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/6/2023 3:32 AM, James Morse wrote:
> On 02/02/2023 23:47, Reinette Chatre wrote:
>> On 1/13/2023 9:54 AM, James Morse wrote:
>>
>> ...
>>
>>> @@ -567,19 +579,14 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>>>  	 * For monitor groups, can move the tasks only from
>>>  	 * their parent CTRL group.
>>>  	 */
>>> -
>>> -	if (rdtgrp->type == RDTCTRL_GROUP) {
>>> -		WRITE_ONCE(tsk->closid, rdtgrp->closid);
>>> -		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
>>> -	} else if (rdtgrp->type == RDTMON_GROUP) {
>>> -		if (rdtgrp->mon.parent->closid == tsk->closid) {
>>> -			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
>>> -		} else {
>>> -			rdt_last_cmd_puts("Can't move task to different control group\n");
>>> -			return -EINVAL;
>>> -		}
>>> +	if (rdtgrp->type == RDTMON_GROUP &&
>>> +	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
>>> +		rdt_last_cmd_puts("Can't move task to different control group\n");
>>> +		return -EINVAL;
>>>  	}
>>>  
>>> +	resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmid);
>>
>> This does not use the intended closid when rdtgrp->type == RDTMON_GROUP.
> 
> Yes, it should be rdtgrp->mon.parent->closid.
> 
> rdtgroup_mkdir_mon() initialises them to be the same

Even so, I do find the code to be confusing when it jumps from one to
the other within the same function.

>, I guess its Peter's monitor-group
> rename that means this could get the wrong value?
> 
> I've fixed it as:
> ---------%<---------
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c7392d10dc5b..30d8961b833c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -585,7 +585,12 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>                 return -EINVAL;
>         }
> 
> -       resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmid);
> +       if (rdtgrp->type == RDTMON_GROUP)
> +               resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
> +                                            rdtgrp->mon.rmid);
> +       else
> +               resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
> +                                            rdtgrp->mon.rmid);
> 
>         /*
>          * Ensure the task's closid and rmid are written before determining if
> ---------%<---------
> 
> 

ok, thank you.

Reinette

