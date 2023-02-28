Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F56A5B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjB1PQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjB1PQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:16:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E32ED79;
        Tue, 28 Feb 2023 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677597388; x=1709133388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0rVDGcs988B6ruuLRlvEEoQMQulrN8WTVi33mWt/aV8=;
  b=XsYOym0VY4YxYmBVIIUmvPoMZx1abKab8ugk5cytltsgUEsLTcGHMYPz
   csB7KRDzPxgdCK2l83X8SlMi+cKZSZDTbVrqAUIYoigE1Frhg//d+rO5W
   aGC4Y9Gdz7a9StJ1PljusyaoANQiSL6hbIMtjcxA98b9BUqsEXSuVK1LV
   bDPPMZZZ3FceicJad3NAGRZ0wDCwcrI5W15fV2U/+Qzffa6GAkvXsqtaH
   +PJWoxxVZ1Wdbi5wn3hmqwgO4ATUcjAGoVg3Ob2muyoAZnJTl8dcLCpJ2
   sSK7jpAVAG6kzYsmpmdo1UVbJmDS1MqBnMSZgWlBYWZSb0i7MbzhOW1Kr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396725446"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="396725446"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 07:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="624057880"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="624057880"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2023 07:16:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 07:16:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 07:16:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 07:16:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G27rqsP3PkyXQt7IJ4juAwGURRY5szMIGKEXJeWh3VN43zcaaYKczuAwS8ZIW3r81Lk3hjdV5dLNuU/s0ea3UUit2RCFHFX5pITY8Wd+duldmq4MnWC1QJsDuMTB76AdItgaBJ5hK8kA0NnB9Hct9fJq7y/wUPjIfr70jc3Yei9pmVgOygvf7SzU69ITdJs4nodMrnB8zR4KYGqsMlW3PAtxpUATIhlG/CC6caUGeblXrJWoYUpMMAfpd/gJFBzGRH0kM7tXOcSTW9NSqP2Whl0KcVL7rKYXkNUmNhtiWyZDS2IERwG8amX3tZiF1rCWNewfYuV/i46oZxJI9xprBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpoYmVunkpJJZ1vhlMl0b80BoOMh4fZiETyl/AhKdd4=;
 b=SZ+Ry69vZ1iD8NMryCi45F+4+UZzBeDftLTirUxmWbKJxvSZooUkZFOn7UdEsAOG4Zu/IZc9pFytFjiN7YFrUeB22mIUk0o1VLgWWuIn20BN6blS8J3eICqP/6S5lytOvEw6WTKUir35tCJmox00IgOQOSEfpaTTPDNObuOrvZT/GTSjnfNYMPCB0pTgLVQhwgjPxlDk8BM9iDV660fSiTAqUh860sXMuy4kS2n+tOC9kui6hGKtKFMqR+9eY7wOFX8bjVFm9VEo4gfehIqb833dpjHVTLw4Eq94JQNCKRSh4aXcmsMFYHtmTCHWpwbG8AEC0zIlVOAn11C3lAFa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 15:16:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%4]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 15:16:24 +0000
Message-ID: <e8addca3-e539-110c-ea2b-9a4921a45d71@intel.com>
Date:   Tue, 28 Feb 2023 16:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Documentation: kbuild: Add note about using (subst m,y)
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        David Gow <davidgow@google.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230228031317.3415484-1-davidgow@google.com>
 <CAK7LNASBznyHmAwSRApOHw_6dyAXFuskmtKav65xFwKZdvNWJw@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAK7LNASBznyHmAwSRApOHw_6dyAXFuskmtKav65xFwKZdvNWJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b0582f-2ef0-416b-297b-08db199ec162
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDz8sUTT5TI3IIksuO6cci1YhuDyvMVzwi9l/8iAwdhEFPDDQcR4wTrp0aBV4GptoG0MKmfm1SiBJDgW6VW9z/5cTaDZsLdX22p305wnFaJmeGILEiXtPgiKtYAd+MQeabPbGlz3oDotXsrl/uFOkNPc5kjWvuTJo/CuzffZKv4ebA86HPRMv453zg+mqRhFOl+aM52TFuaGsQRvMe/uIBkDyNZw8yXMoXLcCj9sSyclGoC9YjVzYCXpdp15gcqyDOmgRte7vIbeQdDlz9vMJe9dFlJMtElGf0PTwH4QGigKTmxtgyhAyjVeWFbO7yRpThKMaibW8lbEqM5U5qiZXnsmfj3ZIVKBF3QG+WRFZroarmbgp0kQGA0gsaIzJMrtqJLmS/AjzIKc9yqsuit3XX5zcE/AbxVNX2lIR3LZBpp79sDRE2Z4lmwCQsrxxOMuha3OTIa2NzC65y/9NE9oIFDUjE8KfLOQSKrfn0yjXCZSQiy78t/f2RCVIl9PU258MtDEBE9ts1SuVkX5Dy2SO2fvZWRlm0G6WwTxHEn3upICdc9ETY7m3ZCXrFCqAsdRe9f7356B1h27X/Wh/uPU83UEND95ENBMkGb4fm3IwaYAkjiiqkWJpY/LQX+w7h/Rp/kiFTcQ1b4IXwLnN0MaEmd1BUInTMy5uNd1FC2IkrYIDieUPiEZk9Tb84z0xgI8obtGQT+6W6mbfMrUFTmg2wov3o9Xpbq9JqTgI9KxPRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(31686004)(31696002)(36756003)(86362001)(41300700001)(66946007)(66556008)(66476007)(7416002)(5660300002)(8936002)(4326008)(2906002)(82960400001)(38100700002)(8676002)(6666004)(6486002)(478600001)(54906003)(316002)(110136005)(2616005)(186003)(53546011)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhoTUhnSkZha05uMlBoQlY3ZWJqaDRPbFZxWmF1T2EzUlA3eVpOTTFXVTda?=
 =?utf-8?B?dndMY21ZMndBcysrQmFzMk0vZWZTUDVMRnpQUXZaRms4bDIreEpEV1VWSE1P?=
 =?utf-8?B?Vngyb2VTeWVhd0Q4a1VESzRXYTlzM1lraVdNeHVtRWNaU0JEcUJzeFpwaFh0?=
 =?utf-8?B?dnJwK3JoNS9GTCtzVnZUd01MNjc0SDYybk9NNGE1dGVSb29ZNnYxN3pLUExj?=
 =?utf-8?B?bktsaktjM0d1SlRDNU4zb2x1dzJSRzJPOTFJem1PdFlYTVpsTEJYTnlKVjI0?=
 =?utf-8?B?ZHl2YXZvQStsbnlzMkFiSzdURllQbGJwNHg2Mm1kUTV6Q2U5M1BXSUM0MW4w?=
 =?utf-8?B?N2c0YjhIK0podDhac0NPNW45bFFqNHZOZWdXcXNoSk9xMUt2RFBveWNUcjBh?=
 =?utf-8?B?bk5lUlIxeHpoa1hhSk16b3l2Wm1oVklZNmdvSllMMUVsMlRENlU5c0ZCMC9k?=
 =?utf-8?B?clZFMEkrZC8vM0ZpU1QyeE16Tk5aVm1LRGhGRlhDdnZWalFXYmtITDB6OVN2?=
 =?utf-8?B?NjFZa1FUZ0ErdldTRmxpY1Y0cUx4TW5lUkRpa0ZyUDhWazdheTE3dUFlVWtR?=
 =?utf-8?B?eU52akFWbXh3MFowL243MDFuRGFvN2diaGhuSzE2SHZBd3YrT3VGWnR3blF4?=
 =?utf-8?B?YTBFK3YraGlPRVM4ZWN1RHY4d1h0RmRvTGtobkRWNnZad2c4bVVmUWJLaThG?=
 =?utf-8?B?dSs5M3o5bXk4dE9vMnQvOWhsS2NVSHVLUk5NNG5QcFhSSXRVWmQ3QWpGR1dJ?=
 =?utf-8?B?MGxCa1hyNGJyMFR0QmhobVlDTHdLMFVWRTRjbTFuOVlSMDFKMFFDeEtUd25B?=
 =?utf-8?B?UExQbk15Sk1JR05KTlZkblBVVEJkTFNlWUtVd1JWamJ6TEtEcW56VWJFL0pn?=
 =?utf-8?B?Zkh2akRRNG9ZNyt2bTZYTmYyVmdOdWhjaGZkLzRGTWU0bGlQcDdYWWdRRklr?=
 =?utf-8?B?K2VUU2NibWhxNWxmSGZpZ3ZrSUhNK01Sblo0eTRmMWZEQTc4WnlZV1AvaU44?=
 =?utf-8?B?cVdCdDc2c2MwKzlRbUY3RVVEbGJQMGRDZHZTRHVmQk8ySVFIaXZBVUcvTVY4?=
 =?utf-8?B?cjQ0dDMwRzd3aHhPU1dsbnF3dlh2VHZZQm9JNTY4cGY4NkNvQ1o0OTZKTlJz?=
 =?utf-8?B?ZEZKQ0phRVk0TWpPcnZQam96d2lwSW1rZW5FYjQrMVgyaTVHejkwM1NjMkxT?=
 =?utf-8?B?dWVZN3V1TW1ma3VPdG9yRjk2aFgzUXB4R1RYMC80a3hXYkI5UHlUenhQc3dR?=
 =?utf-8?B?MWEyZ3FUVzBvS3UzOWN6OWMyM2NYdzhFdFZKWXU3SlZiWVVMbWNOODIwNkRU?=
 =?utf-8?B?Wm5RVVpNVmFyMEFJeXBlRlltNVRSQWlYdDFaemJ1V05RTC9waWhiUGF4MzNP?=
 =?utf-8?B?aHBUcFFvRFJ4RlptL0Z1N2lCVHA3SFk2MXdVZjJhZ1dId29ZV3kxcWtSRUhH?=
 =?utf-8?B?UDdxNkNSSDR5bWhwOEJpNlEwMXh6Z25leG1pUTFLVDdOb0Zuc1UvMktGa0h5?=
 =?utf-8?B?UDc0Wk5Xc2kzbTdqOE5RNFoyNTJJT2MyTTB3VHVLRnVxVTZEb2pyUGFTRnVl?=
 =?utf-8?B?dGhXTVhwUStBSkV0WFhlczNtSHpNL0Z3d3M1bEhOYkd2cU9LV052OFZSMEpK?=
 =?utf-8?B?c093UXhzQWU5ZVFOQ2pJQnYzTzlmUHBIMVA4V3h3VFcxQ0huRnQ5Y2tGMmI0?=
 =?utf-8?B?Nnl4SzU3VjJlVnJ2eUlPeG4xT0FrMndud01vWWRVRW83eldUcnhnK0xWc0c2?=
 =?utf-8?B?bHdjT0t4UW01clQrRmlWRzN3aDRBL3FxT1U2ZXNDMkU2ckRQMzloQUFsTkVF?=
 =?utf-8?B?Y2JpQUd3TFFPcXdjM0RTR09DeTZLSDVWeVdHZ3FzUFVxSnZRYWk0ckpjUm5E?=
 =?utf-8?B?dUYzNE45ZHFlc3N6dW1JR0JxWGJLQW9OZ3JrbWZHQyttV2wzZ05RUnZvdHRv?=
 =?utf-8?B?MGZlS1FkajMxYTVQVXBLbTVrc1Y3NDRmeEMzcGU1Y0F1UUE0RXc0bGxPSUhq?=
 =?utf-8?B?T1k3RDFTcmNmWmh3MVJFenV4SUlxMHdyRFpqZkxJTlEzcnJybHV0S2czSEM0?=
 =?utf-8?B?OW40ZTFjemh4QkxnN0JMb3pIdDFzOGRjTHZOTGFCRWRWbW1iclZGd2diL0sv?=
 =?utf-8?B?NWNNV3Y0TmRkK1J1TXNjRVYzNnlobHVUY2tQaXY4L2p2RG4zckFhYVp5THVq?=
 =?utf-8?Q?+r8aOM6D56zpiMslYDfbCMU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b0582f-2ef0-416b-297b-08db199ec162
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 15:16:24.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R885FH6xXsCaiiN7Djm4ImcaDy7ECBUng1G7UA6JpFJVZehrLkvJU+exOzKESQEpXZk5g1g/zy/xDKGZONzYNdCv8cC5PzMjGO6uutuAPrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
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

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 28 Feb 2023 17:30:09 +0900

> On Tue, Feb 28, 2023 at 12:13 PM David Gow <davidgow@google.com> wrote:

[...]

>> +Example::
>> +
>> +  #drivers/Makefile
>> +  obj-$(subst m,y,$(CONFIG_HYPERV)) += hv/
>> +
> 
> 
> I think many subsystems simply do
> 
> obj-y  += hv/

This creates a ton of empty built-in.a, each of them is listed in the
Kbuild output. Someone may think that if a directory contains
built-in.a, then something was built there. Sure it's their problems,
but I'd prefer to not pollute the log and built-in.a contents when
possible (empty files are still listed there IIRC).

> 
> 
> I do not think we need to advertise hyperv's way
> since it does not look very pretty.
> 
> 
> 
> 
> 
> 
> 
> Mostly, it looks like this:
> 
> 
> obj-y  += kunit/
> 
> and
> 
> obj-$(CONFIG_KUNIT_HOOK)   += hook.o
> 
> 
> 
> 
> 
> 
> 
> Bikeshed:
> 
> I think Linus' suggestion is OK, but
> the BSD style seems less ugly,
> of course, that is just a matter of style.
> 
> 
> obj-$(CONFIG_HYPERV:m=y)   += kunit/

I'd vote for this one, it's compact and readable.

> 
> 
> 
> 
>>  Kbuild also supports dedicated syntax, subdir-y and subdir-m, for
>>  descending into subdirectories. It is a good fit when you know they
>>  do not contain kernel-space objects at all. A typical usage is to let
>> --
>> 2.39.2.722.g9855ee24e9-goog
>>
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

Thanks,
Olek
