Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF982737692
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:22:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B7193
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687296142; x=1718832142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UTOlCZbPip/6uU2ZhUUg/9wxFDL7CH2gFHxxUlQL17Q=;
  b=H+XORlyIgwQxXrpftfcWRkhN2B3/NIWDPW+VEYmedP2XdU3tN0alNRso
   DKQ4AaGmb2fPCvBTEYLlYUPSXGdZJpVGqpZikJ9tR418AWpZeX/10wC9u
   /5oxfo28B6b+L3QEL+GxjwzQjH9uhW3O6/TptoKIBKopGvFlY+hwTaUPf
   fmzGlqVYyOHEoEFTsNU0nPNjDFrdLzdmyZ3CwYseVfECNtHwA9dJy165a
   /q8WvrOIbiYKKlFCalp7Olg0b254E80EsQr9XVtL86722AQcbpPwEiGmr
   6s60/kY7L+ZlZSxF2cNtBP58B5eWSCMGLGpVLLj+p6RpqNdhjiNTBk4pm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340327051"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340327051"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 14:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691594678"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="691594678"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2023 14:22:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 14:22:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 14:22:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 14:22:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfyHu5QB1zeAx2+S68jvkvQpmdvx3127qaXJQE4QRxt11IK+a3t1sOPqnfeLOw/y9IrmtKVNCA921i4V1o3ncHI0a5iFRlnii2iExw3ayyn5HvksWgVTw22Wo/N9k7qL6xyirRGw13tBluJuAupdwafwSIjIJOV1J3DwgeYvEWPHQv2JRqL8sopRP9bVK6itR8hMLY8oDB7uVJDJdvCY7l2QGjbVmUBW+NQl7fh5YicKw3q3jy44feTqEByBEkqikYaF0jDM206IHUWlIMkfT2QcP7aXLG3xJgwSJ7XuvVonUnJFU0S+ZX8jR6ava6GjFWhE+CTLm5A0Nmx9a6/Viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bkhd9SHJV5Yqvl9P2hZp3AbdRNk3lHc9PSqZog+BEs=;
 b=FUwBfgpX3xO8wy00T074TawLqOYJ8iVlUNyczRB04TuSqBPDiiHLVPpeaRnqRB4aVuM1iG4HBAjU3nbIHmWYnHU6oDFrUHutJhbhbxCfoMDw5ZZGiKWDvioo9oUutRPZtbMDsx68D0j1tINH09M+AqI6xMVlvqPrWQ0boe6pDEW7JZg/nimihpmA4isdLfyb6qwviBh/Dg2wpLV3PR3NF2cf2pBLOsqdgg0YbdFpAItIhrLzO6+QgST/a3EtzQ0bECfUw61eXX6qfxMUA4c8ZO6LQhWBJwaPSDFLjNd2C5PlMS+D3WRBGhpvJFjb+DHLOXpMkh6TgTSbwx1jX30gQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 21:22:19 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 21:22:19 +0000
Message-ID: <5d6c7683-0e96-c906-4d17-5f4a087a51ff@intel.com>
Date:   Tue, 20 Jun 2023 14:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Content-Language: en-US
To:     <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yilun.xu@intel.com>, <matthew.gerlach@linux.intel.com>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230620202824.380313-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 252a453b-b018-4a60-7b47-08db71d46dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWHpCi7Zmo0k/Wl9BvrO9MFEjQBvpCMMQoYJWBf33AQyjkXpmhUzvYUOhjPLZa9n7fGKF86ktQj+0AaVxtbHoV1ud30zj8Y/AyHIBDKdNhr7zVfg16m1a6mOVMXG9LB0JTeI6c0U10XoSPc26NqMxSpKcBMc4BhIhjyr1kKjfh9E/GxYOWA3h49+J28Gh9/EYidYZ/8G5/o0DhUlsCtMlx+Gq4LFvQSGy3ayTT3FbpwCgOIU2PiV9zwZh/NFc3nV8761KKvdMnrguCd09VK183tw1pvOvWTWIg+FQ5MX5rvyPU0ZeycSE4sMeXwaTWDY9locEJrWj3W37VTPyvtdpvMw2xoTjeTvLTkD+QPzyhB2xGkJHWg2/0cKprL5NxiWfadzuQ86GzzoqPE68RDCtc84Ia0uDRFgIi5DcpeXhB5mQdaNlR3qgK+q97PFyeHOm/ShkVmX1QgajZAk7f2rbLWdp0ziKUDq0j35TG3JOin5KfjFubu0mRk7b6DGqDh25qgiWCGWnKANY663t3xU64IJ/vU/4KQC9f9VynTToBMpsV+ZQn3ztoOI5f2fV5BZwrollngUH+pSU6NyH+uJYZ2SEU0t+R80cdSXtXpMFD4L7L2HrBox61/2y7EewKwGI42v4FUApi82rgMLuufh+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(8676002)(66556008)(66946007)(66476007)(8936002)(53546011)(26005)(186003)(6512007)(6506007)(36756003)(82960400001)(83380400001)(31686004)(41300700001)(38100700002)(5660300002)(4326008)(316002)(2616005)(6486002)(6666004)(31696002)(2906002)(478600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9XVGk4bzdQQ0dkTy9jR0pKNFc4SW5mRkl3V2FoTjlBS0R5VllmdmxCcVdY?=
 =?utf-8?B?STFoMlYwdzVLRCtNcFNxdEc0NEtCVUc5cEl2b1lHbzczMFlVM0ZhQXFndlJh?=
 =?utf-8?B?cDUycFZ5OFNnRHlQS0dhUG1hbmRaWWQ3UnBiK3lsemd4Z0NROFVhL0ZuTTd3?=
 =?utf-8?B?R2dCa1kya2dVSUpBRnNxMlVvOWpVbVg2ekxHaldDNHJpVGtCSG9JVHR5enQw?=
 =?utf-8?B?aG1NdEJqVEZaY1BFVFF2ZkpWeFcyVER5Y1pJWGovV3NCUmJxLzY0dWhqQTZ3?=
 =?utf-8?B?YlJnZGdvMjFRRlZlMGFsZnhMUkJOc0VFSHphOGtuRVg4bzRZMjQ2bGRSNHJV?=
 =?utf-8?B?OERtK2luSC9SbkFXUVBzanc4WHdiT2crdnhoeVpLSEErOHgzSmFOdEYyYitm?=
 =?utf-8?B?dHo5T3Fic25FM2pwOGJwUVM5b1RqSVZ4NjFJMzIrb3lWRFFwSHZMME9DYTFo?=
 =?utf-8?B?bVdrL0dyWmdSR05sK0h4QjcvV1FnSDVSWmpFbGhjQ3NuWGgwbU5KZlVKNXpM?=
 =?utf-8?B?dURzdUR4b3BYRXFDTHBjdE9lbzZiVHkram4xYzNWeEFJRGIyVy9TelZzVHRS?=
 =?utf-8?B?UDNFaXF6ejlNamtxVjZacTJkQW1tYllHZzBBTmp6cXpNaE5nSzFBbXlZSjR6?=
 =?utf-8?B?cDhQTDc3WnArVWF0VzZMQkF4N0E2TVFoT0ZBMTdOR1RyOE1HR1JjcC9qYnM0?=
 =?utf-8?B?bXhTa1Nzem9JQlg1UnM1UkdiN1JqZXJYekVCazFVV25tY2dCMjRWRmlvMFVk?=
 =?utf-8?B?NlpNdWJqMVowVWlXcExsRkxuUVpYbkhTNVdrTndFVzcrVlhoWnhONDJ4bkth?=
 =?utf-8?B?VksvOG4zN1VOUTdHUnptcnZXbzRaTjJuc084UThXN0hBbFdTQmV4aDRKUmds?=
 =?utf-8?B?ckJJRWZWdFJ2MVRtYWhuVnIrK09KdzQwQW9NSVFRS2pVNVllREhObDhGd3JG?=
 =?utf-8?B?TFlEYW1yL3REYkFPaGRoQTF0RVdWMnVwQlJodjduaU1zTmo1Ym9hc29CZzhU?=
 =?utf-8?B?UDF3VkdGVWNmWFVuRktJY1BCbGtSaFZHN051RTU0VXZhU3h0SFVRaFNJdDM0?=
 =?utf-8?B?QzhXWXhkbC9CMmovckFXSHI3cHZ4WFo4U3VIVGIzSXkwVmVVWTh0VUR2N3BZ?=
 =?utf-8?B?TVRjeDhFTkdhN1k2cSs0VStpbHp0Qnp6M2tWVGV6VUZGZUp5TUt1RHBHc1Rh?=
 =?utf-8?B?b1ZNZWZCbDNjRGR0WlZaUkRDUlduQk5xSlBuYklOZkNHK3NibWo2STVDSy9I?=
 =?utf-8?B?UTl6bndRRnlTVEZUN0w5UUQyYjkxQ053NzU2MnNBZzRaQ0I2eVpUb2FQZlpW?=
 =?utf-8?B?QWZNdE9qQWdSUE1oT2wvZktzL1JNVkMreE9LcUg3aWF6M0ZVTi9keUNNZzlP?=
 =?utf-8?B?N21xZ2t3WDN2dWNzOUE2TEZ4ZzNpcEJkOWlrSnJZRWs5QnliV2l0WDdNQjF0?=
 =?utf-8?B?ZTJsQnNQZmJFTXYzdDd6ZmdMSDRHcGZZa0dCQlFQeHNkbFR6Q0RJeCtJb3k2?=
 =?utf-8?B?alNWbHZOVTd6MlFvR1RLTUVzdXBDY2s5akh0ZmJ0VGhZaFh1cGxlMDhRRzBS?=
 =?utf-8?B?YTg2MWg1SGRrMWg1Q2lUVXNidGZqQkU1bmZZTkVSVEZxdjY2QURSTW9mcVVC?=
 =?utf-8?B?UVIwdEI1ZGRmUU9ia2QwK3NBbWRHM29xUjdxb1NrZFVlSTAzMmQ1ck5FbDBx?=
 =?utf-8?B?ZkszNTYzUXpHMWpHUmVSRDJaaFZLRk9mNi9rb2d5Q0FsSEI1MmppQlNYaG8z?=
 =?utf-8?B?Vjd5THloOVdBVlQxKzB4UllkWnpXTjJ1NWQ3RmJuWjBPOENGL3BMcXlzdmVv?=
 =?utf-8?B?OUtuYkJhQW5udHJ4djBTekIrakVlMnJPbkE5UFN0cTBJS2JsT3FBZytyVWtS?=
 =?utf-8?B?NXkwUmowWXVHcjgxQ29wc3pCQnVoR0ZLTVdpOEh2Q0pDNnBsbk9sdnJpRU1h?=
 =?utf-8?B?eDZia0lLeS9NVzFmQUxENzRxSlhZeXFzOUhZUkx0YytHK2ZMZTMzTUVRQzB3?=
 =?utf-8?B?bUtxNUpiMVZBQjhNcTlzQmJXOTRVcDIwZmVsdUZ5eEMxTjRlRnZtNzZYU0Ey?=
 =?utf-8?B?L1FRYjViQ0NaNStyTzdRdzJ3NVZjUUk0akw1U2VmeFZBblVpTGtlcno4SkQr?=
 =?utf-8?B?Mk1kb2tNZzBhUXo3T25HS2NWZGVCQnJQN2Fkekd2SkgwUGRCa2VXYTZHWVhJ?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a453b-b018-4a60-7b47-08db71d46dd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 21:22:19.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sh05+Ur2OjJF4TKi5NYTBxCe+0KwoO0VuhGzYnr940jh50qdfXiJrIVXVBOlliOPw51ufWPmoautyfUFaOhXsTD20WeSgOsH42/nB8sK1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 13:28, Russ Weight wrote:
> The max_raw_write member of the regmap_spi_avmm_bus structure is defined
> as:
> 	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT
>
> SPI_AVMM_VAL_SIZE == 4 and MAX_WRITE_CNT == 1 so this results in a
> maximum write transfer size of 4 bytes which provides only enough space to
> transfer the address of the target register. It provides no space for the
> value to be transferred. This bug became an issue (divide-by-zero in
> _regmap_raw_write()) after the following was accepted into mainline:
>
> commit 3981514180c9 ("regmap: Account for register length when chunking")
>
> Change max_raw_write to include space (4 additional bytes) for both the
> register address and value:
>
> 	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT
>
> Fixes: 7f9fb67358a2 ("regmap: add Intel SPI Slave to AVMM Bus Bridge support")
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Cc: stable@vger.kernel.org
> ---
>  drivers/base/regmap/regmap-spi-avmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
> index 4c2b94b3e30b..6af692844c19 100644
> --- a/drivers/base/regmap/regmap-spi-avmm.c
> +++ b/drivers/base/regmap/regmap-spi-avmm.c
> @@ -660,7 +660,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
>  	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>  	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>  	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
> -	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
> +	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
>  	.free_context = spi_avmm_bridge_ctx_free,
>  };
>  

