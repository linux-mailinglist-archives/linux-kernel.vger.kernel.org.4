Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7638749EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGFOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:30:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA61725;
        Thu,  6 Jul 2023 07:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLt/DoI6cz2fF0gyyulx75CghzNzfKrNpD5hBfQwYXNFuE56d8VX4wjzw13ANXtzjf7oqALmWftvOK3l/CJkB48EN1ucokiC8iVqC6yVB0Rz0EqLka36+XtTX/t15wASP5ilkI/FsnXh942P06NZbh4IOOS8TmBlblJfOlKB8AHT/vVeX7uoK+MaHVwD6CZUGG8kD1zGuGRmaYekGPqjDE+JVK8aTn6tJbN0oJwGKEY+fssH4i1Aobrj7RLLVSxoxmj88ODsJnbOt6swQvrk3u0yfwy9JpHvFAuEY53ie27khbW4/TUAZndWBhBNHoijHVEXU2fP84vgwE5OR50lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei3ZH348uF17sZtE9osBettIs3oL6ViwCruJ4v0DziQ=;
 b=W9J/7ZFWspePLcNI3hnFvO+OQQ9sVeU1/YIl9ND9PYoWr6XmOGIYNMmHls+AFb1H81P5/I3EqIRxNZXb6yUiGYsb9I6OY+N9/jvWXbHKe5Te9K8zIwErTcnILWJ9Rskpi6sl/GMn7GpKojOkivQouptxDDJbXMMqE/FZLCqtYWgQikyCAP1dyANnIR8hLJ1FEsr+IxTqMit245zVquWFhf+Xs6i6BPv4mvdgHMatZSCPIs6U/z0wuKmE3cwNmQOOB3PFeeTPHWRoBf6Rj4fFSP5tibMd5MBgcFERrfcF7MJ5N365N2+9gqClb5n3A9DA6mY8qwp1srR6Q2g/+t0rPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei3ZH348uF17sZtE9osBettIs3oL6ViwCruJ4v0DziQ=;
 b=fiu3fh1b5y54fTtEg9OKfzJrFqY8Hcw3dbPY3VhYiF/Lrkb1T/9gJWJW32sFFYto+TrZdul3aWt/owvKDMpqr4Fo5+vOWWxStX7HG7P41PE4YAhqCnySLCEN/ZoctV5C+ZnMpo1ZGuX9tlc/TkeTcA26eebckY+p9M4hELBKBMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 14:30:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:30:37 +0000
Message-ID: <653767a7-aa27-9a5c-b37d-e017cf5b12f3@amd.com>
Date:   Thu, 6 Jul 2023 09:30:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] pinctrl: amd: Use amd_pinconf_set() for all config
 options
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        open list <linux-gpio@vger.kernel.org>
References: <20230705133005.577-1-mario.limonciello@amd.com>
 <20230705133005.577-3-mario.limonciello@amd.com>
 <ZKaGaVYOouPgZTSj@smile.fi.intel.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZKaGaVYOouPgZTSj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 19107b29-e653-49e2-7001-08db7e2d9107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujv/0xAE8G9Opokva+0ERnXf4T9jm+UaBCr0AmgGrE2nHJAaYAipTuuSVJhIFD09bCK/1xp78yfBICvdGprgmHYCuajeQ2Sw3L7y2e2D86sbpiiZ372p+DVupbaGK+wKf4BeiLVJE0feE83vR/48J2BwrnjiBP2f0aIBSdmNVmJ6FSoVWvVHCz8RwtPlGIsvquzBUkHRmF6/VSV8LHVyHInPGQfvjQ4i0Rw0Wd4Hp7tRVLrz6Gc6CQva3dBQHbPVvJyesjTkpWvieXRrUJSK2rQIpTFbakB8PNF7qzX0oEm9Vpeb6TVBFtOuFYCVPvMKMW5gjNDGb64zhNzj9lKDMnRCbPJAB0y6xl000gQcv9d+FHQ19moajjebG8am82x9auW7pmR4TbUESepvxVDEmCiyAQcb8eHWr99K0XY6zi0q0diFcYLrOOXHtZRxrIRpr4bPtOjuIdyIxXTvI0H/o4tvcywis1l91W/xwVFch4LhN3UApDzvQyDCckhqEPEzI029Wxj+vzzKH6fR1isD9dltAAA3SNYJg6SvW2FSAw03xLOlvHhtOUq35jl3hBDl4ulRSbDHQXtazXQKzTOnbacInRd10VNuQumZ2WsX/aW2kawcbSFr5qnKo1aCXTBHrOpuuMrlpvFe/wz09aCLnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(31696002)(86362001)(36756003)(38100700002)(478600001)(54906003)(6512007)(6486002)(8676002)(5660300002)(8936002)(316002)(41300700001)(2906002)(6916009)(4326008)(66946007)(66556008)(66476007)(31686004)(186003)(53546011)(2616005)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGptZi9JZytiMXBXYjNjR00vT3VOTXR5UXhMQ0xTYnRLWkMrdU1VTU52VWdK?=
 =?utf-8?B?a2x2cEJsK0hHdEdhWVVJRlNyaGRxKzY0WGFaVERFRlpVWjhjTERNTWI4QzRG?=
 =?utf-8?B?SnBQb2lLV28zelJZay85RVRhYm9DY2Q0bDNQVnZWVDY1UU54SkN1TkhXYnNX?=
 =?utf-8?B?V09rY0JsS2JWOXpEeVRvOUovdTEyZkdZaGg4ZFZDQk1BRkJIWjlXYUxneXZz?=
 =?utf-8?B?bitzWDliakNlTUw1U2l3Njl5VHNmNHZabm42WEg5VlI0cVhxd0loNEVSbWwr?=
 =?utf-8?B?RFJSKzRUeHFmUmVUaHJvYkp4Sy93RHZCMW9NNkRLWENscmxtZTFmck1sck1z?=
 =?utf-8?B?cExlRmFscHlzbm16WnZPOU5jM0V6UGlRYXhCa1Y0VGRMWjlYSEFzb01sQTNW?=
 =?utf-8?B?Q2NxYUo5NzVBelVLQmZhK0JtZ3g2bmpFN0xoYjczYVovQVhzVmlJYTFHQXk5?=
 =?utf-8?B?OUtIQlIveGVCWUorekZmYlAvYXFQOTV6S2srQXk2Sms5TWRwR2oySm1PYUJD?=
 =?utf-8?B?S1dyMHpNSDg0dmRuWDJOdE4rNlNOZjBPS3plc1gwU3QwV3doUTNXSVVabWhH?=
 =?utf-8?B?YTRKSWRyQmpickhXdTlDSWZLekRpODFZWlFRZUZTWlF2Y1dhTWRLSDBXQmpo?=
 =?utf-8?B?SDhIWE45UkdQR1J1UkhEd0pBYnZSdzIvdE9UQ0JiaWVvUkdzK1VlM3ZzZmx3?=
 =?utf-8?B?VlJia2t5NDZ2K3Z5Vk1IZ0hXbU5PSUFHUTZNaG5sb2NIR3FMVlNzb0tscTZF?=
 =?utf-8?B?TENnZEhMVFRLWnlyOFBWR3E1dXBSc1p5TlRtRC9lV3RQZHFrNjdUUkJmNUJN?=
 =?utf-8?B?ODUvRWxjQ1pqcGoyRzFXQ29zYUFwa0ZkZUFZS0tRNXZCS2J6VlJMZ3JhdjN1?=
 =?utf-8?B?UWtEQkIxRHBOL2F4cUIxZDBFY2dzTk5xT3Jnc3NkNVZoemdUSkk3a3RmVW00?=
 =?utf-8?B?Wm1TT3UzUWZsMm9sSG1GZW5xSUZBVitVcGZSRUhiTS93U1BLUndOeTIxVDBF?=
 =?utf-8?B?RDVrODVDTjFxNi8wOWp5OTB5RGlTWlJIb2h5UXRXL1pUV0ErTC9yaVMvNWE4?=
 =?utf-8?B?UTV2QUk1SUxyVU1xVldodmwyZFNreXdnQXZRQ05XMEh3MysrcURrSWt6R1Uv?=
 =?utf-8?B?QzBDQmQrc0dTYTVYb3BMeStNOGZxanJma2hEL2N0WlhVZmpxbzBHbVJ5Qkcz?=
 =?utf-8?B?K05KUXpUYnJvbkcwOEt0dTkvd0xFM3A0a1VXbll6TnpaSTFDTnVNUS9PRUJX?=
 =?utf-8?B?L2RQQ0RxbWJHRFZoc0lGam9LamZZc3BiRFBWb0RPNFNOWXZ3bnFlZzY0R2pw?=
 =?utf-8?B?NW9PVE1EcGFJSWd4aHFHRm9CdEY4aWZ3enh6WEJXb1NLMno3ZmRUaDAxR2dH?=
 =?utf-8?B?dWdKbzZSYzZqUE4vZzNicE5VYTdVODF5eVJOSVBVenVObWQvUDhDV1ljUlVI?=
 =?utf-8?B?RDJma1F4Wm50Mk5JU3FXYTlKSUVobHA0R2RDWFFBbnJ2bUJ0RVdRSEZHckRZ?=
 =?utf-8?B?emkvamwrUXVBdU9xUXVjUkVRb2Zidkw0RVJacVo4eG9XdXNHM0FqdFIxRy82?=
 =?utf-8?B?SGRFSlpiZDVxN1BVMk5qMUxlcGFLa0JKNVpReGZtcG5sRmQ5Rm15aFZVQStQ?=
 =?utf-8?B?dVlHeHB6OUpIZmlLeFB4ZHIvK2k3SURHL0R3YXd4b08yUVQ4ZDBMaEYrTGJt?=
 =?utf-8?B?Z2NQRXYwZlEwUGduaHppTjVuR2daQWlwUk5LNjYwWHp0RGZzNnhiUy8wUDgr?=
 =?utf-8?B?QVhLS0pHb0JGNFNqM2V6Z3UwaFhjYlp6V2JGN3pjQ0FrY3VMdTU2ZFRJRDkz?=
 =?utf-8?B?M2Zpc3pMTER5N0trU2JhREtjdXhueE1DRGJpSGZyeFN6M1gxSEFiU1VmUjRQ?=
 =?utf-8?B?dzh0K2pMNGdaUTZNSHZFTFRGODhtZCtHaXBEdkh6QVRUNVhncWNtUUo0allS?=
 =?utf-8?B?U1lxbWtNQkZBcU1NaDZDN1QraDBuS3k4eW9xdTBGRlF5UkhhdXYxSjhSeWVa?=
 =?utf-8?B?UU9MTkxNRHA2elZiUVQvMEpVY3VxNEpMQVJubVgycnI4Z3VjZlJTVGQrSit2?=
 =?utf-8?B?M1ltSGNJb3pEMms3bkVxTjdzMVpaZGhSSnBOaW5pUk5yd2I2dGk3T1FoSVQ5?=
 =?utf-8?Q?Qzn3d/Ej/oDmLMC9kpq1PcC6x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19107b29-e653-49e2-7001-08db7e2d9107
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:30:37.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxyUJNtOWS7HQn+C33X9f9NYeEnYj8SRe7n8BVtd0pZHs4lPtECVNCL1ntfUrxTEwifcARfieLUzUQwVOKRVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2023 04:16, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 08:30:03AM -0500, Mario Limonciello wrote:
>> On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
>> GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
>> Windows.
>>
>> Comparing the GPIO register configuration between Windows and Linux
>> bit 20 has been configured as a pull up on Windows, but not on Linux.
>> Checking GPIO declaration from the firmware it is clear it *should* have
>> been a pull up on Linux as well.
>>
>> ```
>> GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
>> 	 "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>> {   // Pin list
>> 0x0007
>> }
>> ```
>>
>> On Linux amd_gpio_set_config() is currently only used for programming
>> the debounce. Actually the GPIO core calls it with all the arguments
>> that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.
>>
>> To solve this issue expand amd_gpio_set_config() to support the other
>> arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
>> `PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.
> 
> ...
> 
>> @@ -782,7 +770,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
>>   }
>>   
>>   static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>> -				unsigned long *configs, unsigned num_configs)
>> +			   unsigned long *configs, unsigned int num_configs)
> 
> Seems like a stray change.

Right; if necessary I'll pull this into it's own patch instead of 
s,unsigned,unsigned long, in this one.  It just seemed sensible while 
calling this function.

> 
>>   {
>>   	int i;
>>   	u32 arg;
> 
> Otherwise entire series looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thanks!
