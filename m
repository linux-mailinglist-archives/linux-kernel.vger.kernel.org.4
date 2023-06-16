Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88AC733312
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjFPOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbjFPOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:05:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83ED30F4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686924305; x=1718460305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lYW+n1Q6gILOp9zQzbAIrkvBaYzj8YvCAVb5CNv4a/0=;
  b=PNmOncj0TCmjaNLlU+sBfXCovR5f14+mk5djyyG9OZOREnSjZp5aRL5N
   PwcSL8kjGERkjfJuq4l+zjftKoZXLF07eN8Zqjt/qfJ08gz8Q3b4jBQXv
   s7JOIVko7xUbd9P1WqLEU4fhP84aQRcgVlHwUqSxhUTu/14cc5NEdFq0I
   wKgk9NKHaRJZVhrm7xgCUwil4UEta/yYo2516mW5GXkZln4+BdHUoNxGt
   JqAB/GPISdwRzkrRTdvNjosy+LZZDiOJLzsk9IU/MsqPAZ0GwrWLdSXaD
   om0dxBp+l7GoBoONstfMmQW22NotI8zgMyTOLcYVNQsXWaTIUnoAu0oZ1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359229128"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="359229128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 07:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742685975"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="742685975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2023 07:04:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 07:03:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 07:03:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 07:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAF9PP4891AdR22mvLGHGaUTdCCbUOppbZu/KwkgwqRpe6dMWrcCdujpmcF37Bvjtmd8JYwYVU0SjcYhsiDO7ajtTjeBgbwRnYc79kLwvIrNLBgmOCnJWgJvqUYwdBbokdwtSO/6bKvj/BnQxocrt5eVyc2Ho7TfBpIMPq1luGBapJ4Lml7Aerb0Kj11U2dBRbLM8XgEQmaH4APc9OiBoLJGCSw6sjIJKwoXhKXpFQlP3ElIEBx2hp18CEthR1rARSzAZBQyr5Cow1To/1Udc2LRPKskdFtxDJTXiddlMgGZb0WwrPKGh0ptX0rmQPgTBAxqCdjQuemhjiRGrvj/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHzAnr3WIKHRIv/cJXJsXGonYuVSYfBuq1CuW3Wgpyg=;
 b=EWAAq2b8/E5c+oYPVoBC0jvTmmltT64KeDR0hEFFin0henVHMbQdkZTF8KzdlfjHpKaNjRZxYKXiLBdRJZe4S6L+XKnxoHcdKT2E6+jbH/0S/V53msFFHGL/AYmjOa1kfFPyYM0n/UNznEKtd8WtsTViSH8bJFShjoGsZuPa/ZRmaWQ5XJW6adZhewlN2NXpeb6H5FTh+TKSW6rDujRgBRCByCDt454zDDq1kYfotgNw4mxyx2XkSyuz6565XZzY9tEyCf7fFgAF/EOePMXejb6LF0EqOhfn2AryAYWbt+jEObiknLyhlMdSrffcyKqywBDRqwStwRyFr6QOg3LWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB5360.namprd11.prod.outlook.com (2603:10b6:5:397::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 14:03:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%6]) with mapi id 15.20.6455.030; Fri, 16 Jun 2023
 14:03:36 +0000
Message-ID: <67508559-0bcd-46ff-b040-59bcb41b0a9a@intel.com>
Date:   Fri, 16 Jun 2023 16:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: lib/test_bitmap.c:920:2: error: call to
 '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     kernel test robot <lkp@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>
References: <202306151433.QKcn7ZNn-lkp@intel.com>
 <ZIr0hZV/jcpZkRq2@smile.fi.intel.com>
 <CAKwvOd=Fj51=m0EZznjOmkqeZy_5uDZ_Gyf-Pv=yd2=53Gb6Sw@mail.gmail.com>
 <CAKwvOd=uqfnyw2u=Nhm+Q0uGORjW9GB+pso6tb_HKGSU0rhZBQ@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKwvOd=uqfnyw2u=Nhm+Q0uGORjW9GB+pso6tb_HKGSU0rhZBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a365682-4506-46f2-437b-08db6e727a2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4R84UYdKXiC/EIjtTiElaDepMBXVnKXgcx5My2z/bB0K61Xq5qD0oi232wZpd/R01kiyGUlcEdX1dwpvJWLl4Os+q6bIjnqXVj/N6Jx8MCtnzuUWAN6RwKSWgq6ehMto8fbT8IOJrfXT0wy1fEYv6+gMRLX7Ps74l1ILvgJR6/jEvCthPFBQpdZZnKA3E2mszpwsbfYsfzxcSBkuWG35Z3TLkyoElXcfvhGSlLJKTn3zAwov6kdxXDxqynlE7/wXfAkdwaVmwcO87GLHmK0Fht+LpZnLPtEKy88ROuBkHaiiNw09fJf6+YkcAZryMMRAek4uNfBIxrLxelY4JMH4b/DHDsVP1ye6PGBj6kgxy/B+pA5mnoJufBpJ5D4BtEwgJuoHJvCxXs8+fy2bJUc65GJskKouDhdQFzyKcy0COLUq2orRDzITvHMYxta6lhLtwqhKzIw5hmOAMUGX9hvOxqOF1SK3JnylUrFi320EF7C7xtg/YSy6vmIedXB0wAu3nupEBnYebp/9GhrTMwIg3mFm6k+5LowSJoMsHQUSeIv4NQs6vv5kGTEIp0OJXe5WVXC8tPlIGqpt2NEH9N/eMVCf4zPeMvklO64+BQZbZ4+RMbEhgMRcwgaE4Y3q4y3V3hy83a0dE7W3iAKmeoSOKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(478600001)(110136005)(54906003)(966005)(6666004)(6486002)(5660300002)(8936002)(8676002)(82960400001)(41300700001)(2906002)(36756003)(31696002)(86362001)(38100700002)(66476007)(66556008)(316002)(66946007)(4326008)(26005)(53546011)(6512007)(6506007)(186003)(31686004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRrdXpSdHlpbFp6NEI0YkU3QWROUE9RSnRwQnNXa2J5UkJkSi9OTlRxTHZm?=
 =?utf-8?B?bUl1ZWQ3bHQ4emV5dUFUM2ZYcHkxam1wcEtSVkxWc25velQ1YW9wU1lJTlBK?=
 =?utf-8?B?U2RLOXpyeGNKaXpUOTNsTlVub0RiL1FmMnNmelNIZjF0b2hib25iVXdrQTRQ?=
 =?utf-8?B?bnVFaDg5OEo2dUV0eVZCZmNhU2htQXA5K2QyQWw2d3hobjZROGtmUVRwUVVX?=
 =?utf-8?B?Rmw0d09MZnFqemxsdjVrQWVrSThwK2tES1NITExzVjdhNDMrSmgxWjAxTm03?=
 =?utf-8?B?MGNMeHNydTFPYzRCZW8rbDN3eDI3TzlmcnZSVTNsdGZDSGJ2VEhqNXR0SUFP?=
 =?utf-8?B?L21qUGsweEhUcXRxSVRmTU9RUFV6YTRKQ1hFL1c1R2FPSm00Z0VvR2lHcEp5?=
 =?utf-8?B?dWExdnNVSnlKZXJzbkVublRWNGdYTUI4RFduUU56U1ZoWTlSMy82NW10UVB5?=
 =?utf-8?B?Y1llNUdTbGFtZ050WWtCVEpRL3RmZHF4YXBZVVRTL3V6RDFDdHBUU3Y2WGh0?=
 =?utf-8?B?aHVPL2IxWktxOXA1aEFFQkpmRE9SMm1UZTdXcDdzcXdsanlKeVpGaDVqb01Z?=
 =?utf-8?B?akpKcC9MS0xrQ0dhYWpPWnp4MDdOcW5PRDg3UzJ0aDhJMnBNYnZGb0plZTh0?=
 =?utf-8?B?SFl2QVlheXpSQlYycVdUT0tJZjNvWlFydVlUQTFxaWk0MG8vd0w1VmNVZXhL?=
 =?utf-8?B?RE41UUJFTGV0T0tJeEgrWmJRMkNXci9CU1QxZTRjSmZYT05ESi93M3Q2Vzdh?=
 =?utf-8?B?Sm9wbHBGa2FpdzQ0UmdOMzZ6ZFVMYk1qY3luYWROczVjMkc3bSsxeldYaXIr?=
 =?utf-8?B?NHMrOVRwQ1pUV1ZZWm1SNTl2SmhMVHROTkQwM3VkY1NlcXVoUUpDaG12dXVW?=
 =?utf-8?B?bFVFVVdnaVlhK0tiSXJFOXFpUGIrU2FKRDc0bEFOcWYvRjdBSUFGOVhYL1JY?=
 =?utf-8?B?cWVGcW9MTGxIVFlRbzgrTnJ5V0h6dmMreHBYQllPdGNhaUF3MTgyNi9KL3VF?=
 =?utf-8?B?RDBBWnp0amZGSUtFN1RmZ0lYTm5VRDFSN3Y4akpyTDFsdEtJR0JCUDFaTGxz?=
 =?utf-8?B?K0V0bHJKa0JSSGdwQUlDT0taSEtndUJ3ZDBzaTlxL3dEQnJrZjRXS25pbFpJ?=
 =?utf-8?B?aTVBWDFTT0swK3QxejcyMExCQVRrODhNalVRdzJrQzB1TGdKWk1kTTMvK0ZL?=
 =?utf-8?B?V3N6OXVneHRudmZJTkRVUmxyTEVmV2RFczBZNnVlcksvR2lLNnJncXZoZG1s?=
 =?utf-8?B?WmVYekxHQzdGU2pVUm80ZXVpYWM0b3JaaEp2ODBnOUlNNzgrT1RGL3lqenBU?=
 =?utf-8?B?Zm15blhaSWlvVFlUWDdVcHppcEZyUkVFUDlXSE1hNlhMVjBpVUVRdnlqY1Y3?=
 =?utf-8?B?dWVBNnRPSTBUdi90ekFPWDFjc1U1Y2h4SzhWNUIrSG83L3lRaGtoM1QwdXZB?=
 =?utf-8?B?VHJkZzV6NHB1VDhvekZZZGcyd0tNRHBTSEd5RG5oV0ZRUEg0WHBWUU1pblBz?=
 =?utf-8?B?Zy93WTZoOEdkVjF5cjRrcVZCc1RGYlhNVkFXbk9xKzlkeWlQRkdyMlhnazRM?=
 =?utf-8?B?Q2R0THFacVpQT01YWW1zYk9HYVEydlpkekNZRVZwRHBZNDVkaGtqRHJXaXRV?=
 =?utf-8?B?UzFRTkRIM01mS3p5a21CSUxyOGMxdHdMWFlSenJQTnplZHR6eWtxSVVKTUhG?=
 =?utf-8?B?cGVpMWtxUjUxUTQ3ZC9FbGd0M3RVL2pmSVdBVWJpeklQTUVmRjUxYmx5VEVt?=
 =?utf-8?B?aFJ2OUI1SWcvNVZUMGZQeUpGQ0YxZDhES3UzM0RYR0tTOEk0LzRhLy9DNVpx?=
 =?utf-8?B?NHZ2dkd0NUpZZE44cDFmcGpwRFdLRFpER1E2ZGd2V2xUOWF5R1BmTWl4YmxV?=
 =?utf-8?B?SHg0YjFqZHdQanJ6OEVrclpGYUlWZFRXZE5teElmVVFmcEI2SG9iZHU3aE56?=
 =?utf-8?B?UnlLcmdQak82NTVQQXFWVk1lYXJSbmtIQmNRZDB6OGZFWEVUQm1STW5YVmds?=
 =?utf-8?B?SW1LTzBWRG52UWZ0USs2bG11bThvWG85S0dyVGowbTB3MXNvWGROWkFnYnBI?=
 =?utf-8?B?T2txeEFRK3F3SHBkbXZCZGpINUFuYWVNWXlDb1h3L2VpbkpGUnN3Y0tNU2pD?=
 =?utf-8?B?a1o3dU1rMnZ6OEYvRlR4UzhUREl0d2ZKMTM2UmlPNkJqK0ZKQ3p1WGhQV3B2?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a365682-4506-46f2-437b-08db6e727a2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:03:36.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4lDwNfJyU1JEADrFv/Uwtjr+Ub1Xs2zF16crp2JhcTY4a1bqkCkW0VAYE4keycU0lZCvsL+C0m5B5jr73sedN5JWReQGW+/1Qsi1jq+pcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5360
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 15 Jun 2023 16:48:22 -0400

> On Thu, Jun 15, 2023 at 3:52 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Thu, Jun 15, 2023 at 7:22 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:

[...]

>>>>    896                bitmap_clear(bitmap, 0, BITS_PER_LONG);
>>>>    897        #if defined(__s390__) && defined(__clang__)
>>>>    898                if (!const_test_bit(7, bitmap))
>>>>    899        #else
>>>>    900                if (!test_bit(7, bitmap))
>>>>    901        #endif
>>>
>>> Hmm... Reveals the bug in clang/arm64?
>>
>> Seems related to the config.  ARCH=arm64 defconfig +
>> CONFIG_TEST_BITMAP=y doesn't trigger this for me, but the randconfig
>> does.  We'll bisect the config, and update the thread tracking this:
>> https://github.com/ClangBuiltLinux/linux/issues/1874
> 
> KASAN and GCOV together seem to be tickling this.

Thanks for root-causing this!
Should I prepare a patch which would work around KASAN + GCOV here or
you're digging the Clang sources for potential issues?

> 
>>
>>>
>>>>    919                res = !test_bit(18, &bitopvar);
>>>>  > 920                BUILD_BUG_ON(!__builtin_constant_p(res));
>>>>    921                BUILD_BUG_ON(!res);
>>>
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>>
>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers
> 
> 
> 

Thanks,
Olek
