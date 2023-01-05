Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157EC65F514
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjAEUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjAEUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:14:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CAF63D2A;
        Thu,  5 Jan 2023 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672949648; x=1704485648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ea7szoopLM9JGDgFOxYYtyGoHvevhFcbbppw/zDRH9s=;
  b=CZVAWqEcY7RHentPvpZ/wWVMwSOq/oHDcd+7iKyW7gaM+gem38JEaCuc
   /94KRTtSuQoHJmVFxFWdL1wypOdG9WFRYeKOOefDTiC2mnVEnGK85mdVA
   ErNpGqQyvMPAJfVC5Q2nMA1IIiBUVNeHCxyDATfpeSJabVwBabumDTemZ
   zwFKL5tib27VZ7XzKvvY+fhcFJqT92wMoAjC+ah5qPeJ9UVZ/0/YivCEO
   ZeXTghYW0ehzQ+w5NHRnVNaOu2xHfO4LxDuyFh6rLshlaJBKVat+bxvpz
   OMfwEHJ9qFLIrsf30Tj+l+c3c31o1wElyKffSR7or9ZtrimIr1ZFqx7Kw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="324337220"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="324337220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 12:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="688055135"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="688055135"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2023 12:14:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 12:14:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 12:14:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 12:14:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7jrFHZmwdLWgCWcErn3UVhFNYgokMuH/SuK/y8adZo+DLoTdevh7BSxRHbPmXkAO12+9B+3UhKUbGrPeCBoi/Z0vjD/6eE60OXvWIYwfdYyL36Et44dU1Qsds7wJ2RN2myurNrWAsjEBC/ipLw9wD9apChM0k0i1EPrCntWMqgkt6wLGdnx1uhWdrQvNvYD6tBkfZhEqli9VvdVn9FMOp/9tcfRfu/c/2dUMkVTbvMNsBVMRY17jZrK/wo8JuhmFcqGQJ1WMNMHf13dCzcSRcyyCJkbCuTugmm5x0MHBMrtiV2kbZpAg4ynWbcK9q0PdMDsIXwbDpJNUMRiiwQyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGPMZ8VdG9eIDZ6ArnWbCOt8Gyjiq2trvcLSugDHVgE=;
 b=NxVNZUrx3oKy78H0eEUnT1FJW72vOXFZRgYYXL2XWM6modswQ6AzVk2/ZzOWM9yG+P04//UHij5YfJJQHea5wcPPrEBEiHSAfZiALMngAxV/IuZ7061OB8Klrf3Zp37rEwfQDRDnaz7XIxeDBfBeROpDzyMf5oinIZhl5deHq0QbAWVAmcLGjSPny4JRqYwy3zbwc5y8eihP5guY/R+vyn4AdGs4VgEtiWkznxBhgWaSu9AQWidj6eOduoz39sTaNDFUoI89Uy6wvKwFdPczmoQLuCD3FwFMGIhb/wIxFlITGlMPNsJJozrAN4X9tRxvcnJbvm7uybmFhVXKUxT9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 20:14:03 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::61cf:8d4e:a75c:9389]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::61cf:8d4e:a75c:9389%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:14:03 +0000
Message-ID: <951809d2-bff1-cc62-0bf0-8dc9cef16f40@intel.com>
Date:   Thu, 5 Jan 2023 21:13:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, Viresh Kimar <viresh.kumar@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230105101054.108ad186@canb.auug.org.au>
 <20230105103519.4e849420@canb.auug.org.au>
 <bb71721b-ba20-90d9-df35-aff3c175194e@intel.com>
 <ea9167d4-0978-fc4b-755f-8df09fc7360e@linaro.org>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <ea9167d4-0978-fc4b-755f-8df09fc7360e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|CO1PR11MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: c16c1085-13bc-42e2-7973-08daef5963b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2e107ToMNDyM3cEyacg1JBnzfhywaIXbcKai5G6sDkOe34CrTi9qvfMR8WJUfw7W6QHX3iTIRSDf4+0a1Nmh9PiMHV0jOh7VDEJg87C/Rux4Zm7uNekXp4exLBHKJk+rrvTrJGtUnZF2wkQE14bGUFz5KmrNhpfAWDnc5uhw2osuUZ1+ftpCE0xbI+IeETIGpXAbcXmAQ0oLBeGDSutT3AAw1LqNj2LUc476oxiL+cnEqvxUvdUw41GS33gBL8IelyFYJX1LQO/YCGAvze+5TjN6PjQvuH2rIcj0ocwifzerIjYVLk7g7NOSCZxljcOO8p5qe4VDQI5A81hm+AQqshOGIJoj4iHPr906MC2p0UGEeavu9CRGHb4hfBlohugEKdrvhop5dUv/M3GPQdb/8oZZv/As0ANVlisUjlcGzqe8WXMec+haSGGyKawgmUeR4CLt7MnsG4Qcj5VA2bsmmXEiJxFJelMjjvuWy7Fktgvcdrv/YEbU3M4Ji5pop+6KloBTWRgwAOXtaH5CE78czQYAsiaBj2JbmdwrEteCs6ZpduvBFLoi1stPofzxC3n+NqhZYw/n3Ml32NkGcNUrdqCTiVpMVTMJg5M1uTHuo0MnfN9P65uBTjuGsPm5WMoYXTScsiOVCufBNpptPmEzOWTGdpeJijZZKTm6jbnGl3AK0/z33OpWCpt6INHPnQMnr2QCYi2TqrKABLf6HfROqcetd8LU7mji893+2Qju1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(83380400001)(6512007)(186003)(26005)(6506007)(6666004)(36756003)(86362001)(31696002)(2616005)(82960400001)(53546011)(38100700002)(4326008)(8936002)(31686004)(41300700001)(5660300002)(2906002)(6486002)(478600001)(8676002)(66946007)(316002)(6916009)(66476007)(54906003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVveEZHSGhIWnpEbWdmUkczSXdybi9mcXFBL2M0R0hOcGZXM3dBUlJkZnYv?=
 =?utf-8?B?OXVldUxpVmFmc3RwM0Z1SnlLWWh5R3VMSlJNaGZ5bDlCaUZ4NEI4ZmNzN0Ux?=
 =?utf-8?B?ZGFoVGphRkZvb0UwVTFBdzZBemlSSmlqZ2RkeGVrVW1Rd1FTdFMzMVI2bGti?=
 =?utf-8?B?a1FBblZvaVdiN2RldEJJRDdPeE1hYUh3QzJ6bVdaV2FqU2lHZzl3dDZmUFZ3?=
 =?utf-8?B?U1pINWZYNkIyaGZ3T285Sk5pYnVLNnFHNEJlcUt2N2lDU2Q0RnhMTTBGczRO?=
 =?utf-8?B?R2toRVkvYmRpZlFaRER2TVpJT05GWmxYZStodnE5RE1IWXJ3ZmxNeXJScUlI?=
 =?utf-8?B?Sm81ZXFUS3Y5VzF5bVJhSHVHb0Y5R251WUpZNkJaRWkzNDlTcmlraElSMHdV?=
 =?utf-8?B?aHFVdVZqY0lFSFlmSGxPWFdNNmtNYXZMYkt1aFd5Nk95NENwWC9VMDFValUz?=
 =?utf-8?B?VzJEYlpQU1ZaVGdRek12eTkwNVUzSDFlY0RqQ00zYzdia3NjNk1tTndmaFA4?=
 =?utf-8?B?SlpiV3psQlZFVmkwOEFJNWJtWHhTTXhNdWtDL1o5d0tWUFpyYWt3S1ZJSSs1?=
 =?utf-8?B?V05DTWtPdEdwY3BpYTlrZVV0aFd3V0hRVzZjQVNabXh1VnlMdmFoYzZTRnZS?=
 =?utf-8?B?K2NwTmdxajl5bTN6bDlxTEZ5c0tNWUxJeFhIUXFVYmtjZm5rNkYya1FJVXFQ?=
 =?utf-8?B?QjdtYjdXTFNLdXlHbWhPRzJVMWlzWXplT2IzajMzRDRWQmtWRm83M2NrSjc1?=
 =?utf-8?B?TGRDOXovaFdFcjAvMGNXMTZZUHdnRldWd1lXTS9lWjV4VFYwNUpxaFExckd6?=
 =?utf-8?B?aE5JM2E0N2tIRnoyVkU4WFVsc09KQTRmSVNOa3pha20rTjZkWTUwVGF5SWFx?=
 =?utf-8?B?dHppaytnRGRHZTB3bWJmT0VTRDA0cVRTY1VjM3RTa2VtMXl0dWRWYWdmQWpu?=
 =?utf-8?B?VlFkT1ZsNnhmbGxwMTVjZ2FuM3laTTVTdnJBcmNKREdwMHMyd3lWRGoyYzBF?=
 =?utf-8?B?NWVZNUgreUo0U05zbkJLQnlZQ09RS0czQ2R1K3dJeHdBcjd4NGpCVFBqdC9q?=
 =?utf-8?B?SmNzTXR0UFFSWXZaMVRNMnZyNVhzR2Mxc1M0RkNtNk5RSWRJUnB2dVhGQUVv?=
 =?utf-8?B?NjcyR0Z5L3gxZGZBakd6Qmk0ZVVKd3VRa1FvR01ORUF6T1l0SjhSMnoxUkVm?=
 =?utf-8?B?N0ZTOEZOeE9PQXRIM21JYThVSHhmNUdWSTVXMkE0KzNndE5BOVZBZS9aMmRC?=
 =?utf-8?B?TmtwSkxJY2ttOEJsV3ZGd0hZZzYraFhiaGJIQTYva1pVN1g4NEFxSzVEZGkr?=
 =?utf-8?B?MVo4MWc1V1daMDhFM0dkZHNEQWZTZ0hCMXhCdFFyQ2hPbnR0UlpxR1RqOSt2?=
 =?utf-8?B?NmVVMUt2Y3Nqa3oyd2J0ZlRZeTVtZEZJcjlQSi81UStDUnpSekpBcUcxeDgz?=
 =?utf-8?B?SnJmS3NCNzdFWTZaMWRXa2ZMcXB4QWlHN2xKYWFrVVprZ3VDWklXVXpGcUE1?=
 =?utf-8?B?M1JGNnRjZG54MjZEN1BucmFYdzlwVjdObjdhdkFjRmxlM0xjUUIvZ0pLbWpp?=
 =?utf-8?B?Z3VuVnB1UUVIUm1BOTZNYWtkSFEvYTBHemg4aCtCRHVvQm1jSjh5OHk1THFw?=
 =?utf-8?B?eS9UelJJa2lKOWd2ZU5wTFR0NEJrQVp0VjZWd3pWcDhHVllUZFRWSEZ3K2Fi?=
 =?utf-8?B?MFIyRXM3QVk0TlhYK2llaE56V3Y5a1RaajhGSzFRdGNNWDFDaVRWNnZPUXdz?=
 =?utf-8?B?RXBSRG82UlFxc3AySDFXcGlBWlkxSVlEamE3VjYxTFlRVUMwQWJzZGZUaTdy?=
 =?utf-8?B?Qlo5a01sb2daVFRtS2o2TTlybWFGZzYxWEhMUWswaTlzMzRXc3g4YWUxM0ls?=
 =?utf-8?B?SFc4cEVDS3M0Zjc2OC9FQnIxM1dRQzE0Nmp4V3pWY3F0MHVBcXVuck5nSkth?=
 =?utf-8?B?MXRySHI2ZVNMbCs5Z0o3clNPLzBTS1BMYXkrbmdCUnBRcURWWHBjTlR5T3Vq?=
 =?utf-8?B?STlLNEw5MDM5eGcyZHJ4NnYvQWdHNEI2WjdjcSt5ajhOTkRpeS9EN3NNRUVh?=
 =?utf-8?B?NUdKMnRNaWlUYjBiRHVvVUo5djZ3VnhPWWF5T0FNb2dXU256Qm8xdkt6OW9D?=
 =?utf-8?B?YXFJaHFWZ25qRXJIRFlzb0JVRE5zUE56Q01CYlVTdEw2b0JBUEp3ZmtobG84?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c16c1085-13bc-42e2-7973-08daef5963b6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 20:14:03.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EimOLsBbDk4huODp3jiVAymz+jztzre1ITTJSqT5bd+D2kUk/XV1b3h7hGqUUJmW3h4HyHWLVOJmqmMHxmd0lQlncpVqALDavKZ6IYZD+5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/2023 4:30 PM, Daniel Lezcano wrote:
> On 05/01/2023 15:27, Wysocki, Rafael J wrote:
>>
>> On 1/5/2023 12:35 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Thu, 5 Jan 2023 10:10:54 +1100 Stephen Rothwell 
>>> <sfr@canb.auug.org.au> wrote:
>>>> Today's linux-next merge of the thermal tree got a conflict in:
>>>>
>>>>    drivers/thermal/intel/x86_pkg_temp_thermal.c
>>>>
>>>> between commit:
>>>>
>>>>    58374a3970a0 ("thermal/x86_pkg_temp_thermal: Add support for 
>>>> handling dynamic tjmax")
>>>>
>>>> from the pm tree and commit:
>>>>
>>>>    03b2e86a24aa ("thermal/drivers/intel: Use generic 
>>>> thermal_zone_get_trip() function")
>>>>
>>>> from the thermal tree.
>>
>> I'm wondering why the above commit is in the linux-next branch of the 
>> thermal tree, though.
>
> If you are referring to commit 03b2e86a24aa, it is part of the series 
> which was reviewed but got some locking conflict issues just before 
> the merge window so we dropped it. You asked me to reintroduce it with 
> the fixes after v6.2-rc1 is out [1].
>
Ah, sorry.  I confused it with the new work posted recently. Apologies.


> The previous conflict and this one is because some changes were picked 
> in the linux-pm branch instead of the thermal/linux-branch.
>
So to be precise, I picked up some new material including fixes into 
linux-pm while you were away, and that should work, because linux-pm is 
an upstream for thermal anyway.

Things are slightly complicated by the fact that thermal/linux-next is 
merged directly into linux-next without going into linux-pm/linux-next.  
However, this also happens with other trees I pull from, like cpufreq 
and devfreq.  In particular, both Viresh and I sometimes apply core 
cpufreq changes and it all works.


> We find thermal Intel changes going directly in linux-pm and thermal 
> changes going through the thermal tree. And sometime thermal core 
> changes picked through linux-pm and sometime through thermal/linux-next.
>
And because effectively linux-pm is the thermal's upstream, it all 
should work.


> In order to prevent these conflicts in the future, I suggest to always 
> merge thermal patches through the thermal tree.
>
There are multiple ways to avoid such conflicts, we just need to be more 
careful IMV.

I may as well merge thermal/linux-next into linux-pm/linux-next before 
pushing it and let you know if there are any conflicts.


>> It is still under review AFAICS.
>
> The series including the patch "thermal/drivers/intel: Use generic 
> ..." are reviewed and ready for inclusion AFAICT.
>
> I'm was waiting for an update of linux-pm/thermal to send a PR against 
> this branch.
>
I see.  I didn't know that, though.


>> Daniel, can you possibly create a bleeding-edge branch for such 
>> things? I can merge it into my bleeding-edge branch on a daily basis.
>
> Yes, I can create a bleeding-edge branch for other patches. Some 
> questions about it:
>
>  - thermal/linux-next will be based on linux-pm/thermal, and 
> thermal/bleeding-edge will be based on thermal/linux-next, right?
>
thermal/bleeding-edge is what will go into thermal/linux-next after 
getting some 0-day coverage.  So the flow may look like this:

- Add stuff to thermal/bleeding-edge.

- It is merged into linux-pm/bleeding-edge (note that this will happen 
every time afresh, so you can rebase it etc. before pushing, no problem).

- Give it a couple of days to get tested.

- Move it into thermal/linux-next if all goes well (they need not be the 
same commits, rebasing is fine).

- Repeat.

There will be some topic thermal branches in linux-pm (eg. Intel thermal 
drivers), but this should not be a problem. We'll see conflicts and 
address them as they appear.


>  - When patches can be considered for the bleeding-edge?

Anything regarded as possible future linux-next material.


>  - When patches can be considered moving from bleeding-edge to 
> linux-next?
>
When they are regarded as ready to go into the mainline during the 
subsequent merge window (or during the ongoing one if there is one in 
progress ATM).  IOW, the normal linux-next rules apply I believe.


> (the questions above are for the thermal tree).
>
Sure.

Thanks!


