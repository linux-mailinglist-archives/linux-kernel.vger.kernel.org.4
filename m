Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284973C3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjFWWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFWWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:19:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1902977;
        Fri, 23 Jun 2023 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687558777; x=1719094777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwRHsVqqhjKoDe/sBSBvP5spa8o7yr+Ag2pCnDk8Au8=;
  b=M+6MsVXXn0/0Xg1iOBPg1gqEDXcSH9MPpu4BZDgVjkY4fdds/l1YhsXy
   T3DZDH6shnSxsEoSGdzSQrkpP2RrdnRqAh7t6ieu/IHcsg07Ue60SX4rz
   1PCTfVtNt8X4gTKkmzAvm+LJf3ocCbZdNrfmPVJMKqJRRU27/Aw8Fo5Wz
   JW0loXrwzK7xgkgjfOLPYngE973ww/807tVp4dsR9uaAlxTjckW++jaTj
   V3tcgs/uvP6lzsnQ4q07rkNJJShRp7WoAo++EAQNYkbOaPyZaIWvye5MK
   A6eaM9UmrjWPfcQGrSTfUr2R6wA7Xhhz/lySh7KGH5xIijXw26zmy3yO9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="350642002"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="350642002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="780740953"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="780740953"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2023 15:19:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:19:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 15:19:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NddEyBtuxNKxMNkiB4+yASwQQWDg8lIt+WWUL+blX0nHoKpVfy3jGMJl8qtCOM2exhNJlPSMKTCpAlo6IIx9LFmc6zPhy/H9lUJ+6xPEbWmkYw5G6taajTN6k7IsMx10hO8fRSnTr1HFFKxYbos/iEFGlstKslbWkcfa8NMFBYcrvRWgTS3KlQYTY/jtfKTSI9E97Sd4rTzb+odmlCmP/rNxfLCm3gR6lBGHVOTGaNYiRZzOXZMCuULbwSdGT+BJOC4FgGVK8IhyJxkTdFz2PhG0JuidfqkDaKp7AfVbFY2YGt3xaXa7qnoEuwPdGceDrYwnRUBqnOAtyikyBoCVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX914Yq5cLShwRQtb66OAE5+Zosu7n4Y9l9G0DO8VCo=;
 b=Dj1zt+7S3HozBzEW6cuutdHxgwh4QHPZI5hBa3VXLbU7on2G3x7qgt6ELDQfPrALiX1NJMe0bX/uA9Qo00BuJzLJABz3MN+3JMm84ThDN0tdCenzT9Km6Gk7YzJcJjffe6VrJifEGDG51uTsHCcUcT/R5de8R8Frm81Yvu/B0xAAbTxH3XUHFN71CNLonPdZhqnH0KGCL2LpsQGyj3Ymp/IKIBCm2bRgPgHyQx/lu8mzT8hPG64Evf/ycVE0VdRN2ZLhSWNPAxX3C4FDIPagNyBSCvz1KeQo2h7JI+OUVYsTwkvWO9VrtVlu0iXlr8SQr5EIrQUXR+QT8jxZXcSGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5430.namprd11.prod.outlook.com (2603:10b6:208:31e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:19:33 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:19:33 +0000
Message-ID: <5f99d057-66f1-8a6c-9107-490af0eff3f2@intel.com>
Date:   Fri, 23 Jun 2023 15:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 27/27] cxl/core/regs: Rename phys_addr in
 cxl_map_component_regs()
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-28-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-28-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:40::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ae630f-2a33-45bf-d225-08db7437ebbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwJDN+RTghj1zVNf4cfmzL/n1zWCVi3JePLdnzkPrQ99yeDgL3oZI+yhwuBHWkbG948FkI4RgpfV6366s5ImOrcbgzmyY8tqXZLgz/RKg2LjwPaQj2OdWg6+YukbVq6sjW+E2sUW0AttQ2htrYsFqpXV7G08MGo2lgVnMr7dag3N+LejiAsW1UiSrXoIhfQDNYGk50DYO8PVpDNZS3DXq+TCMbdt69yoDNZ6xx94FgK0ZR2NOm4l7pOoCn8dWgTDQPyTcQXPrFA1DzbKizzqRxuusSuHehp7N5Xy0szpRwuQcf7RqA1K4Lps0NcL/usG9pJutUcR1h7NuXMs++FIC48IpQHl1AfpL/ykV8KkF4e/EkaskNvewqCWJvyf+E9+QjyaGyQWMeqU7JvUNvt66T6Qj8licp+dPxnMKHVgn2SMM7vfNA5WVO2TbvypHqKonRHNdPeAlyRMMEJPVxJr6vJDiTuMkWupbA/lFMPj2DuJ02BeElea2j3OZmpv7oaT0tkZ5w/dGQ+H3+FabJlKrQcOly7G20QMX+pBxx6E2CpQxdHHHUSAoE+UKio8T+yBQJYgJALalzpSXUYm8u8Cfuuf276rlQ7KPI9BV7CXAZmkFk619WIHDEByqSUtMGJjbs0n5HDVUpqPaHFv0cCKNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(6666004)(478600001)(5660300002)(6506007)(53546011)(6486002)(83380400001)(4326008)(66946007)(8936002)(66476007)(66556008)(8676002)(41300700001)(31686004)(44832011)(2906002)(36756003)(26005)(186003)(6512007)(38100700002)(82960400001)(2616005)(316002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFIvWEhBOFBzbDhQZCt3RzEyTXM5WU9tY1o0YkliRTVJTzZMeGNuV2dpdEpH?=
 =?utf-8?B?RE9hcVAwSlliMk1rTW9JUms0RFFwRFJpQ0tNUlNucFpWMy9MWEVCUlBDUFMr?=
 =?utf-8?B?MndHT0laY2FWS3RiallDMHpuT0R1SFlpbnN2V01NOFJWc3FLRmQ5L1gvckZC?=
 =?utf-8?B?MFphZkJqYUxTekFTdW1XUnhDNmlOdllhZHlSWHpIbTU3SnZXWnMzOFh1UzVV?=
 =?utf-8?B?L2x6aFl2cHNzTlpIb3d5K0p4NGRWQXc3d1VLZFlxRXJaTDlWdHBqdkpMOHlq?=
 =?utf-8?B?YUhsV2dTSWhTdk9iTHVCd2lUYzcweTQ3NEREanJ5V1NrZnMrQTI0dHhRVUlJ?=
 =?utf-8?B?ZXozVlJkOGRZcU1zWEpMbU94WG1VenZHS0ZUVXNadlNmSkxtanNTVEZtSU4r?=
 =?utf-8?B?QVFQSFZTT0JOTzVSVUhhSW9rYi8vWDNqYytBL3FORnVQZitUY3pYQWg5cFpY?=
 =?utf-8?B?NE1KRWp0TkV6anVsMW1tTlpnOFFJTFRPMmd3SzdaRGJ1NnVrczZ0SmtsNms4?=
 =?utf-8?B?c2dnZFovS1IvVkFzTzBTb0ZXcTRmUWFmL2l1L2J2Q1FRZktQWlUrYzdXRlpk?=
 =?utf-8?B?bzdJeDBEZUN2UU9TVHlyQ3FvakN5aE1mbkxwb2pkV0hhcG1VOHNRc0RBRVhW?=
 =?utf-8?B?eE9wR3kzdktvd3dOQ1g3MjVTeHhkc3p6UCtkbCtFa0RJbllQZGw0RWp2Z1kz?=
 =?utf-8?B?T2ppdG50cktVa0JOUzQ3ak5QRFB6VVptZFE5UFFDRFVOTHRsblRWeU1aSkpM?=
 =?utf-8?B?UHBDbFZuVGpRK2czeUoyRXU1RnJ0akJHUXVTYXdjZFl6ZldvWS9lbHJrUlFi?=
 =?utf-8?B?WVZ4RzEybVRpdmRxeUJZWll6MEVDOWNPNDNtOGEvRGxINGViR3VZU0hGbXky?=
 =?utf-8?B?c1FmVThyMlJsRUVtdzJmTnVnOGltVnA5emN4UFNDSUNWZ2dUWm55bndoN1Zl?=
 =?utf-8?B?Rm5UVW9XU3FaUlpRQ3l1QkwycnZ3bVJrRS92cHRKU2szMU9yaWVKTFFDN1R5?=
 =?utf-8?B?ZW5wTUltSVZRMjVSbGJ6b0ltM2NKSHorNmQ0eldZcENyQlpWZ3BhOW5mcjVH?=
 =?utf-8?B?T3p5TUJwdXZEN2cyMEdGRTEyNHJkeEU1UU5NM1d4YWNTVEd6TkhXbWtYYXRu?=
 =?utf-8?B?aFRJd2dWTHMzeDRjazIybmhiN3dJMElDUVF3elA2MWYvWnhETVlrRzZJWDRp?=
 =?utf-8?B?RGVmS3UzSlRDYnJnOUVWcWMxbXl1alZWeHFrdDMycU5TOHRFbFVNQWxuQnZT?=
 =?utf-8?B?dEdqUEo3ZExBR2xRWnM3UXc2T2t0dE9NTlZmTDI0a1dMRGtZQ2U5WG1vQkJ6?=
 =?utf-8?B?OXJGcHhUV1NXZm9EL2t1cWlreUtMU3lQRks0QXcvWTJGcTFmcWV2WUtmOVdw?=
 =?utf-8?B?YTFDVE5LSERBN0IwRmllK0hjSHo4NW1GblBmK3l2QlFSUWx0SEVCeEl2Tk5S?=
 =?utf-8?B?bmhXeWx3alFyaU8zZGVxU2hYOVpuYU5iaHk2b3FCS2xPMzArQ3dPMzErcWcr?=
 =?utf-8?B?TGs4RUFtbXg3MkJlWTdHdDEvOEhTbG0wMnY2SGwrb2JVdnpBQ0lHSG5mb09q?=
 =?utf-8?B?ek53VWJHSFEwYm1lK1MxVy84V3kwV0ZMUWVzK3Jya1JYWnltZWtKb29hNzNi?=
 =?utf-8?B?MmFmMmtrN08zL0RqWHUyZHRVdVJESjRTWjIxQXpOa1ZEUVlYWDd4RTR5U2RU?=
 =?utf-8?B?UmtPclN0UW5Fc2hFdVdLMVhNcGU3bzFucW9Gb2hYYU8wbEkyWDJqeHhmU0lu?=
 =?utf-8?B?akhPakJlRXFiNXFCRzIvOHhZN3N0M1FvVXlGWnl3Y3YxWU96TkliOW43My9R?=
 =?utf-8?B?N0tUK1VGZXFJdUdmOWhHV29HTGNKUXFOMjR1S2xjRjRYeDd2YXl6NExxWXlv?=
 =?utf-8?B?cEIzVTRTS1lQRFdtUEpMVXJGWXl2dGNGNWhISEhBSU5lT1EyYTZ5SjFrRHEr?=
 =?utf-8?B?aGJVT0p0bVZVKzhtakxteDJwMFhySUEzWmhFTjdZQ0tIVjJralFEeXNLMy9u?=
 =?utf-8?B?NTA5TTdwVlVNVnVLRVlxeldrOFBIZFMyVTVTaHpINllTTWRvcWdubXJWTWV0?=
 =?utf-8?B?MHEyd05pWWMxRVB4K1Y4Y2JhN2tNMWx3NlRWaFB3blozTG8vK1VOdUM0ZzVw?=
 =?utf-8?Q?hrhMXvJ6j0n2hDX9bf0CYBTpL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ae630f-2a33-45bf-d225-08db7437ebbc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:19:33.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d77EAg+sYFLNOHibjBx5G2/fG4r4307CzHZy8KhR80geR4+tvMlJZyiVA9A5gA+nEyorWWu1cd+Tbd+AFlr0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 13:55, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Trivial change that renames variable phys_addr in
> cxl_map_component_regs() to shorten its length to keep the 80 char
> size limit for the line and also for consistency between the different
> paths.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/regs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 982ef79670c7..ba351a887040 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -216,16 +216,16 @@ int cxl_map_component_regs(struct cxl_register_map *map,
>   
>   	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>   		struct mapinfo *mi = &mapinfo[i];
> -		resource_size_t phys_addr;
> +		resource_size_t addr;
>   		resource_size_t length;
>   
>   		if (!mi->rmap->valid)
>   			continue;
>   		if (!test_bit(mi->rmap->id, &map_mask))
>   			continue;
> -		phys_addr = map->resource + mi->rmap->offset;
> +		addr = map->resource + mi->rmap->offset;
>   		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
>   		if (!*(mi->addr))
>   			return -ENOMEM;
>   	}
