Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BC733BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjFPV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:58:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F422967
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686952712; x=1718488712;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=kOMmsrSb18ZMBXX51H9+aGe3QLPV9C0OiLp+zsuzS7I=;
  b=PRqZ2v5aI07K/8hLZ2IXGA3dMt1DIcsxvaftjqAW8wOrlhB5+al56bpd
   knEZGrQrU7Muu/i1YzSnbnvvQETZ0E/No5nNxetMdRsv6gTXm6RrNFpjP
   AwX9E6k0Ddc6q2cZqCXAUAB+2/KJGxYwKHqdxiqOec6dqL44FDvGiYUx0
   sIZSGmR4HrM4HFNVmAS//MrXNJ9sm6vjY8TGnYhPszZguWzgR/M+8nZJp
   xYNbwEACymtgEnUOLR+tlQy3LZpi+KS7YYC+7eneVdGB49xSM9zNilJ4J
   mAT1YXWVSRwOKOfdss1cnjHlb3T9rPIzB377F5tiNGa1WcHMSb2nZ5Z0x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422976259"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422976259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663330555"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="663330555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2023 14:58:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 14:58:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 14:58:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 14:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx3nnyWm6a8W0bcDakGbRFCnEZeugHSvBPgETcKW48uikQPGMeMM5C2mKVe5BI5GAqA6bCXCl2MSkmMVS9ZZqpWGOc42JL4LTjeIIq5WyvRjH/mW4l7Sljf620GJX1zGlSIKla2bFJ7ityBOr56R3L386+7TnHubCWXy6VbsbJi/ry6FQNNeWp9b7ELi2q3S+rY23G65YgLO2kgbwMSKisHl9DwXfvE+hfectVPTi9BWNlUmTJzy+j5WSTqsVi5pFgT+st6370q2BPlP43wrGG8MRkd0QyqX1GV/+zAxVzhbzWUkf73NmUf/bIIbiTjfO+c256/vpcbI9uSYbwPopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOMmsrSb18ZMBXX51H9+aGe3QLPV9C0OiLp+zsuzS7I=;
 b=ZiVxpg+rrSXZf/Xiv5mYpDMdb6tSLHuFWZWXHOalMTd9SdBdnmPbU5Pc+2VL6A2SS9UqYW9e85RHRNxNonHb2fLUHGXardE/a9SPx+te8E3jQONfoL0zSOko7pkzFwGFFQykrjCMc2O71+A8QRgiNDdcCuOJSbirzfL4zgAPzL7zq8xtr/W9+AarLyIX+PKm6+hVpUxtgKh+j4uFsyMFHv12T9ewqef47oph2TzeGDpzZ6GXyBDSwPqNWoy79YZle3vpHSFtUjMiTpS8H/TWtj+yi5/JurPEJmXg/AHdXUpcRon6vYuZ8XmJJuoOIWHnO4XRBOb6OUohWFH6RkWPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by DS0PR11MB7998.namprd11.prod.outlook.com (2603:10b6:8:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 21:58:29 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 21:58:29 +0000
Message-ID: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
Date:   Fri, 16 Jun 2023 14:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Content-Language: en-US
From:   Russ Weight <russell.h.weight@intel.com>
Subject: [BUG] _regmap_raw_write() - divide-by-zero
To:     Jim Wylder <jwylder@google.com>, Mark Brown <broonie@kernel.org>
CC:     "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|DS0PR11MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa1ceff-2674-40dc-7e64-08db6eb4d19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prXpAddTriQZnvKJNNYeEa0d30htOyvu9ZgBdsW2enYPVS9jsfBBtMTBDLu1x6NWto6vk/h8hhelGEFQ9dIGBQ7G95hlkaU3u1lsIikup7pCiu3i9/C3CQNtMEyX132ljdk93kWoz9ggNLFivVLv70Rok9tgSRHa01KffaUNEsR5G9Eeb1Yjuzl4UHs/oMMC659WdVTdSwpKmxLDmsJzzF6eUI4MVBPDrjtEsMgmX9EA7dvFQ/6GQPVJPcZ83RJTQIWSEdFw9JTwXbHurRXNEbZNjo+GddmgPw3fE00nZvwUuoVDesB9K+2ObOZ7G/7FNVEW9rUKF1K9VEyKj43VAHba/hiiyDEgPCQ12nw/VcKso3T5DNwlM654Px0+lAlaVk3iIfYvDj0thDXVtecLM9WwPHsvirGdZL0haGKC1yWvLfEj8UfVJeXznGLFblCeWE7DbNSFDx4gubf7z09xqRumNGxUQBHAt2sMEn+wtZI0P4pygcIpEiyGX5Kwa8WXbkmAIzUjgJ+5/BwTPhqNQJ9cYiFuoza1FNQ02clsehDen2Ykeb+2D2YnzSjOY1n1QuSUUNO/eZV7kJ+uOUDWTfFzEU1iDCeA2b+4auN9IbkpGU3Q+VDGLEmpXAOiHjD+0oie9pgDV85fdspCAFVxWubp3Q2WBGBgzNwREiF/o3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(54906003)(110136005)(82960400001)(5660300002)(8936002)(4326008)(66556008)(478600001)(41300700001)(8676002)(66946007)(38100700002)(66476007)(45080400002)(2616005)(316002)(186003)(966005)(6666004)(83380400001)(26005)(6506007)(6486002)(6512007)(31696002)(86362001)(2906002)(30864003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW50c2hXU04xZFBJTWlONXN2MGNORE9wSUN1aEViSWNWMGpNVDZSVTNpaEFl?=
 =?utf-8?B?V09GQzlJbW5jRVdGQmlCZkVTU3RBWFRHZkZDemRsR0J4TCs1dkk5NG5EVHNj?=
 =?utf-8?B?Uk9kOWF6UmFNMDBKdlRSaDRPZmdxT1hZbVNVWUVYaWhmM0tzNXBTSXVFMSt0?=
 =?utf-8?B?Y1lvOTV2aTJGZnhxTGUrMEZnVDNEZXdOMWJ3WmNRcmlkUHJ2NzNQZCswby9D?=
 =?utf-8?B?YXRPZWFzR0NZZ2xrczdUSkpWc3BEbHZUN0ZTUHVLaE55UitZSWhFY3JkTmx5?=
 =?utf-8?B?VkZtQzhxeHVuQU16c0gxdEFBNS90MDVWc1YxdzhjUEFubjhvM2c0Tnh6TUVH?=
 =?utf-8?B?R1B2ZkJTWmU4TU9JSzBCNERudW94TXdwRkVjT0VPbDJGeHp2bm9Cb0ZCVEVl?=
 =?utf-8?B?NkZzN3E1aGRObDlZSWgvSXpnMy92WGo5U1dGTW5Ea3ZsK0greDBJL2NpNFhh?=
 =?utf-8?B?RWVPV2Vod28xY3NVeUlzUXgxRFhaSHZjQUoyK0hQTGxNYUZmbXpLVW5PME1J?=
 =?utf-8?B?cFRua3hZOUNwaWMzMERSZDZ5NGR0NXdKcUE4MzR5ZUJBR2R6cHFTb3VnNkxL?=
 =?utf-8?B?N25ZSzRxZjFwNTg5UHYyMW51cEloRUtST09SSXlvVldvL0lkRnBJU0dTK3hR?=
 =?utf-8?B?UTVBK2l4WU9xcEpDTVJPRVZ1dzFtN0xCZ0lJQkxCS20rK3dLRVJYYjZONjhi?=
 =?utf-8?B?YXpFZjRQQ1V1VFBxa1FwbFdDc1c0WEhxODJ1bm5uaHVDdGFvT3FVTlFwZm8z?=
 =?utf-8?B?Ukc4UGNBTXNwcFpmMXhyZXZrNnBJOWVtUVJCSTJtczhuUGRrMG5sYWw1VTJ0?=
 =?utf-8?B?Y21LanBjRUtvWDdvR2JGSGhQSzJ3VTFPdi9WNnk3K29UOEJPR3dJYjlaU1Z5?=
 =?utf-8?B?U2NrNDcvU0h4RHFqOVAyclZqR3N5aHI3eFFQeTF1aUNmZlRDUjhxbzV5ditV?=
 =?utf-8?B?RjFydmVyTUtIalQvVEtLcjBodUhmYUhDVFZqcDhPanppT3M0T01HUVFjazVK?=
 =?utf-8?B?aFB3YkpLblJIZjQrMWJQdTJheFFrN3ZFSjZuckJtbUg4MWVpTFZ6WDdvKzRu?=
 =?utf-8?B?RE1vVitlUGdWMzdBT1ZtaEM3KzZWZFFjQkFpUW0wVk5LdDdIYzlmdFU4OVZl?=
 =?utf-8?B?L2tBMk9KYWp6N1U2ejZGN2wzZnJObHJIMmFNZFREQ0NRSzhGWG9sTHVKa2lH?=
 =?utf-8?B?TGxITHVURFpCZVZpdHpJQUV1am1rV3ZoTUpyRGhJN01HTERjTmhBTEVsLytt?=
 =?utf-8?B?YnY4UHlrMTB3WU9nMDYrYjV3UnZNTDl3cmNPUXVOYUg2UGY2UlBUK2xNemlY?=
 =?utf-8?B?SkxVUFRtTWZndGhISmlvbEIyTkdURTIwSE9yQStSYXVQY3VsQkRDSmZOaGNT?=
 =?utf-8?B?Wmh0enFZaGtDclBFcjNUTlNDQmJ6aTk0NkRMUVd5dVIxU1hvZFV2SWcrSUZr?=
 =?utf-8?B?eHh2NHRvSDYwS0VsNDhjb3VrdGcyaHJwMjVSekVXWG84Ly8wS0xCdFYxalhp?=
 =?utf-8?B?WmhTY1VXbndEdFl3TWV0R0NaUEpNWDBQZkkzdFVZVzBDL0R1Tm1TcXVhZG9n?=
 =?utf-8?B?ZmppSmRBZzVnSHVObGVFa1F5M1hNMVE5SmZ4TWMxaW5ZVE9Gc21GSzJ3ZXFu?=
 =?utf-8?B?bVJwU2NocjR6SlZ3dWk3QmhpOWhCU0xhUUFzckptZlBQcS8wSGU5NS9sdWFn?=
 =?utf-8?B?K0NiazRPSTFXZkE2a2NuL3ZkaEdrcXZoRHl6WUJNcXV2c2ZLOUwwUmZHUnNU?=
 =?utf-8?B?UVRGcjJyRStSdlJwMUYxTFpVOTFOU3pSMjUzY0pWdWdMZDBIK2xWSUZpSS90?=
 =?utf-8?B?MDNCVGJoUkRQRlhmRU01djZlNUJaKyswbVNsWTNiM0xvUFJhZ25iSFQ0OGor?=
 =?utf-8?B?RTh1Q3p1NUh3d0x6eXQrWHhxbVRHZFlZNnk4MHpCMkFBWFlBVGRDQmxBR2p4?=
 =?utf-8?B?ejJjeEJTSFpoQUxIaWNUYlRHUzZHWTBwQkZJZzJTTG9GNXNWaDY2LzYvbkFE?=
 =?utf-8?B?Ym9xalhEZTZ6ZEtlZEtBYlZBUTRsdm0ybnVWMloyUDNheW9IREg5RUVkVVNy?=
 =?utf-8?B?V0VRSmQ2VVNtRTduQUt6c2c4RHRka3k4SC9qUEhkcVZ2U3VaTzh4UnpWbG5G?=
 =?utf-8?B?dlE4MW9GbjNEcVRlQmxYYnYrSlFUNkxrZm9SQnpPK0dRa0dSMDM2dWFWOThG?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1ceff-2674-40dc-7e64-08db6eb4d19a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 21:58:29.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYZv0N1nFcHMDsUvFma5qN8WdIRAytmos+iFm+Dp+F6t2nY6Q3SmtwOx/0HKSyt6u5/IVPYy+UnFsStOJjhH2NnAe6biCO3/jtCmQRI6NA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7998
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I discovered a divide-by-zero bug for the SPI-Avalon use of regmap. I have
reproduced the problem in linux-next (2023-06-15). The problem was
introduced with this commit:

3981514180c9 regmap: Account for register length when chunking

I have quoted the patch below and my analysis is inline with the patch
code. I have added dmesg output including the error and stack trace at the
end of the email.

> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 7de1f27d0323..8359164bff90 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2064,6 +2064,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
>       size_t val_count = val_len / val_bytes;
>       size_t chunk_count, chunk_bytes;
>       size_t chunk_regs = val_count;
> +     size_t max_data = map->max_raw_write - map->format.reg_bytes -
> +                     map->format.pad_bytes;

For the SPI-Avalon implementation, the values used to calculate max_data are:

regmap->max_raw_write = 4
regmap->format->reg_bytes = 4
regmap->format->pad_bytes = 0

So the above calculation for max_data is: max_data = (4 - 4 - 0) = 0

>       int ret, i;
>  
>       if (!val_count)
> @@ -2071,8 +2073,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
>  
>       if (map->use_single_write)
>               chunk_regs = 1;
> -     else if (map->max_raw_write && val_len > map->max_raw_write)
> -             chunk_regs = map->max_raw_write / val_bytes;
> +     else if (map->max_raw_write && val_len > max_data)
> +             chunk_regs = max_data / val_bytes;

                chunk_regs = (0 / val_bytes) = 0
>  
>       chunk_count = val_count / chunk_regs;

  ***** chunk_count = (val_count / 0) *****


The origination of the SPI-Avalon regmap values for regmap->format->reg_bytes
and regmap->format->pad_bytes is here:

https://github.com/torvalds/linux/blob/4973ca29552864a7a047ab8a15611a585827412f/drivers/mfd/intel-m10-bmc-spi.c#L27
>       .reg_bits = 32,
        .pad_bits is not explicitly set, so it is zero

From __regmap_init:
>       map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
>       map->format.pad_bytes = config->pad_bits / 8;

The origination of the regmap->max_raw_write value is here:
https://github.com/torvalds/linux/blob/4973ca29552864a7a047ab8a15611a585827412f/drivers/base/regmap/regmap-spi-avmm.c#L663
> .max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,

SPI_AVMM_VAL_SIZE is defined as 4, and MAX_WRITE_CNT is defined as 1

From __regmap_init:
>       map->max_raw_write = bus->max_raw_write;


Dmesg output:

[ 1198.244799] divide error: 0000 [#1] PREEMPT SMP PTI
[ 1198.244854] CPU: 3 PID: 896 Comm: kworker/3:2 Not tainted 6.4.0-rc6-next-20230615-regmap-broken #1
[ 1198.244910] Hardware name: Dell Inc. PowerEdge R740/0YNX56, BIOS 2.16.1 08/17/2022
[ 1198.244953] Workqueue: events_long fw_upload_main
[ 1198.244996] RIP: 0010:_regmap_raw_write+0x114/0x160
[ 1198.245036] Code: 42 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 31 d2 48 f7 f3 31 d2 48 89 c7 48 89 44 24 10 48 0f af d8 48 89 c8 <48> f7 f7 48 89 44 24 08 48 39 f9 0f 83 39 ff ff ff 41 0f b6 c0 89
[ 1198.245132] RSP: 0018:ffffb39903437d38 EFLAGS: 00010206
[ 1198.245167] RAX: 0000000000001000 RBX: 0000000000000000 RCX: 0000000000001000
[ 1198.245209] RDX: 0000000000000000 RSI: 0000000018000000 RDI: 0000000000000000
[ 1198.245249] RBP: 0000000000004000 R08: 0000000000000000 R09: 5408185ea0cb4615
[ 1198.245290] R10: 366555b501c84686 R11: e73e1b7216811b15 R12: 0000000018000000
[ 1198.245331] R13: ffff92ce16d58000 R14: ffff92ce16d58000 R15: ffff92cca2fa2400
[ 1198.245371] FS:  0000000000000000(0000) GS:ffff92cff7a40000(0000) knlGS:0000000000000000
[ 1198.245418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1198.245452] CR2: 00005638bf126000 CR3: 0000000109600004 CR4: 00000000007706e0
[ 1198.245493] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1198.245533] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1198.245573] PKRU: 55555554
[ 1198.245593] Call Trace:
[ 1198.245613]  <TASK>
[ 1198.245632]  ? die+0x32/0x80
[ 1198.245665]  ? do_trap+0xd6/0x100
[ 1198.245695]  ? _regmap_raw_write+0x114/0x160
[ 1198.245731]  ? do_error_trap+0x6a/0x90
[ 1198.245759]  ? _regmap_raw_write+0x114/0x160
[ 1198.245792]  ? exc_divide_error+0x34/0x50
[ 1198.245822]  ? _regmap_raw_write+0x114/0x160
[ 1198.245853]  ? asm_exc_divide_error+0x16/0x20
[ 1198.245896]  ? _regmap_raw_write+0x114/0x160
[ 1198.245929]  ? __kmalloc_large_node+0xa5/0x110
[ 1198.245966]  regmap_raw_write+0x6c/0x90
[ 1198.245998]  regmap_bulk_write+0xb1/0x250
[ 1198.246036]  m10bmc_sec_fw_write+0x151/0x1c0 [intel_m10_bmc_sec_update]
[ 1198.246096]  fw_upload_main+0xbe/0x1f0
[ 1198.246130]  process_one_work+0x1df/0x3f0
[ 1198.246165]  worker_thread+0x4d/0x390
[ 1198.246197]  ? __pfx_worker_thread+0x10/0x10
[ 1198.246230]  kthread+0xfa/0x130
[ 1198.247352]  ? __pfx_kthread+0x10/0x10
[ 1198.248437]  ret_from_fork+0x29/0x50
[ 1198.249516]  </TASK>
[ 1198.250555] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security rfkill ip_set nf_tables nfnetlink ip6table_filter iptable_filter qrtr sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel binfmt_misc intel_m10_bmc_hwmon intel_m10_bmc_sec_update vfat fat irdma intel_m10_bmc_spi ipmi_ssif regmap_spi_avmm kvm intel_m10_bmc_core ice spi_altera_platform spi_altera_dfl uio_dfl spi_altera_core irqbypass dfl_emif uio dfl_n3000_nios dfl_fme_br dfl_fme_mgr dfl_fme_region iTCO_wdt rapl dfl_fme dfl_afu
intel_pmc_bxt iTCO_vendor_support dfl_pci
[ 1198.250744]  dell_smbios intel_cstate mei_me dfl gnss ib_uverbs joydev dcdbas intel_uncore dell_wmi_descriptor wmi_bmof fpga_region acpi_ipmi pcspkr fpga_bridge ib_core i2c_i801 mei lpc_ich fpga_mgr intel_pch_thermal ipmi_si i2c_smbus ipmi_devintf ipmi_msghandler acpi_power_meter loop zram xfs i40e crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel mgag200 sha512_ssse3 tg3 wmi i2c_algo_bit scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables pkcs8_key_parser dm_multipath fuse
[ 1198.265252] ---[ end trace 0000000000000000 ]---
[ 1198.273368] pstore: backend (erst) writing error (-28)
[ 1198.273859] RIP: 0010:_regmap_raw_write+0x114/0x160
[ 1198.274337] Code: 42 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 31 d2 48 f7 f3 31 d2 48 89 c7 48 89 44 24 10 48 0f af d8 48 89 c8 <48> f7 f7 48 89 44 24 08 48 39 f9 0f 83 39 ff ff ff 41 0f b6 c0 89
[ 1198.275329] RSP: 0018:ffffb39903437d38 EFLAGS: 00010206
[ 1198.275833] RAX: 0000000000001000 RBX: 0000000000000000 RCX: 0000000000001000
[ 1198.276330] RDX: 0000000000000000 RSI: 0000000018000000 RDI: 0000000000000000
[ 1198.276827] RBP: 0000000000004000 R08: 0000000000000000 R09: 5408185ea0cb4615
[ 1198.277317] R10: 366555b501c84686 R11: e73e1b7216811b15 R12: 0000000018000000
[ 1198.277818] R13: ffff92ce16d58000 R14: ffff92ce16d58000 R15: ffff92cca2fa2400
[ 1198.278313] FS:  0000000000000000(0000) GS:ffff92cff7a40000(0000) knlGS:0000000000000000
[ 1198.278824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1198.279332] CR2: 00005638bf126000 CR3: 0000000109600004 CR4: 00000000007706e0
[ 1198.279855] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1198.280373] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1198.280900] PKRU: 55555554

[ 1198.250555] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security rfkill ip_set nf_tables nfnetlink ip6table_filter iptable_filter qrtr sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel binfmt_misc intel_m10_bmc_hwmon intel_m10_bmc_sec_update vfat fat irdma intel_m10_bmc_spi ipmi_ssif regmap_spi_avmm kvm intel_m10_bmc_core ice spi_altera_platform spi_altera_dfl uio_dfl spi_altera_core irqbypass dfl_emif uio dfl_n3000_nios dfl_fme_br dfl_fme_mgr dfl_fme_region iTCO_wdt rapl dfl_fme dfl_afu
intel_pmc_bxt iTCO_vendor_support dfl_pci
[ 1198.250744]  dell_smbios intel_cstate mei_me dfl gnss ib_uverbs joydev dcdbas intel_uncore dell_wmi_descriptor wmi_bmof fpga_region acpi_ipmi pcspkr fpga_bridge ib_core i2c_i801 mei lpc_ich fpga_mgr intel_pch_thermal ipmi_si i2c_smbus ipmi_devintf ipmi_msghandler acpi_power_meter loop zram xfs i40e crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel mgag200 sha512_ssse3 tg3 wmi i2c_algo_bit scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables pkcs8_key_parser dm_multipath fuse
[ 1198.265252] ---[ end trace 0000000000000000 ]---
[ 1198.273368] pstore: backend (erst) writing error (-28)
[ 1198.273859] RIP: 0010:_regmap_raw_write+0x114/0x160
[ 1198.274337] Code: 42 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 31 d2 48 f7 f3 31 d2 48 89 c7 48 89 44 24 10 48 0f af d8 48 89 c8 <48> f7 f7 48 89 44 24 08 48 39 f9 0f 83 39 ff ff ff 41 0f b6 c0 89
[ 1198.275329] RSP: 0018:ffffb39903437d38 EFLAGS: 00010206
[ 1198.275833] RAX: 0000000000001000 RBX: 0000000000000000 RCX: 0000000000001000
[ 1198.276330] RDX: 0000000000000000 RSI: 0000000018000000 RDI: 0000000000000000
[ 1198.276827] RBP: 0000000000004000 R08: 0000000000000000 R09: 5408185ea0cb4615
[ 1198.277317] R10: 366555b501c84686 R11: e73e1b7216811b15 R12: 0000000018000000
[ 1198.277818] R13: ffff92ce16d58000 R14: ffff92ce16d58000 R15: ffff92cca2fa2400
[ 1198.278313] FS:  0000000000000000(0000) GS:ffff92cff7a40000(0000) knlGS:0000000000000000
[ 1198.278824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1198.279332] CR2: 00005638bf126000 CR3: 0000000109600004 CR4: 00000000007706e0
[ 1198.279855] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1198.280373] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1198.280900] PKRU: 55555554

I am willing to test any suggested changes and submit a patch, but it isn't
clear to me at this point what the fix should be.

Thanks,
- Russ
