Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC7652B80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiLUCes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUCep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:34:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B61FCD4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671590082; x=1703126082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+awKvTRVyvYqYD7AHyPm2mQT/h8wyTrfPBm+uK0leJU=;
  b=TRztUPIXIJlxkh4tnQNfiwDLtiXw8o6muIWMua6F5/UtYgS8SrwnX5l7
   vNh5RvOn9PLbZRy2IwCF+SUUPqGvRSK/aAKmICKdkfrDFwqWPuzjN33b8
   GnEcf5kUBdrmFF88AKy14UmUhF/j0ZXAQH/nQzWncyhLq/RFUy9XLECN2
   zkG55DrhsN3yuMrAdMdo1Vztx91k5dNzLiSwne5/xwBoLP2/umw51wipV
   urxAgLyP0p1NmI5rICkzpZUX6jpMtaUZ1DV+bDw/plbmgFptSp1JyPCr7
   YeF+3hTNcwssTMOx8Be+k2pQ/6fsAvpDKHHnMhDf0Eysg9L2xpuooK5Xf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299443234"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="299443234"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 18:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="740003777"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="740003777"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2022 18:34:41 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 18:34:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 18:34:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 18:34:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAy6ZoTRmBPHzWDBn8/lz0nuaNUNNxrqtJWYWwKR0HEBfL8QpWj4VnE0HOvUMij6R51t454sOXfb4Y3Sxpw87DmREMQZ9OfHwma3Rksc5M9IUkejo5lIh1IB3JOjzWnswoMmfQyqqZWlOsNG4bMI5Bdp2j1Psa3rgfOeci8AWVhIJIrpjVQLCU504/ARj5lcYHtAve/PAekv8rjMn0tsvF+0/CqF7Y6ZIuA/Cu5yEaGXApJA69Qr6TM43AjHr2pC7FkfxQMvdH5KoMNuYPXIS9QRCQAJlNJLG5CzAtHABKwnrOxuCDtX7dO7KRUxi+RmBjRZlnra5uP48iK1ge2/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFfRQfr1mBYBF/cZ3WDVMB9UG+jnvGD0ZKksjUn8REE=;
 b=H8NFAl+KuMw7lqfzcdnNLFqCj/Ls3cs5lXmB0zaxYwVoRcrrL+bqJvpGn5+5FSg8Tc7jbkcFmC2wciY5N+0xR2iOsDJ/fQnqoA9os9OOWuH47PUtlSJOrVK4ua9E1PIj3/4+qGQng2ddEHHuUARjoLa9VVTu4BQZQuVlXREVdjbZ4FINeHaH1xxpaOqKJlvTodOWU/4GUQuVqhubeFqCmnoRcGAF1Gp9zfMF44Q2AWZ6zpwa6CUQdOC2a8cx3CZqknAlghialRiLi0XY7VnJwN5+WZuvGgg4Un2U9w4Nk9IBCMoawiMSvcG24jWVUB9+jZV/0Lldx8gP4g1dq9NqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Wed, 21 Dec 2022 02:34:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 02:34:36 +0000
Message-ID: <c5fce325-3f91-7f68-5d21-6804297de722@intel.com>
Date:   Wed, 21 Dec 2022 10:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        kernel test robot <yujie.liu@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <202212151657.5d11a672-yujie.liu@intel.com>
 <CAHbLzkpVr62M4dWCb9J+eMErDvxx0hiTF6DD6bp2qEivzZYXCg@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHbLzkpVr62M4dWCb9J+eMErDvxx0hiTF6DD6bp2qEivzZYXCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9f8291-7342-4754-94d9-08dae2fbe6ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GEMEtOHhza4cJFkin+/11MlX5HooqIv0bUXgKtFO4y1vPBwfBIxY/yjNrgWpVEYzn04fsJ/6In+cwYEZsB6JT4DopfVekAnDI3uEu+RDz2nMRzWhhaqZMbvQMbAOBuK0nKDAUuFSylFCQC/5tCu93oS076ttgi3Mkxi17ObXq7GnQHM0kf5tJlDxVmsjJuX3MIJwULW/ehc96gQCFGB9WW0WsdBsMZoZfPTlv1RVtSiCo2Jgdk2r4uhx4AjAEpnIVaAgtsKZTpUUs0KlA0uhVopPNCpow2fln5o9JBI46ap8BAy6HPT6Tt+SjVwUxTvEZiRQ+sx5p4QRlh+Ug5HQ8IFW83ntCgXy7j3wl+Y3COstzMjo15OjWsxjxeqgH2Dx+85393TQNKZrAh0odxfm06LHpX1CPIfbaDPAFJWtnTa/EA0HXxmSUWSHM2XgCCdI/EUu2aN9gakJfjgIuud8r1EPqO6Pza6x/IGVzqmeUDnc76klHACUjG4EH44ACzFBjP6jvQ2MW62DffGxrruIPQ8mmrnXIYlqz7lafd/rD8C951tmMakl+MEXM8nnzri4gN842WDOw2jSct4wOipeO7CydiSg7luuF08micn9JnGkRfBn4GE/4iYAcwQAPaEav96obI0TPLppBrTC5yKPzvIPfezvoZKP11j0+xuKMVpNFbXufkN7b6KBTBm678Au+KGB1GLsktKLFFCtxF6Jmt2BK27r6rOUfVvByYyDa1G7CI1J+qcYIOf9cwg3LLVaQHg3kRuKvw45tcU3W30nE4Q/gW0b7KbrhSGkMEkE5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(6666004)(31696002)(31686004)(26005)(186003)(53546011)(6506007)(966005)(6486002)(82960400001)(38100700002)(6512007)(478600001)(110136005)(41300700001)(54906003)(30864003)(4326008)(6636002)(316002)(19627235002)(2906002)(66476007)(8676002)(2616005)(66556008)(66946007)(8936002)(7416002)(36756003)(86362001)(83380400001)(5660300002)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxudkdZWnU2eFdWWTNJWHpTbFU4UkxxNC9ldlhQdDBXQW9jeG5pbzllSk5n?=
 =?utf-8?B?Mkl4ekpyK1hJaWh0SjUyODh1MTRDQzBpTXgzUVJWM1B1V0NrSjJiMklLc0N4?=
 =?utf-8?B?YkJOZzlORVIxZDhZODUzWVFtYWp1WUlUTVhOYzhsbjI0ZTdEdzRJNTVHRGEy?=
 =?utf-8?B?dUJIOHA2bjdZaDUwaURGNVZSTk1DVW9SWHZ0YUZDNUxDTGxzVnN0UUI1UFd2?=
 =?utf-8?B?a2s4NWUrM09lMnVDY2h4eFBtYTFHZkJKaXk1TExkbnorblpuZ2xmS0tyRG1r?=
 =?utf-8?B?OGZNSlYxUEFTM01iQTgxS3NydTVaN2JrcVovcWdrQWt6K2FWUTdWR3MyNldL?=
 =?utf-8?B?T09oNVZ4d2RlM0s5Ulo3c1pwUy9Ld1FpTkJ2Q0srajhWN2QzUVl6eTBiZHBU?=
 =?utf-8?B?UTcvcEF0bXp2VmpqUzJMRy9KcWtmRnFhSmw2cjkwT3FqT3hSZlVYdDAzdi81?=
 =?utf-8?B?THhkN2hrYXRKRFdpYXFYUFk4OHNudE9CR21PWUQrY0RWRlFGakQ1YnRteUl0?=
 =?utf-8?B?YzJWVWt1S3g5NnlkY3NSR0FLSCtRRnh2R0RUVmZWQnAxelRxeTNYVytHWGRt?=
 =?utf-8?B?WTNrSnJIaDUyem1uSSsvSWtTcWcvRjBWQ21SOWhsblBSMHgwcEFvMDNDcUp0?=
 =?utf-8?B?dm9TRFVIN1J5Z2hSNmJId2tOK3hUbktiVFdRdzNKM3RMZ2EzUWNieFVHUmNj?=
 =?utf-8?B?ZkI4RHBIeTVMclhqd1BmZ0NITTRnSkhoSmxiZUdLdjRieklJTHJNTFFTeFNh?=
 =?utf-8?B?U1NRWlpqTlIvQzF2Uk5ySjM3cWVrYWZYYVU1SEFCT2JHZll0NDRMQi9xT1RW?=
 =?utf-8?B?MllmZndLSllOT01IOXg4cjhHQTR1bTExVHhOdmlNMmRCTHcxMDdKN0xGcXBM?=
 =?utf-8?B?TzRQZFJXM0JuY3F1UVU2OC9ZOUdYNXErSW5LZUxtd0xqcEhrTXJjR2FaWks2?=
 =?utf-8?B?UStxQUVRTHpvMEc1RkduYXp1RUQydlBSd2lVclcwemlQUFBhYWphQkYwL2FW?=
 =?utf-8?B?Yll2QkdVblI0SGRSbjhNUy9Kc3JzaERTZ3hPRDIzVjNGTnlvQzBReEZyZWxs?=
 =?utf-8?B?UnNBYk40dzBGa1poWmo2a2JMUmV0NHN3K2xOQ1hZTk56YVJPS0JmalNoTnFh?=
 =?utf-8?B?L0ZzSWxDWnVSNmpqUmQ3SmEyTXhMVUVoaGhzWHNrcG9GUUx2cmJFQkhCRVBD?=
 =?utf-8?B?S3VpR3JWNWZFcUN2dlpHTms3UTNDQm14bDF6RFdpSFlVZ2E4bVdYVDVlYVNF?=
 =?utf-8?B?Vk1OZ0tKMW1DbXFIdnVmZjhxTWVsQjFCK3ZQUXg5YWtaejgxeCs0WWdJaldE?=
 =?utf-8?B?QmIwcURScmlJaUVOSzNwbStRR0wyWG84WkhFTHlOZ2IxK0krUTljRW5uZ2Vp?=
 =?utf-8?B?M3lTR29yK0gxT0grY3EzeUFMSENxWUVkczh1V2FSYUxHVjA1ZnlaamNoNWZn?=
 =?utf-8?B?enZ2NFU5emZsWitVU1d3eWRjOURVSmdyRUNWVHM5dHBJT3EyYkJjNDl5N05j?=
 =?utf-8?B?MUhEWm1ERTQ5NzByQjQ5Um04dVZOVW1JczJsbStUY2FjYmpiZXZ4VkQ4UVh2?=
 =?utf-8?B?clAvKzdwNHQxV05PWXp2SDdiZWRFWDQ2ZFNCNmtSZld5WGlxaXJ2S1plaG5B?=
 =?utf-8?B?L2F5L0x6a1RoUUNCa3JoRVlLaURiSlhnTm9GOFNMMzhPT0FwU0sydGpPT2l6?=
 =?utf-8?B?ek1NSXVWZTYxM3J0dXhoeTBPOHk4UVZtZEdlT2NGOEdWaUdoNEpzVFI4bXNa?=
 =?utf-8?B?RGx5SUpWWVdRVHdzaFRHbjdSZWlDNUMxb3V5RVkySWlrRlFQZ2pDbW03TUY1?=
 =?utf-8?B?NjVnOHZVZWc3RjUvcGhUdmlJYkdMMmswZzF6Y1NIL3B6Y0x1TGRQZFpjMW9i?=
 =?utf-8?B?Q3I2OGRHSExWZktBVUlKYTIza29CVnR3ek1YblhlbjhadVlWQTRkSHhEak1O?=
 =?utf-8?B?MTFaYlNycFZ2cDdyMzFpeTNwOEdyVno5NHlxZFNjVS82MW9HY0dmTktrcWg4?=
 =?utf-8?B?WFZjM2dOV2wyRG5iZFhETWtOSFppb0dkU3Vwa1Uyc2k4cVJERjBEMHNBak5n?=
 =?utf-8?B?Z3loRmNJK2pQeVkyRzhtbS84SmVJRjNLaEswcEF4L2g2eFVYQ2g2dy9lRXhP?=
 =?utf-8?Q?O/etaDbdQ9VOEdTwFd/zlIn55?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9f8291-7342-4754-94d9-08dae2fbe6ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 02:34:36.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNknDQ+gUI42zs63iiwaJKYMYBFZTCOoP54eFgkJEi+Nw2w6kxuxy3ynkFtrseXniHFjxeC1JaNajAcO+DNVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2022 2:04 AM, Yang Shi wrote:
> On Mon, Dec 19, 2022 at 3:30 AM kernel test robot <yujie.liu@intel.com> wrote:
>>
>> Greetings,
>>
>> Please note that we reported a regression in will-it-scale malloc1
>> benchmark on below commit
>>   f35b5d7d676e ("mm: align larger anonymous mappings on THP boundaries")
>> at
>>   https://lore.kernel.org/all/202210181535.7144dd15-yujie.liu@intel.com/
>> and Nathan reported a kbuild slowdown under clang toolchain at
>>   https://lore.kernel.org/all/Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X/
>> That commit was finally reverted.
>>
>> When we tested the revert commit, the score in malloc1 benchmark
>> recovered, but we observed another regression in mmap1 benchmark.
>>
>> "Yin, Fengwei" helped to check and got below clues:
>>
>> 1. The regression is related with the VMA merge with prev/next
>>    VMA when doing mmap.
>>
>> 2. Before the patch reverted, almost all the VMA for 128M mapping
>>    can't be merged with prev/next VMA. So always create new VMA.
>>    With the patch reverted, most VMA for 128 mapping can be merged.
>>
>>    It looks like VMA merging introduce more latency comparing to
>>    creating new VMA.
>>
>> 3. If force to create new VMA with patch reverted, the result of
>>    mmap1_thread is restored.
>>
>> 4. The thp_get_unmapped_area() adds a padding to request mapping
>>    length. The padding is 2M in general. I believe this padding
>>    break VMA merging behavior.
>>
>> 5. No idea about why the difference of the two path (VMA merging
>>    vs New VMA) is not shown in perf data
> 
> IIRC thp_get_unmapped_area() has been behaving like that for years.
> The other change between the problematic commit and the revert commit,
> which might have an impact to VMA merging, is maple tree. Did you try to
> bisect further?
> 
> BTW, is this similar to
> https://lore.kernel.org/linux-mm/20221219180857.u6opzhqqbbfxdj3h@revolver/T/#t
> ?
Let me explain more to clear possible confusion here:

There are two regressions found by running will-it-scale:mmap1 test:
[1] This report. 21% regresion
[2] https://lore.kernel.org/linux-mm/20221219180857.u6opzhqqbbfxdj3h@revolver/T/#
    40% regression
So totally, we found about 60% regression for mmap1 test.

In this report, there is no the other change between the problematic commit and
the revert commit. And we saw 21% regression with commit 0ba09b1733 comparing to
its parent commit 23393c6461.

IIUC, the regression is not related with thp_get_unmapped_area() itself. But
different path taken w/o thp_get_unmapped_area(). With thp_get_unmapped_area(),
the "cannot_expand" path is taken almost. Without it, the "vma_expand" path is
taken more for mmap1 testing. These two path have different latency and
thp_get_unmapped_area() makes the difference visible in mmap1 test. Thanks.


Regards
Yin, Fengwei

> 
>>
>> Please check below report for details.
>>
>>
>> FYI, we noticed a -21.1% regression of will-it-scale.per_thread_ops due to commit:
>>
>> commit: 0ba09b1733878afe838fe35c310715fda3d46428 ("Revert "mm: align larger anonymous mappings on THP boundaries"")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: will-it-scale
>> on test machine: 104 threads 2 sockets (Skylake) with 192G memory
>> with following parameters:
>>
>>         nr_task: 50%
>>         mode: thread
>>         test: mmap1
>>         cpufreq_governor: performance
>>
>> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>> test-url: https://github.com/antonblanchard/will-it-scale
>>
>> In addition to that, the commit also has significant impact on the following tests:
>>
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops 1943.6% improvement                               |
>> | test machine     | 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory     |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | mode=process                                                                                   |
>> |                  | nr_task=50%                                                                                    |
>> |                  | test=malloc1                                                                                   |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | unixbench: unixbench.score 2.6% improvement                                                    |
>> | test machine     | 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory      |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | nr_task=30%                                                                                    |
>> |                  | runtime=300s                                                                                   |
>> |                  | test=shell8                                                                                    |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | phoronix-test-suite: phoronix-test-suite.build-eigen.0.seconds 9.1% regression                 |
>> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory  |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | test=build-eigen-1.1.0                                                                         |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2882.9% improvement                               |
>> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | mode=process                                                                                   |
>> |                  | nr_task=100%                                                                                   |
>> |                  | test=malloc1                                                                                   |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops 12.7% improvement                                 |
>> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | mode=process                                                                                   |
>> |                  | nr_task=50%                                                                                    |
>> |                  | test=mmap1                                                                                     |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | stress-ng: stress-ng.pthread.ops_per_sec 600.6% improvement                                    |
>> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
>> | test parameters  | class=scheduler                                                                                |
>> |                  | cpufreq_governor=performance                                                                   |
>> |                  | nr_threads=100%                                                                                |
>> |                  | sc_pid_max=4194304                                                                             |
>> |                  | test=pthread                                                                                   |
>> |                  | testtime=60s                                                                                   |
>> +------------------+------------------------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_process_ops 601.0% improvement                                |
>> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                               |
>> | test parameters  | cpufreq_governor=performance                                                                   |
>> |                  | mode=process                                                                                   |
>> |                  | nr_task=50%                                                                                    |
>> |                  | test=malloc1                                                                                   |
>> +------------------+------------------------------------------------------------------------------------------------+
>>
>>
>> Details are as below:
>>
>> =========================================================================================
>> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>>   gcc-11/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/mmap1/will-it-scale
>>
>> commit:
>>   23393c6461 ("char: tpm: Protect tpm_pm_suspend with locks")
>>   0ba09b1733 ("Revert "mm: align larger anonymous mappings on THP boundaries"")
>>
>> 23393c6461422df5 0ba09b1733878afe838fe35c310
>> ---------------- ---------------------------
>>          %stddev     %change         %stddev
>>              \          |                \
>>     140227           -21.1%     110582 ą  3%  will-it-scale.52.threads
>>      49.74            +0.1%      49.78        will-it-scale.52.threads_idle
>>       2696           -21.1%       2126 ą  3%  will-it-scale.per_thread_ops
>>     301.30            -0.0%     301.26        will-it-scale.time.elapsed_time
>>     301.30            -0.0%     301.26        will-it-scale.time.elapsed_time.max
>>       3.67 ą 71%     -22.7%       2.83 ą 47%  will-it-scale.time.involuntary_context_switches
>>       0.67 ą165%     -75.0%       0.17 ą223%  will-it-scale.time.major_page_faults
>>       9772            -0.7%       9702        will-it-scale.time.maximum_resident_set_size
>>       7274            -0.3%       7254        will-it-scale.time.minor_page_faults
>>       4096            +0.0%       4096        will-it-scale.time.page_size
>>       0.04 ą 16%      -4.0%       0.04        will-it-scale.time.system_time
>>       0.06 ą 24%     -11.8%       0.05 ą 16%  will-it-scale.time.user_time
>>     102.83            +1.9%     104.83 ą  2%  will-it-scale.time.voluntary_context_switches
>>     140227           -21.1%     110582 ą  3%  will-it-scale.workload
>>  1.582e+10            +0.1%  1.584e+10        cpuidle..time
>>   33034032            -0.0%   33021393        cpuidle..usage
>>      10.00            +0.0%      10.00        dmesg.bootstage:last
>>     172.34            +0.1%     172.58        dmesg.timestamp:last
>>      10.00            +0.0%      10.00        kmsg.bootstage:last
>>     172.34            +0.1%     172.58        kmsg.timestamp:last
>>     362.22            +0.0%     362.25        uptime.boot
>>      21363            +0.1%      21389        uptime.idle
>>      55.94            +0.2%      56.06        boot-time.boot
>>      38.10            +0.2%      38.19        boot-time.dhcp
>>       5283            +0.2%       5295        boot-time.idle
>>       1.11            -0.1%       1.11        boot-time.smp_boot
>>      50.14            +0.0       50.16        mpstat.cpu.all.idle%
>>       0.03 ą223%      -0.0        0.00 ą223%  mpstat.cpu.all.iowait%
>>       1.02            +0.0        1.03        mpstat.cpu.all.irq%
>>       0.03 ą  4%      -0.0        0.02        mpstat.cpu.all.soft%
>>      48.59            +0.0       48.61        mpstat.cpu.all.sys%
>>       0.20 ą  2%      -0.0        0.17 ą  4%  mpstat.cpu.all.usr%
>>       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
>>     328352 ą 15%      -7.2%     304842 ą 20%  numa-numastat.node0.local_node
>>     374230 ą  6%      -4.2%     358578 ą  7%  numa-numastat.node0.numa_hit
>>      45881 ą 75%     +17.1%      53735 ą 69%  numa-numastat.node0.other_node
>>       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
>>     381812 ą 13%      +5.9%     404461 ą 14%  numa-numastat.node1.local_node
>>     430007 ą  5%      +3.4%     444810 ą  5%  numa-numastat.node1.numa_hit
>>      48195 ą 71%     -16.3%      40348 ą 92%  numa-numastat.node1.other_node
>>     301.30            -0.0%     301.26        time.elapsed_time
>>     301.30            -0.0%     301.26        time.elapsed_time.max
>>       3.67 ą 71%     -22.7%       2.83 ą 47%  time.involuntary_context_switches
>>       0.67 ą165%     -75.0%       0.17 ą223%  time.major_page_faults
>>       9772            -0.7%       9702        time.maximum_resident_set_size
>>       7274            -0.3%       7254        time.minor_page_faults
>>       4096            +0.0%       4096        time.page_size
>>       0.04 ą 16%      -4.0%       0.04        time.system_time
>>       0.06 ą 24%     -11.8%       0.05 ą 16%  time.user_time
>>     102.83            +1.9%     104.83 ą  2%  time.voluntary_context_switches
>>      50.00            +0.0%      50.00        vmstat.cpu.id
>>      49.00            +0.0%      49.00        vmstat.cpu.sy
>>       0.00          -100.0%       0.00        vmstat.cpu.us
>>       0.00          -100.0%       0.00        vmstat.cpu.wa
>>      12.50 ą100%     -66.7%       4.17 ą223%  vmstat.io.bi
>>       3.33 ą141%     -55.0%       1.50 ą223%  vmstat.io.bo
>>       6.00 ą 47%     -16.7%       5.00 ą 44%  vmstat.memory.buff
>>    4150651            -0.1%    4148516        vmstat.memory.cache
>>  1.912e+08            +0.1%  1.913e+08        vmstat.memory.free
>>       0.00          -100.0%       0.00        vmstat.procs.b
>>      50.50            -0.3%      50.33        vmstat.procs.r
>>       8274 ą  2%      +1.2%       8371 ą  4%  vmstat.system.cs
>>     211078            -0.1%     210826        vmstat.system.in
>>       1399            +0.0%       1399        turbostat.Avg_MHz
>>      50.12            +0.0       50.13        turbostat.Busy%
>>       2799            -0.0%       2798        turbostat.Bzy_MHz
>>     208677 ą 13%   +1112.3%    2529776 ą194%  turbostat.C1
>>       0.03 ą 89%      +0.3        0.36 ą203%  turbostat.C1%
>>   27078371 ą 15%     -22.0%   21125809 ą 51%  turbostat.C1E
>>      37.41 ą 33%      -9.4       28.04 ą 62%  turbostat.C1E%
>>    5088326 ą 84%     +63.1%    8298766 ą 77%  turbostat.C6
>>      12.59 ą 99%      +9.1       21.69 ą 78%  turbostat.C6%
>>      49.79            -0.1%      49.75        turbostat.CPU%c1
>>       0.08 ą 71%     +37.3%       0.12 ą 78%  turbostat.CPU%c6
>>      43.67            -0.4%      43.50        turbostat.CoreTmp
>>       0.03            +0.0%       0.03        turbostat.IPC
>>   64483530            -0.2%   64338768        turbostat.IRQ
>>     647657 ą  2%     +63.2%    1057048 ą 98%  turbostat.POLL
>>       0.01            +0.0        0.05 ą178%  turbostat.POLL%
>>       0.01 ą223%    +200.0%       0.04 ą147%  turbostat.Pkg%pc2
>>       0.01 ą223%    +140.0%       0.02 ą165%  turbostat.Pkg%pc6
>>      44.17            +0.4%      44.33        turbostat.PkgTmp
>>     284.98            +0.1%     285.28        turbostat.PkgWatt
>>      26.78            +0.4%      26.89        turbostat.RAMWatt
>>       2095            +0.0%       2095        turbostat.TSC_MHz
>>      49585 ą  7%      +1.1%      50139 ą  7%  meminfo.Active
>>      49182 ą  7%      +1.4%      49889 ą  7%  meminfo.Active(anon)
>>     402.33 ą 99%     -37.9%     250.00 ą123%  meminfo.Active(file)
>>     290429           -33.7%     192619        meminfo.AnonHugePages
>>     419654           -25.9%     311054        meminfo.AnonPages
>>       6.00 ą 47%     -16.7%       5.00 ą 44%  meminfo.Buffers
>>    4026046            -0.1%    4023990        meminfo.Cached
>>   98360160            +0.0%   98360160        meminfo.CommitLimit
>>    4319751            +0.4%    4337801        meminfo.Committed_AS
>>  1.877e+08            -0.1%  1.875e+08        meminfo.DirectMap1G
>>   14383445 ą 12%      +0.7%   14491306 ą  4%  meminfo.DirectMap2M
>>    1042426 ą  9%      +6.4%    1109328 ą  7%  meminfo.DirectMap4k
>>       4.00 ą141%     -50.0%       2.00 ą223%  meminfo.Dirty
>>       2048            +0.0%       2048        meminfo.Hugepagesize
>>     434675           -26.3%     320518        meminfo.Inactive
>>     431330           -26.0%     319346        meminfo.Inactive(anon)
>>       3344 ą 95%     -65.0%       1171 ą186%  meminfo.Inactive(file)
>>     124528            -0.1%     124460        meminfo.KReclaimable
>>      18433            +0.7%      18559        meminfo.KernelStack
>>      40185 ą  2%      -0.9%      39837        meminfo.Mapped
>>  1.903e+08            +0.1%  1.904e+08        meminfo.MemAvailable
>>  1.912e+08            +0.1%  1.913e+08        meminfo.MemFree
>>  1.967e+08            +0.0%  1.967e+08        meminfo.MemTotal
>>    5569412            -1.8%    5466754        meminfo.Memused
>>       4763            -5.7%       4489        meminfo.PageTables
>>      51956            +0.0%      51956        meminfo.Percpu
>>     124528            -0.1%     124460        meminfo.SReclaimable
>>     197128            +0.1%     197293        meminfo.SUnreclaim
>>      57535 ą  7%      +0.8%      57986 ą  6%  meminfo.Shmem
>>     321657            +0.0%     321754        meminfo.Slab
>>    3964769            -0.0%    3964586        meminfo.Unevictable
>>  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
>>     280612            +0.1%     280841        meminfo.VmallocUsed
>>    6194619            -2.0%    6071944        meminfo.max_used_kB
>>       2626 ą 28%      -7.7%       2423 ą 11%  numa-meminfo.node0.Active
>>       2361 ą 20%      -5.3%       2236 ą 10%  numa-meminfo.node0.Active(anon)
>>     264.67 ą117%     -29.5%     186.67 ą152%  numa-meminfo.node0.Active(file)
>>     135041 ą 20%     -22.4%     104774 ą 42%  numa-meminfo.node0.AnonHugePages
>>     197759 ą 18%     -20.4%     157470 ą 35%  numa-meminfo.node0.AnonPages
>>     235746 ą 19%     -11.8%     207988 ą 29%  numa-meminfo.node0.AnonPages.max
>>       2.00 ą223%      +0.0%       2.00 ą223%  numa-meminfo.node0.Dirty
>>    1386137 ą123%     +89.5%    2626100 ą 67%  numa-meminfo.node0.FilePages
>>     202317 ą 19%     -21.0%     159846 ą 36%  numa-meminfo.node0.Inactive
>>     200223 ą 19%     -20.7%     158765 ą 35%  numa-meminfo.node0.Inactive(anon)
>>       2093 ą129%     -48.4%       1080 ą200%  numa-meminfo.node0.Inactive(file)
>>      46369 ą 57%     +43.5%      66525 ą 41%  numa-meminfo.node0.KReclaimable
>>       9395 ą  4%      +4.6%       9822 ą  5%  numa-meminfo.node0.KernelStack
>>      14343 ą101%     +65.1%      23681 ą 58%  numa-meminfo.node0.Mapped
>>   95532160            -1.3%   94306066        numa-meminfo.node0.MemFree
>>   97681544            +0.0%   97681544        numa-meminfo.node0.MemTotal
>>    2149382 ą 82%     +57.0%    3375476 ą 53%  numa-meminfo.node0.MemUsed
>>       2356 ą 21%      -9.9%       2122 ą  9%  numa-meminfo.node0.PageTables
>>      46369 ą 57%     +43.5%      66525 ą 41%  numa-meminfo.node0.SReclaimable
>>     109141 ą  6%      +1.5%     110817 ą  7%  numa-meminfo.node0.SUnreclaim
>>       4514 ą 34%     -22.4%       3505 ą 30%  numa-meminfo.node0.Shmem
>>     155511 ą 18%     +14.0%     177344 ą 14%  numa-meminfo.node0.Slab
>>    1379264 ą124%     +90.1%    2621327 ą 67%  numa-meminfo.node0.Unevictable
>>      46974 ą  8%      +1.5%      47665 ą  7%  numa-meminfo.node1.Active
>>      46837 ą  8%      +1.6%      47601 ą  7%  numa-meminfo.node1.Active(anon)
>>     137.33 ą219%     -54.0%      63.17 ą 85%  numa-meminfo.node1.Active(file)
>>     155559 ą 18%     -43.5%      87865 ą 52%  numa-meminfo.node1.AnonHugePages
>>     222077 ą 16%     -30.8%     153725 ą 36%  numa-meminfo.node1.AnonPages
>>     304080 ą 17%     -27.5%     220544 ą 28%  numa-meminfo.node1.AnonPages.max
>>       2.00 ą223%    -100.0%       0.00        numa-meminfo.node1.Dirty
>>    2639873 ą 65%     -47.0%    1397913 ą126%  numa-meminfo.node1.FilePages
>>     232481 ą 17%     -30.8%     160887 ą 34%  numa-meminfo.node1.Inactive
>>     231228 ą 16%     -30.5%     160796 ą 34%  numa-meminfo.node1.Inactive(anon)
>>       1252 ą213%     -92.8%      90.33 ą 96%  numa-meminfo.node1.Inactive(file)
>>      78155 ą 34%     -25.9%      57927 ą 47%  numa-meminfo.node1.KReclaimable
>>       9041 ą  4%      -3.3%       8740 ą  5%  numa-meminfo.node1.KernelStack
>>      25795 ą 55%     -37.5%      16118 ą 85%  numa-meminfo.node1.Mapped
>>   95619356            +1.4%   96947357        numa-meminfo.node1.MemFree
>>   99038776            +0.0%   99038776        numa-meminfo.node1.MemTotal
>>    3419418 ą 52%     -38.8%    2091417 ą 85%  numa-meminfo.node1.MemUsed
>>       2405 ą 21%      -1.5%       2369 ą  7%  numa-meminfo.node1.PageTables
>>      78155 ą 34%     -25.9%      57927 ą 47%  numa-meminfo.node1.SReclaimable
>>      87984 ą  7%      -1.7%      86475 ą  9%  numa-meminfo.node1.SUnreclaim
>>      52978 ą  9%      +2.9%      54500 ą  8%  numa-meminfo.node1.Shmem
>>     166140 ą 16%     -13.1%     144403 ą 17%  numa-meminfo.node1.Slab
>>    2585504 ą 66%     -48.0%    1343258 ą131%  numa-meminfo.node1.Unevictable
>>     486.17 ą  9%      +6.8%     519.17 ą  7%  proc-vmstat.direct_map_level2_splits
>>       8.00 ą 22%      +2.1%       8.17 ą  8%  proc-vmstat.direct_map_level3_splits
>>      12303 ą  7%      +1.3%      12461 ą  7%  proc-vmstat.nr_active_anon
>>     100.50 ą 99%     -37.8%      62.50 ą123%  proc-vmstat.nr_active_file
>>     104906           -25.9%      77785        proc-vmstat.nr_anon_pages
>>     141.00           -33.6%      93.67        proc-vmstat.nr_anon_transparent_hugepages
>>     264.00 ą141%     -54.3%     120.67 ą223%  proc-vmstat.nr_dirtied
>>       1.00 ą141%     -50.0%       0.50 ą223%  proc-vmstat.nr_dirty
>>    4750146            +0.1%    4752612        proc-vmstat.nr_dirty_background_threshold
>>    9511907            +0.1%    9516846        proc-vmstat.nr_dirty_threshold
>>    1006517            -0.1%    1005995        proc-vmstat.nr_file_pages
>>   47787985            +0.1%   47813269        proc-vmstat.nr_free_pages
>>     107821           -25.9%      79869        proc-vmstat.nr_inactive_anon
>>     836.17 ą 95%     -65.1%     292.17 ą186%  proc-vmstat.nr_inactive_file
>>      18434            +0.7%      18563        proc-vmstat.nr_kernel_stack
>>      10033 ą  2%      -1.1%       9924        proc-vmstat.nr_mapped
>>       1190            -5.7%       1122        proc-vmstat.nr_page_table_pages
>>      14387 ą  7%      +0.7%      14493 ą  6%  proc-vmstat.nr_shmem
>>      31131            -0.1%      31114        proc-vmstat.nr_slab_reclaimable
>>      49281            +0.1%      49323        proc-vmstat.nr_slab_unreclaimable
>>     991192            -0.0%     991146        proc-vmstat.nr_unevictable
>>     264.00 ą141%     -54.3%     120.67 ą223%  proc-vmstat.nr_written
>>      12303 ą  7%      +1.3%      12461 ą  7%  proc-vmstat.nr_zone_active_anon
>>     100.50 ą 99%     -37.8%      62.50 ą123%  proc-vmstat.nr_zone_active_file
>>     107821           -25.9%      79869        proc-vmstat.nr_zone_inactive_anon
>>     836.17 ą 95%     -65.1%     292.17 ą186%  proc-vmstat.nr_zone_inactive_file
>>     991192            -0.0%     991146        proc-vmstat.nr_zone_unevictable
>>       1.00 ą141%     -50.0%       0.50 ą223%  proc-vmstat.nr_zone_write_pending
>>      17990 ą 21%     -17.6%      14820 ą 46%  proc-vmstat.numa_hint_faults
>>       7847 ą 37%     -41.5%       4588 ą 26%  proc-vmstat.numa_hint_faults_local
>>     806662            +0.3%     809070        proc-vmstat.numa_hit
>>     488.50 ą 13%     -73.4%     130.17 ą 22%  proc-vmstat.numa_huge_pte_updates
>>       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
>>     712588            -0.2%     711419        proc-vmstat.numa_local
>>      94077            +0.0%      94084        proc-vmstat.numa_other
>>      18894 ą 67%      -3.1%      18303 ą 41%  proc-vmstat.numa_pages_migrated
>>     337482 ą 10%     -59.0%     138314 ą 10%  proc-vmstat.numa_pte_updates
>>      61815            -1.6%      60823        proc-vmstat.pgactivate
>>       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
>>     933601            -3.8%     898485        proc-vmstat.pgalloc_normal
>>     899579            -0.5%     895253        proc-vmstat.pgfault
>>     896972            -3.9%     861819        proc-vmstat.pgfree
>>      18894 ą 67%      -3.1%      18303 ą 41%  proc-vmstat.pgmigrate_success
>>       3845 ą100%     -66.8%       1277 ą223%  proc-vmstat.pgpgin
>>       1064 ą141%     -54.3%     486.67 ą223%  proc-vmstat.pgpgout
>>      40396            -0.6%      40172        proc-vmstat.pgreuse
>>     105.50            -9.2%      95.83 ą  5%  proc-vmstat.thp_collapse_alloc
>>      57.00           -87.4%       7.17 ą  5%  proc-vmstat.thp_deferred_split_page
>>      74.83           -72.4%      20.67 ą  4%  proc-vmstat.thp_fault_alloc
>>      19.50 ą105%     -15.4%      16.50 ą 71%  proc-vmstat.thp_migration_success
>>      57.00           -87.4%       7.17 ą  5%  proc-vmstat.thp_split_pmd
>>       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
>>      17.00            +0.0%      17.00        proc-vmstat.unevictable_pgs_culled
>>     589.83 ą 21%      -5.2%     559.00 ą 10%  numa-vmstat.node0.nr_active_anon
>>      66.00 ą117%     -29.3%      46.67 ą152%  numa-vmstat.node0.nr_active_file
>>      49406 ą 18%     -20.3%      39355 ą 35%  numa-vmstat.node0.nr_anon_pages
>>      65.17 ą 21%     -22.0%      50.83 ą 42%  numa-vmstat.node0.nr_anon_transparent_hugepages
>>     132.00 ą223%      -8.6%     120.67 ą223%  numa-vmstat.node0.nr_dirtied
>>       0.50 ą223%      +0.0%       0.50 ą223%  numa-vmstat.node0.nr_dirty
>>     346534 ą123%     +89.5%     656525 ą 67%  numa-vmstat.node0.nr_file_pages
>>   23883055            -1.3%   23576561        numa-vmstat.node0.nr_free_pages
>>      50051 ą 19%     -20.7%      39679 ą 35%  numa-vmstat.node0.nr_inactive_anon
>>     522.67 ą129%     -48.4%     269.67 ą200%  numa-vmstat.node0.nr_inactive_file
>>       0.00          -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
>>       9392 ą  4%      +4.6%       9823 ą  5%  numa-vmstat.node0.nr_kernel_stack
>>       3594 ą101%     +64.8%       5922 ą 58%  numa-vmstat.node0.nr_mapped
>>     587.83 ą 21%      -9.8%     530.00 ą  9%  numa-vmstat.node0.nr_page_table_pages
>>       1129 ą 34%     -22.4%     876.67 ą 30%  numa-vmstat.node0.nr_shmem
>>      11591 ą 57%     +43.5%      16631 ą 41%  numa-vmstat.node0.nr_slab_reclaimable
>>      27285 ą  6%      +1.5%      27704 ą  7%  numa-vmstat.node0.nr_slab_unreclaimable
>>     344815 ą124%     +90.1%     655331 ą 67%  numa-vmstat.node0.nr_unevictable
>>     132.00 ą223%      -8.6%     120.67 ą223%  numa-vmstat.node0.nr_written
>>     589.83 ą 21%      -5.2%     559.00 ą 10%  numa-vmstat.node0.nr_zone_active_anon
>>      66.00 ą117%     -29.3%      46.67 ą152%  numa-vmstat.node0.nr_zone_active_file
>>      50051 ą 19%     -20.7%      39679 ą 35%  numa-vmstat.node0.nr_zone_inactive_anon
>>     522.67 ą129%     -48.4%     269.67 ą200%  numa-vmstat.node0.nr_zone_inactive_file
>>     344815 ą124%     +90.1%     655331 ą 67%  numa-vmstat.node0.nr_zone_unevictable
>>       0.50 ą223%      +0.0%       0.50 ą223%  numa-vmstat.node0.nr_zone_write_pending
>>     374134 ą  6%      -4.1%     358690 ą  7%  numa-vmstat.node0.numa_hit
>>       0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
>>     328256 ą 15%      -7.1%     304955 ą 20%  numa-vmstat.node0.numa_local
>>      45881 ą 75%     +17.1%      53735 ą 69%  numa-vmstat.node0.numa_other
>>      11706 ą  8%      +1.7%      11901 ą  7%  numa-vmstat.node1.nr_active_anon
>>      34.17 ą219%     -54.1%      15.67 ą 84%  numa-vmstat.node1.nr_active_file
>>      55500 ą 16%     -30.8%      38424 ą 36%  numa-vmstat.node1.nr_anon_pages
>>      75.50 ą 18%     -43.7%      42.50 ą 53%  numa-vmstat.node1.nr_anon_transparent_hugepages
>>     132.00 ą223%    -100.0%       0.00        numa-vmstat.node1.nr_dirtied
>>       0.50 ą223%    -100.0%       0.00        numa-vmstat.node1.nr_dirty
>>     659985 ą 65%     -47.0%     349484 ą126%  numa-vmstat.node1.nr_file_pages
>>   23904828            +1.4%   24236871        numa-vmstat.node1.nr_free_pages
>>      57826 ą 16%     -30.5%      40197 ą 34%  numa-vmstat.node1.nr_inactive_anon
>>     313.00 ą213%     -92.9%      22.33 ą 96%  numa-vmstat.node1.nr_inactive_file
>>       9043 ą  4%      -3.3%       8740 ą  5%  numa-vmstat.node1.nr_kernel_stack
>>       6467 ą 55%     -37.6%       4038 ą 85%  numa-vmstat.node1.nr_mapped
>>     601.50 ą 21%      -1.6%     591.83 ą  7%  numa-vmstat.node1.nr_page_table_pages
>>      13261 ą  9%      +2.8%      13630 ą  8%  numa-vmstat.node1.nr_shmem
>>      19538 ą 34%     -25.9%      14481 ą 47%  numa-vmstat.node1.nr_slab_reclaimable
>>      21995 ą  7%      -1.7%      21618 ą  9%  numa-vmstat.node1.nr_slab_unreclaimable
>>     646375 ą 66%     -48.0%     335813 ą131%  numa-vmstat.node1.nr_unevictable
>>     132.00 ą223%    -100.0%       0.00        numa-vmstat.node1.nr_written
>>      11706 ą  8%      +1.7%      11901 ą  7%  numa-vmstat.node1.nr_zone_active_anon
>>      34.17 ą219%     -54.1%      15.67 ą 84%  numa-vmstat.node1.nr_zone_active_file
>>      57826 ą 16%     -30.5%      40197 ą 34%  numa-vmstat.node1.nr_zone_inactive_anon
>>     313.00 ą213%     -92.9%      22.33 ą 96%  numa-vmstat.node1.nr_zone_inactive_file
>>     646375 ą 66%     -48.0%     335813 ą131%  numa-vmstat.node1.nr_zone_unevictable
>>       0.50 ą223%    -100.0%       0.00        numa-vmstat.node1.nr_zone_write_pending
>>     429997 ą  5%      +3.5%     444962 ą  5%  numa-vmstat.node1.numa_hit
>>       0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
>>     381801 ą 13%      +6.0%     404613 ą 14%  numa-vmstat.node1.numa_local
>>      48195 ą 71%     -16.3%      40348 ą 92%  numa-vmstat.node1.numa_other
>>       2.47 ą  2%      -2.0%       2.42 ą  5%  perf-stat.i.MPKI
>>  3.282e+09            +0.7%  3.305e+09        perf-stat.i.branch-instructions
>>       0.41            -0.1        0.33        perf-stat.i.branch-miss-rate%
>>   13547319           -16.6%   11300609        perf-stat.i.branch-misses
>>      42.88            +0.7       43.53        perf-stat.i.cache-miss-rate%
>>   17114713 ą  3%      +1.4%   17346470 ą  5%  perf-stat.i.cache-misses
>>   40081707 ą  2%      -0.0%   40073189 ą  5%  perf-stat.i.cache-references
>>       8192 ą  2%      +1.4%       8311 ą  4%  perf-stat.i.context-switches
>>       8.84            -0.8%       8.77        perf-stat.i.cpi
>>     104007            +0.0%     104008        perf-stat.i.cpu-clock
>>  1.446e+11            +0.1%  1.447e+11        perf-stat.i.cpu-cycles
>>     140.10            -1.0%     138.76        perf-stat.i.cpu-migrations
>>       8487 ą  3%      -0.9%       8412 ą  6%  perf-stat.i.cycles-between-cache-misses
>>       0.01 ą  6%      -0.0        0.01        perf-stat.i.dTLB-load-miss-rate%
>>     434358 ą  3%     -16.9%     360889        perf-stat.i.dTLB-load-misses
>>  4.316e+09            +1.3%  4.373e+09        perf-stat.i.dTLB-loads
>>       0.00 ą 15%      -0.0        0.00 ą  9%  perf-stat.i.dTLB-store-miss-rate%
>>      10408 ą 11%      -2.6%      10135 ą  8%  perf-stat.i.dTLB-store-misses
>>  4.302e+08            +5.5%  4.539e+08        perf-stat.i.dTLB-stores
>>      16.21 ą  2%      -2.5       13.73 ą 18%  perf-stat.i.iTLB-load-miss-rate%
>>     394805 ą  5%     -26.0%     292089 ą  8%  perf-stat.i.iTLB-load-misses
>>    2041963 ą  3%      -8.3%    1872405 ą 12%  perf-stat.i.iTLB-loads
>>  1.638e+10            +1.0%  1.654e+10        perf-stat.i.instructions
>>      41729 ą  6%     +37.4%      57323 ą  8%  perf-stat.i.instructions-per-iTLB-miss
>>       0.11            +0.8%       0.11        perf-stat.i.ipc
>>       0.01 ą 55%      -1.5%       0.01 ą 85%  perf-stat.i.major-faults
>>       1.39            +0.1%       1.39        perf-stat.i.metric.GHz
>>     468.46 ą  2%      -1.5%     461.59 ą  4%  perf-stat.i.metric.K/sec
>>      77.18            +1.3%      78.18        perf-stat.i.metric.M/sec
>>       2473            -0.0%       2472        perf-stat.i.minor-faults
>>      89.67            -0.5       89.18        perf-stat.i.node-load-miss-rate%
>>    5070484           -10.3%    4547670        perf-stat.i.node-load-misses
>>     585336 ą  2%      -5.5%     553260 ą  8%  perf-stat.i.node-loads
>>      98.73            +0.2       98.91        perf-stat.i.node-store-miss-rate%
>>     935187            +2.2%     955923 ą  3%  perf-stat.i.node-store-misses
>>      13301 ą  8%     -12.6%      11631 ą  5%  perf-stat.i.node-stores
>>       2473            -0.0%       2472        perf-stat.i.page-faults
>>     104007            +0.0%     104008        perf-stat.i.task-clock
>>       2.45 ą  2%      -1.0%       2.42 ą  5%  perf-stat.overall.MPKI
>>       0.41            -0.1        0.34        perf-stat.overall.branch-miss-rate%
>>      42.68            +0.6       43.26        perf-stat.overall.cache-miss-rate%
>>       8.83            -0.9%       8.75        perf-stat.overall.cpi
>>       8459 ą  3%      -1.0%       8372 ą  6%  perf-stat.overall.cycles-between-cache-misses
>>       0.01 ą  3%      -0.0        0.01        perf-stat.overall.dTLB-load-miss-rate%
>>       0.00 ą 11%      -0.0        0.00 ą  8%  perf-stat.overall.dTLB-store-miss-rate%
>>      16.19 ą  2%      -2.5       13.73 ą 18%  perf-stat.overall.iTLB-load-miss-rate%
>>      41644 ą  6%     +37.0%      57047 ą  8%  perf-stat.overall.instructions-per-iTLB-miss
>>       0.11            +0.9%       0.11        perf-stat.overall.ipc
>>      89.65            -0.5       89.15        perf-stat.overall.node-load-miss-rate%
>>      98.59            +0.2       98.78        perf-stat.overall.node-store-miss-rate%
>>   35314961           +28.0%   45213422 ą  3%  perf-stat.overall.path-length
>>  3.272e+09            +0.7%  3.295e+09        perf-stat.ps.branch-instructions
>>   13563215           -16.5%   11329031        perf-stat.ps.branch-misses
>>   17059170 ą  3%      +1.3%   17288798 ą  5%  perf-stat.ps.cache-misses
>>   39960738 ą  2%      -0.0%   39951411 ą  5%  perf-stat.ps.cache-references
>>       8205 ą  2%      +1.4%       8320 ą  4%  perf-stat.ps.context-switches
>>     103658            -0.0%     103657        perf-stat.ps.cpu-clock
>>  1.441e+11            +0.1%  1.442e+11        perf-stat.ps.cpu-cycles
>>     140.16            -1.0%     138.77        perf-stat.ps.cpu-migrations
>>     433133 ą  3%     -16.9%     359910        perf-stat.ps.dTLB-load-misses
>>  4.302e+09            +1.3%  4.359e+09        perf-stat.ps.dTLB-loads
>>      10392 ą 11%      -2.6%      10120 ą  8%  perf-stat.ps.dTLB-store-misses
>>   4.29e+08            +5.5%  4.527e+08        perf-stat.ps.dTLB-stores
>>     393499 ą  5%     -26.0%     291118 ą  8%  perf-stat.ps.iTLB-load-misses
>>    2035052 ą  3%      -8.3%    1866106 ą 12%  perf-stat.ps.iTLB-loads
>>  1.633e+10            +1.0%  1.649e+10        perf-stat.ps.instructions
>>       0.01 ą 55%      +0.1%       0.01 ą 85%  perf-stat.ps.major-faults
>>       2466            +0.0%       2466        perf-stat.ps.minor-faults
>>    5053378           -10.3%    4532205        perf-stat.ps.node-load-misses
>>     583428 ą  2%      -5.5%     551516 ą  8%  perf-stat.ps.node-loads
>>     932227            +2.2%     952780 ą  3%  perf-stat.ps.node-store-misses
>>      13342 ą  8%     -12.1%      11729 ą  6%  perf-stat.ps.node-stores
>>       2466            +0.0%       2466        perf-stat.ps.page-faults
>>     103658            -0.0%     103657        perf-stat.ps.task-clock
>>  4.952e+12            +0.9%  4.994e+12        perf-stat.total.instructions
>>      10.88 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.avg
>>       1132 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.max
>>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
>>     110.47 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.stddev
>>       0.53 ą  4%      +7.4%       0.57 ą  4%  sched_debug.cfs_rq:/.h_nr_running.avg
>>       1.03 ą  7%      -3.2%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
>>       0.45 ą  2%      -1.9%       0.44 ą  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
>>      11896 ą 12%      -0.1%      11883 ą 13%  sched_debug.cfs_rq:/.load.avg
>>     123097 ą123%     -80.1%      24487 ą 18%  sched_debug.cfs_rq:/.load.max
>>      19029 ą 74%     -49.9%       9525 ą 13%  sched_debug.cfs_rq:/.load.stddev
>>      22.63 ą 23%      +1.4%      22.93 ą 16%  sched_debug.cfs_rq:/.load_avg.avg
>>     530.85 ą 73%     -13.1%     461.19 ą 43%  sched_debug.cfs_rq:/.load_avg.max
>>      73.53 ą 46%      -7.1%      68.30 ą 33%  sched_debug.cfs_rq:/.load_avg.stddev
>>      10.88 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.avg
>>       1132 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.max
>>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
>>     110.47 ą223%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.stddev
>>    3883756 ą 13%     +12.7%    4377466 ą  4%  sched_debug.cfs_rq:/.min_vruntime.avg
>>    6993455 ą 10%      +6.5%    7445221 ą  2%  sched_debug.cfs_rq:/.min_vruntime.max
>>     219925 ą 60%     +43.7%     315970 ą 71%  sched_debug.cfs_rq:/.min_vruntime.min
>>    2240239 ą 11%     +14.0%    2554847 ą 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
>>       0.53 ą  5%      +7.5%       0.57 ą  4%  sched_debug.cfs_rq:/.nr_running.avg
>>       1.03 ą  7%      -3.2%       1.00        sched_debug.cfs_rq:/.nr_running.max
>>       0.45 ą  2%      -1.9%       0.44 ą  3%  sched_debug.cfs_rq:/.nr_running.stddev
>>       6.96 ą 55%     +26.9%       8.83 ą 45%  sched_debug.cfs_rq:/.removed.load_avg.avg
>>     305.28 ą 32%     +39.3%     425.39 ą 44%  sched_debug.cfs_rq:/.removed.load_avg.max
>>      42.94 ą 36%     +34.4%      57.70 ą 42%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>>       2.96 ą 58%     +39.1%       4.12 ą 48%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>>     150.06 ą 34%     +44.0%     216.03 ą 45%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>>      19.33 ą 42%     +42.6%      27.56 ą 45%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>       2.96 ą 58%     +39.1%       4.12 ą 48%  sched_debug.cfs_rq:/.removed.util_avg.avg
>>     150.06 ą 34%     +44.0%     216.03 ą 45%  sched_debug.cfs_rq:/.removed.util_avg.max
>>      19.33 ą 42%     +42.6%      27.56 ą 45%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>     540.76 ą  6%      +7.5%     581.25 ą  5%  sched_debug.cfs_rq:/.runnable_avg.avg
>>       1060 ą  2%      +2.5%       1087 ą  3%  sched_debug.cfs_rq:/.runnable_avg.max
>>     442.07 ą  4%      -0.1%     441.69 ą  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
>>    3123464 ą 14%     +10.0%    3436745 ą  3%  sched_debug.cfs_rq:/.spread0.avg
>>    6233151 ą 10%      +4.4%    6504505 ą  3%  sched_debug.cfs_rq:/.spread0.max
>>    -540338           +15.6%    -624739        sched_debug.cfs_rq:/.spread0.min
>>    2240217 ą 11%     +14.0%    2554844 ą 14%  sched_debug.cfs_rq:/.spread0.stddev
>>     540.71 ą  6%      +7.5%     581.22 ą  5%  sched_debug.cfs_rq:/.util_avg.avg
>>       1060 ą  2%      +2.5%       1086 ą  3%  sched_debug.cfs_rq:/.util_avg.max
>>     442.07 ą  4%      -0.1%     441.67 ą  5%  sched_debug.cfs_rq:/.util_avg.stddev
>>     454.69 ą  6%      +7.0%     486.47 ą  8%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>       1024            -0.0%       1023        sched_debug.cfs_rq:/.util_est_enqueued.max
>>     396.02 ą  2%      -0.1%     395.79        sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>     642171 ą  4%     +16.6%     748912 ą  2%  sched_debug.cpu.avg_idle.avg
>>    1051166            -1.2%    1038098        sched_debug.cpu.avg_idle.max
>>       2402 ą  5%     +28.5%       3088 ą  9%  sched_debug.cpu.avg_idle.min
>>     384501 ą  3%     -12.3%     337306 ą  5%  sched_debug.cpu.avg_idle.stddev
>>     198632 ą  7%      +5.1%     208788        sched_debug.cpu.clock.avg
>>     198638 ą  7%      +5.1%     208794        sched_debug.cpu.clock.max
>>     198626 ą  7%      +5.1%     208783        sched_debug.cpu.clock.min
>>       3.25            +2.3%       3.32 ą  5%  sched_debug.cpu.clock.stddev
>>     196832 ą  7%      +5.1%     206882        sched_debug.cpu.clock_task.avg
>>     197235 ą  7%      +5.1%     207282        sched_debug.cpu.clock_task.max
>>     181004 ą  7%      +5.7%     191329        sched_debug.cpu.clock_task.min
>>       1575 ą  3%      -1.8%       1546        sched_debug.cpu.clock_task.stddev
>>       2411 ą  4%      +2.8%       2478        sched_debug.cpu.curr->pid.avg
>>       8665 ą  4%      +3.1%       8935        sched_debug.cpu.curr->pid.max
>>       2522 ą  2%      +1.0%       2548        sched_debug.cpu.curr->pid.stddev
>>     501318            -0.0%     501249        sched_debug.cpu.max_idle_balance_cost.avg
>>     528365            +0.5%     531236 ą  2%  sched_debug.cpu.max_idle_balance_cost.max
>>     500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
>>       5157 ą 19%      -4.2%       4941 ą 23%  sched_debug.cpu.max_idle_balance_cost.stddev
>>       4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
>>       4294            +0.0%       4294        sched_debug.cpu.next_balance.max
>>       4294            +0.0%       4294        sched_debug.cpu.next_balance.min
>>       0.00 ą 41%     -40.0%       0.00 ą 13%  sched_debug.cpu.next_balance.stddev
>>       0.44 ą  4%      +2.4%       0.45        sched_debug.cpu.nr_running.avg
>>       1.00            +0.0%       1.00        sched_debug.cpu.nr_running.max
>>       0.47            +0.5%       0.47        sched_debug.cpu.nr_running.stddev
>>      14345 ą  8%      +6.7%      15305 ą  4%  sched_debug.cpu.nr_switches.avg
>>      30800 ą  8%     +34.5%      41437 ą 10%  sched_debug.cpu.nr_switches.max
>>       4563 ą 28%      +5.7%       4822 ą 25%  sched_debug.cpu.nr_switches.min
>>       5491 ą  8%     +26.4%       6941 ą 10%  sched_debug.cpu.nr_switches.stddev
>>  2.111e+09 ą  7%      +1.5%  2.142e+09 ą  6%  sched_debug.cpu.nr_uninterruptible.avg
>>  4.295e+09            +0.0%  4.295e+09        sched_debug.cpu.nr_uninterruptible.max
>>   2.14e+09            +0.1%  2.143e+09        sched_debug.cpu.nr_uninterruptible.stddev
>>     198627 ą  7%      +5.1%     208783        sched_debug.cpu_clk
>>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
>>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
>>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
>>  4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
>>     198022 ą  7%      +5.1%     208178        sched_debug.ktime
>>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
>>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
>>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
>>     199377 ą  7%      +5.1%     209531        sched_debug.sched_clk
>>       1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
>>   58611259            +0.0%   58611259        sched_debug.sysctl_sched.sysctl_sched_features
>>       0.75            +0.0%       0.75        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
>>      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
>>       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
>>       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
>>       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
>>      20.90 ą 47%      -6.4       14.49 ą100%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>>      20.90 ą 47%      -6.4       14.49 ą100%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>>       0.48 ą 44%      -0.5        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>>      29.41 ą 19%      -0.2       29.23 ą 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>>      35.02 ą  8%      -0.2       34.86 ą  7%  perf-profile.calltrace.cycles-pp.__mmap
>>      34.95 ą  8%      -0.1       34.81 ą  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>>      34.92 ą  8%      -0.1       34.79 ą  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>>      34.87 ą  8%      -0.1       34.74 ą  7%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
>>       0.41 ą 74%      -0.1        0.30 ą156%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.secondary_startup_64_no_verify
>>      29.59 ą 19%      -0.1       29.50 ą 17%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>>      29.03 ą 19%      -0.1       28.95 ą 17%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>>      29.03 ą 19%      -0.1       28.95 ą 17%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>>      29.03 ą 19%      -0.1       28.95 ą 17%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>>      29.00 ą 19%      -0.1       28.93 ą 17%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>>      29.00 ą 19%      -0.1       28.93 ą 17%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>>      33.56 ą  8%      -0.0       33.53 ą  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
>>      34.26 ą  8%      -0.0       34.24 ą  7%  perf-profile.calltrace.cycles-pp.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>>      34.23 ą  8%      -0.0       34.21 ą  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      34.19 ą  8%      -0.0       34.18 ą  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64
>>       0.44 ą 44%      +0.0        0.48 ą 44%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
>>       0.45 ą 44%      +0.0        0.48 ą 44%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
>>      33.62 ą  8%      +0.1       33.71 ą  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
>>      34.32 ą  8%      +0.1       34.42 ą  7%  perf-profile.calltrace.cycles-pp.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>      34.29 ą  8%      +0.1       34.39 ą  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
>>      34.25 ą  8%      +0.1       34.36 ą  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
>>      35.11 ą  8%      +0.2       35.31 ą  7%  perf-profile.calltrace.cycles-pp.__munmap
>>      35.04 ą  8%      +0.2       35.25 ą  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
>>      35.02 ą  8%      +0.2       35.24 ą  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>>       0.00            +0.2        0.22 ą223%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>>      34.97 ą  8%      +0.2       35.20 ą  7%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>>      34.97 ą  8%      +0.2       35.20 ą  7%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>>       0.47 ą 44%      +0.2        0.70 ą  7%  perf-profile.calltrace.cycles-pp.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       0.00            +0.4        0.44 ą223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
>>       8.27 ą 91%      +6.2       14.46 ą 77%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>>       8.27 ą 91%      +6.2       14.46 ą 77%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>>      21.09 ą 47%      -6.5       14.62 ą 99%  perf-profile.children.cycles-pp.intel_idle
>>      35.02 ą  8%      -0.2       34.86 ą  7%  perf-profile.children.cycles-pp.__mmap
>>       0.14 ą  9%      -0.1        0.00        perf-profile.children.cycles-pp.thp_get_unmapped_area
>>      34.87 ą  8%      -0.1       34.74 ą  7%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>>       0.55 ą  9%      -0.1        0.46 ą  7%  perf-profile.children.cycles-pp.do_mmap
>>      29.59 ą 19%      -0.1       29.50 ą 17%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>>      29.59 ą 19%      -0.1       29.50 ą 17%  perf-profile.children.cycles-pp.cpu_startup_entry
>>      29.59 ą 19%      -0.1       29.50 ą 17%  perf-profile.children.cycles-pp.do_idle
>>      29.03 ą 19%      -0.1       28.95 ą 17%  perf-profile.children.cycles-pp.start_secondary
>>      29.56 ą 19%      -0.1       29.49 ą 17%  perf-profile.children.cycles-pp.cpuidle_idle_call
>>      29.56 ą 19%      -0.1       29.48 ą 17%  perf-profile.children.cycles-pp.cpuidle_enter
>>      29.56 ą 19%      -0.1       29.48 ą 17%  perf-profile.children.cycles-pp.cpuidle_enter_state
>>      29.52 ą 19%      -0.1       29.45 ą 17%  perf-profile.children.cycles-pp.mwait_idle_with_hints
>>       0.38 ą  9%      -0.1        0.32 ą  6%  perf-profile.children.cycles-pp.mmap_region
>>       0.05 ą  7%      -0.1        0.00        perf-profile.children.cycles-pp.unmap_vmas
>>       0.11 ą  8%      -0.1        0.06 ą 13%  perf-profile.children.cycles-pp.unmap_region
>>       0.16 ą 10%      -0.0        0.13 ą  9%  perf-profile.children.cycles-pp.get_unmapped_area
>>       0.07 ą  7%      -0.0        0.03 ą 70%  perf-profile.children.cycles-pp.mas_find
>>       0.05 ą 44%      -0.0        0.02 ą141%  perf-profile.children.cycles-pp.mas_wr_node_store
>>       0.10 ą 10%      -0.0        0.07 ą 14%  perf-profile.children.cycles-pp.mas_spanning_rebalance
>>       0.14 ą  9%      -0.0        0.11 ą  9%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>>       0.06 ą 11%      -0.0        0.04 ą 72%  perf-profile.children.cycles-pp.__schedule
>>       0.14 ą 10%      -0.0        0.11 ą  9%  perf-profile.children.cycles-pp.vm_unmapped_area
>>       0.07 ą 10%      -0.0        0.04 ą 45%  perf-profile.children.cycles-pp.do_mas_munmap
>>       0.02 ą 99%      -0.0        0.00        perf-profile.children.cycles-pp.mas_next_entry
>>       0.04 ą 44%      -0.0        0.02 ą141%  perf-profile.children.cycles-pp.schedule
>>       0.06 ą  9%      -0.0        0.04 ą 71%  perf-profile.children.cycles-pp.mas_wr_modify
>>       0.10 ą  8%      -0.0        0.08 ą 11%  perf-profile.children.cycles-pp.mas_rev_awalk
>>       0.10 ą 12%      -0.0        0.08 ą 16%  perf-profile.children.cycles-pp.mas_wr_spanning_store
>>       0.06 ą  7%      -0.0        0.04 ą 45%  perf-profile.children.cycles-pp.mas_walk
>>       0.09 ą 11%      -0.0        0.08 ą 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>       0.02 ą141%      -0.0        0.00        perf-profile.children.cycles-pp.perf_event_mmap
>>       0.02 ą141%      -0.0        0.00        perf-profile.children.cycles-pp.unmap_page_range
>>       0.11 ą 26%      -0.0        0.10 ą 10%  perf-profile.children.cycles-pp.__get_user_nocheck_8
>>       0.35 ą 19%      -0.0        0.34 ą 11%  perf-profile.children.cycles-pp.perf_tp_event
>>       0.11 ą 26%      -0.0        0.10 ą 11%  perf-profile.children.cycles-pp.perf_callchain_user
>>       0.34 ą 19%      -0.0        0.33 ą 10%  perf-profile.children.cycles-pp.__perf_event_overflow
>>       0.34 ą 19%      -0.0        0.33 ą 10%  perf-profile.children.cycles-pp.perf_event_output_forward
>>       0.31 ą 19%      -0.0        0.30 ą 12%  perf-profile.children.cycles-pp.perf_prepare_sample
>>       0.30 ą 19%      -0.0        0.29 ą 10%  perf-profile.children.cycles-pp.perf_callchain
>>       0.30 ą 19%      -0.0        0.29 ą 10%  perf-profile.children.cycles-pp.get_perf_callchain
>>       0.12 ą  9%      -0.0        0.11 ą  9%  perf-profile.children.cycles-pp.mas_empty_area_rev
>>       0.08 ą  7%      -0.0        0.07 ą  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>>       0.01 ą223%      -0.0        0.00        perf-profile.children.cycles-pp.mas_wr_bnode
>>       0.01 ą223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_event_mmap_event
>>       0.01 ą223%      -0.0        0.00        perf-profile.children.cycles-pp.__entry_text_start
>>       0.33 ą 10%      -0.0        0.32 ą  7%  perf-profile.children.cycles-pp.mas_store_prealloc
>>       0.32 ą 20%      -0.0        0.32 ą 10%  perf-profile.children.cycles-pp.update_curr
>>       0.32 ą 19%      -0.0        0.31 ą 11%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>>       0.56 ą 22%      -0.0        0.56 ą 58%  perf-profile.children.cycles-pp.start_kernel
>>       0.56 ą 22%      -0.0        0.56 ą 58%  perf-profile.children.cycles-pp.arch_call_rest_init
>>       0.56 ą 22%      -0.0        0.56 ą 58%  perf-profile.children.cycles-pp.rest_init
>>       0.07 ą 45%      -0.0        0.07 ą 11%  perf-profile.children.cycles-pp.native_irq_return_iret
>>       0.01 ą223%      +0.0        0.01 ą223%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>>       0.06 ą 45%      +0.0        0.06 ą  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>       0.18 ą 16%      +0.0        0.18 ą 14%  perf-profile.children.cycles-pp.perf_callchain_kernel
>>       0.12 ą 16%      +0.0        0.12 ą 12%  perf-profile.children.cycles-pp.unwind_next_frame
>>       0.36 ą 18%      +0.0        0.37 ą 10%  perf-profile.children.cycles-pp.task_tick_fair
>>       0.58 ą 14%      +0.0        0.58 ą 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
>>       0.49 ą 14%      +0.0        0.50 ą 11%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>       0.05 ą 46%      +0.0        0.05 ą 45%  perf-profile.children.cycles-pp.__unwind_start
>>       0.45 ą 14%      +0.0        0.46 ą 11%  perf-profile.children.cycles-pp.tick_sched_handle
>>       0.46 ą 14%      +0.0        0.46 ą 11%  perf-profile.children.cycles-pp.tick_sched_timer
>>       0.45 ą 15%      +0.0        0.45 ą 11%  perf-profile.children.cycles-pp.update_process_times
>>       0.06 ą 11%      +0.0        0.07 ą 12%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
>>       0.58 ą 14%      +0.0        0.58 ą 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.record__mmap_read_evlist
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.perf_mmap__push
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.record__pushfn
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.ksys_write
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.vfs_write
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.__libc_write
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.generic_file_write_iter
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.__generic_file_write_iter
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.generic_perform_write
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
>>       0.39 ą 17%      +0.0        0.40 ą 10%  perf-profile.children.cycles-pp.scheduler_tick
>>       0.00            +0.0        0.01 ą223%  perf-profile.children.cycles-pp.clockevents_program_event
>>       0.05 ą 45%      +0.0        0.06 ą 11%  perf-profile.children.cycles-pp.mas_wr_store_entry
>>       0.60 ą 14%      +0.0        0.61 ą  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>>       0.08 ą  8%      +0.0        0.10 ą 12%  perf-profile.children.cycles-pp.mas_destroy
>>       0.08 ą  9%      +0.0        0.09 ą 21%  perf-profile.children.cycles-pp.perf_session__deliver_event
>>       0.08 ą 12%      +0.0        0.09 ą 33%  perf-profile.children.cycles-pp.ordered_events__queue
>>       0.08 ą 11%      +0.0        0.10 ą 22%  perf-profile.children.cycles-pp.__ordered_events__flush
>>       0.08 ą  9%      +0.0        0.10 ą 22%  perf-profile.children.cycles-pp.perf_session__process_user_event
>>       0.06 ą 13%      +0.0        0.08 ą 14%  perf-profile.children.cycles-pp.kmem_cache_alloc
>>       0.07 ą  9%      +0.0        0.09 ą 33%  perf-profile.children.cycles-pp.queue_event
>>       0.08 ą  8%      +0.0        0.10 ą 31%  perf-profile.children.cycles-pp.process_simple
>>       0.00            +0.0        0.03 ą100%  perf-profile.children.cycles-pp.evlist__parse_sample
>>       0.06 ą  6%      +0.0        0.08 ą  8%  perf-profile.children.cycles-pp.memset_erms
>>       0.22 ą  7%      +0.0        0.26 ą 23%  perf-profile.children.cycles-pp.__libc_start_main
>>       0.22 ą  7%      +0.0        0.26 ą 23%  perf-profile.children.cycles-pp.main
>>       0.22 ą  7%      +0.0        0.26 ą 23%  perf-profile.children.cycles-pp.run_builtin
>>       0.21 ą  9%      +0.0        0.25 ą 23%  perf-profile.children.cycles-pp.cmd_record
>>       0.21 ą  9%      +0.0        0.25 ą 23%  perf-profile.children.cycles-pp.__cmd_record
>>       0.20 ą  9%      +0.0        0.24 ą 24%  perf-profile.children.cycles-pp.cmd_sched
>>       0.17 ą 11%      +0.0        0.21 ą 25%  perf-profile.children.cycles-pp.reader__read_event
>>       0.17 ą 11%      +0.0        0.21 ą 26%  perf-profile.children.cycles-pp.record__finish_output
>>       0.17 ą 11%      +0.0        0.21 ą 26%  perf-profile.children.cycles-pp.perf_session__process_events
>>       0.00            +0.0        0.04 ą 45%  perf-profile.children.cycles-pp.kmem_cache_free
>>       0.17 ą  7%      +0.1        0.22 ą  8%  perf-profile.children.cycles-pp.mas_alloc_nodes
>>       0.11 ą  9%      +0.1        0.17 ą  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
>>       0.00            +0.1        0.06 ą 13%  perf-profile.children.cycles-pp.vm_area_dup
>>       0.16 ą  8%      +0.1        0.22 ą  6%  perf-profile.children.cycles-pp.mas_preallocate
>>      67.20 ą  8%      +0.1       67.28 ą  7%  perf-profile.children.cycles-pp.osq_lock
>>      68.59 ą  8%      +0.1       68.66 ą  7%  perf-profile.children.cycles-pp.down_write_killable
>>       1.04 ą  8%      +0.1        1.12 ą  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>>      70.08 ą  8%      +0.1       70.15 ą  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>      68.52 ą  8%      +0.1       68.60 ą  7%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>>      70.03 ą  8%      +0.1       70.11 ą  7%  perf-profile.children.cycles-pp.do_syscall_64
>>      68.46 ą  8%      +0.1       68.55 ą  7%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>>       0.55 ą  8%      +0.2        0.71 ą  8%  perf-profile.children.cycles-pp.do_mas_align_munmap
>>      35.12 ą  8%      +0.2       35.31 ą  7%  perf-profile.children.cycles-pp.__munmap
>>       0.00            +0.2        0.22 ą  7%  perf-profile.children.cycles-pp.vma_expand
>>       0.00            +0.2        0.22 ą223%  perf-profile.children.cycles-pp.intel_idle_irq
>>      34.98 ą  8%      +0.2       35.20 ą  7%  perf-profile.children.cycles-pp.__x64_sys_munmap
>>      34.97 ą  8%      +0.2       35.20 ą  7%  perf-profile.children.cycles-pp.__vm_munmap
>>       0.64 ą 13%      +0.2        0.88 ą 55%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>>       0.00            +0.3        0.30 ą  7%  perf-profile.children.cycles-pp.__vma_adjust
>>       0.00            +0.4        0.36 ą  6%  perf-profile.children.cycles-pp.__split_vma
>>       8.42 ą 91%      +6.2       14.60 ą 77%  perf-profile.children.cycles-pp.intel_idle_ibrs
>>      29.52 ą 19%      -0.1       29.45 ą 17%  perf-profile.self.cycles-pp.mwait_idle_with_hints
>>       0.18 ą  9%      -0.1        0.12 ą 10%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
>>       0.04 ą 45%      -0.0        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>>       0.04 ą 44%      -0.0        0.00        perf-profile.self.cycles-pp.mmap_region
>>       0.10 ą  5%      -0.0        0.08 ą  9%  perf-profile.self.cycles-pp.mas_rev_awalk
>>       0.06 ą  7%      -0.0        0.04 ą 45%  perf-profile.self.cycles-pp.mas_walk
>>       0.06 ą 11%      -0.0        0.04 ą 45%  perf-profile.self.cycles-pp.do_mas_align_munmap
>>       0.08 ą  8%      -0.0        0.07 ą 14%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>>       0.08 ą  7%      -0.0        0.07 ą  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>>       0.06 ą 13%      -0.0        0.05 ą  7%  perf-profile.self.cycles-pp.down_write_killable
>>       0.07 ą 45%      -0.0        0.07 ą 11%  perf-profile.self.cycles-pp.native_irq_return_iret
>>       0.05 ą 45%      -0.0        0.05 ą 47%  perf-profile.self.cycles-pp.unwind_next_frame
>>       0.00            +0.0        0.01 ą223%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
>>       0.05 ą 45%      +0.0        0.06 ą 11%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
>>       0.00            +0.0        0.02 ą141%  perf-profile.self.cycles-pp.kmem_cache_free
>>       0.07 ą  8%      +0.0        0.09 ą 33%  perf-profile.self.cycles-pp.queue_event
>>       0.06 ą  8%      +0.0        0.08 ą  8%  perf-profile.self.cycles-pp.memset_erms
>>       0.04 ą 45%      +0.0        0.08 ą  6%  perf-profile.self.cycles-pp.kmem_cache_alloc_bulk
>>      66.61 ą  8%      +0.1       66.68 ą  7%  perf-profile.self.cycles-pp.osq_lock
>>       1.02 ą  8%      +0.1        1.10 ą  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>> | Link: https://lore.kernel.org/oe-lkp/202212151657.5d11a672-yujie.liu@intel.com
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>         sudo bin/lkp run generated-yaml-file
>>
>>         # if come across any failure that blocks the test,
>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
