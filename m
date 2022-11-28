Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90F63A8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiK1Mw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1MwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:52:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE86568;
        Mon, 28 Nov 2022 04:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669639943; x=1701175943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IHeAHfPv/DjMqQZ6CzRrRohPBeAFXr7rgHgdPzJYE/Y=;
  b=iiQuRydiCgXNJXJucccv/qfxbLPbNw6lN0IO41qVrNbmnlja3Udqqnzm
   nWw15fCgjTiC2Y9plPo16q05heor66OtBoZjiV4XP0uK1+lCKmTRlQgNT
   TgtCxUtN7/T2YZeYgXikQ5QTRBzDfBrr55ybyysutFYZEcx+QTlPEx+ra
   x7hoNrry4xLEAmWCXVcAsZSbbEYPgGG+VD8VyeEFzTeCDOcYFRjoOmwkA
   +yRvBtAsmPGEe/gIOjTmq/txhaBlYNqexopFcHrSmZ3RIms/Kez86J7d6
   brgv8+W36k7iJm153gCJWaIjkUEZwxyQpU2H+CoG/TUDlVXQNDqiOkXpL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401112545"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401112545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749374215"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749374215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 04:52:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 04:52:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 04:52:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 04:52:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEVYAulOkpMSoU6lWxS8yxE0h7Z0YtIo1Kkg8ZTWQZADQQDJfQkTPOK0LqH2sS3592gKZi0723fyC6dYN71asasRdKgYE3vFMlG4FlWr/D/cQkomUyFJCao860caq6dkWjSLcyh2ukvr1bMY33anbYLLnxZDwEP3zE+i6mPvr/QctA8wYECFRxCtU5z76Mo0vvlGQ40d3ls1DIIB5hJt6zv3Vn8WA/OAVPeIfFgOtrJLR30v+tcHozGyTaUpZ4woVg8h4d86zKAl0B0ZRHm/+hNa1jsNgSWSId09WwEZo6ygatpkJ75Oyx2UzV9rMMXNCIrnHAdjPtXPBRZNzmOGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw+MnvxH/q5Kc5OVc2xFamvf3b4Kdyd0uWnRpM5WgJ8=;
 b=PZe4Q+l5BUY+WBGG8EHqdocm5k3eRvshwpi/DuSHllOpjoa53KV3dDJrHt9xKYTpRo9HPY1TeB6mS1EMtGMZy2ltDqYwYsJx6XrjKGWn7XYoCrGHmHRE8HdBpvjSFcH7UOGRHX0xzhPvrwdmd/Fhq/pyrGxYLwmYuomEY7Isd/yAbyc67203/xS4+m2D5bdVQLvWnMCQzgXHBfFDw4+pZVqkffRbdaF5975e8FzGKftDZUeYaBhgM8mvGoJp253Fq+i6i2ie7zvChcIQXl0+Y2n3FyHJZbJshSM123XhmK4IrFWpqW6FX/5OYA+fTRTBZ9Rc3JOpFoTqDBIxzo8naA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 12:52:01 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a%8]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 12:52:01 +0000
Message-ID: <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com>
Date:   Mon, 28 Nov 2022 13:51:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <rafael@kernel.org>
References: <20221117122904.6759427e@canb.auug.org.au>
 <20221128102212.39f90b0c@canb.auug.org.au>
Content-Language: en-US
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20221128102212.39f90b0c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b12a20e-2659-4dd1-26ca-08dad13f56e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ5DlXPmmbkEWB41RPgpH85lWfjwnfAEk5jfy+bD7drJqOCQQSK70v3C0QC+HaEc1M0DRS0mhTW2MKbw6IfI96xMCStAF68IE+VeTohRezxgQPLZSAjmiERpESlk+EX6O3lHvcLyC/4qDhf9Ro9d4Qx1L4IFS6ci1ycZGk5DSdnNcdf/3qCgWFszSJLZbMsAHTkmFbIlfpklsLmF80IukvsHYUTANYK3Vl7X060VmR3W6F3mLBXlrb/I99LTtxkWvadamalquPbghVzd6dMzQwee3LuUQlG21zFmteQflPPqzlfW7BEzkR2FubVfjAaI619Z6ynkfmmC0OIkZb26T9Vd6MFk9d+HMwbXL1OCUSq2/TCU/qpr5OIfkvZY4Lv2aQ/1P8YsGO9TH/g+mxFPGPUgnutbKVS6WnOsQBoPWfEMgZexbsVO2lO7Fb+b6UPtvND8115Grbkg/aU7+3c7oed2ym2f1vjtdF0BSEPjCSk+f56FJOZSS+/N3/CwW2gs4tVYEAiGaslBafliyl3+h1BjKIewPNAZm1SEYBTO2wS4zK9flPNnIAPXnyrIZUINIJhEQ9kD1Mu3N6IpFfew5rSm3e4hwCfo1rU2XtG1tA8t5BTHkV4KJDYFzhx2kPcYqA19mzA7LAwoAXZlW1tPKXeQJz+ClLkwa6hh09DC+owQbOjZ/q5P7ExIs+ar5PlfPpRYt47GRvo2gkvRoECNha66OtzO7v9SpRvd5fWazCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(83380400001)(6486002)(2616005)(6666004)(2906002)(478600001)(36756003)(36916002)(66476007)(41300700001)(66556008)(4326008)(8676002)(82960400001)(66946007)(38100700002)(5660300002)(31686004)(26005)(110136005)(316002)(8936002)(54906003)(6512007)(53546011)(31696002)(6506007)(186003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9kT2VuNHlhMGNhRmhrMHNwTGxCZi85SUdMSGZDaWtPKzVIM3pIcUp4YkRy?=
 =?utf-8?B?c2twTjJ3enJRU1pVU2RoR2owTVN2VnVUVUdDeGhqYzVNVTN6VDZIOWVlRzB2?=
 =?utf-8?B?bDV6b01PdDB3ODBxOFpENUY2MHNrYlhBM0oybE52Wk9VYk5zRkVKSHNOOG4r?=
 =?utf-8?B?Sm83bDExaG1Vc0RCTmJQM1ZoYzFyRmJ1UEJ6NmpmUE1sdUR5TDZEKzFQQ0o2?=
 =?utf-8?B?cHFJbmtLcEZnZGRHUUMzVnQrRmhBRGtXYVBKMmhBWkgzS0c2WUUxV3RLQnB2?=
 =?utf-8?B?dHBNeHhpVGJhRUpFQnhweU50d21naCtkTU9CTHllUFFHT0x2RnBpRkdxSGo4?=
 =?utf-8?B?dEFKNVVyWXRqSCtlZW1YanpmS2M0L0lJM3pyOEdVMXBPTEtzQ0NFQWRFTGxW?=
 =?utf-8?B?ZktTRlFSdVpZWGIzeWdqcWxYWUEwbVpVcHJsQTN1NUY1OWpPaWJrRnZ2Z2hP?=
 =?utf-8?B?aGdtOHJucFNObFRZMmE5cXg4SmN1YUJDSnBicVJ1d29SeTJhWml0TzQwTHZo?=
 =?utf-8?B?L0ExQjRpKy9nazRsS3FtNlpRMktwSXZXcTNHbm5MTDZiczZlSlRpaCtZaG9M?=
 =?utf-8?B?WksveFBPMkcxM2hWcEwzVjFaVUNja3NwMlR1TXFpbERyZy9naFF3VnVINlQ1?=
 =?utf-8?B?VUVHVU0wcTR5ODdYNW9NZG52djJ4d2hlQjhEaDUxTUVmQ3VFTlpLTEJ1MUZV?=
 =?utf-8?B?Sk5WM0YxckdTR2dHeUZRZXErUWdYSGRCc2o2Z0hZYnU0S2gwOCt4dGljSXp2?=
 =?utf-8?B?ZWZ5NXNibEtiR0FQV24wYkdwWDR2dG0yOW5vSys0ZDU1bHZZTjZSc0hKTWNF?=
 =?utf-8?B?aFY5d2JpYmpqUW91WE43czZ6eGduR2JFaDVDeFdKTjNtWURPNVpFRkEvNWVP?=
 =?utf-8?B?TG9xR2cwa2FRTG1XbEh6MDNkNTltSjdBN0FxdllpQ0l1S05ENCt6TWs3bkJs?=
 =?utf-8?B?bElqVDZJTExTdVZoR0tYa0xXQ3phdktWZHdZY3V3YXJaZ0YwV3hNYkVFbnlu?=
 =?utf-8?B?cGdpcUdyblozRmJheHJRMS9zRUxIaWdpbGxsaDdrODlzbXQ2anRRVFNqc0NL?=
 =?utf-8?B?Z3ZRTDRFQVhHbVV4dGRNRWM5b1hOZDY5QjBacUtDVHpjRlVsUlpPdCs1cUc1?=
 =?utf-8?B?azVRVkJNRkR2UHZndmI0VDN1ZVl5MStHYmFSZXRPYVlsN1JncExCRlhFdmIr?=
 =?utf-8?B?S2NFTXZQN0NqYWhYZVdncVQvUlBVemthOW9JYUhURHlTVmdUbFpuVGdacEJP?=
 =?utf-8?B?RFpUc0tjOWUxajJiS1lYa3FUczFPb2xOMUdyVm1aTDdlS3A2Q3hCR210b21W?=
 =?utf-8?B?UTJTTm5FTkJOeXBDWWllSDEvaW9FcUNkQkNFNDVBMzJJdWN6U3dyTkwyblh3?=
 =?utf-8?B?cnVsaTR6a0g1VE9pTEdQUzBxS1A1K1lXWTBPQ211dUd3ZklVZXNqV2JOMmNk?=
 =?utf-8?B?SW40QkI2UUFEV2NpVUR3VzRVdTBNczlpSSs5WktSNy9sZUI0YnZ6ZmM2OW1Q?=
 =?utf-8?B?dWRFRWl6NTQxWG96dVpJdjVpNUV3WjZqSkZKN2psRWJVRTA0SXJGSS8zcXR1?=
 =?utf-8?B?K0NLVE14RHlhT20za3B4UVc1N2JiZ25VTExHV3NrNkViL21uWnhQU0ZxQm92?=
 =?utf-8?B?aTUwNjMrRTJiYnN2Y0ZMa01LQVVqaGh2NC9YU3FPMWdqZG9wSGtFRCs0TXpY?=
 =?utf-8?B?UkwvNlp0cEVqT1ZTdXdOWVV3UjJpRmNTa3BhL1V6azR1UHNhVFFqcXZ4RE0r?=
 =?utf-8?B?eFl6clNySUN5K0xLbU95cUY1UlBmNUttbWxieTBLSFkrQTVmbFk1emJyL0gx?=
 =?utf-8?B?UDREbXFSdGpsQXkydlZpd0xxV21BYWs4WE5SbXBwT1IyOWg2NDBhTTlwZWV3?=
 =?utf-8?B?V3hza2IySXgrbXpVQWVaTlhPYnQ1Uzd4ZFNIMUdFWm85ZVlTblNzT3l3QUlV?=
 =?utf-8?B?SHJPbVp0b25sZFR0c1hxTFBXRlB2aUFxM0ZJUjZrL0VNTkdhMDdxUis1amdk?=
 =?utf-8?B?cEhhOUF2cTZ0Q0k0SXhxd09xSVBKNXZ6WldSb2JGV0Qxd3VEQnUyZVB6Y2RT?=
 =?utf-8?B?TWF4NDJhMklFRmk2MjVGVm1RYThCamZ1ejV6ZitxMUkyLzNSdmFLSUNzYUpY?=
 =?utf-8?B?MjRSMG1Ba1hCZUc1OHUydm5GOHZVb01GbGJITjVudG04VkZTaWFlZ20vbmtr?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b12a20e-2659-4dd1-26ca-08dad13f56e6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 12:52:01.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT8+59Y3FgMCc516iONpPajA2l8DLg9Cgc4AWOqp+1eMJ5knNQGYMyMUn/g7YSf2MGRP5AYs1nkz3RrGG+QshZuJBLyXF0k7dd2c0oRQlZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/28/2022 12:22 AM, Stephen Rothwell wrote:
> Hi all,
>
> On Thu, 17 Nov 2022 12:29:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Today's linux-next merge of the thermal tree got a conflict in:
>>
>>    drivers/thermal/thermal_sysfs.c
>>
>> between commit:
>>
>>    05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex")
>>
>> from the pm tree and commits:
>>
>>    dca20ad5acb7 ("thermal/core: Add a generic thermal_zone_get_trip() function")
>>    aed8b46d141c ("thermal/core: Add a generic thermal_zone_set_trip() function")
>>
>> from the thermal tree.
>>
>> This was just too painful to fix up, so please fix it yourselves or
>> supply me with a resolution.
>>
>> I have dropped the thermal tree for today.
> I am still not merging the thermal tree ...
>
Sorry about this, but I cannot fix it myself and Daniel is on an 
extended leave.

Can you just drop it permanently from linux-next and we'll sort this out 
when Daniel is back?

Thanks,

Rafael


