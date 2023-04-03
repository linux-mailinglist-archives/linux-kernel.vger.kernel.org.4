Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42D6D3BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDCCFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:05:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAD9005;
        Sun,  2 Apr 2023 19:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV7KQ4o+DRlCZPdw/9D49JqDxgYD3tKQoivlQWD2f1wOsQbOzAfvGytv+MrMpRBPMnJ+MAR0tHcVqsaw9MElxL8+HQk5n40Es/RpL3nq9X/PCmtWU43fAqWggAG0be4k2036TINzH0GDw4vudG7ccwPb0VnBjIFX8rmEdXnyAaXCayoN36A2CTPT7cHriCcEifHUgtpU876vXiUzZukD9MtNYUB5cMOQd3Ag15nFT0/JgQC9F+EgO5tlqcfoYMx9ODClToexbJReixej4ikQjOXpmlVhoXkDJ/40SmtiQWHJj6lCZsB+dYgibaS5GG1/vQFdzJoQBgo0FnMfFAVIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSHHWTCgsI7OGujiYlqWXO3wBuQYxZ5zL4J8lBEpWIg=;
 b=ZiJIpAHRL+C2vW7fiDY8q/ZSKc+nBml7eGL+ScIc0QHv0joJMwNOCUxYgPpWgEZqlme39UCe6WubuNJTchiG/2cjR+3dyC/vLVBEzRermRPET4rscpCGNGg44DMVXCH20YUQ5ePxMLWbPBPAcL43zCan9c9Nsh6k87ZB9N444iUmlgwMcuFWgXa4uAOzsEHhThcJs3d3TZTKmnQNSdm0WOFictpY5JCd7iUBWUeNpg0FeXckqqmLWeUcN78voHQrmMA4L5EGQu+wB80LYxN6QQJoYZSAUzAALVeSYa6xbyDYzf8oQEORghEcvxZ3VFWJC2T3+cAg45Mj/vZPr0Tpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSHHWTCgsI7OGujiYlqWXO3wBuQYxZ5zL4J8lBEpWIg=;
 b=LPVsXbaEmYYmDLBszubQ5aO/ScGXDo0LdFEhi1iQrVkIJJQAPcbhxusEZGvwY9AWR04jTSU7hT6cQ4KLxpTJejHM9QwUxijUgQJWjGl8Gc6xqwX2NA7o86viCK2pWzuZgHmY6S3DjN3+avvo4S5hkOL8PwKc4F72e9trxIsCnPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 02:05:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 02:05:48 +0000
Message-ID: <1a758838-0196-86ee-cd26-cc8c930f20dc@amd.com>
Date:   Sun, 2 Apr 2023 21:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] platform/x86: think-lmi: Clean up display of
 current_value on Thinkstation
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
 <20230403013120.2105-2-mpearson-lenovo@squebb.ca>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230403013120.2105-2-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:5:337::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7088decb-1127-445d-3f9d-08db33e7f0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drycyKZJzP07CTKQ0t+fgcKH2EaRourNUHO9kpYEc78HX5i8udYmMHBm9MwCqBCh5rfuyXvl/oU7MuzgLMB89z7Zo69ruk5lafqyaVkCgS55XYViqrSy1conUjNXVhAeKw1WPo5Oh46KGtVI6R6u821lYJECg4lWdPRQHmkxGrdtJoU+EoV2oUZnvdNSnJugRLFN1lFxD6mth4wQ+IclEYw7IImsK713gCO9PwTijxVZqDuJbD3AMJ/20ZlKvsFoewgnaCJGCNSRHx5cimu7fnOYc0gDUys4tvUp9SjjtbOIEHfHbd2s7c951YRYOfgK6HBEZhAAstRlf48R0Tdda+E/zXcbX9eQRA7LapN1lnp33EbiNmTmF35p9MFrCBK5i9hGqiPKFikADKhtyegB4/YWJY+bZfefbzzcXKSO7YtpSimONbo2GonKJH52kUtHo4vGTUBIecS2eZL9xm4pb+/kE4Y2DTHQZcqIOfPtFPN0riQfvYQ5LEdiUN+ss1eR7tmuqqPlpEaMeO03qotEO8QVCkRm9KLUDnQGd/a4a9+9fHvYJY0mU/rRP8yR6S9L7ee9Od+jx0t7HaAVNWvLgvY7oL2hLGnEY41fwLma8U4qtSI7ZOCJ7BydFuYZk/SOcRHglgxDFPjBlrLmYaShUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39850400004)(376002)(451199021)(8676002)(4326008)(6916009)(66556008)(66946007)(66476007)(478600001)(316002)(8936002)(44832011)(5660300002)(41300700001)(38100700002)(53546011)(186003)(83380400001)(2616005)(966005)(6486002)(6666004)(6512007)(6506007)(86362001)(31696002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJIWnpNeGxqbFZNdWlidXdsdko2VThZT1Q0RXIvRytyOFBGeFpUekc2eGp2?=
 =?utf-8?B?QlZKcTUvNU9XRHVtb1M1d1orNmlmaXMvVzF1V2VIcVJrYkpoSXNGZUtoT0dZ?=
 =?utf-8?B?RFljMW8ydytLNjRQbXg5dVQ1c0NFc0s1UVBoQ0R4dDBscVdoeFZDNGY1aGZt?=
 =?utf-8?B?TTM4eVljUFJlQ3VYS0J3dk5xZlJwQnhZUTBnb1hPeUNLRlBQMWJrTjNZVkpk?=
 =?utf-8?B?U0xNVzl1OXFtVGFKOENaOEFScFFVTzBWclVtR3o3V1B2Ni8zcFpRS1ZJeWJw?=
 =?utf-8?B?LzNJM2NRMnZtbXBrVElzb29zajF2eloveWpjSC9YOWhDb05XM2k5QWU4ejR5?=
 =?utf-8?B?NHdCbjgrQUdNc2VEc09lQ2JUV21jUlE2Q1dDV0RTdEhMc0tnVWlRQlZldlFj?=
 =?utf-8?B?bzZWb0kweWY5NnhNdExhdlp4b0NPSk9abGJpUFQrK2FsR0NZbzRkd201SnBE?=
 =?utf-8?B?SnJxUVBBOVpkc0NQMWdYNnNnV1NiV1lKOWpHY1J1V3RxZ1VFSUxRVlVhTFZG?=
 =?utf-8?B?MVR3U2NzL3ZIdDRmTFZub0IxZFNWTTlJckxzTkJxK3BmbVlLVEtPWkc3NDhY?=
 =?utf-8?B?TTVwZ3VyU3pCQ1QxazRFUUl3SHVJWGVkYzZJWjNQZEJoUGFHYlZZaHpYMERw?=
 =?utf-8?B?dmMxOTlreGlmVUlUbThhaksvQXAraTBSaFpnMGlPZHRkQXUzcHFWUFFsVWx0?=
 =?utf-8?B?ZllneWxCK3lRZTd1Qm5QKzlXSlYrLzV6MWVsTUwwK1hjbVd3Visvd3EyRkRr?=
 =?utf-8?B?bnY3RStPZFVyRDdOMjRYL3RUMlNHcjAyUHVKYzdoT2NyV2pGcVVzNGxNczRH?=
 =?utf-8?B?RWR5NHhHMUxIM3RBSDJWbGt1NXV1TnRKOVR4bW9ySloxaXhtb1Iwckt2d0lT?=
 =?utf-8?B?VXR6cWR1eHJ5cEJrV21kZnI0V3pzaDg4RW43NGpwa0NEeDVOL0dUNFFvbjFw?=
 =?utf-8?B?M3FQbW5KL2ZRa201VkRNZnVSYWJtMEJGT3ZpNGNBcmRYd2pQUG1FNWR4ZTR0?=
 =?utf-8?B?eG9PSUUveEYyRjVJdksvZm9YeCt3WHI3NWVuUEFYTU5SR3FwNmY5ck1KZko4?=
 =?utf-8?B?VU1VMWRYdituUkxEcVJKVHRNeml4L0U2TlhNeVA3Y2dEWnpWeXRzdmczMDN6?=
 =?utf-8?B?aEhHeHU4c2oyZVJINmFtTkoyQzllWHFkdmlneXdzZ09JbStwTEg2MG9iOFZR?=
 =?utf-8?B?RmFXYUh1cE05SHVNVHo5TDF2N3hSNFhVSWhBZDVBa0dCanpBQ1RjcHNwMUZQ?=
 =?utf-8?B?T0lvNzhEMzRPR0NMQUxQTHhiZWNDNEplZmJwckRURXgrdmdTNVljVXp5QWhJ?=
 =?utf-8?B?MWZYVHFlQXZadmlyMEJ2OGF2SUJWcWFQRVU0V3VDKytudG1jeGVXTThPUU1M?=
 =?utf-8?B?QXIxUHVkbFNTMXNEMVo1aVhNa0F2SzVQWlJmRVc3UWhGRFBwRkVDMXNTemw3?=
 =?utf-8?B?S1l1ZVJWaGZ5MFRZUERQZEF6RkI2c21qVXhjTjY1U0V5Wjc1d2xDaDVkbTFw?=
 =?utf-8?B?aGpZVnNEaFA5OGlnT1VCc3p0ZU0vQ2JZMFlYMkVKOGhhQi95N1lkTXExWWtX?=
 =?utf-8?B?bVNSYjFsNlI0WlVNYzEyWG9Cdmo4S1llYnNuSis4WWhnNXBuaFhoZ2tOV0JB?=
 =?utf-8?B?SWZuOVlZM21vZU54SlRnRG94RlY1Z3lWVXRzZXZMQ2FvR2VNMks2b2REcVhl?=
 =?utf-8?B?eTNGZXk3dGZ1ZmFwK2l1MzdJbXgyYjJGQnBnOTQ1QnpRSWkyVzliWFB2eUlj?=
 =?utf-8?B?cmN3YUcxL2Nja2cvajJWQ0NiTGlXbUdtWGFCVkVHcUJaWlRZWFlPQ3g5Tjgv?=
 =?utf-8?B?dmhMYmMwbEFONldGYXZKSENmbVl4bTZYOTVWZEV2bno3eEE3T1lLWnNudCtz?=
 =?utf-8?B?UERMYVdPRkxtYWk5VExMejBNMm1ZS0kyVVZ5UDVmR0ZQSVBPUW95ZlgrbUg5?=
 =?utf-8?B?NXJTZUVhVnZIUlB2TmRpVE1sdlIybmpQbjdHTHJ2dUhmZnhIbFM4VFgrOE85?=
 =?utf-8?B?eDFqcVQxOURQODljcFJrYTFsdjVLeGpET2FNcTQyZVZnT2lqb3prWnFoSTV5?=
 =?utf-8?B?YWw1NDI2TUZyMVJubjM0THNTUVExczl2WEMrTCsyck1HckF4NTAyNFAwejNU?=
 =?utf-8?B?eVBrSmdENVZTOVh0VTVkTzNMTDVFNGRVOHErcG5TYjZFdkovMWtxYXBWcFNz?=
 =?utf-8?Q?Nr05lLEOim2IvQE3x/vBtTgIMoZ0osANWOe7NTgu9+ho?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7088decb-1127-445d-3f9d-08db33e7f0ed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 02:05:47.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTDPnCYLwBVNT2yP1c5oaJl1fHjVjacFo25ua5n1GDuS0xdW5piFKpB/rlm+zrwkPhEp/dz/KzLG6eAAhXOGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/23 20:31, Mark Pearson wrote:
> On ThinkStations on retrieving the attribute value the BIOS appends the
> possible values to the string.
> Clean up the display in the current_value_show function so the options
> part is not displayed.
>
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Reported by Mario Limoncello <Mario.Limonciello@amd.com>
> Link: https://github.com/fwupd/fwupd/issues/5077#issuecomment-1488730526
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2: For some reason v2 doesn't apply cleanly so rebased and
> started again. Hopefully this one works

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

tested on 6.3rc5 + prerequisite Armin's patch.

>
>   drivers/platform/x86/think-lmi.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 87f832142d8d..78dc82bda4dd 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -920,7 +920,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
>   static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> -	char *item, *value;
> +	char *item, *value, *p;
>   	int ret;
>   
>   	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -931,9 +931,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>   	value = strpbrk(item, ",");
>   	if (!value || value == item || !strlen(value + 1))
>   		ret = -EINVAL;
> -	else
> +	else {
> +		/* On Workstations remove the Options part after the value */
> +		p = strchrnul(value, ';');
> +		*p = '\0';
>   		ret = sysfs_emit(buf, "%s\n", value + 1);
> -
> +	}
>   	kfree(item);
>   
>   	return ret;
