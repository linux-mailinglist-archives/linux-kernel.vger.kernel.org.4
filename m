Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB533676357
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjAUDWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUDWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:22:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743CA6E0CB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674271321; x=1705807321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zt2ZW2cFiFul1Szj1G0A++wfBiit5uoANVqlbZmYriA=;
  b=Tkuz3jC2Eu5JE8ZrWaFnfpwn9ASnK6U7ODfHVPFT+ICuPAGLSjq7xRwW
   6DyUbWzX/EVGI7nX7JmOykf63onfVqRumxeypd4SVLC+Osb7tENWHl8Ku
   M+YZfQJl7Ls/o/D/MWUsULtsqqu9gLBGcB07iV3qHGGarovp8Ttp2HhdM
   b0I/WxHc9gqUw0QqU93/OAmUdNbuqrqBaCwLscdd0EQQZfWUxymUC5qzY
   4yz8IOxs6wQqaw9Sq63Ga1eomQYq03XC8cFewI5zFZqPqj3VQalUkzRMY
   vSQfeNguZ8yGletuPFvxG3NB8XjirI1AhFF5/7/VPgSyBihlOWs86aOQ9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309328006"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="309328006"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 19:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="660816898"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="660816898"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2023 19:22:00 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 19:22:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 19:22:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 19:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6wtJp/t17dx6yMHvjrRAtA6FpR9Qpd6EYTi2cfkYBSFoc8yZNZA2S7vhNUQLzEEeQFVFY6ShWMsZ0gKrE+p4mwFNP59iaSpvV/h0u5xVLqU7n2Pb8CrUOKDy/jsNFXELdmfa07VhFMyTWHMTpyNUdFOiQzvZfeylc6uCNUEFHzg6EsVVdrCeyeclop7lqEGw4jaqPQ8GztJyygL+Uu9UUlu/qZjL3+vqmV4u2GqOqC1l8t6wqmLrm9tOv3QHM6vBLSRc2KI1jhA3nhBmGDbi6FRYddE+myFYi7YBljdJegegXOEqpPIEmiVQwb8hT3e9Fl/HCKl6c2e+jk29lC4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt2ZW2cFiFul1Szj1G0A++wfBiit5uoANVqlbZmYriA=;
 b=QyQ0mvgiwSIq2XkhhY7lUJkv5CVAg1JYaIq3rq/8Sfyy/cMTtUivOUOU24SJoLpuFIQTDtV8cfcCBbSi/aGWtJYNRlKjFwiUGsudIe7+tAu7QWF3q3D8/xJJvDBPxYAwtt8zxPaygt8x55ho1/be1laSd8hqsK1MsMJvChBsPszM61oCE4dxah7G8/BVXhR11SxzK/LArxTtiTTDM7BxhNHQ7enrK4mI+Mi2mDztG3ruuCfbygt0U030G4ljWLVRAb0ww5EdfTDQTliK2PWZcArxLdAxyWc3dIkKszRf6LR4+tjzU3mOhp2apq3nUNZYOyYCE0jHS34BiR3ESuIuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 03:21:59 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 03:21:58 +0000
Message-ID: <3a39025d-a0d4-3132-125f-0e679d5f0118@intel.com>
Date:   Sat, 21 Jan 2023 11:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add()
 to migrate_folio_add()
To:     Vishal Moola <vishal.moola@gmail.com>
CC:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
 <20230118232219.27038-6-vishal.moola@gmail.com>
 <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
 <CAOzc2pxe-k_ZbC9tiogR8FYCORA48H3Y51_gTEAfewa5mFfOzg@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOzc2pxe-k_ZbC9tiogR8FYCORA48H3Y51_gTEAfewa5mFfOzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: c16b7b7b-578f-4cce-c581-08dafb5ea751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S69JQ6jLd3qmcZiSGnwG6x4X76Q1EYPgbv+I0nCssu/r87jIdafmmnBL4JHJjTE5Ntr9eJQyhWxGDmwLb6ZHNK/pa/Bb/KyyX5cdjZOnIeUTVpa0sT+serLgd6tLT+ztpWyMGHrKYONUJKyuKWR5SQ8f/3eV6L5pMMlaekKtvZLb8Cd/k/G1zXm0C1FrJByvO75k39rPKVeOKApSROyK7Z1kIlJt1Ad7075K8RDMz1vmEk4cQQGCSYa9/URB58tja8SIYK3WdCeECSGkTwwk4zrG406upSgsPcvuY+0b1SWMoNWaW/jyImMgBv9x1s399bH97qwzN8+11aWpUa55IERaf24JkHusP92SBvPr8NYFygHLvlYt554pGFy3kQIuJVwtx1UaBZ82khW92SBf2IvXyPMF4l0nt1v02WtiOzebp3RsvF3Q9ucNPOw6n9gqz1Vmhh/NdDqxpMqSJBRoAny4AWsy9kOLCirjO3rHVxTCp5++IHhh4yOLUixKGsvogkdI5Oe2EoD50i1dYjkHm5Hx4tgrOn+clySN5VOdV3VX9IrqQKvZ8I0gGGi1tmtwrtO34Z3Ofh+2KBk719TxwW0iiZtg24yuQ5b2R+3Npa2Ez/Hz2by5KH0/G3KBUW2KGVZcgZ7azkNuLxVK/ltepgqSB7XIbdFSTsFaLo6dcxaUN23/GUZw7diZw3YZsXw3tuBtgttddLUVjcUogkrY79qi/A1LeDGwp249q2pmweY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(2906002)(86362001)(31696002)(4744005)(66946007)(66476007)(26005)(6512007)(186003)(41300700001)(4326008)(6916009)(66556008)(8676002)(2616005)(478600001)(6486002)(316002)(6506007)(53546011)(6666004)(82960400001)(5660300002)(38100700002)(8936002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBKKzhqaStGUTZ0WE5qL2JBTzNFRkZJaUJha2JJVVBvdC9ZdXBHanJWR3VF?=
 =?utf-8?B?c0xGaTJKblBwejFqd1RucXFGTzh6NW8wWG95WEJ2dnQyck1ZZjJjcHZIWUFR?=
 =?utf-8?B?djlNUlJDSGtmcUNVamZoVlQzZkJTR3FWMkd5TzVpeTFLQk5QUFpCRGlDbnhQ?=
 =?utf-8?B?YTUySVphNGc2cnZQQmNoRkZCV3R2YiszZHpTK3lKS3RHUXR4OWxCc1RCR0V5?=
 =?utf-8?B?bnk3bDE5OXNVbUF0aDhEYlR2N2NacVB5eng3Ymg5eHIxZFlCRnl6Y2xhOVZi?=
 =?utf-8?B?M0hGWlZvS1hYbEhhZUp3WWJ0aldnYTRUc2p1aXJ2bmp1MmVnMDBXRzVuQUhv?=
 =?utf-8?B?QzI1WWZSQ3UreGZWZTl1YUF2ckl3TjErS0F3cURiZkhRZWVUOWRyR0JIU3NW?=
 =?utf-8?B?OTVZQWtaWVdBNmdzUE9oRExra0ZrSm5zMktGbjgyRTBrZk5ZRmNzMDFaenl6?=
 =?utf-8?B?Y2RxQ2VJRG9rby96Ky9UNUY0RFFScHliZEZWT0N2TTJndnk0eWNZeUplUVo5?=
 =?utf-8?B?cHljWUwzbGpjSUtxSDZnYkwrUGpRWVlOQzMzODFXWi9mV2dDbDVQd0VUM0du?=
 =?utf-8?B?bkI0ZGJwOHBnMnBOWTBiMkZ0dHIyR0VkdXJ2aU81L0xwVXdyK001ZXNHNnlo?=
 =?utf-8?B?M0VycHdvM1hOMUE4ZGJQUjdldDBUUlZmTVhzUHd5QTZPeTFGK2dMYy96WkQ4?=
 =?utf-8?B?ZUVvWkFETXBUcXJ6NDBqNFVQeFNZZDd1dlA3RjN3KzRCQnhrQkFGZ1ZpVlFi?=
 =?utf-8?B?MDI0dmpzVW1la09CMTl6elF6YlVxNWZoVkVHbGdBQnIwTjdVZkVCMmRja1lz?=
 =?utf-8?B?a1BmQ3NlZTFoOVJiWTNWSlRqMnU2MU1zU0NJS3l1aXExcUEwM21iUGkxbmZR?=
 =?utf-8?B?QUxGaEozWlhwaUpyMThlN0g3dCs1VU9KU2plKzJSOWk2RTdOTFgwK2puQzJr?=
 =?utf-8?B?N3p5Y1pNY05Ba2xhVnNmOHdnZlBETmVsVlBkYjZHUWdGbytuaEtIeXBHRXNV?=
 =?utf-8?B?bUdrZWV4cUJaUlRBSXhVb3d4b3BMdDZGMWhuVGFPa2V6MmV0YzdTSkJpWjlj?=
 =?utf-8?B?bEkvd0VDWkprVnlnQVRNRm5sdnhoUUZvQ1A2a2V3RStKeGJmTmNyZnhQMkti?=
 =?utf-8?B?Ti9yYm1DYVliTzhUeHJsc2ZadlhQRStKQThyNDBIZnRjTFZ6dFRpZ3o2RHlB?=
 =?utf-8?B?RDFvK1pPRmV6TUtDRVo3QW8wand3VDgycTMva0d5bU1kOHVzckRFL1JoTVNm?=
 =?utf-8?B?cVFZby9wdEF5UXhjRHRveVVLOFkxbm9HUzBGR1FaUVVjQitjWVQxV3BWU0pU?=
 =?utf-8?B?cmNrWTFEZVBleWdFZTR4d1ZLZFFmakc0MURvQkxVZEhDUTU4UXhlNTNQZ1FM?=
 =?utf-8?B?ZFdiaGVSV2RTalhTYzZ3blZwSXozcVhwdllhcXY2OEJtZmxsS3k2L3dhMisw?=
 =?utf-8?B?UHgwU09FOXc2TXU5bE9PeEdJRzVHbEd2ZUx3RUc1VDFnajdKTE5xeHYxbDZk?=
 =?utf-8?B?UDdGcExXcVlWMzF2YnUycUZ4Y1ZGUWJ0eWJ0ZmpyeUd5MDcxNXhNUWd1UTl4?=
 =?utf-8?B?WHJnS0psRWI1OTQyeFl4ZlBVOVdFU3dlRWZQTjFMdHZJb25oTnFCVXJCR3hi?=
 =?utf-8?B?UTQvbDN5bDNDZUxIYXVNcnBMeHNqMDVHRkJxTTRKM2lkak1rL003YVBKRUVD?=
 =?utf-8?B?QVRjejRCRjVtMFk4U1pjVWVYUHNzMlkzbFNIMUNEK3RqZUhOZ1VQRFNaUHZN?=
 =?utf-8?B?N1JuMXl6ZGxieDhRN1BZYkk1OUMzZCthUTR6THZaTk9FMkowTDRMVGlsOEtr?=
 =?utf-8?B?T1p0ZUozRnJ1VXNrUmR3NDAvTnlJaWhwaGxCMENuNWpLVTcwRkhVcmZ2ODlz?=
 =?utf-8?B?b3VqYWZKU29SWG9OTktHZ3JudTFnMUEyNytTTWszVUhpcnVtMC94UFJwWHpK?=
 =?utf-8?B?Ym5EQ3owcXJKVzB3RXMwNEZKV3Zsd1lKaGRpYVJBTFVSbTZ2VkY5c1NMLzc3?=
 =?utf-8?B?alRtMjNtelZWSGNuNVRxejFNbE44dnFHRzl6TTFMVGIvSUp1TFNIc2JoTUFQ?=
 =?utf-8?B?R05wbjhSREp3bk5TQUtOOVlaZXJPL2hOZWdFdU9vb09JYXI0MStuT00zNzBW?=
 =?utf-8?Q?q3LZuAy7wtNwQjGRqX6+5nbgT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c16b7b7b-578f-4cce-c581-08dafb5ea751
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 03:21:58.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwj4l4+bwvX6hh8t7eYT98lFATzEWJAKYMrUJFfAfa/0vxLU/wl1QZc71X4OrS8mLWfqDbMS79Gazsvel0NSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2023 3:41 AM, Vishal Moola wrote:
> My understanding of the purpose of this check is to avoid migrating
> pages shared with other processes. Meaning if a folio (or any pages
> within) are mapped to different processes we would want to skip that
> folio.

This is my understanding also. But check whether a large file folio is
mapped to different process is not very direct. Thanks.

Regards
Yin, Fengwei
