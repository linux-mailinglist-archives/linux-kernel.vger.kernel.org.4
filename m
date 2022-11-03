Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B446177F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKCHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKCHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:49:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2095FC4;
        Thu,  3 Nov 2022 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667461754; x=1698997754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XNyu8SUbW6imROyiQZhH0fahyBFPs3SBoN8X/3JoDYA=;
  b=LdsM8FlRJqQBW3+24l8q6sQFo0CKRCLgY5MC9dmgI6//UA5I+vZWCclD
   QcGoGurkfstVWtfTks6k69qO4+dn6SFqLyQOxMS51p/mL0+djDrcPOh7t
   ZLHTLe4arI3aohUvsrtYfZlmQikHLziIdLXj9ZJkV4sxw/bObscJcdqFp
   /oMO1uYdEtQJnd7/YPwpv0qDZemX9IVxW+5n/CWRuZ/bR1I3vL+1EKtDJ
   oNd3+/GRIL+GzyoUotTDxBM+JFlpQZlEtkdBzj6ViB6hBv+tJRJ/GorRk
   GyxLEREmCAM0ethchgTY5cwikavoe5e1aM8JCL1w3OcMev8b95ntPqPYf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307228024"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307228024"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="667873902"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="667873902"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2022 00:49:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:49:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 00:49:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 00:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvLbHXfo1v9j91yNcF2uDYSqH96VZupJpJu+zIt8b1Zi5GXuCdSFS1O7Fx0y7uOgZnjZJ1H9FaNvAaXJLPIE32S9yP4gm2EbvP95F6EaZvlds+N+vTx7DLZIfYQjGd/G27vlCHl8cx0y7s6lbeBaPQjSH/xFGl4uBXJ0ekFIIENHCyvbsWvBLOosZ3nDh1VfihdaVj4fzowtGmWqlj1A+gtFD34S7ri5Gt3ok0BMB9KU/nsiO7ljfPJAY7e0j9UxUw9iJhTVnxMJQFDCADi+BaXauqcLvhiZ0+WoF889XNsBhq3CUcbVWVh66iHSmDnYL2LdTASkz+4iMXtGx0KdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRmIXa+QMjsKnbaOhVu0/Un0SkDqsMFfBiFJCAfvcC8=;
 b=bY043YDy1XFD6D94eB+SyJi5lf/YoVh1gS64eDAuCglPluGOdSxBgtShEvWJWgMjTAzh/9Zk/LIjB6M6GNL9f7q7hN9j4OFZbGOGrSsGscBQQnfjXalJ9m6m7BQjd/zOkJeNoh6jQianp4tHuSW1MLf4NW8vDGLq+5OgMdBb2B3IgMBIBJEVXYIAPFpk8HfmaDC4VPBu++Rbj4DX793JRKpR3vdLDw6njEA5MubuJEqKw143xKyn1819/bUQlrtKJ80nRNDbVtEiitB4q93C/CPMeQeGJ2u0yIhGRIDPOiisgXoaH92H3cr/Gwvq0EpLqEpqTIDaj2E63vL+EabsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 07:49:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 07:49:10 +0000
Message-ID: <397249ba-eefc-ff44-5391-90a81a42ce45@intel.com>
Date:   Thu, 3 Nov 2022 00:49:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-14-jithu.joseph@intel.com>
 <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
 <511d9020-04d2-0deb-5f92-a7b2d6b9830e@intel.com>
 <d8f3fda0-5c2d-f19c-23b7-7df6ac38ee41@intel.com>
 <e11f09fb-4037-1869-65f5-a83786f513e8@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e11f09fb-4037-1869-65f5-a83786f513e8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ee417b-36b7-4c19-ec6f-08dabd6fe456
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANadfEbi0dq8VGpBHQ4Z/aIG+bhhya7qlMZ2DoqIH/xl/wFdJUaTym1+aWXQ8LZE70Mi+MbaoXDlq+RORvxMJ+ovzOeTxQzUviTXrMP8jCPNxKUgnLfuoYsoz2FV1EfcAW95nQ9Cr4XZuq9iUc/K9yprbJwwZ9KkTc9aErxPyiWeY2QqSu5fQLv3uB/lUcS8HqcAZ8dDy+lAz541QvrmPJR9EVIdYJao1zLjLROZOJDOxKN4OIu6sxTaiEU5CCusIIyYaF6sQ2Itsx3qTo0gn93i3rEkllrwNk7TJceJrW8cWiT6O5WtO92xNJZI7GenvHbgECCUJcOXSNacNfK3lxSY66vyWM+pqvEPCosU+Dsd46fgfbwv/FpV2Tv169BVYWlr9sZdcB9RcQo/w3xp+utLNWpHmbMFmL3mYKXeh1SQCWInMQ3Py88EwFI9ceGLoTsHHjuvRpZwQNvCJeg626QMqxbA3xeeY3QiNP/UKsrxXgDL85ZVFEojCU0MYp9WQjrBg6cRCWcMOVgu6BVZ84Z5SwtIUPVocdBRMF2rwpoCiMrDjNeYTtEkaUbxO8cyjBhIpnpucdcjyWt9XHQjwwKNOT/aOo2kwJk09HfuPo8YRF0fryAzA+vejttvCMseOKi/Wkf6xfLXVgzZGZAPdFGYgGb4NEWQyBBfweTed0D1CVVV+ArZLzUqv+vSE/FvMo04+2a8c/HPdWcqnR916P11sZlLcUIJ0+fWkkKukh5n8mHQS0L9Bc2PGlxaRXp50u7+UyC25F1pbvJqeC8fJgu4MmTeJXr4JjvTnfWv/+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(186003)(6862004)(41300700001)(2906002)(4744005)(8936002)(44832011)(38100700002)(36756003)(2616005)(5660300002)(7416002)(6512007)(53546011)(6666004)(4326008)(26005)(6506007)(6486002)(316002)(66476007)(478600001)(37006003)(66556008)(66946007)(82960400001)(8676002)(86362001)(31686004)(6636002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UloyWkx3eHlDd2FwbitHamRPbWpSZnlXYTRrdEtJdHdXcVhaVlZYSXZaVkJq?=
 =?utf-8?B?OVRWdnBFZVI0dk5rY2xxS21Gb3loRnM5US9zTUdJR29ZMWYycm0vQ09uZm5Q?=
 =?utf-8?B?emQ3Y0J4UXdMM3hHS3ZTSFdsNmJQSXZFdEp0SmZTRzNCQURYSk9LQnJNYWJR?=
 =?utf-8?B?RkhpL2Y2bFd6MkFJc1BuSzM1ZStISGJCK2dCd3ZZTGpGV0NNWGl2U0tndXBi?=
 =?utf-8?B?Q1I2UTh6Y0JobXpMVE56ODJ3QStpeEZubEtjdTczaGtML3FnVEdnSG1PV3VX?=
 =?utf-8?B?bGZzUDU1M1pmZnJuZ090VDJ3KzJiNkFPeUtwZlpaZDI2bnB5c1YyVlN5a1Ns?=
 =?utf-8?B?RGlmNWZLaFJNTFpvdG82WGpQWlh0OXRlNXZ2SGRqUUNFaFlSVWJGR1ZMWGQz?=
 =?utf-8?B?QmtHbzFqdTJiRElrUHFrbVk0dHZKWG9WKzV3MFNZMG5Td05JNzJrcm5RdmRC?=
 =?utf-8?B?alA5ZldVVGl1cFRmdHpsbjdwM0ZEaDVYdGoxWW1ud0w0L1llTWFBMUt1ZDFT?=
 =?utf-8?B?bWVSd1FZcXdwQmdtMVZCczNuZjVxenBFUzNFMWo0c2dOS0o4bitVRHFsR3pt?=
 =?utf-8?B?U1BrK1VjWTl0Sk91N09UeGJnOXBRZ2Z0WHJLcmROSm5WZ3NEK1R6eThLUndV?=
 =?utf-8?B?azkrUmlTNHA0b2J0Q0xIaUVMTWdHMUswSVhKQy9EcDRyZlMwR21FdWtRSTRa?=
 =?utf-8?B?MVQyNElHd2doMlFUYXdIYWxUeU50emtlS0N6NGJNbWkySzdzOFBjTnlHTVNs?=
 =?utf-8?B?RHpuUTJXVy9aV1J5dzMvMGhSZVRFdmk2QjZyR2Z4QlhGaWt0VHVvUFVyRUtV?=
 =?utf-8?B?SmRTRFd5YU5wMzBaVFRvSG9QekIyWFdaSm1YTDE0QjdPOWF1YytrVlMxWnBM?=
 =?utf-8?B?c1BxR1dxdmNJZWh2Y1EyRVk1MHlQbVpKbFNrTTJIMHJ3TWYya3l2dXZxZWZs?=
 =?utf-8?B?eFZrZjA5U1lJbnRFaUxCV1BPMWNUNzNKMy9aZnZiU0h4d2NmanNQTVdIOVAw?=
 =?utf-8?B?NFlWTWdZSllqcnJ4R3FuZG8xb0oxZk5GWk9lNEtabjM3c25XRU1zRkhxMXBV?=
 =?utf-8?B?NXNDbzE2QXVkSW9jdHpVZ0ZtL0tHZ3VZZ2pBN1k3T2E1Wk1BL2FIRHduelBV?=
 =?utf-8?B?R21mUkZQTlIxR0FDdU5pblBPSFFkbUhMUExoUHZRUG9oSkdvcExiNG9jY1o4?=
 =?utf-8?B?ZWxBc1NjOEVnQXhjZ05UajNhZUhDdmdQUS9TTjM3YUxWaVFaS0xSZmViWGFN?=
 =?utf-8?B?bEJiYTlLcUphY0FlSFJpTzV2d3NTK2IyT3VNTk96bHFUUnlKMHo1Y2xSVTVS?=
 =?utf-8?B?cW1DS29iRXdKNllzS05KNXozRlNUa2hUQ0UwT3MvRjBGN1ZlcTJvMCtrTlpH?=
 =?utf-8?B?RElZM0VhRGpJVUc3R08rN3pkeEV5ZlBPb3owYWlBTWdLanc0VW43MEVqa3FI?=
 =?utf-8?B?T0p3WWtJTW1Id2cxbjFCSm1OOFJUUlRsei85dm43dnpsK3lPbHVrM08zUVNG?=
 =?utf-8?B?VFhXNFdobmtYdFBNODc4M1FZSE5mSmJGQ0MwTE9Sc0QzZTkyempyYk5vTmxz?=
 =?utf-8?B?dWtYTlNtY05DazlNY3RzakxPUG9TYURveWVlRFNTa2UvSldvZFdYMnhmQTVP?=
 =?utf-8?B?STkrb1k4U200SVpRamsvdGlJQXFkQW16Z2w0OWZoWFVUei9uS05Sb0FUQjcx?=
 =?utf-8?B?bFdPQmFEVzdSemQ0NW0vL29icWpQWCtNVlRJVjN3RDd2SFQ5VElyVWc2TE84?=
 =?utf-8?B?cllXNitBVHFJcHRQM2J3WHpXVmJsVzB0ZkxpREFXVTJuV3hGS0x4YlFRUGhh?=
 =?utf-8?B?c1NwSDFrRkEvcy9LUDRoRUVDVjJGaTBmMng3Y0pSTC9RSEtKV1dHT0wxa2JK?=
 =?utf-8?B?SjVRWXY5V2t1UVpPa1JFTmtqWXdRWTJQd3BuMUI1NUliVXJyYTN1aFlTYTVR?=
 =?utf-8?B?emExMHNEQlZNbjYvWlhkNnVYTGFDRjFLQlppYUdRVjdISzBlYVI4OXgrL0ZD?=
 =?utf-8?B?dXpXQS9EYi9OaERGMWFqUWJCN0ZYU3NMM2hBcXVlajVEOU5KY1ZBRDhhbWFI?=
 =?utf-8?B?dTVGWjRJbnJXRmNQeU4zWUtvWkdXWW94ay9WbUVVMEtGbTlhZng1ZG0wM0Rv?=
 =?utf-8?Q?5IeWkOj5NhU1MalEPu2qgnN62?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee417b-36b7-4c19-ec6f-08dabd6fe456
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 07:49:09.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbYT5H/JOaAeqNAgK246pBxs4VhQlewTJbZ+A4N4vaCrO18uOA21VS0rLLxXSnStfAjU0H15OWIBafQazXYHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/2022 3:10 PM, Joseph, Jithu wrote:
> 
> There is a mapping based on the device number, for e.g if the user tries to use the below sysfs file for loading
> /sys/devices/virtual/misc/intel_ifs_<N>/current_batch
> 
> The driver will look for the below test image for loading
> /lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.<test_type>
> 
> The number<N> is same in both the above path.

I guess that is OK. Adding the test name to the device path could 
potentially make the interface more restrictive.

Sohil
