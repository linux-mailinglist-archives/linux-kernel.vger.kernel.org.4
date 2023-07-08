Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF874BBD0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGHEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:40:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED191FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688791248; x=1720327248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yr7z1v8z0AyQzlY/1+TnGDBLiYl62xFX8A6qZpphJfA=;
  b=jfMxd7yCr1i5iwXGaNNVy8fWwmsHDGljaevcMEYHeMoWuKXM+6/R2W/Q
   bu8VhTU7grmXQc7QVez+u+bwkj+0wsZMhdNkOYtg9MU9VUcSeRP/6cqPj
   O/KYDbJVKi0VHHYChMoLtEg/qytJMyiT63Wi2JhjNR5ZCFj5rKF4GLoq7
   L/MRwnL6SHAMix5rChiy8t4mR9u5OkEYTFukoNi3T6Vgb+u2k18gQD8iN
   3/omyat/NzuNlqZXSByInXOFQtMs9BUpLVxsVgnbMYPvIROvwDPRtDuGV
   Aczha2LFXdfROsN5LTsiyxi6v4dOMPb5lJ2mr1bGdKYWWU8LMy44pxHs1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353882909"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353882909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 21:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="894202195"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="894202195"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2023 21:40:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 21:40:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 21:40:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 21:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A24FR31LtJu1sFye06K72OLUfEJMLg+b5FeW0isgZnBgwZhnmtwyHPOhW2NBfMdyVtjZHLTpH9MCrI29LQILtzm5DIvIMUayn3uTt4sO7W2qaNi+UkoSfYzJiVp3kyj5QYP2zIVJyfUfsIZk+n4bf8mngqcBXjI5r6SgiLJMrVvFgRmDyLDpJ615r2E1wKPhNz9XcSFAoAWVQ1XnPcjMaHwlBjrjR1hp4+CbNGZvBzvl12cN9AVxj7BYfDa0l9SMlT0Krkhry5nrsbEAAN/klqIEb0vTJON5X2SsE/J8fDSH6VqeY+y9tbGknNLzxI82P+6gqrw9MHfLws+O6mLn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRXe/HzCoBBxP+NVQQqpJzEdNkNRZaisxakUOJ8vRgc=;
 b=E6AbNXInZh9EtOQd4CLhKzJNB0Ac6duTV49z+9qZzd2FusiNpX3ja2od/v7TxnNcH9AKT8DV0KcpBNhZItXhS5g5iyDD5CTPM94jBRz3lOIzx7P2DxnJAazoEt/B8JxhZyK5oqXdtrD/gNCidGjLSqgTC3wX7WUhXMNsYHjZovQbEU3JPq9v89+izgIyR0i1FljH8XF4UEL+5TUwTqyuzi5Vuoi95ERls9H+zM4xQTSLmgB22VkDI4N+ppUY2SYxLgS/586SozfJlcvOd7u3dgDDgMrONkEcgXIMphkyLmhDr9H5nfPJJMO1ZaYQmnkbRV1u0Kdw5BiQ89IKbtfa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 04:40:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 04:40:45 +0000
Message-ID: <0e3a7331-bf91-5d3b-0f05-634f1cbb60d5@intel.com>
Date:   Sat, 8 Jul 2023 12:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>, <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
 <CAOUHufbjiW00jd_DWanfW0ps1o8KstZYbvkbYcJia1L=jVojMw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbjiW00jd_DWanfW0ps1o8KstZYbvkbYcJia1L=jVojMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8c31c6-62b0-4df7-ece9-08db7f6d7e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1QT5hFtFQP4rIziOGV0wU4ETqjGGUDVYZEOTIA2rveg4ysdGsDAcmQu0fYs7Gbki4gCc1GFDe5BbGYjYbF4Dw6Rw/fvcPDohfryXlZG39yDdxyzfbnf3FFvftxE+ykUA3Ygqg2lDsTOOr/WWDxkIzgmAWSZyZ4jzSiHToUTtwxNGHZGWPNdUNgnXufylLAX0WZhu9zSGv4tKIAbBhAZTYeD0SR4y1WmIltCEjPxwkKjD4X8KqNjJLWsBuH5yeCXs3D/HX35UTWy32untXm9XpU5AuBiBNlhcj12Vb1/XAT1yZuzPNxQl9re3aj/uIEhFE9bynx6TDmNw6dpHFGgdTWngEZp6s7sHs9x9zYIRR1ddLl/XfgW23rCFOtPZ6fH5qyO8UPpfS3PX2mfMXIQi02E4WmLUJisCOQ8E5uWVe3RoUBXoDgyJ90+5YG0077uyUjIeH6lag+hyLkLD8y6aU2NCjTTZFEYa+uKZEiUt/cZTpGqhjDskETY0MWeIXY11HYTA3XNZBA4efl2566x7/2s5touXKkoTbjhO4SqgFhAIsv7KaB0Twdq6u4w77R+8zGEIr5G7e1XtkaYZThP0dblgcKwU/QydPtY+xp8k06s16YGp00ee9iHGsT76okn3zASrUg1LFaHmpnMvkMWTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(31686004)(66899021)(6486002)(478600001)(6666004)(110136005)(2616005)(83380400001)(36756003)(86362001)(31696002)(2906002)(6506007)(26005)(53546011)(186003)(6512007)(38100700002)(82960400001)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(5660300002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE90WkYvMU13RXhVTzUxQ3BUekUwWDR0NE1kZ0REdUlXOHNIWTdlQWRRNXNp?=
 =?utf-8?B?VUtUQnVXNStRWmw4TUUyT29TSVptNHRxK09vRHRtVnVwa0s3YUFKbDVLOVdD?=
 =?utf-8?B?MlAwN1VDMmpORjlid1NGTFhPMWVYRXRVK0ZXL3dzOGsyNG9uVTRCc0ZDeGht?=
 =?utf-8?B?NG9oNG9iSktGWUYyMVlOL012S2VsQkZZSXh4ZFUvdDFiTnZBOEIxdkpaTzRB?=
 =?utf-8?B?dGowODVMcnoyYTZ6ek4rVU9IckZrSVp5cDFqSjFGVGR0RG0rZFJRM0JEek1W?=
 =?utf-8?B?RWpWVVZaVDVpc05BSW91OXF6S1Z2UmtLc1dZY2R0VlFhL0JqS3JVWG5EUXdk?=
 =?utf-8?B?Slh2NHp4WXlYSUxWS0l2ZmN3RE93dTZQOEdob0RuVzdSS2I3dDdvREFmQzBX?=
 =?utf-8?B?T0hCdnMzQTlCSVJaSVdMSSszOFVPRGRMYXc4SDRqWVJZcjlOUXVWVHd0SVRo?=
 =?utf-8?B?VDhXY09kbVErdldWRm5pQ253TU5vejNocEVVdU5ydE1MVzFkbVNVYUtETmJt?=
 =?utf-8?B?TE9wL0JIZTd6Vy9qbkU0YzNtWEdJUEFGTGtobG85ajMweE5sZTNrTkU4N1Rk?=
 =?utf-8?B?d1QwRTEwK0l3UGk0MmRIZ1lQaml2dSsxRHYzTGJjTmp1MC8xVCtZcXBBcVFr?=
 =?utf-8?B?OWtETHY5enBqWnJYcjB1cENxQzRnL0wxemZUdCs3UkdMMndidEhGdGc1bXl1?=
 =?utf-8?B?dG5Fd3RPdXJYQ2RzNVZoMWhCeTNlVlFzMGdmWWhGTkp5ZENaaWM3TWp1VEJE?=
 =?utf-8?B?eXpnM1d2dVdldzIxa29QRGhlN3BlN1ZmWmYrMm9oUTh3b2RjbFFzMm9NSUhy?=
 =?utf-8?B?Z0RaeEtRZ3N5UlhZVXpIQU82RW84TlRKeFVIUzd6VDlITTQ1SHVjZFNYY092?=
 =?utf-8?B?b0lxRDdtb0k2UkdlN3JNNWRtdm5qNW1GQlorOWFiMER1cTR2NEs2SDllZlVl?=
 =?utf-8?B?QzFNbHpaVkpaTXRYa2wvRDJyN3V0b1hhR3piWGNIakdCMks5WHNsWjR6dGF5?=
 =?utf-8?B?clJ5Z09lZVhMSFFYeXdHYzlrd1hKU3RPZWU1anZiM1gwYjVjS2tVR09JS25D?=
 =?utf-8?B?SWdZQ2ZPQlU1dVJ6UUZKWHZCdnlrUDdNN2Z0b1BkWWV4RUt2Z0Z1ZlpEV2ZB?=
 =?utf-8?B?MmRvMVNHQnc2UHJGK1Nub1NOWkpmWlh3cUdLSUFoMUF4cTJiMnIxRXk5eHNK?=
 =?utf-8?B?TkpPMUVMSzJTL2p1eUhKVnRNT2o0RWFQdllkdVdDUXA1azdiNUxRbzVvNjFt?=
 =?utf-8?B?eDUxRTNaL2FadFBBZTFSSTZiUmswcHR4bi9mMERDYlkvL0cvenJ4UzVZZGhw?=
 =?utf-8?B?SVVaOTF5ajFyOTdpeWY4MHYyc2FsSEsvRmJqSlhLM0ZnUEd5QTBtbVB4UDdJ?=
 =?utf-8?B?d3lLMTRUTUVxMzlyL2xGQUVucEF4RGl3YUxJVXNUUzBENk90VVQvdTM2b2xp?=
 =?utf-8?B?L2JFVFUzemFUcm12Uk1Zd2p3TFBPaXdKb2xjRldRaVBRdnpMeGd0SzdkYmc5?=
 =?utf-8?B?Ry9RUTg2aEpXQldJcGNzTkRpd0ZVakNvd2lRRTA2WXRQR0VNcTJ1eG5uYnNt?=
 =?utf-8?B?RnFnVmJLWXE2bFhWdFE5QjNmazE2c3NnL0Nqd05GWGx3bW0yb0ZTbmh4cjY2?=
 =?utf-8?B?MUh0SFh2dFFiUUdUT214bmxyOVlMOG1WT0hjdU5oRVRPRTN3VTAwMEVFeEdx?=
 =?utf-8?B?THRtWGxYSk5YNjZQSW5iaFlTMEVsRy9zdnQxelREeEYvYysvREwzWDFRNjVq?=
 =?utf-8?B?VTB5R3BLTE5TSFZaby9lTVRuVXlSRGh2Zk5HYW5UT0ZsdTlCVEFsR3Z5ZmlG?=
 =?utf-8?B?WnlKYURQU05OSjJ0SlZJNldHelRrNEhRcHQrR01OMU8zQXdBSzBZd0U2dEt4?=
 =?utf-8?B?SEpmQzcvNERQL3BidlVvU21RbWhOMEVUVHRrMkwxR085eC9jUEMvSk9hb3o1?=
 =?utf-8?B?WUp1TllXT3JBdkswbWI2WXYxT29xZkxnU0wxK240V3poMy9PS1RwTzhjL2VN?=
 =?utf-8?B?V0JNN29vZVQwRXdwZnYyTWFzT05UKzNEalhjazFlckcwNmo4aDNZeDdzSWpY?=
 =?utf-8?B?cWgvWEp6MlZjMHlnN2RkZUdpU3BzODlwK1ZmanRIVTVOc2xwYmkySCtxeDBx?=
 =?utf-8?B?ZldVZGhwWjl5c2VKT2NPVGVUay85eEZmWjlJRFdUWmkvbHRRN3hzY1hnSFhm?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8c31c6-62b0-4df7-ece9-08db7f6d7e3e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 04:40:45.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04xV+TokRqOaQGACw4ynftWa3rW4zxlCzDmWa2HOV4Bp2Ew0Gssa/iTjDrNNBTRQlTXGm2Yk02NhkjvGi6BrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 12:35 PM, Yu Zhao wrote:
> On Fri, Jul 7, 2023 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Sat, Jul 08, 2023 at 11:52:23AM +0800, Yin, Fengwei wrote:
>>>> Oh, I agree, there are always going to be circumstances where we realise
>>>> we've made a bad decision and can't (easily) undo it.  Unless we have a
>>>> per-page pincount, and I Would Rather Not Do That.  But we should _try_
>>>> to do that because it's the right model -- that's what I meant by "Tell
>>>> me why I'm wrong"; what scenarios do we have where a user temporarilly
>>>> mlocks (or mprotects or ...) a range of memory, but wants that memory
>>>> to be aged in the LRU exactly the same way as the adjacent memory that
>>>> wasn't mprotected?
>>> for manpage of mlock():
>>>        mlock(),  mlock2(), and mlockall() lock part or all of the calling process's virtual address space into RAM, preventing that memory
>>>        from being paged to the swap area.
>>>
>>> So my understanding is it's OK to let the memory mlocked to be aged with
>>> the adjacent memory which is not mlocked. Just make sure they are not
>>> paged out to swap.
>>
>> Right, it doesn't break anything; it's just a similar problem to
>> internal fragmentation.  The pages of the folio which aren't mlocked
>> will also be locked in RAM and never paged out.
> 
> I don't think this is the case: since partially locking a
> non-pmd-mappable large folio is a nop, it remains on one of the
> evictable LRUs. The rmap walk by folio_referenced() should already be
> able to find the VMA and the PTEs mapping the unlocked portion. So the
> page reclaim should be able to correctly age the unlocked portion even
> though the folio contains a locked portion too. And when it tries to
> reclaim the entire folio, it first tries to split it into a list of
> base folios in shrink_folio_list(), and if that succeeds, it walks the
> rmap of each base folio on that list to unmap (not age). Unmapping
> doesn't have TTU_IGNORE_MLOCK, so it should correctly call
> mlock_vma_folio() on the locked base folios and bail out. And finally
> those locked base folios are put back to the unevictable list.
Yes. This is exact my understanding to this too. It's also why this
patchset keep large folio cross VMA boundary munlocked.


Regards
Yin, Fengwei

> 
>>> One question for implementation detail:
>>>   If the large folio cross VMA boundary can not be split, how do we
>>>   deal with this case? Retry in syscall till it's split successfully?
>>>   Or return error (and what ERRORS should we choose) to user space?
>>
>> I would be tempted to allocate memory & copy to the new mlocked VMA.
>> The old folio will go on the deferred_list and be split later, or its
>> valid parts will be written to swap and then it can be freed.
