Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351AC69178C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjBJETb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBJET2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:19:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8693DCA19;
        Thu,  9 Feb 2023 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676002766; x=1707538766;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1933y+ezLKUd+99rVnfq8Weo09t7v0aO/C6vMbMfLc=;
  b=AD7bYWEl6r49+Avsa4ZrBGvXMmL3HjwkyzPPDXcUoxGG68FLwK60U1GN
   97r+uhxDY8dCNakwXiDyUKin1a45khSbheQ1+zPqy2uD91vML6evUphlp
   jzxFzdxEohTV7ftPRUEGFbTdcDCZA3sa5Ewjc2mEHG/m/DJzgSFl4EYh+
   HjCM1fJ6+oth8SBpU8AjzktF8GhIFp7e651bdFwd/1THDwT7+9r+/ka6v
   0LeX9NrYeo5UMv3RTwO0enUKzSdCuV38sSsd/G4SjgxdLql4pzwlDlYii
   xJ/ddJmfpbZQKVG+z9Cgw8lPCyuo/BtsWblzbmqU+1N9a/GkOUybFL3Kd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416558284"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416558284"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 20:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756650872"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756650872"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 20:19:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 20:19:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 20:19:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 20:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ArDwzaxqJxnJJJIzu5BGzGSQJxHvIKevDUin61ZQVBivxWvZk2STuoeTDg4epJYDoEQELQNHHpytXMY6WSVjUxeYzlzO+0JduHy2MyQB+SdnCs/agic9mlI5YcAUA2Bfva/EBMC9NbWgt9CdLkqMlf/+U8TVfxn1SFfE1kCJOTuyBs/+AhnZfzC4iNqLDYBPXtHP6BkZuzn4mNjAP9MAN/JTNZN/oFzvDnTaN+oeFmdseKEJPDz08G6US2/+lU/Ew9SMIBL+JEQ4yFRYGJ0XxeonYahSYNBOChALJgLy1V5XDP9S195+pa0YJ4tL2I0x0go+3Q6qCECu7ijmwiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8jwTnc3kp0q4mBfsKxWxs4XeZL2gd840jG9yRZr38o=;
 b=fWL6RSVtMqTOZcVQ/wNeOMSuI4kSC/0Sqd972wdWibm8k43ZQWV3PzTiUC63u5mm4KI1CkBjGE0L+0fYoW1xBPfYMPiWI0nGmsgAGfvloQEwAWcOKJymKzqdMKSVggnh9uIQFDg7jm/nwq/PcKV2OcBx1VrzCciBSikQQ6nmSC1vevp2xWsq8sEkQKUa2Z4w4ryULlYerWIOA9NDDJlbVjn9OtF6E6zWb9G9d0/kIBY0XzOv3BmHHWyjm+NUEWICvKGTnAQikbId7FLw22+9Vbgn+HsyYUAU3HDuzEDdk983kptx6+sgagf8HilGjZkUqowXMSz0gpzd3KL7GETuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 04:19:23 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 10 Feb 2023
 04:19:22 +0000
Message-ID: <d5b5cf43-0dea-da68-1417-3d12e4a4bce8@intel.com>
Date:   Thu, 9 Feb 2023 20:19:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 23/24] Documentation: x86: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-24-rdunlap@infradead.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230209071400.31476-24-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1771026e-436d-4ffe-ab9b-08db0b1dfcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPDwgHHT8BXnErSHH1w7jKd66rkPEMzuNSJRAjpk0Pb1e1aZXeGeejYQlx7wblHvSrDt0EJpuBuEv+xcz2ulDBcmNaVJjB/WOyeD0/yX08z5H62RxxlWQqGAGJebyvef1wZZDzoEZ2aSJyE/xUWlaCf7zyuOuyJhx7r09zzHP8GD3+vAkmpCJ+zz8noStGAKvJYxBEeT2FeO7veuypJyVNFD0dlMMENH265WGWBlqD3q3h9u7kLnFdsh1MTf3Ih/MaN8uNiewOHfsGyvvtzzxfNcb+tp4yM8rejWyz654supE7ynzC5F64mgt5Sn+n247rZAa8Oh22TQY/mmcT0gQoz34mo8Pd5Ue04vm4Jsvy6uVrMvoSwY8+hOhK7vmyi5tq+R99CJg8XrTgGLwUP5v6fAniPayge7EY1EDODaJI8ujaojB2D7Hh0DxeryUcEriqtPAy7fXgu6ySTxfkJm1rLZ+ekBaFjSu+jveQsMsAlPWdJNprj1aS6XefjQh1+FjX48Q6ZPgiyp2pPewvj4WTBqx9p0Ou9crVUb0W4sgCpuU5WzH3ZfQzsi79sfzATB/YffwB5sk1XcZTToaasC5m13oQ9gTFaTKILrQPp/yGLpiwCUhHXmJn8Kg4mh9qRH1uCOZPKGK1PFhAN8i5YNeT8YvM20amUGlBQFMF3DZk5Y24Hj4DA2NJMf8kCO+PosjPMAsqTgUxxeRf7ueZPAcY308ugo89qZHX4IWCfmiR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(31696002)(86362001)(82960400001)(4326008)(8676002)(66556008)(66476007)(41300700001)(44832011)(66946007)(7416002)(8936002)(5660300002)(6486002)(54906003)(316002)(2906002)(83380400001)(38100700002)(26005)(186003)(6512007)(6506007)(53546011)(478600001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1RzSGxKZFNQK2ZKTGdLM0x1RGJXME9LcHhDazdWa01OUjNxQkVtU2xEbmY4?=
 =?utf-8?B?OGF2czdxRVlBNGRITmdySzJISmFNdnU1bEIreE5nY2xTV1dkbk1jUTU5MURa?=
 =?utf-8?B?ZGR3ajFjMzdMYTk4M1lVZUVsb0p5R1VKVjR2WTUzZzd4a1ZZYUpodHlsRHpK?=
 =?utf-8?B?NmhrRjY1UTJUSmZyMi9sMjNBb1IvNm13TFFEUFJtRUMvYkdubGpzVmdSVGZq?=
 =?utf-8?B?OEJRWkJVcHMxbFBmSGM5bjR5LzFubmtHVWQ1S01WVnVXWTJpVnV1R3FSTG10?=
 =?utf-8?B?NVZweGZOZHZzOUcwdE5pTUF1by81NkVyQXNjamc1dUZYMDNZbGhJNDRJTUJI?=
 =?utf-8?B?TGo5a3JKNHpaVEEzOUxtT2s5WERjaER2Q2JzWlNZNDA4SlNTSXNHRGExeGhx?=
 =?utf-8?B?RXJ0WmVVY3hJUFRFNWt5QXlvcXdYSCs1a2RDYjN4TmR0UjhBZlEzd0M1Mzlw?=
 =?utf-8?B?b2NPdGtPc3V4Vk12SXY0YlFnVFdPcjljMzE2cHlnRlhpRUozUjhwNW90U2ZT?=
 =?utf-8?B?aTUwMW4yYkdwK1ZqNXJRanFjTDFEWVcvWXVtQjhSc0wwby9PSVhDNGhlVGlO?=
 =?utf-8?B?LzhOL1NqeXN0VnhNL3FqZi8vaVU4ajJzekJZUERKYTJRZXFKampsR0szdm1i?=
 =?utf-8?B?RkZoUzZBYlI5SmhPdVdITVBLUUpxbTBFcWp6TE5VRHl4N3VGYytGdWhTaFZ1?=
 =?utf-8?B?QW5yZkRDWkdkUFlobnFWU084UksxYkVXYzV2elFyOWxiNEtpbVB2V3N2bmZT?=
 =?utf-8?B?K0l1cGZObS9VcEw3MHNJeUxuT1RVSjN3RFY0MWtqN2J1YU1oSUphQk1lWHF0?=
 =?utf-8?B?bithWDNGR0s4VlU0MUVpT3BaYjcxektnTXdyQkpGQUZ4M1ltRFZ6K05NTVBP?=
 =?utf-8?B?ZVpKNnlydFRiQnFPMEhPamtDMjREdjlMQVZjVWdlZk01aVhTSlE4Q2ZNZGY0?=
 =?utf-8?B?b2dOdzMwTVBDSFRzazNJQ0M0YTg1VnYrY1d3VWsrZzNKUlhyODA5TTJoQzBS?=
 =?utf-8?B?dk5xajh5UExSWHlQQzJEZkZ6OU1BZjlnQlJvRWJCRTYzanNaQ2JzOWR6azNo?=
 =?utf-8?B?YzNxVGhBR2QvYlRrTXFkTmNXdHRYQXh4MWJ4c3g5RkVla2diNXFGNTdDT0ZS?=
 =?utf-8?B?Q1FaWmtIY2NQZnJUaUJrSFoxUGpoTnhZMjRwcTN6R1k1UXgvdm4rV3dmaGlS?=
 =?utf-8?B?TVVodyt4YzFKenVoN0U5V240eVNhK1piWDc1WkpZemxRbWVIZTJONVpWWFZW?=
 =?utf-8?B?Y09yTXBHWnVXQmwyOHhBUEFpM3FkM01xMXJKdmFUZ0psVFBERUNUcG9wbks2?=
 =?utf-8?B?WGdOS29SQW9pVUg2K2c1Z2x3cFV5UXFoVVFWUkZ3QlFKOHpacUpEeTc2TjFq?=
 =?utf-8?B?TmN0Q1JxTHJkcHlwVVhsRU00aU5lYlBJN0xDZEllRHZKbzJLTXY4NkhLWmxq?=
 =?utf-8?B?Yzg4VGlBUXc3Y1ZPSnIxRHdRbklEaFZHRzFuTDR0dEJyUXFqekxPaWl5WmxZ?=
 =?utf-8?B?VTRkZTVxNTVIN21MY0lkQU84bXV6aUhHVDE5cU5XcVhQa1VZT2xmVWVhMG9B?=
 =?utf-8?B?bXlISThLQ1NKUzNERzl3U04xZzJRb1M5dUg5THRKZVFQUlJYNjlhVTNpRzVS?=
 =?utf-8?B?WnBEVjJBQzJGbVEzR1dRVlkrLy9RTTlOTEZhNWVWczh1cnJVUXQvME0yZlB0?=
 =?utf-8?B?dmJiSVV4dm5EUHRydUp4eENaU3FEb1NaODRxbkhmQTJJV0lFZmIxcTZNakpw?=
 =?utf-8?B?VytxVk15YWswY3BWM2VPTmhwZDAwdnBnRndUcEdVUm5lQXFtY0pTWFJ6T1RQ?=
 =?utf-8?B?VFdKMWQyYVpma2ovRGNBaG81SWFPNHRrQ2VOWlZ6Q0FZa2tKRitqczhKdnRG?=
 =?utf-8?B?bkRVNVhNVmpvSm9YekhaSkFWek90STY3Nm9ZTGtjWXJ1THZDV0tJaUZaaVZv?=
 =?utf-8?B?V2pkNjdoMVJzTkpGaC85cGFHaHFHZzlVc0pQemFPY2w2aFB5WitCOVh6cSti?=
 =?utf-8?B?cXZIck83VlB5RFNpdGQ2dlhNZ2VzSnN6VUdJRDlvNVJ1MFZacFloQmJRLy93?=
 =?utf-8?B?aE9QWUZtUHdONnpTSyt4ZGdVY2JLYzM0YWcwSlExSXorVkVtNVpGM29JNVdG?=
 =?utf-8?B?UVlKa1puSlgzZzg4L09rMXZrZktnVy9IZitDdm5BZHFsZDN6NjA0dWhRa0Rs?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1771026e-436d-4ffe-ab9b-08db0b1dfcc5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 04:19:22.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7IN10YdSEFoWw6/2FBYc7oe7uFroJrBNuPUrK0MkynFdF7XTz/+obmyK8PSqC0F0MiunxGtSXv53QKzwcOfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/23 23:13, Randy Dunlap wrote:
> Correct spelling problems for Documentation/x86/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/x86/boot.rst    |    2 +-
>   Documentation/x86/buslock.rst |    2 +-
>   Documentation/x86/mds.rst     |    2 +-
>   Documentation/x86/resctrl.rst |    2 +-
>   Documentation/x86/sgx.rst     |    2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -1105,7 +1105,7 @@ The kernel command line should not be lo
>   code, nor should it be located in high memory.
>   
>   
> -Sample Boot Configuartion
> +Sample Boot Configuration
>   =========================
>   
>   As a sample configuration, assume the following layout of the real
> diff -- a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
> --- a/Documentation/x86/buslock.rst
> +++ b/Documentation/x86/buslock.rst
> @@ -32,7 +32,7 @@ mechanisms to detect split locks and bus
>   --------------------------------------
>   
>   Beginning with the Tremont Atom CPU split lock operations may raise an
> -Alignment Check (#AC) exception when a split lock operation is attemped.
> +Alignment Check (#AC) exception when a split lock operation is attempted.
>   
>   #DB exception for bus lock detection
>   ------------------------------------
> diff -- a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
> --- a/Documentation/x86/mds.rst
> +++ b/Documentation/x86/mds.rst
> @@ -60,7 +60,7 @@ needed for exploiting MDS requires:
>      data
>   
>   The existence of such a construct in the kernel cannot be excluded with
> -100% certainty, but the complexity involved makes it extremly unlikely.
> +100% certainty, but the complexity involved makes it extremely unlikely.
>   
>   There is one exception, which is untrusted BPF. The functionality of
>   untrusted BPF is limited, but it needs to be thoroughly investigated
> diff -- a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -487,7 +487,7 @@ this would be dependent on number of cor
>      depending on # of threads:
>   
>   For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
> -thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
> +thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
>   they have same percentage bandwidth of 10%. This is simply because as
>   threads start using more cores in an rdtgroup, the actual bandwidth may
>   increase or vary although user specified bandwidth percentage is same.
> diff -- a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> --- a/Documentation/x86/sgx.rst
> +++ b/Documentation/x86/sgx.rst
> @@ -245,7 +245,7 @@ SGX will likely become unusable because
>   limited. However, while this may be fatal to SGX, the rest of the kernel
>   is unlikely to be impacted and should continue to work.
>   
> -As a result, when this happpens, user should stop running any new
> +As a result, when this happens, the user should stop running any new
>   SGX workloads, (or just any new workloads), and migrate all valuable
>   workloads. Although a machine reboot can recover all EPC memory, the bug
>   should be reported to Linux developers.

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
