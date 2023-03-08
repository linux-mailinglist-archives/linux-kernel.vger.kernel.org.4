Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB76AFDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCHE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:28:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D308315E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxLUm759P5N50SIc2VSY+mGKg6/HzT6AD3d4h33PX9cygY/hdfcaHPOOuuXMNGV673/FoUe4XzGaiaaWuD2/9XgWvDJQgxZLYxFGXQW645alarFlzxx12L+ZYu93Md7lXRHAwns5jc9iKdg85CzlPeuTpNnPJfgyUdYh/q/F50zjbGZe/C8zqGrHpLpkebr9lLQDZOkLsVjZjRFXYfQb7cpZdZtHMkVSP8hY7Jrgntz2S3Hv5EM3GbYCAPHbItGgjVedV8NVfbMXKbge+MpcWMu+jB52GJBvJ1crQ5ADzSKkq4UiiRqMGUgYUl7FqPO+OwIqTvm/Xm41mR2+TBa4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZpvPFAV17wHjtxpSWFinEu6D6lNgOnCGAC0n3rasFU=;
 b=fSLIJZfy/Chf65FtzeIMl4Yzjw8+xLfJg/nxygar0ppzWFs6XNp8/1tQiQ3NjLJJR4kzZbM+jcitckMSMKn4SywBJw3gFNge2edFuzirQP6l1NYPiITfunFGxgKdLpStd2ME/p/CB5hEzCHcwxjAomoHvnF7jHq3wSzlKXwBMyXTaTlKPPlJ7PRSAkE1A8PQXNlsug8N+LDvufUi3ZabjestWwsJzZ6LCAOXflovnxvnWGqn6Hw5xNsSnRnngd4sPxwRHcTNRUPamcTDOgcIQhcL/Yb1xfDhVvdynBgNuqXjW1BQTcOczmI0y6SSXH9cOfG8hAxuKEJb+qO1Yk3ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZpvPFAV17wHjtxpSWFinEu6D6lNgOnCGAC0n3rasFU=;
 b=MjJ/wFjZ2102NNyJAnAwF0KhW4URNL4nKKfkrq30KXM5HVch1GLd4/RTArpp6kcBxPgpLNdiBsurz9pl6UVxnBuggV5ucWi8i+0TOejLSRvEM1qLTRDQNKaA6r/omKBJTsxJq8BBo1ibAu+v2qWDEJ0KsK6rF/NmT3AWiNqZKOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 04:28:15 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 04:28:15 +0000
Message-ID: <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
Date:   Wed, 8 Mar 2023 10:02:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
 <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
 <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 2877bf80-de69-46ff-ab00-08db1f8d88a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlTYxoZxfZZZl9mJaDlxG2DrAygDcRH+CfCTIzaBKeLVy9QoPcp3iK8xOGvh/o6t3X6q5GqH5VkscMhfsXQzAR2orXmhb+wMHo2KhQ1wqwyyHF6dwpyyLA2E2dVly9lhx3cYrZc4Lb/h7ff7K+LnflbuHAGbE8Hdb8Qxe52ZjbIdy+kp5qxpRd3I4rFZYT2hcMDIH2ztuyJsUWnZpCinzWJXeUgxIIlD1prbftBmNmecnacEaryqMgeMOdh3m1jfxJ35ZWVe1rUkbXSp4XN9pjYowabzkU4a7gQ6IMs3h6YnJs/tJjQxvy8PW+9M46E6f85yevxu0Cba1RItoLjlASEaXFIk01zvvkm83rMIo/uAmlus8G0cT/C+QhN2NHN9nE0PABrwpcv3zlZQxI32tc4RpqXOmmIhJRLm/Etk1VI7LKo9NWsMQYwdq0hEno32bJ75KfWUR61hDigxjoHoZi6lPef25g5hb5O95Kh8HjT41vfWVOtT9Tta1zzDYU0dv3yn/zYUq6501EfardvTAzpkg7f8pIV544uZkfq8bNuNsZ2HO8lKGU7lJPyiCVmkAk+HxWjjed09jO6x0Il9pIr2WyeK7TyTId6wIUtMuy4kKzHkH5H3ee4xyLzkqd9BNn1dZBsXL/v3LEwYKcq+TZcBetwLhhpcFUcigybOIIsifJSxbQfDhJl9V3oAhchoa80tkjAoL+eGLzxJdYRQFj7uyxLsLaLgZCCQfm9li2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199018)(66946007)(26005)(5660300002)(186003)(4326008)(66476007)(8676002)(66556008)(966005)(478600001)(6486002)(6506007)(54906003)(31696002)(86362001)(6512007)(316002)(36756003)(53546011)(8936002)(41300700001)(38100700002)(6666004)(2906002)(83380400001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUgxYWFGejhwSWo3cFNEaGZzN1VPS2F6dEZJanVjVWxhS1JrYnY5dEhzS25i?=
 =?utf-8?B?d0hvU3dHWG0zd2RROUo1eXJSSVRySTZJbndOQlR0TkZZQmV4bVJwOFhlUi83?=
 =?utf-8?B?QVJiOWRhNDlyN3Bid3dPQ2hHUWNqUHp1UHFQM0YyeTNsdzB4Wks4eFptNXpi?=
 =?utf-8?B?WEhwZmJqR20wSDVYZ2lPbC9RWmVhY0duRVFxeFo2ZVpDN2R0b0hzemNXN2Nx?=
 =?utf-8?B?M0ptMjgzNzRvaFduMG9KcjdPWDgyVkhSSWl0aWpzRFZiUDRick1aTlJ0NmtD?=
 =?utf-8?B?d011TmlyYWJsRWE3Q2t1bFFBdnlCMVdNRU5oeEtUQmU2L3czc2VKSVlvSlF5?=
 =?utf-8?B?b0U2ZXhrZGVYMFFVNVFyS0ZJV2xJeFpIRWNMWXZvKy9OenpWWkl6TUVPVFZO?=
 =?utf-8?B?MDVqajJGNVU3YjhzT0xIUFo4QS9CckVLVXFqSzYyMUlyQi91VUZ0bDV4Ui9U?=
 =?utf-8?B?WUVVQUpLU3lJS1l4S1c4ZnVjK01xcy9UVFhwblVRd3lPOUZTZk00bTRXQVUr?=
 =?utf-8?B?M3BOSUtzSk9ySnphYmVHUi9XU1lvN2lsRlZmaVNVSDBoci9KL3VYZm5IalV3?=
 =?utf-8?B?dG0yYTI4QzlwYW9TWXRQZjV2dDlrM2NTVmhZVFFpcldZTWwrbVFNRmxwTmNm?=
 =?utf-8?B?OHFXYXZsZ1RxdnJ0WDQ3NUwwT25lakg1NFV3cSs1c010Q041VE9aMG43RnEz?=
 =?utf-8?B?QUhSUEpaRlg4UE5aay96V0JTSlVYYjFOV1czZkxJSTg5VjhWSmMxcXdSWHpJ?=
 =?utf-8?B?TEYza2s4ZTRuK01CMW5sRlNkSkdSM1lER3JkQUY4L0lrT1h2aUU5ZkRaUFV2?=
 =?utf-8?B?cFJXbjhqTHdGNHQvZUwrSFJ2U1JyT0gxUGgwc1Fjelo4NndReTN5dDc4cjRv?=
 =?utf-8?B?NGppYlU4czJPSk5SZ3U1cDFPc3djTzBYNkdoZnhDVGthVndBM2xxc3ZUbjVk?=
 =?utf-8?B?WW9LNnpXS21MTXdwdzR2UkpPNnVKK3FTL2h5cktjUmJSYTFxNzh6a0hPZVNT?=
 =?utf-8?B?Y2FDV1pTVUpBSVFkdXBVU3pmRzRTQVU2WGtVS0pBMjZJTWNiWU1sRFNQbFBo?=
 =?utf-8?B?aEhHcWoyekpXVWxHeEFEYUFlaVkrTUp3bjh0M0tqNjNYem5NbkZ5TjhQRndQ?=
 =?utf-8?B?T1hxZ3h1UGQrd1hUZjIvZ0dTZGN4cmVGNEVZcDVaT2l2QktHaXVXdm0yM2RL?=
 =?utf-8?B?VU5WKzhnZGpNVDJyckFzN2xPL0IxRithMFhISFRUL2dRMUJBcllZRE9WbzJO?=
 =?utf-8?B?cTNXVDBYakdhMFVTMUlzV0g0dnZCZi9vWmh3YVRtRVVIdFRCTEhOMGpwcTk1?=
 =?utf-8?B?WjNvbkEyMjBaclB2UFg3amU0ZjhKYzVZYkp2YkVmRUMxNTkxNXZKZGs4TDVh?=
 =?utf-8?B?VktBREtlNW5TVW1pcHgwaDVzT2FUZW4wU0VYajhkanFPNmsveXBDclhHdUFp?=
 =?utf-8?B?Vm9XVDdpVmdTaHJTaVh6Z1Aydi90cHdWUmQwS3NqWVVJMGo4Tk5heUVqbUJH?=
 =?utf-8?B?UnNnZWlhcnBCVmdUdExDWWszNEJJOUFPK0g5dE9UWm5qRVRtQlpoOEZ3ZGt2?=
 =?utf-8?B?cFZvQzVXazNLMHhqUkJyQ3U3TUtrK1dyQXlpWXIyMXl6WXJna09JYzRIUkJB?=
 =?utf-8?B?VWVsYnRiZEt2dDhRM3hCbWhlZDRkdVhpRlJJbUF2d29Lei9ta1hCcEhWRVBm?=
 =?utf-8?B?cnVFQnVua0RESzJzc1FZbTB6ZUQ5dWpzbjF6dC9TOWJkWEdRbTlReXh0T1Ex?=
 =?utf-8?B?VXloRlZyalZlQ2N3Skw1N3hQRWxPK042Z3hzYlpJblhKcmxLL211SGJ3eWt1?=
 =?utf-8?B?QXhKcjVHTEphWWR4SVVIRWNMOHlQM2J3aEloSTl4UW4wNzZMeUJkUDBlemIy?=
 =?utf-8?B?NGxwVmxlS3JFV3N2T0FlTC9aZlhhYk1CU3RhQjFGVFVjMVRiV2tzeWVFNWFJ?=
 =?utf-8?B?K2lkaFJXT2lQeWZXSnRNVGhBN1dFS28va1BRbzZSVWhHUlJQRzlxbXFVQjhE?=
 =?utf-8?B?djc4RTZZcVdCVm9DTnE2YzN4dnc1NGxKRUhOcXhCL0o0RkJtRGlyT2tXZkNw?=
 =?utf-8?B?WlR5bHQ5b3BuaFg0U0R3WG9NOTdzdTN4QklvaGZLb0l0MUxCUWdFaVdJV3lN?=
 =?utf-8?Q?jsNS3+x/K/GgwkrC8lugfTjXD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2877bf80-de69-46ff-ab00-08db1f8d88a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 04:28:15.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9pyPpkKDTVuf8LXwzJar7Hg0qQVQdaTr/PiRJoitJfJxqiRZoQnea4khAnKxgmuSF2icJfHYBQUls7RYhFCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/23 02:38, Pierre-Louis Bossart wrote:
>
> On 3/7/23 14:25, Mukunda,Vijendar wrote:
>> On 07/03/23 20:58, Pierre-Louis Bossart wrote:
>>>> +static int amd_resume_child_device(struct device *dev, void *data)
>>>> +{
>>>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>>> +	int ret;
>>>> +
>>>> +	if (!slave->probed) {
>>>> +		dev_dbg(dev, "skipping device, no probed driver\n");
>>>> +		return 0;
>>>> +	}
>>>> +	if (!slave->dev_num_sticky) {
>>>> +		dev_dbg(dev, "skipping device, never detected on bus\n");
>>>> +		return 0;
>>>> +	}
>>>> +	if (!pm_runtime_suspended(dev))
>>>> +		return 0;
>>>> +	ret = pm_request_resume(dev);
>>> I still don't get why the test above was needed. It's racy and brings
>>> limited benefits.
>> As explained below thread,
>>
>> https://lore.kernel.org/lkml/acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com
>>
>> Our scenario is multiple peripheral devices are connected
>> over the same link.
>>
>> In our implementation, device_for_each_child() function invokes
>> amd_resume_child_device callback for each child.
>> When any one of the child device is active, It will break the
>> iteration, which results in failure resuming all child devices.
> Can you clarify the 'it will break the iteration' statement?
>
> Are you saying pm_request_resume() will return a negative error code if
> the device is already active?
>
> We've used an unconditional pm_request_resume() in the Intel code for
> quite some time, including with multiple amplifiers per link, and have
> never observed the issue you report, so I'd like to get to the root
> cause pretty please. You took the Intel code and added a test for AMD
> platforms, and I'd really like to understand if the Intel code was wrong
> in the first place, or if the test is not needed. Something does not add
> up here.
AMP Codec (In aggregate mode) + Jack Codec connected over the same
link on our platform.
Consider below, scenario.
Active stream is running on AMP codec and Jack codec is already in runtime
suspend state.
If system level suspend is invoked, in prepare callback, we need to resume
both the codec devices.

device_for_each_child() will invoke amd_resume_child_device() function callback
for each device which will try to resume the child device in this case.
By definition, device_for_each_child() Iterate over @parent's child devices,
and invokes the callback for each. We check the return of amd_resume_child_device()
each time.
If it returns anything other than 0, we break out and return that value.

In current scenario, As AMP codec is not in runtime suspend state,
pm_request_resume() will return a value as 1. This will break the
sequence for resuming rest of the child devices(JACK codec in our case).

As mentioned in an earlier thread, there are two possible solutions.
1. check pm runtime suspend state and return 0 if it is not suspended
2. simply always return 0 for amd_resume_child_device() function callback.

We opted first one as solution.
>
>> If we skip , pm_suspended check , it will not resume all
>> peripheral devices when any one of the peripheral device is active.
>>>> +	if (ret < 0)
>>>> +		dev_err(dev, "pm_request_resume failed: %d\n", ret);
>>>> +
>>>> +	return ret;
>>>> +}

