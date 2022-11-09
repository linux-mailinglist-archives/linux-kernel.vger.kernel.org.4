Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD0462375B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiKIXQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:16:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4B55A8;
        Wed,  9 Nov 2022 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668035796; x=1699571796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Qh2uukMfBGdtrL58H3G1iPL3AsuycTeYF0vbmQcM8Q=;
  b=MbgNoCUBvcNYW4yQj77MOptpPCXRfZWADyq5lKZ57LYnmyjIr9912Yjh
   ElwNitPgHLda6iZ95WILM3ehutuU+tCk/5GNFOozJjjHZd2QfaSzRZMdd
   Ol9Kvd0PSz919B/bJHGLedEeItwlFn17cD3hsJ0cb3xXdP1xmteSbR7qd
   DAqcJ0xodEO4QgdXhTJpFCYuA+8Pp4KJxsukHbYWWnwP+nNyZSpsIa/m0
   L3+KJ1/ZoK+Vdk/r+Mh+9ztlDI4hVkrm9TA3QybWUxaV+8NzVj5i0eWi9
   mztyf6LG/rsHLetqAMpAIwjio9mlJYgp2WNBtWwkbXarw9b/AWooYwIAe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337898640"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="337898640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700558158"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="700558158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2022 15:16:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:16:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:16:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:16:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg6LOPQvi8P4odZwectIpxetBctugw2LMFxUgn+VLrNGSncJz9aiT4f101gs5XoiXcLXus+ntzGrjcQf9ayRNPGjbKCNChMsrE+WPNlr89l9HA/2OeSxgPnvRDUyzsUCCWkYYgPZGD07A8KTtaWAkMcxidSvobIWoeLxOQwGsu+p7VQ5dlEkiOj2eEThhdEBl8hH3GSRp0+hXrJ+mcs8+JjfAGSLcWc+yR77CkKlmyvObh/dVqfmFQ2euhLcQLnWbaqxtBv7npCnLMKRZQSk8ayzriPB2V2l7Tt3gIv/ge6ptdzuHAdBdCzAELzPxVn0lcyePGQEu+0J8jYoD2tEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0wJwKabN2w18QHad3iddpWU3iV/MnjaVP1ONJNtO8M=;
 b=EY+bOrlLMeI5M8vH2ZjFA6PMt/zuVx9jBR6uTJX2OSpUb1Z3K1iE9PX5THBaN863BYY5hS10p9taKjcBxxx1pj9HiHk/uqiabY6C/G7i9wjL3PNc7/OquGCSZCmYnomYoyrBW/EPi0HLTGPmS+pQmtXAxBnbtcOM5mH/V+/Yx4pJ1XDZjYIm4tK4Iermyqw3OrcEFl2Gk6PYo7c4dmdH9uKgYes+jpcSpeUCw6z3Fsv/oWKD4GIrdJUi7q9MYaB5i46oVVdUtkm/DgIo/j066SKAq4AopQJEoYTwEPobvmyLhAgmN2UuntkJqAWEaYX5q2qmWE84ktMUHmDLLhw/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 23:16:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:16:29 +0000
Message-ID: <f4d985de-6f50-ca3d-84a6-85f5fa55cdd1@intel.com>
Date:   Wed, 9 Nov 2022 15:16:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 11/14] platform/x86/intel/ifs: Remove reload sysfs
 entry
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-12-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-12-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 15afba64-9c38-403d-1990-08dac2a86e6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcwjZkay4ZCH48CeOD4qXg3s111RUC5+P/Qv3tPUHTnfewaCvjwlqOfrHvQYYiLjovAFe/PINZ9fAaLzEcBkJ2sC0dt+LUhWSEL7ROw/ovVKSZzyQyJuvSaqGKBlrwn5shB6wf5JXSdyaRj1fTKnGjXvHXp2N3Us24PmiOO1R3kZcOuCbh6+uCjVaV6/dPesPbCgIEihfHyASLGfCmXGuclTSO0Tx1oprngahsQ5eqTY2BL4V/OjIPCjyvKBekOpD/vShh/TrM3eWS964vbmpYSY/q6oNodUMaJcgmjnk/LeiqrALKaVKxKdinKHV7SQ72Mk9rU5RS2B1KpClEsN1C1A6FAARom//M3Uh2bXXXrB7Et/+Pz5CLDDiA+X8IHgssH+IS4/lJLnOGnTAYBCJP6+pLTiZzI5tbUjaaWi2YutxXf8gVHwOLxQ7hnYzeIDlX2vtJUmCTfq3BG2UyhspG1S6TW6iF5Q8ArIhgGOqpe+91bGd8bA2NUyKKk1accLkqj33cmErBnJl7UT5ZIN4IPDXKiz6UCqhHX8oZoYmDykRKkQqdzaF1hxRCr3dsr9z+E5suzXbOcUIav1rDt8Z9hwFDDcHDqM2/TBJD1ELA2hrll7jA3vP88fyomdRldM8SD4/BMzJeKJ2cI3FhH+cZSqjHYI24ZYZYTKM9jOV31dasesDsKOnwKHGr+oun+sWJ3mJ52CVt3QVT+BxTU/Waeuom/5SusjOCoTkBDEttGppjXcTT4WkWErv6cfmzkEgt7h1XvZXZBBfWiCUp7RmGiK1v2gvwOAbgeXkZesX5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(8936002)(478600001)(5660300002)(186003)(6486002)(2906002)(31686004)(7416002)(44832011)(2616005)(36756003)(558084003)(53546011)(6506007)(41300700001)(26005)(38100700002)(82960400001)(6512007)(66556008)(66476007)(66946007)(8676002)(4326008)(316002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmpKT3ZYdWp0NHpDYThuS0NIQ1FUMjlLT1A3dnJ4UGtzdFk0Sm9hdVRMaHMy?=
 =?utf-8?B?QjNJcHpsYWtBTmdBcXFldG5oWkRXbVhRTkJwd1JKQWJvcU1uNkNRRk91OVJ0?=
 =?utf-8?B?YVN6MnpNUlZicjBiVGNaMWZHM1dSMXJRRnNCbmxyWE00QUp2RGhpdDZueVNk?=
 =?utf-8?B?Zk1xSzVpektQbGUrNm9UZU1zekdYdXVENDRXK01WcnNCaFFPWkZ4Y0FiclNo?=
 =?utf-8?B?N1hkVW5yS2xEL0lHb1d6QndLNEtzOWpsU1Q2dnpJTkVjRGc2anV2dC9wb1p4?=
 =?utf-8?B?cEtEVmlaRk9saDdwdFFKcCtkc2xpMDNFYVZyWFp2ZHlaSHNmNU1QTDdWS1NB?=
 =?utf-8?B?U0srbmtySnR2ZUx0N0I3MHF2OW9HVzNFYmhyQXd1RFlGODFRV0MyaGJKY3Rk?=
 =?utf-8?B?dTNqUzJUUGxVVWlGa2NyMmgyalpyQ2VjVS9BSCt5ZUpPekdkc1E5blNIdjU3?=
 =?utf-8?B?dGVaaU45Rk5QYUNmeExrdTVCNHRsS0xmTWM2VUJDWWJFOHcyZkdnaUdBV09O?=
 =?utf-8?B?RjRyczBXWENtUEIwRkZ5c3l5QjVhaUZMMFRKTkNPYjUyQ2JvZmV5UmlHS0Rs?=
 =?utf-8?B?S1p1aGwrbFZab1hZci9GYzE3U28zanl2dWMvb25xY0NaQVZxQStsam9rVG11?=
 =?utf-8?B?UVQzOWwzY0VjMkRESEN0NWR0UVJrQ0dkekh0bTd0djhWeFpZT3FPSExWRFow?=
 =?utf-8?B?T1k1elJrYTlkUWExd3pPM0Q1eGpYeTErbDNIOTJha1RNOFRNeXlkWXNWWGha?=
 =?utf-8?B?K0FNajBWUDA4SGlDNklheFpPQjBqamxqT2MvczlDdUd5S0k1bkZwL1pWTXZL?=
 =?utf-8?B?MnhVOVNNNVJ4a3pMeEN4S1dvY3BpUVpiblJuUVNObVNNS0xGVmpndldFalAv?=
 =?utf-8?B?Si81YWtod1BGeHQ4cFZjSHBPNFZSdFpuVmg0VDI0NHJnK1MxUEFxOHV1VWZM?=
 =?utf-8?B?N3c5OTBtZDl5M3hZb2pBNUdiTzV2bHBYQmtLUmRhVGFwRWl5NmR2UlNlY3Js?=
 =?utf-8?B?Z24yRVFrVmNzOFM3Zi9kYnh2cURIT2Rwd21RVFJIUGhyU1RIZG5yV3grRUds?=
 =?utf-8?B?c09mdEF0bGREV1NDUHlWcE95MjhCcm81ZWJ5TFBjemxncWlZY3B4LytPQjlQ?=
 =?utf-8?B?TjFZSEoybTlCS0RZc3IzOFI4M0IraHI0eUw2cm1YNnBrV1RDNnBGNStkRlYw?=
 =?utf-8?B?R3JGdVZ0aUhYTUpVZlJaV01HWW4rSUFucEtzTU04M0RuYmVHd3lNc2FSalB2?=
 =?utf-8?B?a0RXekZLdEVOQjJMdGNvN3FyZ2FrbWROV1h2V3EyaXV0Nlc5cTF6ZE8yL1kr?=
 =?utf-8?B?SWhTcHFEa0ZEek1wcStIWjBoZzQ4NndqVVd4NlhtNHN5aUMyYjdONTd6d2Ux?=
 =?utf-8?B?Yk0xdFJCMllBUEc5Q3JITG1sUGRFeUwzR1VWY2JuWkVyK2pBd2JnOHlhZHRC?=
 =?utf-8?B?WXZITDdnLzhWNUkrNGZFT2d6UVdzKzZpUGlMNWpPYStTUDlZOWw3R3gxUzM4?=
 =?utf-8?B?VFdoTWxjcnJEVU1CUmFXTnhPSmV5TUlaTncyTkdEQ0RMS1cxZWRtNFZ2N1o1?=
 =?utf-8?B?blVEZUNNeHFVbDh5djE1NlpHRHRTdUJHT2U3V2JnSDFyUVdIaGkyUmdYUVky?=
 =?utf-8?B?d3BQSGZVeXdRWHU0OCtLUTFXVklOcnJlVnRFUXlhUzdaNGlkK3kvamVKYjJH?=
 =?utf-8?B?WTVYVEI3OHVOYldiOW1rbjJoZnlMZERJcC80S3FHZCtUcGpFSFpnRGg3NUkv?=
 =?utf-8?B?Ujl3ZFJwQUZZVCtWYUVVQWNBaHoyODE4ajJMZFJSRVVGR0l5UzltUGVvcUli?=
 =?utf-8?B?aXVTbnZnVFJGaXVRQWhSTFJvSzFtcU45Zk1yd1hoK09NVm5DNnZaYUVGQ1Yx?=
 =?utf-8?B?NGw3ci9lWFNEN0pSNVVjOThaVHhldXR4SytyKzhQQkpqZHdvZGtHZVVNWmh1?=
 =?utf-8?B?c2l3UjZDTnI5cGh3cC8wTjk2YWsrTFNGOXZDOTJad3duM3hYNWZrUUF0eDdD?=
 =?utf-8?B?V0QwVERpS2FIOGRIVG4rd0s4Y082VWlGcEdWamxxb0FmV3E0R1JqV1Y1WStZ?=
 =?utf-8?B?SmJXelRkWU1uSUtVZ3ZSTWpzbHcvMUNGb1haVFZRVmRvRG1haXU0YjVKZ3lD?=
 =?utf-8?Q?LAdhF/CZeqNaCFHJ0su/kakHa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15afba64-9c38-403d-1990-08dac2a86e6f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:16:29.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiz/wMvPXJCyumTbHm1AGZGT/86oLRCoXrgos58BbVg/lhiMhyQxdkGHoESPcQ29x9SNAzGBg9vWi0yZCAWG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> Reload sysfs entry will be replaced by current_batch, drop it.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
