Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4665974A25C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGFQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGFQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:40:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026C11BF3;
        Thu,  6 Jul 2023 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688661606; x=1720197606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l2JXdu4DMzb5jegOT5oh9dJJSoTvkjN9H8PyGD0aRRU=;
  b=i+pH524gBTufYlfw4ANzilJUrMagIcHFuuBV0vY2z9NiIl7+BWLNjOEj
   XY+e/HgfG0yglfMYST4BB/kP/BCQe6WryLLdvlKHrU0qIAE8Nkua/a7Gv
   9em/plHdRYFgynYD5eE7VqSnSEhajxDBF6BW+CQoGpV7/LCp416BE8Ooq
   smgRw/I5hcUMRV3Nhqr3IWbcPssc0SBiM9O+Uslh9u3+vqSSxUzW349Qn
   Lg+O4Llt3XF1SCS3bmbm5JNCgbl/nIqqJGDGo1XYm3A6p6uGLpeFahjqU
   Em4F8D2yRzu+77SMH6eR0+k+7Yttv+w9X8fQLWTB+s5oS/3BsK56UqRbS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361125730"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361125730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 09:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="966302044"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="966302044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2023 09:40:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:40:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 09:40:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 09:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAmeripzOVCRNUQ2EWdLo+hYWp1zXxQY/rmaOgfe762G6AU64Qx8lpswqw2y/BBw52ath4L9mqyXe64W2a+k//V32jx3ErTYny5cinBYsu4T/IXCguVcvOBnJ+VlGFhoWwMFFClQaUjygtwQnj65Q8Exz0iLoZrRueUHpKJ8D9OsUjXI4AHsOvY6QGUMcAVoT8e4+AB80AsWg6z1CEX9/Km0h9ctQ4Jsd8B5Omsz3Chs0NNSRNmlKhLhPVfQEjrl/GqimOepH/aeR+fWYq/hqpLVgdtA+b6yvD03MKiqtwUKojc5orPjUG1ODcvIeq0NT+XrZcjkhwY9IwPVT2+ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pA2AHiZLVsfV6N4wS0Rg6MUqpd9J5GH0lKK4gyAdOg=;
 b=bapUTw7DOUXYDoG4eFjfwb9rRZmZpH102zW2eBxgZO+tQWompucD5wmo6LOK92u/wZ4pCOxZUlJg1aGYPEwzV03F57+JRpV6v8vXyrEpqSzyYIl72SnhyCBDSDIYg/00KbH3ZwfP8OIbTJffFYURAqM9LyWdba91WEjSJWKwnaKGo6rP3qrjqv+sgCodERtuxELGLD5kw1Klo4UrnM10ZwNbVwxJwnQVATxzbhJVgaxB6bGeetXHna5IJOZsN3q63AWGOG7N34fusfS4EivsN5mjZu9hHJab7yD2LCe4ZRvvVl0IYkcDsUQ8pz3GyPBF6cAVJnGWW/3XjdYM2oyA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:40:02 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:40:02 +0000
Message-ID: <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
Date:   Thu, 6 Jul 2023 18:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0046.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cccf2b0-f16e-47af-3342-08db7e3fa4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLPqrvmOXEa/DPhhvpmsic0bg6rfgLGb3Ov1SNNaCY/rvi3hlT1cpaa6Vu8whmDchxqha/x8ZReSwE3GrrI/4ExdAP6aF55NDFkT7eJ4MemIO4rCOdSsa0Z4z8+yC5RvQjk8PXLlUZWPZ2LOcFR2AzSW91jzPfI4WXYRrnDuQJdG0ag+RXefv7ZqrJuS38bbtp3vM7OMOPKQ9agf2c4OO9vMPvIxsQDsnpEQBXt+r6S6jAtwcL/pa9iUo914yo8qf00gt/9zoGMCtTsuR8rcEAZnPUMdMMapsMYkUPSOvi9GQOY08IekIe8ZdKUPN7hycqoaMLaZ3dFNlTExGR3qrlhhE9H1NghLGfrMbJEjLN6KTn4IW6TFxm7SNIsZx+sdu0/apVLIG/wOqq4EwbA8ZEkqy2DhqyCvNeKp1YX9FNjwXivSijE1N+mMQHLlTcEY1rfqWgGl3NKgidBRpbO4Qrp/GnjArAZ7PG9+/BWwElD+jvajhFBKaxl+3MvVI3Z6qS+7LFzJjfukzgH7kGbyphbdBTrdyo6dz6Od99BpIgNl3ttBBjIXnpFjmvO2Bnxv/9iFqW/mfxItPYHu2Qu4hzwLbcOarWDkjmNUPMoSK5ZS1cwiq3Fg3uT+6iBasmeWtpKyohhHsS+e8mEm2RvAZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(31686004)(7416002)(86362001)(31696002)(5660300002)(2906002)(38100700002)(6512007)(186003)(83380400001)(6506007)(53546011)(26005)(6486002)(82960400001)(54906003)(66556008)(4326008)(6916009)(66476007)(66946007)(2616005)(316002)(6666004)(8676002)(478600001)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRvOTY5b01DSU91ampFK3pzcTl5SGg0aGlqRUxvam9abGFyNnYvRHptOHN4?=
 =?utf-8?B?eFZDbEpZWENnNkpoWHR4SHpRZzQ1TjRQL3owQ1haOFhvVzhzeWtreTllTzhR?=
 =?utf-8?B?MjNwRWZRbEd1SVl5WEVkRS9uSkwwMVRQWjRhT0VYU2hlQlRzbVVMNzIwT1ps?=
 =?utf-8?B?QVRGYisxVEdmQWYrZ0Y5bkZScXNHMkc4OHVYTDVLa0lBYmNmSnR5YzBIY1kz?=
 =?utf-8?B?ZzRtY1RMV2RMbXlMa01IRWdxWk80VjlmZHJpWERrWHNaM2NLeUtoUWhrYmdE?=
 =?utf-8?B?NUt1cTNjVGkwNXRuanM0VlAxSUg3S0ZXNHduYjdLdGovbVFqbnM0MWVGN3dD?=
 =?utf-8?B?WnlvWm9hZFd0TnU3ZTMySjRVZ2c4UU9VWUFtNGJrVk0wNzRPYVJJYmo3NFJU?=
 =?utf-8?B?NzY0bnJTb3pHN3F1dVllSmJ1NWc1N2JVNDAzWEpXblErRS9UQ2dpVE04aHU0?=
 =?utf-8?B?YlpFYStTMEpodmR3M3BtbWJqQ2FBTG9sNHVuMEZSeDJ5dVFPVEZQVFB6c0JC?=
 =?utf-8?B?T0dzaGRVTVMrY3l5dG9LbzVUTDlHdnVTUW1QWTBSeC9TdkJhSHRxaERsVVBJ?=
 =?utf-8?B?TXcwcHprNzAwcUdEeVdPQUE0YUtnN1BvKzFCREJaWDRuVXBRbVdLd3gxbXc4?=
 =?utf-8?B?TTV0KzBEY3RvZFlMMzU3MURad3Y4UzVjNWYwRXpGNkRiVW15Vm1IZFlmcm9F?=
 =?utf-8?B?RTEza3ZnWkNVclQxZzA4czJmQWdmOHc5WHUrT2lROVJSRS9TbkY3Q0N5YmRG?=
 =?utf-8?B?eW44ZjZMbk1IcVJGL1B2MTA3dWx2cUJJNWFEeVBQSHZ3MWx1TnNoUEUrYXhT?=
 =?utf-8?B?cFdaMGpKSk9zL25KQlVjeEVNaHUzSnoyK0NSRWVqd1ZEQmFheW4wcXpSdkZH?=
 =?utf-8?B?UzdYS21pcUdxTGJCakpiMUN4TEx0V3ZMRGpYME9FeGF4OHFDWnc5NmNROE5Z?=
 =?utf-8?B?Ymt6aTRIMnpLOTBaUDlnb29lM1I4elpxWFh4STBZUEg0NFJyazFXbk5VcFpK?=
 =?utf-8?B?QWZOMmZtV1BzRE1jUVh4SXhzSXdqZlhMWEJ5bVE4WFJCUGkreGVSK093Q1RJ?=
 =?utf-8?B?enBLem16NHZJS0FFMDBJUHpmVDBZZUZDQkhsbC9RRE1VVjRybEpWZHVzdXVX?=
 =?utf-8?B?VnhRaG9rc0dOS3pxREIycUpGVjRhWTVwVGt3WHdVbm9HRmxYVitudHpNeDBa?=
 =?utf-8?B?UFhmaEdDcVVPbFhHajBzaXVKVldla1g4dXJyaXdlSWpMdDMydXpQV2FNR2c4?=
 =?utf-8?B?UlYwV0pPVFZibGVpam5ZYWprN2oyOGtEbHFneDhIeDQ2c1B5R2FOSGhuOGpU?=
 =?utf-8?B?ak5KMkU3OGlQUjArYkhGZkZSUE1nZXVRT0JCa3dYTDhTNDNDL2ttdEZIc3A4?=
 =?utf-8?B?RmhWTGpQMEhSenY5Q1ZXQ0N4MkNYMVJzV09MS2ZWaGZTdjhYdjdENTBJdG5H?=
 =?utf-8?B?MUwyVXhsb2tVdW9idGR3YmRFWWVQVFhRYmRCcWxoSC9Yb01FcmdMWmIySEFY?=
 =?utf-8?B?clU5UmtYczU0bjVjTWJPcHZycnlJd2xCZnQ5RU9QTTR5SkExRTgrNERnS2Iz?=
 =?utf-8?B?WVllRHZZVENYUkpzNWNFajJNZWpNc1BUOUpoNENuNVFMbE9CVmY1aWNYZmcy?=
 =?utf-8?B?UkZlK0lsYjVYb0Z3Qmtna3VLUVJFNTN2aHRRMTFDaHhYVHp0bnFSRWFvcUNK?=
 =?utf-8?B?cWV6T00xUWFLWmRlaExhRlZqMlVEdzNPdTFhOWJvenRPQ2tFb3hOeTdnbnhj?=
 =?utf-8?B?Zjk1OWFmTWxJcFN4K0xNTHR5b3k0THR1Z1pLUEFUZTV1bVpRVDNsNDdZSFdV?=
 =?utf-8?B?R0dsV0VNOE94NEhyL3lvU2NLQkZnbm1udnZxYmNydTZ0NHNXbktRS1pPZERi?=
 =?utf-8?B?ejdGN3B4VytzY2tGaFN3eXM4Q0crQitSL1R3R0lUL3gyMjZicFl3OTk0VmNO?=
 =?utf-8?B?ZURiVTYzVlMwZ1RVcnRlWXNiQXhoZlZJM0c1K0hqUDV2cklZanlac2x4UTd4?=
 =?utf-8?B?ZS8zTllrVkJSeE90TFphVlhnZDNkd056aWVuRkVBbm5ESFFiTnd1VEhDMDBU?=
 =?utf-8?B?ZjhaQ09lR1BHSWVnUjUyTGk1NXhaTkpiSWtuUHNFUHQwcEpxZWJxVVNkZmxM?=
 =?utf-8?B?TUl6ZG1kcmQyTmFxaWt6ZTR2elZtZFBWNTBTVm4yS2psdW8zSk43RVJ2VnBo?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cccf2b0-f16e-47af-3342-08db7e3fa4f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:40:02.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9hEgFbV8tv3sHyOXzoLjV9USoUhjIucmAaI+GLKt0zoTLG9ixt+eF0DUJxIYOOoUcbYlw3De5gyfnuMGUtjLsKjdobtzZZop0NDJYZTcow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 6 Jul 2023 20:47:22 +0800

> On 2023/7/5 23:55, Alexander Lobakin wrote:
>> Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
>> no custom recycling logics, it can easily be switched to using Page
>> Pool / libie API instead.
>> This allows to removing the whole dancing around headroom, HW buffer
>> size, and page order. All DMA-for-device is now done in the PP core,
>> for-CPU -- in the libie helper.
>> Use skb_mark_for_recycle() to bring back the recycling and restore the
>> performance. Speaking of performance: on par with the baseline and
>> faster with the PP optimization series applied. But the memory usage for
>> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
>> every second descriptor.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
> 
> ...
> 
>> @@ -2562,11 +2541,7 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
>>  
>>  	netdev->netdev_ops = &iavf_netdev_ops;
>>  	iavf_set_ethtool_ops(netdev);
>> -	netdev->watchdog_timeo = 5 * HZ;
> 
> This seems like a unrelated change here?

Sorta. Default timeout is 5 seconds already, so I removed this
redundance. But I expected someone to spot this, so I'm perfectly fine
with not doing this [and stop doing such things in general].

> 
>> -
>> -	/* MTU range: 68 - 9710 */
>> -	netdev->min_mtu = ETH_MIN_MTU;
>> -	netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
>> +	netdev->max_mtu = LIBIE_MAX_MTU;
>>  
> 
> ...
> 
>>  /**
>> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>>   **/
>>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>>  {
>> -	struct device *dev = rx_ring->dev;
>> -	int bi_size;
>> +	struct page_pool *pool;
>> +
>> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
>> +					 rx_ring->count);
> 
> If a page is able to be spilt between more than one desc, perhaps the
> prt_ring size does not need to be as big as rx_ring->count.

But we doesn't know in advance, right? Esp. given that it's hidden in
the lib. But anyway, you can only assume that in regular cases if you
always allocate frags of the same size, PP will split pages when 2+
frags can fit there or return the whole page otherwise, but who knows
what might happen.
BTW, with recent recycling optimization, most of recycling is done
directly through cache, not ptr_ring. So I'd even say it's safe to start
creating smaller ptr_rings in the drivers.

> 
>> +	if (IS_ERR(pool))
>> +		return PTR_ERR(pool);
>> +
>> +	rx_ring->pp = pool;

[...]

>>  	/* build an skb around the page buffer */
>> -	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
>> -	if (unlikely(!skb))
>> +	skb = napi_build_skb(va, rx_buffer->truesize);
>> +	if (unlikely(!skb)) {
>> +		page_pool_put_page(page->pp, page, size, true);
> 
> Isn't it more correct to call page_pool_put_full_page() here?
> as we do not know which frag is used for the rx_buffer, and depend
> on the last released frag to do the syncing, maybe I should mention
> that in Documentation/networking/page_pool.rst.

Ooof, maybe. My first try with PP frags. So when we use frags, we always
must use _full_page() / p.max_len instead of the actual frame size?

> 
>>  		return NULL;
>> +	}
> 
> ...
> 
>>  struct iavf_queue_stats {
>>  	u64 packets;
>>  	u64 bytes;
>> @@ -311,16 +243,19 @@ enum iavf_ring_state_t {
>>  struct iavf_ring {
>>  	struct iavf_ring *next;		/* pointer to next ring in q_vector */
>>  	void *desc;			/* Descriptor ring memory */
>> -	struct device *dev;		/* Used for DMA mapping */
>> +	union {
>> +		struct page_pool *pp;	/* Used on Rx for buffer management */
>> +		struct device *dev;	/* Used on Tx for DMA mapping */
>> +	};
>>  	struct net_device *netdev;	/* netdev ring maps to */
>>  	union {
>> +		struct libie_rx_buffer *rx_bi;
>>  		struct iavf_tx_buffer *tx_bi;
>> -		struct iavf_rx_buffer *rx_bi;
>>  	};
>>  	DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
>> +	u8 __iomem *tail;
> 
> Is there a reason to move it here?

Oops, seems like it's a leftover. There is reason: removing hole in the
structure, but it needs to be done right when I change its layout. In
this commit I just alter unions with no actual layout changes. Will fix.

> 
>>  	u16 queue_index;		/* Queue number of ring */
>>  	u8 dcb_tc;			/* Traffic class of ring */
>> -	u8 __iomem *tail;
>>  
> 

Thanks,
Olek
