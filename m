Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DA748C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjGESnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGESnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:43:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D0139;
        Wed,  5 Jul 2023 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688582629; x=1720118629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fu3W6uJw15Ja1eqA+ymukZGMbFq0TuyXrz6gOBjUhU0=;
  b=hUW2/FHmleNmQoA39x5bY8L0HEaCeVBUWgr1+ULwsG85PHzmmcUB9GQh
   Mm8n1bpH7uYJVP+qqdsx89nFHMJFRD2JjrCcsOR+DD37Il74bxm9kWz4u
   5ySXH3OtJMC4fbf3LYV1E2A4Vra/9h9NdqAwZZCFOO5lP3KN3VZLjjfPx
   edOgY/9BQAjtGtZK9lKkfsFqhlYPvfPm4lSuc2wGEzsHBdevN8hijae8a
   xEeJC4S5SASGIjaqQ5FsHCEw6bwZpRWAjEVZ2azWSBtcL2UKe3LIb+0CA
   Br5YOARHoxWCdtypdqyIySWlEYGyuYFky46VBybFOG67eoLJPz+aZ0w05
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394169571"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="394169571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 11:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863820194"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="863820194"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 11:43:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 11:43:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 11:43:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 11:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgiCEBAmPosNVYnBBGOmLwqfdvNNOXht6A2ibwoCcEqfYSQQEkAhEd7KoXsrsb2u2kz27im5gzp7iockrXQaYvvguM5q7IzZE1q0urBQqm5wSJy0UiXf90ynp4ogTvAB1f3HeaCcPXMQAtUxzIHU6HbjuOcc4VaqUKGTPHTC9nZcg4zi0dwd/xr89aIwD7oWu32GSzdUUiupiPivkZMqiolHLqZVBCZkqKec72y+vSnME10DBbg8l/q0TrB87tIN34XnMlM4t+I7yvG6qm0kRO1yH9cgzq1zXBmFP9hX93LIDjITCsxkMFKTBuEior2PFBzdy0p1JhEY3fU8bBMKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Db2m439tGMGxm/EpA/J8nhTZ3MYwGt+e+43p46KWU=;
 b=hVrlx0UV76KFeVXRK9Fb94w1f21nCZSeRx4FeSUV0/t1jGftcGb3ZoeoRjFzPsTbYJqsplDsMe8dG6nkJErqaS1J0+c7ZfTV4KlhZVGoT3MDzIloBomNd7V9y6S1N2eRGYIrIrEx2ncbgxOOd98wHer9HtvCBQH09tcmkiAyW69TWfffVBsbdURlmN4h0qTBH04H5q55FjsSeUMkUEYwOlmN5jisSaXFOrINGDI7SqYb0eBCNEYY2mc4zF760Si7c3DNIvdmZPr0YCbSUGGQ2XfVejutQFGpx/T2B2xt0aSu64EtBmMNE7htpcQrT+AfyoUdOicNCjvhMRmdIH9bHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5502.namprd11.prod.outlook.com (2603:10b6:5:39e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 18:43:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 18:43:45 +0000
Message-ID: <4ba1aeba-d744-4296-811f-71140e9c66d9@intel.com>
Date:   Wed, 5 Jul 2023 11:43:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] ACPI: NFIT: add helper to_nfit_mem() to take device to
 nfit_mem
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lenb@kernel.org>
References: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6240286e-f585-4919-3fc4-08db7d87c339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n93kAm0bFgA3Thgk8xv8QVFZXV/61BlWaYb7Gcwsw8YYOZwPtMn/3RnhGNjYPCHhW00uxKHuUHB2heDBOqMDjH9KnZvzMbx02MwYBSkMBriDzJDx0TnxnCY0vmu95daf5GEea/j/8fREAb/wYd1fMwTrWVHZMLTjNDsEbQofvWcEvSBgAi+1Pt01nvk6NXM1zDZFhifQqtFM8eARcv+EfQf51O5ICOa1fmIGuUPLSj5KYnXPmJLpeQvA/7CXJCh83sJFQ56SDCeywQjK6/9JefNFheZrlD96eCaI7P+cepoXk1u1sYz72Hq1+KJ5TKpk+OSNtFNgKK82O7HXbArZEZac3x6hRmpZuUXQ8E2END9GB/mHuvkC2ofL/TU7BxzFnYvs05sznU7DBq3Znp4s3v0rNnP3hhd60QwfVz2zJj6AwSwjM/JvRJB1yAqt/CrArL9iT+3ghlQaYpb75Upz9whHf5y9/GtkB+ut7xxF98LHuaZmkgQCl3MmZv5PnxfttLdwsFmM9VbBifU0DHiaKWxmCXvCYuhuCsW1tjdqyL7FdBzxxZL/Tww6+NbhV/b6Oc7ozCLohEFyRTW4l/Hc0oT9XlwbzWmnYaXOgxrGv8XU51cYzUe4uqHHYbGmSaTpQh7ws6cUWZLsxgAFld5hrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(66946007)(66556008)(8676002)(2616005)(2906002)(8936002)(5660300002)(6506007)(53546011)(44832011)(26005)(31686004)(186003)(41300700001)(6666004)(82960400001)(6486002)(4326008)(66476007)(36756003)(83380400001)(316002)(478600001)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRodkEyV2dtblVaTDFlQkNhdUN6dkE5dFVkbUpQb2JoUStjYUZlUEtYRWI3?=
 =?utf-8?B?ZjhaOVJMY1RwVXIyaHV4b1JTdzk0SFZyWWxUTGpBMUhLRGJzMUlhWGcvZEZC?=
 =?utf-8?B?OHR4aitGQWRXemFFWloyMjZ3SGJSUEZDcnl6STgxU1NlbGZML3VwMjNsNDVv?=
 =?utf-8?B?TFlHKzlqODhQQi9ISFJPOGMyL2k3MTlpYkhsN1V0eW9VbEJydDJjcEpKMXJ2?=
 =?utf-8?B?ZjZWY0NCMlpWVXQvM09QekV5S1RVVFR6bk1za2xXaXhtQWJacy9xQ2c2eTBp?=
 =?utf-8?B?eUgzYWZuT242eStUWW5GWFFORUtpellvMmdpdHkycS9kaUNuem93SmpZc3lW?=
 =?utf-8?B?Mkc0OXgvaW9zQ0NCekVkRXpJZmlJQVp0ejgyWm5qYVltNkM5cmFuN3V5RFl0?=
 =?utf-8?B?UWYxNCt0T3hhb3FjTEFoNkdERHNpUGlJTzZjOFQ5ZVljRXl2dEhTdDFWVGxG?=
 =?utf-8?B?RlgrcTIzU0R2ei9kcjIyejZrM2VBMTV0VkYxNHc0L1RNYUY4RVgvTEhkdlVV?=
 =?utf-8?B?RWJsN1dYNUZNV2xaWXN5bVhjaGJTMnhLNzJqRitkR3RLSU81SXBPOW9RWjcz?=
 =?utf-8?B?WkFGaUVHVjFCMVRpT2Z5N1JXdE5xTjQ5OXUwN1pCa2w4Tlc1MDhYQmYrQlZl?=
 =?utf-8?B?ZjJ0Njk5RER0QW1zQitDQmNaTEYwaEdVOW16YkJPKzFoWWlrRGo1V2wvbkVT?=
 =?utf-8?B?eGdzcWVaTVI4dEtieG40bkdWeHVjOE5VRGk5K0s5R25wYVpVTDdlcStVOTRs?=
 =?utf-8?B?Y291VEdiYWF2RTdRN1l6VUlLSmd2amlVamNNSTN1V3ZJZlgwTEpwalQzMmVz?=
 =?utf-8?B?QjF3aFVVQmRlRERYNGZodU1ySDVmYUwwbE5VNVJ5MnpMek84dXZ3OHJhOTFC?=
 =?utf-8?B?MEUxWWlwb0tneFVBTXJQL0JGcVhiNGxFUTRyVXBrT04zVnNuZFRuZTcwTjhi?=
 =?utf-8?B?TVhidnVnMFF3cHIzSm1LdnorcFpzcnVpZlZRblBIQis4eGVRK2d1SmZwY1Zi?=
 =?utf-8?B?SFp0akg3eTFIbVdKN01UMHZ4dk5ad3psS2s4bkNlcVdGT1NOM3dGTWd1ZGlk?=
 =?utf-8?B?cWFmMUhzSUJ1NXBpRVp0eXBsOWdnWlFMV3ZFelRzSHZBSGhPeHlpR2JpdVZn?=
 =?utf-8?B?b1kvQUNDOE1sellaM214UDFvaXA4b0xBTmFsazA5QmVXRG8rRU9VTlp1YTg4?=
 =?utf-8?B?L2hhKzdDaUF5dE5PQUVwSE4yWVQ2aGlyVzRxVFlhckUxWjZKTmZrUE5YSHVW?=
 =?utf-8?B?YWRVNW1RaEZLTVl2QUNXTmtUWTNCSWlXWWkrbS9YdnBTS0xyTXZ3VG1HR2tr?=
 =?utf-8?B?dkVjcWhZb2w1Wm96N1hUWUFrMmR6STdkb2c3cmJBemtCaWxNcHozMGg4d2RV?=
 =?utf-8?B?ZlpDVDMzb2pHbVQ4cXhVZGhsYTg4NFFXdEtFV3lVZEhjQ3pOS3k3ZElkRXNo?=
 =?utf-8?B?b0RTZTNwL2NLNHVRMFZLbFdmWG5Fc3RUUzVWRkVwQ2VkaFduWURhWEVaQy9y?=
 =?utf-8?B?VlFvRGZDWVVhMjZVQTJyaXhzZVhIbmhndkw0Nk9vZGNlc1ZBQnZXNWxXYlJF?=
 =?utf-8?B?NThrSFB4RE5semQrNmNLT016c2wvZHY1dGJza0JaUHpyelFTK3gwUy9RdWZR?=
 =?utf-8?B?eTRJVmVPdkFlREJWSElWS1lVbUY1NjdpeHRUSHlZakZwQWtqSVhBOWNIR3BN?=
 =?utf-8?B?VlQvNm9IQnh3V0xQQjBLOW5zNVcwVi92cHRTaG5STk9jQWRLMTRuUzBzNllI?=
 =?utf-8?B?VU9vd3VDT3hYZVFodUllSEQ1QzdhbEdaVG0rN0xlUFhnSXhSZis5TXZRZUtW?=
 =?utf-8?B?TUNJZW5mcUUwTUtKVW15OG5EUVBldnNBQndWWTZPYUFZUzdMeU1QSVFYOUpS?=
 =?utf-8?B?UWJucDVqeURCVEpWMVpWbFd4YVpmVkw3RnVRcTZiQ2krellIVTJuTzlySmtz?=
 =?utf-8?B?NmtQdG5RRm5nMGUxeklqcklMOFZIaVJ3d3YwbjZhZk9WM1FzNUpKM2ZWYjdI?=
 =?utf-8?B?czJ0ZHFTQ3U3c3BEdlV0VnhON3N4WWZSTThrRiswZFVDQUNDVGQxY3NJc1Ar?=
 =?utf-8?B?ZktTVDVxRSt4NElTbTZrUUlsZ1VYdXZnMklVUituWlJMRFFLUFArQTNBaVAy?=
 =?utf-8?B?alNvMUZVOUUyNk8xK0lzbzBaS0g0cjhpU2xCejRmWHZkQ1dOVzlSTEJhTzRv?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6240286e-f585-4919-3fc4-08db7d87c339
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:43:45.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaTsaTF21W9+83HkC47jGGxgla6h5VvPuMCuI/WbgZrr+3675LnbqsSQ4ZGLuolrIWUEoaeXbO0f/OCoENg+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5502
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



On 7/3/23 06:17, Ben Dooks wrote:
> Add a quick helper to just do struct device to the struct nfit_mem
> field it should be referencing. This reduces the number of code
> lines in some of the followgn code as it removes the intermediate

s/followgn/following/

> struct nvdimm.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/nfit/core.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 0fcc247fdfac..9213b426b125 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1361,18 +1361,22 @@ static const struct attribute_group *acpi_nfit_attribute_groups[] = {
>   	NULL,
>   };
>   
> -static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +static struct nfit_mem *to_nfit_mem(struct device *dev)
>   {
>   	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	return  nvdimm_provider_data(nvdimm);
> +}
> +
> +static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +{
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	return __to_nfit_memdev(nfit_mem);
>   }
>   
>   static struct acpi_nfit_control_region *to_nfit_dcr(struct device *dev)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	return nfit_mem->dcr;
>   }
> @@ -1531,8 +1535,7 @@ static DEVICE_ATTR_RO(serial);
>   static ssize_t family_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	if (nfit_mem->family < 0)
>   		return -ENXIO;
> @@ -1543,8 +1546,7 @@ static DEVICE_ATTR_RO(family);
>   static ssize_t dsm_mask_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	if (nfit_mem->family < 0)
>   		return -ENXIO;
> @@ -1555,8 +1557,7 @@ static DEVICE_ATTR_RO(dsm_mask);
>   static ssize_t flags_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   	u16 flags = __to_nfit_memdev(nfit_mem)->flags;
>   
>   	if (test_bit(NFIT_MEM_DIRTY, &nfit_mem->flags))
> @@ -1576,8 +1577,7 @@ static DEVICE_ATTR_RO(flags);
>   static ssize_t id_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	return sprintf(buf, "%s\n", nfit_mem->id);
>   }
> @@ -1586,8 +1586,7 @@ static DEVICE_ATTR_RO(id);
>   static ssize_t dirty_shutdown_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
>   	return sprintf(buf, "%d\n", nfit_mem->dirty_shutdown);
>   }
