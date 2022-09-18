Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FA5BBF95
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIRTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIRTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:46:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D62175A9;
        Sun, 18 Sep 2022 12:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1fPumo3PFlnurXGVy68z5dqwsguIbz8xZ3EzimN2cSFlF2lfXhOcacCKxl3BviUhfgBMxSp0VPXTzzKzsIEcDk+z9C1Bxjw5uX5h3t5MQ85I4tDQQ12pBWGrfNJhfyCsVDczB+VBi7PHr5Go5j/qzyZZksgTjRLD0waZKHt/xZBBw273ere27OwIQfo13lLXv52YRn8uhZkDCw7GUKPP4pnU55DL4+CktN4O3PGD9Xjf0tBEoFILA+JywEBHyo83US01VkJP984zdAxkiPaBtiK+Ti66rP9O2Yc9ZRKx9kxdDT9Y1uHZikCS3LVEWGSmjfLq1xLWt3FcwuFW2JRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gy+6o0XpkfkDDExvsP2aNPRf1AJTS7LXwjRT9E6q54=;
 b=nxGTYP8261JmmoRHA26YywxllsMrGD2upxacJ7UrPsbRvWIZnPS6znwYQGBQ3uHYBor76sujNzx+QzIxQZMTxJpw2kOa+ZmXoeznfa6tjf/2YCx3RE3tUgjFCtIMLtHmFe7ZOKIsCCGQ2MlGL19k6TSqnL4P6gQDSXJ7qSQh1aZSjEoDfVa8FtAjaQvryfbDo11n4UCoNvItClQpSL/5P+ZQ1wOgYK4n5ugQ2tubOB/ERHMx3+85OHKaKYGzCsYJsoBTFY+vf5BKfYSIBJnHHY1+XKh0PFFnQ9cIa+4hzqmo/2HihIPE/s2TYqvvkEToAO3Y+vWDowrCAhrqXyenFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gy+6o0XpkfkDDExvsP2aNPRf1AJTS7LXwjRT9E6q54=;
 b=5KlwkUZtzBlgBHfwS3z7OrmcOs/vAvsO+aQtKAj4vHtwfvqoApG6vcH8c2SYimll/DuN9jOgNNhJEAshF+CsrGWKeovb1IAlnXHgZ7GgS4VXx7/Tk0vbvfSg0ib15HS6wktc/BcIWvmy67dX5q+j8UjCkiXCP3HZWjtC/Iv/FTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Sun, 18 Sep
 2022 19:46:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5632.017; Sun, 18 Sep 2022
 19:46:17 +0000
Message-ID: <d3dd18be-9c03-7c29-eb2e-d8d617994259@amd.com>
Date:   Sun, 18 Sep 2022 14:46:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>,
        Philipp Zabel <philipp.zabel@gmail.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <Yx9ItlBjl6bxxu2H@rog>
 <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Yx9K88pXilS6qqL9@rog>
 <b94e6fd33938877d5863c9444ca9c68c01417d8f.camel@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b94e6fd33938877d5863c9444ca9c68c01417d8f.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d3b082-f7e4-46ff-2e57-08da99ae7389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idE8Vw279Ep3iNCGcrmzINL6iFMx4fHOLfJvRJV4wCPo2XjT58m4Krx7O6zVYJN+9V/KQTHj3ewwph0tG/NizJTsf0rX7u8kHV64nOimYMTyrpzpULSnqH0ux8v5m5rXBjNIzKyn6lY6cFeAaKlovByq5NZCS+P0J6QZIAY5TufwmXClEGgUxc5WGtZiiYXtfJHw/1Plg5MyPvBPAyBowARXmrcxLB5jfj4OsIhbbGJIpL9z8M/SsxtXKVqlUYa4KB0u4QJ4fP7O/uNGo6iKVd1ylsJsNxPvZU44Tq6bYz27Ta7amenonpe8hj6fcjdiBRZb1+Ua9CotwXS6vn8wf34NKJ3vbNvvD8iDiFk/ZDJW5o6dJeFC1EK9Lo1L6dYtO/zuUAXhr71Em4xowjNRRNCaUlWc7acmJp/p+7DRErccrHiLKKW4PjgWTZAkk0ubsIIu0yz//WZZImsPid9u0bjtAx5W9kKnbLjlMMfE+TvV0rIOjeLohyNR8XyeZgZIJXupvkDptXaGCtxgxtJsXSGilN3/L9mEoOIPUG+jBJMD6UaRyQVqPQ8FYYgj9N+EvWeOvTJI4T0FOFT63cJ2xIp2qHed7y3aqinmt6rJCJsfa8ZQmEVSj78CI030Vuhh+bhYAZ2NCPuvY57jxvw6IEGK7Oc5X1MPrLFx3C+6f5U6HsNZ2y4SlIdhOC4Wic6C2tfzhl9YmsnO6g7bIE3nSemhzHqWNIrdcY3m7WAt6oIVjAo/8e3gUuPoO192vzSMePdWSB2oOCyJ7yudsaP72be9kx2rzvTmZSgJdMFHSIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(5660300002)(66556008)(66476007)(66946007)(2906002)(31686004)(44832011)(4326008)(110136005)(54906003)(8676002)(316002)(38100700002)(41300700001)(6506007)(45080400002)(6666004)(86362001)(31696002)(2616005)(6512007)(26005)(53546011)(6486002)(478600001)(186003)(8936002)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZhd25xbDUxNHl5ZURxaUFuVjJpNjVVc1grKzFOWHZraTA4QjVvRnhCK1hx?=
 =?utf-8?B?REtZU2JnU2w3V05qQ3Nld0VFZW03Wko5M3dibHpqUVZRclpNb0pOZjdBT3By?=
 =?utf-8?B?aU92U2QvYWwxUGlJdS8zK0ZteW5RWlI0UUlsVXRHQVNWKzZBcDNXaW5OWWNa?=
 =?utf-8?B?WUJqVEo5bFZ5ZnN6aGUrV1dONzRmdEZESjRQc0RRbys1N3phOVJKOGlQbjB2?=
 =?utf-8?B?SDZVZG1MNEVmU3Y2bldRNEJkbmxIYXJMZzJzNW95Ti9FWWFqZWVCcnVZTjM1?=
 =?utf-8?B?dzJJMzdESEJqMVBBeEk3allPbnZnVE5hODNQTW1pY0hQSUNFblNNcjdrd1dY?=
 =?utf-8?B?dEtSbFJZajZrc2JiODJsdWNKeDRoL0t4aHp5d0xFejFXbFo0Ky82c1pXU29T?=
 =?utf-8?B?MzI0Y0VGZy93VFVxWUlHaHFCVTZGNDNJN2JodHJybjFCd1BNejI0VVBUUFhs?=
 =?utf-8?B?QXJPRGhCYlVFdXFyM2NURWs1SmRGTXRlUmtIam13ZHZtYysyNDArV3I2TWZ4?=
 =?utf-8?B?UXVtRG9LWXpwTjdSc1NZM3NOMnNYUWxVaWZqNW5jRUI5ZTRlR0ZQVHlWL0x0?=
 =?utf-8?B?RlZ0MWhvTmZ3RmpBd0VvdzdhVWJuOG9KdU56dU4vOTZTWk0yZlhWQW5wa050?=
 =?utf-8?B?YW03NXY2Mml3ckQ0eEh2Y01CbHdpL0hEVmpxNGFSZVI0S0hIaHVza0ttcU4w?=
 =?utf-8?B?YWxWaFNsL05kYkJGR0tlOHIyRThxaHc0eCtTa0NtclFjVWFXNlM5YXp2TGla?=
 =?utf-8?B?S1hTRTFGSzJJT3FQUC9hTXZ4MXVtL1lUazd2cDg5Q3RWMXY4RHgyamRramlV?=
 =?utf-8?B?MUlEcEZ2TjlvREhnc29uYzg3cVVCek1DMUpoZ3dFNkc4d1RuYm9GeThHaHpV?=
 =?utf-8?B?UkN2dXRsRkN6bFkrSXVqdmpuMWM0U2hkRWxwSURjbXBFQzZZdFRCdlY0N2la?=
 =?utf-8?B?QUdQekhGRE1MVkMyY2tEc1ZhWnp0TUg1bWpSN01oa3oxay84NktCSk85WnhS?=
 =?utf-8?B?YVR5eTdPNXpoWUxIdWFaN0Nrd20vbi81aFBseHBRREQ2U09ZcnE1UzVFNGlv?=
 =?utf-8?B?UVdQTXNmbVROU0oxYVRYV00weWFXMHFJcWdWVlUyNjZJSTdmTkU4T3F3Z29t?=
 =?utf-8?B?SFBHczdkSnpncXpPUW5hQ2ZEZ0lvb05oNnRFdlRyOVVoVk1lWmRjdEFva1cw?=
 =?utf-8?B?Sy9ETk1xTEdMcFFpaGxWcXltOFBpak9GSFNPVEpiN1M4MlBSekpkaFVIR21K?=
 =?utf-8?B?UVZXc2x4QVZoZFZUV293VmI0K0VjM3RuQ3RWbWo4SlFjUmttTUNCbzdCMmRN?=
 =?utf-8?B?ZkRHeVJzQTVEUWpGU0tqWkIwSGRJSWIrYmpFL3ErMWlIY0lsaEF0UlBCOG5N?=
 =?utf-8?B?eHhuYjVOenhoUXpDeWhNV09kSmxJM3Evc1V0Nk0vZFpQcU5jWFY2SSs3ZXRV?=
 =?utf-8?B?bEkxajhkc0tQMS96a2w1cEI4V082S08ydU5ML1Q0ZmVQMHdib21LODc1YVdm?=
 =?utf-8?B?RXlWa3d2VHRhZ2dmUnN0bWxmdGZtaDMzTnAyWTZuVFdycWE4eTJyV2lYT1JR?=
 =?utf-8?B?aGRnOTVVQWZVQnAxa24zcFBwSThrSklGd0tNMzJTUFNtNjgzRTlMVEFoL2hv?=
 =?utf-8?B?UklrTTNsNDR4VUFIVUFVL29tc1VDUnZKU2lkUHZ5RTRLamU2S2grMmJycHdu?=
 =?utf-8?B?b1pYOER2SnhwdUxnNkgwS0F6bTJHV2FsbjcyaUg1bTViUEFTdmE0UHJSTUNE?=
 =?utf-8?B?cWo0SHJZb2hPK2R6K3RSSzJXQjhrMmpsMUN4OGNFVmtqWCsyK1dWdTY5MFdn?=
 =?utf-8?B?eTRWdklOdm5YR1VLWnl6NHFMVXFZVlNqSlNJU1FBSnZPWVpTRWhyQ0Zkclgw?=
 =?utf-8?B?Mm50SlQrdHVZNU4wZkZSaS9HazJCUlh1VTJpTGQzTXpraWIwY1dOUUVVWi9i?=
 =?utf-8?B?MDJRYWVwdnB6SlNQYXpVZGdWSlRKVS9oRisyUExnNXpLTlROTW9DTVZGUFE0?=
 =?utf-8?B?UVE1c1RIWkxBWnVpWjFmSE5WOStvYnJmVlg5REdET1hka1dhcDg3MkYvR0J3?=
 =?utf-8?B?Y1B6c3k3c1BwMGV0dUlvSC9VQ3BSU0dRRHJCelNxcERxMlhLaXhzSjdMb3lC?=
 =?utf-8?Q?ZirhjGVTrrGKn6bds4LA0J2O9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d3b082-f7e4-46ff-2e57-08da99ae7389
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2022 19:46:16.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKDaPfS3Z+YfPVryELO0HbZx3OzWlrhjq2gLV08GqH5jEjjo9VHCUp6VeMiy8aLmbGzxIwqIJLCSJvJuqZXUsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 03:37, Luke Jones wrote:
> Hi,
> 
> On Mon, 2022-09-12 at 17:06 +0200, Philipp Zabel wrote:
>> Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello, Mario:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Philipp Zabel <philipp.zabel@gmail.com>
>>>> Sent: Monday, September 12, 2022 09:57
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar
>>>> <Shyam-
>>>> sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt
>>>> laptop
>>>>
>>>> Hi Mario,
>>>>
>>>> Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario
>>>> Limonciello:
>>>>> It was reported that an ASUS Rembrandt laptop has problems with
>>>> seemingly
>>>>> unrelated ACPI events after resuming from s2idle. Debugging the
>>>>> issue
>>>>> proved it's because ASUS has ASL that is only called when using
>>>>> the
>>>>> Microsoft GUID, not the AMD GUID.
>>>>>
>>>>> This is a bug from ASUS firmware but this series reworks the
>>>>> s2idle
>>>>> handling for AMD to allow accounting for this in a quirk.
>>>>>
>>>>> Additionally as this is a problem that may pop up again on
>>>>> other models
>>>>> add a module parameter that can be used to try the Microsoft
>>>>> GUID on a
>>>>> given system.
>>>>
>>>> thank you, these also helped on an ASUS ROG Zephyrus G14 (2022)
>>>> with
>>>> BIOS version GA402RJ.313. Patches 1-3
>>>>
>>>> Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
>>>
>>> Did you use acpi.prefer_microsoft_guid=1 for your system then too?
>>>
>>> If so, I should re-spin this series to add your system's quirk to
>>> patch 4.
>>
>> Yes. I also tested with the following diff applied instead of the
>> module
>> parameter:
>>
>> ----------8<----------
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index 6a2c94fdbeae..a247560e31de 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -420,6 +420,14 @@ static const struct dmi_system_id
>> s2idle_dmi_table[] __initconst = {
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming
>> A17"),
>>                  },
>>          },
>> +       {
>> +               /* ASUS ROG Zephyrus G14 (2022) */
>> +               .callback = lps0_prefer_microsoft,
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
>> INC."),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14
>> GA402"),
> 
> Just a note, this needs to be `ROG Zephyrus G14 GA402R` or this will
> catch the GA402Q series as well which doesn't require this quirk.
> In general the model numbering goes
> <Range><Model><Generation><Graphics>, So for my old G14 <GA><402<Q><M>.
> Or for example a ROG Strix machine <G><513><Q><Y>
> 

What _HID is used?  From your description GA402"Q" is Cezanne generation 
right? Can you please share the acpidump for me to confirm what is 
happening and if it's expected?

> I don't know of any others that may need this quirk.
> 
>> +               },
>> +       },
>>          {}
>>   };
>>   
>> ---------->8----------
>>
>> The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ", but
>> there is also a near-identical higher spec model GA402RK.
>>
>> regards
>> Philipp
> 

