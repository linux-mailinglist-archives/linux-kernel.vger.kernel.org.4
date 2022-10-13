Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77645FD2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJMBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJMBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:47:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23B139E49
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665625658; x=1697161658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BY7KlCggxj4Sbyacv2ELZ9Bpqi2ip5HoRiBT0uXLEtk=;
  b=LIYcs2Dh3hRb68r7CQOhyTQJDics8KLWdErtDjDv7Nl0vjC/1b+97U2s
   zMbCEwRfwIKBOecbN3PHRmGqr8h+kKTOxnlPRatuWGNBlN+bnCkAExZa1
   p4FbXeMiDhk4C1zfFHbGf2JtuV/OEeFGwm8kGUqOQJf0/+V8FC1zKCvLA
   QmrJRw1vchLa0yRlCMD2gwoH08c/RxkzFY0kjzUAYCqEXMc7qv6mYBFzh
   Z03Hpkiz7bNXO9ejt6RyVKkuqJ62aGluIERzA5R2qmfi5mZHU5lDQkLfV
   bTQ81B9f0b9XBWXonzBj7zHpYFmTUNrnK3G6JPzi07k2AE7exLZsDQYlN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="288221964"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="288221964"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 18:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="629334448"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="629334448"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2022 18:47:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 18:47:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 18:47:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 18:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGBGXprYGc8W9CuTBSoHhZ+RM7W4VXPFkQgFqKlFLeyKiy8WFU1CIutFcHc6MBdbHyoS3LKdoj14R9LPDs5c/1zqYsvYqtO9tVsTeyhdAmfnqsUnjuJGcmvLimMZXjLIyYRHCQFlerxubU/rzz5sHanH3XiUwFQYLpRspEqPpG6bDO9ceQOWfCFOv2H/2CH2dUtI+r4Dj/ripN2tZkBww/cEI3XJdc6xV3xkMVDbHkkFTuwTYct2YF2Fow6aw0aOSwIlqSVsd2MzPlDLaDtas1Q4sKvd4XYUceP7pJqADmyO9BjX96wOa8YdKyvtgSmCO+DxiB2RH4yes3na0ixAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7Z4uqFRZg1HdLz2ZrtobdrZdGgC+zeTzRoSyBp707Y=;
 b=m0FzY887qoQu/p94tWKRiMM7W8fzPeAJIrF9spRpocfU2MUbJfyB7+ekMFV13OxZy78eCt+Ni8qK+wVcNLtsaywcXfHSN+tWtsbUughzuTAlpGqaV+n7b2rO7o+3lAZE/wIr+sAqwaTc09QfFhdhbVEOsbDOx0z+1x4+naYo3H8FbR3BHDr3GRslYr2oakCX7hm+fAZgKMlVI8MtISzij/Pcm8VJ9Ho4jUVjvoKQ3E8qxmesUQ7UBX4wiKAgjUTgYKDWxe0BUY2dwZwmYzoBEour93T4JGtOMAuWuOtruYcggzPdRyd7nMvZ/4ZsRBioC6z+65E5faVdGc2OsDjnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 01:47:33 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 01:47:33 +0000
Message-ID: <02e2bdf6-0b55-e944-532b-d93c89e5a822@intel.com>
Date:   Wed, 12 Oct 2022 18:47:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Yuan Yao <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20221011222425.866137-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::20) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SJ0PR11MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 968c951b-1154-4887-e9e4-08daacbce5a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfzEpOCoQ0fd/b8If+8vkYy+CIHqfZNw9qEf1dYtQLZZhdUy5lmSq7lT2+S3myV+0gGI/5jsfj9eOCV7FV0NOA08NfOg/4p0kfh3C3RHtY0CLx5yw0csx+9AdZfH9osqK4yeP5pqQxjYT1AZLNeSis+hKRpO53xus0SKb99n76/Y2reZzDRVblQvw2pvoZ6jpImWSl/rL4p2iy8q26VuL4sml6VXI9n9/WnEqLO+QTKP6DhmmO0sbx/639J3lYbVVlpGD8oKdwCl6+4qwnuMoeThavP+7/36fUWGZTHEgcsxiBUaw5j9wIRdiryPPck46zl+XfPMu+WNaakoFhqDyHl0ltOHoNExodiaQwIL9VT+c5UihxXuQ3BKHpHuASB6UCfng4Yxq/CXvgEvSWJRbGU4pGJ4W3+ckI8lWEpRx7iu3YL/rnmFm1xfyTpDGse9iHmi21MnSrjnWRta+k6E/Rtyi/q7FghwcJPi+QE/t6z8IiiuzHakr5qaH9Yye3gWgqNKvtuPF1nrlQjsFs4scWrzz7WCoUlm+4FHVpcWT6wkjdW853B717MRj1OttVPBKqZJBttf4F/EoK3HKlCMWN67pBKF1KPlJqOMN5EEQDdoTb0Am3uhroI9EiIJBZdgIOFFPXkECWKjGbthrSTFosWxDLOXrxo2Bed/Lh/RoOxKaJHYXOFdlPJgqKTroyVkszXwGDffqW9Bt2TJsHvMFH11T0FiQUN25B8J50lN7wWqT50WHEMEWF3bNrbg7/6WViH4utmwe3BeuHi/NqY8eSI0O0Tth7L0DVSlwlLhbjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(31696002)(54906003)(86362001)(8936002)(26005)(6512007)(4744005)(5660300002)(36756003)(4326008)(8676002)(66476007)(6506007)(53546011)(66556008)(66946007)(41300700001)(316002)(2906002)(186003)(2616005)(31686004)(82960400001)(38100700002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEk0SUdlKzdjUVBSYUZDTlV0b21DQXdrUzd6N2ROUm1TWWxKVERad0hQeVVy?=
 =?utf-8?B?TmNQeEpjTnFuTXd6anJ2SlJLK1BHc3o0ZHlUanBTZ25qcHpXWnlBK2c1NEpN?=
 =?utf-8?B?Q2JiNk5GaUg5UEJIRUtxc0twTVdHcUVlc2dySUNuWXFGR0dpaXI0KzRKTUVF?=
 =?utf-8?B?YzA1cmpsQUpDbWxMM3JIUHlkV0tPQWVmNGxlNFJWT1RSSDVzUVRRVzFlUnJ3?=
 =?utf-8?B?M0lCdTJmMXYzZjI0N0JKUTVFTmVrYmhsS3JuSWh0Ulk1UURBQ2orZzZza1lX?=
 =?utf-8?B?cHIwYkhwMXR6UUw1czdqNHpQNmdhTWs0UEJ0NGd1SUh4b0t0Q21qNENMVThD?=
 =?utf-8?B?UWsrUm5Mb0hUSDVjc21LNUhodXFaemw1NFdpeXRWa01oaFltTHZGQVc0bW8z?=
 =?utf-8?B?SDlPdGhkVUgyNy93a2ZZQklIWjYwRzl4TldVUEs4Qm02M0I4Znh6aTAzZEtZ?=
 =?utf-8?B?T09QbjFGUE5xSmZydm1sUHh6VnBkL0hmSkhUYzh2ZlA0MjRkSHZRMVJ1WXhl?=
 =?utf-8?B?eE8zVzh3cjVOUXk3WVIvdDRxNktUN1pKNlkvRDVVZHg1RG9qVkIreEhsbjMw?=
 =?utf-8?B?eXpEVTYvWHpXUDk4eEU3MlZjWFNnblhLdWJDM0QvOU1iUnlDSlZpUlRRY25T?=
 =?utf-8?B?ZmRmbUJTRHRJNEdlTFBuRFlZWDY5YnRQRjBHMnE3VmRDMVFHaHdSY2o0Wmdi?=
 =?utf-8?B?bmMvanMxYWFnVk5DTzZvTFpVMmdWcnp0a211ZkFkWUdWenlxeDRVazg1ak9G?=
 =?utf-8?B?Y2kzZnFsdzVCajByNDBCbDFwTFNzYk01WEU4NEtvKzRuTjNaWGhRaG5tS3lT?=
 =?utf-8?B?NFpMaUh4SmFrK0VGTlk2UVJveUdmcERaMS83MU83WklYak1UUjltVXlBcnpy?=
 =?utf-8?B?QjlwYUtOS2xyVUVwVXNlSjZSelQwU2syYTA2bTJ3NHMxREVCbWorQkJiemNV?=
 =?utf-8?B?SFdidUVlUy9WdXZJb1ZSdnAyendTTnRjVHJ3ZE8wRlJhdWV3dEVLM3haZjFz?=
 =?utf-8?B?ck5CcVdTWUlBNWZYY25jY1pMOE1YWW9QKzdPZ25YTjRNcDlhS3VDcERieFlH?=
 =?utf-8?B?LzEvMGZPNk9BWmZndUM3Rk5lQ0FQMW90dG1UaGpYTk5WT3VXay9qYzU0MjZH?=
 =?utf-8?B?VjVkWHZJMklWNTB1K01mSTdIc096VW4wL2pPczFHc3ZsVmhLT3ZJZVcvSlFU?=
 =?utf-8?B?RGI1N2hrK2tlK0JpMzFncm9scVExYVJ4cFRqN3RuUFJtaThSUEtNUW9xazJo?=
 =?utf-8?B?Zi9pUEZPQ0tkYVoxN0xZcTdXZWphSmlSNzdjcGxxZGJsSDBwTXYyR0IvZ0NZ?=
 =?utf-8?B?U3dvRDB4UURBNmdETW5oOEo2cFV1L29xUlpyU3M3ZEROTDZ1ZVJKMS82Yy93?=
 =?utf-8?B?aFU3bTdMd3FGaVU1WTZQYTc2b0Z0cVRQUytuNXFBQUtEZjVlZXQ1M3IybWJC?=
 =?utf-8?B?VHl2ZENpTU1kMjlyYkR1d2thck1iMkhKT1V4MlpmdWNLRjRpOXhhczBPNTFX?=
 =?utf-8?B?Z3YxOTFkT2Y5RzV6WWZzKzRWMHcveHNObjZnVkZuYnZMNmxwS3FwWXZ1ZGVu?=
 =?utf-8?B?RGtnSEprdEw3OE94K0psWWhQU1pINEx1OWNNWHg1cTZoRk4zOVFibm5Yb3dM?=
 =?utf-8?B?NHF6OXo5cExoWXRjY25Vblk5ajRSc1c2Z29CRFdVRFg0VHhmam9Jd0lRQXJ0?=
 =?utf-8?B?OC9lV0F4U1Y2MXk5NkZ5Tk5xOEZDVitvTW8vazVvYzJQbmY5cjRnQlNZcHpl?=
 =?utf-8?B?ZGRiSVVYN3VDdXBpVkREanZ5T2diZFJjT2lvbyt6bVpyVm5QVktPMnZ2WXVx?=
 =?utf-8?B?aXRNZ1NwQWRFZlBEeFdiNktJbHlraU54eUdTcEtyUlBPTklvckNEaDd2QVdF?=
 =?utf-8?B?cEJLYXJOSG91cElBZ3dHUUJHTmV2dzArK2FRNjJnTjVyNk1vbzk0UUF1NSs1?=
 =?utf-8?B?QmtZNkJjcGxmZEczTGlRaVQ2aFU1aHk5dkZXcnYyRCt3bWx0ckMrOEVOWVdi?=
 =?utf-8?B?MnYyUFBrKzNpajZJeGc1RUgvdDNEZE13cjVSYVJUNExRQ2g2Y0NzdytPdVFX?=
 =?utf-8?B?eml0VEJIWkZlVThzeTBJYmxBOWhvaE43TUcxNitoT2lhYndGL0ZLei9JOCta?=
 =?utf-8?B?bE1pYjkwb1ByRTJYRVhEeUhNeE0vS1M1eXNUcVlXVWw3NGJwdUxBbEovWTl4?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 968c951b-1154-4887-e9e4-08daacbce5a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 01:47:33.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2dvSDCib5E0q671otAXz+SbrTIlLhAbjYy6JwYiKN5GuDUHVs3WCcP3fQWdLy8lMws2+RIXg5xVM9HxSkge6A6twpEQJXzeocT+pWCRQlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 3:24 PM, Dave Hansen wrote:
> 
> Please let me know if this looks OK.  I'd also especially
> appreciate some testing from folks that have AMX hardware
> handy.

The issue looks to be reproducible at boot time with 
CONFIG_DEBUG_PAGEALLOC=y and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y. 
Folks found this.

With the patch, I don't see the splat anymore.

Tested-by Chang S. Bae <chang.seok.bae@intel.com>

Thanks,
Chang
