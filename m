Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5154A67B21A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjAYL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:57:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B43346B;
        Wed, 25 Jan 2023 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674647856; x=1706183856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLBGkQokqny9dgbx/itT4fRJwXu9cizrTkCBngukhm8=;
  b=FU5BtYvpoC9dkK18YZqKiPT3uWKszskk3G9DV52s1OaYcaKFcTFqDTwG
   g0mFe+SYwaA8XBBWVQPDNLynusCYhtlwU6GsRt9sZ/shAeIFEc3bh7cPL
   Obl7WuhCy/PnNZ85MxpSqKnzLLD75Qb72SGakt9HtnLwUd8sK1Yb01G0B
   PLe9rSaSBkQDFbuDmsTrMOKpcxTsy0qb/aNXN2kFV/mQjA+VNQ7VwnvuI
   qyN0VDQOXpP7f2mmDQDkumeHXjrD3cvg5A6Dc6dBF1TUwAOuljT67ULHh
   0WERYEAw1s4knFjkadBGmFzKVtzStHHcpESD8JybsrFt7NVSPrvVLJqme
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324236534"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="324236534"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694713800"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="694713800"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2023 03:57:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 03:57:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 03:57:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 03:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2B9prwD4Ip3FWGlP2out55g0Myvv0QYgOIP6mx4lzfwh9xdZaa+qoQnOgK4j9LC8o1Px2GBjNn51NhAjb5yE+ienj76OaAuU93MdxqD1kLr+v8keoPwPOqswIw+qI78mTsXVofMIAnvxhY4xIDG19wzdlmncZQ+l5uCA7Wd3LoWJKoRrgGZV2lVE6yIiQnV8CwV5r+EV2+iiP0BLIjcTMAFlkBHgOSm9wTEjafhjuWMQhDL8ATZ3DKXckEDFF3aZpuR5DQyKEjibNRVEcINBGIQhO7U6VU+pzVnHJXkxdxcF5r5TeCVx4H5z/eMdSnSEwH1yLYOMaoun6DeDOOU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoCCxHZbWPWmKozmfqDprkEeXqnzMNH6FR7elEmhvqs=;
 b=DJws4IvkusHQNUrSR3Iu7qhK0vJ1ueMBdt3pmZihd6JqAC/QQAPuNuZyAjhFnvW9x5Jc7kfk191IPMehaoHsKwGrasGBTDQfCj8NKQGI5hKL+xao8vT9sbRQk0bO1j2U7UCPd70hFA/0XnNMZRYoAZ6HKJISCJvlsHra6S58OzOz1YRHX/czYLMtQcfYzFkGoUYLpXQnuTYcUpFC4K/LbMHOv/qMhfcT6uz3cbNY/spw7jX39UVpOzwHQWqDI2XIZeAReV7UyKSn4xedah9tQuGaQdO235oAxYhYpdx/yyUQwwOi2KQ+ULZppbk1BxcJ7v6RoERH3/nyDG0cABqtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 11:57:33 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 11:57:33 +0000
Message-ID: <bc2f3bec-43c6-ede5-42be-f06babab0ca3@intel.com>
Date:   Wed, 25 Jan 2023 12:57:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
References: <20230125093933.518d9010@canb.auug.org.au>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230125093933.518d9010@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::10) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DM4PR11MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: e134d08e-d21a-4b58-03d6-08dafecb57e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TfeuoiE6gxxjlTwp+5oGZarKn9RqElnqJE/0gz101QExQHzSkKxeWOMm/T9KA01OcyCEjnwh2RtiQsz8PyiwcVtVyjFlwQdzRDVEMJmzV8NHx9S4yoKjWwvdgblRuGPNhXSRjY7IFzT6vHJPFMdz0+OJWNHTl5od3BiuqcS08VjA7QLM6ELZ4x8zPj9/mM4q/DrA0ZcCBDApCouxrWP5BHtPp7h9w7QhVc/vZytA5V7BqKbDJzmoTdgaODOaJ/gMs3Kz7mQYPic4tyX4ZTdlUjR5kPIjcjlfJessT85JrsCVfDigmaWIzjetBjybsKYFJvk04ECOlh3ERCVWwxIHGWFUUzj+CFlle+fFTBycUbCAsz4WpktLCWIerDiYFz0S36Fs+UxHIVNA2QVYdVm2F/b9cShBhcC7+YNhdG2UDTUJidHfXCS5pDBKie1HXiGyqlNO5z81oJJJDcn7rNdGHKM54OTi+q0PlPMNc021fu14OJDuaKEqz354oCD6ZevmKDX27wqK2YcQbJsZ/6gf6y/6OyGy1YwxlU6fvgc6bgAJ0NrUN/iuU/5EV2TH56CxiD75b5K66gKUvWpvD4lREQB87C1Ou8CVRtUq/FAxT5oyeTmQMmJlnk6wW9Pkk4QtADz9EGn1DCbhV8Wru/mmIiK+pxvcf1LWhzruKYyJHDMnsNJWshk/GWUq2/8YvbGVA9AOouYtX/QgE5aPotoYmfhIgZIVNREdUd1vEkRq/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(86362001)(38100700002)(82960400001)(36756003)(2906002)(8936002)(5660300002)(41300700001)(186003)(26005)(6512007)(31686004)(8676002)(66556008)(54906003)(2616005)(6666004)(6506007)(4744005)(316002)(83380400001)(53546011)(66946007)(110136005)(66476007)(4326008)(6636002)(6486002)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVR3TGViSHNGNHdXQXBmdEtyOUkxUlQxakF2d0NQaENTdUtTbHRnaG5ZWWFM?=
 =?utf-8?B?UFFUNzR6OE9NekdIVWJkd2xhYi9xVEVxTkUyWkNPdUdQc0ZtWWFmUTdIc2Ey?=
 =?utf-8?B?Q1hVK2g2REVoWjh5aTVhOVZSd3BZQmZERGxNRSt2UEt4R3JDd0k5TjZyVUFR?=
 =?utf-8?B?bTBKZngrM1FCOS9lb05LNXlReWN6dHI4OWZJWUJaL09qK2llUXpQK2tiOC9H?=
 =?utf-8?B?cEFOYkxPVTBoN09vYlA0YU1NTEpIbnRiajZBaUFFNm1zVlB3VGI3Y0FqRnVJ?=
 =?utf-8?B?L1IvLzhLZDIyanpmY1p1eHNpbHBYQkhIc0VrZVMwL2JaZDRrb1lRc1FqK1k5?=
 =?utf-8?B?NnpOTWYyTDB1Y3FRR2JXNnRGVTB5R2xNNEJxa1NJTXlaaVRmbkVUZWtxN1dK?=
 =?utf-8?B?dHJBVUd5NTNaOUdvQkdOR3drcGh3M2lRb1pFUk5MbktjNFZtOWpJWS9EK0F3?=
 =?utf-8?B?RUJ2M2ZUbEwrUUIvbzd4RjYxUzhyRFB6SzlQRldDazJnWExwYWJaelNHWkpQ?=
 =?utf-8?B?RmZtdnFrbktFenk4R040QlVqdVJwK3Y5VTFPWG5PT0F6Njk5dlU0eG9heWxM?=
 =?utf-8?B?U2NmdS95blhtMEt4c2E5eGNubFVMaXFQdVh3MnJoQkw5MzZTYW5keXY4R1JJ?=
 =?utf-8?B?QmIydDlsNXAwZ0FreUxvTGUwK3J5NmFaeVo4b3l4OWhZMjlPSWU4T2l1K1lX?=
 =?utf-8?B?anJuNXpkU1ZnNCttMkw0ck1mVkZtTU10YllnMzI4S2o0RURtaFdQQXliOGtn?=
 =?utf-8?B?Y0NXWU55cHpLRk95dmdRcDFkVFNjcnBlSXVVNDhCLzRnNEEvTDJZejQ1bTdp?=
 =?utf-8?B?WGM2cEFQTnR1ancvTnIzYXlGbjZ4MkdoSldHMlNDbjROVUhwamtCaTRFelZq?=
 =?utf-8?B?djMxMGphaXF2clBwamJSSjE5emtEZVV6Z0xmUWFmVmp4T3dET01vN29kVExT?=
 =?utf-8?B?RVh0WjJYa2I1RjBUWEhva3BmaHVKRFI3UFlTNlY3UERjU1pyRjhIb3ZUV3VJ?=
 =?utf-8?B?R1E1RnhxaFkwTWJrRHY4cVlYcnkyVURFRnpYZjBXSGRwVTI2Ry83RHAvSW1w?=
 =?utf-8?B?ZHpOR000ZzJPcVl3d0FZckd6UUJ0T1hhUlp5aThJVitYTSswSm1ZR0hkSGtE?=
 =?utf-8?B?NUJ3UVRnM2NXOFZya05aUnpnOXBWaE1MZXAxMHlKNlU4OHo1Y0M2ZEdlUFRN?=
 =?utf-8?B?QVB2c3Bub095WmtHdGVwMHpyNHVRYktpYWhVMUcxQmo3THc1V0MyMW5vY2dV?=
 =?utf-8?B?c0hsOGdheGdlSVphRVg1bzVuZzBvUXdtK3AxNmY4WjNDZGtUQlhjZ1MramZE?=
 =?utf-8?B?VEwwTTZ1SXVUMWRlM0dzcnVmWXBiT1pQZkEzN0x2RG9JTm9tNDdtUU9HNDd0?=
 =?utf-8?B?SGVXM1ByVGF0VFBpTUVaUTUrVkxIamJEQWZ4V29JT3hQZTFkdmlyamx3dUpH?=
 =?utf-8?B?c1JjNlJndHVGMHRFbCszQWZadHlxbjNFM29tTWxHd2JMR0JFdThaWWJLRGJm?=
 =?utf-8?B?STVBMEUrTjczMnM2UGZTY1BvSGlZbTFDTHg0RnIzdEJkYU5hMXRJeGY0Zzh5?=
 =?utf-8?B?MmcvSGh1WElreFRFa1B3ZDZXaERyL245YUhsMk8xTi9qYmk2ZEhGNk5IVk5T?=
 =?utf-8?B?Um42dUN2Tkt1ZWVWVjl6ZGZCdzFSUC8xdTJJNFBBcTk3NVFCK1EzeTJsM0xv?=
 =?utf-8?B?dldDNE4xS3BORHl3ZE1uaDhWQ0dtbnlBZjJEQTB2VkxaSkNkZmRLNlpETFBT?=
 =?utf-8?B?a3VlMlRGa3MwWmExVTUzUld0TmRnVHJmRDJRVm1oK1BIQ1JXUXZHZDJObEE4?=
 =?utf-8?B?YU13S1gzOXNLSXVmTUVJQ1N6UWFQOVBiVHRucWxKSS96SXVUZjhHcnUvWXp6?=
 =?utf-8?B?disza2xsMnk3bXFOUnB4VFJxTVJPSG5mQTUzSWRZaHg4eXBvMVFTYU9CRVFo?=
 =?utf-8?B?Tzc1SHRFd3dFVDVJNDBiSWNYTmkycUw2ZzZjeG9iN3owY09VMnk0enZEclFt?=
 =?utf-8?B?NG02Z08rVnpZTXpSMzM3ZGpNeFQ0dUVvTVAxVkVSYUtjbHVKY1Ewb2UwaHZo?=
 =?utf-8?B?ZmE0b0VzbUk4VVM4YVZGa2ZZN1pWUnRDWGkzUVo4N3ZKa29WakR3SmV2R1NO?=
 =?utf-8?B?Rm9uQUU2ZzFVd2loenYwSVdiWnB3UFd5d2hMMVA5OVhtOG5XNkhYTXFLZHR2?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e134d08e-d21a-4b58-03d6-08dafecb57e4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 11:57:33.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrBL6Ov3XW5tOTGcCfuCOmHkAY8z6k47SLCNZkfKreobhCs1X+Hrqh7fX7/LO6gBaufQ7sEDdjz/I4CTpDsXvFWqZ+qIdfFc6e4hLpcPJtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
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


On 1/24/2023 11:39 PM, Stephen Rothwell wrote:
> Hi all,
>
> FIXME: Add owner of second tree to To:
>         Add author(s)/SOB of conflicting commits.
>
> Today's linux-next merge of the thermal tree got a conflict in:
>
>    drivers/thermal/intel/intel_pch_thermal.c
>
> between commit:
>
>    fee19c692160 ("thermal: intel: intel_pch: Use generic trip points")
>
> from the pm tree and commit:
>
>    9e631aa90c97 ("thermal/drivers/intel: Use generic trip points for intel_pch")
>
> from the thermal tree.
>
> These commits are very similar, so I just used the former version (since
> it was newer).

Thank you, this is correct.

The linux-next branch in the thermal tree needs to be updated.

Cheers,

Rafael


