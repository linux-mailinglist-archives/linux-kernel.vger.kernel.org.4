Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847046FD182
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjEIVgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjEIVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:35:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607D7DA4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683668135; x=1715204135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AXPlzEdhXSHAkX0IDpYNA+dGT13fyKBDazDr/fK394w=;
  b=a8L6Mq8kT3azptYFeieEAaonTYzueHcN+03sguInqxLMLQEINFCz8PFF
   28FgfYK8mFrx3FfO6LEhfAayQBbfLcIPRAxWNwwcsPlqdBhhJG3lpJ5Qo
   +yuiOfnY5wnryW4Xt/tToblNvyDsRGYVNSDIpZVZ9RVneVo8Qig2e7JpZ
   75EITDuwr9KAMxVDRwBhL54d4NPYVLx1DKgQ8I9yG9AnB4I59ZijOR1OJ
   I2ry4NRvXjTqDRrVS7dLZR8tJG/cilENiBFawR9Ershs5GTJUUxs9oOid
   zpKN9DN+6uAennRPSjVrvWbXHKeqbA5AMP2RKbMQ4QnESsrItj9guAgAO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="378153723"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="378153723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843268648"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="843268648"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2023 14:34:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 14:34:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 14:34:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 14:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+djl0wSYVv1GPGfNj3aGDTttlQfMtqOp1KsvHqsAcN9CKOq/3mbr/xWV+SiawbQhnrtotLwSerIRbXgmoRgwuYr1jkftfMO+25keiEYy/mHt9Iqm1H93Bi8cjXNQ/U6mROs/tWqlfID0DxuacZf/kP7xGA81ANeQXy3gyAAhWQR0pqdMzcfFz69KDJf5ndeGzAfyqTvaiz8XucYN1kAtoDbVSQgFdD1dC2yYmLaeRpAMaIpmb81jjoiUR+Lp1JYVog1Kb/lByrmQaOghlEj/Tm0V0BBHYa+VqvWkSRIEEn3qmP9hq85GmBACY44q9ZZ4rOBgFLr5Z5ppvpvfNAS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgpklc1alhhv4aaklqXfEnZvXUsULGJWLdrtPYNT5cM=;
 b=INmKRN555WA2KUY/J56YrPPwzoVdR3TTsENoXsVLtMIVY1ioBaNbtSqHSPyV96Xw8m1hmaU5EsrclWT9M0aiSJTd5Vq06mvTXV4TxucLWCCR9INUVWz4w9PSRCjc2GRulPrPo5heuFBr//XBrOuw35ok4oMyXXdZiYElwAnVfr4RpsTfMlO4oGkXh9JTvH5zqiiUnw20A4rc46WU2rNsQqvRI8/tntLVKjPs3e5Z8iWpD5qaVPIsi7dmAmfHAPKcGstPlrNMtRoukwo6BHWdyT25XFNc+6xNaaA1/2gJ8Ntr14oyZhFrIuodcezqr6KDbR+DbKnXrRoIcFtDwJiU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 21:34:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 21:34:08 +0000
Message-ID: <237603b3-f553-2ede-5725-239b65626c69@intel.com>
Date:   Tue, 9 May 2023 14:34:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbbd326-50b8-45b9-d24a-08db50d51edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dQeJsam1iVf1Z7hXMLIxHrDPd3BoLHq2CDJByGN6QT/wH3CahY6oy739fnlIOvJf4B8+3832TlmpNEmBUi8Opvi/UVy58u0lHnxEiUFjQLltNqzDU2AykiFVrX2fvHVX7WyluHqF1vwuERZi8kzaOSCxApk74VtaGSPA/50l2Kcv2tqYDoVydi5PP6kan49BfUAs7WGt6lYJ0k+y1FCp0YEOJjmC9MK0V7ip0GCGM+Twhs4PZRqCqwNZUYvmDXJRvAkOqtC1gHqnRp33s2hrpio28Plv9gACLzFkKgBWTPp0eTPw9dzGcXGWE19ls0x19EYtLa64SAQT9DH8qGr+vAcxyjuZLrZHVviDaHfCpfk4ssQr9+Q/wGP2pyn7mkrqN9mTsF5y187FuePxJzbPpdRNBhQdYxKl0ClVN2y+NG7akZfJbNRlJWhsmw4tUZVHbqw/bF8qZVZGQqjidugZU27cfK8sncWn51SpdpOhQPTN7pdLYlK1qlcUMm1rlMBKnVOr2bmSU2tSeQqkwyMYkUGsyHx372UaEHVH3b8cmXCZgm6mZrU2cvxEngDzR1dogUFJXY6SUkrTBII30e1YpYR8xxWzXhYV+sRLEjYyvknWWiO3vMpKa1jcbZGsZ7Ay8GnkBChovdea/72kknVQXDys4iVbZRhiHsMomCKLTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(2616005)(8676002)(8936002)(53546011)(6512007)(26005)(6506007)(38100700002)(7416002)(478600001)(44832011)(36756003)(5660300002)(186003)(2906002)(82960400001)(66476007)(4326008)(31686004)(66946007)(66556008)(54906003)(83380400001)(921005)(6486002)(316002)(966005)(86362001)(31696002)(110136005)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFCSUhiYkR1OWh1RDdIdUJ3bkFEamdVYktqR05mUlJsNjZaSXg4dW5Oakh0?=
 =?utf-8?B?bmEvL1JNRWRpeGd5UStIWG5nSTRkTUpJWFVDS2xJTkJ1b1Y4Zk5EMnlzSU5E?=
 =?utf-8?B?a3NucWRIVWNYY040UUJlRm9RVjNsYU9jdmhxd1FZV0ZwZnNEdndPTHFvdXVy?=
 =?utf-8?B?eW5TeUJ3VHdKaStzUHFMTmR2bm0zeEpKL3YxQ3BVTWlNaHMzY0UvK0I2QzR1?=
 =?utf-8?B?V0lSTnhQcDdoWnFEOG5IN1E1RStZVFBSQkRjWVpaTDFJczVHRjlFeHVxdm9H?=
 =?utf-8?B?ZU9IYjVxSmFIUnROOUtRR2FVcmJhd0ZrVllXRDM3U0ZXYlhrVCtEM1lHMWJZ?=
 =?utf-8?B?S2ZiZEk2QmVxNFYvUFVSV25LUVdmTW0wakEvUmpPTGd1aStjck5oRGZvcktp?=
 =?utf-8?B?d2VZcC9FZUc4SVFwNllTaXM2QkFDN1B5a2Y3b1VLcUg0S1QvNVdPU0FtRXFk?=
 =?utf-8?B?cVNlKzlqT2JsWGxHOE1PTnJTY2VaRWx6OUNST1RycUpyaTFsT3JGWXpMVmRR?=
 =?utf-8?B?emo0MENpa3c1dDk0TExNZUVwU2o4bHVBM2dvVjRQcDN4OVFueFR5OFpDK2ZQ?=
 =?utf-8?B?YXNYbjFnUlladC8vZHJKazR4MFJIV0RtV2Z1SFNvN1F1MkY3L09PUTR0ZXl4?=
 =?utf-8?B?WTNVd0lJcldHM0ZRS0k4NDVWMkdRQVNCcldzcXZKMDRvK2tXdzZROGRNZGx4?=
 =?utf-8?B?NVZNeGM0N0ErYUpPQmQ2czJBeGZBdm1NK2lSRXRvTzRFcXFvWnpQMlpyZG1X?=
 =?utf-8?B?SUQyL1dXQ09FUE9iamRtbEZzc25IcG5MQ1d3ZFh6VG5kM2FESDJ2bWw0ajV3?=
 =?utf-8?B?L1dCWVdtd1d1cU5OaEh5eVpKNzRWOFluc0RqYUZMNk9yaWh5a0NURWd3YmRw?=
 =?utf-8?B?TmxUMWdZSzF3MTJXd3NKSTBoWkJmeCtUd205TS9ib1VDQ1NKVFVsbEo0SlNz?=
 =?utf-8?B?VFdraXdMWU14OFI2b1daOUUxT0YxTkM1aDcvWE1MVGJ4UGFmb01wNnN0ZUJv?=
 =?utf-8?B?bVo5Y1JvQXZpbGdPU083N1c5V2dKWGtFVTlhYnZLUEc1N2dRcEJIaXBDVUhD?=
 =?utf-8?B?eDhaUVkrc0FiK05UK2dpN0I1dExCVmphbjRad043VXltQ0FvY0VTOUVkdG5N?=
 =?utf-8?B?eC9PWmpBRThwTUJqbnJEeGpnRXh3cnlpbGJVcFoxRUVLalF4amxSL0RONEpR?=
 =?utf-8?B?RGRSRXVkSjd0VjZ6TE8zejRUdEpDTER0UkM2TnRhb0tRRW8xeXd4MVV4d0xz?=
 =?utf-8?B?aHY3WVBLdndNTEp5M25adXdMSEV0YWV1TTc0K2hMaEtZTlJuQ0xuNUlRc2NI?=
 =?utf-8?B?cE9LcGt6RW9kZTYxSUNyWHIvbi9rc25DbXc1M2hJR0tkSFJycVBMOEliVmth?=
 =?utf-8?B?ZXEzRlN2YjdrS3lpbDNGOHJYN0FvdWZpUGFpU1UxaVBwM0NubjU0b0FKL1BP?=
 =?utf-8?B?T0QwQ1hVelN0N2cxSHJYTDh6ZHRyYnpwY1hGcXZWOEVBSWFLUlpGbVBJUlJD?=
 =?utf-8?B?dnRPbE1mNmtEQ1lsNGN6L3JhaTRYTDI0R2IwcDdpS0ZTRUVrQ3JhbmRqVXJZ?=
 =?utf-8?B?Z2s1NTFMMGhlcm9Ba3VqWVkxQ3ZRSEo3UlNRVU8yL3BzK2ZreHNlZUw0QU9M?=
 =?utf-8?B?Y0lTeERtSXk4TnJXWGZ1TndVUDBHbWt4T1FYZmZvY25ydnIxbjVrcktJRGZV?=
 =?utf-8?B?em1FUnNPRjR3YmRqRnppUHI4aUtoNElvcG5tR0RZbmtXbWNla1ZxbUkrU0xz?=
 =?utf-8?B?bEJHSUg0VzJGNVBHMUdjN0d3elFmdTFYZitGempRQkhQbXVzdExiRG5mV2Zx?=
 =?utf-8?B?UHNLL3ErUEhKa3JoRnNCUFB2UXJVbWk4czR6R3ZMOUVKdjNaZzhOMnpFanhG?=
 =?utf-8?B?UWd3SkRRNjN4VVcwS3lhV2tVMnJjWjZBajN5ZUlaVG9nZTFsaXBFOUF3dUYv?=
 =?utf-8?B?S1F0bEQvNzRTRENGWlBLSlNmUjFyNWdpMm5UZjZuSG5OUVpyQk8rYUQ5Nnky?=
 =?utf-8?B?WjVYTDlhR3VhOVJlbHBwbVB3eUNOc1ZMTHR3akJJNVAwWkFEZXRxK25OblhC?=
 =?utf-8?B?ZGRRdm5iWXJjTEpGRks1YTNIT0FsZU4yTzF2RmVVR1hjWWFqTS9GaEQ1V0xF?=
 =?utf-8?B?S3BjOHZ4V1JENXlBczhRbGR5bWNKc0JwaTVjQW1SdFIrMm40UytTSEdmTEZP?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbbd326-50b8-45b9-d24a-08db50d51edd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 21:34:08.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qXE/R8r2kRQiHsBrJSbhianRBirTjN/qpHaocAEMPY8slNLaZnJkKrFRLO0AcJSzDVhquThm+1teqEpvu6zBSNG+MXh4osAMZ2TDRN7iIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 5/8/2023 11:32 AM, Luck, Tony wrote:
> Reinette,
> 
> Thanks for the review. Your comments on individual patches are all good, but I'll try to address
> them here to keep all the pieces together.
> 
> You sum up everything in your concise:
> 
>   "I would like to understand these two motivations better."
> 
> I'll try to give some additional details. But the specific features of the drivers I
> want to add are still under wraps, so I will have to be somewhat vague at times.
> If that means that a final decision can't be made until more details are forthcoming,
> that's fine. At least the discussion has begun now so people have some time
> to think about this well before I need to get code upstream. Or if the answer
> is "No. We will never create s/w layers in the resctrl code." Then I can go
> back to puzzling some other solutions.
> 
> Intel has always had some model specific "RDT" features that we have
> not attempted to push to upstream. Rationale is that architectural features
> have lasting value across CPU generations. Once the code is upstream it
> "just works" (TM) for all time. Cluttering up core code with features that are
> only applicable to one or two CPU generations seemed like a recipe for
> disaster from a long-term maintenance perspective.

Could you please elaborate how this seems like a "recipe for disaster"? I
can certainly see how removing a driver is easy when it is decided that
something is "end of life". I rarely see "end of life" in practice
though and viewing removal of obsolete code from a driver as a "disaster"
is not clear to me. Re-factoring code occurs frequently.

> But things are changing. Previously the end user industries that wanted
> the model specific features were content for out-of-tree patches for their
> specific systems. We now have some features that may be useful to a
> wider audience, ones that requires a solution integrated into upstream
> so that they don't take on technical debt to move the solution to new
> kernel versions.
> 
> I'm also guessing that with other architectures (AMD, ARM, RISC-V)
> all building on the resctrl foundation, some of them may also have some
> features that don't fit neatly into the core of resctrl.

They absolutely have features that don't fit neatly into the core of
resctrl. I am not able to tell whether this style of interface would
solve this.

The second motivation from your original email was that these new features
have "input parameters that do not fit neatly into the existing schemata
model". It is not obvious to me where you address that, but maybe it is
related to "Q6".

> My RFC patches were just to show that creating a s/w layer in resctrl
> is possible. If there is a better dividing line between core code and 
> architecture/model specific code I'm happy to discuss cleaner ways to
> draw the line. E.g. you make the point here and in one of your comments
> to the individual patches that making new resctrl resources may be a 
> cleaner solution. I didn't do it that way partly because the existing code
> has a static array of resources. But it might be relatively simple to transform
> that into a list to make dynamically adding new resources easier. But see
> Q6 below about tracking domains in a resource for other challenges.
> 
> Specific questions you raise:
> 
> Q1) Will there be a need for drivers to "call into" resctrl rather than rely
> on call backs? May make locking complex.
> 
> A1) So far I haven't found a case. But I only have three drivers (in addition
> to the example one) so it is possible that more complex things may be needed.
> I agree that this will raise many locking challenges. Exporting the resctrl
> mutex seems like a terrible idea.

I agree that we should not export the mutex. You may be interested in the work
that James is working on separating the locks. 
https://lore.kernel.org/lkml/20230320172620.18254-1-james.morse@arm.com/

It would be great if you could join these discussions to see if there are
some common requirements that can be solved together.

> Q2) What about exclusive groups?
> A2) I didn’t try to handle in this RFC. Additional bits will be needed.

It seems like every time a driver needs "additional bits" it would impact
all the other drivers.

> 
> Q3) How to make visible to the driver other resctrl assumptions (e.g. default
> group is CLOSID=0, RMID=0).

Actually I think resctrl assumptions should be _invisible_ to drivers.

> A3) I think this specific example is unlikely to ever change (it is somewhat tied
> to the power-on/reset state of the IA32_PQR_ASSOC register. But the general
> point is true that assumptions by drivers may create challenges to refactor core
> code in ways that break those assumptions.
> 
> Q4) Suppressing schemata resources from a driver surprised you.
> A4) This is, as you guessed, about conflicting resources. There are other ways it
> could be handled. E.g. use existing mount options to suppress the resource from
> the schemata. To be safe that might also need some way to fail to load of a driver
> that needs other access to a resource unless the correct mount options are in
> force.

From above it sounds like there may be scenarios where a driver layer would still
be accompanied by core changes (like mount options added to the core that will 
allow/deny certain drivers). If there was no driver layer it could just be handled
in a single spot.

The second part of my original question was "Where would it be decided whether
the overriding driver should be loaded and why can that logic not be in
enumeration within resctrl?" It is the user that needs to determine that there are
conflicting resources?

> Q5) Boundaries are not clear. Too much of resctrl internals made visible to drivers.
> A5) Can work on more abstract interfaces if we move forward with some sort of
> layered approach.
> 
> Q6) Domain awareness of drivers.
> A6) This is a challenge. Especially as the domain for a driver may not match up
> with any existing resource scope (e.g. driver may be socket scoped, which may
> not be the same as "L3 cache" scoped). After I posted this series I added
> an entry in the resource table with socket scope to handle this. Dynamically adding
> a new resource with a custom scope has challenges (because the domain lists
> attached to that resource are maintained by the resctrl cpu hot plug callbacks as
> CPUs come online and go offline.

My comment was not about a need to make drivers "domain aware". My assumption was that
drivers are not domain aware since I did not see any related information shared
with the drivers and since the drivers override the schemata entries I thus assumed
that the schemata entries use some driver specific scope. 
The challenge to add a resource with a custom scope seems like the biggest problem
raised thus far. Is this perhaps what started the venture down this driver interface?

Reinette


