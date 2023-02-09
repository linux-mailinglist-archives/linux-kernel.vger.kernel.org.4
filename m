Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC5691447
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBIXW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:22:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1D420059;
        Thu,  9 Feb 2023 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675984942; x=1707520942;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PREazefhZvrAh//ahKxapzaAtxl4K5lavGUtkTFx3xk=;
  b=jMjxMyfG4eWmgL1CU5GBHDl+/VIIC2viVsCrM+FzzvX6lGGLcZv/yOQu
   +n22j8P5BoVvd3/rQBDsNLJ8gz1oYaM8rbSgecssHMEgrEmtBcHs6DZG/
   1q0pWGhL2aLfALMm6vL67lmu4M1ck6Ym+MXkzOKF5bGzvh5pIVNvEu6Xq
   HDO81B9qw0Hj1gd+ohMBLRQrWw+ZXDvWe7E/SFIon0XoIMEFv2qhNLCri
   Ee07wY+KcBxmZIx8SwJwSgB1EjGkLocwx5KADVD1VVqa3aJWCq+O3CLdL
   B+P4/Dyt65u5N4cU9gwfwX+QCVOWoU8zLS3N8cUKk25nRTKSqk0n85zj5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416505787"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416505787"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756588918"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756588918"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 15:22:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 15:22:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 15:22:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 15:22:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssx39bYCMeJ+cWZ1My8SAePDVkJCXQ3NEh4eRE947th7y0Pd5zkH6PrFLjyMD8wukI/MFkoBiLvgYsuEfZIqId146mi5a94pKAEXCTXEyAs5GtAhgaELlW9wPjjgvSkiGpcyqaKJu4vLZBhar7xUz9Rgc5ovH0ToKvkYnUyWKmLui/V5/2Wkwf15PTaKj5lDjlZ2+dWHZzeh2Yj0U+9CeTHZ3rILrJ1U9kd3yfEOovvQWdbPx7zfjbxmfFSaoh11Zof6TwrGxaDAXbHkFvHNFMDs9nI3Zki5fKedmV/PT8ee7YLFNMZ546GVNCAdi8oYqbnsuYZrxMhVaxG2mL5VYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+AagrhkDb/y1PuVmMf2xAGPQ3+abGm//1k5bjHbRNk=;
 b=SPeBGaC1ZatNtaUxhsv25YdMOM/jEj5miQuMQ3Npv9tag/cZykSYXg010TIaHGvOg/Bi2yo/ShnEhSjiNYcv13b8D71L2kEbNNl639D1VTN2OI17+dDLTovGUIi8kX6hpj+wr8nk/LamCdGE4cokaHRFbbJjX4i2vdnyIDW6YgroeEMz9fvmGWDdJvZRerx8ayXjKKtEFirdeBfRUeOj9PzuKeEIaJgnMgT4Va6F/NhjP1d8DpnGcAzsxm6Vh2fXkY3ReIeAm+x09ff4p9tJEBCu7kjXdW8JB92j7dE8BaARc5p6gj8+msTKsXI3BNivG5q35CVgtdv52ZQzE0pyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 23:22:15 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::41a7:eb5c:741a:e84a]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::41a7:eb5c:741a:e84a%8]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 23:22:14 +0000
Message-ID: <c2e6b364-2678-a7ea-f3fe-e1aedd169a23@intel.com>
Date:   Thu, 9 Feb 2023 15:22:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 23/24] Documentation: x86: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-24-rdunlap@infradead.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230209071400.31476-24-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1404df-0376-4ab8-12fd-08db0af47a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+zJDWJVfiYdCeDEG/J+8MY5yX9u4c2NAzwPyW+KYy8JwLQhx7h1VDPewFUagSfPEGpT1XMSjq4s2hmDR8laKhGwQD0DA/FhZ0Ap3vgZYsxfFEKicwSYOomg5Enr3/M0gXD1Tuu4SSvr2PmzlwyvROMLNpr14KqinxoLF6DW5TqCXU09nvzB7RXeufFbHTKOJoOK8qgD47+RB+pefTR2heMORvXi7i2nwM/ekAM1ya0weC90XiZbZFQ6/pF6d9a9nT1mT8V+neMufoJWbRWbYNxMwBQFyp+pK9HMVcYoH0vRDA1m6zsAY676q2majJFMr7/TmlHnKcxzjEc2QzCjK4q4VELdVUiNKkPDrsLCaH1lejAAvrs9qXtcqZG4b947UxmraSlv0xD0LrMFMznXe4CRzS8nEDaoaxfOY2k1j2T2B/HSj8GmpWguJiR4TnlXCndPkN/gdzwGAWCzfVLPenffwA+bC1rC9xukyfa0CgZU4y8QCgB2rjzS+SEzXo3CXgJL/+ykA06MvB6Td0LBf+UoGqyZZPt3xdVt3asMGAcYTExhLLqROoaxknNx48htjcwpjQqHb/1GeIB7VxR9nWoDflXF0DE85+UZ34WGNnbQdXpj5ONLwDUG5k2lNUzdRvzs8MdGaGUpNoLhHX32KmS0q6n6dsbAqUQR+2IU4ylkidUMTT8J4Vd2jj/dERiScgPAS9iRlRLcdro4qiXMggHN2AVRoAKPJxUT/H5h+68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199018)(2906002)(44832011)(26005)(7416002)(86362001)(6512007)(8936002)(2616005)(5660300002)(186003)(6486002)(36756003)(478600001)(82960400001)(53546011)(6506007)(31686004)(31696002)(6666004)(83380400001)(38100700002)(66946007)(316002)(41300700001)(4326008)(66556008)(66476007)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUEzRURPNkMrbFJVcTNzSkoxUU54Q2Y5YUxEWmNDaG9ERzJWeVRWaVkwR09w?=
 =?utf-8?B?QmRQQi9maU9Rclkxb29DaGRXR0hwd0ZENUhaSGdZa1VCcTRCdE85a1AxMUxS?=
 =?utf-8?B?Y2JEUjUxRk03cWVkVlVZZ3dHYjVhYmhYSW5VL1MzZWZ1bUxYQjk4YVdBK0lZ?=
 =?utf-8?B?SnFNU1lPTDR0SzZxTmJKUXlVTzNCWnRYbGY5bWx5dTRIaityN2p1ZkxsQlgx?=
 =?utf-8?B?U2RlNzQ2ajVTWmtmZnZIU0dLbTJMOHNiUHFKYUx6TkVzMFdYeHRiQjVRcVNZ?=
 =?utf-8?B?aUJHWGhTUUZDR0dzQmY3ZnRtbWdCRk1JNCt4SnNzYlVTd0E2bUZaZmVYS0hC?=
 =?utf-8?B?SWNPQ2xNQnBZdWNZbWRDU0NyNG9tTHFSNWt1S3QyWGxBWVBSL3cvK2dHK3Jz?=
 =?utf-8?B?NXIzeXkybzcvb1pwRk4wbVo1MzNPakhjTnI1dFk3amkxOFlSNXhBZytTNU5j?=
 =?utf-8?B?ZmovRVVMRmUyaTZ0dnhScFdkUWc1SEdNK3Y4OXpYYm41ZkFpUFJHNlFzUlFD?=
 =?utf-8?B?N1AweFRYbVBLNTFMQWtIaHBwY1J5VnphVXlIb3B6MUZ6dW1rVVFuSWFxR1M1?=
 =?utf-8?B?b3FicWUzNmlBa2hvUzRLNHlWTmxDUGk0TVp2cU1PQmlPdGxxMWZLSlVrZUlr?=
 =?utf-8?B?RjdDSlhIVnhCcS9JekxYYU1RbTZoL2R3NEZpSXlpMnBzWEs2eHpHYzZuM0pz?=
 =?utf-8?B?M3dGUnk2ejVCc1hZNE5CU0FQQUpBYWRoamU3MmlZNFRaTHNWQkY1aEpPMEF6?=
 =?utf-8?B?TStxZTNzVTJpdDZ5Y0o3WUNUdnhTT0JDK0N6ZUthUytwbmRVYTJPVGhXVjVB?=
 =?utf-8?B?bjZobE10RnBYVUwrQS8rcHozY3JQQjhvVWUrM2MxUXRlcWRvNUJrQmM1ZjRi?=
 =?utf-8?B?eGVrdjNXUHdCY0xNaHM3bW9SZXpRc1huQ0ViMXlLQUNzenp6OEtoK29hZmZH?=
 =?utf-8?B?TWJ0MmsxcFJxK3NWWWFCSmpuMk9BNlJ1N2lnRmx0YzZHM1V2UXk1d2w1MUNB?=
 =?utf-8?B?KzZSb01RZ29PRXgwK3UwTVVIRmg0YUlubUtWdXhHbGdTQWVOODB4a2dKUHRC?=
 =?utf-8?B?QlRneFlDeW80ZWk0RjQ0amNpZ1FZNVZNRkpOUnJ1M3h3QjUraVZvOVZPNXhG?=
 =?utf-8?B?R3gwQ1k0L2VUSjVjMGo2Qldvb2Ryb1o4ZFJLc2ZrM2l6ZktQOWVMdURhb1Bq?=
 =?utf-8?B?Qkxtd0NITTdBSnUrTG5XRThwNnhldXQvelNCME5BS2VwQ2RYelN5allLamFB?=
 =?utf-8?B?SVQ2UHlFWHg2WmVpbGxSNEZsWEVHaGI4V1FNU2JMaWFiNCtxbFVza3RwdUJy?=
 =?utf-8?B?VTR3RURiYzM1QVF1c0huVDlpa0M4M3RuVVlzODg4N3ZBLzRvTi9DaXJMTDh4?=
 =?utf-8?B?a2RwTUdoOXF4a0E2ZWo0YU1ncGpzcExZclpxZ2pqZ1hObVl0S0FsaXIyVGlT?=
 =?utf-8?B?NnBwVFRSeEpSSGJsdzVUcGtDWHdUSXhOTE8xaTR4eS82V3hWbUFCaWZ0YXl6?=
 =?utf-8?B?ZURWQXg4ZG83RWhpU1hhOUFIdWlOTlViZnYzVURxRDdGVDhmdHFZVFZwajMy?=
 =?utf-8?B?SEY2SGZZSndQdklodHptSWM3bEZZd1JGOG4rS1lERG5OTFZ4US9Kc3VLYVAy?=
 =?utf-8?B?a0VCZkY0R2JpdG5NTHN1cnJsdzRnUUJrbFhCMXpJb3hhME5yWTFaRktDMjN3?=
 =?utf-8?B?VXFpMFRHQXFRTFk5REZWbUdsR1VONGduemlNZFNwNnVnRHBuVGdUclVpTFZS?=
 =?utf-8?B?bEdtWmJlZ0xDNEozL1I4M0ZBL0FCZ2FBbXBINWYzdkpXTkFJa2hIdXJhcnBP?=
 =?utf-8?B?a3dKQjltbEtxSVVkTDN0NURYKzNOcmZQeHh6YzNMdDRvU0hiM3pRYzd5WVJO?=
 =?utf-8?B?YUl3Z1cxeStzR056WVFwRUE5a28xbmI3OVN6TndhaElabjlkZkNDWU1wUU1W?=
 =?utf-8?B?UVM3Q0ZuVHNiOVN4OWdlNkJML0ZWT3JySkdnQkNYd0lSZ01NZkpYN1JLVUQz?=
 =?utf-8?B?NFFTcnNwTEhnb29pNG44R0hTTUpySXRiWkhSQk5qUnpySUtXTUVOaloyeUFw?=
 =?utf-8?B?V2QvSWY0TW0rZFA1bGlqOXNIcnByVzBiVHNDS0lJRkR5V0VXS2RLdHFjbG9L?=
 =?utf-8?B?YmwvWnBtQmY1ajloUUhpQk1jKzBJcG9ld3VXcVlHRzRYaTQ1M1IvcVpZYWUv?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1404df-0376-4ab8-12fd-08db0af47a71
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 23:22:14.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXcQOw6kjZ6dDMdcYJwubE6nJHOphcAvgVKNM4Ui+Jk+nVo1AFN+dYINcyTJA17d0PuyXgejrGWOSq12d0EdqJWDqVh0Ae93hxY5fSyfSpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
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

Hi Randy,

On 2/8/2023 11:13 PM, Randy Dunlap wrote:
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
>  Documentation/x86/boot.rst    |    2 +-
>  Documentation/x86/buslock.rst |    2 +-
>  Documentation/x86/mds.rst     |    2 +-
>  Documentation/x86/resctrl.rst |    2 +-
>  Documentation/x86/sgx.rst     |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

...

> diff -- a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -487,7 +487,7 @@ this would be dependent on number of cor
>     depending on # of threads:
>  
>  For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
> -thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
> +thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
>  they have same percentage bandwidth of 10%. This is simply because as
>  threads start using more cores in an rdtgroup, the actual bandwidth may
>  increase or vary although user specified bandwidth percentage is same.

Acked-by: Reinette Chatre <reinette.chatre@intel.com> #resctrl

Thank you very much

Reinette
