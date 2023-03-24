Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547F66C7E60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCXNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCXNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:02:20 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3B1F933;
        Fri, 24 Mar 2023 06:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv/02ZuhYgbPmqn+y/eLbH5O1Mz0ZoRAmf8Y1DqRrPHcWXifVxp8uiwk1nWpoLTQ975nA29WZAiV2VuxoUurlILJVQJxf7ysL6O3Glz5WMr74SvgzG+o9OwPTnsc4lFLuGdlTHlOLLO3oOSc+FGDSIlxynAGzdy7BaNgZXk3pIl6a5NKLMH4jUOBF8eUT7JbNWTfMzNMj8qVddsbRzvJA0OHI6hp/ffXQUhTT88R1DAOon2xVQvMz3z72yn0zQsZMmmXGPjyfooURvBpXEAKNE4AyUswxd0wpF32ikpoCZcEw3wyBA/+Jwji+wq31SoBfxnZPqH8AwL0luZAHg3f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvpRzOOt+bDCP3nBKnjirqJw+OiJKxz2UcqUXaJu+70=;
 b=feTnaA2SbkUwBxlrOsvyrh+0amcNaEKrAjle1kZY5hDY3zIMBPsxs1ExfJ/hG6bnLKUNk+3xcyXzCKsAZqhVc9bdEdJ/WMyUpVBpZSFuXjMwd5CFwGJ6WbzN1Cqf2bEpisTzKfdISjCAb8u8cCaKN5dIbjaK76QcelV7K2LxPLYfyNmj8dHccTwgfIhCirgY+0JmhyHOyFC3v8eU87K1DPq8HUWrJ6isozDGsk5R7szEh1S3343y8HJiiCe+MpryE9HHjvaR/rmeb3bCKwu4R5CcHRtsc1yX7KO2ZouZtZrtBYajUj7iXjQ7gncY/c/GRQdQqvaT4swZ0K1pX837mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvpRzOOt+bDCP3nBKnjirqJw+OiJKxz2UcqUXaJu+70=;
 b=IlIBW/GbXbCcmxlX2xROdCbRdwnOe5y6XccvnG3Pvkf45hD17GVDH/pNu/I6/OLEIKszUFjJAtpoInS8IdEU/mcXoif+QTq46NrOPbODJ1iTj6Cf8oxC8l55hTA2OJTbWXQj70gLkl4H7yK+GPA+HirbuWCS5zeWqXFjZTWGm8RrlWS6amzcqu70qcckRfOsoMUMy0pU/9lx4xHAbApX0BoMZS8syGtqh0xsTYof1z0lFQ1cAgynzWMNw0Sx+kcaCgMjsPrfqyTg3mjuDsyWX+/P3/AKlCLqQ+ZGl88MOZ/h+24SnZd3+ULBkkEox8heUvLcpf2rTMbik8dRd2JAZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6927.eurprd04.prod.outlook.com
 (2603:10a6:803:139::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 13:02:08 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:02:08 +0000
Message-ID: <71176c99-cacb-9a7a-0b4a-9e2c5cb1c3b5@suse.com>
Date:   Fri, 24 Mar 2023 14:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/12] module: move early sanity checks into a helper
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     christophe.leroy@csgroup.eu, song@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, prarit@redhat.com
References: <20230319212746.1783033-1-mcgrof@kernel.org>
 <20230319212746.1783033-5-mcgrof@kernel.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230319212746.1783033-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cdddae-72ed-4e13-84e7-08db2c67f98b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpS6oxidHmYLWG6C6v8r3/UJ3486+PXv8k8h3uXJkj49D0jqUQ9yNhlVcYLuWly6wU1yV9xgwEqrsvhNLyCt7hz95aqd8ys5j80wZKkb4yPOqfylUMJWNLsdCSj075lTvGgrobOPZS1+Mv+8FWl5V21VOvNkoHohhsDGpK0RPjCy2CwJD9m4r9knYbe/t7MjjHozhP6n8GVyT2RGMVyy2GBbDTUZOOgEPpZXc+ylaU4NHOGGZ5MREOEf9+SmSbdtoRho7TpHEsRCG10SAsP6I+/R6nyy9/PHkBYGegLpQCN/jm8SOeoTm05+IvtOjjoXE9WncttdMqPOH7PQTUTWrGgTO0fWZ8gYrA+bcW4FhTr3kfc5fAOAsgzqaeVFo49kb4raXMIdqVBJ8dypIRinzvd9Cu3ebGNTijl1kbZKUXwhQiZ3G3FOQOlGlupCISwrKZ7Sie4dilXemXkiEXdwi4jiFjpnV8iDGxzPBqXKrUGyskafj417dg2J3HJ14rIZTDfpaWcYHipAboNof9iYKl0kQdMs0uyVwAHgmPjOuyqzhszFDL2gQZuxEnltllAjo6tyZZJkXVRAsvA612tpxwPSYJyaWw63Xx3HKa9OiMHa7TMkV0ZYIl5rGXj38IKMAHxxD+LcaxPA3zCsKcShB/yv3cSwcgFvH2ClKvA8s3Cq1AxDgchh6APlh4y20FVH1Z25POU1AvEGvTYiqrk0orguVv0M5tfKjcTmITVcKAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199018)(38100700002)(6916009)(31696002)(86362001)(36756003)(44832011)(5660300002)(66476007)(4326008)(8676002)(2906002)(41300700001)(8936002)(66556008)(6512007)(2616005)(53546011)(186003)(55236004)(83380400001)(6506007)(66946007)(478600001)(6486002)(26005)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21BTk9TSE1SNkNEbVZubFIwaVJWaHVYdHlBYXcrd2p1OG5PUkJqSmIva0RJ?=
 =?utf-8?B?MkdaNTRnaEVhbVRuNXZNdm05VmpZTnRuczRGMjRkU2g0NnNIYzBJZ0wzTkc0?=
 =?utf-8?B?MzBlRlAzZHFIZnNlek9BeTRwcGhvdStvNHN1QnFCT29DYU9LcXhxeXlQOTFa?=
 =?utf-8?B?L0xFcWVIdWI3Y1JiaFFsMWo5amdMUGdxUUZUTWxuV1hGdjVpSDhQS3ZPNG9v?=
 =?utf-8?B?N0UrQjZDVnBWNDI1ZVBFTXFWU3JDVENENmQ3aWllZmRBaUlPUDJmMkFORGhu?=
 =?utf-8?B?Q0E5QnZ2Ri8xd0RvcnVld09mOGRkZTZYcVVHZG9MeG1Gb1I3Z2wybnBvVHY3?=
 =?utf-8?B?M3AzOHlTTkZHL0VuS043MTVIQkhmYXlnWEQxM1dzWk1RZHptZUdtZFJha05N?=
 =?utf-8?B?a0k0Q2lFbUtiSTNScEtGanhManYrNkdyWEJlNVpGc3VQOWlnNWUrakM1NkVG?=
 =?utf-8?B?NXZZcG9YZFVSZHJTVmNOZmdrTU9LY05tbTJyelJWZDJsN2FFTU90N0N6RUhu?=
 =?utf-8?B?RlVHRTY1T2xMVlFDSVhHVTArQ3MxUkZKVmQ1d0RjN05WUmFZWG1aNVI3S01Z?=
 =?utf-8?B?UmpwZU5zeEZ1TVpicU5TMTRNaW9ZaXQwR2kxYVJHai9EbVJTSHFuMGV1M3ZD?=
 =?utf-8?B?VmdoaHplTHllazlXMmEwR25RQ3JHc1JndU1iZWFmb0xDclFyWXFEOGF1SXA4?=
 =?utf-8?B?QWdwOTA5eXFxaXZqY29KK0lyZUVSa3dXSVEwT0FPWTl4M29NNnJ4TVNhdktR?=
 =?utf-8?B?Skxxdkw3T0RkYXZQY1hsdk5FdTA2cDUyeGhTWmJ0Tm9ETTIxdnM2SGZtdlBq?=
 =?utf-8?B?ZXhVRENtYVByUGlaR1JWaVpvL0JrQ05TZFlTd2pTRlF0YXhZR2FLcW1IaTVV?=
 =?utf-8?B?eVltSjZtcGIwUjFpdmlIY0p0WmRRdU5TZWZNRkthWHlBYnBxdi95bzd5SGpu?=
 =?utf-8?B?WnJZd1hRMmYzVFRXbWZDYTB3am54K3I3UlNHSFpsdWJHbHg0MmhYalR4SkhG?=
 =?utf-8?B?UEl1bmxQa0UwQU00b2Z2UEZMc0Z4aGFFSHJ2SzJMR3BHbE8ySGs5VXRXa1pB?=
 =?utf-8?B?T055aVlRTUl4U05NM3Y4RWpIMUJuOGJMMXA2aXpmbEtTbWs5TkpiZjUvOFZT?=
 =?utf-8?B?Nit0UUR3d0FHWUVialJpRUQ4S1pVUThPMDg0SFdycnhuY2tIK1Awdm10NVQ2?=
 =?utf-8?B?bU1mVjgwYXVIOU03N0RLV2duK0pGZ3BQTTN0ZHR5MjZiSUdPWnJhWDNnNTVU?=
 =?utf-8?B?bFcxZXd1VkxZNEhlb2NtWkJWaTJjdmREbTRNU2dBUENEa2dYNFVlcHl0bG0z?=
 =?utf-8?B?M2w0Zno5YXhwSTRxaVFERm92K29EbjErNTVRNTdEK3Vnb2hLaW0yUCtacFNM?=
 =?utf-8?B?MktKQXdUd0NESnIyTkpMQW1wYlcyd05ERmNCM0NQUlZ2d2YxTUUzNVhQMWw2?=
 =?utf-8?B?TGFaRk03Q3VTckpmWTM0OGM1Rk81RHI2a2txM09BZ2hhbnltdzNLS0V2R3NX?=
 =?utf-8?B?b3lHQjd6OGhDWERDaVRZdm14K3JGSDhUQkNoRGlvYjdSU2RZU1M1QWl4YUo3?=
 =?utf-8?B?VXhWMTNIdTJyaVlJN05naDdDeS9hN2I4QXJmTU9NUEZvL1RRMjd3M29UUm9N?=
 =?utf-8?B?d1NGZ2JvL2FxelBUOE1vRVJvaDhseEJlQ1NvU2dta3NMUlI0SHIzbDRhNnEv?=
 =?utf-8?B?NWVLaDFlWXpaWlY1QlQwaTZFQ1VKajFzak1xTHdIY0FlZWJqYkxRZ3ZxdTNQ?=
 =?utf-8?B?M1ZUb3g4SWtRRDJwVERGTldRZHlzOEtrQ2NrSjAxcUl1NlFxVFVXYnlOM2dl?=
 =?utf-8?B?TG9tVThDaTh6a2tsaHJqQ2Y3WFg1K3BGaWtMQnowMGFFcW00OVVUK2NPQ0pC?=
 =?utf-8?B?ZUpMRnZMYTR6Y1lvWXUyTHgxVDRKOXhOUFFjdTlLei95dk5XanpCQ01XWUVE?=
 =?utf-8?B?dTdmSUdxbmZoblh4NFhYR1lpbVQ1TDB0cEZKU2czWVhMQThXTlBKdURwZjky?=
 =?utf-8?B?RlFxOTFxZ3dxMjgvM04yMlA0R1BTR05ubFQvY3VFM0d6UHZXRnNRbmhIVUhS?=
 =?utf-8?B?OHVVd2FZTkRkRFpsZTlNZlpaTXBVV3BoU3Avakl6OU1ZRS9xTEVqNjRYVS8w?=
 =?utf-8?Q?EN6pfXwjvhfYYo8zUDe5gQILB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cdddae-72ed-4e13-84e7-08db2c67f98b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:02:08.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDFUN2gG2oLKqXnrusE0k+c/Np8HHCQVFUyh3SKiO2fKDmGOYn7esnqIjGTvf1qseSYrOJG7HXcBm+i0qqXR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/23 22:27, Luis Chamberlain wrote:
> Move early sanity checkers for the module into a helper.
> This let's us make it clear when we are working with the
> local copy of the module prior to allocation.
> 
> This produces no functional changes, it just makes subsequent
> changes easier to read.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/module/main.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 427284ab31f1..933cef72ae13 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2668,6 +2668,31 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>  	return 0;
>  }
>  
> +/* Module within temporary copy, this doesn't do any allocation  */
> +static int early_mod_check(struct load_info *info, int flags)
> +{
> +	int err;
> +
> +	/*
> +	 * Now that we know we have the correct module name, check
> +	 * if it's blacklisted.
> +	 */
> +	if (blacklisted(info->name)) {
> +		pr_err("Module %s is blacklisted\n", info->name);
> +		return -EPERM;
> +	}
> +
> +	err = rewrite_section_headers(info, flags);
> +	if (err)
> +		return err;
> +
> +	/* Check module struct version now, before we try to use module. */
> +	if (!check_modstruct_version(info, info->mod))
> +		return ENOEXEC;

The error value when check_modstruct_version() fails is changed in this patch
from -ENOEXEC to ENOEXEC and updated back again in the next patch. It would be
good to avoid introducing this temporary problem and keep the value throughout
as -ENOEXEC.

> +
> +	return 0;
> +}
> +
>  /*
>   * Allocate and load the module: note that size of section 0 is always
>   * zero, and we rely on this for optional sections.
> @@ -2711,26 +2736,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	if (err)
>  		goto free_copy;
>  
> -	/*
> -	 * Now that we know we have the correct module name, check
> -	 * if it's blacklisted.
> -	 */
> -	if (blacklisted(info->name)) {
> -		err = -EPERM;
> -		pr_err("Module %s is blacklisted\n", info->name);
> -		goto free_copy;
> -	}
> -
> -	err = rewrite_section_headers(info, flags);
> +	err = early_mod_check(info, flags);
>  	if (err)
>  		goto free_copy;
>  
> -	/* Check module struct version now, before we try to use module. */
> -	if (!check_modstruct_version(info, info->mod)) {
> -		err = -ENOEXEC;

Original value here.

> -		goto free_copy;
> -	}
> -
>  	/* Figure out module layout, and allocate all the memory. */
>  	mod = layout_and_allocate(info, flags);
>  	if (IS_ERR(mod)) {

Thanks,
Petr

