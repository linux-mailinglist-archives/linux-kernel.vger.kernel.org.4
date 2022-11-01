Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161161556D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKAXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKAW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:59:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6B65F6;
        Tue,  1 Nov 2022 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667343599; x=1698879599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yKzsG+R389SztQ5HE6qKMoo6xt3Pn30EIq6NJqhbJOI=;
  b=m/9Ol/dKOhDBXSggbzIHei5t9/xKp/FP7IM0ZnLpgwhu37iLqd7ty1zH
   2N23p9bxWAKXRp7eYAB86eHg6sCFTqgBAgfb6hFx8SUKMZOJNWwfzQuou
   xmCmUeWQzWROkQBanf7W+RBEG2pff4HChjRW2cw7+qUNl+ark7gyKK/Lu
   TvCs4No+C3uyxzJUMVlHgvTVxeAhRPCaSmW3M7gyaTLfPUu1geIx88z5y
   oHZbfpOmf/y3B/ntUiIOKI/Ve9uB6dhWr/fQ42cecieOs0P+gA5A9KBKE
   y0bV7XAO7X9GWjpJGpN/gWXq7/CS9BbDv/loQwDNqI0O1nTS8RWaMPLtT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="307983200"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="307983200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585173095"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="585173095"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2022 15:59:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:59:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 15:59:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 15:59:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZCQmlIrScM5grVFCBPDa484DYeYJLiILQDHgZnWqFG3lBqx2jHzN4Fj+EysxJIyf+bR7Ut3dBD7ZvCag0sOI2vSGFfbTfvLepK5Iuz1CqmG9SnOKT2yrZnXoINtj+kh0QLBUtyxahEKa2LC2cCd9AiI9tokkgBivPKWGxB2DYt78Vg0e3J8FuJycC0BgYSsH4/fAn+9GBvycnLXhLoNRdT1+ccImvsxlCTtIzs+3pG7lWYv0OLfF1geQ1ODFJQ/Vt5U2/7qiJg/cZwrX5ZGUv83j/tvGqpSUBvy78DmODnoX+pssshl6tdEEyVb4Yv4mM9Ono1NeJUVQu6dOxT7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXTSVjyXPRkGxUkK2gp45fwsC8+qFKvDLAL/LD74EXI=;
 b=DshLHmp0pXOeb9cNklksRPxnk86OKVA4lim5qICWpAgyhOEvOFHbkufG+yLKx5mamv01BjDjDabenGqQnywWlqUjFJkQ1V6MkHhIxLgiyiGXRFUtEwLk/THoalc3DHwMslB/tpbWgOnPKW9QKpsE2DoQgKKNAHwMPl35Iu7IIPAGzRVeEXWRclAgiEVN1evpcNuvOUlb5RoRs70Cvb/qCE61nYau4S5r5z38LGjegDtfB+SOxVvCKk6yGYFq/eOxhxrp9X++30jobsXTK9GTMBik8PM1BdKdtiPZDHQS8qatU6sQMt4EDWr+0cTYrdfgmwLU7SE4W4tzQ9OSDBEVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Tue, 1 Nov 2022 22:59:52 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:59:52 +0000
Message-ID: <d8f3fda0-5c2d-f19c-23b7-7df6ac38ee41@intel.com>
Date:   Tue, 1 Nov 2022 15:59:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-14-jithu.joseph@intel.com>
 <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
 <511d9020-04d2-0deb-5f92-a7b2d6b9830e@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <511d9020-04d2-0deb-5f92-a7b2d6b9830e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: f7de9a1b-6cc8-4ac9-f7d1-08dabc5cc8fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBg3zlL9DWGFx35LUn1NkWiXczDUalfv0m/PCvbs5+VRYZkEag0DwMyDN2oqBsEvWRpTbqwhROspsmTgXF88kFBWaZxBzEDR35WA5T+9287PrOFkLbvtkhqQaQgJa4G04JoM+D2EUUEuJdWya0BJULZ6zkcFofOulybvqwdPCWOcLa9w8ofH8FvfSDWEOzq2KsZyoRLX5dYJ4qPergy4Df96yyba6ytYGZ6qGpEmIv9HENI4EGheLwsSRuk1nTUm+3I6q4U1AMejuGsj23+v1RoVrDcHfWKap9P+RlBIX/+jPVQ9YyPffEzPyS54ejXMgStglf7cxYNo4uy9ITUSWS71rbL7Sd/rwVRrxW1u7cl35EqDrviLT/4oilNhorj0fQIOs0lgtTSaty+u/MGHM9sOwCpf+1/mTDD/d57DtOZNeqsy8/VNPPU+9NL5SEBu+0XNr3xh7O+60w9BC4g4q4lb5gW1o41au09Yn48nRQn2Y8fk5vy+rRh8s8gof23s8UzGCWtQFEz3ZkTNbfXGgCsdjI2KUzOfA4i8UCdAMP7036K1I6dWv8S50VCT7pExoFo0SYVmTRHjADCripbZTb/hqOPt2M2Xk7kTpDR7CtUlt218CG2h++eSKQ77wuNWjxfniYTa71A2s8WwPYlV5f4cuAfoBDoEyFIsWZyzsGXWGpCE2avXdld+DI8Ch/sZDuHT5bSB7l+G/Yp69uN+Xf359iM7sKVRE+l5zIb1ruz9Tzuz/Afoj4ylLNPQqSf+/wOzi+rAAxB9YWv4X1XB3YnLA5FvwsZEJvKG36247s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(31686004)(2906002)(86362001)(36756003)(41300700001)(66556008)(66946007)(66476007)(6512007)(8676002)(26005)(316002)(82960400001)(31696002)(38100700002)(7416002)(5660300002)(8936002)(44832011)(2616005)(4326008)(4744005)(186003)(478600001)(53546011)(6666004)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzR2NGpoWDloN0p5QnI1Z2FjdWcyeW94emllbGRTaVJhZWkrTng0MkVQRDI0?=
 =?utf-8?B?cTN4LytycFR2R3h4WXZZcDF1UzMxeE9YTE5lblpLVDRKUjh4QVhSTk1QWS9D?=
 =?utf-8?B?cFo4b05HMnpBZHJPQ1dudEIzK2ZMdHdLZTdxZnlWY3E0VTJ0ODh0Z3lza25y?=
 =?utf-8?B?L0VEUkQ5dE5qOXZCWXdGMDlObzFBQkExNUNrNTVId1llMnppMUkzTmNQcWtK?=
 =?utf-8?B?ZkxCSGxNWUc2YUVpQ3dLbllYMTU0bVhDeWRjd0xoc01WbjkxSzB2clV3MXE1?=
 =?utf-8?B?UjA4TDNrYThSSmxPRWwrYXpIb1pCWi8yZVBaL2VIUldnakc3eE1vMG9rZzVD?=
 =?utf-8?B?MkNrYW1hVUxZM2hVRkU5eE4wY09rNThmUFh5NVlhT0wrUGQwSDNzUjdNdVc4?=
 =?utf-8?B?aFByeHZpMUZ0cU1rZnV2RTVwcGhMeWhHenF2bDYxUXk5OS8vOWhJSkdYd21O?=
 =?utf-8?B?aVo4QmhRbmt5ODJmaGJPWHJVb2w4RFdGTlUrRURQZ29QT3A3K1JURHA3dS9L?=
 =?utf-8?B?UHNxMndEU21OVTNBUWVRTmRnbXc5V0t6K21WMTlGWmJGME1QWTJmK1d2WEcx?=
 =?utf-8?B?SnNuYk13MXNGYVZmdUpTbUxYMDlpRHF4dm81WHoyTmFyMDBNeUJhbjRjYUd3?=
 =?utf-8?B?Yzd3eGMvSENGV20wcWowdzcrN0YwcWhyOEx1V3RRRXcvZEw5WExDOGpoVWw3?=
 =?utf-8?B?WEZSTWIrcktuVGRhR1dCUEx1MjZ1ZXY4UkRuV1lXeFF5NHNpdU5SR3QvekRN?=
 =?utf-8?B?TDRUM09vZlZUaXQ0VmlOSGFGUUh5MGVkQUI5ME9KUGZ4VTFpaC9DM09VS2My?=
 =?utf-8?B?Uk43a3JOeU1kcEVpelJDK2NVYTlPbkU5MTdueE9HdVQ5R3dYZTJJd2M0OFE4?=
 =?utf-8?B?VDNJTFNiMkJKNklVa2RqNkZaVWVNR3hxTFFOeEd5SjhrVUFTZWJ5NURNWmEy?=
 =?utf-8?B?MndoUXg0alR0RlNiTHZ0enhnMzNaR2dZMGFGNkI4eDg4bkZrWnVBNnNLaU1l?=
 =?utf-8?B?MXZkbHN2NWZGa2VlZW5GclBzTzJoT3hzZWFlK3NkVmdDVFhjQlk2dkwzeFkx?=
 =?utf-8?B?aWtzaFNvblIxc2pmSUFYYnhBVzJlNC9TQVRPYm51U0VGSzBSa3hPT1NncFBR?=
 =?utf-8?B?eHdBbENLSzNDV3EwTjFvdFV0b1l2RDVLekVPY2xiTVNsUFFpSldleTlaWkJW?=
 =?utf-8?B?djZ0NkYxbms2ejJidVRlQVhZQWlSK2UvL2JYd1NsVWtYQ0VhaWNlb0pKeHFy?=
 =?utf-8?B?V3dPczR0NWFyS0JMSzJCa2pWQWlBWlozMENETWNkbHlMeUh1bkRuaEJ5UlBX?=
 =?utf-8?B?dXJ4S1pNREZET0ErYmEwVThCQ1E1WFNsamlGOVpldHlMTXBITnNaSjBFcXp6?=
 =?utf-8?B?aEgrZkNVajhNNEV0dUtsam03Tk5CSHhPYVl6YVlLalVEekZMSjA4bHhmV3hC?=
 =?utf-8?B?QWhRZlhOZlpadWV6YjdpL3V3K09IclRKa2NFdzRsZzJuUGt3WW9hQkMwQTV3?=
 =?utf-8?B?azFvMWE3dHF4VDFuYm1iOWRJc052bmVaYmlaUmJTY2kyYnhmWllpUGF5UXpj?=
 =?utf-8?B?Y1dqSEFtQklZRyt0dzZRNEVlWDVxdlFmSldURzR3Z3lMWXVnVTl0ZlRXWHVQ?=
 =?utf-8?B?K3JFTVoyWklHalJxMHFkMWF2MFdFd2hxNTZlakRnb2NJZXlGSGhheThHQWNi?=
 =?utf-8?B?eEZGdFhKWFptaU9SNy9nUEtwbDl4TUxRV1lpU1dGc0Z1cHhIelJ0V21lTXRh?=
 =?utf-8?B?bG1DREJiZmJFS3p5OWR1VUtaS3QwemJ6SHhOUlJtc21JM3ZvbzZsM1FWcktJ?=
 =?utf-8?B?Wi8rMTMyanYyZTdnb1pJZkxSQ1pKaGNPNHYwQ1loNmRId2sxMFVjMXZBK3Q3?=
 =?utf-8?B?cHZQOE15RVlkK1JKRHhHVmNZNDVoSytTU2k2TG9oV3I3aFczQjBSRklpajVX?=
 =?utf-8?B?YUlCRHo0eDZnakRzNExxV3NDaUFCV1AwbTZ1QUcvRlIwaTVvRmFDbTI3Zldn?=
 =?utf-8?B?dWtMUzZRY25pbXN4R3JGRlJmcW5KMFRJWm5HaGU1UktxKzNsT3NpbGp1VlJM?=
 =?utf-8?B?ODFkVDVYUGxEQk1sSHo3dHNLc3JaeTJrOEJXQzl0VTNZUHpISmpyTGZLeDFv?=
 =?utf-8?B?N3gyWFV0czJnN3NsNGZXOTNiL0h4d1UydFlHZGNTcUJnWkpod2oreHRBRDUy?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7de9a1b-6cc8-4ac9-f7d1-08dabc5cc8fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:59:52.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R87lzOEyHaQzibGsIZnF6Egi3V1ANxjt2xSIICgPxverjaGTsG5+RcliGooajTrwUrPuz+XXcx+o8wZmS74AaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2022 3:48 PM, Joseph, Jithu wrote:
> The testname would be inferred based the sysfs file context (the<N> in /sys/devices/virtual/misc/intel_ifs_<N>/current_batch) from which the operation is triggered.
> 
> Meaning if the user writes to /sys/devices/virtual/misc/intel_ifs_0/current_batch it would look for ff-mm-ss.scan and if they write to
> /sys/devices/virtual/misc/intel_ifs_2/current_batch  it would look for ff-mm-ss.<test_type_2>
> 

So intel_ifs_<N> corresponds to <test_type> i.e. intel_ifs_0 maps to .scan

Is the N to test_type mapping visible to the user somewhere? If not, how 
would the user infer that?

Would it be useful to name the misc device as intel_ifs_<test_type>?


