Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5066E28A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjAQPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAQPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:43:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5A84345B;
        Tue, 17 Jan 2023 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673970026; x=1705506026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9OdaO2BV7a0z5YTjB2gNCLnB3exm8oFLRnULJp3H1Ts=;
  b=Blh04w0QNmesWaXh4xiI0PjPwEcpeQP2MT0gsUDY4WonPMlRT02qX2kh
   LWYZ5hvoxTD9S0R1Aqn1kvaFNivKatJPCdVsz7k5/mO/5WxAaSSSfXLP3
   SrIvTZxb6K42SfNtlLhXZxFXkUzhimXBLXX6gf9VJDSCJszKTPIvgAeo0
   5r/CZNNZnedOZwnzafyzzBGV5BAc7uzfjg64PJryLIgpxLgZ4pcED0ol9
   /mFy5ksskSm9m4RTHZM2ywA6CvXi42T6/r6ReK5u2qveaud1pNDC5b9rM
   1CrFnTCGG6rPFMRg6vgfB0pgFuTfEWOpatuRiV9oSPGUQ3c6QzQb1YR8K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322413250"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322413250"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659426750"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659426750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2023 07:40:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 07:40:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 07:40:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 07:40:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EddbBu9zbZP4keOFHd1SldriwAweawsfSfWCYMcEEx6ZLgywZg9EAe3tC2RYa9QI9MDev4tKspXfzbskoVYD+Js4k5gjzgZgBMz0LTn4gnSqBuUtY8T/AGLVjXl0ct4OZ2iQToBFf+j1MsVSayBY2eTvVyhgovS9On/VU4z/Ml5fKjdkYtzH7FrsvqmYR9VO+JjOoHAJ2AdW3dprcnB9q5bVQNYwCLp4wqG1NZZIy5FaJFT2prF1vJddoed9nLxpUA/IBbdbn/2DZmTKv3FPXCvozM2uunx4xduhkygBefkEH9MOrONtTHegXlCbkjtgpGSu0s1Iczfm6IiGYafwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+luNFWNn05Bju2TqrrOJ2dh6H4Q0jffTAXNi8gFeEI4=;
 b=oI6cMgzXwHBo7m6JXma4PhyiRbTlIlWck6rh5PTA47IhqaXSG/7+G54Gw8y2RgobfPSgSPb296IsNgSy118e5SCT2nIEVfVwZb8IIOZJwwDmM17giXnAqo3SEX3IWB+nWrbXAVMKl0wWuym+P9p+0Ss21YZQTzGsHSg8baV/CaftVUixI9brQqzRjeohpFlM8UI8oxq0a4fXtPQqlWIPw02NWDJLPPfxAPufOt9XbbjK7sBcKN3vc0mUns98T5chieGJPf8UX7eVde/aXAKl0i5sYyy0vxjPYJECPcSGz/JUYZWpd7UXbsaQFrU0unQTQkHUkQ+I+CtyOOrIgEATUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN9PR11MB5337.namprd11.prod.outlook.com (2603:10b6:408:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 15:40:24 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 15:40:23 +0000
Message-ID: <7964ec80-4d02-6c9c-ff9e-a6a8a0c427c3@intel.com>
Date:   Tue, 17 Jan 2023 16:40:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>, Doug Smythies <dsmythies@telus.net>
CC:     <linux-kernel@vger.kernel.org>, <sedat.dilek@gmail.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>, <linux-pm@vger.kernel.org>
References: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BN9PR11MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e4cd97-4dff-4fec-83a9-08daf8a125c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqNQcjvLbysXMytcyfvklFuxUS/Q9LJQiUIbiAohL8SkT+JE/nkx6zI2CaPHPrii7uTX9Hem/EcrIrFrTouGM+X6e4fuKDG1VmkWyFLFQ63YO2/gnpnyd+qHMQ+A5lvgzhOl1vibIpT9fBemS3mopmxIr/9c6wDgt34rIL15S+QIXj+innhvaEvXfe0Vaw2x+Vu47eJbrkPSFUP5+z1dVIN7mo/59NYIvYRfKSyvnqvDqFOibJMoGOhpMNgwzLLh5fc5dupmvaZAsIpUfK5NtGFmS0fxZGlQJVyiO4upmh7ju6/T8IabGOeVuf/Bxa/jiVatgA5r9lF8PJyRnLehg96w9Z7ZFLBYnyjJcIPvbMhUG+qh/1m2bDHE4aBPdieqCrqnFSZJBY4ae61C4+uIMvvMccV/KOhWBtA6WbVmJx5XqRZBt8+es8O0lo3WIdq9q1zMVqR6ZRV5T0w8cZ66HGQxhbAc/dVPodZED0rJvRC/brEzjyQwURe7wEZ5WL8I3c5WvjHUpizqECHHOFt1DJcFa2MXLLJb9MxiTBk1PDwCEw784DrXyiTCY/QsR4He+Ox5/4+WA1d90+HjlBL2g5w7WoWB0CYEHYwKxoxLbYqP5D79+GvGrxm8tBZsTFWRXOc6ox2KVWtV1v1+w0bGJbC7Wclesdjd+mk9mxoy7yOrZfn3+/m/KZ54O1qqMCgQ6rzibb9alnADRgA9qcUDFry2gJOgjemKOcdvzXUyTRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(2616005)(478600001)(6666004)(6506007)(26005)(186003)(53546011)(6486002)(6512007)(316002)(31686004)(66476007)(66946007)(66556008)(8676002)(4326008)(4744005)(110136005)(38100700002)(41300700001)(8936002)(5660300002)(31696002)(86362001)(82960400001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5ocHN3S2tSRjNBNzVOektETUVrUjlDb3k3QnB0RWxZMVNuM0VwSXlFNjE0?=
 =?utf-8?B?UkkwNDZTUldvWi9iNE5JT3BLbUxEdEFXNTc5QW5MMUFsTUV5amZJTTBwQWU2?=
 =?utf-8?B?Wm84Y0RQM09TMlNpWG5oM1FXekMyNHVCNXhpdjFZbklvaHRMVEw4bjVtOHU3?=
 =?utf-8?B?cGpmUW5MWVJwNlFCTEdUL3MrVXVwMW5mVjMzVGdZNTRQcnM2ZmN4dE95RDBa?=
 =?utf-8?B?VGxBbkozMDZnT25nN0kyeng5dGlZbUwrYXJsVVNNSS94TkxDZmNSWVlsRzBQ?=
 =?utf-8?B?ZXNjYVJhWjZYa0owSWpNRlJLZ2ROb1NRSHZNYXdHbFRoeTNEbUNZY1ZZamJ3?=
 =?utf-8?B?U3grOXRGd1cvRjQ1Y3FPY2tZMDc1eUVkMmhPY1hjQVYwQ091TEtYRy9kb0M5?=
 =?utf-8?B?dExrMW5xR3V3M1JOMFdBZHExK2dpYWlTWXlwZURieENHSlg3OG9tZUtnOEJK?=
 =?utf-8?B?eG9wSGdoY2N0RHJYUEFFc29lT2JSU0QrMExkb3Urc2phK1JTRnU4WldtTXhl?=
 =?utf-8?B?NzNILzNoYVY5YWpvcDk2VTFRZEFqSUM3TzJKcDRSQnM2UzJ0ckRuOElBOHI3?=
 =?utf-8?B?TVgxeTI3M1B5MFJneDhXS0t1M09qZnZxM0tlbTd0aC9VTHhQRVJaZFp3V3Mz?=
 =?utf-8?B?Y3dvTVZwTko0OG96Q1FRVUY2WXMrQytEcU96QW1UUXFyR0RTdE9zWDNKNWpw?=
 =?utf-8?B?c0lFSVlTeExnT1MxZEdKL3pySittRUYycERGd2VCbHZXTlhSeXc1RHJBeTIx?=
 =?utf-8?B?QVUzWmR2NDFiV3dOMGx1S3JNUU5HcmNJZ2VTcWxDaUVCZDY2VjduQ1NsMHNO?=
 =?utf-8?B?YmpyQTNrblpadmlEaFJtV0ZHNHZLVWtGcW51TW0xNDRxcFJCTlhIY1dHVnhS?=
 =?utf-8?B?REU3TkRPc3lXVndEVVRvWjB1cnUxRlV4M1AxZGVJK0VXbkJzSkswb3J2clQx?=
 =?utf-8?B?OUl2bmRsOTByalJXcUtjS0psblM0T0swdjFtZEpyQnFaV0tqVDVIMUFMYjlj?=
 =?utf-8?B?SFhhblJNdkFNeXV6VW1UY25ydy9ySjRVb3JKWndnVVhOR1l4WndKWDMvVFJt?=
 =?utf-8?B?Y2tMVlJnUzYwZlFYS2laa2lqTnROc2hkajNOcWpNckdjL1pFUEoybDNBM0wz?=
 =?utf-8?B?L3N2Rm9oT3JSY0prUzRnQVBVeElzWmZOdGxUY3Y3ZE9sd21jYWUyaFhyM0VB?=
 =?utf-8?B?bGZ6dTlVcFVwSmhsL0hRMnZYM3gwckQxSUMzdUI5NUUrcWlUemdiYzlhTnZP?=
 =?utf-8?B?NmI3c1IwMVBXbHI2RW95WTNyUjcwRFo3TDdndVc5ekQzaFZhbHJGVkhPYUY1?=
 =?utf-8?B?QWg2eW5sQUZsZFFVNndYWjR4QjdqMmZRR1VqN2hSeFBVeWtMMDRucTNtbTh0?=
 =?utf-8?B?bTByem5GVFlvZGJxSWhTTk9BVnRSWUJmVHQyUVN0b2dsclhLVm9sMlhFTnRa?=
 =?utf-8?B?L2xMMVVNdFpGZDh3VVNPZnJ1R25SMHlHemVZY2dvM3h1d2hWMzAvL3FVYUN1?=
 =?utf-8?B?bGRBWVMxTFBIaDB1TVRWMDZaMDVvMmNCS3M2UVJ5ZjNtY3htd3pIc1BhMlFN?=
 =?utf-8?B?c1pucm1UeThNMm1iK3k4eGtqTmJKbk8xNkszc3FGcTdaWmRERzl1TFNJa0hx?=
 =?utf-8?B?djRFTkx1c1pDZFJsVndVbFQ0SFVnSWFPSUdoU1M5eXpJY3YvRTY0L1dISTR5?=
 =?utf-8?B?Z3dxZnVIalZHSzJ1Y1hLMWMwblRXcU01ZmZVYVpURmVXU09wYUdRb3ovUG1u?=
 =?utf-8?B?SERlQjNSUHA1ak1YZXU4R3FwZWRJemxwQmZYTjREZUJOSmtLam4wSzl4WWhU?=
 =?utf-8?B?Y2RYU0IyK3F5eGVqNU1ZWXE3SzNxMXlsSjB4cXY5eFNYalVvSXFLeWhJUjIw?=
 =?utf-8?B?ekVNUjJMeUtWcXpaUWYvVU1FRzdBc0F1eE8rYjJRSVRRNVVaeTBtRGw2MnBF?=
 =?utf-8?B?ZmhFQ1hLZkFFQk42NHd5dkpMdGc4eEp4aVhkb0lnVkZzWXh2RDdXblZJVzE2?=
 =?utf-8?B?MElOckpBT1JidEs4RkZBQUl5dDAzaXkxY2FsME1pVkwzKy8xUjRqalpkOVF5?=
 =?utf-8?B?QXQ2eXB4UWw1dzZXY2gwai95VTNvUFRrSXBkNXh4ak9IYjRmaUFlL2tlQTRr?=
 =?utf-8?B?SXRmdWEzeS9XSXdPblZiYmN2bmcxQ3BtMm5Mc2lER2dTTkVGcFl5ekNTVzlH?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e4cd97-4dff-4fec-83a9-08daf8a125c2
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:40:23.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OTSQwYvSuZ4/qg3UwqLabCZUQ2yzz2G5VA9DkHtRoIYJsCvhWfzqP3oe6TnQujiLiI7xpChxG4l9KoQbPWuvbD/gZ7fRCDL9Qzuk9wSrpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/2023 3:03 PM, Sedat Dilek wrote:
> Hi,
>
> I regularly test:
>
> $ LANG=C LC_ALL=C make -C tools/ clean 2>&1 | tee ../make-log_tools-clean.txt
>
> This removes:
>
> $ git status -s
> D tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> D tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>
> Checking the log:
>
> $ grep pstate_tracer.py ../make-log_tools-clean.txt
> 89:rm -f -r   /home/dileks/src/linux/git/tools/testing/selftests/amd-pstate/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> /home/dileks/src/linux/git/tools/t
> esting/selftests/amd-pstate/../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>
> Is that intended or not?

I don't think so.

Doug?


