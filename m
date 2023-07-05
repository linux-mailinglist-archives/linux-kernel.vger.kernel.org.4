Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C49748431
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGEMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGEMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:32:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0C113;
        Wed,  5 Jul 2023 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688560359; x=1720096359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMMEifuj3nZHs1cam9JevVoCzxc0wawuSUGd5WHt3kA=;
  b=YsZTnPzcdLOAMOfvYN6Z8E/5wz/PRheS7Qhdxx5O6Xv/SIXt0vgNazP+
   aK1yAZbzEavb5Swu7OXIOB5BqBTdXzSriWJmO4WCrTWFFrTX6Q/ti90VO
   6G6eLvhvef3hJzLFS8Qt3IRCIjGTwVjpZAUZwJQk6QYrPJhNkPN4YeD/0
   oswGR1JfIfgft25CqGo8ovbbvZwm9Wp8Q2IaHc0tyyw7mfpIqBvqKctfl
   jeCNNEy90LM75weovZ8BGTBUaC9OaEbVAlcLrb1jx7lLRUMV1aEN5QqUE
   6ZaUibGq7cCWRaFu4JlziPQModbXz5bmY3KpvFSWhccyskFbaR94M19Gh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="343657933"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="343657933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 05:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754344116"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="754344116"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2023 05:32:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 05:32:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 05:32:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 05:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PddrkrifQ6rRHbKh6epy4XVNo2mDnjtJmycmirHjMcwqYVxUOSsdIC3QbVZNgWJajR48Ursb2dNECR7qrLUACc3IqteXPYUuZsyYC0LjOE1WK8sMlwRHAv0q8mQ9COacTaRz14he00DSMu56qc6MJ+aUb2+BjK4MDM7SEsEUekChvsBM4wXR3nm6MoYVSeZ+9AkChaV1fHUih60U3iGBtvofaazwRnprxxy2bp0XTuwGogdqcLubHH2dBguwDEE/Ll+ac1HnNiL7RYjZClA8tFTzixfpzB+XJDohjtCQ/lB9h4F50urHZOJY8UhnJReJme/t0qkHLN3f+SJn95Xdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYr/OLyZAModl4EB2Ymxp6rsYYJGUOVhJ2huI8ulZSY=;
 b=TlGuwEMjstsoRc1hJpljPJcxDbXi4qTd8QFzLNSwHn8LFehtsQ/SND4SVDy3+ryRJpO0yth1vn+pgReT/ojML0RhvET2Uz4ltMJ/wax/pegTyC2pY7/bDAhdhumLiE5T+ezDhBStW4mlzTs88bErCOU65IbNnewaCDCfds54SMEjb6dKIpY/qq+M54vtSN+6wM4sp1qVThS/4eoI808tATiSuNJnd0c4gzGJTm4xp1iKgQlj0d584zOSY4hdg8VBNnOQPhIj4AZCKZTuHgTmGCXlcKRwKYdK6DViwrmmKYlPbfbvSnVG8LgXWVuRLdeDbECAiDXKin9JZLt4EHtz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:32:35 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:32:34 +0000
Message-ID: <eb3ef477-cd42-7796-7297-ef10e74c994c@intel.com>
Date:   Wed, 5 Jul 2023 14:31:15 +0200
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
 <72658bca-c2b2-b3cb-64a0-35540b247a11@intel.com>
 <20230703115734.6ee8f658@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703115734.6ee8f658@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 244aa836-6cb7-4333-5d79-08db7d53e89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5w/FzsH1DXjMMXC507y3kbs+qhSJhOK6F4hkT6SuDRE+bGkom5kSNjUMFZoxC5Ob7ucN13fqIc/VPelDcNHySytg2/y3d/YRUwwcJVVIRdf0NnzE2LqYeWkEj2TDoxBqAfPyVP+Bf53MQxD3Bs3lYT4vPz8WGopk3dFUXGqTyMZMuvEBPEHtZiU3qPsOzaKRUsKXfeUQUgifep3CPp8Tj2qJcchA7FHAZ1rRrTzE2uNFgcScdLPAgJzmPy2oKAHkH4pcvM2JD+vancR5jnQeE1S3E0bqHn4rkFI9pysQjYRB4MlFhvKl+wpdYum7sEgaIQ3auISScx1OM3hpATcmlyRkh4F7DMA19eo3AacuBRh5yNkrGsnxmyRDDiuSfSvMIOg9O6Cs2pn2CniZB9BpKI2g0nCAk6Xejavqa1N8/yrtYRYNLNJytQKUFLEyt+qNU4or0jJQc8OSAOSWd/+yTGFkcqUmbOrnF0u2y3rKq0yNcyg7oRaHdh9U9eMSGfz86WG5Nc7uV18Um9SXbQxYhQpa4ML32KRSL+rYRE02b5/IkaeuAhXNz43d7v7M7GRhxGuA0rFEJmiFOocuIbQBXpejWJesm+a4s55tXCQ+S2FyImLKMiqpzXSvU7/4p4RPkecR7DGwQMt1DCB7k8Nmng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(82960400001)(54906003)(478600001)(6486002)(6666004)(41300700001)(8936002)(8676002)(6916009)(38100700002)(4326008)(66946007)(66556008)(66476007)(316002)(2616005)(186003)(6512007)(6506007)(26005)(31696002)(86362001)(7416002)(5660300002)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVBOMnY0azUrMUowbFoxajY0TXRBT2J5RlRPWHkzU2xZb3BDVXNIWmVROTRj?=
 =?utf-8?B?U1RlMENUeG4zUVRodWdqUXVwZi9ZK0Z6YVQyUjYzUlppcTl3NGR4R1ZkU3ho?=
 =?utf-8?B?N1Z4VWQ2cHhHempRN1NkQnVXdjAzSmxhMENuZDJRVkt3SGpvdDQ4NHVVa1E5?=
 =?utf-8?B?OXhVa1ozVkdwOXkwUzNNaktvNkgwOThsQWZKeUdYRFBIT1VSQjRpaWtLZllJ?=
 =?utf-8?B?ZnhQQUZycHdIcytyeWhiMDVRQW5qMytGbW9QODErNGtHZEJnUHVEYUI1SnlQ?=
 =?utf-8?B?QUlmUEFnWEtvVDRBSWdsOGVEQTNxNGtzWEJYVFdIb2ZRNmZxaW1wU0ZWQ0RK?=
 =?utf-8?B?RFNmd1hLNnNUTC91ZHpnWEhRS3NPdG1SYXdYV1loQVNoeSsrNjdCT3VHVHFt?=
 =?utf-8?B?M2cxYjFVUjNFSkFlSldQcjI0UE1FMFdCWG55ejU5eXJjMXhJOVgrcktSZTRi?=
 =?utf-8?B?dzVTWHBGekhML0ZVbEdZVUEra3hrN2ZuYVhVRE1GaHlnOGgvOTM2ZURESG1r?=
 =?utf-8?B?aENveTl6Z1hJVkhvU2wzaEllOW1FSzJxU1M1M1lVQzlpcVhOUTZ1RzJEeFc4?=
 =?utf-8?B?eEhaK2RuU1c1MDUxdHd4U0FNREhqcXQ5ejJXOUdYZzJlM1lDZTlXcno5aVcw?=
 =?utf-8?B?bHJBQ2xkdG1NdU5xSHhNWDVuOWZpTkNzMGswR0dlV0NmRFBkZ1BzUjZMTm81?=
 =?utf-8?B?Q3pxZU41NzVUVmJoT1lIWTRCUUZyQThXcHVCaHplOEk1M2h4NmJ3WUJhaGds?=
 =?utf-8?B?QU94Z2RUN2xzMDlCWUQvY0crRmkrV2t5bzIwclZDbUg1L2c3dk1yZmNUUS9Y?=
 =?utf-8?B?dENjTExlN3VjdkdKblBLZ3MxdG93eHZGWjJqR1RGb3BrZTA5dFVHREVyazdi?=
 =?utf-8?B?U08zSmxOWG5PWTIyZlJoeVNKVkI4SEZ2RXZrVzd3eU4yeVhFNlpvbjdPUE1Z?=
 =?utf-8?B?RFdzWjNFUlgzOW1hd0hnR3Nkc2lKcHJWbTNFSDVqaDdiTFd2VlVLay9yd0Vl?=
 =?utf-8?B?bTYrcjhxUFo5c08rSEVDVW1HV1pqVXFsdlZtZUU5ZkJUblBkM2JvUVBjeDJp?=
 =?utf-8?B?MUx3MzJucWsrTUtTeW10dGU0KzNMS0RBNXl3eWpqOHIrYVpKU0lBUTJyNkl3?=
 =?utf-8?B?VjlrYytNVzcwZ2VDZ0RoOEkzUElza2wwT1R0b2s3aDNmNnZMKzhQSVRLcFRr?=
 =?utf-8?B?ZHJKMUR3ZU5NTWdDT211V3g3eHMzREd6K2dXN05adzFmeFRGdm1iSmVSbTZF?=
 =?utf-8?B?R2x3ZFY3aXNvajRlV2o2bXdJS3dDYncxb2xPc3R3c0dWZUxXNnJiQXdwQjZN?=
 =?utf-8?B?bXFKSVdxc0w2Zmh1VEg1WU00ek9xc2VLbXhjUVdRZDZ2YXlqMlA2cjVRQTBT?=
 =?utf-8?B?dmwrVXdxWnU3d05vVE1QRzZIV1lwallRVkNTUi9haTE2VTBtS0hXM2g2cnZG?=
 =?utf-8?B?bEJzU1Jvc2JBZ29INUVEVzhWM3dXR0FJZEdwckhjY2RYV0MxQlZTWjhhdS9l?=
 =?utf-8?B?YUcrVXFYMDcwMVhRM21FUTFyZDlBdU5XSG0rcTRrR2RBSDlCQjg1bHZHdmNR?=
 =?utf-8?B?ajZmaGdmSkVlSWc3UUlGUitVQVQ3cHVDb3RZZStPQk9mdjZqL3ltQUZ6L1JC?=
 =?utf-8?B?Z2VLYXR1K2tUNWM0NWpnWWY1d0tLMkN0RCttNEFxT0pmUGxFY1JaMmVCV1dK?=
 =?utf-8?B?TlJJODQ2MVlYaGtQYnZOSjNSbXNwWU1lZFgxTzFwd2hlR01ORmI3VDlhTU1B?=
 =?utf-8?B?TnhZaEFUVHpDTFBDRkFIeVNDQU4xQmkwVWUvenVrOWxBOGt6dWtQVDF6Y2w1?=
 =?utf-8?B?eTA3YmNrVU5JS2V0NTBCWkZVbDBoQ21TWk12am5zTGtUUk1pT0trR04rZjh5?=
 =?utf-8?B?ZEJrV2V2KzBGS3Z2NSszUXZ1eHNBZXp5dmJtL0xjcnNtaHpQZzNkblpNWXBV?=
 =?utf-8?B?Um1KZHJBZ1FHc2p1TG1OWlZkaWxBQ1p3bmdGQTJjSjZtdFRJZlhteFgzNkFv?=
 =?utf-8?B?amZuSUpobDhCVE52aUttNTFnMUdkUUxKekZlK1kyTnVwMjZhOGJiQ0x4UkFE?=
 =?utf-8?B?WXhjbUNnaXF2RmJiRUoxOXdzSUNyQ0htVzV3Wk42dnpCbkhyUlRHWExqNFp6?=
 =?utf-8?B?NkllYmErcG43N2tUSEw1UExTelpPSno0dnAyNmNVSklRczQ0dklPUWJKVXBn?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 244aa836-6cb7-4333-5d79-08db7d53e89c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:32:34.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7GPNGM6GTzLPPS0JIcHk/B1PMGnaRGRokz6bX+s8WM50N/D2YowSA2Hso93F/fd7zx8huxheYqnCTbCxwQ7WVobbYLfs7jUfkEAGq0afvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
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

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 3 Jul 2023 11:57:34 -0700

> On Mon, 3 Jul 2023 15:50:55 +0200 Alexander Lobakin wrote:
>>> The reason I did not do that is that I wasn't sure if there is no
>>> weird (netcons?) case where skb gets freed from an IRQ :(  
>>
>> Shouldn't they use dev_kfree_skb_any() or _irq()? Usage of plain
>> kfree_skb() is not allowed in the TH :s
> 
> I haven't looked at the code so I could be lying but I thought that 
> the only thing that can't run in hard IRQ context is the destructor,
> so if the caller knows there's no destructor they can free the skb.
> 
> I'd ask you the inverse question. If the main use case is skb xdp
> (which eh, uh, okay..) then why not make it use napi_consume_skb()?

Remember about Wi-Fi, DSA, and other poor citizens with no native XDP! :D
That was mostly a joke, but I thought of this, too. At the end my
thought was "let's try making it cover more usecases" and I found this
approach. I'm not saying it's optimal or even much needed, that's why I
sent it to discuss basically.

(e.g. I wanted to try speed up xdp_return_frame{,_bulk}() using it)

> I don't think skb XDP can run in hard IRQ context, can it?

skb XDP can't happen in the TH and I think we could assume it's safe to
use napi_consume_skb() there (with a fake non-zero budget :p).

> 
>> Anyway, if the flag really makes no sense, I can replace it with
>> in_softirq(), it's my hobby to break weird drivers :D

Thanks,
Olek
