Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF218745DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGCNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGCNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:52:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE20114;
        Mon,  3 Jul 2023 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688392322; x=1719928322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fFuZoS7HGG+aS4Yboi793g9kSdDcevtA4isGOwdO7bM=;
  b=RzVx73j5b3OVZYJLjaSJnxxfh4qn3dJ2+EPswJN4QTAez87oueiOzU2f
   oNMrBQKU5kXOi7YDyYqXqSX6ieykDnMiAteQMmmlNpqJXLStG1802WjrQ
   ItE/YZQtlchYX6VPjecV/XvFLhbzDgBwO9y7r1h9kUEVvyzHhF6KLGSaU
   dCAEL81P4tPWphR3tM1v2L3mo9PDDu8ycm3dpWxJ71YYeegii6X8eK68R
   fvqV49A8BF0ItKvJab2RcESfAKbgudCE90DZS1oxx+aDsw2vsgE15kF7i
   BUVAC/H5OxU5WalvvEUyWtbRxr0j3qPoxAwJox63LZ5ZNdqWn0pXlqdzH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352712470"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="352712470"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="842675392"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="842675392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2023 06:52:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 06:52:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 06:52:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 06:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2JzTLRb0MF/y0lTNnu165W6K7vMiZ2fMBpweUKCkSBgFS8G4GtxsvIM+tGBNgoI+nzzT4AvRXlO5glnyIzQ/TyV1Qej606Kzv4y2pe4tbXcSOCnJbvyXjJlBmpATnxfZB3usltqtEp7RVVNbmW/zjAGjjeFrSXoBCYjqF6xPMmqBIuWOyV2NfRpgZXloccVLPbK57dqjnCRkdoUueUZJB4EY7KVkt54zhEnB2TUxreQi6M+lil09HjkMvLVzDv9IYKco6tUaEYEVxoqtCFEBGcLEVJv74QQg7lEJk5N9Hs48p8Dq7f7n3mTrnwrE3p0+wK2qROnAQTqdu0A1zq7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tya9jzJIgoHhtbT07L5Kz5OkqsHm3JGyqN0wWpYj6i0=;
 b=YuADu4irCajCG/uDZ/dDmncErf6v5pohca/0vqCG68/qTAQDlnS43zcjUT17ZqoCgr/Yw95SmR41My3iMa8MZoznf21taXQwmwlyNdrboZ/edKc5Aj3y4fIMHdMI4CJTzUAzMuF+P75mLkIbqewSft97Mf57NG7aNqhXKwXjyg4p/IlPhb8pEii3/Lm3mFP0tD8Xa0CmLnTo/o8W5D+nz+ZPyEeyj3jzCA2Ioi2TMHsZ4lE3DQXz3nLW+5InR0O0V6Yr1ohSsl/EcN8wkD2dS2mFiEtUA+M8+APv+xc9XmoEBvhzTsnBAzy5JRmeRxIECs7hlWIUa5865iNpMdJmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:51:58 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:51:58 +0000
Message-ID: <72658bca-c2b2-b3cb-64a0-35540b247a11@intel.com>
Date:   Mon, 3 Jul 2023 15:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next 0/4] net: page_pool: a couple assorted
 optimizations
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230701170155.6f72e4b8@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230701170155.6f72e4b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a2d7f8-b056-4054-e15b-08db7bccaada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8SYkG5xIf0XWB0n+GBl3nE0NQu3JDGyIdrlwjO6qHhc2ikh/FifZcGuNhv0jlh/3ocnI1+cEDv+1UmC/Dsn+6qxNBPVCiLdIe0CUO714EWR+O+rsf1uXWY8avza/uTynL0n7SNwD4ls7NdO+VZrpx/7vTencFYmEiBIbJlG4mStxrDM1fpi70iiO11H64XQ98L8Zfm7ZRBbGCwmF9J4b5+jqIedd6iMxdHUBPIFNgu/QeZJ7Iz9TyxLPd0AU2Ez8xYAk9eVmTbX5BHYpe62ADNpoDBVMKvvzpLx2tr/0WHxBViLADj+Y2TSsvFKH063vY3Q6zEHVfxM0twOm6XA4cBvb76dBErlAPy7F+rdkITULoKNb5s/FozD4c57LmV9PPzkYr6Dmk4wj/TCEl2WIgvsT+EaGQNQC9MbTBxzRrjgp65nPTdFfiJ647Jkezvujk8FyqHFK4bdCc/Z4ZaNhiqDuMNz1dURCSbi/n8N5yVnPJrbNYurKYxmjDhOacfXwrnetJzAiNvrVV9NjfL/n7OEk+xmfof8Rle+ppCwXsWvJZaLekfqDH9yjW+/mb5v63TSMwxZAicb2/DKWpvrTUDUCc4CqCx6Th0X4uPv08tn0fEhH+NvDVd+Xbdmt+9M24GnVK2toqja8lfrbuIe/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39850400004)(451199021)(8936002)(8676002)(54906003)(478600001)(26005)(6666004)(41300700001)(36756003)(6486002)(2906002)(31696002)(7416002)(5660300002)(31686004)(86362001)(316002)(6512007)(66556008)(66476007)(4326008)(38100700002)(6916009)(66946007)(6506007)(82960400001)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2w5S1A4M0FBbVJvK3g2WThtUG5qRU5tdkR0TnFYbDlFREJUcmcrNDJtSkxN?=
 =?utf-8?B?QVEzaXFmOGtCcXh1QzJQMmNEbUJHMk5DN0N0ZFoyZ1hjOW9PTXBqajg2NEIr?=
 =?utf-8?B?a2VXd2pMMTJDMnQyMGFqUE9sdStWWUdwOVZoa0RVK1ZDK0NkVVFzeXd4TFVh?=
 =?utf-8?B?dC9kbFBOb0V5aFpaMk41MXNSQ1N4enNxYnJWSU03NExML3BpWVVHcWI0bnl4?=
 =?utf-8?B?NVNYb0tEbjBVVlA0aEhFNWZvcnliNEgxVEl6bStab0F5SHovRUZzOHg1N2xY?=
 =?utf-8?B?djVGTnFrcVlhME1TVEFBMGJJc1hub0tUM3lNZHFhZjZnSFY4NlJuKzdDdmty?=
 =?utf-8?B?RS9ENCs3TUttZFBSOHlqTFhUd2hZZEtwNHNqNGVMOWg2TGhxNG56U3Y5MVlm?=
 =?utf-8?B?dmtLeERyTEJaZ2g5OWJzZnd1OENiVCtsN0daM2k1TXVBNW1BVFZzRWlYbnNQ?=
 =?utf-8?B?emNPZmF1Mk55UXQycVNKZVpjSG1BeSt0clAzNFRVM3dHRGxpZzdSWnVBdElU?=
 =?utf-8?B?UnE2ckVicWtFVUdxTk9UTUlpNk5NRTVyeW9xVDZvZm9zSGk4dlRVNjhnSUZY?=
 =?utf-8?B?QXZLVURJSm1PVVFIbkdNdW5IUEVNYXdUY21WNWFuUzRQV2wwRFpvQlo4YThi?=
 =?utf-8?B?SzR1QkVHRjVCOUZMaHJycXIrWUxVTDhPWXNSanFabHNtd2V2bGRRWXVkNzgz?=
 =?utf-8?B?a2tiVHE2Z2NYdU80dXhRUTVpTGxOclZZc3RwYkg0eFpYME1NQmQyam5xQWpj?=
 =?utf-8?B?bjlCQ2lwNUNLdC9vMGFMcXFkTXcraGUzTWt6aUFub3UzcW96ZHkvZUFDZ1NH?=
 =?utf-8?B?V0xTL3ZjQjBTSHlodm5UNzNsS3RQUU1uS1hWK1VwZzdHbk0yemYzOFc3djd0?=
 =?utf-8?B?U09MejMyR1N3R3dXRVNOK1JHN2w2NExVQzN1VUFpbnVBeldtTE9pdTdYajJH?=
 =?utf-8?B?dHBtVzRHTFhXNU91Zm53N0FJL1JyVjQxQUkxZXJmT1BSVElQWVFycWlySnU5?=
 =?utf-8?B?UVhXdlU2NVg0L1RiZnZMay9xWkZNU1pKTlR1UFcvd3EveHJPNFh3S3hucjF3?=
 =?utf-8?B?QmYybTJUeU9RdWNGb3BadXhQa205SnoyakhkM3FUSHlteTdCdWNOMnA0aXg5?=
 =?utf-8?B?SjdSMGFMOW9CT1RHTzlJUkRMZ0d6RjcxZWxjdHZzektBaXh3ckEyaVppWHE0?=
 =?utf-8?B?RkE3Y05XMEJsd3ZaZ0Q3Si9pa2NUNlkxV1BPQUhQQjNXSERBQzEzb2Vlb1JQ?=
 =?utf-8?B?SHBHcDFVRmdndGJjVndCWGowOVNRRkFiQXo1UnhCRDNHS3NQdVVtVlIrVDRX?=
 =?utf-8?B?NmlKcDFlVXZhb082elJFYXhmZWFUUnZ5MkM3RlI5ZzRRbG9tVUFpRjBmMko4?=
 =?utf-8?B?U1dEOXFHb3FIOW9Ob2o4M3lPc0g1NDJlenBRTkgyMWZCTlpiaTh3UXkyT2xE?=
 =?utf-8?B?TUY0bnNOSlYvcVlKSVNmcnp6cksvTFgzQm9Mc1JjbmZPbUJFK2dsbWhLeVJN?=
 =?utf-8?B?WFdDZ0RUUndYajFXRXhwdC9la2xkMSsycStGbzNqRmY1T2UzUlFqdHpKbmlv?=
 =?utf-8?B?NlpVSTVKVWxUN0xzRnFSUHdQeWVBTkhISHh4R1ZsYmxpM2FVLzY3SHcxNUgv?=
 =?utf-8?B?VzVYSEcwdFlTUm41cDgyMExXWWJpNUM3cGlqb1lqZFBuU3lvRHJTWWpZY0cz?=
 =?utf-8?B?cGRwZmZvdjE0K094Qk1jbWRMVmNVUWlwQXpTRlczcmp6RG5PNGkvM3NlaGhW?=
 =?utf-8?B?VGFrbVVUS3I3cHdiZmZod3psd3l0WFdtMS9CWFhWNVI1YkVNZ2YzWmVVZ0I4?=
 =?utf-8?B?SFNFbzZadmNoQkN3N25zTFVNODZOUG16TDU2Qmh4ZFBFSlhPL1pvdDZmU3Nt?=
 =?utf-8?B?YTZRSkRvdDZLaUFDUDg2UHhWaDhWVkJEQjFhcVpjSTFwSlIrcHRDK2xqdm1h?=
 =?utf-8?B?OHVBMjNOSjd5aDRDdWoyR3cxNHFTcXhibnR6SVlxYjFKUzRycVhMMkNQc1B6?=
 =?utf-8?B?b0RsaUVxUlFEcjhvQ1p4aE85VmFEbzFnK3Fzc2FOYUo2K0VVS3FNa0VBM0VB?=
 =?utf-8?B?UDNjNE5kRWVvd2JoWU4rU3JickRXb0pKcVRNeElJbnF0T0xkb1RZSHVJUU5G?=
 =?utf-8?B?VndUOUlRNnpvRkZEcUljRk4zeFFnVlIwSWNJbnA3WmFpSzZnNUFkY3BMejR5?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a2d7f8-b056-4054-e15b-08db7bccaada
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:51:57.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV1KGoyzMlsNZ2K6E44AxFWo6fgt/7gt/jVsdMAMXKYeoCAURe2ZTMfwR4oZltJXplO+gDTqq6+ZFgxSlmvPR0gFxtf52qeRYF2GaVEi098=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 1 Jul 2023 17:01:55 -0700

> On Thu, 29 Jun 2023 17:23:01 +0200 Alexander Lobakin wrote:
>>  #3: new, prereq to #4. Add NAPI state flag, which would indicate
>>      napi->poll() is running right now, so that napi->list_owner would
>>      point to the CPU where it's being run, not just scheduled;
>>  #4: new. In addition to recycling skb PP pages directly when @napi_safe
>>      is set, check for the flag from #3, which will mean the same if
>>      ->list_owner is pointing to us. This allows to use direct recycling  
>>      anytime we're inside a NAPI polling loop or GRO stuff going right
>>      after it, covering way more cases than is right now.
> 
> You know NAPI pretty well so I'm worried I'm missing something.

I wouldn't say I know it well :D

> I don't think the new flag adds any value. NAPI does not have to 
> be running, you can drop patch 3 and use in_softirq() instead of 
> the new flag, AFAIU.

That's most likely true for the patch 4 case, but I wanted to add some
flag for wider usage.
For example, busy polling relies on whether ->poll() returned whole
budget to decide whether interrupts were reenabled to avoid possible
concurrent access, but I wouldn't say it's precise enough.
napi_complete_done() doesn't always return true.
OTOH, the new flag or, more precisely, flag + list_owner combo would
tell for sure.

> 
> The reason I did not do that is that I wasn't sure if there is no
> weird (netcons?) case where skb gets freed from an IRQ :(

Shouldn't they use dev_kfree_skb_any() or _irq()? Usage of plain
kfree_skb() is not allowed in the TH :s

Anyway, if the flag really makes no sense, I can replace it with
in_softirq(), it's my hobby to break weird drivers :D

Thanks,
Olek
