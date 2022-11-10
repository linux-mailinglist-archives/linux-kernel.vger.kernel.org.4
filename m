Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D996F624693
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKJQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiKJQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:07:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6132BBA;
        Thu, 10 Nov 2022 08:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeMOGFsqyllwHXnUqqgpjAyHtYGjjEO/F+qdtGqTjQsGqPln3w/jVn47u8Re2G/1nYlADr/TLWvxh67DBml2biW8WcxiKQutx+iP7sNjDXrHzw33R7rbZzgB8Z6B3cXmZrp5QlgGd8oPCvLJmXK86hWcoje83qYxQHwSBZ/2ZMUzlqlviH680paoz12BxYJ0HPvPLvd7MDX0gsPGya34v/qYMeTnFqKx4cln2d9y2A8ARGxUprF6ear3f2u7mFnDavSU1YNmgINq++pcOlUatSuU3y8LtrrlE2/QsMWjia03aUzx4uJZ0EICsX/MaEEyWTMwJHTYPq+ZaTlQgOcjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az8PNtsobkU8s8obZj3l4eXd91jPOxhs/RplpT02/WA=;
 b=AJ76quxpJ/TTZS4MiWTz3ycU2rFIullCbTlPty4rGXXt/dhvAa1f546Th4aTylfTOGxKXacWjUneHUY4IyZkH1S0zAUPc1A7PJS0GfXurN6OB4wqEXCNQJVEHabQEzBubYHgvVrihHpT5z5d25Vq4MotPOwWhZWAupdWxeENMy/FBRZRO8WlYB4HWC7/4RDkodwxXnKU0YFpD20nMAtZ6PTFsT7Jy2vcexPe4j9lSb4KIr+wpokBRUNxsIg8/ZRf/Mtx9IXjNhp1H8qutTE53/c3MZ/xzUHFDgHz1RQ2bnTFkoUTKbVGwsWP7zNP0pLYzOCccaeTEGisUbqoWIx4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az8PNtsobkU8s8obZj3l4eXd91jPOxhs/RplpT02/WA=;
 b=EOs9avpf9L3FTzfNygo5h/usPJM2YUbjrW81krNdBNKLu5kL4T0QdIUx2mWq4VOLIejwMfMOMBo9yP8rIplz+/JL4GyhOW7KHnH8QRD5wbOXCtx8g2+7bZz37W9E3YT6FDquEsrSU/NewXBi18xFPkIJ8nzQUYdFTz5ZUoifb9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 16:06:57 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a404:1a79:53c:453d]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a404:1a79:53c:453d%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 16:06:57 +0000
Message-ID: <2c4f7c3c-bb05-e16c-19af-451fe167f2e8@amd.com>
Date:   Thu, 10 Nov 2022 10:06:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-9-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <20221107175705.2207842-9-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:610:e7::9) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa8ebb9-de7b-4d1b-b2fb-08dac33597be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/AliaXFx6mFduH7aP45q5ulmtZURJDGWVm6wREH0X8niCc47nli5NJslSxvA8douyrav3yYFSsgtpq0EwyUGVtZ7EkC9RElcQmbjNEnQQj5db4mBux6T0ABrx8AjvJUOHC7qtkFZmiM3LkpJbeHUVBobnOwZD4pC1/8lAqbNfNdtK/CWxzWPMgDNbNmdr74grDbU1RpSjv59MsQMWvFeXwH5HWj2tWCLhB0rIrViRRb/1QgWA2GiOcDdw5M97AtiFOdla/mfuOXKR7aRmDxhK5YjPuZqOi5VWqRLXkS4bfrEcmmTUWfFOJBdyMXGH9ntlU3xmwvWptryz0ms2l57kyuQRpGqZHbrGlp0lvlsbUVwESNJEtu2F+cnr7pr0isXlAIkQjF1dX2Vgwo8miFWecLopo3Lpsjew+V3Ou9Zki0yOtwVpVkI25w6vcOjyVn9zDBnU+E3j0XO07ipMY3sGqxIJKsfp6ek2ASWakm8jEc5Bt+6oSKr8mR3FojA+fmE7+rK/8NVXbdCFapOX+7idffaXYfQ04wroCo2Fb6YMg+SefKajEwupUzRzWtl2JVUrnW+6ZR852F8FhMmCdcN9OAn6MYt1ARdxK5SBI7ntrdtkQDgTSSsh33OhBiGfZ7EcbfmTH/MAtepUlMZf1tEOIM+OMmSzDRVWBlsltoWbe0a61WJPiS33jFX7+1sy9B4i7/pin07fcpIVeHIrNNFMnvwDI8821v5i1DpgkE21n8dwr1/pmrkNXaQQoBDc8lnmrTplqiLGW5Tt9jfpCej5tNe9q/g8BkKgZXyxtOBx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(31686004)(36756003)(478600001)(38100700002)(83380400001)(86362001)(31696002)(6486002)(2906002)(6512007)(26005)(44832011)(6506007)(53546011)(66946007)(8936002)(5660300002)(41300700001)(4326008)(2616005)(186003)(316002)(6666004)(66476007)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdtb2ZQS2l6RmtZZG8wOXR3eFJFYnJsclRPZ3YxV2RsUS9jRFcxLytOaXdZ?=
 =?utf-8?B?TmYyV0wrK01STm9OZFMwZWJ0ekpNRk51SW9kdTBOSHJtWXdISmk2QWlaNi9o?=
 =?utf-8?B?WFpLSTNaY1N2ZmlIWVdVQzFhS2ppRmcycC9iSFhzcjJVeDNxdTVwbGRJNkdX?=
 =?utf-8?B?WTVjVHhWOVluazMxcFlWRGs2aFM5bEo1djB0RWlBNXFoZ1hmSHRqeFRnaGxw?=
 =?utf-8?B?Zm1QK2xCNG9uZ1RGUDdPVjN4L3dUQi9rbWtiblV6SWhKOTRVQ1haMEZsQkF6?=
 =?utf-8?B?cWxaU1hibVUzWUwwWnM4U2FsRDFjNVpNUFZucXc4U1ZXY2JPMGl1QTVyUGVj?=
 =?utf-8?B?UktsWU5UL2xMK1NOZmx6QWJuR0ZJYUFzUytJMDJrSnM4aVpBZGhZVzZCWkNN?=
 =?utf-8?B?eWFuQWt0MERJOXo4ZjdOV0xxdjRqd1Bza0lhc21oZVFwNFp5cWZmOXFwd3hm?=
 =?utf-8?B?MG9aVThaMWZZQ0pCaGZxTHgvZWN5cWJhOXZ5UXdoNHVWb2Eyd0M5QTI1UTZn?=
 =?utf-8?B?MUxKbDRLYnFKQWFXOHdIMjNGWU9RM0t5WDllWVczbUE3TU9OMDk4QVM3QnRE?=
 =?utf-8?B?Ui94UnNXdmlwaldOOU9ZSW9PekZrM2F0ekQ3bkxaekF3MmVYcG9SZGdoV29w?=
 =?utf-8?B?QzFSdnlob0Y1Mjdob2QzUWJReU90bEI2YWs1WWw4QmFvbUJaM0lSRFN0Wkpn?=
 =?utf-8?B?QnNPTTVtRUNoL3d6U0thbFdSR3VpUW1JQk9QQ2tSWktXZHFlV0ZwS0c0MHRo?=
 =?utf-8?B?WEplUUxJaWRJZGpWd0VxSEY5U3ZMdUw2WW81UUJvNE54RnpienR6ZklXdG90?=
 =?utf-8?B?SHUwZzBZV1dYMTUvbE9uWmxMYnhNNzhWQ2w4c1NFZjROSDJRczN6NjdpdFRU?=
 =?utf-8?B?RWRqczdhenU0K3JsWlFwQTNpVHFpOHNYUlhaUkZUVk1DaTNZSVd0dmJ3a3p4?=
 =?utf-8?B?Ty9MNHYycTAvait6c25nMDlwVnd4TlJ0SzRLZE52UHUxOEtXbmR1NXlSR1Fu?=
 =?utf-8?B?RlB1L21DWjNXbjNZNVhkbEh1L3FSY0U5c05PN3MraVl0aEZlOTAzZ3RJQU9D?=
 =?utf-8?B?NmxBeXBXOU1vOUVkc3NBUHk5MjY2NE8vVzFOV1ZFYnJ1b05DRW5uaXl0eG9N?=
 =?utf-8?B?OFd2UUMwaTdJWW9DeDlhQ1RpYkJIeTIrWDV3SWhPazRBN1dsbUYzc2NlSDFR?=
 =?utf-8?B?b0RtQVdlaWpvVndQbGRDRXlKT0x2SCt5cWFsbnF3WG9XYWhBQWZWcHlQQlAw?=
 =?utf-8?B?UjFaMndjbm9OWjlIS3RQRUI5SnFkaHR2SFY1SU9Cd05lL1V3YllyRkI5cnJX?=
 =?utf-8?B?Skw5Z1JqczZJZHJudCtrdnkxTTJ3RXlTTDBjNlp0K3JQYlRQY1doc2VIdVV0?=
 =?utf-8?B?VWZ0MmVObkFrR0hwQzZyNEh4RkxyQnluQUdrUXB2VC9aMFJEVXdybGJ4OVE3?=
 =?utf-8?B?anhPcVBXajc5S21XdmRwT3ZpNXBIY01HdG9IeVh4MXh6d2x4UEtkOWF2R0oz?=
 =?utf-8?B?NXVsd0pPSzg0QjhVcmRLaVdvZ25aTkRhdEQ2Z0N0dGp5NVNKa1V3YTluT0J1?=
 =?utf-8?B?RTBpZFBQTmdhV1VpSlFrZ0pDT0wwNFFkc0liQjM0RjhYTnJqTTVTVEliTTJl?=
 =?utf-8?B?VzBiQXgrRmY5ZlYzc3dHZnh6MFhkWUh3RmRPNEc0d3N4WjFrd1ZPOUZscEdG?=
 =?utf-8?B?cExXeWNoTkRmS2NidWt1ZGZZYjdFQmMyTkt2YUM3L3FhZ2J0dkFaMUIyWnVl?=
 =?utf-8?B?TkNOV1pLTVNpbDlsN2d6YUxQcHllUTNBa2hQcFdMWC82VkhnNGpsUGpFL1Rj?=
 =?utf-8?B?NXlZa1ZpbEl5WVpLLzMrZlRBYnl3Z2Nya1BmNGR5UXcxdlpiMmNvZUdnQWM2?=
 =?utf-8?B?ZFpicWhPSmo0R1Q0dEZWVitIREs2OHc5V3ljUWFoTnBYOVgrTEswT1ZIMGx2?=
 =?utf-8?B?YldBZmk5UGdiU2dPMmhuRndyUkdscEhKa0xBc3djb2krZlpiR3ROVnpHclhL?=
 =?utf-8?B?WG02YmJvSWZjYm5uT3hMUExqV2l4WjZUdFNhLysrMU85R2Zyay9FbFhPaW5D?=
 =?utf-8?B?djBxUjdxWDNrNU82YnVLMUhMcld2ME9ibUxuQzFtVzlyTk9zemVHaml1NGZo?=
 =?utf-8?Q?9JVig6IiFxcaVbmHuQnV7UGZn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa8ebb9-de7b-4d1b-b2fb-08dac33597be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 16:06:57.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMXrAx8Fwc4R6DpimRvH6m800zxanXrRtWo8mH4627Oz643cOmdGigUCQxBI5XVPIqP2svyzK6Yrzcnubfo8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 11:57, Perry Yuan wrote:
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6958c5fd9e1c..eadcc9d61d39 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,8 @@ static int disable_pstate_load __initdata;
>  static int epp_off __initdata;
>  
>  static struct cpufreq_driver *default_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct cpufreq_driver amd_pstate_driver;
>  static struct amd_cpudata **all_cpu_data;
>  
>  static struct amd_pstate_params global_params;
> @@ -819,6 +821,46 @@ static ssize_t store_pstate_dynamic_boost(struct kobject *a,
>  	return count;
>  }
>  
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sprintf(buf, "off\n");
> +
> +	return sprintf(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	/* FIXME: add driver dynamic switching code */
> +	return 0;
> +}
> +
> +static ssize_t show_status(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_show_status(buf);
> +	mutex_unlock(&amd_pstate_driver_lock);

Do we really need to take a lock to show the driver status?

-Nathan

> +
> +	return ret;
> +}
> +
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -826,6 +868,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  define_one_global_rw(pstate_dynamic_boost);
> +define_one_global_rw(status);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -845,6 +888,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&pstate_dynamic_boost.attr,
> +	&status.attr,
>  	NULL
>  };
>  
