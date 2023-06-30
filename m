Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D26743C09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjF3Mjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjF3Mjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:39:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F91B4;
        Fri, 30 Jun 2023 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688128790; x=1719664790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPS9YYzxaThZERRS6ro2TLYluNr0xa2RsBlwCpJv2P4=;
  b=Wi5vUeLJ0MIypdWg9zXAJuFrBSQpOE7wTGm7yeqlBE9luPmEOVWCeBwx
   eNRvvGcePvllW3VKwjA8QIzUDbN9zWpDbWJRkGMrM0+8lFM7pcmuRlgUT
   4k7ZDLs+duKee0lU/TFlZbZ06LiKfLMytRw9Y9uRlfaVkM7MEV58Tysgk
   Ivz7HocY1Qi5GebNI4CzTuPJHEXcDnMA2lZj6WmrBjLCA9c8tKh/WY1YU
   csz7znfTzUYC9BXTTmCJ9htW6UNJn0AvRIH3etcQoAB4rrBkjR+D+xe53
   6oe7cSl5ZikITo1EvY9rgokoh7WPr3VigMWjZZvl40jm9ouvnPwSPjn/m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="426070665"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="426070665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="787711713"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="787711713"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2023 05:39:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 05:39:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 05:39:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 05:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmyucAfm1VI9NoeQZqKAWI0/65FUtK+9HvM8mwxW9YBdFzMn/nDi9/tn5O8ReOU8/KRa6h+4Y9yvn+maCBX1mXCY51NN+4ZapQWvADlmuzL2wbmTFmEX5nxxePvvYV1j5qOp5oWAnTvJ/mAZ+yNpEIj3mGja7XWdh00sLzFlUDP1e0as64GjaDIgE9okbHa09usU6Hx8GaDUjoDvCZP9BGUE1ajkTIfrQVt2i3uPqfbddNQhv/QxhBp7mEtI5k6DtBilXA+90Fg4sdBS3fv7kRLjF+0ohirK/8qmJDlCJ3jJuFh+mRphS43Ko6HJ6HpSytnOa5VjArr7OsgSXEN9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCU9DHlBkf10MyK/SGtkUk2LKLdDsgDSpdmlK77PIyI=;
 b=e6AYOsvXGI9BCWjSQ3hbD0r6cSCAQdoudPQ1uK2NaFV4oi65K8tsbGWbHuT8X7G3VSKro4MJp863qg0wvlGYtWq8bhYNmCkKMjjSVOqBGtz+5VRCmIwu0XRZ7yiBXNma3MArwT7K+ZVczWZptle5hMze7Naos4RbDMbt5Tw9scYMturfpLElJh0KZmrIU/9JZoIhKJ8ufV5vXa1rp2MYFvx8XY48uadVYj2EabiNaP4Il12FM/K/cTeoiuhIHMVVc/qQoUz7k7LSllkQ4sOX7XTE1cglXUw8jIusK1AvqMqqi+J1Sc+kUxM2x9VKZXDwwgxd/9cBFwJ0UD1XcQQOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 12:39:44 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 12:39:44 +0000
Message-ID: <6d79614b-1258-08be-1bd8-cb02ffd9dc6e@intel.com>
Date:   Fri, 30 Jun 2023 14:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next 1/4] net: skbuff: don't include
 <net/page_pool.h> to <linux/skbuff.h>
Content-Language: en-US
To:     Alexander H Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-2-aleksander.lobakin@intel.com>
 <b7dda3fe88bb3d302b1cbb2016387d5e98e2f946.camel@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <b7dda3fe88bb3d302b1cbb2016387d5e98e2f946.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM6PR11MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ad393e-8c04-4c80-0f96-08db796714f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8OMAG19A23iUB5onq0qEXgfe3y6xrwIqwHQ/UvptIIJZ7Hk6iSI5+nyBTBjiNDC/ou4e9MfEN4B+2eYBaoGsWucr9nhrDUUqBnwQXWSLOE8e4uouYd1desOYQvbMc49x98PcpPTTS1scMIRaecete+qd3JIvdaaw45rYnp8FgMhMgFgXGpq4Mc4bRLPjC9Y4ipu7Huhvh3ZzLsEgxqdT8/r83CeVEDYQykuiygra914hKpkTRw2eE3jEeGpQqX1eCCIkE1MXigDxCYIxxjRKfsdOM7pQHR/XO/1D7hc3ze9erSY63lkkTOxcVjA4ujcX2FetE8SJEQLS/xoyzOb7VQCZaBmGq/ydE/9Hp8VcCUYJBEySHyioAMBsjAG8NRlbU4PkwKcmOcIg9ou8iIqZLUKS3ba7wcpkNDfnP3XXwY0v9VlHs8Z9yw1hFwSc+6nPoN8wgRNr5kozEdkV9hS/e2sOdm1unP6/bUzhbKgbYhgQ3BQEB668PiUgt8Y86mbiwLbQk8hMh+qofpSfJwx7oxOR8uC+CSOiCtOCmk3egP3pN1z0VwYlKSOXa/Y+xgqghv1cPj6VGc2PtopMm9rsQWDBIkAfeE/YKvIjg5l7L6vce2BfEk7Ta3+fo/Fls3OQ/BMzXTpz8ygngDlgmQWzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(66946007)(83380400001)(2906002)(186003)(2616005)(316002)(6916009)(54906003)(6666004)(66476007)(66556008)(4326008)(478600001)(6512007)(26005)(7416002)(5660300002)(8936002)(6506007)(6486002)(8676002)(41300700001)(38100700002)(82960400001)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5DeXZxR09jZEREWGw2clRsYmsxeXAza09McnF4WThvMHQvT3RKVE11Vzho?=
 =?utf-8?B?bE9EMHFsS3VCd3loekh1ZnJ2OXZxK0dVOG9naEpGTXZ6WjFUWlB4RlRhQlli?=
 =?utf-8?B?Q1k1Zmt1NHBGenluRDlMRDh2REFBNFZRVEFXaFNSYXN0NHBFODZGSHJvaVNl?=
 =?utf-8?B?N1JTMHErTFdIRE1qRS93b1E3M0psQ1kyLzIzRmdxVUlMVTZacE5YZmZ0SDVF?=
 =?utf-8?B?S0x0UHR0cnF3VEhkdFQ5SGVBMlY5eTVvQ0pNeGFzTEI5dzQwQkxJeXdkTDRp?=
 =?utf-8?B?d2NHdWRYZm10NnowZmtheTdiSkVuSnpvMXl4YnFsV1ZjdDNucEI3aW1jcmIy?=
 =?utf-8?B?NG16VHVmMExnaW5wbmp4SU5HbjNSa29QOFhpbVdqNTRYbEtrUkN6UGoxV0Vt?=
 =?utf-8?B?Vks5ZGtSNjZabCs3T1RzVFllUHBsL2NUeVJLQ1dabTViNXJjV0x2TkFCNVNG?=
 =?utf-8?B?VW00UGl1NWNuRDRNWVJvUjV2cmpOb1NlMTdHeUs1SGlIUzVJQlA2eDM5Yzdh?=
 =?utf-8?B?Q09aSHF2TUN4R01TS2xORTI2cERMSUNNaTVOSlhSV2ZVOGZNb0JPUmFjUTFC?=
 =?utf-8?B?cEE0SXpwVTMxSndrMUdsNzdid3JHRGRVT08zZlUvMGx0cFRCZWRnWkpaR05P?=
 =?utf-8?B?Rk5ERk1yK1BBMmhscUszREt6SDJwZlA5dmgzRjdYbm0xVFdHRmQ4ODZkS2gz?=
 =?utf-8?B?M3FhWkVIWUtCQ1kwUUhDemVleG1ObCtYd1hGcFRidkRRZ3daVUZiTm40amJs?=
 =?utf-8?B?Rkc1ZTBENEZaMFRra1kwWWUvK3o4MFNPR2RSYmNQRmVsaVhHNCtPRE8vWE5Z?=
 =?utf-8?B?QXU2Uk9Lcy9VSEV5bUFCeFpQUG03NWhESnNMQUpOOWp0bm1lWDFxbktZZWtx?=
 =?utf-8?B?RGVmWG1lcGI0WVJ6cGx1Zkl3MjhXTHZJZURTRjYzVnpLZXp6QStLN1RvL0pk?=
 =?utf-8?B?bjE2SGpabmxndTlScEFVMy95Q2lnb3hQRm9ETTFjMTN2NHh4a3lLd1pHWW55?=
 =?utf-8?B?dXBJYWFnSFloTHp5Q1JINktOL2srM0lTOHVxYnk4c3N3TlAxZ1ZUaWdNWlF6?=
 =?utf-8?B?OGJZa1QwTDcwald1dEFXaU10NWVTam9vd1RlME1LbWRtSmdlMFpUS0R0a211?=
 =?utf-8?B?ZTdxMmVIa3RDM3FaWk1IYUt2RndocEdLZmhCLzZiWnBUNFJxeU9KRzJpTmhL?=
 =?utf-8?B?bkxQSWZuNXREbmVCZEsxMnBvTEFSRzg2THRMTjVYWDlhZ09qUXo2SWNpWXVX?=
 =?utf-8?B?c2J3SlVBbnlpMytZMmpOVWFONkg0T1drVm8yNlU5UjN4ZzhteDZkZTFKc1hm?=
 =?utf-8?B?eVcwQmZ5S1Q2Z2NtWWFtZ3Y0emhvSUdiQUttazJveDAyQlE0eldrWFIvbEp1?=
 =?utf-8?B?UzZIYWUxcHNKcXk3QXdOcmt4dnRHOHRQL0dEVWdPanA3MTBxVDgzemVDSDA4?=
 =?utf-8?B?elFMQVJGcGdDSHNuRFFMdGFoYnJVdE12d2pFU2g1OUZoNTFMcTVGNDdDeFNJ?=
 =?utf-8?B?OWZ3ZVJERngrcURIamg1T2ZNaTJqNXU1Tkx5K1pJZHU4UWRlRGhmL3JIclVB?=
 =?utf-8?B?Y1dsdmJVWnRmRmdMRmpOVjUrMVU0TVhiclpkdWVpdWQyTExFMWRucVVWWndE?=
 =?utf-8?B?YlZQdkJndlY4a0t4U1dvWkorSWRvTFJwVGxiSWo0TjViWGRzUjVyWnNSN2hH?=
 =?utf-8?B?UFB3WlQ3WmlneXlHZlN3MGF5aUhkcVZKRlZpY3ZrWUNXUVVmczlYSEZaSkJD?=
 =?utf-8?B?b1o5ajJxTTlMUFVib2l6RksxYkFUdWhhYVFGUmRPNnNvOS93TDZpUGpjSlRG?=
 =?utf-8?B?RVRreG1nR0hJWmRpa29nNGw4d2UzMUNvM3lNd2pxVHNnc2NKZDkyKzcyV2Iy?=
 =?utf-8?B?SFBubFRyRDNSMGlPUFdHUEVkMzQ5ckExNkhLZ2xZVE9FRUdUUDhxZDRORW5k?=
 =?utf-8?B?SSsxbWY5MUdjNkRaKytqdi8yd2RUbklDNEROM3RTRmdvTEU1a2thOFdBcmRi?=
 =?utf-8?B?c0xXT05mQ1F5SUhqTWJOMWlscTV1cmVSeG5ieXJ1b1dkeDlMYWk5dGcvTjFP?=
 =?utf-8?B?WnhDTTU1K3RyaEFCUFNBZWg2WVlsUFpMSm5FcE16OGY5TWpRc013NmRTTnVT?=
 =?utf-8?B?RThKQmdGVi9NMzQ1SFplS3ZndnhIWTZ6Tzg2YTlnUHhtV1lIQ3VzVFo3RkQr?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ad393e-8c04-4c80-0f96-08db796714f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:39:44.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPz7i05A8B4A0veBhlMbuQhagSxS6KOufZAbltns0sV/mWkRwaJXxQhLgnZQYMSrB8pY6VE/kZqF50b5rzneZWVVaNT8JHNxUE3tCDcovDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547
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

From: Alexander H Duyck <alexander.duyck@gmail.com>
Date: Thu, 29 Jun 2023 09:55:15 -0700

> On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
>> Currently, touching <net/page_pool.h> triggers a rebuild of more than
>> a half of the kernel. That's because it's included in <linux/skbuff.h>.
>> And each new include to page_pool.h adds more [useless] data for the
>> toolchain to process per each source file from that pile.

[...]

>> +bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>> +{
>> +	struct napi_struct *napi;
>> +	struct page_pool *pp;
>> +	bool allow_direct;
>> +
>> +	page = compound_head(page);
>> +	pp = page->pp;
> 
> So this is just assuming that any page we pass thru is a page pool
> page. The problem is there may be some other pointer stored here that
> could cause issues.

But that is exactly what you suggested in the previous revision's
thread... Hey! :D

"I suspect we could look at pulling parts of it out as well. The
pp_magic check should always be succeeding unless we have pages getting
routed the wrong way somewhere. So maybe we should look at pulling it
out and moving it to another part of the path such as
__page_pool_put_page() and making it a bit more visible to catch those
cases".

Anyway, since some drivers still mix PP pages with non-PP ones (mt76
IIRC, maybe more), I feel the check for magic is still relevant. I just
believed you and forgot about that T.T

> 
> I would suggest creating an accessor as mentioned above to verify it is
> a page pool page before you access page->pp.
> 
>> +
>> +	/* Allow direct recycle if we have reasons to believe that we are
[...]

Thanks,
Olek
