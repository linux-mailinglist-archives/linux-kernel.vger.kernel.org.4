Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A86F82BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjEEMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEEMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:15:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E66A5E1;
        Fri,  5 May 2023 05:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6XGGsh7pbYJfNmJfvdppOQwqzcf++Y4PA1cGebkbf0ZRz46UKlwwxPNSOI7KsgSctPyGk5FTcbK0CJhD5C8JEZQWHFWJ5ENPzHkql1BabLw/6rfUskPpVM90AQRy6DfnFEcRdewwhMFk7P0+N41uu0T7zdIEv352bc7qgep+jMXsgNPAQL7zx0cvXQWXq8te6vZsf5Lh/sKTJPlOuihzMDlnrMAWkoJg79L/CdZ9zdOJx+1k2zNoU0m4eydfesW83IOla1gNCR/Wq3pY6JXD7hZpXweUSpsG2ZgsT6iPeT9zoKKwxyJtZ+i3zCsjsECKEkSMqgI45NoNOSAj82fEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSuBvriGyx3ef/vWyLrPe68bn08mHzmxahu+PsIAbks=;
 b=kK1fdK6xMk6vjK+xXzAvjs07xd382Jx8IutZtONYeqGJhDDMz7NPckl/DsLQ0un2Vu9FzjJjF9ywhGHRyzEyTcck8hrb5N4UwU+N0rbUOhYtoC5cfhSBFT/nIJh+CB+0yjJ3PW8IwF2e4G8EAI3v5pHvF1tYCDxzwUQTjb1YAW5uRjJUkUrzVjhq8o4jve+0la+WKG0JSd9aYOeb9Ppx3t2U7rhmHbgenYMSU/fCQ+lNRuqvqXFEGiEy4vYFXz9k35OfDoSmpxWxUQeGpKCD9b4gStIg3EM65cKJhvjqkTX1knp749RbCLCHpHRJixG79AmyBvORJF+8PT/vHX+0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSuBvriGyx3ef/vWyLrPe68bn08mHzmxahu+PsIAbks=;
 b=KV5l2BjDq/lwW3oVtkEs5Upx9K2bj//tZfCByfTUfWddABwIOeAcyHG07znjEwD2DcVA18ICVZEWWGT+AmJGNDBHMpIb7I/9Yn8abgHWfE+q34OCjy0+QRf2TFjhIfDDtjDofliBwTrP62AdjH+RJn8SiDICjEXPdleAAZe+V98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 12:15:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 12:15:01 +0000
Message-ID: <4950083e-0469-4110-0a2c-17b806a35493@amd.com>
Date:   Fri, 5 May 2023 07:14:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/4] pinctrl: amd: Adjust handling for firmware
 misconfigurations
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-gpio@vger.kernel.org, nakato@nakato.io, korneld@chromium.org,
        richard.gong@amd.com, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com, linux-kernel@vger.kernel.org
References: <20230421120625.3366-1-mario.limonciello@amd.com>
 <CACRpkda6zyvQ6a4ycEyyi=k5dTZo2Ecm6t6w_9e8hf3gih3qGA@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <CACRpkda6zyvQ6a4ycEyyi=k5dTZo2Ecm6t6w_9e8hf3gih3qGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6487a6-fcf9-46bf-1247-08db4d625998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAPCnyTdY87zvuUBXIDNTRnkCFtxCc0xsqLxWntYwfWX3sdpjjl3Fw5QUHmCI/PrGbFHkgR4pXXLHQ/7Yd511BFKWlVrNEO4NhpzzF7HKspZwSdvtIeZzpSXxg6UVxI7T4L/jHJgVn5SdBjoV7gx03+MaAVkXptgSfLA/KJBimYse2QLl7Ko+ZZJsoxC00R6Ux10yjCRdLI7Gk6DfJ2a7/4+yPgqm4Lxs5WLCCV5YvrdnMGCyt2lOuUeQdb75Lkcp5RpCv5PjczbJ6bCGlok3xj4FL/w+k26shUJIUNEUXfnZnpEG5/6DFQS2Tx+Oygv7CH4eL0UYyicX/EMm398ta/EfyyrWXA00+vKESCUK8fWXSGA+eTWIC6reWhvUs3cowxx3Hdef1WnIfWPSlO5hYXQBh3w9OufT22XrJ5xLr1HsvhbQIzi4THSMTXNd0DZwna1cQJH9rsr4ww3CuTQ8JWQiTuLyeSP2EiJL0ckrZGt6aPAXjUbWOs75s4eUTNByAsHK+AkgsSwgLMujj1dc0Ik8/M9qyNL1PEWY59UQLmPcq5kZp1eMjw6nmf903e3IwnbmPlJRcDqCuwVFzw6Ky66BT+UVn7y6EFoTITAVykq3YGnW8R1pBYBx83xsUBeKp9WUvGE5YAl85Q3M684Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(6506007)(8936002)(2906002)(83380400001)(8676002)(2616005)(186003)(36756003)(31696002)(38100700002)(26005)(6512007)(53546011)(41300700001)(66476007)(45080400002)(6636002)(66556008)(66946007)(478600001)(4326008)(31686004)(6486002)(66899021)(110136005)(316002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhmUkt2NERuNjQ3Vk51bW1wVWdsQUpoYWtHMTNERjRzZFZ6L3hOTEZ6ZzBi?=
 =?utf-8?B?WGIzaStYMzI0UjBqL05LeTR3cnZ0RW5iUmFhc1NpenhkUjZIWEtUTXQ5Tkx0?=
 =?utf-8?B?NzhYWFJFcjRyeDVxT2FGQTVid0plR1ZMempuaVRGOXpCRnJEMDR4R2ZFelVM?=
 =?utf-8?B?aXBQbXJHY1FLbCtROG53TitnVld0TjV2ekNjL2Y0K0MzYTFQUWgxNllwNzc3?=
 =?utf-8?B?ZHozdFptUUNTRnVzQnN4REd0SHZNcUJPOEpjZktkd2NSeU4vK2dTbDBoWDBh?=
 =?utf-8?B?Z1BRRDlpRUVUNmhkMHk2djBlMjZKaXhXZVppci8zY0lkSzkrRTl3ZVBFNnNX?=
 =?utf-8?B?NWVjRVpTUzIzaTZHRk1hRG1FNkZFV1NVbHVWZXVXY0QzZFVlcml1YkQydy9C?=
 =?utf-8?B?UXpreXFhNWgvS2FBZkEvdW5vREZOUGlEclU1M0krY0RYalB2WDQvVTl6eER1?=
 =?utf-8?B?MEIyOGI3Q3NqL1lyM0x0ZGlFbEdiY004WFdmYzlCUERTY3I5Tld4WCtQQ2FY?=
 =?utf-8?B?OHJBMndxN28xczRkYUJKaVZuTXpGYitVeFo5Y1lDOHpBV2JJOEJ3R1AzS2R0?=
 =?utf-8?B?UktFNzdCU1FJUEhWZDJTSU5OKzVKdGRGbmVqd1dyLzN4c1BsWTUxVTVsTVZ3?=
 =?utf-8?B?NDdTWkJHaHo2TFVsK3lmUlJpTmZtaWlsUjM4clc5YXZPdWx3RnVDTlFZQjVs?=
 =?utf-8?B?UFhBZHo1WVlKSWtYY1QwV0pvclRjT2o0V0ZoRkhrVHV2SGtJSEFnT0I0Smty?=
 =?utf-8?B?SVMzakE5aVVCQkpTRWJ3NFY1d294WU8zUm54Wkhtd3VpK0hiV3VZL1pLeVBX?=
 =?utf-8?B?ZE5OS01ySUVVdVFQOU5KWkd2UExxdEoxYktvM29IZVEyM2tvcGlWalhhSmJy?=
 =?utf-8?B?V1lZQlVQQzF1YjB2SmRNZ1Vpd0ZRUkFCVGpSTDNmejhvVHVwMnZ6MExqWEF2?=
 =?utf-8?B?TTI5WjB6bko3VzZESHhJRDFUVDhIdXlxTkdoZ0M3d3paNWYzSncvbUo3elBR?=
 =?utf-8?B?TjVOQTRoV2owT0w1M0NrVTZaUUYvZGg5cHk0Yldjb2ttai9oY2JvditsRFdH?=
 =?utf-8?B?OTU3ZzRMd0hqZ1Z0QlJVcU03dEhZdkZEemtwTVNnSUt1SDNGYk1Sc2hleEgv?=
 =?utf-8?B?VDVzdy9zQ0YwZndUMmVQRDJ3VXdnM0haOXQ2ZkxIblJVNzFhTHJueGpyVEpi?=
 =?utf-8?B?cWxXbEt5dUJMS0l2d3RLc0FrYlBXRjkvZk9uaHIrajdlYi96WDNuVnZWUWtH?=
 =?utf-8?B?d3pRVkdBdzhDc1JmaUZjc0cvM0FBOFZWbW9ZRDlIbk1ybVkwNVViTXIzZmhG?=
 =?utf-8?B?RFMyQWUrRkl6MExzWVo4Zk41RWltVUE5Y0Q3M2NQbjZHcnNzVG8rMzczL2JW?=
 =?utf-8?B?T3MrMUEvaytHbzhMZjBzOWhJOGNvYVhvRy8vQXRRcmNYaXhCZ3lYZzdoN0wy?=
 =?utf-8?B?MVVpZlVrdlRtbjMvd3RqVkhpNkcrZmp5QTNRanpna3habnhXQzdlb0lCK0Fr?=
 =?utf-8?B?dWVvSXo4cFIrcWl4SldZZ2U5Tk0yNU8wWFlKRldlNXA2S3JxSlhkR1oxTCt0?=
 =?utf-8?B?VWxDdGl2TlZWVUMxWVpQTExDTElIUHNrd2FxK3FNTVEwaS9Wb3BaV000Wm53?=
 =?utf-8?B?ZFJveko2UXM1bU05VDFkaUw5TWMyTkRuekJ6aTlneHc5eXplWUN3dVkzb0pB?=
 =?utf-8?B?Z1VJbkVVbmRJNjhIYkRJc1lEbG94c0ZNVW9JQjQ4SnFWWFR0bFVMMnhCYWcw?=
 =?utf-8?B?UHYwMGFRUWlIU0FVeFRxWTZqTTE0dVVIb3JrcEd5KzcrTXUvek4raXhqQXkz?=
 =?utf-8?B?NDQzazJBc3RoWHlNYTJPNFJ1ZmNXa2ZVUUwweFE4M2RLL3EyazZtWWljakxQ?=
 =?utf-8?B?S1Y5eUNodkx5TFh2QkVhTGV4S1BHM3E0eTdzNU9TR0VoM0dVYXdsaVJ4SzBN?=
 =?utf-8?B?NGZQR1BjUmNVdjZ3bUV6ejVPZ3d6VExkamJLQU1SOW9Nc0MxZStRZW9Wd2hm?=
 =?utf-8?B?OWhqMkJsYmp0YkY0SUplekk0WjJ1SkVhcWJ3SlhLN0ROVjV2eTlUUzZ3UHlv?=
 =?utf-8?B?SlJXaWFEWUFSL0ZEazhnVG0yTVg2ak5QOHhsVVUzcEIybDF0K0FUUkpuM1VC?=
 =?utf-8?Q?1mf1wy4fFr3jKU/7BeWNAowtj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6487a6-fcf9-46bf-1247-08db4d625998
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:15:01.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwcoGaKoa4rkHLyjTaNXCGcEpgBXPX4liiPuyFfdKsJ549RaZVbZuBKsHwyHQPZb7Up8XPzNQjWoqTadKaJb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2023 6:43 AM, Linus Walleij wrote:
> On Fri, Apr 21, 2023 at 2:06 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>
>> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
>> had intended to work around firmware problems on a Microsoft Surface
>> device but actually masked other real bugs in firmware and the driver.
>>
>> Before this commit, "wake on lid" doesn't work properly on a number of
>> systems, but this is because debounce handling was improperly configured
>> in the driver and due to a bug in this commit it gets configured a
>> different way.
>>
>> commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
>> resume") attempted to build on top of this to mask issues on resume, but
>> it happened to "fix" the bug in commit 4e5a04be88fe ("pinctrl: amd:
>> disable and mask interrupts on probe") which "broke" wake on lid since
>> the debounce handling was programmed differently.
>>
>> This was reverted in commit 534e465845eb ("Revert "pinctrl: amd: Disable
>> and mask interrupts on resume"") which fixed the wake on lid.
>>
>> To fix this series of unfortunate events and prevent them in the future
>> this series corrects the GPIO0 debounce handling and reverts commit
>> 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"). A new
>> patch that is safer is included that will fix spurious interrupt handling
>> and is expected to fix the issues that both
>> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
>> and
>> commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
>> resume") attempted to fix in a more scalable way.
> I applied the series for the next kernel cycle (becoming v6.5).
>
> If it gets urgent to get this in we can move it into the fixes (for v6.4 and
> stable) but at least this way we get some rotation in linux-next and wide
> testing of the patches.
>
> I will push it once v6.4-rc1 is out.
>
> Yours,
> Linus Walleij

Thanks!  Especially given the regression we were dealing with before I 
think this is the right
approach.

