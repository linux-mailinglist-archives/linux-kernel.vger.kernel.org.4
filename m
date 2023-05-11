Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1AE6FF547
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbjEKO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbjEKO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:57:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A808422A;
        Thu, 11 May 2023 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683817055; x=1715353055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dip2pqa/33hLTECW7ldfgQ723XDqbZyzA+LmTwZrnjI=;
  b=KXq89uOAtJrBSpR++WK7OVrQTEgj+wtPSRYtetQbp//pUsa8lNhYB8Zb
   pTJuXHe6dre2hVmYfjNXjy0qqXuKGaDRdx+myQhRESzYpdVHgw/Sn5LNy
   QvEVKZwNNx0/pAyT6xdvvWMHPZYx61gK1MhxPZUVXRl8K/XPRBySFPZZy
   z3+og4+Q5cfwxm0Kfa4P8bfp6nNai76SgKmCYt711EnQNdVrXBfsl3q9o
   K5Eu1RE6A0nsCSe8QgvoRuMd2dEGJ0zyJPQFEZwLpfRHK7GsgjkSkCVsc
   PU4uyoE1URmMHPdtERsV4PBcfIW9LC2jXT4bPkqZ38X0gQAj3aBigupu+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349359718"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="349359718"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="843998589"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843998589"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2023 07:55:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 07:55:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 07:55:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 07:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRPuzpHWFq4oP56QBIl9cu5xutw/UHfhzPo32Jy/mBaHO0OY1Tsq2ra9qCWyKFFwfQQrCWsmRlg/h3L44hXjTm20cflaCjreWOGVjL+eaQFKQwgZPLY+ArEreLm0Lo9KuVfnDbyLYS9b4Gxw2RC/znsrs9w41ZZfQmUGZE9dgTmgthR3k1GhIr7WYcicxdnlXScHs+SMyVhTo9OW4rAD+qcRWtdA/KgyyMSdhRVl+g9hxELEp/P3owBEhvkxcMVRchvN9/G0XG0d5YowcgvGZqoeftQFWlmQcBZXiS10KiFsv3JUM8IWL6RcPe7vmoSGWN8lvIeBW6OJzCCMCJ1FHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bak51/4RAowOJ93drTJqftvUYgcifJc+2PviNDDR8tg=;
 b=TxOMcEMWj9CMIM+ZaSTdXHeDR+cBQo9HR/jt6Joo1NFZyWA/VRDGYJMR2sYMsumAqaazKxy56Eqo1RVB7mFf1UteqSBbezkspzICWzUQ79RhuY6tlS5QggsrpLWEmN70ztGXOBWroN7vlPT43tBfYbuJmYT/LGue3/r+zVPNDn04pEuaQWlC/bnXSXvzhfn/Kg7cbpb/X64iLA2B2Gh0tFoMS3LI1V2yTLEYjVzyjyz1SBapKmBOb1AVpMD3aLDJSuulwrRmbL94kKwRPR+5nVVhqdybGc0s607C/9R4Ks+3q3RsdvnsSA7e85J6NbvUj77ZpcfY5hnhrcpTKRgNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Thu, 11 May
 2023 14:55:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590%2]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 14:55:06 +0000
Message-ID: <75179e0d-f62c-6d3c-9353-e97dd5c9d9ad@intel.com>
Date:   Thu, 11 May 2023 16:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        "Xiu Jianfeng" <xiujianfeng@huawei.com>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230508075507.1720950-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: d7203700-0068-4f34-f379-08db522fb513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9MXEcacRhxUDBWOCG9F/JQUK6f5Q8THZePQtJ7d3rRuTD1pviqK1zbg3xum3ZmS2fX6GnHRZQhH0RfNZaZ4nto7KkWGEoGFn30l4zMHI3mjA0PT/PWDk4WbRdTclUijER/iR0+1oHCA1Ch+dXHSGYyj/EaML8PqR9x4/Pfn3LR9nqUWxh5OIny63qN1U9jabmPRc1O7CJzewU82T00cj7OkirHKfE3nhTU4E+EMbece9//xmMd29AB5+XisG6ZkPCz71rPGFt5mR0tkKZxZzplcXi0+d3qIFQVYUNdwcWXNOuZsX3jTfVnRyfiIm6nGZWcz3IUQUi3KCn14+MCqv6Qd4MKmcmO2UrobjSIrkazYsRKT8Mj7arQOHg/+Rh8w0BFy6404k45CY1ZdLJlLbV/UNn2QsAkyfuRRpF/yRV5vGRCykThqWFSUMozh5RkR4ECD077cHSBaDi+B3Ha27PMr3r6G9iK0QyN+fq9693zIX4Ja4IqQx+sVFNIuCKhK8mgHLmC9zetzjL0yCVcb1sNygNsJzpHy0MsB6YHWoXqtBLla8agA/0+5ypiBBIfpsjoZC7Ta960QvWWGevP9yyf2Cz2urdmEbA7ETW4b5T71uDnMpCTaqbei09dU8KLf4W/8P69bE3LYlvvQyAdiDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(41300700001)(2906002)(478600001)(83380400001)(6512007)(6916009)(66556008)(2616005)(6486002)(66476007)(4326008)(6666004)(186003)(66946007)(54906003)(316002)(26005)(5660300002)(6506007)(8676002)(8936002)(38100700002)(31696002)(82960400001)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1JzUjVOdGs4dHB1UlRJeGRxZW5LSEhXQVBGVDVuQzcxQjltdVpKOGZuMEVy?=
 =?utf-8?B?b0M4c1p1MWFqendnc1lqdmdxdEgrdFB6S1Vta1ZSM0ZWY1VaQnRRSEdNQnlR?=
 =?utf-8?B?SEJsTDNHRzZJcW5PeEF5TWp0bWJURlRPK3R1Yk1nY2Q3NTBxT0xLR1lZdW1r?=
 =?utf-8?B?c01iY003b2VGZlU1b3hNZ1ZaMkI3NWYxbzIzMnZULzlUZGU3ZHRadU51ZXNz?=
 =?utf-8?B?OThCZlArMkR2SWJzY0hTUjBuMG1XUWtCY3ZRc1Vpb1pMTEF1dHk3ZExHeVd4?=
 =?utf-8?B?U2lBT0ZxVUZoZHduK25ETzVBTzNhYWl3T1MvVlRjTS81TUNBQWxwUlllN2hZ?=
 =?utf-8?B?UzRpWEtOclBxVVpmMVlCbDdKaGp1K3dmK0RjWkpOVlhjaDZrd0FhbHJqaHlI?=
 =?utf-8?B?L3VEcVpuS3Y0bXpGZmdRY1RzQno2eDgzWTc2UmR4eTdvNXBpbkZvWXVVR0lr?=
 =?utf-8?B?RVBWVHpleGJkTkkvSU8rZ1R3dEN1aTc2VUk5Y1pGdDYzYmdYOFBmaTlpMjNU?=
 =?utf-8?B?VStseUVLRlRZMTlKYlZ2bDdPSjlnbjlXcmg1b0JoNXhZUkNOMTRmd2ZxUEFH?=
 =?utf-8?B?UFlBSmFSdHc4SEFRRkl1bXBGMXRFK3ZYN202TldDWXFiWk5ZalJEakVEYUhD?=
 =?utf-8?B?b1o5NWxIcE9uNDI5dXBEMlFPNW5MUmIvNGM1dW1VSXFXcXg2eFkwWmN2bmJu?=
 =?utf-8?B?VEFkNi9NcWZPci8rTVE5RVAwZlI0Y2RQNWl6aDBlTmpwa290N1R3QUY2d0F0?=
 =?utf-8?B?R1FiWnErODJGd1ZaVkRaTzZCWUtqSFR5OGk0LzFtdGQ0QlhXc1plM2JuZDkx?=
 =?utf-8?B?bkJNZU56NVQ5ZHB6UnRXU21Qa0lQbE1XQWNBTjhqMUpIb1Y1eThJVjBzQ29P?=
 =?utf-8?B?bHRGQTVNRVorR2dpOWJWR2JxTWZITXZjT3ZIMXBSVEFma1Q0Zm04a3FLQjJR?=
 =?utf-8?B?OXVKdlZodE84SjFQVnUyaERPRk1BWW4xMDZJQjB2Q3ZqaHJUZE1lVm94eU5J?=
 =?utf-8?B?MzNPQk41Z0x4QzF1cWVQZEZySlV5T1BGV0xHeGRxWUJSRmFhQmlPMk9YbEYz?=
 =?utf-8?B?b2ZCT29RbnVncVNhS2xMeHR1cGVFZW16K3l1NHdZMkpDbm9Dd1p1RzM3d3I0?=
 =?utf-8?B?a1FXVzEzOFpmckVZS25JMmVZcDdxRHZvRlpJZi80TWZDUHdITWNyZnNsNWpo?=
 =?utf-8?B?Zi9aQ2xkMzRnWUQ0SVcybUJzSVA4YUpNUFFNSEdOTnJaYjN4UHB3NGhQQk9h?=
 =?utf-8?B?V0Y0cDd1cEgxT2lOcStjTVhTS3p3QUlTSFRQTDBaZm5LZ1RqZU9jSk4wR2My?=
 =?utf-8?B?ZW1lODZjNCs3ZUdWcWJoWUR0VEhzMTBrL2dPUnBMR0xSZ3dIRlVIL1JybFlD?=
 =?utf-8?B?STZKczlNanJzWXQ3bUdXTmVmRFZHZE9yQW1BblN5M3IvQ3dsNzhqamR1Um1j?=
 =?utf-8?B?cTdiamh5d1RoQk9MakdOcWZmSTROMGNoYzhscGFWSEVNamd5WDljVGN3Vno3?=
 =?utf-8?B?c1VyVFBUMDY0ZS9UdjB4SEFPTkxLTjhoRFZmTkpQTXdDelVlMjZsWUdHdjB1?=
 =?utf-8?B?ZWpzV2NzdjdsYjlmVWJ5aU41S1ExOTd1c0tWeFpOTWc1WUo0WklCU1hRaW5r?=
 =?utf-8?B?aklBTG5yL1BDSlJoc2JaRjBydk9SY0JaQXJyRUhXSDByR01mc3dCV1NHNEhP?=
 =?utf-8?B?L01DZ1REdmgyb2VscGFPb1BKWU9zOHNvQ1h5VUlnSkNmRW1IRUErSTV3MklS?=
 =?utf-8?B?VmY4WjZQc1BjM2xBVUJWeUlBVU5lcnBaV0FSZWErcEpUVHJIemxGdDNRcWFs?=
 =?utf-8?B?SGFrcGJXSjlyTldyblNJODh4Z3Z6N3doazAzSk9oOXlrV2hKVmNWNlJoOHVu?=
 =?utf-8?B?UStBZE5uNWFSTjRadW1WaWFMQUFPSTJERHZORkt2MzRsRDFmdnBHNGhSWXJq?=
 =?utf-8?B?Q1FYN2N6cHM0cTN0VHFQNEtUblVhWWo3c0haeCtOZ2ljbjNGeWw1L3lhTjJk?=
 =?utf-8?B?aUNQVGtsRHpBUHpjWEVmaFRqYlJjdEtWRzFLdEdlblBjVWdLeFl2V1d4RXN2?=
 =?utf-8?B?SXB6VnB2Q3pUMEtOeGFPbG13cWw4UFJ2L1R6ai9EL0tEakE3TVY1VlBRdFhM?=
 =?utf-8?B?dmQzbTE0ajI3cEFLT3FkWmhPSU5obHlvR255ZGJxeXc3UlB1MVlHNm0wRXJq?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7203700-0068-4f34-f379-08db522fb513
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:55:06.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QkvnENllz/Gto05Vqmz5Me6HgNnBJswzckfHFw1LH7ODlEbsJ18KjLmxT00EvS12KYAgKZWPX+0PqvNcylJVvlX+zPa3tEyYUl7hViuDlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gong, Ruiqi <gongruiqi1@huawei.com>
Date: Mon, 8 May 2023 15:55:07 +0800

> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.

[...]

> @@ -777,12 +783,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #define KMALLOC_RCL_NAME(sz)
>  #endif
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#define __KMALLOC_RANDOM_CONCAT(a, b, c) a ## b ## c
> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMALLOC_RANDOM_, N, _NAME)(sz)
> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
> +#define KMALLOC_RANDOM_1_NAME(sz)                             .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
> +#define KMALLOC_RANDOM_2_NAME(sz)  KMALLOC_RANDOM_1_NAME(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-random-02-" #sz,
> +#endif
> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 2
> +#define KMALLOC_RANDOM_3_NAME(sz)  KMALLOC_RANDOM_2_NAME(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-random-03-" #sz,
> +#define KMALLOC_RANDOM_4_NAME(sz)  KMALLOC_RANDOM_3_NAME(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-random-04-" #sz,
> +#endif
> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 3
> +#define KMALLOC_RANDOM_5_NAME(sz)  KMALLOC_RANDOM_4_NAME(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-random-05-" #sz,
> +#define KMALLOC_RANDOM_6_NAME(sz)  KMALLOC_RANDOM_5_NAME(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-random-06-" #sz,
> +#define KMALLOC_RANDOM_7_NAME(sz)  KMALLOC_RANDOM_6_NAME(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-random-07-" #sz,
> +#define KMALLOC_RANDOM_8_NAME(sz)  KMALLOC_RANDOM_7_NAME(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-random-08-" #sz,
> +#endif
> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 4
> +#define KMALLOC_RANDOM_9_NAME(sz)  KMALLOC_RANDOM_8_NAME(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-random-09-" #sz,
> +#define KMALLOC_RANDOM_10_NAME(sz) KMALLOC_RANDOM_9_NAME(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-random-10-" #sz,
> +#define KMALLOC_RANDOM_11_NAME(sz) KMALLOC_RANDOM_10_NAME(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-random-11-" #sz,
> +#define KMALLOC_RANDOM_12_NAME(sz) KMALLOC_RANDOM_11_NAME(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-random-12-" #sz,
> +#define KMALLOC_RANDOM_13_NAME(sz) KMALLOC_RANDOM_12_NAME(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-random-13-" #sz,
> +#define KMALLOC_RANDOM_14_NAME(sz) KMALLOC_RANDOM_13_NAME(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-random-14-" #sz,
> +#define KMALLOC_RANDOM_15_NAME(sz) KMALLOC_RANDOM_14_NAME(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-random-15-" #sz,
> +#define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_15_NAME(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,

This all can be compressed. Only two things are variables here, so

#define KMALLOC_RANDOM_N_NAME(cur, prev, sz)	\
	KMALLOC_RANDOM_##prev##_NAME(sz),	\	
	.name[KMALLOC_RANDOM_START + prev] =	\
		"kmalloc-random-##cur##-" #sz

#define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_N_NAME(16, 15, sz)

Also I'd rather not put commas ',' at the end of each macro, they're
usually put outside where the macro is used.

> +#endif
> +#else // CONFIG_RANDOM_KMALLOC_CACHES
> +#define KMALLOC_RANDOM_NAME(N, sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>  	KMALLOC_RCL_NAME(__short_size)				\
>  	KMALLOC_CGROUP_NAME(__short_size)			\
>  	KMALLOC_DMA_NAME(__short_size)				\
> +	KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)	\

Can't those names be __initconst and here you'd just do one loop from 1
to KMALLOC_CACHES_NR, which would assign names? I'm not sure compilers
will expand that one to a compile-time constant and assigning 69
different string pointers per one kmalloc size is a bit of a waste to me.

>  	.size = __size,						\
>  }
>  
> @@ -878,6 +916,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  		flags |= SLAB_CACHE_DMA;
>  	}
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +	if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
> +		flags |= SLAB_RANDOMSLAB;
> +#endif
> +
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>  					kmalloc_info[idx].name[type],
>  					kmalloc_info[idx].size, flags, 0,
> @@ -904,7 +947,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/*
>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>  	 */
> -	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
> +	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {

Can't we just define something like __KMALLOC_TYPE_START at the
beginning of the enum to not search for all such places each time
something new is added?

>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
>  				new_kmalloc_cache(i, type, flags);
> @@ -922,6 +965,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  				new_kmalloc_cache(2, type, flags);
>  		}
>  	}
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +	random_kmalloc_seed = get_random_u64();
> +#endif
>  
>  	/* Kmalloc array is now usable */
>  	slab_state = UP;
> @@ -957,7 +1003,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  		return ret;
>  	}
>  
> -	s = kmalloc_slab(size, flags);
> +	s = kmalloc_slab(size, flags, caller);
>  
>  	if (unlikely(ZERO_OR_NULL_PTR(s)))
>  		return s;

Thanks,
Olek
