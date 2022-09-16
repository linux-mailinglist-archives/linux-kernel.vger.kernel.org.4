Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE65BAD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIPMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiIPMYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:24:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F25FB1B9C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663331051; x=1694867051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c7OLGeDx2+f5FVAxPzjJ7NBLTC+8PvXr+4XXksOOmh8=;
  b=ZAsgW95ekfHQsYyY1+FWMFOUCQih5Kd+QOvjhY29f4V07/uz7oFFGdNK
   6UY3FQnk8hZ+j3IQapU87VS1ZHbYesVSM9wvpLh8BBWA1t7pBh0xwhsW0
   iFFsJNdx7kb9urH7nu8Y5Aef4rPBDCbfqU3y8lz9GOJGktSMURFHXPTMo
   9rEpYD5P+T5p4J9Pgi3087i8UlP4pNtkGAKyAEWsBrzbnRsjks5OavRCh
   2mxqICyepLzPNA7pVcxpMdTogkXCSR+xsUU7tJ/0tMjn9rIx9LGMlJ1zH
   nHXjobHJgbxxyttXCFm53v1pu4fZqPw9rUg9oZ6S/ipcYsFusHpVgqUq2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="286020291"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="286020291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 05:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568813829"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 05:24:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 05:24:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 05:24:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 05:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuyMus+Us+2rAMx0ueMJu3TSZ5uLNsB6MHMvFsVUZrvgiX2WFOR2XFvQCAFXLsNzJPJdCJukwNd/JNXmiRJ2esqBU9ovuNxbsGWjGGXxyhSvqkfSIg8Lm4nT44K2V93FtTM2kPdl75aOvV9E0gKaxLGuA+I5IgixIlozK6pKC4F6702I7Y78yeek+4+e8eN9cBUMpkpF0RPSqZXKAtx2L7F7ltZ5xyZvx98Qa0w+gjmAOBOhH1xJYBs9IEpDKhsetyJEM7MsiqMpWfcyi3MXJxc0Gk1Fg1IOu2MsL/dNUDB3rkmfXTe4GsQqAGphsABh7HMHprr2pqqnv+0BXmKr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg3wAyb/kThunuN8wEIupu8sEsxGFQnZO0VNiv/Oe3A=;
 b=HF3FxJj7dWCuOiT19nHoegX8AfrKqc+8M3jqmrqbQ7xCohsH/eRsz93hpOUXstkLzcZal2VstQBaKC20mtKXstGxDKk3cBn+qx3dxzU2R2rzfVS1FAI0bbpEKsGsYOJj1rKr9VUJQpI2LkaMUYdR4pomRaggDazPhzeobmcXTpWTZ+2CA90loqWC5LIvljO3yk6OndK5a5G910zbCmnGBJEHRXgI54V5yphTzj3YYli72amWxtWLiwqhKonP34nOVKe13l1WON7jYvBFtPp7Y4TFWmEr7qeR8IgfXpSUz4BJ3ESzV+yUF1yM4fEuhtN47xumuKnxBiq0bOgBCEsuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 12:24:07 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0%7]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 12:24:06 +0000
Message-ID: <fbca082a-7fb1-bdb5-af93-69061e597b34@intel.com>
Date:   Fri, 16 Sep 2022 14:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [topic/core-for-CI] Revert "iommu/dma: Fix race condition during
 iova_domain initialization"
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20220914124045.903883-1-karolina.drobnik@intel.com>
 <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
 <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
From:   Karolina Drobnik <karolina.drobnik@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0741.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::34) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|SJ0PR11MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c5c30b-773a-40f9-9d85-08da97de593e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9aqgOCjZOCA5i6r9fx+mwHd75wKTwRdunZeJ1ooBEYJibY3KdisVVEQ66IwaJrFBlMupvQf+k1YYOWQBV5fD3inn9wsDqTQU9p4eVj2o/ypsNpnLRvUEeluup6nhHzsyZ8Y/Tct4uAEZNYAL6bCEsY740h/1R0QUTc63QXH9zQLW8a2PNxIf8CjEYDTuhZlO25lgCHuwN79TG3SYB8UqRw1okyRAQdRf7FKnaiuShkH8m2wm4ntQ2NRBEAvndsKLp0lER/xnTa6H1wv7uYy61HMyGgO4LrC3jR3M39+mi3l+kJYfp9wbgSlqgEdJuh9fpO2J9Ya1n+tA9TxDT5p1YT4rcMmXonXEkKODho/w7ynsoxyeniwdCMkB/L43prKXz0ShQSDFNJH4yotMdCbM9rPOyUq97++wgLQ4FX24904cR8Gs+DiM2h7hgDDLzCPDifvn5yLtsSGmB17hRGzS814N3v/fc4GZI6x/1S/7PZDkVO9T6oFnzS14eW/5Gc7wp9uQe56bY6DyOBHYXHSW3j7a9nweM7X+x0cN7nmHZxKNYO8PWTWB6DSnd33RL0kUxgcayc2PDGzYN3sdD/72mbH4u2eqZfAi3WB++XMOJeBfm/PtHJ9Y6teuf62DJFQP6Y+VjiMieXcllzpXKQiWz1q1uV2CnnCTxclyLjVm5dskPXwGteMMrZCiItb/4ziEgfHZ/Wus1jE4TRrU0k5pfv0ZxNScadPErz+Q/l0PnKoE2qT0QFPvFNFvgNDm9veETN/x31mFSjmEcIS1RE6nE1oMU+QxXrTDnijk3IUU7MxLMN0rtQrF0g+TxoDhJJfpSKxjHAuHt2g5m+i4y+hH/6MBn0h2tMn/ETd9rCKi+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(54906003)(110136005)(31686004)(44832011)(8676002)(8936002)(83380400001)(186003)(2616005)(5660300002)(31696002)(86362001)(66476007)(66946007)(66556008)(2906002)(36756003)(4326008)(38100700002)(6636002)(316002)(6666004)(41300700001)(966005)(82960400001)(36916002)(26005)(6512007)(6506007)(53546011)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhwcnNqSWxwdndxN0REUXNvRjl0UjhFUUFHTDdMYTBCOXlyU3VUclNOWjZW?=
 =?utf-8?B?Uy9HeE1RVUFxU211M0l3OWxqOEJOSlZsWnN6TnM3NDFHVTBrOXFZcGtXYWZL?=
 =?utf-8?B?ZmtuSFFsMTluR05IaHJBNW42OVRZMmp3K2tnbk9jY29XQXF4SHBkWFU3YThW?=
 =?utf-8?B?a29KYy9iUmxicURyV1JpVUJHTytuaTVRbk5BWlBCMEp1SUsyTkUzTmxmQnh1?=
 =?utf-8?B?QXFZUlVBUCtQK2dINkZ3SHAxSjR2ZDQ5a0ZrNWlIMHlOdGVKbFRhS0dMNDQz?=
 =?utf-8?B?MmI4QkxINXl2OGVsV3FXMGlmcWgrTytnQjBUakpXbDUweEFiWS9WS3IyazNh?=
 =?utf-8?B?YUNnMGpjSy9WZVRzRGFmeXZCcnRycnZrTWdYemphbDExc3JkTWhma1NORmRz?=
 =?utf-8?B?Z2hvalo5VjV6RGhiOWNJeTBvMHpoT1pvM2o3WE9ReU41Yk91STNUY3dWb0ZQ?=
 =?utf-8?B?d3F3czVsdWpCM2xMZ1RWMHZHTzVLUldzYTVzN3d0bFp0akdrQzhmVG4wVkVp?=
 =?utf-8?B?VDMxTEg4TTRSeGJIQUkyVGN2QWJ6OEJuMWxiYkNzSHQwSUg3K0xJMElKK3Ba?=
 =?utf-8?B?OFJySnNmVEtCSTc5bkpSamRzZFJzcys1ZXBUQmVqNThXM1NmTFMyeFFSM1R3?=
 =?utf-8?B?cWx5eG1VZXBNMm1yOHBsdEErRWZ3R1VzQlF4RVZsczZ5TUV6R0g1d3VrVGd3?=
 =?utf-8?B?ZEJacEgxRXhXc0hrcWw5VCt2cGx5cVRQakZnYnMrR1RVM01odmsxM3NsbW8v?=
 =?utf-8?B?cmhCTExXR3JQenNFL3FkYnp3N0tuSllxWHdEeVBSQVViWTV4bFNvV0l0alNG?=
 =?utf-8?B?bmU2RWhFRnVkNkFuRm91ZnR0OHVnWUZNblBBVkJGTWFOa1A4cFd6QXJMT2N3?=
 =?utf-8?B?eE5YanR6TzV6SEhQWW5zZEdyRUVreVpaWnVPUXU3R2RuaUpYK1BPRHdGMVZL?=
 =?utf-8?B?MENSbGppRXN2eHZWQUh2TVRqdGdhcVR6TkoybFZXU3JwWUc2emFPUkk1TmdP?=
 =?utf-8?B?UkphbDZZdnFFOG9DNmo2cUdVQmE4dTdXUm9HSldudk4vT3dONzNEUnV2N2R1?=
 =?utf-8?B?R2hOY05xMUVsckJGMjQ0UnY3N3JKUHhNOXp2dm54TDJJUVlEYThNaDF5RFM3?=
 =?utf-8?B?SE9STEVEd0wzVnV5OGtKWVdUMGkrQlBrbFUwRXdadkZhTHEwT3lWYmEydS80?=
 =?utf-8?B?V01VRVp2ZHA5cEpoczhYN2RLcmx2K0JKams3R0c4T00xcmFYOGJiME5ZTWUz?=
 =?utf-8?B?VHVhemUvRDhlcjFRdm5TMnFkY0ZEY0ZCYi82VE42V0lUSElSdU1rbFVVMmtw?=
 =?utf-8?B?ay9xak9YSHB0SWJFenovZ1IwazFLVXU5Y2swMzREZzl5enZIUXl6ZmcxZERw?=
 =?utf-8?B?b3pNSDE0U1FUOHc3WXNPSW5nM2lOdmpraVdUVmRRSWJSNVBtcmRDWWpMTkJF?=
 =?utf-8?B?UlN5NW1ucnc4WkRiT0NuRXhFWlIzL01jOU96ZDBFMEJoN2I2S0t4Lys5MTRs?=
 =?utf-8?B?V0JraEFCdkU4TjlvY3dJZVlqMkY5V2FQRXI2bjRVRjFVS3VjVmd6azh6ZnRG?=
 =?utf-8?B?bFoyeGkxOGsxeGhFZGh4OCs5ek5VOTR0Y1VEeCs3NGVFTUNHSXM0SUxCRUdv?=
 =?utf-8?B?bk1rREcwVW1ReFl0Rk95c1puK3F5ODZCT2NrSkxwQ0hYaG81ZXJjWE1HeFR3?=
 =?utf-8?B?UmFzUTN4TGRrRDRia0dLbHZraUpSb1Y5a1RUd215QW5TUmYrQytZT0JUYzlq?=
 =?utf-8?B?S1JpczJZTFRVWE85UDEralJFZW9CUVBiVFJmZC92bURBY3hxR2dBdnpBclIy?=
 =?utf-8?B?YmsyQ3BFMHVIdnIrUHY4YzdTb2FEbDJXaXVYK3F5NkJmQjk0UEJiMVMyeVQ5?=
 =?utf-8?B?S29iL054eW1lVFp3NExIRHdCaEdCRVZIbC9ZbnBwSU5rRHNJTUxZK3QrNjMw?=
 =?utf-8?B?dkpwSlhob1l5UjdYcnc2dGVWOWs5WThlRlFGUFltK05kcnNtUXRzK082VSt4?=
 =?utf-8?B?N01aekM4ZWJObE8xRkJqK2dlMFFqSWQ5dWF1MXRMdjZ0MmFMWk5OL2FFdkVJ?=
 =?utf-8?B?SVV1QksrYVNoZ3RmWktTMWZSeEZSUlN4a2E2YWpPR2h1ejU3a3FqZjIzeDVQ?=
 =?utf-8?B?Uk9EbExGYjh6TCt4b1dOTVFuQnJPTzBoNEIzUTZQaVVja2ZscGs4eEpZeW9U?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c5c30b-773a-40f9-9d85-08da97de593e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 12:24:06.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtGfH6pW5dVMHp0tG0TdlmJ8MdNp6d0FcAzbW9hCXtnPv2m1kdCpTu03vI3W9R4fkjXVwRKH9xNBG3vNspUU0mXg68u5INtsWo9Th9ciED4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2022 17:54, Robin Murphy wrote:
> On 2022-09-14 16:01, Lucas De Marchi wrote:
>> On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
>>> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
>>> 
>>> This change introduces a regression on Alder Lake that
>>> completely blocks testing. To enable CI and avoid possible
>>> circular locking warning, revert the patch.
>> 
>> We are already on rc5. Are iommu authors involved aware of this 
>> issue? We could do this in our "for CI only" branch, but it's 
>> equally important that this is fixed for 6.0
>> 
>> Cc'ing them.
> 
> The lockdep report doesn't make much sense to me - the deadlock cycle
> it's reporting doesn't even involve the mutex added by that commit,
> and otherwise the lock ordering between the IOMMU bus notifier(s) and
> cpu_hotplug_lock has existed for ages. Has lockdep somehow got
> multiple different and unrelated bus notifiers mixed up, maybe?
> 
> FWIW nobody else has reported anything, and that mutex addresses a 
> real-world concurrency issue, so I'm not convinced a revert is 
> appropriate without at least a much clearer justification.

I'll share more background on this regression. We've noticed that no
tests were run for Alder Lake platforms. This may happens when, for
example, there is a kernel taint or lockdep warning.

Links:
https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlm-1.html
https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlp-6.html

The CI logs (which can be found for example here[1], boot0 file)
revealed a lockdep warning. One of the recent changes in the area was
commit ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain
initialization"), and I sent a revert patch to test it on CI[2]. This
proved to be effective, as the tests started running on Alder Lake
platform:
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_108474v1/index.html?hosts=adlp

To be clear, that revert is just a way of unblocking CI testing, the
problem requires a specific fix.

Lucas, would it be possible to merge this revert to the topic branch to
unblock Alder Lake until this issue is fixed? I'm afraid that some
regressions could slip through the cracks if we don't do it soon enough.

Thanks,
Karolina

----
[1] -
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12145/bat-adlm-1/igt@runner@aborted.html
[2] - https://patchwork.freedesktop.org/series/108474/

> Robin.
> 
>> thanks Lucas De Marchi
>> 
>>> 
>>> kernel log:
>>> 
>>> ====================================================== WARNING: 
>>> possible circular locking dependency detected 
>>> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted 
>>> ------------------------------------------------------ cpuhp/0/15
>>> is trying to acquire lock: ffff8881013df278 
>>> (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
>>> blocking_notifier_call_chain+0x20/0x50 but task is already 
>>> holding lock: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at:
>>>  cpuhp_thread_fun+0x48/0x1f0 which lock already depends on the
>>> new loc the existing dependency chain (in reverse order) is: ->
>>> #3 (cpuhp_state-up){+.+.}-{0:0}: lock_acquire+0xd3/0x310 
>>> cpuhp_thread_fun+0xa6/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>> kthread+0xed/0x120 ret_from_fork+0x1f/0x30 -> #2 
>>> (cpu_hotplug_lock){++++}-{0:0}: lock_acquire+0xd3/0x310 
>>> __cpuhp_state_add_instance+0x43/0x1c0 
>>> iova_domain_init_rcaches+0x199/0x1c0 
>>> iommu_setup_dma_ops+0x130/0x440 bus_iommu_probe+0x26a/0x2d0 
>>> bus_set_iommu+0x82/0xd0 intel_iommu_init+0xe33/0x1039 
>>> pci_iommu_init+0x9/0x31 do_one_initcall+0x53/0x2f0 
>>> kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>> ret_from_fork+0x1f/0x30 -> #1 
>>> (&domain->iova_cookie->mutex){+.+.}-{3:3}: 
>>> lock_acquire+0xd3/0x310 __mutex_lock+0x97/0xf10 
>>> iommu_setup_dma_ops+0xd7/0x440 iommu_probe_device+0xa4/0x180 
>>> iommu_bus_notifier+0x2d/0x40 notifier_call_chain+0x31/0x90 
>>> blocking_notifier_call_chain+0x3a/0x50 device_add+0x3c1/0x900 
>>> pci_device_add+0x255/0x580 pci_scan_single_device+0xa6/0xd0 
>>> pci_scan_slot+0x7a/0x1b0 pci_scan_child_bus_extend+0x35/0x2a0 
>>> vmd_probe+0x5cd/0x970 pci_device_probe+0x95/0x110 
>>> really_probe+0xd6/0x350 __driver_probe_device+0x73/0x170 
>>> driver_probe_device+0x1a/0x90 __driver_attach+0xbc/0x190 
>>> bus_for_each_dev+0x72/0xc0 bus_add_driver+0x1bb/0x210 
>>> driver_register+0x66/0xc0 do_one_initcall+0x53/0x2f0 
>>> kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>> ret_from_fork+0x1f/0x30 -> #0 
>>> (&(&priv->bus_notifier)->rwsem){++++}-{3:3}: 
>>> validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>> lock_acquire+0xd3/0x310 down_read+0x39/0x140 
>>> blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 
>>> platform_device_add+0x108/0x240 coretemp_cpu_online+0xe1/0x15e 
>>> [coretemp] cpuhp_invoke_callback+0x181/0x8a0 
>>> cpuhp_thread_fun+0x188/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>> kthread+0xed/0x120 ret_from_fork+0x1f/0x30 other info that might
>>>  help us debug thi Chain exists of &(&priv->bus_notifier)->rwsem 
>>> --> cpu_hotplug_lock --> cpuhp_state- Possible unsafe locking 
>>> scenari CPU0 CPU1 ----                    ---- 
>>> lock(cpuhp_state-up); lock(cpu_hotplug_lock); 
>>> lock(cpuhp_state-up); lock(&(&priv->bus_notifier)->rwsem); *** 
>>> DEADLOCK * 2 locks held by cpuhp/0/15: #0: ffffffff82648f10 
>>> (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0 
>>> #1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
>>> cpuhp_thread_fun+0x48/0x1f0 stack backtrace: CPU: 0 PID: 15 Comm:
>>> cpuhp/0 Not tainted 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
>>> Hardware name: Intel Corporation Alder Lake Client 
>>> Platform/AlderLake-P DDR4 RVP, BIOS 
>>> ADLPFWI1.R00.3135.A00.2203251419 03/25/2022 Call Trace: <TASK> 
>>> dump_stack_lvl+0x56/0x7f check_noncircular+0x132/0x150 
>>> validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>> lock_acquire+0xd3/0x310 ? blocking_notifier_call_chain+0x20/0x50 
>>> down_read+0x39/0x140 ? blocking_notifier_call_chain+0x20/0x50 
>>> blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 ? 
>>> dev_set_name+0x4e/0x70 platform_device_add+0x108/0x240 
>>> coretemp_cpu_online+0xe1/0x15e [coretemp] ? 
>>> create_core_data+0x550/0x550 [coretemp] 
>>> cpuhp_invoke_callback+0x181/0x8a0 cpuhp_thread_fun+0x188/0x1f0 ?
>>>  smpboot_thread_fn+0x1e/0x260 smpboot_thread_fn+0x1b5/0x260 ? 
>>> sort_range+0x20/0x20 kthread+0xed/0x120 ? 
>>> kthread_complete_and_exit+0x20/0x20 ret_from_fork+0x1f/0x30 
>>> </TASK>
>>> 
>>> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
>>> 
>>> Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com> Cc:
>>>  Lucas De Marchi <lucas.demarchi@intel.com> --- 
>>> drivers/iommu/dma-iommu.c | 17 ++++------------- 1 file changed,
>>>  4 insertions(+), 13 deletions(-)
>>> 
>>> diff --git a/drivers/iommu/dma-iommu.c 
>>> b/drivers/iommu/dma-iommu.c index 17dd683b2fce..9616b473e4c7 
>>> 100644 --- a/drivers/iommu/dma-iommu.c +++ 
>>> b/drivers/iommu/dma-iommu.c @@ -65,7 +65,6 @@ struct 
>>> iommu_dma_cookie {
>>> 
>>> /* Domain for flush queue callback; NULL if flush queue not in 
>>> use */ struct iommu_domain        *fq_domain; -    struct mutex 
>>> mutex; };
>>> 
>>> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled); @@
>>> -312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain 
>>> *domain) if (!domain->iova_cookie) return -ENOMEM;
>>> 
>>> -    mutex_init(&domain->iova_cookie->mutex); return 0; }
>>> 
>>> @@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct 
>>> iommu_domain *domain, dma_addr_t base, }
>>> 
>>> /* start_pfn is always nonzero for an already-initialised domain
>>>  */ -    mutex_lock(&cookie->mutex); if (iovad->start_pfn) { if 
>>> (1UL << order != iovad->granule || base_pfn != iovad->start_pfn)
>>>  { pr_warn("Incompatible range for DMA domain\n"); - ret = 
>>> -EFAULT; -            goto done_unlock; +            return 
>>> -EFAULT; }
>>> 
>>> -        ret = 0; -        goto done_unlock; +        return 0; 
>>> }
>>> 
>>> init_iova_domain(iovad, 1UL << order, base_pfn); ret = 
>>> iova_domain_init_rcaches(iovad); if (ret) -        goto 
>>> done_unlock; +        return ret;
>>> 
>>> /* If the FQ fails we can simply fall back to strict mode */ if 
>>> (domain->type == IOMMU_DOMAIN_DMA_FQ && 
>>> iommu_dma_init_fq(domain)) domain->type = IOMMU_DOMAIN_DMA;
>>> 
>>> -    ret = iova_reserve_iommu_regions(dev, domain); - 
>>> -done_unlock: -    mutex_unlock(&cookie->mutex); -    return
>>> ret; +    return iova_reserve_iommu_regions(dev, domain); }
>>> 
>>> /** -- 2.25.1
>>> 
